unit nonline2d;

interface

uses solve3d,
  ComVars, SysUtils, complx, cm_ini, cmVars, cmData;

type
  TSolutionNL=class
  protected
    a,b,c,d:mxtyp3;
    Volume:float;
    function Determinant(a1,b1,c1, a2,b2,c2, a3,b3,c3 : float) : float;
    procedure ElementMatrix3(iElement:Int);
  public
    //////////
    procedure CreateMatrixRE(dim : int);
    procedure CreateAllMatrixRE;
    function RunSolutionRE(eps:double;ni:int):double;
    /////////
    procedure CreateMatrix;
    function RunSolution(eps:double;ni:int):double;
    /////////
  end;

implementation

uses main, axu_3;

function TSolutionNL.Determinant(a1,b1,c1, a2,b2,c2, a3,b3,c3 : float) : float;
begin
  Result:=a1*(b2*c3-c2*b3)-b1*(a2*c3-c2*a3)+c1*(a2*b3-b2*a3)
end;

procedure TSolutionNL.ElementMatrix3(iElement:Int);
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

procedure TSolutionNL.CreateAllMatrixRE;
var
  dim: int;
begin
  { Place thread code here }
  RealMatrix_X:=nil;
  RealMatrix_Y:=nil;
  RealMatrix_Z:=nil;
  for dim:=0 to 2 do
    CreateMatrixRE(dim);
end;

procedure TSolutionNL.CreateMatrixRe(dim : int);
var
  Mult:double;
  MultRowX,MultRowY,MultRowZ,MultColumnX,MultColumnY,MultColumnZ : float;
  iiNode,iiPoint,jjNode,jjColumn,i : Int;
  m1,m2b:float;
  iPoint,iConnect,iElement:int;
  iSource,iMagnet,iMaterial:int;
  iBound,iNode,jNode,NConnects,jColumn,jConnect:int;
  NewConnectAllowed:boolean;
begin
  {Обнуление коэффициентов глобальной матрицы и правой части}
  SetLength(RightSide_X,NPoints+1);
  SetLength(RightSide_Y,NPoints+1);
  SetLength(RightSide_Z,NPoints+1);
  //////////////////////////////////////
  SetLength(NumberConnect,NPOints+1);
  case dim of
    0: SetLength(RealMatrix_X,nPoints+1);
    1: SetLength(RealMatrix_Y,nPoints+1);
    2: SetLength(RealMatrix_Z,nPoints+1);
  end;
  ///////////////////////////////////////
  for iPoint:=1 to NPoints do
  begin
    case dim of
      0: RightSide_X[iPoint]:=0.0;
      1: RightSide_Y[iPoint]:=0.0;
      2: RightSide_Z[iPoint]:=0.0;
    end;
    ///////////////////////////////////
    SetLength(NumberConnect[iPoint],2);
    case dim of
      0: SetLength(RealMatrix_X[iPoint],4);
      1: SetLength(RealMatrix_Y[iPoint],4);
      2: SetLength(RealMatrix_Z[iPoint],4);
    end;
    ///////////////////////////////////
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
        2: RealMatrix_Z[iPoint,iConnect]:=0.0
      end
    end; {  for iConnect  }
  end;  {  for iPoint  }
  { Просмотр всех тетраэдров по порядку (по номеру iElement)  }
  iSource:=1;
  iMagnet:=1;
  for iElement:=1 to NElements do
  begin
    ElementMatrix3(iElement);
    iMaterial:=ATopology[iElement][0];
    m1:=mt.Prop(iElement,iMaterial);
    if m1>1e25 then m1:=1e20;
    m2b:=mt.dMuH2(iElement,iMaterial);
    if m2b>1e25 then m2b:=1e25;
    Mult:=2*m2b/(36*36*Volume*Volume*Volume);
    { Просмотр вершин тетраэдра - определение номера строки матрицы }
    for iNode:=1 to 4 do
    begin
      iPoint:=ATopology[iElement][iNode];
      NConnects:=NumberConnect[iPoint,1];
      { Заполнение правой части - для элементов с источниками поля - плотностью тока }
      if (iSource<=NSources) and (iElement=NumberSource[iSource]) then
      begin
        case dim of
          0: RightSide_X[iPoint]:=RightSide_X[iPoint]+0.25*Source_X[iSource]*Volume;
          1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]+0.25*Source_Y[iSource]*Volume;
          2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]+0.25*Source_Z[iSource]*Volume;
        end;
        if iNode=4 then inc(iSource)
      end; {  if iElement  }
      { Заполнение правой части - для элементов с источниками поля - остаточной индукцией }
      if (iMagnet<=NMagnets) and (iElement=NumberMagnet[iMagnet]) then
      begin
        case dim of
          0: RightSide_X[iPoint]:=RightSide_X[iPoint]+m1/6*(Magnet_Y[iMagnet]*d[iNode]-Magnet_Z[iMagnet]*c[iNode]);
          1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]+m1/6*(Magnet_Z[iMagnet]*b[iNode]-Magnet_X[iMagnet]*d[iNode]);
          2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]+m1/6*(Magnet_X[iMagnet]*c[iNode]-Magnet_Y[iMagnet]*b[iNode]);
        end;
        if iNode=4 then inc(iMagnet)
      end; {  if iElement  }
      { !!!! Расчет множителя от точки наблюдения - по номеру строки  }
      MultRowX:=0;  MultRowY:=0;  MultRowZ:=0;
      for iiNode:=1 to 4 do
      begin
        iiPoint:=ATopology[iElement][iiNode];
        case dim of
          0: MultRowX:=MultRowX+vmx[iiPoint]*(d[iiNode]*d[iNode]+c[iiNode]*c[iNode])-vmy[iiPoint]*b[iiNode]*c[iNode]-vmz[iiPoint]*b[iiNode]*d[iNode];
          1: MultRowY:=MultRowY+vmy[iiPoint]*(d[iiNode]*d[iNode]+b[iiNode]*b[iNode])-vmx[iiPoint]*c[iiNode]*b[iNode]-vmz[iiPoint]*c[iiNode]*d[iNode];
          2: MultRowZ:=MultRowZ+vmz[iiPoint]*(c[iiNode]*c[iNode]+b[iiNode]*b[iNode])-vmx[iiPoint]*d[iiNode]*b[iNode]-vmy[iiPoint]*d[iiNode]*c[iNode];
        end;
      end;  { for iiNode }
      { Заполнение правой части - расчет вектора-невязки - ошибки }
      case dim of
        0: RightSide_X[iPoint]:=RightSide_X[iPoint]-m1*MultRowX/36.0/Volume;
        1: RightSide_Y[iPoint]:=RightSide_Y[iPoint]-m1*MultRowY/36.0/Volume;
        2: RightSide_Z[iPoint]:=RightSide_Z[iPoint]-m1*MultRowZ/36.0/Volume;
      end;
      { Просмотр вершин тетраэдра - определение номера узла и коэффициента связи }
      for jNode:=1 to 4 do
      begin
        { номер узла связи !!!}
        jColumn:=ATopology[iElement][jNode];
        NewConnectAllowed:=true;
        { Расчет множителя от точки наблюдения - по номеру строки }
        MultColumnX:=0;  MultColumnY:=0;  MultColumnZ:=0;
        {!!!! Нужно формировать эту часть только для нелинейного материала  !!!!}
        for jjNode:=1 to 4 do
        begin
          jjColumn:=ATopology[iElement][jjNode];
          case dim of
            0: MultColumnX:=MultColumnX+vmx[jjColumn]*(d[jjNode]*d[jNode]+c[jjNode]*c[jNode])-vmy[jjColumn]*b[jjNode]*c[jNode]-vmz[jjColumn]*b[jjNode]*d[jNode];
            1: MultColumnY:=MultColumnY+vmy[jjColumn]*(d[jjNode]*d[jNode]+b[jjNode]*b[jNode])-vmx[jjColumn]*c[jjNode]*b[jNode]-vmz[jjColumn]*c[jjNode]*d[jNode];
            2: MultColumnZ:=MultColumnZ+vmz[jjColumn]*(c[jjNode]*c[jNode]+b[jjNode]*b[jNode])-vmx[jjColumn]*d[jjNode]*b[jNode]-vmy[jjColumn]*d[jjNode]*c[jNode];
          end;
        end;  { for jjNode - для НЕлинейного материала }
        { Расчет коэффициентов матрицы Якоби }
        if iNode=jNode then begin   {  диагональный коэффициент !!  }
          case dim of
            0: RealMatrix_X[iPoint,1]:=RealMatrix_X[iPoint,1]+m1*(c[iNode]*c[jNode]+d[iNode]*d[jNode])/Volume/36.0+Mult*MultRowX*MultColumnX;
            1: RealMatrix_Y[iPoint,2]:=RealMatrix_Y[iPoint,2]+m1*(b[iNode]*b[jNode]+d[iNode]*d[jNode])/Volume/36.0+Mult*MultRowY*MultColumnY;
            2: RealMatrix_Z[iPoint,3]:=RealMatrix_Z[iPoint,3]+m1*(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Volume/36.0+Mult*MultRowZ*MultColumnZ;
          end;
          case dim of
            0: begin
              RealMatrix_X[iPoint,2]:=RealMatrix_X[iPoint,2]-m1*(c[iNode]*b[jNode])/Volume/36.0+Mult*MultRowX*MultColumnY;
              RealMatrix_X[iPoint,3]:=RealMatrix_X[iPoint,3]-m1*(d[iNode]*b[jNode])/Volume/36.0+Mult*MultRowX*MultColumnZ;
            end;
            1: begin
              RealMatrix_Y[iPoint,1]:=RealMatrix_Y[iPoint,1]-m1*(b[iNode]*c[jNode])/Volume/36.0+Mult*MultRowY*MultColumnX;
              RealMatrix_Y[iPoint,3]:=RealMatrix_Y[iPoint,3]-m1*(d[iNode]*c[jNode])/Volume/36.0+Mult*MultRowY*MultColumnZ;
            end;
            2: begin
              RealMatrix_Z[iPoint,1]:=RealMatrix_Z[iPoint,1]-m1*(b[iNode]*d[jNode])/Volume/36.0+Mult*MultRowZ*MultColumnX;
              RealMatrix_Z[iPoint,2]:=RealMatrix_Z[iPoint,2]-m1*(c[iNode]*d[jNode])/Volume/36.0+Mult*MultRowZ*MultColumnY;
            end;
          end;
        end
        else
        begin    {  расчет НЕдиагональных коэффициентов матрицы Якоби }
          if NConnects > 1 then
          begin
            for iConnect:=2 to NConnects do
            begin
              if jColumn=NumberConnect[iPoint,iConnect] then
              begin
                jConnect:=3*iConnect-2;
                case dim of
                  0: RealMatrix_X[iPoint,jConnect]  :=RealMatrix_X[iPoint,jConnect]  +m1*(c[iNode]*c[jNode]+d[iNode]*d[jNode])/Volume/36.0+Mult*MultRowX*MultColumnX;
                  1: RealMatrix_Y[iPoint,jConnect+1]:=RealMatrix_Y[iPoint,jConnect+1]+m1*(b[iNode]*b[jNode]+d[iNode]*d[jNode])/Volume/36.0+Mult*MultRowY*MultColumnY;
                  2: RealMatrix_Z[iPoint,jConnect+2]:=RealMatrix_Z[iPoint,jConnect+2]+m1*(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Volume/36.0+Mult*MultRowZ*MultColumnZ;
                end;
                case dim of
                  0: begin
                    RealMatrix_X[iPoint,jConnect+1]:=RealMatrix_X[iPoint,jConnect+1]-m1*(c[iNode]*b[jNode])/Volume/36.0+Mult*MultRowX*MultColumnY;
                    RealMatrix_X[iPoint,jConnect+2]:=RealMatrix_X[iPoint,jConnect+2]-m1*(d[iNode]*b[jNode])/Volume/36.0+Mult*MultRowX*MultColumnZ;
                  end;
                  1: begin
                    RealMatrix_Y[iPoint,jConnect]:=RealMatrix_Y[iPoint,jConnect]-m1*(b[iNode]*c[jNode])/Volume/36.0+Mult*MultRowY*MultColumnX;
                    RealMatrix_Y[iPoint,jConnect+2]:=RealMatrix_Y[iPoint,jConnect+2]-m1*(d[iNode]*c[jNode])/Volume/36.0+Mult*MultRowY*MultColumnZ;
                  end;
                  2: begin
                    RealMatrix_Z[iPoint,jConnect]:=RealMatrix_Z[iPoint,jConnect]-m1*(b[iNode]*d[jNode])/Volume/36.0+Mult*MultRowZ*MultColumnX;
                    RealMatrix_Z[iPoint,jConnect+1]:=RealMatrix_Z[iPoint,jConnect+1]-m1*(c[iNode]*d[jNode])/Volume/36.0+Mult*MultRowZ*MultColumnY;
                  end;
                end;
                NewConnectAllowed:=false;
              end { if jColumn }
            end { for iConnect:=2 }
          end; { if NConnects > 1 }
          if (NConnects=1) or NewConnectAllowed then begin
            NumberConnect[iPoint,1]:=NumberConnect[iPoint,1]+1;
            iConnect:=NumberConnect[iPoint,1];
            jConnect:=3*iConnect-2;
            ///////////////////////
            SetLength(NumberConnect[iPoint],iConnect+1);
            case dim of
              0: SetLength(RealMatrix_X[iPoint],jConnect+3);
              1: SetLength(RealMatrix_Y[iPoint],jConnect+3);
              2: SetLength(RealMatrix_Z[iPoint],jConnect+3);
            end;
            ///////////////////////
            NumberConnect[iPoint,iConnect]:=jColumn;
            case dim of
              0: RealMatrix_X[iPoint,jConnect]  :=m1*(c[iNode]*c[jNode]+d[iNode]*d[jNode])/Volume/36.0;
              1: RealMatrix_Y[iPoint,jConnect+1]:=m1*(b[iNode]*b[jNode]+d[iNode]*d[jNode])/Volume/36.0;
              2: RealMatrix_Z[iPoint,jConnect+2]:=m1*(b[iNode]*b[jNode]+c[iNode]*c[jNode])/Volume/36.0;
            end;
            case dim of
              0: begin
                RealMatrix_X[iPoint,jConnect+1]:=-m1*(c[iNode]*b[jNode])/Volume/36.0;
                RealMatrix_X[iPoint,jConnect+2]:=-m1*(d[iNode]*b[jNode])/Volume/36.0;
              end;
              1: begin
                RealMatrix_Y[iPoint,jConnect]:=  -m1*(b[iNode]*c[jNode])/Volume/36.0;
                RealMatrix_Y[iPoint,jConnect+2]:=-m1*(d[iNode]*c[jNode])/Volume/36.0;
              end;
              2: begin
                RealMatrix_Z[iPoint,jConnect]:=  -m1*(b[iNode]*d[jNode])/Volume/36.0;
                RealMatrix_Z[iPoint,jConnect+1]:=-m1*(c[iNode]*d[jNode])/Volume/36.0;
              end;
            end;
          end  {  if (NConnects=1) or NewConnectAllowed }
        end  {  else if iNode=jNode  }
      end  { for jNode }
    end  {  for iNode }
  end;   {  for iElement }
  { Учет граничных условий - просмотр узлов с заданным векторным потенциалом }
  case dim of
    0: begin
      for iBound:=1 to NBounds_X do
      begin
        iPoint:=NumberBound_X[iBound];
        RightSide_X[iPoint]:=0.0;
        for i:=1 to 3*NumberConnect[NumberBound_X[iBound],1] do RealMatrix_X[iPoint,i]:=0;
        RealMatrix_X[iPoint,1]:=1
      end;
    end;
    1: begin
      for iBound:=1 to NBounds_Y do
      begin
        iPoint:=NumberBound_Y[iBound];
        RightSide_Y[iPoint]:=0.0;
        for i:=1 to 3*NumberConnect[NumberBound_Y[iBound],1] do RealMatrix_Y[iPoint,i]:=0;
        RealMatrix_Y[iPoint,2]:=1
      end;
    end;
    2: begin
      for iBound:=1 to NBounds_Z do begin
        iPoint:=NumberBound_Z[iBound];
        RightSide_Z[iPoint]:=0.0;
        for i:=1 to 3*NumberConnect[NumberBound_Z[iBound],1] do RealMatrix_Z[iPoint,i]:=0;
        RealMatrix_Z[iPoint,3]:=1
      end  {   for iBound }
    end;
  end;
end;

function TSolutionNL.RunSolutionRE(eps:double;ni:int):double;
var
  ResX,ResY,ResZ:array of float;
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
    if ps.wSMeth3d=1 then
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
      if ps.wSMeth3d=1 then
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
  RightSide_X:=nil;
  RightSide_Y:=nil;
  RightSide_Z:=nil;
  NumberConnect:=nil;
  { uniting axial and defect-depending solution }
  a_SaveDataFile('resultx.dat',ResX[0],(NPoints+1)*SizeOf(ResX[0]));
  a_SaveDataFile('resulty.dat',ResY[0],(NPoints+1)*SizeOf(ResY[0]));
  a_SaveDataFile('resultz.dat',ResZ[0],(NPoints+1)*SizeOf(ResZ[0]));
  Result:=NormalError;
  ///////////////////////////////////////////////////////////////////////
  ResX:=nil;
  ResY:=nil;
  ResZ:=nil;
end;

procedure TSolutionNL.CreateMatrix;
var
  i,iPoint,iMagnet,iElement,iNode,jNode,jPoint,iBound,k:int;
//  a,b,c:mxtyp2;
  NewConnect:boolean;
  iMaterial:int;
  Var_s:float;
  m1,mh2:float;
  mult_1,mult_2:float;
begin
  //////////////////
  NumberConnect:=nil;
  ScalarMatrix:=nil;
  RightSide:=nil;
  ///////////////////////////////////
  SetLength(NumberConnect,nPoints+1);
  SetLength(ScalarMatrix,nPoints+1);
  SetLength(RightSide,nPoints+1);
  //////////////////////////////////////
  for iPoint:=1 to NPoints do begin
    RightSide[iPoint]:=0.0;
    ////////////////////////////
    SetLength(ScalarMatrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    ////////////////////////////
    ScalarMatrix[iPoint,1]:=0.0;
    NumberConnect[iPoint,1]:=1;
  end;
  {Taking all tetrahedrons in order (by number iElement)}
  iMagnet:=1;
  for iElement:=1 to NElements do
  begin
    ElementMatrix3(iElement);
    iMaterial:=ATopology[iElement][0];
    m1:=mt.Prop(iElement,iMaterial)/36/Volume;
    if m1>1e25 then
      m1:=1e20;
    mh2:=mt.dMuH2(iElement,iMaterial);
    if mh2>1e25 then
      mh2:=1e25;
    {Taking all tetrahedron nodes - definition of ScalarMatrix row}
    for iNode:=1 to 4 do
    begin
      iPoint:=ATopology[iElement][iNode];
      mult_1:=0;
      for i:=1 to 4 do
        mult_1:=mult_1+(b[iNode]*b[i]+c[iNode]*c[i]+d[iNode]*d[i])*vm[ATopology[iElement][i]];
      if (iMagnet<=NMagnets) and (iElement=NumberMagnet[iMagnet]) then begin
        RightSide[iPoint]:=RightSide[iPoint]+(Magnet_X[iMagnet]*b[iNode]+Magnet_Y[iMagnet]*c[iNode]+Magnet_Z[iMagnet]*d[iNode])/6;
         if iNode=4 then inc(iMagnet)
      end; {  if iElement  }
      RightSide[iPoint]:=RightSide[iPoint]-mult_1*m1;
      {Taking tetrahedron nodes - definition of its number and connection coefficient}
      for jNode:=1 to 4 do
      begin
        mult_2:=0;
        for i:=1 to 4 do mult_2:=mult_2+(b[jNode]*b[i]+c[jNode]*c[i]+d[jNode]*d[i])*vm[ATopology[iElement][i]];
        if iNode=jNode then
          ScalarMatrix[iPoint,1]:=ScalarMatrix[iPoint,1]+m1*(b[iNode]*b[jNode]+c[iNode]*c[jNode]+d[iNode]*d[jNode])
                                            +mult_1*mult_2*mh2*2/(1296*Volume*Volume*Volume)
        else
        begin  {  calculation NON-DIAGONAL coefficient  }
          NewConnect:=true;
          jPoint:=NumberConnect[iPoint,1]+1;
          for k:=2 to NumberConnect[iPoint,1] do
            if NumberConnect[iPoint,k]=ATopology[iElement][jNode] then
            begin
              jPoint:=k;
              NewConnect:=false;
              break;
            end;
          if NewConnect then
          begin
            SetLength(NumberConnect[iPoint],jPoint+1);
            NumberConnect[iPoint,1]:=jPoint;
            NumberConnect[iPoint,jPoint]:=ATopology[iElement][jNode];
            SetLength(ScalarMatrix[iPoint],jPoint+1);
          end;
          ScalarMatrix[iPoint,jPoint]:=ScalarMatrix[iPoint,jPoint]+m1*(b[iNode]*b[jNode]+c[iNode]*c[jNode]+d[iNode]*d[jNode])
                                            +mult_1*mult_2*mh2*2/(1296*Volume*Volume*Volume)
        end;  {  else - iNode <> jNode }
      end;
    end;  {  for iNode }
  end;   {  for iElement }
  { Boundary conditions }
  for iBound:=1 to NBounds do
  begin
    iPoint:=NumberBound[iBound];
    RightSide[iPoint]:=0;
    SetLength(ScalarMatrix[iPoint],2);
    SetLength(NumberConnect[iPoint],2);
    NumberConnect[iPoint,1]:=1;
  end;
end;

function TSolutionNL.RunSolution(eps:double;ni:int):double;
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
  until (Error<eps)or(iIteration>=ni);
  Residual:=nil;
  Direction:=nil;
  DirectionNew:=nil;
  Z:=nil;
  { Erasing ScalarMatrix and right side }
  ScalarMatrix:=nil;
  RightSide:=nil;
  NumberConnect:=nil;
  { saving results to file }
  a_SaveDataFile('sresult.dat',Res[0],(NPoints+1)*SizeOf(Res[0]));
  Result:=error;
  ///////////////////////////////////////////////////////////////////////
  Res:=nil;
end;

end.
