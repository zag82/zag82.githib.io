unit common_main2d;

interface

uses
  cm_ini, SysUtils, cmData, Gauges, StdCtrls;

type
  TPoint2d=record
    x:float;
    z:float;
  end;

  TAdoptMesh2d=class
  protected
    nnx,nnz:int;
    procedure Point2Num(NPoint:int; var npx,npz:int);
    procedure GetNumsX(npx:int; var ix,jx:int);
    procedure GetNumsZ(npz:int; var iy,jy:int);
    procedure CalcCoord(ix,jx,iy,jy:int;var x0,y0:float);
  private
    numx:int;
    numz:int;
    pts:array of array of TPoint2d;
    quantX:array of int;
    quantZ:array of int;
  public
    rn:int;
    resX:array of float;
    resY:array of float;
    procedure LoadFromFile(fName:string);
    procedure GenerateTop2;
  end;

  TFlatTask=class
  public
  {protected}
    procedure Quad2Num(NQuad:int; var nqx,nqz:int);
    procedure Point2Num(NPoint:int; var npx,npz:int);
    function Num2Quad(nqx,nqz:int):int;
    function Num2Point(npx,npz:int):int;
    function GetMat(xx,yy,zz:float):int;
    function NPoint2coord(npp:int;var discrete:array of TStep;MaxN:int):float;
    function coord2NQuad(cc:float;var discrete:array of TStep;MaxN:int):int;
    ///////////////////
    function GetWhere(sq:int;x,z:float):int;
    procedure GetCenter(iElement:int; var x,z:float);
    function Det(a1,b1,a2,b2 : float) : float;
    procedure ElementMatrix(i:LongInt;var Area,R_average:float;var a,b,c:mxtyp2);
  public
    w:float;
    mm:float;
    // discretization
    angle:byte;
    sort_d:byte;    // axial  or cartesian mesh
    sort_t:byte;    // direction of topology
    sort_ex:byte;   // kind of expanding procedure
    disc_1:array of TStep;
    disc_2:array of TStep;
    nd1:int;
    nd2:int;
    // coordinates
    az:float;
    bz:float;
    ax:float;
    bx:float;
    nnx:int;
    nnz:int;
    ////////////
    // main arrays
    Topology:TTriangleList;
    Nodes:TFlatPointList;
    Sources:TFlatSourceList;
    // array sizes
    NNodes:int;
    NTriangles:int;
    NBounds:int;
    NSources:int;
    // additional data variables
    Top:TTriangle;
    R_Average:float;
    Area:float;
    defMat:int;
    // progress show variables
    nds:boolean;
    gg:TGauge;
    lb:TLabel;
    ggb:TGroupBox;
    /////////////
    constructor Create;
    procedure SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox);
    procedure ReleaseVars;
    ///////////////////
    procedure GenerateTopology;
    procedure GenerateTopMat;
    procedure GenerateNodes;
    procedure GenerateBounds(bnd:TBounds2_data; num:int);virtual;abstract;
    procedure GenerateSources;
    //////////////////////////
    procedure PrepareData();
    procedure PrepareMatrix;virtual;abstract;
    procedure PrepareSolution;virtual;abstract;
    function MakeSolutionStep:float;virtual;abstract;
    function RunSolution(ee:double;ni:int):float;virtual;abstract;
    procedure CreateNLMatrix;virtual;abstract;
    /////////////////////////////
    function FindApproximate(x,z:float;var A,B:float):boolean;virtual; abstract;
  end;

var
  adoptedM2:TAdoptMesh2d;

////////////////////////////////////////////////////////////////////////////////
implementation

uses  cmVars, uni_mesh;
////////////////////////////////////////////////////////////////////////////////
//                               TAdoptedMesh                                 //
////////////////////////////////////////////////////////////////////////////////
procedure TAdoptMesh2d.Point2Num(NPoint:int; var npx,npz:int);
begin
  npx:=(NPoint mod nnx);
  npz:=1+(NPoint div nnx);
  if npx=0 then
  begin
    npx:=nnx;
    npz:=npz-1;
  end;
end;

procedure TAdoptMesh2d.GetNumsX(npx:int; var ix,jx:int);
var i,k:int;
begin
  k:=1;
  for i:=1 to numX-1 do
  begin
    k:=k+quantX[i];
    if k>=npx then
    begin
      ix:=i;
      jx:=npx-(k-quantX[i]);
      break;
    end;
  end;
end;

procedure TAdoptMesh2d.GetNumsZ(npz:int; var iy,jy:int);
var i,k:int;
begin
  k:=1;
  for i:=1 to numZ-1 do
  begin
    k:=k+quantZ[i];
    if k>=npz then
    begin
      iy:=i;
      jy:=npz-(k-quantZ[i]);
      break;
    end;
  end;
end;

procedure TAdoptMesh2d.CalcCoord(ix,jx,iy,jy:int;var x0,y0:float);
var x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6:float;
begin
  ////////////////////
  x1:=pts[ix,iy].x;
  y1:=pts[ix,iy].z;
  x2:=pts[ix+1,iy].x;
  y2:=pts[ix+1,iy].z;
  x3:=pts[ix,iy+1].x;
  y3:=pts[ix,iy+1].z;
  x4:=pts[ix+1,iy+1].x;
  y4:=pts[ix+1,iy+1].z;
  ////////////////////
  x5:=x1+jy/quantZ[iy]*(x3-x1);
  y5:=y1+jy/quantZ[iy]*(y3-y1);
  //
  x6:=x2+jy/quantZ[iy]*(x4-x2);
  y6:=y2+jy/quantZ[iy]*(y4-y2);
  //////
  x0:=x5+jx/quantX[ix]*(x6-x5);
  y0:=y5+jx/quantX[ix]*(y6-y5);
end;

procedure TAdoptMesh2d.LoadFromFile(fName:string);
var f:TextFile;
    i,j,i1,i2:int;
    v1,v2:float;
begin
  AssignFile(f,fName);
  Reset(f);
  readln(f,i1,i2);
  numx:=i1;
  numz:=i2;
  SetLength(quantX,numX);
  SetLength(quantZ,numZ);
  SetLength(pts,numX+1);
  for i:=1 to numX do
    SetLength(pts[i],numZ+1);
  readln(f);
  for i:=1 to numZ do
  begin
    for j:=1 to NumX do
    begin
      read(f,v1,v2);
      pts[j,i].x:=v1/1000;
      pts[j,i].z:=v2/1000;
    end;
    readln(f);
  end;
  readln(f);
  for i:=1 to numX-1 do
  begin
    read(f,i1);
    quantX[i]:=i1;
  end;
  readln(f);
  for i:=1 to numZ-1 do
  begin
    read(f,i2);
    quantZ[i]:=i2;
  end;
  readln(f);
  CloseFile(f);
  nnx:=1; for i:=1 to numX-1 do nnx:=nnx+quantX[i];
  nnz:=1; for i:=1 to numZ-1 do nnz:=nnz+quantZ[i];
  rn:=nnx*nnz;
  SetLength(ResX,rn+1);
  SetLength(ResY,rn+1);
end;

procedure TAdoptMesh2d.GenerateTop2;
var i:int;
    npx,npz:int;
    ix,jx,iy,jy:int;
    x0,y0:float;
begin
  for i:=1 to rn do
  begin
    Point2Num(i,npx,npz);
    GetNumsX(npx,ix,jx);
    GetNumsZ(npz,iy,jy);
    CalcCoord(ix,jx,iy,jy,x0,y0);
    ResX[i]:=x0;
    ResY[i]:=y0;
  end;          
end;

////////////////////////////////////////////////////////////////////////////////
//                                TFlatTask                                   //
////////////////////////////////////////////////////////////////////////////////
procedure TFlatTask.Quad2Num(NQuad:int; var nqx,nqz:int);
{ Определяет по номеру квадрата в разбиении его "координаты" (положение) вдоль осей }
begin
  nqx:=(NQuad mod (nnx-1));
  nqz:=1+(NQuad div (nnx-1));
  if nqx=0 then
  begin
    nqx:=nnx-1;
    nqz:=nqz-1;
  end;
end;

procedure TFlatTask.Point2Num(NPoint:int; var npx,npz:int);
{ Определяет по номеру узла в разбиении его "координаты" (положение) вдоль осей }
begin
  npx:=(NPoint mod nnx);
  npz:=1+(NPoint div nnx);
  if npx=0 then
  begin
    npx:=nnx;
    npz:=npz-1;
  end;
end;

function TFlatTask.Num2Quad(nqx,nqz:int):int;
{ Определяет по положению квадрата вдоль осей его номер }
begin
  Result:=nqx+(nnx-1)*(nqz-1)
end;

function TFlatTask.Num2Point(npx,npz:int):int;
{ Определяет по положению узла вдоль осей его номер }
begin
    Result:=npx+nnx*(npz-1)
end;

function TFlatTask.GetMat(xx,yy,zz:float):int;
{ Определяет номер материала точки заданной координатами (xx,yy,zz) }
var i:int; // текущий номер материала
    mgo:TMgObject;
    mm:int;
begin
  Result:=mt.DefaultMaterial; // вначале задаем материал по умолчанию (окружающая среда)
  for i:=0 to ob.Count-1 do
  begin
    mgo:=TMgObject(ob.Items[i]);
    mm:=mgo.iMaterial;
    if defMat<>mm then
      if mgo.IsPointInside(xx,yy,zz) then
        Result:=mm;
  end;
end;

function TFlatTask.NPoint2coord(npp:int;var discrete:array of TStep;MaxN:int):float;
var
  i,Num:int;
  tt:float;
begin
  tt:=0.0;
  Num:=1;
  for i:=1 to MaxN do
  begin
    Num:=Num+discrete[i].num;
    if npp>Num then
      tt:=tt+(discrete[i].num*discrete[i].val)
    else
    begin
      tt:=tt+(discrete[i].val*(discrete[i].num-Num+npp));
      break;
    end;
  end;
  result:=tt;
end;

function TFlatTask.coord2NQuad(cc:float;var discrete:array of TStep;MaxN:int):int;
var
  s:float;
  Num,i,l:int;
begin
  s:=0.0;
  Num:=1;
  for i:=1 to MaxN do
  begin
    Num:=Num+discrete[i].num;
    s:=s+discrete[i].num*discrete[i].val;
    if s>=cc then
    begin
      l:=round((s-cc)/discrete[i].val);
      Num:=Num-l;
    end;
  end;
  Result:=Num;
end;

{==============================================================================}
{===============================  TFlatTask  ==================================}
{==============================================================================}
constructor TFlatTask.Create;
begin
 // adoptedM2:=nil;
  nds:=true;//default set: it mean that it is necessary to show progress during calculations
  //
  angle:=1;
  sort_d:=1;
  sort_t:=1;
  sort_ex:=1;
  /////////////
  Topology:=nil;
  Nodes:=nil;
  Sources:=nil;
  NNodes:=0;
  NTriangles:=0;
  NBounds:=0;
  NSources:=0;
  defMat:=-1;
  //
  disc_1:=nil;
  disc_2:=nil;
  nd1:=0;
  nd2:=0;
  inherited Create;
end;

procedure TFlatTask.SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox);
begin
  gg:=Gag;
  lb:=lab;
  ggb:=Grop;
end;

procedure TFlatTask.ReleaseVars;
begin
 // if AdoptedM2<>nil then AdoptedM2.Free;
  Topology:=nil;
  Nodes:=nil;
  Sources:=nil;
  NNodes:=0;
  NTriangles:=0;
  NBounds:=0;
  NSources:=0;
  defMat:=-1;
  //
  disc_1:=nil;
  disc_2:=nil;
  nd1:=0;
  nd2:=0;
end;

// Generation procedures
procedure TFlatTask.GenerateTopMat;
var i:int;
  xx,zz:float; // координаты середины треугольника
begin
  if nds then
  begin
    lb.Caption:='Creating Materials ...';
    ggb.Refresh;
    gg.MaxValue:=NTriangles;
  end;
  for i:=1 to NTriangles do
  begin
    GetCenter(i,xx,zz);
    Topology[i,0]:=GetMat(xx,1e-6,zz);
    if (nds)and((i mod 1000)=0) then gg.Progress:=i;
  end;
end;

procedure TFlatTask.GenerateTopology;
{ Создание топологии }
var
  i:int; // текущий номер объемного узла, текущий номер квадрата
  qx,qz:int;    // положение квадрата вдоль осей
  ar,rav:float;
  a,b,c:mxtyp2;
  rr:int;
begin
  if umEnable then
  begin
    NTriangles:=um.nEls;
    SetLength(Topology,NTriangles+1);
    for i:=1 to NTriangles do
      Topology[i]:=um.Top[i];
    for i:=1 to Ntriangles do
    begin
      ElementMatrix(i,ar,rav,a,b,c);
      if ar<0 then
      begin
        rr:=Topology[i][1];
        Topology[i][1]:=Topology[i][2];
        Topology[i][2]:=rr;
      end;
    end;
  end
  else
  begin
  NTriangles:=(nnx-1)*(nnz-1)*2;//
  SetLength(Topology,NTriangles+1);
  if nds then
  begin
    lb.Caption:='Creating Topology ...';
    ggb.Refresh;
    gg.MaxValue:=(NTriangles div 2);
  end;
  for i:=1 to NTriangles div 2 do //
  begin
    Quad2Num(i,qx,qz); //
    Case sort_t of
      1:begin
          Topology[2*i-1][1]:=Num2Point(qx,qz);
          Topology[2*i-1][2]:=Num2Point(qx+1,qz);
          Topology[2*i-1][3]:=Num2Point(qx,qz+1);
          ///////////////////////
          Topology[2*i][1]:=Num2Point(qx+1,qz+1);
          Topology[2*i][2]:=Num2Point(qx,qz+1);
          Topology[2*i][3]:=Num2Point(qx+1,qz);
        end;
      2:begin
          Topology[2*i-1][1]:=Num2Point(qx+1,qz);
          Topology[2*i-1][2]:=Num2Point(qx+1,qz+1);
          Topology[2*i-1][3]:=Num2Point(qx,qz);
          ///////////////////////
          Topology[2*i][1]:=Num2Point(qx,qz+1);
          Topology[2*i][2]:=Num2Point(qx,qz);
          Topology[2*i][3]:=Num2Point(qx+1,qz+1);
        end;
      3:begin
          if ((qx+qz)mod 2)=0 then  // четное
          begin
            Topology[2*i-1][1]:=Num2Point(qx,qz);
            Topology[2*i-1][2]:=Num2Point(qx+1,qz);
            Topology[2*i-1][3]:=Num2Point(qx,qz+1);
            ///////////////////////
            Topology[2*i][1]:=Num2Point(qx+1,qz+1);
            Topology[2*i][2]:=Num2Point(qx,qz+1);
            Topology[2*i][3]:=Num2Point(qx+1,qz);
          end
          else
          begin
            Topology[2*i-1][1]:=Num2Point(qx+1,qz);
            Topology[2*i-1][2]:=Num2Point(qx+1,qz+1);
            Topology[2*i-1][3]:=Num2Point(qx,qz);
            ///////////////////////
            Topology[2*i][1]:=Num2Point(qx,qz+1);
            Topology[2*i][2]:=Num2Point(qx,qz);
            Topology[2*i][3]:=Num2Point(qx+1,qz+1);
          end;
        end;
    end;
    if (nds)and((i mod 1000)=0) then gg.Progress:=i;
  end;
  end;
end;

procedure TFlatTask.GenerateNodes;
var i,j,k:int;
  rr,phi:float;
begin
  if nds then
  begin
    lb.Caption:='Creating Nodes ...';
    ggb.Refresh;
    gg.MaxValue:=nnz;
  end;
  if umEnable then
  begin
    um.GenerateUniMesh;
    NNodes:=um.nPts;
    SetLength(Nodes,NNodes+1);
    for i:=1 to NNodes do
    begin
      Nodes[i][1]:=um.crX[i];
      Nodes[i][2]:=um.crY[i];
    end;
  end
  else if AdoptedM2<>nil then
  begin
    NNodes:=AdoptedM2.rn;
    SetLength(Nodes,NNodes+1);
    for i:=1 to NNodes do
    begin
      Nodes[i][1]:=AdoptedM2.resX[i];
      Nodes[i][2]:=AdoptedM2.resY[i];
    end;
  end
  else
  if sort_d=1 then
  begin
    NNodes:=nnx*nnz;
    SetLength(Nodes,NNodes+1);
    for i:=1 to nnz do
    begin
      for j:=1 to nnx do
      begin
        k:=Num2Point(j,i);
        Nodes[k][1]:=ax+NPoint2coord(j,disc_1,nd1);
        Nodes[k][2]:=az+NPoint2coord(i,disc_2,nd2);
      end;
      if (nds)and((i mod 100)=0) then gg.Progress:=i;
    end;
  end
  else
  begin
    NNodes:=nnx*nnz;            // here nx- analogue to r
    SetLength(Nodes,NNodes+1);  // here nz- analogue to fi
    for i:=1 to nnz do
    begin
      for j:=1 to nnx do
      begin
        k:=Num2Point(j,i);
        rr:=ax+NPoint2coord(j,disc_1,nd1);
        phi:=az+NPoint2coord(i,disc_2,nd2);
        Nodes[k][1]:=rr*cos(phi*pi/180);
        Nodes[k][2]:=rr*sin(phi*pi/180);
      end;
      if (nds)and((i mod 100)=0) then gg.Progress:=i;
    end;
  end;
end;

procedure TFlatTask.GenerateSources;
var i,j:int;
    im:int;
    sr:TFlatSource;
    f:boolean;
    xx,zz,yy:float;
    mgo:TMgObject;
begin
  if nds then
  begin
    lb.Caption:='Creating Sources ...';
    ggb.Refresh;
    gg.MaxValue:=NTriangles;
  end;
  NSources:=0;
  for i:=1 to NTriangles do
  begin
    im:=Topology[i,0];
    GetCenter(i,xx,zz);
    yy:=1e-10;
    f:=false;
    sr.num:=0;
    sr.val_Bx:=0;
    sr.val_Bz:=0;
    sr.val_J:=0;
    sr.val_Jim:=0;
    sr.val_Ro:=0;
    for j:=0 to ob.Count-1 do
    begin
      mgo:=ob.Items[j];
      if mgo.GetMaterial=im then
        if mgo.IsPointInside(xx,yy,zz) then
        begin
          if mgo.sr_kind<>0 then f:=true else f:=false;
          sr.num:=i;
          sr.val_J:=mgo.Jy(xx,yy,zz)*cos(pi/180*mgo.Phi(xx,yy,zz));
          sr.val_Jim:=mgo.Jy(xx,yy,zz)*sin(pi/180*mgo.Phi(xx,yy,zz));
          sr.val_Bx:=mgo.Bx(xx,yy,zz);
          sr.val_Bz:=mgo.Bz(xx,yy,zz);
          sr.val_Ro:=mgo.Ro(xx,yy,zz);
        end;
    end;
    if f then
    begin
      inc(NSources);
      SetLength(Sources,NSources+1);
      Sources[NSources]:=sr;
    end;
    if (nds)and((i mod 1000)=0) then gg.Progress:=i;
  end;
end;

procedure TFlatTask.PrepareData();
var i:int;
begin
  bx:=ax;
  bz:=az;
  for i:=1 to nd1 do bx:=bx+disc_1[i].num*disc_1[i].val;
  for i:=1 to nd2 do bz:=bz+disc_2[i].num*disc_2[i].val;
  nnx:=1;
  nnz:=1;
  for i:=1 to nd1 do nnx:=nnx+disc_1[i].num;
  for i:=1 to nd2 do nnz:=nnz+disc_2[i].num;
  NNodes:=nnx*nnz;
  NTriangles:=(nnx-1)*(nnz-1)*2;
end;

{==============================================================================}
{===============================  PROTECTED  ==================================}
{==============================================================================}
function TFlatTask.GetWhere(sq:int;x,z:float):int;
var x1,x2,z1,z2:float;
begin
  x1:=Nodes[Topology[2*sq-1][3]][1];
  x2:=Nodes[Topology[2*sq-1][2]][1];
  z1:=Nodes[Topology[2*sq-1][3]][2];
  z2:=Nodes[Topology[2*sq-1][2]][2];
  if (x-x2)<((x1-x2)/(z1-z2)*(z-z2)) then
    Result:=1
  else
    Result:=2
end;


procedure TFlatTask.GetCenter(iElement:int; var x,z:float);
var i:int;
begin
  x:=0;
  z:=0;
  for i:=1 to 3 do
  begin
    x:=x+Nodes[Topology[iElement][i]][1];
    z:=z+Nodes[Topology[iElement][i]][2];
  end;
  x:=x/3;
  z:=z/3;
end;

function TFlatTask.Det(a1,b1,a2,b2 : float) : float;
begin
  Result:=a1*b2-b1*a2
end;

procedure TFlatTask.ElementMatrix(i:LongInt;var Area,R_average:float;var a,b,c:mxtyp2);
var
  j:int;
  x1,x2,x3,y1,y2,y3:float;
begin
  { Getting node coordinates of tetrahedron by number iElement }
  Top:=Topology[i];
  x1:=Nodes[Top[1]][1];
  x2:=Nodes[Top[2]][1];
  x3:=Nodes[Top[3]][1];
  y1:=Nodes[Top[1]][2];
  y2:=Nodes[Top[2]][2];
  y3:=Nodes[Top[3]][2];
  { Definition of coefficients for finite element matrix }
  a[1]:=Det(x2,y2,x3,y3);
  b[1]:=-Det(1,y2,1,y3);
  c[1]:=Det(1,x2,1,x3);
  a[2]:=-Det(x1,y1,x3,y3);
  b[2]:=Det(1,y1,1,y3);
  c[2]:=-Det(1,x1,1,x3);
  a[3]:=Det(x1,y1,x2,y2);
  b[3]:=-Det(1,y1,1,y2);
  c[3]:=Det(1,x1,1,x2);
  { Calculation of Triangle Area }
  Area:=(a[1]+a[2]+a[3])/2.0;
  { Coefficients' correction for RZ-coordinates and Vector Potential}
  if sort_ex=1 then
  begin
    R_average:=(x1+x2+x3)/3;
    if Task >2 then
      for j:=1 to 3 do
        b[j]:=b[j]+2*Area/R_average/3;
    R_average:=R_average*2*pi;
  end
  else
    R_average:=1;
end; { ElementMatrix }

{==============================================================================}
{============================  END OF CLASSES  ================================}
{==============================================================================}
end.
