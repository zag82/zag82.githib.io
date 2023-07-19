unit ado3;

interface

uses cm_ini;

type
  TPointAd=record
    x,y,z:float;
  end;

  TAdoMesh3d=class
  protected
    nnx,nny,nnz:int;
    procedure Point2Num(NPoint:int; var npx,npy,npz:int);
    procedure GetNumsX(npx:int; var ix,jx:int);
    procedure GetNumsY(npy:int; var iy,jy:int);
    procedure GetNumsZ(npz:int; var iz,jz:int);
    procedure CalcCoord(ix,jx,iy,jy,iz,jz:int;var x0,y0,z0:float);
  private
    numx:int;
    numy:int;
    numz:int;
    pts:array of array of array of TPointAd;
    quantX:array of int;
    quantY:array of int;
    quantZ:array of int;
  public
    rn:int;
    resX:array of float;
    resY:array of float;
    resZ:array of float;
    procedure LoadFromFile(fName:string);
    procedure GenerateTop3;
  end;


var
  adm3:TAdoMesh3D;

implementation

////////////////////////////////////////////////////////////////////////////////
//                               TAdoptedMesh                                 //
////////////////////////////////////////////////////////////////////////////////
procedure TAdoMesh3d.Point2Num(NPoint:int; var npx,npy,npz:int);
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

procedure TAdoMesh3d.GetNumsX(npx:int; var ix,jx:int);
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

procedure TAdoMesh3d.GetNumsY(npy:int; var iy,jy:int);
var i,k:int;
begin
  k:=1;
  for i:=1 to numY-1 do
  begin
    k:=k+quantY[i];
    if k>=npy then
    begin
      iy:=i;
      jy:=npy-(k-quantY[i]);
      break;
    end;
  end;
end;

procedure TAdoMesh3d.GetNumsZ(npz:int; var iz,jz:int);
var i,k:int;
begin
  k:=1;
  for i:=1 to numZ-1 do
  begin
    k:=k+quantZ[i];
    if k>=npz then
    begin
      iz:=i;
      jz:=npz-(k-quantZ[i]);
      break;
    end;
  end;
end;

procedure TAdoMesh3d.CalcCoord(ix,jx,iy,jy,iz,jz:int;var x0,y0,z0:float);
var x1,x2,x3,x4,x5,x6,
    y1,y2,y3,y4,y5,y6,
    z1,z2,z3,z4,z5,z6:float;
    x:array[1..8]of float;
    y:array[1..8]of float;
    z:array[1..8]of float;
    kx,ky,kz:float;
begin
  ////////////////////
  kx:=jx/quantX[ix];
  ky:=jy/quantY[iy];
  kz:=jz/quantZ[iz];
  ////////////////////
  x[1]:=pts[ix+0,iy+0,iz+0].x; y[1]:=pts[ix+0,iy+0,iz+0].y; z[1]:=pts[ix+0,iy+0,iz+0].z;
  x[2]:=pts[ix+1,iy+0,iz+0].x; y[2]:=pts[ix+1,iy+0,iz+0].y; z[2]:=pts[ix+1,iy+0,iz+0].z;
  x[3]:=pts[ix+0,iy+1,iz+0].x; y[3]:=pts[ix+0,iy+1,iz+0].y; z[3]:=pts[ix+0,iy+1,iz+0].z;
  x[4]:=pts[ix+1,iy+1,iz+0].x; y[4]:=pts[ix+1,iy+1,iz+0].y; z[4]:=pts[ix+1,iy+1,iz+0].z;
  x[5]:=pts[ix+0,iy+0,iz+1].x; y[5]:=pts[ix+0,iy+0,iz+1].y; z[5]:=pts[ix+0,iy+0,iz+1].z;
  x[6]:=pts[ix+1,iy+0,iz+1].x; y[6]:=pts[ix+1,iy+0,iz+1].y; z[6]:=pts[ix+1,iy+0,iz+1].z;
  x[7]:=pts[ix+0,iy+1,iz+1].x; y[7]:=pts[ix+0,iy+1,iz+1].y; z[7]:=pts[ix+0,iy+1,iz+1].z;
  x[8]:=pts[ix+1,iy+1,iz+1].x; y[8]:=pts[ix+1,iy+1,iz+1].y; z[8]:=pts[ix+1,iy+1,iz+1].z;
  ////////////////////
  x1:=x[1]+(x[5]-x[1])*kz; y1:=y[1]+(y[5]-y[1])*kz; z1:=z[1]+(z[5]-z[1])*kz;
  x2:=x[2]+(x[6]-x[2])*kz; y2:=y[2]+(y[6]-y[2])*kz; z2:=z[2]+(z[6]-z[2])*kz;
  x3:=x[3]+(x[7]-x[3])*kz; y3:=y[3]+(y[7]-y[3])*kz; z3:=z[3]+(z[7]-z[3])*kz;
  x4:=x[4]+(x[8]-x[4])*kz; y4:=y[4]+(y[8]-y[4])*kz; z4:=z[4]+(z[8]-z[4])*kz;
  ////////////////////
  x5:=x1+(x3-x1)*ky; y5:=y1+(y3-y1)*ky; z5:=z1+(z3-z1)*ky;
  x6:=x2+(x4-x2)*ky; y6:=y2+(y4-y2)*ky; z6:=z2+(z4-z2)*ky;
  ////////////////////
  x0:=x5+(x6-x5)*kx;
  y0:=y5+(y6-y5)*kx;
  z0:=z5+(z6-z5)*kx;
end;

procedure TAdoMesh3d.LoadFromFile(fName:string);
var f:TextFile;
    i,j,k,i1,i2,i3:int;
    v1,v2,v3:float;
begin
  AssignFile(f,fName);
  Reset(f);
  readln(f,i1,i2,i3);
  numx:=i1;
  numy:=i2;
  numz:=i3;
  SetLength(quantX,numX);
  SetLength(quantY,numY);
  SetLength(quantZ,numZ);
  SetLength(pts,numX+1);
  for i:=1 to numX do SetLength(pts[i],numY+1);
  for i:=1 to numX do for j:=1 to numY do SetLength(pts[i,j],numZ+1);
  readln(f);
  for k:=1 to numZ do
  begin
    for i:=1 to numY do
    begin
      for j:=1 to numX do
      begin
        read(f,v1,v2,v3);
        pts[j,i,k].x:=v1/1000;
        pts[j,i,k].y:=v2/1000;
        pts[j,i,k].z:=v3/1000;
      end;
      readln(f);
    end;
    readln(f);
  end;
  for i:=1 to numX-1 do
  begin
    read(f,i1);
    quantX[i]:=i1;
  end;
  readln(f);
  for i:=1 to numY-1 do
  begin
    read(f,i2);
    quantY[i]:=i2;
  end;
  readln(f);
  for i:=1 to numZ-1 do
  begin
    read(f,i3);
    quantZ[i]:=i3;
  end;
  readln(f);
  CloseFile(f);
  nnx:=1; for i:=1 to numX-1 do nnx:=nnx+quantX[i];
  nny:=1; for i:=1 to numY-1 do nny:=nny+quantY[i];
  nnz:=1; for i:=1 to numZ-1 do nnz:=nnz+quantZ[i];
  rn:=nnx*nny*nnz;
  SetLength(ResX,rn+1);
  SetLength(ResY,rn+1);
  SetLength(ResZ,rn+1);
end;

procedure TAdoMesh3d.GenerateTop3;
var i:int;
    npx,npy,npz:int;
    ix,jx,iy,jy,iz,jz:int;
    x0,y0,z0:float;
begin
  for i:=1 to rn do
  begin
    Point2Num(i,npx,npy,npz);
    GetNumsX(npx,ix,jx);
    GetNumsY(npy,iy,jy);
    GetNumsZ(npz,iz,jz);
    CalcCoord(ix,jx,iy,jy,iz,jz,x0,y0,z0);
    ResX[i]:=x0;
    ResY[i]:=y0;
    ResZ[i]:=z0;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//                            END OF CLASSES                                  //
////////////////////////////////////////////////////////////////////////////////
end.
