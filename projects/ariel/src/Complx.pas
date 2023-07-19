{*------------------------------------------------------------------------------
  ������ ����������� ������������ ���� ������ � �������� ��� ���

  �������� ���������, ����������� �������������� �������� ��� ������������
  �������

  @Author    ������� ��, ���(��), ������ 2005-2007
  @Version   4.0 Build 255
-------------------------------------------------------------------------------}
unit Complx;
interface

type
  TComplexInt = record
    re: smallint;
    im: smallint;
  end;

  /// ��� ����������� �����
  TComplex=record
    re:double; /// �������������� ����� ������������ �����
    im:double; /// ������ ����� ������������ �����
  end;

const
  /// ����������� ����
  CNull : TComplex = (re:0; im:0);

function CAdd(a,b : TComplex) : TComplex;     // ��������
function CSub(a,b : TComplex) : TComplex;     // ���������
function CMul(a,b : TComplex) : TComplex;     // ���������
function CDiv(a,b : TComplex) : TComplex;     // �������
function CAbs(a : TComplex) : double;         // ������
function CPhase(a : TComplex) : double;       // ���� � ��������
function CPhaseD(a : TComplex) : double;      // ���� � ��������
function CInv(a : TComplex) : TComplex;       // ����������-����������� �����
function CSqr(a : TComplex) : TComplex;       // ���������� � �������
function CSqrt(a : TComplex) : TComplex;      // ���������� ����������� �����
function CLn(a : TComplex) : TComplex;        // ����������� ��������
function CExp(a : TComplex) : TComplex;       // ����������
function CSin(a : TComplex) : TComplex;       // ����� ������������ ���������
function CCos(a : TComplex) : TComplex;       // ������� ������������ ���������
function CSh(a : TComplex) : TComplex;        // ��������������� �����
function CCh(a : TComplex) : TComplex;        // ��������������� �������
function CTg(a : TComplex) : TComplex;        // ��������������� �������

{
  �������������� ������������� ����� � ������������

  a - �������������� �����
  b - ������ �����
}
function CConv(a : double) : TComplex;
function CDConv(a,b : double) : TComplex;

function CNeg(a : TComplex) : TComplex;       // ������� �����

procedure CAddTo(var a:TComplex; b:TComplex);
procedure CSubTo(var a:TComplex; b:TComplex);
procedure CMulTo(var a:TComplex; b:TComplex);
procedure CDivTo(var a:TComplex; b:TComplex);

// Mathematical functions
function Sh(a : double) : double; { ����� ��������������� sh(a) }
function Ch(a : double) : double; { ������� ��������������� ch(a) }
function ArcTng(x,y : double) : double; { y��� ����y �����p�� (x,y) � ���� OX }

function min(a, b: integer): integer; overload;
function min(a, b: double): double; overload;
function max(a, b: integer): integer; overload;
function max(a, b: double): double; overload;


implementation

uses
  SysUtils;

function min(a, b: integer): integer; overload;
begin
  if a < b then Result := a else Result := b;
end;

function min(a, b: double): double; overload;
begin
  if a < b then Result := a else Result := b;
end;

function max(a, b: integer): integer; overload;
begin
  if a > b then Result := a else Result := b;
end;

function max(a, b: double): double; overload;
begin
  if a > b then Result := a else Result := b;
end;

{*------------------------------------------------------------------------------
  ����� ��������������� sh(a)
                                                                                
  @param a   �������� ������� ���������������� ������
  @return double     ����� ���������������
------------------------------------------------------------------------------*}
function Sh(a : double) : double;
begin
  Sh:=(Exp(a)-Exp(-a))/2
end;

{*------------------------------------------------------------------------------
  ������� ��������������� ch(a)
                                                                                
  @param a   �������� ������� ���������������� ��������
  @return double   ������� ���������������  
------------------------------------------------------------------------------*}
function Ch(a : double) : double;
begin
  Ch:=(Exp(a)+Exp(-a))/2
end;

{*------------------------------------------------------------------------------
  ���������� - ���������� �������� ���� � ��������� (-pi; pi]
                                                                                
  @param x   �������������� ����������
  @param y   ������ ����������
  @return double   ���������� ��������� y � x  
------------------------------------------------------------------------------*}
function ArcTng(x,y : double) : double;
var
  l,tmp : double;
begin
  if Abs(x)<1e-10 then
    if y<0 then
      tmp:=Pi*1.5
    else
      tmp:=Pi*0.5
  else
  begin
    l:=ArcTan((y/x));
    if (y<0)and(x>0) then
      l:=2*pi+l;
    if x>0 then
      tmp:=l
    else
      tmp:=pi+l;
  end;
  ArcTng:=tmp
end;

{*------------------------------------------------------------------------------
  �������� ���� ����������� �����
                                                                                
  @param a   ������ ���������
  @param b   ������ ���������
  @return TComplex   �����  
------------------------------------------------------------------------------*}
function CAdd(a,b : TComplex) : TComplex;
begin
  CAdd.Re:=a.Re+b.Re;
  CAdd.Im:=a.Im+b.Im
end;

{*------------------------------------------------------------------------------
  ��������� ���� ����������� �����
                                                                                
  @param a   �����������
  @param b   ����������
  @return TComplex   ��������  
------------------------------------------------------------------------------*}
function CSub(a,b : TComplex) : TComplex;
begin
  CSub.Re:=a.Re-b.Re;
  CSub.Im:=a.Im-b.Im
end;

{*------------------------------------------------------------------------------
  ��������� ���� ����������� �����
                                                                                
  @param a   ������ ���������
  @param b   ������ ���������
  @return TComplex   ������������  
------------------------------------------------------------------------------*}
function CMul(a,b : TComplex) : TComplex;
begin
  CMul.Re:=a.Re*b.Re-a.Im*b.Im;
  CMul.Im:=a.Im*b.Re+a.Re*b.Im
end;

{*------------------------------------------------------------------------------
  ������� ���� ����������� �����
                                                                                
  @param a   �������
  @param b   ��������
  @return TComplex   �������  
------------------------------------------------------------------------------*}
function CDiv(a,b : TComplex) : TComplex;
var
  c,d,e:double;
begin
  c:=b.Re*b.Re+b.Im*b.Im;
  if Abs(c)<1e-30 then
    c:=1e-30;
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

{*------------------------------------------------------------------------------
  ������ ������������ �����
                                                                                
  @param a   ����������� ��������
  @return double   ������  
------------------------------------------------------------------------------*}
function CAbs(a : TComplex) : double;
begin
  CAbs:=Sqrt(a.Re*a.Re+a.Im*a.Im)
end;

{*------------------------------------------------------------------------------
  ���������� ���� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return double   ���� ������������ �������� (���)  
------------------------------------------------------------------------------*}
function CPhase(a : TComplex) : double;    // ���� � ��������
begin
  Result:=ArcTng(a.Re,a.Im);
end;

{*------------------------------------------------------------------------------
  ���������� ���� ������������ ��������,
  ��������� ������������ � ��������
                                                                                
  @param a   ����������� ��������
  @return double   ���� ������������ �������� (�������)  
------------------------------------------------------------------------------*}
function CPhaseD(a : TComplex) : double;  // ���� � ��������
begin
  Result:=CPhase(a)*180/pi;
  if Result>180 then Result:=Result-360; 
end;

{*------------------------------------------------------------------------------
  ���������� ����������� ��������
  ���� x=a+i*b, �� ��� ���������� ����������� �������� x*=a-i*b
                                                                                
  @param a   ����������� ��������
  @return TComplex   ���������� ���������� ��������  
------------------------------------------------------------------------------*}
function CInv(a : TComplex) : TComplex;
begin
  CInv.Re:=a.Re;
  CInv.Im:=-a.Im;
end;

{*------------------------------------------------------------------------------
  ���������� �������� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ������� ������������ ��������  
------------------------------------------------------------------------------*}
function CSqr(a : TComplex) : TComplex;
begin
  CSqr.Re:=a.Re*a.Re-a.Im*a.Im;
  CSqr.Im:=2*a.Re*a.Im
end;

{*------------------------------------------------------------------------------
  ���������� ����������� ����� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ���������� ������ ������������ ��������  
------------------------------------------------------------------------------*}
function CSqrt(a : TComplex) : TComplex;
begin
  CSqrt.Re:=Sqrt((a.Re+Sqrt(a.Re*a.Re+a.Im*a.Im))/2);
  CSqrt.Im:=Sqrt((-a.Re+Sqrt(a.Re*a.Re+a.Im*a.Im))/2)
end;

{*------------------------------------------------------------------------------
  ���������� ������������ ��������� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ����������� �������� ������������ ��������  
------------------------------------------------------------------------------*}
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

{*------------------------------------------------------------------------------
  ���������� ���������� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ���������� ������������ ��������  
------------------------------------------------------------------------------*}
function CExp(a : TComplex) : TComplex;
begin
  CExp.Re:=Exp(a.Re)*Cos(a.Im);
  CExp.Im:=Exp(a.Re)*Sin(a.Im)
end;

{*------------------------------------------------------------------------------
  ���������� ������ ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ����� ������������ ��������  
------------------------------------------------------------------------------*}
function CSin(a : TComplex) : TComplex;
begin
  CSin.Re:=Sin(a.Re)*Ch(a.Im);
  CSin.Im:=Cos(a.Re)*Sh(a.Im)
end;

{*------------------------------------------------------------------------------
  ���������� �������� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ������� ������������ ��������  
------------------------------------------------------------------------------*}
function CCos(a : TComplex) : TComplex;
begin
  CCos.Re:=Cos(a.Re)*Ch(a.Im);
  CCos.Im:=-Sin(a.Re)*Sh(a.Im)
end;

{*------------------------------------------------------------------------------
  ���������� ���������������� ������ ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ��������������� ����� ������������ ��������  
------------------------------------------------------------------------------*}
function CSh(a : TComplex) : TComplex;
begin
  CSh.Re:=Sh(a.Re)*Cos(a.Im);
  CSh.Im:=Ch(a.Re)*Sin(a.Im)
end;

{*------------------------------------------------------------------------------
  ���������� ���������������� �������� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ��������������� ������� ������������ ��������  
------------------------------------------------------------------------------*}
function CCh(a : TComplex) : TComplex;
begin
  CCh.Re:=Ch(a.Re)*Cos(a.Im);
  CCh.Im:=Sh(a.Re)*Cos(a.Im)
end;

{*------------------------------------------------------------------------------
  ���������� �������� ������������ ��������
                                                                                
  @param a   ����������� ��������
  @return TComplex   ������� ������������ ��������  
------------------------------------------------------------------------------*}
function CTg(a : TComplex) : TComplex;
begin
  CTg.Re:=Sin(2*a.Re)/(Cos(2*a.Re)+Ch(2*a.Im));
  CTg.Im:=Sh(2*a.Im)/(Cos(2*a.Re)+Ch(2*a.Im))
end;

{*------------------------------------------------------------------------------
  �������������� ������������ ����� � �����������
  �=a+i*0
                                                                                
  @param a   ������������ ����� - �������������� ����� ������������ ��������
  @return TComplex   ����������� �����  
------------------------------------------------------------------------------*}
function CConv(a : double) : TComplex;
begin
  CConv.Re:=a;
  CConv.Im:=0
end;

{*------------------------------------------------------------------------------
  �������������� ������������ ����� � �����������
  �=a+i*b
                                                                                
  @param a   �������������� �����
  @param b   ������ �����
  @return TComplex   ����������� �����  
------------------------------------------------------------------------------*}
function CDConv(a,b : double) : TComplex;
begin
  CDConv.Re:=a;
  CDConv.Im:=b
end;

{*------------------------------------------------------------------------------
  ���������� ����������� �������� ������������ �����
  ����� ������� b:=CNeg(a)
  ������������ �������������� �������� b=-a
                                                                                
  @param a   ����������� ��������
  @return TComplex   ���������� �������� ������������ �����  
------------------------------------------------------------------------------*}
function CNeg(a : TComplex) : TComplex;
begin
  CNeg.Re:=-a.re;
  CNeg.Im:=-a.im
end;

{*------------------------------------------------------------------------------
  �������� ���� ����������� ���� � ����������� ���������� ������ ����������
  ����� ������� CAddTo(a,b);
  ������������ a:=CAdd(a,b);
                                                                                
  @param a   ������ ��������� � ��������� �������� (�����)
  @param b   ������ ���������
  @return None     
------------------------------------------------------------------------------*}
procedure CAddTo(var a:TComplex; b:TComplex);
var tt:TComplex;
begin
  tt.re:=a.re+b.re;
  tt.im:=a.im+b.im;
  a:=tt;
end;

{*------------------------------------------------------------------------------
  ��������� ���� ����������� ���� � ����������� ���������� ������ ����������
  ����� ������� CSubTo(a,b);
  ������������ a:=CSub(a,b);
                                                                                
  @param a   ����������� � ��������� ��������� (��������)
  @param b   ����������
  @return None     
------------------------------------------------------------------------------*}
procedure CSubTo(var a:TComplex; b:TComplex);
var tt:TComplex;
begin
  tt.re:=a.re-b.re;
  tt.im:=a.im-b.im;
  a:=tt;
end;

{*------------------------------------------------------------------------------
  ������������ ���� ����������� ���� � ����������� ���������� ������ ����������
  ����� ������� CMulTo(a,b);
  ������������ a:=CMul(a,b);
                                                                                
  @param a   ������ ��������� � ��������� ������������ (������������)
  @param b   ������ ���������
  @return None     
------------------------------------------------------------------------------*}
procedure CMulTo(var a:TComplex; b:TComplex);
var tt:TComplex;
begin
  tt.Re:=a.Re*b.Re-a.Im*b.Im;
  tt.Im:=a.Im*b.Re+a.Re*b.Im;
  a:=tt;
end;

{*------------------------------------------------------------------------------
  ������� ���� ����������� ���� � ����������� ���������� ������ ����������
  ����� ������� CDivTo(a,b);
  ������������ a:=CDiv(a,b);
                                                                                
  @param a   ������� � ��������� ������� (�������)
  @param b   ��������
  @return None     
------------------------------------------------------------------------------*}
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

end.
