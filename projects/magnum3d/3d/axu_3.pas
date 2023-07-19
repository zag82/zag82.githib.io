unit axu_3;

interface

uses
  cmData, cm_ini, classes, Gauges, StdCtrls, comvars;

Type
  TPoint3d=record
    x:float;
    z:float;
  end;

  TAdoptMesh3d=class
  protected
    nnx,nny,nnz:int;
    procedure Point2Num(NPoint:int; var npx,npy,npz:int);
    procedure GetNumsX(npx:int; var ix,jx:int);
    procedure GetNumsZ(npz:int; var iy,jy:int);
    procedure CalcCoord(ix,jx,iy,jy:int;var x0,y0:float);
  private
    numx:int;
    numz:int;
    pts:array of array of TPoint3d;
    quantX:array of int;
    quantZ:array of int;
  public
    rn:int;
    resX:array of float;
    resY:array of float;
    resZ:array of float;
    procedure LoadFromFile(fName:string);
    procedure GenerateTop3;
  end;

  TPoint3=array [1..3] of float;
  TPointList=array of TPoint3;

  TAxialTask3=class
  protected
  public
    procedure Cube2Num(NCube:int; var ncr,ncf,ncz:int);
    procedure Point2Num(NPoint:int; var npr,npf,npz:int);
    function Num2Cube(ncr,ncf,ncz:int):int;
    function Num2Point(npr,npf,npz:int):int;
    function NPoint2coord(npp:int;var discrete:array of TStep;MaxN:int):float;
    function coord2NQuad(cc:float;var discrete:array of TStep;MaxN:int):int;
    ///////////////////
    function GetMat(xx,yy,zz:float):int;
    procedure GetCenter(iElement:int; var x,y,z:float);
  public
    //======================Andrew+
    nds:boolean;
    mesh_s:int;
    defMat:int;
    angle:byte;
    disc_1:array of TStep;
    disc_2:array of TStep;
    disc_3:array of TStep;

    nd1:int;
    nd2:int;
    nd3:int;
    gg:TGauge;
    lb:TLabel;
    ggb:TGroupBox;
    //======================Andrew=
    adpt:byte;
    ad_type:byte;
    /////////////
    ax,ay,az,bx,by,bz:float;
    nnx,nny,nnz:int;
    /////////////////
    ///
    constructor Create;
    procedure SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox);
    procedure Delete();
    ///////////////////
    procedure GenerateTopology;
    procedure GenerateTopMat;
    procedure GenerateNodes(c1,c2:int);
    procedure GenerateSources;
    procedure GenerateBounds(var bnd:TBounds3_data; MaxN:int);
    //////////////////////////
    procedure PrepareData();
  end;

var
  adoptedM3:TAdoptMesh3d;

implementation

uses SpecMat, cmVars, complx, ado3;
////////////////////////////////////////////////////////////////////////////////
//                               TAdoptedMesh                                 //
////////////////////////////////////////////////////////////////////////////////
procedure TAdoptMesh3d.Point2Num(NPoint:int; var npx,npy,npz:int);
var k:int;
begin
  npz:=1+(NPoint div (nnx*nny));
  k:=NPoint mod (nnx*nny);
  if k=0 then
  begin
    k:=nnx*nny;
    npz:=npz-1;
  end;
  npy:=1+(k div nnx);
  npx:=k mod nnx;
  if npx=0 then
  begin
    npx:=nnx;
    npy:=npy-1;
  end;
end;

procedure TAdoptMesh3d.GetNumsX(npx:int; var ix,jx:int);
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

procedure TAdoptMesh3d.GetNumsZ(npz:int; var iy,jy:int);
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

procedure TAdoptMesh3d.CalcCoord(ix,jx,iy,jy:int;var x0,y0:float);
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

procedure TAdoptMesh3d.LoadFromFile(fName:string);
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
  nny:=axa.nny;
  rn:=nnx*nny*nnz;
  SetLength(ResX,rn+1);
  SetLength(ResY,rn+1);
  SetLength(ResZ,rn+1);
end;

procedure TAdoptMesh3d.GenerateTop3;
var i:int;
    npx,npy,npz:int;
    ix,jx,iy,jy:int;
    x0,y0:float;
begin
  for i:=1 to rn do
  begin
    Point2Num(i,npx,npy,npz);
    GetNumsX(npx,ix,jx);
    GetNumsZ(npz,iy,jy);
    CalcCoord(ix,jx,iy,jy,x0,y0);
    ResX[i]:=x0;
    ResY[i]:=axa.ay+axa.NPoint2coord(npy,axa.disc_2,axa.nd2);
    ResZ[i]:=y0;
  end;          
end;

////////////////////////////////////////////////////////////////////////////////
//                                 TAxialTask                                 //
////////////////////////////////////////////////////////////////////////////////
function TAxialTask3.coord2NQuad(cc:float;var discrete:array of TStep;MaxN:int):int;
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

function TAxialTask3.NPoint2coord(npp:int;var discrete:array of TStep;MaxN:int):float;
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

{==============================================================================}
{===============================  TAxialTask3  ==================================}
{==============================================================================}
constructor TAxialTask3.Create;
begin
  ad_type:=0;
  nds:=true;
  mesh_s:=0;
  defMat:=-1;
  angle:=1;
  adpt:=0;
  disc_1:=nil;
  disc_2:=nil;
  disc_3:=nil;
  nd1:=0;
  nd2:=0;
  nd3:=0;
  ax:=0;
  ay:=0;
  az:=0;
  bx:=0;
  by:=0;
  bz:=0;
  inherited Create;
end;

procedure TAxialTask3.Delete();
begin
  disc_1:=nil;
  disc_2:=nil;
  disc_3:=nil;
  gg:=nil;
  lb:=nil;
  ggb:=nil;
end;

procedure TAxialTask3.SetShower(Gag:TGauge;lab:TLabel;Grop:TGroupBox);
begin
  gg:=Gag;
  lb:=lab;
  ggb:=Grop;
end;

/////////////////////////////////////
procedure TAxialTask3.GenerateTopMat;
var
  i:int;
  xx,yy,zz:float;
begin
  { Visualisation }
  if nds then
  begin
    lb.Caption:='Materials';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  { EOV }
  for i:=1 to NElements do
  begin
    GetCenter(i,xx,yy,zz);
    ATopology[i,0]:=GetMat(xx,yy,zz);
    if nds then gg.Progress:=i;
  end;
  { Visualisation }
  if nds then
  begin
    lb.Caption:='<< Done >>';
    gg.MaxValue:=0;
    gg.Progress:=0;
  end;
  { EOV }
end;

procedure TAxialTask3.GenerateTopology;
{ Создание топологии }
var
  b_r,b_f,b_z,bb:int;
  num,n1:int;
  k,j,m:int;
  i:int; // текущий номер объемного узла, текущий номер квадрата
  cr,cf,cz:int;    // положение квадрата вдоль осей
begin
  NElements:=(nnx-1)*(nny-1)*(nnz-1)*Tic;//
  SetLength(ATopology,NElements+1);
  { Visualisation }
  if nds then
  begin
    lb.Caption:='Topology';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  { EOV }
  if tic=6 then // 6 tetrahedrons in CUBE
    for i:=1 to (NElements div 6) do //
    begin
      Cube2Num(i,cr,cf,cz); //
      // 1
      ATopology[6*i-5][1]:=Num2Point(cr,cf,cz);
      ATopology[6*i-5][2]:=Num2Point(cr+1,cf,cz);
      ATopology[6*i-5][3]:=Num2Point(cr+1,cf+1,cz);
      ATopology[6*i-5][4]:=Num2Point(cr,cf,cz+1);
      // 2
      ATopology[6*i-4][1]:=Num2Point(cr,cf+1,cz);
      ATopology[6*i-4][2]:=Num2Point(cr,cf,cz);
      ATopology[6*i-4][3]:=Num2Point(cr+1,cf+1,cz);
      ATopology[6*i-4][4]:=Num2Point(cr,cf,cz+1);
      // 3
      ATopology[6*i-3][1]:=Num2Point(cr+1,cf,cz);
      ATopology[6*i-3][2]:=Num2Point(cr+1,cf+1,cz);
      ATopology[6*i-3][3]:=Num2Point(cr,cf,cz+1);
      ATopology[6*i-3][4]:=Num2Point(cr+1,cf,cz+1);
      // 4
      ATopology[6*i-2][1]:=Num2Point(cr+1,cf+1,cz);
      ATopology[6*i-2][2]:=Num2Point(cr,cf+1,cz);
      ATopology[6*i-2][3]:=Num2Point(cr,cf,cz+1);
      ATopology[6*i-2][4]:=Num2Point(cr,cf+1,cz+1);
      // 5
      ATopology[6*i-1][1]:=Num2Point(cr+1,cf+1,cz);
      ATopology[6*i-1][2]:=Num2Point(cr,cf,cz+1);
      ATopology[6*i-1][3]:=Num2Point(cr+1,cf,cz+1);
      ATopology[6*i-1][4]:=Num2Point(cr+1,cf+1,cz+1);
      // 6
      ATopology[6*i][1]:=Num2Point(cr,cf,cz+1);
      ATopology[6*i][2]:=Num2Point(cr+1,cf+1,cz);
      ATopology[6*i][3]:=Num2Point(cr,cf+1,cz+1);
      ATopology[6*i][4]:=Num2Point(cr+1,cf+1,cz+1);
      if nds then gg.Progress:=i;
    end
  else // 5 tetrahedrons in CUBE
    for i:=1 to (NElements div 5) do //
    begin
      Cube2Num(i,cr,cf,cz); //
      b_r:=(cr mod 2);
      b_f:=(cf mod 2);
      b_z:=(cz mod 2);
      bb:=b_r + b_f + b_z;
      if (bb = 3) or (bb = 1)then k:=1 else k:=2;
      for j:=1 to 5 do
        for m:=1 to 4 do
          ATopology[5*i-5+j][m]:=Num2Point(cr+tet5[k,j,m,1],cf+tet5[k,j,m,2],cz+tet5[k,j,m,3]);
      if nds then gg.Progress:=i;
    end;
end;

procedure TAxialTask3.GenerateNodes(c1,c2:int);
var
  i,j,k,num:int;
  rr,phi,zz,xx,yy:float;
  n1,n2:int;
  r1,r2,p1,p2,p3:float;
begin
  if ad_type=1 then
  begin
    NPoints:=adoptedM3.rn;
    SetLength(Crd_X,NPoints+1);
    SetLength(Crd_Y,NPoints+1);
    SetLength(Crd_Z,NPoints+1);
    for i:=1 to NPoints do
    begin
      Crd_X[i]:=adoptedM3.ResX[i];
      Crd_Y[i]:=adoptedM3.ResY[i];
      Crd_Z[i]:=adoptedM3.ResZ[i];
    end;
  end
  else if ad_type=2 then
  begin
    NPoints:=adm3.rn;
    SetLength(Crd_X,NPoints+1);
    SetLength(Crd_Y,NPoints+1);
    SetLength(Crd_Z,NPoints+1);
    for i:=1 to NPoints do
    begin
      Crd_X[i]:=adm3.ResX[i];
      Crd_Y[i]:=adm3.ResY[i];
      Crd_Z[i]:=adm3.ResZ[i];
    end;
  end
  else  // regular meshes
  begin                         // here nnx- analogue to R
    NPoints:=nnx*nny*nnz;        // here nny- analogue to Fi
    SetLength(Crd_X,NPoints+1);  // here nnz- analogue to Z
    SetLength(Crd_Y,NPoints+1);
    SetLength(Crd_Z,NPoints+1);
    { Visualisation }
    if nds then
    begin
      lb.Caption:='Nodes';
      ggb.Refresh;
      gg.MaxValue:=Nnz;
    end;
    { EOV }
    if mesh_s=0 then // cilindrical mesh
      for i:=1 to nnz do
      begin
        for j:=1 to nny do
          for k:=1 to nnx do
          begin
            num:=Num2Point(k,j,i);
            rr:= ax + NPoint2coord(k,disc_1,nd1);
            phi:=ay + NPoint2coord(j,disc_2,nd2);
            zz:= az + NPoint2coord(i,disc_3,nd3);
            Crd_X[num]:=rr*cos(phi*pi/180);
            Crd_Y[num]:=rr*sin(phi*pi/180);
            Crd_Z[num]:=zz;
          end;
        if nds then gg.Progress:=i;
      end
    else
      for i:=1 to nnz do
      begin
        for j:=1 to nny do
          for k:=1 to nnx do
          begin
            num:=Num2Point(k,j,i);
            xx:= ax + NPoint2coord(k,disc_1,nd1);
            yy:= ay + NPoint2coord(j,disc_2,nd2);
            zz:= az + NPoint2coord(i,disc_3,nd3);
            Crd_X[num]:=xx;
            Crd_Y[num]:=yy;
            Crd_Z[num]:=zz;
          end;
        if nds then gg.Progress:=i;
      end;
  end;
end;

procedure TAxialTask3.GenerateSources;
var i,j:int;
    im:int;
    xx,zz,yy:float;
    mgo:TMgObject;
begin
  NSources:=0;
  NMagnets:=0;
  NCharges:=0;
  NumberCharge:=nil;
  NumberMagnet:=nil;
  NumberSource:=nil;
  Charge_Ro:=nil;
  Magnet_X:=nil;
  Magnet_Y:=nil;
  Magnet_Z:=nil;
  Source:=nil;
  Source_X:=nil;
  Source_Y:=nil;
  Source_Z:=nil;
  Source_Xc:=nil;
  Source_Yc:=nil;
  Source_Zc:=nil;
  if nds then
  begin
    lb.Caption:='Creating Sources ...';
    ggb.Refresh;
    gg.MaxValue:=NElements;
  end;
  for i:=1 to NElements do
  begin
    im:=ATopology[i,0];
    GetCenter(i,xx,yy,zz);
    for j:=0 to ob.Count-1 do
    begin
      mgo:=ob.Items[j];
      if (mgo.GetMaterial=im)and(mgo.sr_kind<>0) then
        if mgo.IsPointInside(xx,yy,zz) then
        Case mgo.sr_kind of
          1:begin  //charge
              inc(NCharges);
              SetLength(NumberCharge,NCharges+1);
              SetLength(Charge_Ro,NCharges+1);
              NumberCharge[NCharges]:=i;
              Charge_Ro[NCharges]:=mgo.Ro(xx,yy,zz);
            end;
          2:begin  // magnet
              inc(NMagnets);
              SetLength(NumberMagnet,NMagnets+1);
              SetLength(Magnet_X,NMagnets+1);
              SetLength(Magnet_Y,NMagnets+1);
              SetLength(Magnet_Z,NMagnets+1);
              NumberMagnet[NMagnets]:=i;
              Magnet_X[NMagnets]:=mgo.Bx(xx,yy,zz);
              Magnet_Y[NMagnets]:=mgo.By(xx,yy,zz);
              Magnet_Z[NMagnets]:=mgo.Bz(xx,yy,zz);
            end;
          3:if Task=5 then
            begin
              inc(NSources);
              SetLength(NumberSource,NSources+1);
              SetLength(Source_Xc,NSources+1);
              SetLength(Source_Yc,NSources+1);
              SetLength(Source_Zc,NSources+1);
              NumberSource[NSources]:=i;
              Source_Xc[NSources]:=CDConv(mgo.Jx(xx,yy,zz)*cos(mgo.Phi(xx,yy,zz)/180*pi),mgo.Jx(xx,yy,zz)*sin(mgo.Phi(xx,yy,zz)/180*pi));
              Source_Yc[NSources]:=CDConv(mgo.Jy(xx,yy,zz)*cos(mgo.Phi(xx,yy,zz)/180*pi),mgo.Jy(xx,yy,zz)*sin(mgo.Phi(xx,yy,zz)/180*pi));
              Source_Zc[NSources]:=CDConv(mgo.Jz(xx,yy,zz)*cos(mgo.Phi(xx,yy,zz)/180*pi),mgo.Jz(xx,yy,zz)*sin(mgo.Phi(xx,yy,zz)/180*pi));
            end
            else if Task=3 then
            begin
              inc(NSources);
              SetLength(NumberSource,NSources+1);
              SetLength(Source_X,NSources+1);
              SetLength(Source_Y,NSources+1);
              SetLength(Source_Z,NSources+1);
              NumberSource[NSources]:=i;
              Source_X[NSources]:=mgo.Jx(xx,yy,zz);
              Source_Y[NSources]:=mgo.Jy(xx,yy,zz);
              Source_Z[NSources]:=mgo.Jz(xx,yy,zz);
            end
            else
            begin
              inc(NSources);
              SetLength(NumberSource,NSources+1);
              SetLength(Source,NSources+1);
              NumberSource[NSources]:=i;
              Source[NSources]:=0;
            end;
        end;
    end;
    if nds then gg.Progress:=i;
  end;
end;

procedure TAxialTask3.GenerateBounds(var bnd:TBounds3_data; MaxN:int);
var i,j,k,m:int;
  x1,x2,y1,y2,z1,z2:int;
begin
  NBounds:=0;
  NBounds_X:=0;
  NBounds_Y:=0;
  NBounds_Z:=0;
  NumberBound:=nil;
  PotentialBound:=nil;
  NumberBound_X:=nil;
  NumberBound_Y:=nil;
  NumberBound_Z:=nil;
  PotentialBound_X:=nil;
  PotentialBound_Y:=nil;
  PotentialBound_Z:=nil;
  PotentialBound_Xc:=nil;
  PotentialBound_Yc:=nil;
  PotentialBound_Zc:=nil;
  if nds then
  begin
    lb.Caption:='Applying Boundary conditions ...';
    ggb.Refresh;
  end;
  if bnd<>nil then
  begin
  if nds then
    if MaxN<0 then gg.MaxValue:=1 else gg.MaxValue:=MaxN;
  for i:=0 to MaxN-1 do
  begin
    if bnd[i].x1=-1 then x1:=nnx else x1:=bnd[i].x1;
    if bnd[i].y1=-1 then y1:=nny else y1:=bnd[i].y1;
    if bnd[i].z1=-1 then z1:=nnz else z1:=bnd[i].z1;
    if bnd[i].x2=-1 then x2:=nnx else x2:=bnd[i].x2;
    if bnd[i].y2=-1 then y2:=nny else y2:=bnd[i].y2;
    if bnd[i].z2=-1 then z2:=nnz else z2:=bnd[i].z2;
    Case bnd[i].dir of
      0:begin                // scalar
          for m:=z1 to z2 do
          for k:=y1 to y2 do
          for j:=x1 to x2 do
          begin
            inc(NBounds);
            SetLength(NumberBound,NBounds+1);
            SetLength(PotentialBound,NBounds+1);
            NumberBound[NBounds]:=Num2Point(j,k,m);
            PotentialBound[NBounds]:=bnd[i].val;
          end;
        end;
      1:for m:=z1 to z2 do   // x
        for k:=y1 to y2 do
        for j:=x1 to x2 do
        if Task<>5 then
        begin
          inc(NBounds_X);
          SetLength(NumberBound_X,NBounds_X+1);
          SetLength(PotentialBound_X,NBounds_X+1);
          NumberBound_X[NBounds_X]:=Num2Point(j,k,m);
          PotentialBound_X[NBounds_X]:=bnd[i].val;
        end
        else
        begin
          inc(NBounds_X);
          SetLength(NumberBound_X,NBounds_X+1);
          SetLength(PotentialBound_Xc,NBounds_X+1);
          NumberBound_X[NBounds_X]:=Num2Point(j,k,m);
          PotentialBound_Xc[NBounds_X]:=CDConv(bnd[i].val,bnd[i].vl_im);
        end;
      2:for m:=z1 to z2 do   // Y
        for k:=y1 to y2 do
        for j:=x1 to x2 do
        if Task<>5 then
        begin
          inc(NBounds_Y);
          SetLength(NumberBound_Y,NBounds_Y+1);
          SetLength(PotentialBound_Y,NBounds_Y+1);
          NumberBound_Y[NBounds_Y]:=Num2Point(j,k,m);
          PotentialBound_Y[NBounds_Y]:=bnd[i].val;
        end
        else
        begin
          inc(NBounds_Y);
          SetLength(NumberBound_Y,NBounds_Y+1);
          SetLength(PotentialBound_Yc,NBounds_Y+1);
          NumberBound_Y[NBounds_Y]:=Num2Point(j,k,m);
          PotentialBound_Yc[NBounds_Y]:=CDConv(bnd[i].val,bnd[i].vl_im);
        end;
      3:for m:=z1 to z2 do   // Z
        for k:=y1 to y2 do
        for j:=x1 to x2 do
        if Task<>5 then
        begin
          inc(NBounds_Z);
          SetLength(NumberBound_Z,NBounds_Z+1);
          SetLength(PotentialBound_Z,NBounds_Z+1);
          NumberBound_Z[NBounds_Z]:=Num2Point(j,k,m);
          PotentialBound_Z[NBounds_Z]:=bnd[i].val;
        end
        else
        begin
          inc(NBounds_Z);
          SetLength(NumberBound_Z,NBounds_Z+1);
          SetLength(PotentialBound_Zc,NBounds_Z+1);
          NumberBound_Z[NBounds_Z]:=Num2Point(j,k,m);
          PotentialBound_Zc[NBounds_Z]:=CDConv(bnd[i].val,bnd[i].vl_im);
        end;
    end;
    if nds then gg.Progress:=i;
  end;
  end;
  if adpt<>0 then
    for k:=1 to nnz do
    begin
      inc(NBounds);
      SetLength(NumberBound,NBounds+1);
      SetLength(PotentialBound,NBounds+1);
      NumberBound[NBounds]:=Npoints-nnz+k;
      PotentialBound[NBounds]:=bnd[MaxN-1].val;
    end;
  if nds then
  begin
    lb.Caption:='<< Done >>';
    ggb.Refresh;
    gg.Progress:=0;
  end;
end;

/////////
procedure TAxialTask3.PrepareData();
var i:int;
begin
  bx:=ax;
  by:=ay;
  bz:=az;
  for i:=1 to nd1 do bx:=bx+disc_1[i].num*disc_1[i].val;
  for i:=1 to nd2 do by:=by+disc_2[i].num*disc_2[i].val;
  for i:=1 to nd3 do bz:=bz+disc_3[i].num*disc_3[i].val;
  nnx:=1;
  nny:=1;
  nnz:=1;
  for i:=1 to nd1 do nnx:=nnx+disc_1[i].num;
  for i:=1 to nd2 do nny:=nny+disc_2[i].num;
  for i:=1 to nd3 do nnz:=nnz+disc_3[i].num;
  NPoints:=nnx*nny*nnz;
  NElements:=(nnx-1)*(nny-1)*(nnz-1)*tic;
end;

{==============================================================================}
{===============================  PROTECTED  ==================================}
{==============================================================================}
function TAxialTask3.GetMat(xx,yy,zz:float):int;
{ Определяет номер материала точки заданной координатами (xx,yy,zz) }
var i,mm:int; // текущий номер материала
    mgo:TMgObject;
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

procedure TAxialTask3.GetCenter(iElement:int; var x,y,z:float);
var i:int;
begin
  x:=0;
  y:=0;
  z:=0;
  for i:=1 to 4 do
  begin
    x:=x+Crd_X[ATopology[iElement,i]];
    y:=y+Crd_Y[ATopology[iElement,i]];
    z:=z+Crd_Z[ATopology[iElement,i]];
  end;
  x:=x/4;
  y:=y/4;
  z:=z/4;
end;

///////////////////////////////
procedure TAxialTask3.Cube2Num(NCube:int; var ncr,ncf,ncz:int);
var
  k:int;
begin
  ncz:=1+(NCube div ((nnx-1)*(nny-1)));
  k:=NCube mod ((nnx-1)*(nny-1));
  if k=0 then
  begin
    k:=(nnx-1)*(nny-1);
    ncz:=ncz-1;
  end;
  ncf:=1+(k div (nnx-1));
  ncr:=k mod (nnx-1);
  if ncr=0 then
  begin
    ncr:=nnx-1;
    ncf:=ncf-1;
  end;
end;

procedure TAxialTask3.Point2Num(NPoint:int; var npr,npf,npz:int);
var k:int;
begin
  npz:=1+(NPoint div (nnx*nny));
  k:=NPoint mod (nnx*nny);
  if k=0 then
  begin
    k:=nnx*nny;
    npz:=npz-1;
  end;
  npf:=1+(k div nnx);
  npr:=k mod nnx;
  if npr=0 then
  begin
    npr:=nnx;
    npf:=npf-1;
  end;
end;

function TAxialTask3.Num2Cube(ncr,ncf,ncz:int):int;
begin
  Result:=(ncz-1)*(nnx-1)*(nny-1)+(ncf-1)*(nnx-1)+ncr
end;

function TAxialTask3.Num2Point(npr,npf,npz:int):int;
begin
  Result:=(npz-1)*nnx*nny+(npf-1)*nnx+npr
end;

{==============================================================================}
{============================  END OF CLASSES  ================================}
{==============================================================================}
end.

