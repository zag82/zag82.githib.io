unit ec_main2d;

interface
uses common_main2d, ComPlx, cm_ini, cmData, StdCtrls, Gauges, cmVars;

type
  TFlatECTask=class(TFlatTask)
  protected
    ErrorCriterion : float;
  public
    Bounds:TFlatBound_cxList;
    //////////////////////
    NumberConnect:array of array of int;
    Matrix:array of array of TComplex;
    RightSide:array of TComplex;
    /////////////////////////////
    Residual:array of TComplex;
    Direction:array of TComplex;
    DirectionNew:array of TComplex;
    Q:array of TComplex;
    k:array of TComplex;
    L:array of array of TComplex;
    Vmatr:array of TComplex;
    //////////////////////////
    constructor Create;
    procedure ReleaseVars;
    procedure GenerateBounds(bnd:TBounds2_data; num:int);override;
    //////////////////////////
    procedure PrepareMatrix;override;
    procedure PrepareSolution;override;
    function MakeSolutionStep:float;override;
    function RunSolution(ee:double;ni:int):float;override;
    ////////////////////////////
    function FindApproximate(x,z:float;var A,B:float):boolean;override;
    function FindInTri(k:int;x,z:float):TComplex;
    procedure ICCG;
    procedure InverseMul(var p,z:array of TComplex);
    function GetL(i,j:int; var ncon:int):TComplex;
  end;

implementation

uses uni_mesh;

{==============================================================================}
{==============================  TFlatECTask  =================================}
{==============================================================================}
constructor TFlatECTask.Create;
begin
  Bounds:=nil;
  //
  Matrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  //
  Residual:=nil;
  Q:=nil;
  k:=nil;
  L:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  Vmatr:=nil;
  inherited Create;
end;

procedure TFlatECTask.ReleaseVars;
begin
  Bounds:=nil;
  //
  Matrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  //
  Residual:=nil;
  Q:=nil;
  k:=nil;
  L:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  Vmatr:=nil;
  inherited ReleaseVars;
end;

////////////////////////////////////////
procedure TFlatECTask.GenerateBounds(bnd:TBounds2_data; num:int);
var i,j,k:int;
  x1,x2,z1,z2:int;
begin
  NBounds:=0;
  Bounds:=nil;
  if nds then
  begin
    lb.Caption:='Creating Bounds ...';
    ggb.Refresh;
  end;
  for i:=0 to num-1 do
  begin
    if bnd[i].x1=-1 then x1:=nnx else x1:=bnd[i].x1;
    if bnd[i].z1=-1 then z1:=nnz else z1:=bnd[i].z1;
    if bnd[i].x2=-1 then x2:=nnx else x2:=bnd[i].x2;
    if bnd[i].z2=-1 then z2:=nnz else z2:=bnd[i].z2;
    for k:=z1 to z2 do
    for j:=x1 to x2 do
    begin
      inc(nBounds);
      SetLength(Bounds,nBounds+1);
      Bounds[nBounds].num:=Num2Point(j,k);
      Bounds[nBounds].val:=CDConv(bnd[i].val,bnd[i].vl_im);
    end;
  end;
  if nds then
  begin
    lb.Caption:='<< Done >>';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

procedure TFlatECTask.PrepareMatrix;
var
  iPoint,iSource,iElement,iNode,jNode,jPoint,iBound,k:int;
  a,b,c:mxtyp2;
  NewConnect:boolean;
  iMaterial,i:int;
  Mult:int;
  MultImagine:float;
  Var_S:TComplex;
  flag:boolean;
begin
  if nds then
  begin
    lb.Caption:='Creating Matrix and RightSide ...';
    ggb.Refresh;
    gg.MaxValue:=NTriangles;
  end;
  NumberConnect:=nil;
  Matrix:=nil;
  RightSide:=nil;
  ///////////////////////////////////
  SetLength(NumberConnect,nNodes+1);
  SetLength(Matrix,nNodes+1);
  SetLength(RightSide,nNodes+1);
  //////////////////////////////////////
  for iPoint:=1 to NNodes do
  begin
    RightSide[iPoint]:=CNull;
    ///////////////////////////////////
    SetLength(Matrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    ///////////////////////////////////
    NumberConnect[iPoint,1]:=1;
    Matrix[iPoint,1]:=CNull;
  end;  {  for iPoint  }
  iSource:=1;
  for iElement:=1 to NTriangles do
  begin
    Top:=Topology[iElement];
    ElementMatrix(iElement,Area,R_average,a,b,c);
    iMaterial:=Topology[iElement][0];
    {Taking all tetrahedron nodes - definition of matrix row}
    for iNode:=1 to 3 do
    begin
      iPoint:=Top[iNode];
      {Definition of right side - for source elements (current and magnets)}
      if (iSource<=NSources) and (iElement=Sources[iSource].num) then
      begin
        RightSide[iPoint]:=CAdd(RightSide[iPoint],CDConv(Sources[iSource].val_J*Area*R_average/3,Sources[iSource].val_Jim*Area*R_average/3));
        RightSide[iPoint]:=CAdd(RightSide[iPoint],CConv((Sources[iSource].val_Bx*c[iNode]-Sources[iSource].val_Bz*b[iNode])*R_average/2*mt.VecProperty[iMaterial]));
        if iNode=3 then inc(iSource)
      end; { iSource }
      {Taking tetrahedron nodes - definition of its number and connection coefficient}
      for jNode:=1 to 3 do
        if iNode=jNode then
        begin
          CAddTo(Matrix[iPoint,1],CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Area/4.0*R_average));
          Mult:=2;   {  if iNode=jNode  !!!  }
          MultImagine:=Mult*pi*mt.Frequency*mt.Sigma[iMaterial];
          CAddTo(Matrix[iPoint,1],CDConv(0,MultImagine*Area/6.0*R_average));
        end
        else
        begin  {  calculation NON-DIAGONAL coefficient  }
          NewConnect:=true;
          jPoint:=NumberConnect[iPoint,1]+1;
          for k:=2 to NumberConnect[iPoint,1] do
            if NumberConnect[iPoint,k]=Top[jNode] then
            begin
              jPoint:=k;
              NewConnect:=false;
              break;
            end;
          if NewConnect then
          begin
            SetLength(NumberConnect[iPoint],jPoint+1);
            NumberConnect[iPoint,1]:=jPoint;
            NumberConnect[iPoint,jPoint]:=Top[jNode];
            SetLength(Matrix[iPoint],jPoint+1);
          end;
          CAddTo(Matrix[iPoint,jPoint],CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Area/4.0*R_average));
          Mult:=1;  {  iNode <> jNode  }
          MultImagine:=Mult*pi*mt.Frequency*mt.Sigma[iMaterial];
          CAddTo(Matrix[iPoint,jPoint],CDConv(0,MultImagine*Area/6.0*R_average));
        end;  {  else - iNode <> jNode }
    end;  {  for iNode }
    if nds and (iElement mod 1000=0) then gg.Progress:=iElement;
  end;   {  for iElement }
  { Normalization }
{  for iPoint:=1 to NNodes do
  begin
    Var_S:=Matrix[iPoint,1];
    RightSide[iPoint]:=CDiv(RightSide[iPoint],Var_S);
    for k:=2 to NumberConnect[iPoint,1] do
      Matrix[iPoint,k]:=CDiv(Matrix[iPoint,k],Var_S);
    Matrix[iPoint,1]:=CDiv(Matrix[iPoint,1],var_s);//CDConv(1,0);
  end;  {  for iPoint  }
  { Boundary conditions }
  if umEnable then
  begin
    for i:=1 to NNodes do
    begin
      flag:=false;
      if Abs(Nodes[i][1]-tt.ax)<1e-10 then flag:=true;
      if Abs(Nodes[i][2]-tt.az)<1e-10 then flag:=true;
      if Abs(Nodes[i][1]-tt.bx)<1e-10 then flag:=true;
      if Abs(Nodes[i][2]-tt.bz)<1e-10 then flag:=true;
      if flag then
      begin
        RightSide[i]:=CNull;
        SetLength(Matrix[i],2);
        SetLength(NumberConnect[i],2);
        NumberConnect[i,1]:=1;
      end;
    end;
  end
  else
  for iBound:=1 to NBounds do
  begin
    iPoint:=Bounds[iBound].num;
    RightSide[iPoint]:=CMul(Matrix[iPoint,1],Bounds[iBound].val);
    SetLength(Matrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    NumberConnect[iPoint,1]:=1;
  end;
  if nds then
  begin
    lb.Caption:='Done';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

procedure TFlatECTask.PrepareSolution;
var
  NConnects,iConnect,jColumn,iPoint:Cardinal;
  Var_sum:TComplex;
begin
  if nds then
  begin
    lb.Caption:='Preparing solution ...';
    ggb.Refresh;
    gg.MaxValue:=NNodes;
  end;
  SetLength(Vmatr,NNodes+1);
  SetLength(Residual,NNodes+1);
  SetLength(Q,NNodes+1);
  SetLength(Direction,NNodes+1);
  SetLength(DirectionNew,NNodes+1);
  //////////////////////////////////
  if ps.wSMeth2d=2 then ICCG;
  for iPoint:=1 to NNodes do Vmatr[iPoint]:=CDiv(RightSide[iPoint],Matrix[iPoint,1]);
  for iPoint:=1 to NNodes do
  begin
    Var_Sum:=CMul(Matrix[iPoint,1],Vmatr[iPoint]);
    Residual[iPoint]:=CSub(RightSide[iPoint],Var_Sum);
    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do
    begin
      jColumn:=NumberConnect[iPoint,iConnect];
      Var_Sum:=CMul(Matrix[iPoint,iConnect],Vmatr[jColumn]);
      Residual[iPoint]:=CSub(Residual[iPoint],Var_Sum);
    end;  {  for iConnect    }
    if nds then gg.Progress:=iPoint;
  end;  {  for iPoint  }
  Case ps.wSMeth2d of
    1:for iPoint:=1 to NNodes do Q[iPoint]:=CDiv(Residual[iPoint],Matrix[iPoint,1]);
    2:InverseMul(Residual,Q);
    else
      for iPoint:=1 to NNodes do Q[iPoint]:=Residual[iPoint];
  end;
  ErrorCriterion:=0.0;
  for iPoint:=1 to NNodes do begin
    Direction[iPoint]:=Q[iPoint];
    if ErrorCriterion <= CAbs(Residual[iPoint]) then ErrorCriterion := CAbs(Residual[iPoint])
  end;  {for iPoint}
  if nds then
  begin
    // Series1.Clear;
    lb.Caption:='Done';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

function TFlatECTask.MakeSolutionStep:float;
var
  Error : float;
  NConnects : Cardinal;
  iConnect : Cardinal;
  jColumn : Cardinal;
  iPoint : Cardinal;
  MultResidualNew,Alpha,Beta,MultDirection,MultResidual:TComplex;
begin
    for iPoint:=1 to NNodes do
    begin
      DirectionNew[iPoint]:=CNull;
      DirectionNew[iPoint]:=CAdd(DirectionNew[iPoint],CMul(Matrix[iPoint,1],Direction[iPoint]));
      NConnects:=NumberConnect[iPoint,1];
      for iConnect:=2 to NConnects do
      begin
        jColumn:=NumberConnect[iPoint,iConnect];
        DirectionNew[iPoint]:=CAdd(DirectionNew[iPoint],CMul(Matrix[iPoint,iConnect],Direction[jColumn]));
      end  {  for iConnect    }
    end; { if iPoint <= NPoints }
    MultResidual:=CNull;
    MultDirection:=CNull;
    for iPoint:=1 to NNodes do
    begin
      MultResidual:=CAdd(MultResidual,CMul(Residual[iPoint],Q[iPoint]));
      MultDirection:=CAdd(MultDirection,CMul(Direction[iPoint],DirectionNew[iPoint]));
    end;  {  for iPoint  }
    Alpha:=CDiv(MultResidual,MultDirection);
    for iPoint:=1 to NNodes do
    begin
      Vmatr[iPoint]:=CAdd(Vmatr[iPoint],CMul(Alpha,Direction[iPoint]));
      Residual[iPoint]:=CSub(Residual[iPoint],CMul(Alpha,DirectionNew[iPoint]));
    end;  {  for iPoint  }
    Case ps.wSMeth2d of
      1:for iPoint:=1 to NNodes do Q[iPoint]:=CDiv(Residual[iPoint],Matrix[iPoint,1]);
      2:InverseMul(Residual,Q);
      else for iPoint:=1 to NNodes do Q[iPoint]:=Residual[iPoint];
    end;
    MultResidualNew:=CNull;
    for iPoint:=1 to NNodes do MultResidualNew:=CAdd(MultResidualNew,CMul(Residual[iPoint],Q[iPoint]));
    Beta:=CDiv(MultResidualNew,MultResidual);
    for iPoint:=1 to NNodes do Direction[iPoint]:=CAdd(Q[iPoint],CMul(Beta,Direction[iPoint]));
    Error:=0.0;
    for iPoint:=1 to NNodes do {if Error<=CAbs(Residual[iPoint]) then} Error:=Error+CAbs(Residual[iPoint]);
    if Abs(ErrorCriterion) > 1e-20 then Error:=Error/ErrorCriterion;
    Result:=Error;
end;

function TFlatECTask.RunSolution(ee:double;ni:int):float;
var
  iIteration : int;
  Error : float;
begin
  PrepareSolution;
  iIteration:=0;
  repeat
    iIteration:=iIteration+1;
    Error:=MakeSolutionStep;
    if (Error<ee)or(iIteration>=ni)then
      break;
  until false;
  /////////////////
  Result:=Error;
  Matrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  Residual:=nil;
  Q:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  //////////////////
end;

{==============================================================================}
{===============================  PROTECTED  ==================================}
{==============================================================================}
function TFlatECTask.FindInTri(k:int;x,z:float):TComplex;
var
  a,b,c:mxtyp2;
  area,rav:float;
  p:TComplex;
  i:int;
begin
  ElementMatrix(k,area,rav,a,b,c);
  p:=CNull;
  for i:=1 to 3 do
    CAddTo(p,CMul(Vmatr[Topology[k][i]],CConv((a[i]+(b[i]-2/3*Area/rav)*x+c[i]*z)/area/2)));
  Result:=p;
end;

function TFlatECTask.FindApproximate(x,z:float;var A,B:float):boolean;
var
  j,k,qx,qz:int;
  AA:TComplex;
begin
  AA:=CNull;
  qx:=coord2NQuad(x-ax,disc_1,nd1);
  qz:=coord2NQuad(z-az,disc_2,nd2);
  if (qx<1)or(qx>=nnx)or(qz<1)or(qz>=nnz) then
  begin
    Result:=false;
    A:=0;
    B:=0;
    exit;
  end;
  j:=Num2Quad(qx,qz);
  if (0<j)and(j<=(NTriangles div 2)) then
  begin
    Result:=true;
    k:=GetWhere(j,x,z);
    if k=1 then
      AA:=FindInTri(2*j-1,x,z)
    else
      AA:=FindInTri(2*j,x,z);
  end
  else
    Result:=false;
  A:=AA.Re;
  B:=AA.Im;
end;

{==============================================================================}
{============================  END OF CLASSES  ================================}
{==============================================================================}
function TFlatECTask.GetL(i,j:int; var ncon:int):TComplex;
var iConnect,jColumn:int;
begin
  ncon:=-1;
  Result:=CNull;
  for iConnect:=1 to NumberConnect[i,1] do
  begin
    jColumn:=NumberConnect[i,iConnect];
    if jColumn=j then
    begin
      ncon:=iConnect;
      Result:=Matrix[i,iConnect];
      break;
    end;
  end;
end;

procedure TFlatECTask.ICCG;
var i,j,m,iConnect,ic:int;
    vv:TComplex;
begin
  // Generating matrix l: L*L(transponsed)=ScalarMatrix
  // memory for arrays
  L:=nil;
  setLength(L,NNodes+1);
  for i:=1 to NNodes do SetLength(L[i],NumberConnect[i,1]+1);
  // calculation of matrix
  for m:=1 to NNodes do
    for i:=m to NNodes do
      if i=m then
      begin
        L[m,1]:=Matrix[m,1];
        for j:=1 to m-1 do L[m,1]:=CSub(L[m,1],CSqr(GetL(m,j,iConnect)));
        L[m,1]:=CSqrt(L[m,1]);
      end
      else
      begin
        vv:=GetL(i,m,iConnect);
        if (vv.Re<>0)and(vv.Im<>0) then
        begin
          L[i,iConnect]:=vv;
          for j:=1 to m-1 do L[i,iConnect]:=CSub(L[i,iConnect],CMul(GetL(i,j,ic),GetL(m,j,ic)));
          L[i,iConnect]:=CDiv(L[i,iConnect],L[m,1]);
          GetL(m,i,ic);
          if ic>0 then L[m,ic]:=L[i,iConnect];
        end;
      end;
  // end of calculations
end;

procedure TFlatECTask.InverseMul(var p,z:array of TComplex);
var i,NConnect,jColumn,iConnect:int;
begin
  // memory for internal array
  k:=nil;
  SetLength(k,NNodes+1);
  // Solving the system L*k=p (we try to find k)
  for i:=1 to NNodes do
  begin
    k[i]:=p[i];
    NConnect:=NumberConnect[i,1];
    for iConnect:=2 to NConnect do
    begin
      jColumn:=NumberConnect[i,iConnect];
      if jColumn<i then k[i]:=CSub(k[i],CMul(k[jColumn],L[i,iConnect]));
    end;
    k[i]:=CDiv(k[i],L[i,1]);
  end;
  // Solving the system L(transposed)*z=k (we try to find z)
  for i:=1 to NNodes do
  begin
    z[i]:=k[i];
    NConnect:=NumberConnect[i,1];
    for iConnect:=2 to NConnect do
    begin
      jColumn:=NumberConnect[i,iConnect];
      if jColumn>i then z[i]:=CSub(z[i],CMul(z[jColumn],L[i,iConnect]));
    end;
    z[i]:=CDiv(z[i],L[i,1]);
  end;
  // release memory used for internal variables
  k:=nil;
end;

end.

