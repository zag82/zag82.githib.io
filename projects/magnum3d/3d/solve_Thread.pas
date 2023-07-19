unit solve_Thread;
{  Creation of Global Matrix and Right Side using Approximate
   (axisymmetric) solution - Result_app[NPoints]
   New Parameters:
   Number of Elements with 'Defect': NDefects
   Numbers: NumberDefect[NDefects]
   Uniform Property in 'Defect' used in Axisymmetric System:
   PropertyDefect[NDefects]
   Real Property in 'Defect': ScProperty[iMaterial]       }

interface
uses Comvars, cm_ini, cmData, cmVars, complx, Gauges, StdCtrls, sysutils, solve3d,
  Chart,series;

type
  TApproximateSolution=class(TObject)
  protected
    a,b,c,d:mxtyp3;
    Volume:float;
    function Determinant(a1,b1,c1,a2,b2,c2,a3,b3,c3 : float) : float;
    procedure ElementMatrix3(iElement:Int);
  public
    Result_Xc_app:array of TComplex;
    Result_Yc_app:array of TComplex;
    Result_Zc_app:array of TComplex;
    ResXc:array of TComplex;
    ResYc:array of TComplex;
    ResZc:array of TComplex;
    ///////////////
    Result_X_app:array of float;
    Result_Y_app:array of float;
    Result_Z_app:array of float;
    ResX:array of float;
    ResY:array of float;
    ResZ:array of float;
    Result_app:array of float;
    Res:array of float;
    ///////////////
    iDefect:int;
    NDefects:int;
    NumberDefect:array of int;
    PropertyDefect:array of float;
    SigmaDefect:array of float;
    ///////////////////
    gg:TGauge;
    lb:TLabel;
    ggb:TGroupBox;
    Chart1:TChart;
    Series1:TLineSeries;
    /////////////
    nds:boolean;
    constructor Create(NeedShowEdits:boolean);
    procedure SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox;c:TChart;s:TLineSeries);
    // scalar
    procedure PrepareData(iMat:int);
    procedure CreateMatrix;
    function RunSolution(eps:double;ni:int):double;
    // vector
    procedure CreateMatrixRe(dim : int);
    procedure PrepareDataRE(iMat:int);
    procedure CreateAllMatrixRE(iMat:int);
    function RunSolutionRE(eps:double;ni:int):double;
    // complex
    procedure CreateMatrixEC(dim : int);
    procedure PrepareDataEC(iMat:int);
    procedure CreateAllMatrixEC(iMat:int);
    function RunSolutionEC(eps:double;ni:int):double;
  end;

implementation

uses main;

////////////////////////////////////////////////////////////////////////////////
constructor TApproximateSolution.Create(NeedShowEdits:boolean);
begin
  nds:=NeedShowEdits;
  inherited Create;
end;

procedure TApproximateSolution.SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox;c:TChart;s:TLineSeries);
begin
  gg:=Gag;
  lb:=lab;
  ggb:=Grop;
  Chart1:=c;
  Series1:=s;
end;

function TApproximateSolution.Determinant(a1,b1,c1,  a2,b2,c2,  a3,b3,c3 : float) : float;
begin
  Determinant:=a1*(b2*c3-c2*b3)-b1*(a2*c3-c2*a3)+c1*(a2*b3-b2*a3)
end;

procedure TApproximateSolution.ElementMatrix3(iElement:Int);
var
  x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4:float;
begin
{  Вызов координат вершин тетраэдра с номером iElement }
  x1:=Crd_x[ATopology[iElement][1]];
  x2:=Crd_x[ATopology[iElement][2]];
  x3:=Crd_x[ATopology[iElement][3]];
  x4:=Crd_x[ATopology[iElement][4]];
  y1:=Crd_y[ATopology[iElement][1]];
  y2:=Crd_y[ATopology[iElement][2]];
  y3:=Crd_y[ATopology[iElement][3]];
  y4:=Crd_y[ATopology[iElement][4]];
  z1:=Crd_z[ATopology[iElement][1]];
  z2:=Crd_z[ATopology[iElement][2]];
  z3:=Crd_z[ATopology[iElement][3]];
  z4:=Crd_z[ATopology[iElement][4]];
{  Определение коэффициентов матрицы конечного элемента }
  a[1]:=Determinant(x2,y2,z2,x3,y3,z3,x4,y4,z4);
  b[1]:=-Determinant(1,y2,z2,1,y3,z3,1,y4,z4);
  c[1]:=Determinant(1,x2,z2,1,x3,z3,1,x4,z4);
  d[1]:=-Determinant(1,x2,y2,1,x3,y3,1,x4,y4);

  a[2]:=-Determinant(x1,y1,z1,x3,y3,z3,x4,y4,z4);
  b[2]:=Determinant(1,y1,z1,1,y3,z3,1,y4,z4);
  c[2]:=-Determinant(1,x1,z1,1,x3,z3,1,x4,z4);
  d[2]:=Determinant(1,x1,y1,1,x3,y3,1,x4,y4);

  a[3]:=Determinant(x1,y1,z1,x2,y2,z2,x4,y4,z4);
  b[3]:=-Determinant(1,y1,z1,1,y2,z2,1,y4,z4);
  c[3]:=Determinant(1,x1,z1,1,x2,z2,1,x4,z4);
  d[3]:=-Determinant(1,x1,y1,1,x2,y2,1,x4,y4);

  a[4]:=-Determinant(x1,y1,z1,x2,y2,z2,x3,y3,z3);
  b[4]:=Determinant(1,y1,z1,1,y2,z2,1,y3,z3);
  c[4]:=-Determinant(1,x1,z1,1,x2,z2,1,x3,z3);
  d[4]:=Determinant(1,x1,y1,1,x2,y2,1,x3,y3);
{  Расчет объема тетраэдра  }
  Volume:=(a[1]+a[2]+a[3]+a[4])/6.0;
end; { ElementMatrix3  }

{==============================================================================}
{===================== Data preparation for defectoscopy ======================}
{==============================================================================}
procedure TApproximateSolution.PrepareData(iMat:int);
var
  i:int;
  mDef,m:int;
begin
  if nds then
  begin
    lb.Caption:='Preparing defect data ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  { loading existing data from axial solution }
  SetLength(Result_app,NPoints+1);
  a_LoadDataFile('sresult.dat',Result_app[0],(NPoints+1)*SizeOf(Result_app[0]));
  { finding defect material }
  mDef:=mt.DefaultMaterial;
  for i:=0 to mt.NMaterials-1 do if LowerCase(mt.mmName[i])='defect' then mDef:=i;
  { defining defect properties }
  NDefects:=0;
  for i:=1 to NElements do
  begin
    m:=ATopology[i][0];
    if m=mDef then
    begin
      NDefects:=NDefects+1;
      SetLength(NumberDefect,NDefects+1);
      SetLength(PropertyDefect,NDefects+1);
      NumberDefect[NDefects]:=i;
      PropertyDefect[Ndefects]:=mt.ScProperty[iMat];
    end;
    if nds then gg.Progress:=i;
  end;
end;

{==============================================================================}
{==================== Preparing matrix for solution ===========================}
{==============================================================================}
procedure TApproximateSolution.CreateMatrix;
const
  MultConst=1.0E+10;
var
  Var_S : float;
  NewConnectAllowed: boolean;
  iBound,jColumn,jNode,NConnects,
  iNode,iConnect,iPoint : int;
  qq,i,iElement:Cardinal;
  f:boolean;
  iMaterial,k:int;
begin
  SetLength(ScalarMatrix,NPoints+1);
  SetLength(RightSide,NPoints+1);
  SetLength(NumberConnect,NPoints+1);
  { displaying operations }
  if nds then
  begin
    lb.Caption:='Initializing matrix ...';
    ggb.Refresh;
    gg.MaxValue:=NPoints;
  end;
  {Initialization of global matrix, connection matrix and right side}
  for iPoint:=1 to NPoints do begin
    RightSide[iPoint]:=0.0;
    ///////////////////////
    SetLength(ScalarMatrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    /////////////////////////////
    ScalarMatrix[iPoint,1]:=0.0;
    NumberConnect[iPoint,1]:=1;
    if nds then gg.Progress:=iPoint;
  end;  {  for  iPoint  }
  if nds then
  begin
    lb.Caption:='Creating matrix ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  {Taking all tetrahedrons in order (by number iElement)}
  iDefect:=1;
  qq:=Round(NElements/150);
  for iElement:=1 to NElements do
  begin
    f:=false;
    ElementMatrix3(iElement);
    iMaterial:=ATopology[iElement][0];
    {Taking all tetrahedron nodes - definition of matrix row}
    for iNode:=1 to 4 do
    begin
      iPoint:=ATopology[iElement][iNode];
      NConnects:=NumberConnect[iPoint,1];
      {Taking tetrahedron nodes - definition of its number and connection coefficient}
      for jNode:=1 to 4 do
      begin
        jColumn:=ATopology[iElement][jNode];
        NewConnectAllowed:=true;
        {Calculation of global matrix coefficients, starting with diagonal}
        if iNode=jNode then
        begin  {  calculation DIAGONAL coefficient  }
          ScalarMatrix[iPoint,1]:=ScalarMatrix[iPoint,1]
            +mt.ScProperty[iMaterial]*(b[iNode]*b[jNode]*mt.Anisotropy_X[iMaterial]
            +c[iNode]*c[jNode]*mt.Anisotropy_Y[iMaterial]
            +d[iNode]*d[jNode]*mt.Anisotropy_Z[iMaterial])/Volume/36.0;
          {Consideration of 'Defect' Elements with NonUniform Property  }
          if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
          begin
            RightSide[iPoint]:=RightSide[iPoint]+Result_app[iPoint]
              *(PropertyDefect[iDefect]-mt.ScProperty[iMaterial])
              *(b[iNode]*b[jNode]*mt.Anisotropy_X[iMaterial]
              +c[iNode]*c[jNode]*mt.Anisotropy_Y[iMaterial]
              +d[iNode]*d[jNode]*mt.Anisotropy_Z[iMaterial])/Volume/36.0;
            f:=true;
          end;  { if iDefect }
        end
        else
        begin  {  calculation NON-DIAGONAL coefficient  }
          if NConnects>1 then
          begin
            for iConnect:=2 to NConnects do
              if jColumn=NumberConnect[iPoint,iConnect] then
              begin
                ScalarMatrix[iPoint,iConnect]:=ScalarMatrix[iPoint,iConnect]
                  +mt.ScProperty[iMaterial]*(b[iNode]*b[jNode]*mt.Anisotropy_X[iMaterial]
                  +c[iNode]*c[jNode]*mt.Anisotropy_Y[iMaterial]
                  +d[iNode]*d[jNode]*mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                {  Consideration of 'Defect' Elements with NonUniform Property  }
                if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
                begin
                  RightSide[iPoint]:=RightSide[iPoint]+Result_app[jColumn]
                    *(PropertyDefect[iDefect]-mt.ScProperty[iMaterial])
                    *(b[iNode]*b[jNode]*mt.Anisotropy_X[iMaterial]
                    +c[iNode]*c[jNode]*mt.Anisotropy_Y[iMaterial]
                    +d[iNode]*d[jNode]*mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                  f:=true;
                end;  { if iDefect }
                NewConnectAllowed:=false;
              end
          end;  {  if NConnects > 1  }
          if (NConnects=1) or NewConnectAllowed then
          begin
            inc(NumberConnect[iPoint,1]);
            iConnect:=NumberConnect[iPoint,1];
            //////////////////////////////////
            SetLength(ScalarMatrix[iPoint],iConnect+1);
            SetLength(NumberConnect[iPoint],iConnect+1);
            ////////////////////////////////////////
            NumberConnect[iPoint,iConnect]:=jColumn;
            ScalarMatrix[iPoint,iConnect]:=
              mt.ScProperty[iMaterial]*(b[iNode]*b[jNode]*mt.Anisotropy_X[iMaterial]
              +c[iNode]*c[jNode]*mt.Anisotropy_Y[iMaterial]
              +d[iNode]*d[jNode]*mt.Anisotropy_Z[iMaterial])/Volume/36.0;
            {Consideration of 'Defect' Elements with NonUniform Property}
            if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
            begin
              RightSide[iPoint]:=RightSide[iPoint]+Result_app[jColumn]
                *(PropertyDefect[iDefect]-mt.ScProperty[iMaterial])
                *(b[iNode]*b[jNode]*mt.Anisotropy_X[iMaterial]
                +c[iNode]*c[jNode]*mt.Anisotropy_Y[iMaterial]
                +d[iNode]*d[jNode]*mt.Anisotropy_Z[iMaterial])/Volume/36.0;
              f:=true;
            end;  { if iDefect }
          end;  {  if NConnects = 1 or NewConnectAllowed  }
        end;  {  else - iNode <> jNode }
      end;  { for jNode }
    end;  {  for iNode }
    if f then inc(iDefect);
    if ((iElement mod qq)=0)and nds then gg.Progress:=iElement;
  end;   {  for iElement }
  if nds then
  begin
    lb.Caption:='Creating right side due to boundary potentials ...';
    ggb.Refresh;
    gg.MaxValue:=NBounds;
  end;
  { Normalization }
{  for iPoint:=1 to NPoints do
  begin
    Var_S:=ScalarMatrix[iPoint,1];
    RightSide[iPoint]:=RightSide[iPoint]/Var_S;
    for k:=2 to NumberConnect[iPoint,1] do
      ScalarMatrix[iPoint,k]:=ScalarMatrix[iPoint,k]/Var_S;
    ScalarMatrix[iPoint,1]:=1.0;
  end;  {  for iPoint  }
  {BOUNDARY conditions - nodes with predefined potential value}
  for iBound:=1 to NBounds do begin
    iPoint:=NumberBound[iBound];
    RightSide[iPoint]:=ScalarMatrix[iPoint,1]*PotentialBound[iBound];
    for i:=2 to NumberConnect[iPoint,1] do ScalarMatrix[iPoint,i]:=0.0;
    if nds then gg.Progress:=iBound;
  end;
  if fmMain.N60.Checked then a_SaveRSide3;
  if fmMain.N61.Checked then a_SaveMatrix3;
end;

{==============================================================================}
{============================= Run Solution ===================================}
{==============================================================================}
function TApproximateSolution.RunSolution(eps:double;ni:int):double;
var
  iIteration : Cardinal;
  Error,MultResidualNew,Alpha,Beta,
  MultDirection,MultResidual,ErrorCriterion : float;
  NConnects : Cardinal;
  iConnect : Cardinal;
  jColumn : Cardinal;
  iPoint : Cardinal;
  Res:array of float;
begin
  {Нулевое приближение для решения - правая часть, деленная на диагональ}
  SetLength(Residual,NPoints+1);
  SetLength(Z,NPoints+1);
  SetLength(Direction,NPoints+1);
  SetLength(DirectionNew,NPoints+1);
  SetLength(Res,NPoints+1);
  ////////////////////////////
  for iPoint:=1 to NPoints do Res[iPoint]:=RightSide[iPoint]/ScalarMatrix[iPoint,1];
  {Расчет критерия завершения итерационного процесса}
  for iPoint:=1 to NPoints do begin
    Residual[iPoint]:=RightSide[iPoint]-Res[iPoint]*ScalarMatrix[iPoint,1];
    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do
    begin
      jColumn:=NumberConnect[iPoint,iConnect];
      Residual[iPoint]:=Residual[iPoint]-ScalarMatrix[iPoint,iConnect]*Res[jColumn]
    end;  {  for iConnect  }
  end;  {  for iPoint  }
  for iPoint:=1 to NPoints do
    if ps.wSMeth3d=1 then Z[iPoint]:=Residual[iPoint]/ScalarMatrix[iPoint,1]
    else Z[iPoint]:=Residual[iPoint];
  ErrorCriterion:=0.0;
  for iPoint:=1 to NPoints do
  begin
    Direction[iPoint]:=Z[iPoint];
    ErrorCriterion:=ErrorCriterion+Sqr(Residual[iPoint])
  end;  {  for iPoint  }
  iIteration:=0;
  repeat
    for iPoint:=1 to NPoints do
    begin
      DirectionNew[iPoint]:=Direction[iPoint]*ScalarMatrix[iPoint,1];
      NConnects:=NumberConnect[iPoint,1];
      for iConnect:=2 to NConnects do
      begin
        jColumn:=NumberConnect[iPoint,iConnect];
        DirectionNew[iPoint]:=DirectionNew[iPoint]+ScalarMatrix[iPoint,iConnect]*Direction[jColumn];
      end  {  for iConnect  }
    end;  {  for iPoint  }
    MultResidual:=0.0;
    MultDirection:=0.0;
    for iPoint:=1 to NPoints do
    begin
      MultResidual:=MultResidual+Residual[iPoint]*Z[iPoint];
      MultDirection:=MultDirection+Direction[iPoint]*DirectionNew[iPoint];
    end;  {  for iPoint  }
    Alpha:=MultResidual/MultDirection;
    for iPoint:=1 to NPoints do begin
      Res[iPoint]:=Res[iPoint]+Alpha*Direction[iPoint];
      Residual[iPoint]:=Residual[iPoint]-Alpha*DirectionNew[iPoint];
    end;  {  for iPoint  }
    for iPoint:=1 to NPoints do
      if ps.wSMeth3d=1 then Z[iPoint]:=Residual[iPoint]/ScalarMatrix[iPoint,1]
      else Z[iPoint]:=Residual[iPoint];
    MultResidualNew:=0.0;
    for iPoint:=1 to NPoints do MultResidualNew:=MultResidualNew+(Residual[iPoint]*Z[iPoint]);
    Beta:=MultResidualNew/MultResidual;
    for iPoint:=1 to NPoints do Direction[iPoint]:=z[iPoint]+Beta*Direction[iPoint];
    inc(iIteration);
    Error:=0.0;
    for iPoint:=1 to NPoints do Error:=Error+Sqr(Residual[iPoint]);
    if nds then
    begin
      fmSolver3d.eError.Text:=FloatToStrF(Error,ffGeneral,5,1);
      fmSolver3d.eError.Refresh;
      fmSolver3d.eIter.Text:=IntToStr(iIteration);
      fmSolver3d.eIter.Refresh;
      Series1.AddXY(iIteration,Error);
      Chart1.Refresh;
    end;
  until (Error<eps)or(iIteration>=ni);
  Residual:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  Z:=nil;
  { Erasing ScalarMatrix and right side }
  ScalarMatrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  { uniting axial and defect-depending solution }
  a_SaveDataFile('sresult_def.dat',Res[0],(NPoints+1)*SizeOf(Res[0]));
  a_SaveDataFile('sresult_ax.dat',Result_app[0],(NPoints+1)*SizeOf(Result_app[0]));
  for iPoint:= 1 to NPoints do
    Res[iPoint]:=Res[ipoint]+Result_app[iPoint];
  { saving results to file }
  a_SaveDataFile('sresult.dat',Res[0],(NPoints+1)*SizeOf(Res[0]));
  Result:=error;
  ///////////////////////////////////////////////////////////////////////
  Result_app:=nil;
  Res:=nil;
  iDefect:=0;
  NDefects:=0;
  NumberDefect:=nil;
  PropertyDefect:=nil;
end;

{==============================================================================}

{==============================================================================}
procedure TApproximateSolution.PrepareDataRE(iMat:int);
var
  i:int;
  mDef,m:int;
begin
  if nds then
  begin
    lb.Caption:='Preparing defect data ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  { loading existing data from axial solution }
  Result_X_app:=nil;
  Result_Y_app:=nil;
  Result_Z_app:=nil;
  SetLength(Result_X_app,NPoints+1);
  SetLength(Result_Y_app,NPoints+1);
  SetLength(Result_Z_app,NPoints+1);
  a_LoadDataFile('resultx.dat',Result_X_app[0],(NPoints+1)*SizeOf(Result_X_app[0]));
  a_LoadDataFile('resulty.dat',Result_Y_app[0],(NPoints+1)*SizeOf(Result_Y_app[0]));
  a_LoadDataFile('resultz.dat',Result_Z_app[0],(NPoints+1)*SizeOf(Result_Z_app[0]));
  { finding defect material }
  mDef:=mt.DefaultMaterial;
  for i:=0 to mt.NMaterials-1 do if LowerCase(mt.mmName[i])='defect' then mDef:=i;
  { defining defect properties }
  NDefects:=0;
  for i:=1 to NElements do
  begin
    m:=ATopology[i][0];
    if m=mDef then
    begin
      NDefects:=NDefects+1;
      SetLength(NumberDefect,NDefects+1);
      SetLength(PropertyDefect,NDefects+1);
      SetLength(SigmaDefect,NDefects+1);
      NumberDefect[NDefects]:=i;
      PropertyDefect[Ndefects]:=mt.VecProperty[iMat];
      SigmaDefect[Ndefects]:=mt.Sigma[iMat];
    end;
    if nds then gg.Progress:=i;
  end;
end;

procedure TApproximateSolution.CreateAllMatrixRE(iMat:int);
var
  dim: int;
begin
  PrepareDataRE(iMat);
  { Place thread code here }
  RealMatrix_X:=nil;
  RealMatrix_Y:=nil;
  RealMatrix_Z:=nil;
  for dim:=0 to 2 do
    CreateMatrixRE(dim);
  if fmMain.N60.Checked then a_SaveRSide3;
  if fmMain.N61.Checked then a_SaveMatrix3_re;
end;

procedure TApproximateSolution.CreateMatrixRe(dim : int);
var
  iNode,jNode,iPoint,iSource,
  jColumn,iConnect,jConnect,iElement,
  NConnects,iBound : int;
  NewConnectAllowed: boolean;
  Var_X,Var_Y,Var_Z : float;
  Mult : float;
  i : int;
  f:boolean;
  qq:int;
  iMaterial:int;
begin
  {Обнуление коэффициентов глобальной матрицы и правой части}
  SetLength(RightSide_X,NPoints+1);
  SetLength(RightSide_Y,NPoints+1);
  SetLength(RightSide_Z,NPoints+1);
  { displaying operations }
  if nds then
  begin
    lb.Caption:='Initializing matrix ...';
    ggb.Refresh;
    gg.MaxValue:=NPoints;
  end;
  /////////////////////////////////
  SetLength(NumberConnect,NPOints+1);
  case dim of
    0: SetLength(RealMatrix_X,nPoints+1);
    1: SetLength(RealMatrix_Y,nPoints+1);
    2: SetLength(RealMatrix_Z,nPoints+1);
  end;
  /////////////////////////////
  for iPoint:=1 to NPoints do
  begin
    case dim of
      0: RightSide_X[iPoint]:=0.0;
      1: RightSide_Y[iPoint]:=0.0;
      2: RightSide_Z[iPoint]:=0.0;
    end;
    ///////////
    case dim of
      0: SetLength(RealMatrix_X[iPoint],4);
      1: SetLength(RealMatrix_Y[iPoint],4);
      2: SetLength(RealMatrix_Z[iPoint],4);
    end;
    SetLength(NumberConnect[iPoint],2);
    /////////////////////////////////
    case dim of
      0: RealMatrix_X[iPoint,1]:=0.0;
      1: RealMatrix_Y[iPoint,1]:=0.0;
      2: RealMatrix_Z[iPoint,1]:=0.0;
    end;
    NumberConnect[iPoint,1]:=1;
    for iConnect:=1 to 3 do
    begin
      case dim of
        0: RealMatrix_X[iPoint,iConnect]:=0.0;
        1: RealMatrix_Y[iPoint,iConnect]:=0.0;
        2: RealMatrix_Z[iPoint,iConnect]:=0.0;
      end;
    end; {  for iConnect  }
    if ((iPoint mod 100)=0)and nds then gg.Progress:=iPoint;
  end;  {  for iPoint  }
  {Просмотр всех тетраэдров по порядку (по номеру iElement)}
  if nds then
  begin
    lb.Caption:='Creating matrix ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  ///////////
  iDefect:=1;
  qq:=Round(NElements/150);
  for iElement:=1 to NElements do
  begin
    f:=false;
    ElementMatrix3(iElement);
    iMaterial:=ATopology[iElement][0];
    {Просмотр вершин тетраэдра - определение номера строки матрицы}
    for iNode:=1 to 4 do
    begin
      iPoint:=ATopology[iElement][iNode];
      NConnects:=NumberConnect[iPoint,1];
      {Просмотр вершин тетраэдра - определение номера узла и коэффициента связи}
      for jNode:=1 to 4 do
      begin
        {номер узла связи !!!}
        jColumn:=ATopology[iElement][jNode];
        NewConnectAllowed:=true;
        {Расчет коэффициентов глобальной матрицы и формирование матрицы связи}
        if iNode=jNode then
        begin   {  диагональный коэффициент !!  }
          case dim of
            0: RealMatrix_X[iPoint,1]:=RealMatrix_X[iPoint,1]
               +mt.VecProperty[iMaterial]*(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]
               +d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
            1: RealMatrix_Y[iPoint,2]:=RealMatrix_Y[iPoint,2]
               +mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]
               +d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
            2: RealMatrix_Z[iPoint,3]:=RealMatrix_Z[iPoint,3]
               +mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]
               +c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
          end;
          case dim of
            0: begin
              RealMatrix_X[iPoint,2]:=RealMatrix_X[iPoint,2]
              -mt.VecProperty[iMaterial]*(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
              RealMatrix_X[iPoint,3]:=RealMatrix_X[iPoint,3]
              -mt.VecProperty[iMaterial]*(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
            end;
            1: begin
              RealMatrix_Y[iPoint,1]:=RealMatrix_Y[iPoint,1]
              -mt.VecProperty[iMaterial]*(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
              RealMatrix_Y[iPoint,3]:=RealMatrix_Y[iPoint,3]
              -mt.VecProperty[iMaterial]*(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
            end;
            2: begin
              RealMatrix_Z[iPoint,1]:=RealMatrix_Z[iPoint,1]
              -mt.VecProperty[iMaterial]*(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
              RealMatrix_Z[iPoint,2]:=RealMatrix_Z[iPoint,2]
              -mt.VecProperty[iMaterial]*(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
            end;
          end;
          {Consideration of 'Defect' Elements with NonUniform Property}
          if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
          begin
            f:=true;
            case dim of
            0: RightSide_X[iPoint]:=RightSide_X[iPoint]+Result_X_app[iPoint]
               *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
               *(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]
               +d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
            1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]+Result_Y_app[iPoint]
               *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
               *(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]
               +d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
            2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]+Result_Z_app[iPoint]
               *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
               *(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]
               +c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
            end;
            case dim of
              0: begin
                RightSide_X[iPoint]:=RightSide_X[iPoint]-Result_Y_app[iPoint]
                *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                RightSide_X[iPoint]:=RightSide_X[iPoint]-Result_Z_app[iPoint]
                *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
              end;
              1: begin
                RightSide_Y[iPoint]:=RightSide_Y[iPoint]-Result_X_app[iPoint]
                *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                RightSide_Y[iPoint]:=RightSide_Y[iPoint]-Result_Z_app[iPoint]
                *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
              end;
              2: begin
                RightSide_Z[iPoint]:=RightSide_Z[iPoint]-Result_X_app[iPoint]
                *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                RightSide_Z[iPoint]:=RightSide_Z[iPoint]-Result_Y_app[iPoint]
                *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
              end;
            end;
          end;  { if iDefect }
        end {if iNode=jNode}
        else
        begin   {  расчет НЕдиагональных коэффициентов  }
          if NConnects > 1 then
          begin
            for iConnect:=2 to NConnects do
            begin
              if jColumn=NumberConnect[iPoint,iConnect] then
              begin
                jConnect:=3*iConnect-2;
                try
                  case dim of
                    0: RealMatrix_X[iPoint,jConnect]:=RealMatrix_X[iPoint,jConnect]+
                       mt.VecProperty[iMaterial]*(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                       d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                    1: RealMatrix_Y[iPoint,jConnect+1]:=RealMatrix_Y[iPoint,jConnect+1]+
                       mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                       d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                    2: RealMatrix_Z[iPoint,jConnect+2]:=RealMatrix_Z[iPoint,jConnect+2]+
                       mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                       c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                  end;
                  case dim of
                    0: begin
                      RealMatrix_X[iPoint,jConnect+1]:=RealMatrix_X[iPoint,jConnect+1]-
                      mt.VecProperty[iMaterial]*(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                      RealMatrix_X[iPoint,jConnect+2]:=RealMatrix_X[iPoint,jConnect+2]-
                      mt.VecProperty[iMaterial]*(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                    end;
                    1: begin
                      RealMatrix_Y[iPoint,jConnect]:=RealMatrix_Y[iPoint,jConnect]-
                      mt.VecProperty[iMaterial]*(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                      RealMatrix_Y[iPoint,jConnect+2]:=RealMatrix_Y[iPoint,jConnect+2]-
                      mt.VecProperty[iMaterial]*(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                    end;
                    2: begin
                      RealMatrix_Z[iPoint,jConnect]:=RealMatrix_Z[iPoint,jConnect]-
                      mt.VecProperty[iMaterial]*(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                      RealMatrix_Z[iPoint,jConnect+1]:=RealMatrix_Z[iPoint,jConnect+1]-
                      mt.VecProperty[iMaterial]*(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0
                    end
                  end;
                  {Consideration of 'Defect' Elements with NonUniform Property}
                  if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
                  begin
                    f:=true;
                    case dim of
                      0: RightSide_X[iPoint]:=RightSide_X[iPoint]+Result_X_app[jColumn]
                         *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                         *(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                         d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                      1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]+Result_Y_app[jColumn]
                         *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                         *(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                         d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                      2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]+Result_Z_app[jColumn]
                         *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                         *(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                         c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                    end;
                    case dim of
                      0: begin
                        RightSide_X[iPoint]:=RightSide_X[iPoint]-Result_Y_app[jColumn]
                          *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                          *(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                        RightSide_X[iPoint]:=RightSide_X[iPoint]-Result_Z_app[jColumn]
                          *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                          *(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                      end;
                      1: begin
                        RightSide_Y[iPoint]:=RightSide_Y[iPoint]-Result_X_app[jColumn]
                          *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                          *(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                        RightSide_Y[iPoint]:=RightSide_Y[iPoint]-Result_Z_app[jColumn]
                          *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                          *(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                      end;
                      2: begin
                        RightSide_Z[iPoint]:=RightSide_Z[iPoint]-Result_X_app[jColumn]
                          *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                          *(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                        RightSide_Z[iPoint]:=RightSide_Z[iPoint]-Result_Y_app[jColumn]
                          *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                          *(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0
                      end
                    end;
                  end;  { if iDefect }
                except
                end;
                NewConnectAllowed:=false;
              end  {if jColumn}
            end  {for jConnect}
          end; {if NConnects}
          if (NConnects=1) or NewConnectAllowed then
          begin
            NumberConnect[iPoint,1]:=NumberConnect[iPoint,1]+1;
            iConnect:=NumberConnect[iPoint,1];
            jConnect:=3*iConnect-2;
            //////////////////////////////////////////
            SetLength(NumberConnect[iPoint],iConnect+1);
            case dim of
              0: SetLength(RealMatrix_X[iPoint],jConnect+3);
              1: SetLength(RealMatrix_Y[iPoint],jConnect+3);
              2: SetLength(RealMatrix_Z[iPoint],jConnect+3);
            end;
            ////////////////////////////////////////
            NumberConnect[iPoint,iConnect]:=jColumn;
            try
              case dim of
                0: RealMatrix_X[iPoint,jConnect]:=
                   mt.VecProperty[iMaterial]*(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                   d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                1: RealMatrix_Y[iPoint,jConnect+1]:=
                   mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                   d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                2: RealMatrix_Z[iPoint,jConnect+2]:=
                   mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                   c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
              end;
              case dim of
                0: begin
                  RealMatrix_X[iPoint,jConnect+1]:=
                  -mt.VecProperty[iMaterial]*(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                  RealMatrix_X[iPoint,jConnect+2]:=
                  -mt.VecProperty[iMaterial]*(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                end;
                1: begin
                  RealMatrix_Y[iPoint,jConnect]:=
                  -mt.VecProperty[iMaterial]*(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                  RealMatrix_Y[iPoint,jConnect+2]:=
                  -mt.VecProperty[iMaterial]*(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                end;
                2: begin
                  RealMatrix_Z[iPoint,jConnect]:=
                  -mt.VecProperty[iMaterial]*(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                  RealMatrix_Z[iPoint,jConnect+1]:=
                  -mt.VecProperty[iMaterial]*(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0
                end
              end;
              {Consideration of 'Defect' Elements with NonUniform Property}
              if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
              begin
                f:=true;
                case dim of
                  0: RightSide_X[iPoint]:=RightSide_X[iPoint]+Result_X_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                     d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                  1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]+Result_Y_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                     d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                  2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]+Result_Z_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                     c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                end;
                case dim of
                  0: begin
                    RightSide_X[iPoint]:=RightSide_X[iPoint]-Result_Y_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                    RightSide_X[iPoint]:=RightSide_X[iPoint]-Result_Z_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                  end;
                  1: begin
                    RightSide_Y[iPoint]:=RightSide_Y[iPoint]-Result_X_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0;
                    RightSide_Y[iPoint]:=RightSide_Y[iPoint]-Result_Z_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0;
                  end;
                  2: begin
                    RightSide_Z[iPoint]:=RightSide_Z[iPoint]-Result_X_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0;
                    RightSide_Z[iPoint]:=RightSide_Z[iPoint]-Result_Y_app[jColumn]
                     *(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                     *(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0
                  end
                end;
              end;  { if iDefect }
            except
            end;
          end  {  if (NConnects=1) or NewConnectAllowed }
        end  {  else if iNode=jNode  }
      end  { for jNode }
    end;  {  for iNode }
    if f then inc(iDefect);
    if ((iElement mod qq)=0)and nds then gg.Progress:=iElement;
  end;   {  for iElement }
  { Normalization }
{  lb.Caption:='Normalizing matrixes ...';
  ggb.Refresh;
  gg.MaxValue:=NPoints;
  for iPoint:=1 to NPoints do
  begin
    case dim of
      0: Var_X:=RealMatrix_X[iPoint,1];
      1: Var_Y:=RealMatrix_Y[iPoint,2];
      2: Var_Z:=RealMatrix_Z[iPoint,3];
    end;
    try
      case dim of
        0: RightSide_X[iPoint]:=RightSide_X[iPoint]/Var_X;
        1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]/Var_Y;
        2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]/Var_Z;
      end;
      case dim of
        0: begin
          RealMatrix_X[iPoint,2]:=RealMatrix_X[iPoint,2]/Var_X;
          RealMatrix_X[iPoint,3]:=RealMatrix_X[iPoint,3]/Var_X;
        end;
        1: begin
          RealMatrix_Y[iPoint,1]:=RealMatrix_Y[iPoint,1]/Var_Y;
          RealMatrix_Y[iPoint,3]:=RealMatrix_Y[iPoint,3]/Var_Y;
        end;
        2: begin
          RealMatrix_Z[iPoint,1]:=RealMatrix_Z[iPoint,1]/Var_Z;
          RealMatrix_Z[iPoint,2]:=RealMatrix_Z[iPoint,2]/Var_Z;
        end
      end;
    except
    end;
    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do begin
      //jColumn:=NumberConnect[iPoint,iConnect];
      jConnect:=3*iConnect-2;
      try
        case dim of
          0: begin
            RealMatrix_X[iPoint,jConnect]:=RealMatrix_X[iPoint,jConnect]/Var_X;
            RealMatrix_X[iPoint,jConnect+1]:=RealMatrix_X[iPoint,jConnect+1]/Var_X;
            RealMatrix_X[iPoint,jConnect+2]:=RealMatrix_X[iPoint,jConnect+2]/Var_X;
          end;
          1: begin
            RealMatrix_Y[iPoint,jConnect]:=RealMatrix_Y[iPoint,jConnect]/Var_Y;
            RealMatrix_Y[iPoint,jConnect+1]:=RealMatrix_Y[iPoint,jConnect+1]/Var_Y;
            RealMatrix_Y[iPoint,jConnect+2]:=RealMatrix_Y[iPoint,jConnect+2]/Var_Y;
          end;
          2: begin
            RealMatrix_Z[iPoint,jConnect]:=RealMatrix_Z[iPoint,jConnect]/Var_Z;
            RealMatrix_Z[iPoint,jConnect+1]:=RealMatrix_Z[iPoint,jConnect+1]/Var_Z;
            RealMatrix_Z[iPoint,jConnect+2]:=RealMatrix_Z[iPoint,jConnect+2]/Var_Z;
          end
        end;
      except
      end
    end;
    case dim of
      0: RealMatrix_X[iPoint,1]:=1.0;
      1: RealMatrix_Y[iPoint,2]:=1.0;
      2: RealMatrix_Z[iPoint,3]:=1.0;
    end;
    if (iPoint mod 500)=0 then gg.Progress:=iPoint;
  end;  {  for iPoint  }
{  Boundary conditions  }
  case dim of
    0: begin {  X-component  }
      {Учет граничных условий - просмотр узлов с заданным векторным потенциалом }
      if nds then
      begin
        lb.Caption:='Applying boundary potentials (X) ...';
        ggb.Refresh;
        gg.MaxValue:=NBounds_X;
      end;
      for iBound:=1 to NBounds_X do
      begin
        iPoint:=NumberBound_X[iBound];
        {Граничное условие - узел с заданной Х-компонентой векторного потенциала}
        RightSide_X[iPoint]:=RealMatrix_X[iPoint,1]*PotentialBound_X[iBound];
        for i:=1 to 3*NumberConnect[iPoint,1] do
          RealMatrix_X[iPoint,i]:=0.0;
        RealMatrix_X[iPoint,1]:=1.0{MultConst};
        if ((iBound mod 100)=0)and nds then gg.Progress:=iBound;
      end;
    end;
    1: begin
      if nds then
      begin
        lb.Caption:='Applying boundary potentials (Y)...';
        ggb.Refresh;
        gg.MaxValue:=NBounds_Y;
      end;
      for iBound:=1 to NBounds_Y do
      begin
        iPoint:=NumberBound_Y[iBound];
        {Граничное условие - узел с заданной Y-компонентой векторного потенциала}
        RightSide_Y[iPoint]:=RealMatrix_Y[iPoint,2]*PotentialBound_Y[iBound];
        for i:=1 to 3*NumberConnect[iPoint,1] do
          RealMatrix_Y[iPoint,i]:=0.0;
        RealMatrix_Y[iPoint,2]:=1.0{MultConst};
        if ((iBound mod 100)=0) and nds then gg.Progress:=iBound;
      end;
    end;
    2: begin
      if nds then
      begin
        lb.Caption:='Applying boundary potentials (Z)...';
        ggb.Refresh;
        gg.MaxValue:=NBounds_Z;
      end;
      for iBound:=1 to NBounds_Z do
      begin
        iPoint:=NumberBound_Z[iBound];
        {Граничное условие - узел с заданной Z-компонентой векторного потенциала}
        RightSide_Z[iPoint]:=RealMatrix_Z[iPoint,3]*PotentialBound_Z[iBound];
        for i:=1 to 3*NumberConnect[iPoint,1] do
          RealMatrix_Z[iPoint,i]:=0.0;
        RealMatrix_Z[iPoint,3]:=1.0{MultConst};
        if ((iBound mod 100)=0)and nds then gg.Progress:=iBound;
      end;  {   for iBound }
    end;
  end;
  if nds then
  begin
    lb.Caption:='Done';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

function TApproximateSolution.RunSolutionRE(eps:double;ni:int):double;
var
  Alpha,Beta,MultResidual,Var_X,Var_Y,Var_Z,Var_Sum,
  MultDirection,
  ErrorCriterion,MultResidualNew : float;
  i,iPoint,iIteration,
  NConnects,iConnect,jColumn,
  jConnect : LongInt;
  NormalError:double;
begin
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
  ////////////////////////////////
  SetLength(Residual_X,NPoints+1);
  SetLength(Residual_Y,NPoints+1);
  SetLength(Residual_Z,NPoints+1);
  SetLength(Direction_X,NPoints+1);
  SetLength(Direction_Y,NPoints+1);
  SetLength(Direction_Z,NPoints+1);
  SetLength(DirectionNew_X,NPoints+1);
  SetLength(DirectionNew_Y,NPoints+1);
  SetLength(DirectionNew_Z,NPoints+1);
  SetLength(zrX,NPoints+1);
  SetLength(zrY,NPoints+1);
  SetLength(zrZ,NPoints+1);
  SetLength(ResX,NPoints+1);
  SetLength(ResY,NPoints+1);
  SetLength(ResZ,NPoints+1);
  ////////////////////////////////
  for iPoint:=1 to NPoints do
  begin
    ResX[iPoint]:=RightSide_X[iPoint]/RealMatrix_X[iPoint,1];
    ResY[iPoint]:=RightSide_Y[iPoint]/RealMatrix_Y[iPoint,2];
    ResZ[iPoint]:=RightSide_Z[iPoint]/RealMatrix_Z[iPoint,3];
  end;  {  for iPoint  }
  {Расчет критерия завершения итерационного процесса}
  for iPoint:=1 to NPoints do
  begin
    Var_X:=ResX[iPoint];
    Var_Y:=ResY[iPoint];
    Var_Z:=ResZ[iPoint];

    Var_Sum:=RealMatrix_X[iPoint,1]*Var_X+
             RealMatrix_X[iPoint,2]*Var_Y+
             RealMatrix_X[iPoint,3]*Var_Z;
    Residual_X[iPoint]:=RightSide_X[iPoint]-Var_Sum;

    Var_Sum:=RealMatrix_Y[iPoint,1]*Var_X+
             RealMatrix_Y[iPoint,2]*Var_Y+
             RealMatrix_Y[iPoint,3]*Var_Z;
    Residual_Y[iPoint]:=RightSide_Y[iPoint]-Var_Sum;

    Var_Sum:=RealMatrix_Z[iPoint,1]*Var_X+
             RealMatrix_Z[iPoint,2]*Var_Y+
             RealMatrix_Z[iPoint,3]*Var_Z;
    Residual_Z[iPoint]:=RightSide_Z[iPoint]-Var_Sum;
    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do
    begin
      jColumn:=NumberConnect[iPoint,iConnect];
      jConnect:=3*iConnect-2;

      Var_X:=ResX[jColumn];
      Var_Y:=ResY[jColumn];
      Var_Z:=ResZ[jColumn];

      Var_Sum:=RealMatrix_X[iPoint,jConnect]*Var_X+
               RealMatrix_X[iPoint,jConnect+1]*Var_Y+
               RealMatrix_X[iPoint,jConnect+2]*Var_Z;
      Residual_X[iPoint]:=Residual_X[iPoint]-Var_Sum;

      Var_Sum:=RealMatrix_Y[iPoint,jConnect]*Var_X+
               RealMatrix_Y[iPoint,jConnect+1]*Var_Y+
               RealMatrix_Y[iPoint,jConnect+2]*Var_Z;
      Residual_Y[iPoint]:=Residual_Y[iPoint]-Var_Sum;

      Var_Sum:=RealMatrix_Z[iPoint,jConnect]*Var_X+
               RealMatrix_Z[iPoint,jConnect+1]*Var_Y+
               RealMatrix_Z[iPoint,jConnect+2]*Var_Z;
      Residual_Z[iPoint]:=Residual_Z[iPoint]-Var_Sum;
    end;  {  for iConnect    }
  end;  {  for iPoint  }
  for iPoint:=1 to NPoints do
    if ps.wSMeth_d=1 then
    begin
      zrX[iPoint]:=Residual_X[iPoint]/RealMatrix_X[iPoint,1];
      zrY[iPoint]:=Residual_Y[iPoint]/RealMatrix_Y[iPoint,2];
      zrZ[iPoint]:=Residual_Z[iPoint]/RealMatrix_Z[iPoint,3];
    end
    else
    begin
      zrX[iPoint]:=Residual_X[iPoint];
      zrY[iPoint]:=Residual_Y[iPoint];
      zrZ[iPoint]:=Residual_Z[iPoint];
    end;
  ErrorCriterion:=0.0;
  for iPoint:=1 to NPoints do begin
    Direction_X[iPoint]:=zrx[iPoint];
    Direction_Y[iPoint]:=zrY[iPoint];
    Direction_Z[iPoint]:=zrZ[iPoint];
    if NSources=0 then begin
      ErrorCriterion:=ErrorCriterion+Sqr(Residual_X[iPoint]);
      ErrorCriterion:=ErrorCriterion+Sqr(Residual_Y[iPoint]);
      ErrorCriterion:=ErrorCriterion+Sqr(Residual_Z[iPoint])
    end else begin
      ErrorCriterion:=ErrorCriterion+Sqr(RightSide_X[iPoint]);
      ErrorCriterion:=ErrorCriterion+Sqr(RightSide_Y[iPoint]);
      ErrorCriterion:=ErrorCriterion+Sqr(RightSide_Z[iPoint])
    end
  end;  {  for iPoint  }
  if NSources=0 then ErrorCriterion:=Eps*ErrorCriterion;
  iIteration:=0;
  repeat
    {Расчет вектора коррекции остатка}
    for iPoint:=1 to NPoints do
    begin
      Var_X:=Direction_X[iPoint];
      Var_Y:=Direction_Y[iPoint];
      Var_Z:=Direction_Z[iPoint];

      Var_Sum:=RealMatrix_X[iPoint,1]*Var_X+
               RealMatrix_X[iPoint,2]*Var_Y+
               RealMatrix_X[iPoint,3]*Var_Z;
      DirectionNew_X[iPoint]:=Var_Sum;

      Var_Sum:=RealMatrix_Y[iPoint,1]*Var_X+
               RealMatrix_Y[iPoint,2]*Var_Y+
               RealMatrix_Y[iPoint,3]*Var_Z;
      DirectionNew_Y[iPoint]:=Var_Sum;

      Var_Sum:=RealMatrix_Z[iPoint,1]*Var_X+
               RealMatrix_Z[iPoint,2]*Var_Y+
               RealMatrix_Z[iPoint,3]*Var_Z;
      DirectionNew_Z[iPoint]:=Var_Sum;
      NConnects:=NumberConnect[iPoint,1];
      for iConnect:=2 to NConnects do
      begin
        jColumn:=NumberConnect[iPoint,iConnect];
        jConnect:=3*iConnect-2;

        Var_X:=Direction_X[jColumn];
        Var_Y:=Direction_Y[jColumn];
        Var_Z:=Direction_Z[jColumn];

        Var_Sum:=RealMatrix_X[iPoint,jConnect]*Var_X+
                 RealMatrix_X[iPoint,jConnect+1]*Var_Y+
                 RealMatrix_X[iPoint,jConnect+2]*Var_Z;
        DirectionNew_X[iPoint]:=Var_Sum+DirectionNew_X[iPoint];

        Var_Sum:=RealMatrix_Y[iPoint,jConnect]*Var_X+
                 RealMatrix_Y[iPoint,jConnect+1]*Var_Y+
                 RealMatrix_Y[iPoint,jConnect+2]*Var_Z;
        DirectionNew_Y[iPoint]:=Var_Sum+DirectionNew_Y[iPoint];

        Var_Sum:=RealMatrix_Z[iPoint,jConnect]*Var_X+
                 RealMatrix_Z[iPoint,jConnect+1]*Var_Y+
                 RealMatrix_Z[iPoint,jConnect+2]*Var_Z;
        DirectionNew_Z[iPoint]:=Var_Sum+DirectionNew_Z[iPoint];
      end  {  for iConnect    }
    end;  {  for iPoint  }
    {Расчет коэффициента коррекции векторов решения и остатка}
    MultResidual:=0.0;
    MultDirection:=0.0;
    for iPoint:=1 to NPoints do
    begin
      MultResidual:=MultResidual+(Residual_X[iPoint]*zrX[iPoint]);
      MultResidual:=MultResidual+(Residual_Y[iPoint]*zrY[iPoint]);
      MultResidual:=MultResidual+(Residual_Z[iPoint]*zrZ[iPoint]);
      MultDirection:=MultDirection+Direction_X[iPoint]*DirectionNew_X[iPoint];
      MultDirection:=MultDirection+Direction_Y[iPoint]*DirectionNew_Y[iPoint];
      MultDirection:=MultDirection+Direction_Z[iPoint]*DirectionNew_Z[iPoint]
    end;  {  for iPoint  }
    if MultDirection=0 then Alpha:=0 else Alpha:=MultResidual/MultDirection;
    {Расчет новых значений векторов решения и остатка}
    for iPoint:=1 to NPoints do begin
      ResX[iPoint]:=ResX[iPoint]+Alpha*Direction_X[iPoint];
      ResY[iPoint]:=ResY[iPoint]+Alpha*Direction_Y[iPoint];
      ResZ[iPoint]:=ResZ[iPoint]+Alpha*Direction_Z[iPoint];
      Residual_X[iPoint]:=Residual_X[iPoint]-Alpha*DirectionNew_X[iPoint];
      Residual_Y[iPoint]:=Residual_Y[iPoint]-Alpha*DirectionNew_Y[iPoint];
      Residual_Z[iPoint]:=Residual_Z[iPoint]-Alpha*DirectionNew_Z[iPoint];
    end;  {  for iPoint  }
    for iPoint:=1 to NPoints do
      if ps.wSMeth_d=1 then
      begin
        zrX[iPoint]:=Residual_X[iPoint]/RealMatrix_X[iPoint,1];
        zrY[iPoint]:=Residual_Y[iPoint]/RealMatrix_Y[iPoint,2];
        zrZ[iPoint]:=Residual_Z[iPoint]/RealMatrix_Z[iPoint,3];
      end
      else
      begin
        zrX[iPoint]:=Residual_X[iPoint];
        zrY[iPoint]:=Residual_Y[iPoint];
        zrZ[iPoint]:=Residual_Z[iPoint];
      end;
    {Расчет коэффициента коррекции вектора направления изменения решения}
    MultResidualNew:=0.0;
    for iPoint:=1 to NPoints do
    begin
      MultResidualNew:=MultResidualNew+(Residual_X[iPoint]*zrX[iPoint]);
      MultResidualNew:=MultResidualNew+(Residual_Y[iPoint]*zrY[iPoint]);
      MultResidualNew:=MultResidualNew+(Residual_Z[iPoint]*zrZ[iPoint]);
    end;  {  for iPoint  }
    if MultResidual=0 then Beta:=0.0 else Beta:=MultResidualNew/MultResidual;
    {Расчет вектора направления изменения решения}
    for iPoint:=1 to NPoints do
    begin
      Direction_X[iPoint]:=zrX[iPoint]+Beta*Direction_X[iPoint];
      Direction_Y[iPoint]:=zrY[iPoint]+Beta*Direction_Y[iPoint];
      Direction_Z[iPoint]:=zrZ[iPoint]+Beta*Direction_Z[iPoint]
    end;  {  for iPoint  }
    {Расчет номера итераций и значения ошибки}
    inc(iIteration);
    NormalError:=0;
    for iPoint:=1 to NPoints do
    begin
      NormalError:=NormalError+Sqr(Residual_X[iPoint]);
      NormalError:=NormalError+Sqr(Residual_Y[iPoint]);
      NormalError:=NormalError+Sqr(Residual_Z[iPoint])
    end;  {  for iPoint  }
    { need to change }
    if ErrorCriterion=0.0 then ErrorCriterion:=1e-20;

    if nSources>0 then NormalError:=NormalError/ErrorCriterion;
    //////////////////////////////////////
    if nds then
    begin
      fmSolver3d.eError.Text:=FloatToStrF(NormalError,ffGeneral,5,1);
      fmSolver3d.eError.Refresh;
      fmSolver3d.eIter.Text:=IntToStr(iIteration);
      fmSolver3d.eIter.Refresh;
      Series1.AddXY(iIteration,NormalError);
      Chart1.Refresh;
    end;
  until (NormalError<eps)or(iIteration>=ni);
  /////////////////
  Residual_X:=nil;
  Residual_Y:=nil;
  Residual_Z:=nil;
  Direction_X:=nil;
  Direction_Y:=nil;
  Direction_Z:=nil;
  DirectionNew_X:=nil;
  DirectionNew_Y:=nil;
  DirectionNew_Z:=nil;
  zrX:=nil;
  zrY:=nil;
  zrZ:=nil;
  ////////////////////
  { Erasing matrix and right side }
  RealMatrix_X:=nil;
  RealMatrix_Y:=nil;
  RealMatrix_Z:=nil;
//  RightSide_X:=nil;
//  RightSide_Y:=nil;
//  RightSide_Z:=nil;
  NumberConnect:=nil;
  { uniting axial and defect-depending solution }
  a_SaveDataFile('resultx_def.dat',ResX[0],(NPoints+1)*SizeOf(ResX[0]));
  a_SaveDataFile('resulty_def.dat',ResY[0],(NPoints+1)*SizeOf(ResY[0]));
  a_SaveDataFile('resultz_def.dat',ResZ[0],(NPoints+1)*SizeOf(ResZ[0]));
  a_SaveDataFile('resultx_ax.dat',Result_X_app[0],(NPoints+1)*SizeOf(Result_X_app[0]));
  a_SaveDataFile('resulty_ax.dat',Result_Y_app[0],(NPoints+1)*SizeOf(Result_Y_app[0]));
  a_SaveDataFile('resultz_ax.dat',Result_Z_app[0],(NPoints+1)*SizeOf(Result_Z_app[0]));
  for i:=1 to NPoints do
  begin
    ResX[i]:=ResX[i]+Result_X_app[i];
    ResY[i]:=ResY[i]+Result_Y_app[i];
    ResZ[i]:=ResZ[i]+Result_Z_app[i];
  end;
  { saving results to file }
  a_SaveDataFile('resultx.dat',ResX[0],(NPoints+1)*SizeOf(ResX[0]));
  a_SaveDataFile('resulty.dat',ResY[0],(NPoints+1)*SizeOf(ResY[0]));
  a_SaveDataFile('resultz.dat',ResZ[0],(NPoints+1)*SizeOf(ResZ[0]));
  Result:=NormalError;
  ///////////////////////////////////////////////////////////////////////
  Result_X_app:=nil;
  Result_Y_app:=nil;
  Result_Z_app:=nil;
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
  iDefect:=0;
  NDefects:=0;
  NumberDefect:=nil;
  PropertyDefect:=nil;
  SigmaDefect:=nil;
end;

{==============================================================================}

{==============================================================================}
procedure TApproximateSolution.PrepareDataEC(iMat:int);
var
  i:int;
  mDef,m:int;
begin
  if nds then
  begin
    lb.Caption:='Preparing defect data ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  { loading existing data from axial solution }
  Result_Xc_app:=nil;
  Result_Yc_app:=nil;
  Result_Zc_app:=nil;
  SetLength(Result_Xc_app,NPoints+1);
  SetLength(Result_Yc_app,NPoints+1);
  SetLength(Result_Zc_app,NPoints+1);
  a_LoadDataFile('cresultx.dat',Result_Xc_app[0],(NPoints+1)*SizeOf(Result_Xc_app[0]));
  a_LoadDataFile('cresulty.dat',Result_Yc_app[0],(NPoints+1)*SizeOf(Result_Yc_app[0]));
  a_LoadDataFile('cresultz.dat',Result_Zc_app[0],(NPoints+1)*SizeOf(Result_Zc_app[0]));
  { finding defect material }
  mDef:=mt.DefaultMaterial;
  for i:=0 to mt.NMaterials-1 do if LowerCase(mt.mmName[i])='defect' then mDef:=i;
  { defining defect properties }
  NDefects:=0;
  for i:=1 to NElements do
  begin
    m:=ATopology[i][0];
    if m=mDef then
    begin
      NDefects:=NDefects+1;
      SetLength(NumberDefect,NDefects+1);
      SetLength(PropertyDefect,NDefects+1);
      SetLength(SigmaDefect,NDefects+1);
      NumberDefect[NDefects]:=i;
      PropertyDefect[Ndefects]:=mt.VecProperty[iMat];
      SigmaDefect[Ndefects]:=mt.Sigma[iMat];
    end;
    if nds then gg.Progress:=i;
  end;
end;

procedure TApproximateSolution.CreateMatrixEC(dim : int);
const
  MultConst = 1.0E+7;
var
  iNode,jNode,iPoint,iSource,
  jColumn,iConnect,jConnect,iElement,
  NConnects,iBound,Mult : int;
  MultImagine : Real;
  NewConnectAllowed: boolean;
  Var_X,Var_Y,Var_Z : TComplex;
  i : int;
  f:boolean;
  qq:int;
  iMaterial:int;
begin
  {Обнуление коэффициентов глобальной матрицы и правой части}
  SetLength(RightSide_Xc,NPoints+1);
  SetLength(RightSide_Yc,NPoints+1);
  SetLength(RightSide_Zc,NPoints+1);
  { displaying operations }
  if nds then
  begin
    lb.Caption:='Initializing matrix ...';
    ggb.Refresh;
    gg.MaxValue:=NPoints;
  end;
  /////////////////////////////////
  SetLength(NumberConnect,NPOints+1);
  ///////////
  case dim of
    0: SetLength(ComplexMatrix_X,nPoints+1);
    1: SetLength(ComplexMatrix_Y,nPoints+1);
    2: SetLength(ComplexMatrix_Z,nPoints+1);
  end;
  ////////////
  for iPoint:=1 to NPoints do
  begin
    case dim of
      0: RightSide_Xc[iPoint]:=CNull;
      1: RightSide_Yc[iPoint]:=CNull;
      2: RightSide_Zc[iPoint]:=CNull;
    end;
    ////////////
    case dim of
      0: SetLength(ComplexMatrix_X[iPoint],4);
      1: SetLength(ComplexMatrix_Y[iPoint],4);
      2: SetLength(ComplexMatrix_Z[iPoint],4);
    end;
    SetLength(NumberConnect[iPoint],2);
    ///////////////////////////
    NumberConnect[iPoint,1]:=1;
    for iConnect:=1 to 3 do
    begin
      case dim of
        0: ComplexMatrix_X[iPoint,iConnect]:=CNull;
        1: ComplexMatrix_Y[iPoint,iConnect]:=CNull;
        2: ComplexMatrix_Z[iPoint,iConnect]:=CNull;
      end;
    end; {  for iConnect  }
    if ((iPoint mod 200)=0) and nds then gg.Progress:=iPoint;
  end;  {  for iPoint  }
  if nds then
  begin
    lb.Caption:='Creating matrix ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  ///////////
  iDefect:=1;
  qq:=Round(NElements/150);
  for iElement:=1 to NElements do
  begin
    f:=false;
    ElementMatrix3(iElement);
    iMaterial:=Atopology[iElement][0];
    for iNode:=1 to 4 do
    begin
      iPoint:=ATopology[iElement][iNode];
      NConnects:=NumberConnect[iPoint,1];
      for jNode:=1 to 4 do
      begin
        jColumn:=ATopology[iElement][jNode];
        NewConnectAllowed:=true;
        if iNode=jNode then
        begin
          case dim of
            0: ComplexMatrix_X[iPoint,1]:=CAdd(ComplexMatrix_X[iPoint,1],
               CConv(mt.VecProperty[iMaterial]*(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]
               +d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
            1: ComplexMatrix_Y[iPoint,2]:=CAdd(ComplexMatrix_Y[iPoint,2],
               CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]
               +d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
            2: ComplexMatrix_Z[iPoint,3]:=CAdd(ComplexMatrix_Z[iPoint,3],
               CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]
               +c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
          end;
          case dim of
            0: begin
              ComplexMatrix_X[iPoint,2]:=CAdd(ComplexMatrix_X[iPoint,2],
              CConv(-mt.VecProperty[iMaterial]*(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0));
              ComplexMatrix_X[iPoint,3]:=CAdd(ComplexMatrix_X[iPoint,3],
              CConv(-mt.VecProperty[iMaterial]*(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
            end;
            1: begin
              ComplexMatrix_Y[iPoint,1]:=CAdd(ComplexMatrix_Y[iPoint,1],
              CConv(-mt.VecProperty[iMaterial]*(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0));
              ComplexMatrix_Y[iPoint,3]:=CAdd(ComplexMatrix_Y[iPoint,3],
              CConv(-mt.VecProperty[iMaterial]*(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
            end;
            2: begin
              ComplexMatrix_Z[iPoint,1]:=CAdd(ComplexMatrix_Z[iPoint,1],
              CConv(-mt.VecProperty[iMaterial]*(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
              ComplexMatrix_Z[iPoint,2]:=CAdd(ComplexMatrix_Z[iPoint,2],
              CConv(-mt.VecProperty[iMaterial]*(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
            end;
          end;
          {Consideration of 'Defect' Elements with NonUniform Property  }
          if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
          begin
            f:=true;
            case dim of
              0: RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                 CMul(Result_Xc_app[iPoint],
                 CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                 *(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]
                 +d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
              1: RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                 CMul(Result_Yc_app[iPoint],
                 CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                 *(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]
                 +d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
              2: RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                 CMul(Result_Zc_app[iPoint],
                 CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                 *(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]
                 +c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
            end;
            case dim of
              0: begin
                RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                CMul(Result_Yc_app[iPoint],
                CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0)));
                RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                CMul(Result_Zc_app[iPoint],
                CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
              end;
              1: begin
                RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                CMul(Result_Xc_app[iPoint],
                CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0)));
                RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                CMul(Result_Zc_app[iPoint],
                CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
              end;
              2: begin
                RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                CMul(Result_Xc_app[iPoint],
                CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                CMul(Result_Yc_app[iPoint],
                CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                *(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
              end;
            end;
          end;  { if iDefect }
          Mult:=2;   {  if iNode=jNode  !!!  }
          MultImagine:=Mult*2*pi*mt.Frequency*mt.Sigma[iMaterial];
          case dim of
            0: ComplexMatrix_X[iPoint,1]:=CAdd(ComplexMatrix_X[iPoint,1],
                                 CDConv(0,MultImagine*Volume/20.0));
            1: ComplexMatrix_Y[iPoint,2]:=CAdd(ComplexMatrix_Y[iPoint,2],
                                 CDConv(0,MultImagine*Volume/20.0));
            2: ComplexMatrix_Z[iPoint,3]:=CAdd(ComplexMatrix_Z[iPoint,3],
                                 CDConv(0,MultImagine*Volume/20.0))
          end;
          {Consideration of 'Defect' Elements with NonUniform Property  }
          if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
          begin
            f:=true;
            Mult:=2;   {  if iNode=jNode  !!!  }
            MultImagine:=Mult*2*pi*mt.Frequency;
            case dim of
              0: RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                 CMul(Result_Xc_app[iPoint],
                 CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                 *MultImagine*Volume/20.0)));
              1: RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                 CMul(Result_Yc_app[iPoint],
                 CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                 *MultImagine*Volume/20.0)));
              2: RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                 CMul(Result_Zc_app[iPoint],
                 CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                 *MultImagine*Volume/20.0)));
            end;
          end;  { if iDefect }
        end
        else
        begin
          if NConnects > 1 then
          begin
            for iConnect:=2 to NConnects do
            begin
              if jColumn=NumberConnect[iPoint,iConnect] then
              begin
                jConnect:=3*iConnect-2;
                case dim of
                  0: ComplexMatrix_X[iPoint,jConnect]:=CAdd(ComplexMatrix_X[iPoint,jConnect],
                     CConv(mt.VecProperty[iMaterial]*(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                     d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
                  1: ComplexMatrix_Y[iPoint,jConnect+1]:=CAdd(ComplexMatrix_Y[iPoint,jConnect+1],
                     CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                     d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
                  2: ComplexMatrix_Z[iPoint,jConnect+2]:=CAdd(ComplexMatrix_Z[iPoint,jConnect+2],
                     CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                     c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
                end;
                case dim of
                  0: begin
                    ComplexMatrix_X[iPoint,jConnect+1]:=CAdd(ComplexMatrix_X[iPoint,jConnect+1],
                    CConv(-mt.VecProperty[iMaterial]*(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0));
                    ComplexMatrix_X[iPoint,jConnect+2]:=CAdd(ComplexMatrix_X[iPoint,jConnect+2],
                    CConv(-mt.VecProperty[iMaterial]*(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
                  end;
                  1: begin
                    ComplexMatrix_Y[iPoint,jConnect]:=CAdd(ComplexMatrix_Y[iPoint,jConnect],
                    CConv(-mt.VecProperty[iMaterial]*(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0));
                    ComplexMatrix_Y[iPoint,jConnect+2]:=CAdd(ComplexMatrix_Y[iPoint,jConnect+2],
                    CConv(-mt.VecProperty[iMaterial]*(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
                  end;
                  2: begin
                    ComplexMatrix_Z[iPoint,jConnect]:=CAdd(ComplexMatrix_Z[iPoint,jConnect],
                    CConv(-mt.VecProperty[iMaterial]*(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
                    ComplexMatrix_Z[iPoint,jConnect+1]:=CAdd(ComplexMatrix_Z[iPoint,jConnect+1],
                    CConv(-mt.VecProperty[iMaterial]*(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
                  end;
                end;
                {Consideration of 'Defect' Elements with NonUniform Property  }
                if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
                begin
                  f:=true;
                  case dim of
                    0: RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                       CMul(Result_Xc_app[jColumn],
                       CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                       d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                    1: RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                       CMul(Result_Yc_app[jColumn],
                       CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                       d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                    2: RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                       CMul(Result_Zc_app[jColumn],
                       CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                       c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                  end;
                  case dim of
                    0: begin
                       RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                       CMul(Result_Yc_app[jColumn],
                       CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0)));
                       RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                       CMul(Result_Zc_app[jColumn],
                       CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                       end;
                    1: begin
                       RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                       CMul(Result_Xc_app[jColumn],
                       CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0)));
                       RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                       CMul(Result_Zc_app[jColumn],
                       CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                       end;
                    2: begin
                       RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                       CMul(Result_Xc_app[jColumn],
                       CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                       RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                       CMul(Result_Yc_app[jColumn],
                       CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                       *(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                       end;
                  end;
                end;  { if iDefect }
                Mult:=1;  {  iNode <> jNode  }
                MultImagine:=Mult*2*pi*mt.Frequency*mt.Sigma[iMaterial];
                case dim of
                  0: ComplexMatrix_X[iPoint,jConnect]:=CAdd(ComplexMatrix_X[iPoint,jConnect],
                                       CDConv(0,MultImagine*Volume/20.0));
                  1: ComplexMatrix_Y[iPoint,jConnect+1]:=CAdd(ComplexMatrix_Y[iPoint,jConnect+1],
                                       CDConv(0,MultImagine*Volume/20.0));
                  2: ComplexMatrix_Z[iPoint,jConnect+2]:=CAdd(ComplexMatrix_Z[iPoint,jConnect+2],
                                       CDConv(0,MultImagine*Volume/20.0));
                end;
                {Consideration of 'Defect' Elements with NonUniform Property}
                if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
                begin
                  f:=true;
                  Mult:=1;  {  iNode <> jNode  }
                  MultImagine:=Mult*2*pi*mt.Frequency;
                  case dim of
                  0: RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                     CMul(Result_Xc_app[jColumn],
                     CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                     *MultImagine*Volume/20.0)));
                  1: RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                     CMul(Result_Yc_app[jColumn],
                     CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                     *MultImagine*Volume/20.0)));
                  2: RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                     CMul(Result_Zc_app[jColumn],
                     CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                     *MultImagine*Volume/20.0)));
                  end;
                end;  { if iDefect }
                NewConnectAllowed:=false
              end;
            end;
          end;
          if (NConnects=1) or NewConnectAllowed then
          begin
            inc(NumberConnect[iPoint,1]);
            iConnect:=NumberConnect[iPoint,1];
            jConnect:=3*iConnect-2;
            //////////////////////////////////////////
            SetLength(NumberConnect[iPoint],iConnect+1);
            case dim of
              0: SetLength(ComplexMatrix_X[iPoint],jConnect+3);
              1: SetLength(ComplexMatrix_Y[iPoint],jConnect+3);
              2: SetLength(ComplexMatrix_Z[iPoint],jConnect+3);
            end;
            ////////////////////////////////////////
            NumberConnect[iPoint,iConnect]:=jColumn;
            case dim of
              0: ComplexMatrix_X[iPoint,jConnect]:=CAdd(ComplexMatrix_X[iPoint,jConnect],
                 CConv(mt.VecProperty[iMaterial]*(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                 d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
              1: ComplexMatrix_Y[iPoint,jConnect+1]:=CAdd(ComplexMatrix_Y[iPoint,jConnect+1],
                 CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                 d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
              2: ComplexMatrix_Z[iPoint,jConnect+2]:=CAdd(ComplexMatrix_Z[iPoint,jConnect+2],
                 CConv(mt.VecProperty[iMaterial]*(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                 c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
            end;
            case dim of
              0: begin
                ComplexMatrix_X[iPoint,jConnect+1]:=CAdd(ComplexMatrix_X[iPoint,jConnect+1],
                CConv(-mt.VecProperty[iMaterial]*(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0));
                ComplexMatrix_X[iPoint,jConnect+2]:=CAdd(ComplexMatrix_X[iPoint,jConnect+2],
                CConv(-mt.VecProperty[iMaterial]*(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
              end;
              1: begin
                ComplexMatrix_Y[iPoint,jConnect]:=CAdd(ComplexMatrix_Y[iPoint,jConnect],
                CConv(-mt.VecProperty[iMaterial]*(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0));
                ComplexMatrix_Y[iPoint,jConnect+2]:=CAdd(ComplexMatrix_Y[iPoint,jConnect+2],
                CConv(-mt.VecProperty[iMaterial]*(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
              end;
              2: begin
                ComplexMatrix_Z[iPoint,jConnect]:=CAdd(ComplexMatrix_Z[iPoint,jConnect],
                CConv(-mt.VecProperty[iMaterial]*(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0));
                ComplexMatrix_Z[iPoint,jConnect+1]:=CAdd(ComplexMatrix_Z[iPoint,jConnect+1],
                CConv(-mt.VecProperty[iMaterial]*(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0));
              end;
            end;
            {Consideration of 'Defect' Elements with NonUniform Property}
            if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
            begin
              f:=true;
              case dim of
                0: RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                   CMul(Result_Xc_app[jColumn],
                   CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(c[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial]+
                   d[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                1: RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                   CMul(Result_Yc_app[jColumn],
                   CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(b[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial]+
                   d[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                2: RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                   CMul(Result_Zc_app[jColumn],
                   CConv((PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(b[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial]+
                   c[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
              end;
              case dim of
                0: begin
                   RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                   CMul(Result_Yc_app[jColumn],
                   CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(c[iNode]*b[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0)));
                   RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                   CMul(Result_Zc_app[jColumn],
                   CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(d[iNode]*b[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                   end;
                1: begin
                   RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                   CMul(Result_Xc_app[jColumn],
                   CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(b[iNode]*c[jNode]/mt.Anisotropy_Z[iMaterial])/Volume/36.0)));
                   RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                   CMul(Result_Zc_app[jColumn],
                   CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(d[iNode]*c[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                   end;
                2: begin
                   RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                   CMul(Result_Xc_app[jColumn],
                   CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(b[iNode]*d[jNode]/mt.Anisotropy_Y[iMaterial])/Volume/36.0)));
                   RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                   CMul(Result_Yc_app[jColumn],
                   CConv(-(PropertyDefect[iDefect]-mt.VecProperty[iMaterial])
                   *(c[iNode]*d[jNode]/mt.Anisotropy_X[iMaterial])/Volume/36.0)));
                   end;
              end;
            end;  { if iDefect }
            Mult:=1;  {  iNode <> jNode  }
            MultImagine:=Mult*2*pi*mt.Frequency*mt.Sigma[iMaterial];
            case dim of
              0: ComplexMatrix_X[iPoint,jConnect]:=CAdd(ComplexMatrix_X[iPoint,jConnect],
                                   CDConv(0,MultImagine*Volume/20.0));
              1: ComplexMatrix_Y[iPoint,jConnect+1]:=CAdd(ComplexMatrix_Y[iPoint,jConnect+1],
                                   CDConv(0,MultImagine*Volume/20.0));
              2: ComplexMatrix_Z[iPoint,jConnect+2]:=CAdd(ComplexMatrix_Z[iPoint,jConnect+2],
                                   CDConv(0,MultImagine*Volume/20.0))
            end;
            {Consideration of 'Defect' Elements with NonUniform Property}
            if (iDefect<=NDefects) and (iElement=NumberDefect[iDefect]) then
            begin
              f:=true;
              Mult:=1;  {  iNode <> jNode  }
              MultImagine:=Mult*2*pi*mt.Frequency;
              case dim of
              0: RightSide_Xc[iPoint]:=CAdd(RightSide_Xc[iPoint],
                 CMul(Result_Xc_app[jColumn],
                 CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                 *MultImagine*Volume/20.0)));
              1: RightSide_Yc[iPoint]:=CAdd(RightSide_Yc[iPoint],
                 CMul(Result_Yc_app[jColumn],
                 CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                 *MultImagine*Volume/20.0)));
              2: RightSide_Zc[iPoint]:=CAdd(RightSide_Zc[iPoint],
                 CMul(Result_Zc_app[jColumn],
                 CDConv(0,(SigmaDefect[iDefect]-mt.Sigma[iMaterial])
                 *MultImagine*Volume/20.0)));
              end;
            end;  { if iDefect }
          end;  {  if (NConnects=1) or NewConnectAllowed }
        end;  {  else if iNode=jNode  }
      end;  { for jNode }
    end;  {  for iNode }
    if f then inc(iDefect);
    if ((iElement mod qq)=0)and nds then gg.Progress:=iElement;
  end;   {  for iElement }
  {!!! Normalization  !!!}
{  lb.Caption:='Normalizing matrixes ...';
  ggb.Refresh;
  gg.MaxValue:=NPoints;
  for iPoint:=1 to NPoints do begin
    case dim of
      0: Var_X:=ComplexMatrix_X[iPoint,1];
      1: Var_Y:=ComplexMatrix_Y[iPoint,2];
      2: Var_Z:=ComplexMatrix_Z[iPoint,3];
    end;
    case dim of
      0: RightSide_Xc[iPoint]:=Cdiv(RightSide_Xc[iPoint],Var_X);
      1: RightSide_Yc[iPoint]:=Cdiv(RightSide_Yc[iPoint],Var_Y);
      2: RightSide_Zc[iPoint]:=Cdiv(RightSide_Zc[iPoint],Var_Z);
    end;
    case dim of
      0: begin
        ComplexMatrix_X[iPoint,2]:=
                 CDiv(ComplexMatrix_X[iPoint,2],Var_X);
        ComplexMatrix_X[iPoint,3]:=
                 CDiv(ComplexMatrix_X[iPoint,3],Var_X);
      end;
      1: begin
        ComplexMatrix_Y[iPoint,1]:=
                 CDiv(ComplexMatrix_Y[iPoint,1],Var_Y);
        ComplexMatrix_Y[iPoint,3]:=
                 CDiv(ComplexMatrix_Y[iPoint,3],Var_Y);
      end;
      2: begin
        ComplexMatrix_Z[iPoint,1]:=
                 CDiv(ComplexMatrix_Z[iPoint,1],Var_Z);
        ComplexMatrix_Z[iPoint,2]:=
                 CDiv(ComplexMatrix_Z[iPoint,2],Var_Z);
      end;
    end;
    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do begin
      jConnect:=3*iConnect-2;
      case dim of
        0: begin
          ComplexMatrix_X[iPoint,jConnect]:=
                   CDiv(ComplexMatrix_X[iPoint,jConnect],Var_X);
          ComplexMatrix_X[iPoint,jConnect+1]:=
                   CDiv(ComplexMatrix_X[iPoint,jConnect+1],Var_X);
          ComplexMatrix_X[iPoint,jConnect+2]:=
                   CDiv(ComplexMatrix_X[iPoint,jConnect+2],Var_X);
        end;
        1: begin
          ComplexMatrix_Y[iPoint,jConnect]:=
                   CDiv(ComplexMatrix_Y[iPoint,jConnect],Var_Y);
          ComplexMatrix_Y[iPoint,jConnect+1]:=
                   CDiv(ComplexMatrix_Y[iPoint,jConnect+1],Var_Y);
          ComplexMatrix_Y[iPoint,jConnect+2]:=
                   CDiv(ComplexMatrix_Y[iPoint,jConnect+2],Var_Y);
        end;
        2: begin
          ComplexMatrix_Z[iPoint,jConnect]:=
                   CDiv(ComplexMatrix_Z[iPoint,jConnect],Var_Z);
          ComplexMatrix_Z[iPoint,jConnect+1]:=
                   CDiv(ComplexMatrix_Z[iPoint,jConnect+1],Var_Z);
          ComplexMatrix_Z[iPoint,jConnect+2]:=
                   CDiv(ComplexMatrix_Z[iPoint,jConnect+2],Var_Z);
        end;
      end;
    end;  
    case dim of
      0: ComplexMatrix_X[iPoint,1]:=CDConv(1.0,0.0);
      1: ComplexMatrix_Y[iPoint,2]:=CDConv(1.0,0.0);
      2: ComplexMatrix_Z[iPoint,3]:=CDConv(1.0,0.0);
    end;
    if (iPoint mod 500)=0 then gg.Progress:=iPoint;
  end;  {  for iPoint  }
  {Boundary conditions}
  case dim of
    0: begin
      if nds then
      begin
        lb.Caption:='Applying boundary potentials (X) ...';
        ggb.Refresh;
        gg.MaxValue:=NBounds_X;
      end;
      for iBound:=1 to NBounds_X do begin
        iPoint:=NumberBound_X[iBound];
        {X-component}
        RightSide_Xc[iPoint]:=CMul(ComplexMatrix_X[iPoint,1],CNull
                                   {CConv(PotentialBound_X[iBound])});
        for i:=2 to 3*NumberConnect[iPoint,1] do
          ComplexMatrix_X[iPoint,i]:=CNull;
        if ((iBound mod 100)=0) and nds then gg.Progress:=iBound;
      end;
    end;
    1: begin
      if nds then
      begin
        lb.Caption:='Applying boundary potentials (Y)...';
        ggb.Refresh;
        gg.MaxValue:=NBounds_Y;
      end;
      for iBound:=1 to NBounds_Y do begin
        iPoint:=NumberBound_Y[iBound];
        {Y-component}
        RightSide_Yc[iPoint]:=CMul(ComplexMatrix_Y[iPoint,2],CNull
                                   {CConv(PotentialBound_Y[iBound])});
        ComplexMatrix_Y[iPoint,1]:=CNull;
        for i:=3 to 3*NumberConnect[iPoint,1] do
          ComplexMatrix_Y[iPoint,i]:=CNull;
        if ((iBound mod 100)=0) and nds then gg.Progress:=iBound;
      end;
    end;
    2: begin
      if nds then
      begin
        lb.Caption:='Applying boundary potentials (Z)...';
        ggb.Refresh;
        gg.MaxValue:=NBounds_Z;
      end;
      for iBound:=1 to NBounds_Z do begin
        iPoint:=NumberBound_Z[iBound];
        {Z-component}
        RightSide_Zc[iPoint]:=CMul(ComplexMatrix_Z[iPoint,3],CNull
                                   {CConv(PotentialBound_Z[iBound])});
        ComplexMatrix_Z[iPoint,1]:=CNull;
        ComplexMatrix_Z[iPoint,2]:=CNull;
        for i:=4 to 3*NumberConnect[iPoint,1] do
          ComplexMatrix_Z[iPoint,i]:=CNull;
        if ((iBound mod 100)=0) and nds then gg.Progress:=iBound;
      end  {   for iBound }
    end;
  end;
  if nds then
  begin
    lb.Caption:='Done';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

procedure TApproximateSolution.CreateAllMatrixEC(iMat:int);
var
  dim:int;
begin
  PrepareDataEC(iMat);
  { Place thread code here }
  ComplexMatrix_X:=nil;
  ComplexMatrix_Y:=nil;
  ComplexMatrix_Z:=nil;
  for dim:=0 to 2 do
    CreateMatrixEC(dim);
  if fmMain.N60.Checked then a_SaveRSide3;  
  if fmMain.N61.Checked then a_SaveMatrix3_cx;
end;

function TApproximateSolution.RunSolutionEC(eps:double;ni:int):double;
var
  Error,ErrorCriterion : float;
  Beta,MultResidualNew,MultResidual,MultDirection,Alpha : TComplex;
  i,iPoint,iIteration,
  NConnects,iConnect,jColumn,jConnect : int;
  Var_X,Var_Y,
  Var_Z,Var_Sum  : TComplex;
begin
  /////////////////////////////////
  SetLength(Residual_Xc,NPoints+1);
  SetLength(Residual_Yc,NPoints+1);
  SetLength(Residual_Zc,NPoints+1);
  SetLength(Direction_Xc,NPoints+1);
  SetLength(Direction_Yc,NPoints+1);
  SetLength(Direction_Zc,NPoints+1);
  SetLength(zcx,NPoints+1);
  SetLength(zcy,NPoints+1);
  SetLength(zcz,NPoints+1);
  SetLength(DirectionNew_Xc,NPoints+1);
  SetLength(DirectionNew_Yc,NPoints+1);
  SetLength(DirectionNew_Zc,NPoints+1);
  SetLength(ResXc,NPoints+1);
  SetLength(ResYc,NPoints+1);
  SetLength(ResZc,NPoints+1);
  ///////////////////////////////
  for iPoint:=1 to NPoints do
  begin
    ResXc[iPoint]:=CDiv(RightSide_Xc[iPoint],ComplexMatrix_X[iPoint,1]);
    ResYc[iPoint]:=CDiv(RightSide_Yc[iPoint],ComplexMatrix_Y[iPoint,2]);
    ResZc[iPoint]:=CDiv(RightSide_Zc[iPoint],ComplexMatrix_Z[iPoint,3]);
  end;  {  for iPoint  }
  for iPoint:=1 to NPoints do
  begin
    Var_X:=ResXc[iPoint];
    Var_Y:=ResYc[iPoint];
    Var_Z:=ResZc[iPoint];

    Var_Sum:=CAdd(CMul(ComplexMatrix_X[iPoint,1],Var_X),
                  CMul(ComplexMatrix_X[iPoint,2],Var_Y));
    Var_Sum:=CAdd(Var_Sum,CMul(ComplexMatrix_X[iPoint,3],Var_Z));
    Residual_Xc[iPoint]:=CSub(RightSide_Xc[iPoint],Var_Sum);

    Var_Sum:=CAdd(CMul(ComplexMatrix_Y[iPoint,1],Var_X),
                  CMul(ComplexMatrix_Y[iPoint,2],Var_Y));
    Var_Sum:=CAdd(Var_Sum,CMul(ComplexMatrix_Y[iPoint,3],Var_Z));
    Residual_Yc[iPoint]:=CSub(RightSide_Yc[iPoint],Var_Sum);

    Var_Sum:=CAdd(CMul(ComplexMatrix_Z[iPoint,1],Var_X),
                  CMul(ComplexMatrix_Z[iPoint,2],Var_Y));
    Var_Sum:=CAdd(Var_Sum,CMul(ComplexMatrix_Z[iPoint,3],Var_Z));
    Residual_Zc[iPoint]:=CSub(RightSide_Zc[iPoint],Var_Sum);

    NConnects:=NumberConnect[iPoint,1];
    for iConnect:=2 to NConnects do
    begin
      jColumn:=NumberConnect[iPoint,iConnect];
      jConnect:=3*iConnect-2;
      Var_X:=ResXc[jColumn];
      Var_Y:=ResYc[jColumn];
      Var_Z:=ResZc[jColumn];
      Var_Sum:=CAdd(CMul(ComplexMatrix_X[iPoint,jConnect],Var_X),
                    CMul(ComplexMatrix_X[iPoint,jConnect+1],Var_Y));
      Var_Sum:=CAdd(Var_Sum,CMul(ComplexMatrix_X[iPoint,jConnect+2],Var_Z));
      Residual_Xc[iPoint]:=CSub(Residual_Xc[iPoint],Var_Sum);
      Var_Sum:=CAdd(CMul(ComplexMatrix_Y[iPoint,jConnect],Var_X),
                    CMul(ComplexMatrix_Y[iPoint,jConnect+1],Var_Y));
      Var_Sum:=CAdd(Var_Sum,CMul(ComplexMatrix_Y[iPoint,jConnect+2],Var_Z));
      Residual_Yc[iPoint]:=CSub(Residual_Yc[iPoint],Var_Sum);
      Var_Sum:=CAdd(CMul(ComplexMatrix_Z[iPoint,jConnect],Var_X),
                    CMul(ComplexMatrix_Z[iPoint,jConnect+1],Var_Y));
      Var_Sum:=CAdd(Var_Sum,CMul(ComplexMatrix_Z[iPoint,jConnect+2],Var_Z));
      Residual_Zc[iPoint]:=CSub(Residual_Zc[iPoint],Var_Sum);
    end;  {  for iConnect    }
  end;  {  for iPoint  }
  for iPoint:=1 to NPoints do
    if ps.wSMeth_d=1 then
    begin
      zcx[iPoint]:=CDiv(Residual_Xc[iPoint],ComplexMatrix_X[iPoint,1]);
      zcy[iPoint]:=CDiv(Residual_Yc[iPoint],ComplexMatrix_Y[iPoint,2]);
      zcz[iPoint]:=CDiv(Residual_Zc[iPoint],ComplexMatrix_Z[iPoint,3]);
    end
    else
    begin
      zcx[iPoint]:=Residual_Xc[iPoint];
      zcy[iPoint]:=Residual_Yc[iPoint];
      zcz[iPoint]:=Residual_Zc[iPoint];
    end;
  ErrorCriterion:=0.0;
  for iPoint:=1 to NPoints do begin
    Direction_Xc[iPoint]:=zcx[iPoint];
    Direction_Yc[iPoint]:=zcy[iPoint];
    Direction_Zc[iPoint]:=zcz[iPoint];
    if NSources=0 then begin
      ErrorCriterion:=ErrorCriterion+Sqr(CAbs(Residual_Xc[iPoint]));
      ErrorCriterion:=ErrorCriterion+Sqr(CAbs(Residual_Yc[iPoint]));
      ErrorCriterion:=ErrorCriterion+Sqr(CAbs(Residual_Zc[iPoint]))
    end else begin
      ErrorCriterion:=ErrorCriterion+Sqr(CAbs(RightSide_Xc[iPoint]));
      ErrorCriterion:=ErrorCriterion+Sqr(CAbs(RightSide_Yc[iPoint]));
      ErrorCriterion:=ErrorCriterion+Sqr(CAbs(RightSide_Zc[iPoint]))
    end
  end;  {  for iPoint  }
  if NSources=0 then ErrorCriterion:=Eps*ErrorCriterion;
  iIteration:=0;
  repeat
    for iPoint:=1 to NPoints do begin
      DirectionNew_Xc[iPoint]:=CNull;
      DirectionNew_Yc[iPoint]:=CNull;
      DirectionNew_Zc[iPoint]:=CNull;
      DirectionNew_Xc[iPoint]:=CAdd(DirectionNew_Xc[iPoint],
                               CMul(ComplexMatrix_X[iPoint,1],
                               Direction_Xc[iPoint]));
      DirectionNew_Xc[iPoint]:=CAdd(DirectionNew_Xc[iPoint],
                               CMul(ComplexMatrix_X[iPoint,2],
                               Direction_Yc[iPoint]));
      DirectionNew_Xc[iPoint]:=CAdd(DirectionNew_Xc[iPoint],
                               CMul(ComplexMatrix_X[iPoint,3],
                               Direction_Zc[iPoint]));
      DirectionNew_Yc[iPoint]:=CAdd(DirectionNew_Yc[iPoint],
                               CMul(ComplexMatrix_Y[iPoint,1],
                               Direction_Xc[iPoint]));
      DirectionNew_Yc[iPoint]:=CAdd(DirectionNew_Yc[iPoint],
                               CMul(ComplexMatrix_Y[iPoint,2],
                               Direction_Yc[iPoint]));
      DirectionNew_Yc[iPoint]:=CAdd(DirectionNew_Yc[iPoint],
                               CMul(ComplexMatrix_Y[iPoint,3],
                               Direction_Zc[iPoint]));
      DirectionNew_Zc[iPoint]:=CAdd(DirectionNew_Zc[iPoint],
                               CMul(ComplexMatrix_Z[iPoint,1],
                               Direction_Xc[iPoint]));
      DirectionNew_Zc[iPoint]:=CAdd(DirectionNew_Zc[iPoint],
                               CMul(ComplexMatrix_Z[iPoint,2],
                               Direction_Yc[iPoint]));
      DirectionNew_Zc[iPoint]:=CAdd(DirectionNew_Zc[iPoint],
                               CMul(ComplexMatrix_Z[iPoint,3],
                               Direction_Zc[iPoint]));
      NConnects:=NumberConnect[iPoint,1];
      for iConnect:=2 to NConnects do begin
        jColumn:=NumberConnect[iPoint,iConnect];
        jConnect:=3*iConnect-2;
        DirectionNew_Xc[iPoint]:=CAdd(DirectionNew_Xc[iPoint],
                                 CMul(ComplexMatrix_X[iPoint,jConnect],
                                 Direction_Xc[jColumn]));
        DirectionNew_Xc[iPoint]:=CAdd(DirectionNew_Xc[iPoint],
                                 CMul(ComplexMatrix_X[iPoint,jConnect+1],
                                 Direction_Yc[jColumn]));
        DirectionNew_Xc[iPoint]:=CAdd(DirectionNew_Xc[iPoint],
                                 CMul(ComplexMatrix_X[iPoint,jConnect+2],
                                 Direction_Zc[jColumn]));
        DirectionNew_Yc[iPoint]:=CAdd(DirectionNew_Yc[iPoint],
                                 CMul(ComplexMatrix_Y[iPoint,jConnect],
                                 Direction_Xc[jColumn]));
        DirectionNew_Yc[iPoint]:=CAdd(DirectionNew_Yc[iPoint],
                                 CMul(ComplexMatrix_Y[iPoint,jConnect+1],
                                 Direction_Yc[jColumn]));
        DirectionNew_Yc[iPoint]:=CAdd(DirectionNew_Yc[iPoint],
                                 CMul(ComplexMatrix_Y[iPoint,jConnect+2],
                                 Direction_Zc[jColumn]));
        DirectionNew_Zc[iPoint]:=CAdd(DirectionNew_Zc[iPoint],
                                 CMul(ComplexMatrix_Z[iPoint,jConnect],
                                 Direction_Xc[jColumn]));
        DirectionNew_Zc[iPoint]:=CAdd(DirectionNew_Zc[iPoint],
                                 CMul(ComplexMatrix_Z[iPoint,jConnect+1],
                                 Direction_Yc[jColumn]));
        DirectionNew_Zc[iPoint]:=CAdd(DirectionNew_Zc[iPoint],
                                 CMul(ComplexMatrix_Z[iPoint,jConnect+2],
                                 Direction_Zc[jColumn]))
      end  {  for iConnect    }
    end; { if iPoint <= NPoints }
    MultResidual:=CNull;
    MultDirection:=CNull;
    for iPoint:=1 to NPoints do begin
      MultResidual:=CAdd(MultResidual,CMul(Residual_Xc[iPoint],zcx[iPoint]));
      MultResidual:=CAdd(MultResidual,CMul(Residual_Yc[iPoint],zcy[iPoint]));
      MultResidual:=CAdd(MultResidual,CMul(Residual_Zc[iPoint],zcz[iPoint]));
      MultDirection:=CAdd(MultDirection, CMul(Direction_Xc[iPoint],DirectionNew_Xc[iPoint]));
      MultDirection:=CAdd(MultDirection, CMul(Direction_Yc[iPoint],DirectionNew_Yc[iPoint]));
      MultDirection:=CAdd(MultDirection, CMul(Direction_Zc[iPoint],DirectionNew_Zc[iPoint]))
    end;  {  for iPoint  }
    Alpha:=CDiv(MultResidual,MultDirection);
    for iPoint:=1 to NPoints do begin
      ResXc[iPoint]:=CAdd(ResXc[iPoint], CMul(Alpha,Direction_Xc[iPoint]));
      ResYc[iPoint]:=CAdd(ResYc[iPoint], CMul(Alpha,Direction_Yc[iPoint]));
      ResZc[iPoint]:=CAdd(ResZc[iPoint], CMul(Alpha,Direction_Zc[iPoint]));
      Residual_Xc[iPoint]:=CSub(Residual_Xc[iPoint], CMul(Alpha,DirectionNew_Xc[iPoint]));
      Residual_Yc[iPoint]:=CSub(Residual_Yc[iPoint], CMul(Alpha,DirectionNew_Yc[iPoint]));
      Residual_Zc[iPoint]:=CSub(Residual_Zc[iPoint], CMul(Alpha,DirectionNew_Zc[iPoint]));
    end;  {  for iPoint  }
    for iPoint:=1 to NPoints do
      if ps.wSMeth_d=1 then
      begin
        zcx[iPoint]:=CDiv(Residual_Xc[iPoint],ComplexMatrix_X[iPoint,1]);
        zcy[iPoint]:=CDiv(Residual_Yc[iPoint],ComplexMatrix_Y[iPoint,2]);
        zcz[iPoint]:=CDiv(Residual_Zc[iPoint],ComplexMatrix_Z[iPoint,3]);
      end
      else
      begin
        zcx[iPoint]:=Residual_Xc[iPoint];
        zcy[iPoint]:=Residual_Yc[iPoint];
        zcz[iPoint]:=Residual_Zc[iPoint];
      end;
    MultResidualNew:=CNull;
    for iPoint:=1 to NPoints do
    begin
      MultResidualNew:=CAdd(MultResidualNew, CMul(Residual_Xc[iPoint], zcx[iPoint]));
      MultResidualNew:=CAdd(MultResidualNew, CMul(Residual_Yc[iPoint], zcy[iPoint]));
      MultResidualNew:=CAdd(MultResidualNew, CMul(Residual_Zc[iPoint], zcz[iPoint]));
    end;  {  for iPoint  }
    Beta:=CDiv(MultResidualNew,MultResidual);
    for iPoint:=1 to NPoints do begin
      Direction_Xc[iPoint]:=CAdd(zcx[iPoint],CMul(Beta,Direction_Xc[iPoint]));
      Direction_Yc[iPoint]:=CAdd(zcy[iPoint],CMul(Beta,Direction_Yc[iPoint]));
      Direction_Zc[iPoint]:=CAdd(zcz[iPoint],CMul(Beta,Direction_Zc[iPoint]))
    end;  {  for iPoint  }
    inc(iIteration);

    Error:=0.0;
    for iPoint:=1 to NPoints do begin
      Error:=Error+Sqr(CAbs(Residual_Xc[iPoint]));
      Error:=Error+Sqr(CAbs(Residual_Yc[iPoint]));
      Error:=Error+Sqr(CAbs(Residual_Zc[iPoint]))
    end;  {  for iPoint  }

    { need to change }
    if ErrorCriterion=0.0 then ErrorCriterion:=1e-20;

    if nSources>0 then Error:=Error/ErrorCriterion;
    //////////////////////////////////////
    if nds then
    begin
      fmSolver3d.eError.Text:=FloatToStrF(Error,ffGeneral,10,1);
      fmSolver3d.eError.Refresh;
      fmSolver3d.eIter.Text:=IntToStr(iIteration);
      fmSolver3d.eIter.Refresh;
      Series1.AddXY(iIteration,Error);
      Chart1.Refresh;
    end;
  until (Error<eps)or(iIteration>ni);
  /////////////////
  Residual_Xc:=nil;
  Residual_Yc:=nil;
  Residual_Zc:=nil;
  Direction_Xc:=nil;
  Direction_Yc:=nil;
  Direction_Zc:=nil;
  DirectionNew_Xc:=nil;
  DirectionNew_Yc:=nil;
  DirectionNew_Zc:=nil;
  zcx:=nil;
  zcy:=nil;
  zcz:=nil;
  ////////////////////
  { Erasing matrix and right side }
  ComplexMatrix_X:=nil;
  ComplexMatrix_Y:=nil;
  ComplexMatrix_Z:=nil;
  RightSide_Xc:=nil;
  RightSide_Yc:=nil;
  RightSide_Zc:=nil;
  NumberConnect:=nil;
  { uniting axial and defect-depending solution }
  a_SaveDataFile('cresultx_def.dat',ResXc[0],(NPoints+1)*SizeOf(ResXc[0]));
  a_SaveDataFile('cresulty_def.dat',ResYc[0],(NPoints+1)*SizeOf(ResYc[0]));
  a_SaveDataFile('cresultz_def.dat',ResZc[0],(NPoints+1)*SizeOf(ResZc[0]));
  a_SaveDataFile('cresultx_ax.dat',Result_Xc_app[0],(NPoints+1)*SizeOf(Result_Xc_app[0]));
  a_SaveDataFile('cresulty_ax.dat',Result_Yc_app[0],(NPoints+1)*SizeOf(Result_Yc_app[0]));
  a_SaveDataFile('cresultz_ax.dat',Result_Zc_app[0],(NPoints+1)*SizeOf(Result_Zc_app[0]));
  for i:=1 to NPoints do
  begin
    ResXc[i]:=CAdd(ResXc[i],Result_Xc_app[i]);
    ResYc[i]:=CAdd(ResYc[i],Result_Yc_app[i]);
    ResZc[i]:=CAdd(ResZc[i],Result_Zc_app[i]);
  end;
  { saving results to file }
  a_SaveDataFile('cresultx.dat',ResXc[0],(NPoints+1)*SizeOf(ResXc[0]));
  a_SaveDataFile('cresulty.dat',ResYc[0],(NPoints+1)*SizeOf(ResYc[0]));
  a_SaveDataFile('cresultz.dat',ResZc[0],(NPoints+1)*SizeOf(ResZc[0]));
  Result:=Error;
  ///////////////////////////////////////////////////////////////////////
  Result_Xc_app:=nil;
  Result_Yc_app:=nil;
  Result_Zc_app:=nil;
  ResXc:=nil;
  ResYc:=nil;
  ResZc:=nil;
  iDefect:=0;
  NDefects:=0;
  NumberDefect:=nil;
  PropertyDefect:=nil;
  SigmaDefect:=nil;
end;



{==============================================================================}
{============================= END OF CLASSES =================================}
{==============================================================================}
end.

