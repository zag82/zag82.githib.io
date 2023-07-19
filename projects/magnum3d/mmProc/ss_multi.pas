unit ss_multi;

interface

uses cm_ini, comvars, cmdata, cmvars;

type
  TMagnetSignal=class
  protected
    a,b,c,d:mxtyp3;
    Volume:float;
    function Determinant(a1,b1,c1, a2,b2,c2, a3,b3,c3 : float) : float;
    procedure ElementMatrixS(iElement:int);
  public
    Bx:array of float;
    By:array of float;
    Bz:array of float;
    dBx:array of float;
    dBz:array of float;
    Nres:array of int;
    res:array of array of array[1..5] of float;
    StepX:float;
    StepY:float;
    numX:int;
    numY:int;
    offset:float;
    minus:boolean;
    procedure SetData(sx,sy:float; nx,ny:int; ofs:float);
    procedure FreeData;
    procedure GetB(x,y,z:float; var bbx,bby,bbz,dbbx,dbbz:float);
    function GetPointElement(x,y,z:float):int;
    procedure SaveResToFile(fName:string; iComponent:int);
    procedure GenerateFullMatrix;
  end;

implementation

uses Compute_VectorsUnit;

procedure TMagnetSignal.SetData(sx,sy:float; nx,ny:int; ofs:float);
var i,j,k:int;
begin
  minus:=false;
  offset:=ofs;
  StepX:=sx;
  StepY:=sy;
  numX:=nx;
  numY:=ny;
  SetLength(Bx,NPoints+1);
  SetLength(By,NPoints+1);
  SetLength(Bz,NPoints+1);
  SetLength(dBx,NPoints+1);
  SetLength(dBz,NPoints+1);
  SetLength(Nres,NPoints+1);
  for i:=1 to NPoints do
  begin
    Bx[i]:=0.0;
    By[i]:=0.0;
    Bz[i]:=0.0;
    dBx[i]:=0.0;
    dBz[i]:=0.0;
  end;
  for i:=1 to Npoints do Nres[i]:=0;
  SetLength(res, numX+1);
  for i:=1 to numX do
    SetLength(res[i],numY+1);
  for i:=1 to NElements do
  begin
    Compute_Vectors(i);
    for j:=1 to 4 do
    begin
      k:=Atopology[i,j];
      Nres[k]:=Nres[k]+1;
      Bx[k]:=Bx[k]+FluxDensity_X;
      By[k]:=By[k]+FluxDensity_Y;
      Bz[k]:=Bz[k]+FluxDensity_Z;
    end;
  end;
  for i:=1 to NPoints do
    if Nres[i]<>0 then
    begin
      Bx[i]:=Bx[i]/Nres[i];
      By[i]:=By[i]/Nres[i];
      Bz[i]:=Bz[i]/Nres[i];
      dBx[i]:=dBx[i]/Nres[i];
      dBz[i]:=dBz[i]/Nres[i];
    end;
end;

procedure TMagnetSignal.FreeData;
begin
  Bx:=nil;
  By:=nil;
  Bz:=nil;
  dBx:=nil;
  dBz:=nil;
  Nres:=nil;
  res:=nil;
end;

function TMagnetSignal.Determinant(a1,b1,c1, a2,b2,c2, a3,b3,c3 : float) : float;
begin
  Result:=a1*(b2*c3-c2*b3)-b1*(a2*c3-c2*a3)+c1*(a2*b3-b2*a3)
end;

procedure TMagnetSignal.ElementMatrixS(iElement:int);
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
end;

procedure TMagnetSignal.GetB(x,y,z:float; var bbx,bby,bbz,dbbx,dbbz:float);
var k:int;
    i:int;
begin
  k:=GetPointElement(x,y,z);
  if k<0 then
  begin
    bbx:=0;
    bby:=0;
    bbz:=0;
    dbbx:=0;
    dbbz:=0;
  end
  else
  begin
    ElementMatrixS(k);
    bbx:=0;
    bby:=0;
    bbz:=0;
    dbbx:=0;
    dbbz:=0;
    for i:=1 to 4 do
    begin
      bbx:=bbx+Bx[ATopology[k][i]]*(a[i]+b[i]*x+c[i]*y+d[i]*z);
      bby:=bby+By[ATopology[k][i]]*(a[i]+b[i]*x+c[i]*y+d[i]*z);
      bbz:=bbz+Bz[ATopology[k][i]]*(a[i]+b[i]*x+c[i]*y+d[i]*z);
      dbbx:=dbbx+dBx[ATopology[k][i]]*(a[i]+b[i]*x+c[i]*y+d[i]*z);
      dbbz:=dbbz+dBz[ATopology[k][i]]*(a[i]+b[i]*x+c[i]*y+d[i]*z);
    end;
    bbx:=bbx/(6*Volume);
    bby:=bby/(6*Volume);
    bbz:=bbz/(6*Volume);
    dbbx:=dbbx/(6*Volume);
    dbbz:=dbbz/(6*Volume);
  end;
end;

function TMagnetSignal.GetPointElement(x,y,z:float):int;
var k,i:int;
    v1,v2,v3,v4,vv:float;
    x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4:float;
begin
  k:=-1;
  for i:=1 to NElements do
  begin
    //////////////////////////////////
    x1:=Crd_x[ATopology[i][1]];
    x2:=Crd_x[ATopology[i][2]];
    x3:=Crd_x[ATopology[i][3]];
    x4:=Crd_x[ATopology[i][4]];
    y1:=Crd_y[ATopology[i][1]];
    y2:=Crd_y[ATopology[i][2]];
    y3:=Crd_y[ATopology[i][3]];
    y4:=Crd_y[ATopology[i][4]];
    z1:=Crd_z[ATopology[i][1]];
    z2:=Crd_z[ATopology[i][2]];
    z3:=Crd_z[ATopology[i][3]];
    z4:=Crd_z[ATopology[i][4]];
    //////////////////////////////////
    v1:=abs(determinant(x-x1,y-y1,z-z1, x-x2,y-y2,z-z2, x-x3,y-y3,z-z3));
    v2:=abs(determinant(x-x1,y-y1,z-z1, x-x2,y-y2,z-z2, x-x4,y-y4,z-z4));
    v3:=abs(determinant(x-x1,y-y1,z-z1, x-x3,y-y3,z-z3, x-x4,y-y4,z-z4));
    v4:=abs(determinant(x-x2,y-y2,z-z2, x-x3,y-y3,z-z3, x-x4,y-y4,z-z4));
    //////////////////////////////////
    vv:=abs(determinant(x1-x2,y1-y2,z1-z2, x1-x3,y1-y3,z1-z3, x1-x4,y1-y4,z1-z4));
    if abs(v1+v2+v3+v4-vv)<1e-10 then
    begin
      k:=i;
      break;
    end;
  end;
  Result:=k;
end;

procedure TMagnetSignal.SaveResToFile(fName:string; iComponent:int);
var f:textFile;
    i,j:int;
begin
  AssignFile(f,fname);
  try
    ReWrite(f);
    for i:=1 to numX do
    begin
      for j:=1 to numY do
        write(f,res[i][j][iComponent]:10:10,#9);
      writeln(f);
    end;
  finally
    CloseFile(f);
  end;
end;

procedure TMagnetSignal.GenerateFullMatrix;
var i,j:int;
    vx,vy,vz,dvx,dvz:float;
    x,y,z:float;
begin
  for i:=1 to numX do
    for j:=1 to numY do
    begin
      if minus
      then x:=(i-1-(numX div 2))*StepX
      else x:=(i-1)*StepX;
      y:=(j-1)*StepY;
      z:=offset;
      GetB(x,y,z,vx,vy,vz,dvx,dvz);
      res[i][j][1]:=vx;
      res[i][j][2]:=vy;
      res[i][j][3]:=vz;
      res[i][j][4]:=dvx;
      res[i][j][5]:=dvz;
    end;
end;

end.
