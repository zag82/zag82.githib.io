unit Complx;
interface

uses cm_ini;

const
  CNull : TComplex = (re:0.0; im:0.0);

function CAdd(a,b : TComplex) : TComplex;
function CSub(a,b : TComplex) : TComplex;
function CMul(a,b : TComplex) : TComplex;
function CDiv(a,b : TComplex) : TComplex;
function CAbs(a : TComplex) : float;
function CPhase(a : TComplex) : float;
function CPhaseD(a : TComplex) : float;
function CInv(a : TComplex) : TComplex;
function CSqr(a : TComplex) : TComplex;
function CSqrt(a : TComplex) : TComplex;
function CLn(a : TComplex) : TComplex;
function CExp(a : TComplex) : TComplex;
function CSin(a : TComplex) : TComplex;
function CCos(a : TComplex) : TComplex;
function CSh(a : TComplex) : TComplex;
function CCh(a : TComplex) : TComplex;
function CTg(a : TComplex) : TComplex;
function CConv(a : float) : TComplex;
function CDConv(a,b : float) : TComplex;
function CNeg(a : TComplex) : TComplex;
//================= Andrew+
procedure CAddTo(var a:TComplex; b:TComplex);
procedure CSubTo(var a:TComplex; b:TComplex);
procedure CMulTo(var a:TComplex; b:TComplex);
procedure CDivTo(var a:TComplex; b:TComplex);
//================= Andrew=

implementation

uses
  SpecMat, SysUtils;

function CAdd(a,b : TComplex) : TComplex;
begin
  CAdd.Re:=a.Re+b.Re;
  CAdd.Im:=a.Im+b.Im
end;

function CSub(a,b : TComplex) : TComplex;
begin
  CSub.Re:=a.Re-b.Re;
  CSub.Im:=a.Im-b.Im
end;

function CMul(a,b : TComplex) : TComplex;
begin
  CMul.Re:=a.Re*b.Re-a.Im*b.Im;
  CMul.Im:=a.Im*b.Re+a.Re*b.Im
end;

function CDiv(a,b : TComplex) : TComplex;
var
  c,d,e:double;
begin
  c:=b.Re*b.Re+b.Im*b.Im;
  d:=(a.Re*b.Re+a.Im*b.Im)/c;
  e:=(a.Im*b.Re-a.Re*b.Im)/c;
  if (Abs(e)<1e35)and(Abs(d)<1e35) then
  begin
    CDiv.Re:=d;
    CDiv.Im:=e;
  end
  else
  begin
    CDiv.Re:=0;
    CDiv.Im:=0;
  end;
end;

function CAbs(a : TComplex) : float;
begin
  CAbs:=Sqrt(a.Re*a.Re+a.Im*a.Im)
end;

//=========================== Andrew +
function CPhase(a : TComplex) : float;    // phase in radians
begin
  Result:=ArcTng(a.Re,a.Im);
end;

function CPhaseD(a : TComplex) : float;  // phase in degrees
begin
  Result:=CPhase(a)*180/pi;
end;

//=========================== Andrew =

function CInv(a : TComplex) : TComplex;
begin
  CInv.Re:=a.Re;
  CInv.Im:=-a.Im;
end;

function CSqr(a : TComplex) : TComplex;
begin
  CSqr.Re:=a.Re*a.Re-a.Im*a.Im;
  CSqr.Im:=2*a.Re*a.Im
end;

function CSqrt(a : TComplex) : TComplex;
begin
  CSqrt.Re:=Sqrt((a.Re+Sqrt(a.Re*a.Re+a.Im*a.Im))/2);
  CSqrt.Im:=Sqrt((-a.Re+Sqrt(a.Re*a.Re+a.Im*a.Im))/2)
end;

function CLn(a : TComplex) : TComplex;
var
  t : TComplex;
begin
  t.Re:=ln(a.Re*a.Re+a.Im*a.Im)/2;
  t.Im:=ArcTan(a.Im/a.Re);
  if (a.Re<0) and (a.Im>=0) then
    t.Im:=t.Im+Pi
  else if (a.Im<0) and (a.Re>=0) then
    t.Im:=t.Im-Pi;
  CLn:=t
end;

function CExp(a : TComplex) : TComplex;
begin
  CExp.Re:=Exp(a.Re)*Cos(a.Im);
  CExp.Im:=Exp(a.Re)*Sin(a.Im)
end;

function CSin(a : TComplex) : TComplex;
begin
  CSin.Re:=Sin(a.Re)*Ch(a.Im);
  CSin.Im:=Cos(a.Re)*Sh(a.Im)
end;

function CCos(a : TComplex) : TComplex;
begin
  CCos.Re:=Cos(a.Re)*Ch(a.Im);
  CCos.Im:=-Sin(a.Re)*Sh(a.Im)
end;

function CSh(a : TComplex) : TComplex;
begin
  CSh.Re:=Sh(a.Re)*Cos(a.Im);
  CSh.Im:=Ch(a.Re)*Sin(a.Im)
end;

function CCh(a : TComplex) : TComplex;
begin
  CCh.Re:=Ch(a.Re)*Cos(a.Im);
  CCh.Im:=Sh(a.Re)*Cos(a.Im)
end;

function CTg(a : TComplex) : TComplex;
begin
  CTg.Re:=Sin(2*a.Re)/(Cos(2*a.Re)+Ch(2*a.Im));
  CTg.Im:=Sh(2*a.Im)/(Cos(2*a.Re)+Ch(2*a.Im))
end;

function CConv(a : float) : TComplex;
begin
  CConv.Re:=a;
  CConv.Im:=0
end;

function CDConv(a,b : float) : TComplex;
begin
  CDConv.Re:=a;
  CDConv.Im:=b
end;

function CNeg(a : TComplex) : TComplex;
begin
  CNeg.Re:=-a.re;
  CNeg.Im:=-a.im
end;

//================= Andrew+
procedure CAddTo(var a:TComplex; b:TComplex);
var tt:TComplex;
begin
  tt.re:=a.re+b.re;
  tt.im:=a.im+b.im;
  a:=tt;
end;

procedure CSubTo(var a:TComplex; b:TComplex);
var tt:TComplex;
begin
  tt.re:=a.re-b.re;
  tt.im:=a.im-b.im;
  a:=tt;
end;

procedure CMulTo(var a:TComplex; b:TComplex);
var tt:TComplex;
begin
  tt.Re:=a.Re*b.Re-a.Im*b.Im;
  tt.Im:=a.Im*b.Re+a.Re*b.Im;
  a:=tt;
end;

procedure CDivTo(var a:TComplex; b:TComplex);
var
  tt:TComplex;
  c : Extended;
begin
  c:=b.Re*b.Re+b.Im*b.Im;
  if (Abs(c)>1e-30)and(Abs(c)<1e30) then
  begin
    tt.Re:=(a.Re*b.Re+a.Im*b.Im)/c;
    tt.Im:=(a.Im*b.Re-a.Re*b.Im)/c
  end
  else
  begin
    tt.Re:=0;
    tt.Im:=0;
  end;
  a:=tt;
end;

//================= Andrew=

end.
