unit god2;

interface
uses cm_ini, cmData, Complx;

const
  m=2;
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
    ds:double;
    ph1,ph2,dph:double;
    i,k1,k2:int;
begin
  sm1:=sqrt(sqr(ge.fdata1[1])+sqr(ge.fdata2[1]));
  sm2:=sqrt(sqr(gx.fdata1[1])+sqr(gx.fdata2[1]));
  k1:=1;
  k2:=1;
  for i:=1 to ge.num do
  begin
    sm:=sqrt(sqr(ge.fdata1[i])+sqr(ge.fdata2[i]));
    if sm>sm1 then begin sm1:=sm; k1:=i; end;
  end;
  for i:=1 to gx.num do
  begin
    sm:=sqrt(sqr(gx.fdata1[i])+sqr(gx.fdata2[i]));
    if sm>sm2 then begin sm2:=sm; k2:=i; end;
  end;
  ph1:=ArcTng(ge.fdata1[k1],ge.fdata2[k1]);
  ph2:=ArcTng(gx.fdata1[k2],gx.fdata2[k2]);
  ////////////////
  if Abs(sm1)<1e-10 then ds:=Abs(sm1-sm2) else ds:=Abs((sm2-sm1)/sm1);
  if Abs(ph1-ph2)>pi then dph:=6*(Abs(ph1-ph2)-pi)/pi else dph:=6*Abs(ph1-ph2)/pi;
  //////////
  sm:=sqrt(sqr(ds)+sqr(dph));
  //sm:=sm/ge.num;
  Result:=sm;
end;

{
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
end;
 }
procedure TOptimize.ApplyToObject;
begin
  TSector(ob.Items[ob.Count-1]).h:=profile[1];
  TSector(ob.Items[ob.Count-1]).zz:=-profile[1]/2;
  TSector(ob.Items[ob.Count-1]).r1:=TSector(ob.Items[ob.Count-1]).r2-profile[2];
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
    //vv:=CDConv(4.993465E-0003,3.597519E-0002);
    //for i:=1 to 21 do sg1[i]:=CSub(sg1[i],vv);
    AssignFile(f,sx);
    Rewrite(f);
    writeln(f,21);
    for i:=1 to 21 do
      writeln(f,1e6/14.56*sg1[i].re:15,#09,1e6/14.56*sg1[i].im:15);
    CloseFile(f);
  end;
begin
  SetLength(sg1,22);
  SetLength(sg2,22);
  for i:=1 to 21 do
  begin
    TSector(ob.Items[ob.Count-1]).zz:=TSector(ob.Items[ob.Count-1]).h/2+(i-12)*0.001;
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
//                                  EOF                                       //
////////////////////////////////////////////////////////////////////////////////

end.
