unit ss_main2d;

interface
uses common_main2d, cm_ini, cmData, Gauges, StdCtrls, cmVars;

type
  TFlatSSTask=class(TFlatTask)
  protected
    ErrorCriterion : float;
  public
    Bounds:TFlatBound_reList;
    //////////////////////
    NumberConnect:array of array of int;
    Matrix:array of array of float;
    RightSide:array of float;
    /////////////////////////////
    Residual:array of float;
    ResidualNew:array of float;
    Q:array of float;
    k:array of float;
    L:array of array of float;
    Direction:array of float;
    DirectionNew:array of float;
    Vmatr:array of float;
    //////////////////////////
    constructor Create;
    procedure ReleaseVars;
    procedure GenerateBounds(bnd:TBounds2_data; num:int);override;
    //////////////////////////
    procedure PrepareMatrix;override;
    procedure PrepareSolution;override;
    function MakeSolutionStep:float;override;
    function RunSolution(ee:double;ni:int):float;override;
    procedure CreateNLMatrix;override;
    //////////////////////////////////
    function FindInTri(k:int;x,z:float):float;
    function FindApproximate(x,z:float;var A,B:float):boolean;override;
    procedure ICCG;
    procedure InverseMul(var p,z:array of float);
    function GetL(i,j:int; var ncon:int):float;
  end;

implementation

{==============================================================================}
{==============================  TFlatSSTask  =================================}
{==============================================================================}
constructor TFlatSSTask.Create;
begin
  Bounds:=nil;
  //
  Matrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  //
  Residual:=nil;
  ResidualNew:=nil;
  Q:=nil;
  k:=nil;
  L:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  Vmatr:=nil;
  inherited Create;
end;

procedure TFlatSSTask.ReleaseVars;
begin
  Bounds:=nil;
  //
  Matrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  //
  Residual:=nil;
  ResidualNew:=nil;
  Q:=nil;
  k:=nil;
  L:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  Vmatr:=nil;
  inherited ReleaseVars;
end;

////////////////////////////////////////
procedure TFlatSSTask.GenerateBounds(bnd:TBounds2_data; num:int);
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
      Bounds[nBounds].val:=bnd[i].val;
    end;
  end;
  if nds then
  begin
    lb.Caption:='<< Done >>';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

procedure TFlatSSTask.PrepareMatrix;
var
  iPoint,iSource,iElement,iNode,jNode,jPoint,iBound,k:int;
  a,b,c:mxtyp2;
  NewConnect:boolean;
  iMaterial:int;
  Var_s:float;
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
  for iPoint:=1 to NNodes do begin
    RightSide[iPoint]:=0.0;
    ////////////////////////////
    SetLength(Matrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    ////////////////////////////
    Matrix[iPoint,1]:=0.0;
    NumberConnect[iPoint,1]:=1;
  end;
  {Taking all tetrahedrons in order (by number iElement)}
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
        RightSide[iPoint]:=RightSide[iPoint]+Sources[iSource].val_J*Area*R_average/3;
        RightSide[iPoint]:=RightSide[iPoint]+(Sources[iSource].val_Bx*c[iNode]-Sources[iSource].val_Bz*b[iNode])*R_average/2*mt.Prop(iElement,iMaterial);
        if iNode=3 then inc(iSource)
      end; { iSource }
      {Taking tetrahedron nodes - definition of its number and connection coefficient}
      for jNode:=1 to 3 do
        if iNode=jNode then
          Matrix[iPoint,1]:=Matrix[iPoint,1]+mt.Prop(iElement,iMaterial)*(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Area/4.0*R_Average
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
          Matrix[iPoint,jPoint]:=Matrix[iPoint,jPoint]+mt.Prop(iElement,iMaterial)
                       *(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Area/4.0*R_Average;
        end;  {  else - iNode <> jNode }
    end;  {  for iNode }
    if nds and (iElement mod 1000=0) then gg.Progress:=iElement;
  end;   {  for iElement }
  { Normalization }
{  for iPoint:=1 to NNodes do
  begin
    Var_S:=Matrix[iPoint,1];
    RightSide[iPoint]:=RightSide[iPoint]/Var_S;
    for k:=2 to NumberConnect[iPoint,1] do
      Matrix[iPoint,k]:=Matrix[iPoint,k]/Var_S;
    Matrix[iPoint,1]:=1.0;
  end;  {  for iPoint  }
  { Boundary conditions }
  for iBound:=1 to NBounds do
  begin
    iPoint:=Bounds[iBound].num;
    RightSide[iPoint]:=Matrix[iPoint,1]*Bounds[iBound].val;
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

procedure TFlatSSTask.CreateNLMatrix;
var
  i,iPoint,iSource,iElement,iNode,jNode,jPoint,iBound,k:int;
  a,b,c:mxtyp2;
  NewConnect:boolean;
  iMaterial:int;
  Var_s:float;
  m1,mh2:float;
  mult_1,mult_2:float;
begin
  NumberConnect:=nil;
  Matrix:=nil;
  RightSide:=nil;
  ///////////////////////////////////
  SetLength(NumberConnect,nNodes+1);
  SetLength(Matrix,nNodes+1);
  SetLength(RightSide,nNodes+1);
  //////////////////////////////////////
  for iPoint:=1 to NNodes do begin
    RightSide[iPoint]:=0.0;
    ////////////////////////////
    SetLength(Matrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    ////////////////////////////
    Matrix[iPoint,1]:=0.0;
    NumberConnect[iPoint,1]:=1;
  end;
  {Taking all tetrahedrons in order (by number iElement)}
  iSource:=1;
  for iElement:=1 to NTriangles do
  begin
    Top:=Topology[iElement];
    ElementMatrix(iElement,Area,R_average,a,b,c);
    iMaterial:=Topology[iElement][0];
    m1:=mt.Prop(iElement,iMaterial)/4/Area;
    if m1>1e25 then
      m1:=1e20;
    mh2:=mt.dMuH2(iElement,iMaterial);
    if mh2>1e25 then
      mh2:=1e25;
    {Taking all tetrahedron nodes - definition of matrix row}
    for iNode:=1 to 3 do
    begin
      iPoint:=Top[iNode];
      {Definition of right side - for source elements (current and magnets)}
      mult_1:=0;
      for i:=1 to 3 do mult_1:=mult_1+(b[iNode]*b[i]+c[iNode]*c[i])*vm[Top[i]];
      RightSide[iPoint]:=RightSide[iPoint]-mult_1*m1*R_Average;
      if (iSource<=NSources) and (iElement=Sources[iSource].num) then
      begin
        RightSide[iPoint]:=RightSide[iPoint]+Sources[iSource].val_J*Area*R_average/3;
        RightSide[iPoint]:=RightSide[iPoint]+(Sources[iSource].val_Bx*c[iNode]-Sources[iSource].val_Bz*b[iNode])*R_average/2*mt.Prop(iElement,iMaterial);
        if iNode=3 then inc(iSource)
      end; { iSource }
      {Taking tetrahedron nodes - definition of its number and connection coefficient}
      for jNode:=1 to 3 do
      begin
        mult_2:=0;
        for i:=1 to 3 do mult_2:=mult_2+(b[jNode]*b[i]+c[jNode]*c[i])*vm[Top[i]];
        if iNode=jNode then
          Matrix[iPoint,1]:=Matrix[iPoint,1]+m1*R_Average*(b[iNode]*b[jNode]+c[iNode]*c[jNode])
                                            +mult_1*mult_2*mh2/sqr(2*Area)/(2*Area)
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
          Matrix[iPoint,jPoint]:=Matrix[iPoint,jPoint]+m1*R_Average*(b[iNode]*b[jNode]+c[iNode]*c[jNode])
                                            +mult_1*mult_2*mh2/sqr(2*Area)/(2*Area);
        end;  {  else - iNode <> jNode }
      end;
    end;  {  for iNode }
  end;   {  for iElement }
  { Boundary conditions }
  for iBound:=1 to NBounds do
  begin
    iPoint:=Bounds[iBound].num;
    RightSide[iPoint]:=0;
    SetLength(Matrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    NumberConnect[iPoint,1]:=1;
  end;
end;

procedure TFlatSSTask.PrepareSolution;
var
  NConnects,iConnect,jColumn,iPoint:Cardinal;
begin
  if nds then
  begin
    lb.Caption:='Preparing solution ...';
    ggb.Refresh;
    gg.MaxValue:=NNodes;
  end;
  /////////////////////////////
  SetLength(Vmatr,NNodes+1);
  SetLength(Residual,NNodes+1);
  SetLength(ResidualNew,NNodes+1);
  SetLength(Q,NNodes+1);
  SetLength(Direction,NNodes+1);
  SetLength(DirectionNew,NNodes+1);
  /////////////////////////////////
  if ps.wSMeth2d=2 then ICCG;
  for iPoint:=1 to NNodes do Vmatr[iPoint]:=RightSide[iPoint]/Matrix[iPoint,1];
  ErrorCriterion:=0.0;
  for iPoint:=1 to NNodes do
  begin
    Residual[iPoint]:=RightSide[iPoint]-Vmatr[iPoint]*Matrix[iPoint,1];
    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do
    begin
      jColumn:=NumberConnect[iPoint,iConnect];
      Residual[iPoint]:=Residual[iPoint]-Matrix[iPoint,iConnect]*Vmatr[jColumn]
    end;  {  for iConnect  }
    if ErrorCriterion < Abs(RightSide[iPoint]) then ErrorCriterion:=Abs(RightSide[iPoint]);
    if nds then gg.Progress:=iPoint;
  end;  {  for iPoint  }
  Case ps.wSMeth2d of
    1:for iPoint:=1 to NNodes do Q[iPoint]:=Residual[iPoint]/Matrix[iPoint,1];
    2:InverseMul(Residual,Q);
    else
      for iPoint:=1 to NNodes do Q[iPoint]:=Residual[iPoint];
  end;
  for iPoint:=1 to NNodes do Direction[iPoint]:=Q[iPoint];
  if nds then
  begin
    //Series1.Clear;
    lb.Caption:='Done';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

function TFlatSSTask.MakeSolutionStep:float;
var iPoint,NConnects,jColumn,iConnect:int;
  MultResidual,MultDirection,Alpha,Beta:float;
  MultResidualNew:float;
  Error:float;
  ee:double;
begin
    for iPoint:=1 to NNodes do
    begin
      DirectionNew[iPoint]:=Direction[iPoint]*Matrix[iPoint,1];
      NConnects:=NumberConnect[iPoint,1];
      for iConnect:=2 to NConnects do
      begin
        jColumn:=NumberConnect[iPoint,iConnect];
        DirectionNew[iPoint]:=DirectionNew[iPoint]
        +Matrix[iPoint,iConnect]*Direction[jColumn];
      end  {  for iConnect  }
    end;  {  for iPoint  }
    MultResidual:=0.0;
    MultDirection:=0.0;
    Alpha:=0.0;
    Beta:=0.0;
    for iPoint:=1 to NNodes do
    begin
      MultResidual:=MultResidual+(Residual[iPoint]*Q[iPoint]);
      MultDirection:=MultDirection+Direction[iPoint]*DirectionNew[iPoint];
    end;  {  for iPoint  }
    ee:=MultResidual/MultDirection;
    if Abs(ee)<1e35 then Alpha:=ee;
    MultResidualNew:=0.0;
    Error:=0.0;
    for iPoint:=1 to NNodes do
    begin
      Vmatr[iPoint]:=Vmatr[iPoint]+Alpha*Direction[iPoint];
      Residual[iPoint]:=Residual[iPoint]-Alpha*DirectionNew[iPoint];
      if Error < Abs(Residual[iPoint]) then Error:=Abs(Residual[iPoint]);
    end;  {  for iPoint  }
    Case ps.wSMeth2d of
      1:for iPoint:=1 to NNodes do Q[iPoint]:=Residual[iPoint]/Matrix[iPoint,1];
      2:InverseMul(Residual,Q);
      else for iPoint:=1 to NNodes do Q[iPoint]:=Residual[iPoint];
    end;
    for iPoint:=1 to NNodes do MultResidualNew:=MultResidualNew+(Residual[iPoint]*Q[iPoint]);
    if Abs(ErrorCriterion) > 1e-20 then Error:=Error/ErrorCriterion;
    ee:=MultResidualNew/MultResidual;
    if Abs(ee)<1e35 then Beta:=ee;
    for iPoint:=1 to NNodes do Direction[iPoint]:=Q[iPoint]+Beta*Direction[iPoint];
    Result:=Error;
end;


function TFlatSSTask.RunSolution(ee:double;ni:int):float;
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
  Q:=nil;
  Residual:=nil;
  ResidualNew:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  //////////////////
end;

{==============================================================================}
{===============================  PROTECTED  ==================================}
{==============================================================================}
function TFlatSSTask.FindInTri(k:int;x,z:float):float;
var
  a,b,c:mxtyp2;
  area,rav:float;
  p:float;
  i:int;
begin
  ElementMatrix(k,area,rav,a,b,c);
  p:=0;
  for i:=1 to 3 do
    p:=p+Vmatr[Topology[k][i]]*(a[i]+(b[i]-2/3*Area/rav)*x+c[i]*z)/area/2;
  Result:=p;
end;

function TFlatSSTask.FindApproximate(x,z:float;var A,B:float):boolean;
var
  j,k,qx,qz:int;
  AA:float;
begin
  AA:=0.0;
  qx:=coord2NQuad(x-ax,disc_1,nd1);
  qz:=coord2NQuad(z-az,disc_2,nd2);
  if (qx<1)or(qx>=nnx)or(qz<1)or(qz>=nnz) then
  begin
    Result:=false;
    A:=0.0;
    B:=0.0;
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
  A:=AA;
  B:=0;
end;

{==============================================================================}
{============================  END OF CLASSES  ================================}
{==============================================================================}
function TFlatSSTask.GetL(i,j:int; var ncon:int):float;
var iConnect,jColumn:int;
begin
  ncon:=-1;
  Result:=0;
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

procedure TFlatSSTask.ICCG;
var i,j,m,iConnect,ic:int;
    vv:float;
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
        for j:=1 to m-1 do L[m,1]:=L[m,1]-sqr(GetL(m,j,iConnect));
        L[m,1]:=sqrt(L[m,1]);
      end
      else
      begin
        vv:=GetL(i,m,iConnect);
        if vv<>0 then
        begin
          L[i,iConnect]:=vv;
          for j:=1 to m-1 do L[i,iConnect]:=L[i,iConnect]-GetL(i,j,ic)*GetL(m,j,ic);
          L[i,iConnect]:=L[i,iConnect]/L[m,1];
          GetL(m,i,ic);
          if ic>0 then L[m,ic]:=L[i,iConnect];
        end;
      end;
  // end of calculations
end;

procedure TFlatSSTask.InverseMul(var p,z:array of float);
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
      if jColumn<i then k[i]:=k[i]-k[jColumn]*L[i,iConnect];
    end;
    k[i]:=k[i]/L[i,1];
  end;
  // Solving the system L(transposed)*z=k (we try to find z)
  for i:=1 to NNodes do
  begin
    z[i]:=k[i];
    NConnect:=NumberConnect[i,1];
    for iConnect:=2 to NConnect do
    begin
      jColumn:=NumberConnect[i,iConnect];
      if jColumn>i then z[i]:=z[i]-z[jColumn]*L[i,iConnect];
    end;
    z[i]:=z[i]/L[i,1];
  end;
  // release memory used for internal variables
  k:=nil;
end;

end.
