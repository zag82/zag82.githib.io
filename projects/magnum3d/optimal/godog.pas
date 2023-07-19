unit godog;

interface

uses cm_ini, cmData, Complx;

const
  m=9;
  n=m+1;

  alfa=1.0;
  beta=0.5;
  gamma=2.0;

type
  vector=array[1..n]of double;
  vic=array[1..n]of integer;

  TGodograph=class
  public
    num:int;
    fdata1:array of float;
    fdata2:array of float;
    function LoadData(s:string):boolean;
    procedure AssignData(var d1,d2:array of float; n:int);
    procedure FreeData;
  end;

  TOptimize=class
  private
    procedure GetFourierKoefficient(k:int; gg:TGodograph; var r1,r2:float);
  public
    q:int;        // sort of profile
    ge:TGodograph;
    gx:TGodograph;
    se:string;
    sx:string;
    profile:vector;
    procedure SetData(sse,ssx:string);
    procedure LoadFiles;
    procedure FreeData;
    function GetError:double;
    procedure ApplyToObject;
    procedure RunSolver;
  end;

  TOpSec=class(TMgObject)
  public
    { Public declarations }
    al,bt:float;
    z0:float;
    dz:float;
    profile:vector;
    R_max:float;
    constructor Create(m:int; nm:string);
    function IsPointInside(x,y,z:float):boolean;override;
    procedure SetData(z_0,delta_z,rmax,alpha,betta:float);
    ///////////////////////
    function Ro(x,y,z:float):float;override;
    function Phi(x,y,z:float):float;override;
    ///////////////////////
    function Jx(x,y,z:float):float;override;
    function Jy(x,y,z:float):float;override;
    function Jz(x,y,z:float):float;override;
    ////////////////////////
    function Bx(x,y,z:float):float;override;
    function By(x,y,z:float):float;override;
    function Bz(x,y,z:float):float;override;
  end;

  TOpSecR=class(TMgObject)
  public
    { Public declarations }
    al,bt:float;
    z0:float;
    dz:float;
    profile:vector;
    R_max:float;
    constructor Create(m:int; nm:string);
    function IsPointInside(x,y,z:float):boolean;override;
    procedure SetData(z_0,delta_z,rmax,alpha,betta:float);
    ///////////////////////
    function Ro(x,y,z:float):float;override;
    function Phi(x,y,z:float):float;override;
    ///////////////////////
    function Jx(x,y,z:float):float;override;
    function Jy(x,y,z:float):float;override;
    function Jz(x,y,z:float):float;override;
    ////////////////////////
    function Bx(x,y,z:float):float;override;
    function By(x,y,z:float):float;override;
    function Bz(x,y,z:float):float;override;
  end;

var
  opt:TOptimize;

implementation

uses specMat, cmVars, cmProc;

////////////////////////////////////////////////////////////////////////////////
//                            TGodograph                                      //
////////////////////////////////////////////////////////////////////////////////
function TGodograph.LoadData(s:string):boolean;
var f:TextFile;
    i:integer;
    v1,v2:double;
begin
  {$I-}
  AssignFile(f,s);
  Reset(f);
  readln(f,num);
  SetLength(fdata1,num+1);
  SetLength(fdata2,num+1);
  for i:=1 to num do
  begin
    readln(f,v1,v2);
    fdata1[i]:=v1/1e3;
    fdata2[i]:=v2/1e3;
  end;
  CloseFile(f);
  {$I+}
  if IOResult<>0 then
  begin
    FreeData;
    Result:=false;
  end
  else
    Result:=true;
end;

procedure TGodograph.AssignData(var d1,d2:array of float; n:int);
var i:int;
begin
  FreeData;
  num:=n;
  SetLength(fdata1,n+1);
  SetLength(fdata2,n+1);
  for i:=1 to num do
  begin
    fdata1[i]:=d1[i];
    fdata1[i]:=d1[i];
  end;
end;

procedure TGodograph.FreeData;
begin
  num:=0;
  fdata1:=nil;
  fdata2:=nil;
end;

////////////////////////////////////////////////////////////////////////////////
//                            TOptimize                                       //
////////////////////////////////////////////////////////////////////////////////
procedure TOptimize.SetData(sse,ssx:string);
begin
  se:=sse;
  sx:=ssx;
  ge:=TGodograph.Create;
  gx:=TGodograph.Create;
end;

procedure TOptimize.LoadFiles;
begin
  ge.LoadData(se);
  gx.LoadData(sx);
end;

procedure TOptimize.FreeData;
begin
  se:='';
  sx:='';
  ge.FreeData;
  gx.FreeData;
end;

procedure TOptimize.GetFourierKoefficient(k:int; gg:TGodograph; var r1,r2:float);
var i:int;
    w:float;
begin
  r1:=0;
  r2:=0;
  for i:=1 to gg.num do
  begin
    w:=-2*pi/gg.num*(i-1)*k;
    r1:=r1+(gg.fdata1[i]*cos(w)-gg.fdata2[i]*sin(w));
    r2:=r2+(gg.fdata1[i]*sin(w)+gg.fdata2[i]*cos(w));
  end;
  r1:=r1/gg.num;
  r2:=r2/gg.num;
end;


function TOptimize.GetError:double;
var sm,sm1,sm2:double;
    i:int;
begin
  sm1:=0;
  sm2:=0;
  for i:=1 to ge.num do
  begin
    sm1:=sm1+abs(ge.fdata1[i]-gx.fdata1[i]);
    sm2:=sm2+abs(ge.fdata2[i]-gx.fdata2[i]);
  end;
  sm:=sqrt(sqr(sm1)+sqr(sm2));
  //sm:=sm/ge.num;
  Result:=sm;
end;
{
function TOptimize.GetError:double;
var sm,sm1,sm2:float;
    i:int;
    te,tx:array[1..5,1..2]of float;
begin
  sm1:=0;
  sm2:=0;
  for i:=1 to 5 do
  begin
    GetFourierKoefficient(i,ge,sm1,sm2);
    te[i][1]:=sm1;
    te[i][2]:=sm2;
    GetFourierKoefficient(i,gx,sm1,sm2);
    tx[i][1]:=sm1;
    tx[i][2]:=sm2;
  end;
  sm:=0;
  for i:=1 to 5 do
  begin
    sm:=sm+abs(te[i,1]-tx[i,1])+abs(te[i,2]-tx[i,2]);
  end;
  Result:=sm;
end; }

procedure TOptimize.ApplyToObject;
begin
  if q=0 then
    TOpSec(ob.Items[ob.Count-1]).profile:=profile
  else
    TOpSecR(ob.Items[ob.Count-1]).profile:=profile;
end;

procedure TOptimize.RunSolver;
var i,j:int;
    w3:double;
    rm:int;
    rr:float;
    sg1:array of TComplex;
    sg2:array of TComplex;
  procedure SaveGod;
  var f:TextFile;
      i:integer;
      vv:TComplex;
  begin
    vv:=CNull;
    //vv:=CDConv(4.993465E-0003,3.597519E-0002);
    for i:=1 to 21 do sg1[i]:=CSub(sg1[i],vv);
    AssignFile(f,sx);
    Rewrite(f);
    writeln(f,21);
    for i:=1 to 21 do
      writeln(f,1e3*sg1[i].re:15,#09,1e3*sg1[i].im:15);
    CloseFile(f);
  end;
begin
  SetLength(sg1,22);
  SetLength(sg2,22);
  for i:=1 to 21 do
  begin
    if q=0 then
      TOpSec(ob.Items[ob.Count-1]).z0:=-0.010+(i-1)*0.001
    else
      TOpSecR(ob.Items[ob.Count-1]).z0:=-0.010+(i-1)*0.001;
    mt.GenerateAllProperties(Task);
    tt.nds:=false;
    tt.SetShower(nil,nil,nil);
    tt.PrepareData;
    // prepare to solution
    tt.GenerateNodes();
    tt.GenerateTopology();
    tt.GenerateBounds(bnd2,Nbnd2);
    // define solution arrays
    tt.GenerateTopMat();
    tt.GenerateSources();
    // starting solution
    tt.PrepareMatrix;
    tt.PrepareSolution;
    j:=0;
    repeat
      w3:=tt.MakeSolutionStep;
      j:=j+1;
    until (j>=ps.wMIter2d)or(w3<ps.wError2d);
    ///////////////////////////////////////
    with TSector(ob.Items[0])do
    begin
      rm:=iMaterial;
      rr:=(r1+r2)/2;
    end;
    sg1[i]:=GetSignal_Axial_2(rm,rr);
    rm:=rm+1;
    sg2[i]:=GetSignal_Axial_2(rm,rr);
    sg1[i]:=CSub(sg1[i],sg2[i]);
    sg2[i]:=CNull;
  end;
  SaveGod;
end;

////////////////////////////////////////////////////////////////////////////////
//                               TOpSec                                       //
////////////////////////////////////////////////////////////////////////////////
constructor TOpSec.Create(m:int; nm:string);
begin
  inherited Create(m,nm);
end;

function TOpSec.IsPointInside(x,y,z:float):boolean;
const delta=1e-11;
var rr,phi:float;
    r_1,r_2:boolean;
    i:int;
  function Det(a1,a2,a3,b1,b2,b3,c1,c2,c3:float):float;
  begin
    Result:=0.5*( a1*(b2*c3-b3*c2)+a2*(b3*c1-b1*c3)+a3*(b1*c2-b2*c1) );
  end;
  function CellInside(k:int):boolean;
  var z1,z2,r1,r2:float;
      b1,b2:boolean;
      s:float;
  begin
    r1:=R_max-profile[k];
    r2:=R_max-profile[k+1];
    z1:=z0+dz*(k-5);
    z2:=z0+dz*(k-4);
    s:=Det(1,r2,z2,1,r1,z1,1,rr,z);
    b1:=(delta<=z-z1)and(delta<=z2-z);
    b2:=(s>=delta)and(delta<=R_max-rr);
    Result:=(b1 and b2);
  end;
begin
  rr:=sqrt(sqr(x)+sqr(y));
  phi:=ArcTng(x,y)/pi*180;
  r_2:=(delta<=phi-al)and(delta<=bt-phi);
  r_1:=false;
  for i:=1 to 8 do
    r_1:=r_1 or CellInside(i);
  Result:=(r_1)and(r_2);
end;

procedure TOpSec.SetData(z_0,delta_z,rmax,alpha,betta:float);
begin
  al:=alpha;
  bt:=betta;
  z0:=z_0;
  dz:=delta_z;
  r_max:=rmax;
end;

function TOpSec.Ro(x,y,z:float):float; begin Result:=0; end;
function TOpSec.Phi(x,y,z:float):float; begin Result:=0; end;
function TOpSec.Jx(x,y,z:float):float; begin Result:=0; end;
function TOpSec.Jy(x,y,z:float):float; begin Result:=0; end;
function TOpSec.Jz(x,y,z:float):float; begin Result:=0; end;
function TOpSec.Bx(x,y,z:float):float; begin Result:=0; end;
function TOpSec.By(x,y,z:float):float; begin Result:=0; end;
function TOpSec.Bz(x,y,z:float):float; begin Result:=0; end;

////////////////////////////////////////////////////////////////////////////////
//                               TOpSecR                                      //
////////////////////////////////////////////////////////////////////////////////
constructor TOpSecR.Create(m:int; nm:string);
begin
  inherited Create(m,nm);
end;

function TOpSecR.IsPointInside(x,y,z:float):boolean;
const delta=1e-11;
var rr,phi:float;
    r_1,r_2:boolean;
    i:int;
  function CellInside(k:int):boolean;
  var z1,z2,r1:float;
      b1,b2:boolean;
      s:float;
  begin
    r1:=R_max-profile[k];
    z1:=z0+dz*(k-5.5);
    z2:=z1+dz;
    b1:=(delta<=z-z1)and(delta<=z2-z);
    b2:=(delta<=rr-r1)and(delta<=R_max-rr);
    //b2:=(delta<=rr-R_max)and(delta<=r1-rr);
    Result:=(b1 and b2);
  end;
begin
  rr:=sqrt(sqr(x)+sqr(y));
  phi:=ArcTng(x,y)/pi*180;
  r_2:=(delta<=phi-al)and(delta<=bt-phi);
  r_1:=false;
  for i:=1 to 9 do
    r_1:=r_1 or CellInside(i);
  Result:=(r_1)and(r_2);
end;

procedure TOpSecR.SetData(z_0,delta_z,rmax,alpha,betta:float);
begin
  al:=alpha;
  bt:=betta;
  z0:=z_0;
  dz:=delta_z;
  r_max:=rmax;
end;

function TOpSecR.Ro(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.Phi(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.Jx(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.Jy(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.Jz(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.Bx(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.By(x,y,z:float):float; begin Result:=0; end;
function TOpSecR.Bz(x,y,z:float):float; begin Result:=0; end;

////////////////////////////////////////////////////////////////////////////////
//                                  EOF                                       //
////////////////////////////////////////////////////////////////////////////////
end.
