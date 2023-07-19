{$N+}
unit SpecMat;
{ �������������� � ������� �������������� ������� }
interface

function Sign(a : Integer) : Integer; { ��������� }
function Sh(a : Single) : Single; { ����� ��������������� sh(a) }
function Th(a : Single) : Single; { ������� ��������������� th(a) }
function Sch(a : Single) : Single; { ������ ��������������� sch(a) }
function Ch(a : Single) : Single; { ������� ��������������� ch(a) }
function Coth(a : Single) : Single; { ��������� ��������������� cth(a) }
function Cosch(a : Single) : Single; { �������� ��������������� csch(a) }
function Tan(a : Single) : Single; { ������� tg(a) }
function CoTan(a : Single) : Single; { ��������� ctg(a) }
function Sec(a : Single) : Single; { ������ sec(a) }
function CoSec(a : Single) : Single; { �������� cosec(a) }
function ArcSin(a : Single) : Single; { �������� arcsin(a) }
function ArcCos(a : Single) : Single; { ���������� arccos(a) }
function ArcCoTan(a : Single) : Single; { ������������ arcctg(a) }
function Deg(a,b : Single) : Single; { (a) � ������� (b) }
function Root(a,b : Single) : Single; { ������ ������� (b) �� (a) }
function ArcTng(x,y : Single) : Single; { y��� ����y �����p�� (x,y) � ���� OX }

implementation

function Sign(a : Integer) : Integer; { ��������� }
begin
  Sign:=0;
  if a>0 then
    Sign:=1
  else if a<0 then
    Sign:=-1
end;

function Sh(a : Single) : Single; { ����� ��������������� sh(a) }
begin
  Sh:=(Exp(a)-Exp(-a))/2
end;

function Th(a : Single) : Single; { ������� ��������������� th(a) }
begin
  Th:=(Exp(a)-Exp(-a))/(Exp(a)+Exp(-a))
end;

function Sch(a : Single) : Single; { ������ ��������������� sch(a) }
begin
  Sch:=2/(Exp(a)+Exp(-a))
end;

function Ch(a : Single) : Single; { ������� ��������������� ch(a) }
begin
  Ch:=(Exp(a)+Exp(-a))/2
end;

function Coth(a : Single) : Single; { ��������� ��������������� cth(a) }
begin
  Coth:=(Exp(a)+Exp(-a))/(Exp(a)-Exp(-a))
end;

function Cosch(a : Single) : Single; { �������� ��������������� csch(a) }
begin
  Cosch:=2/(Exp(a)-Exp(-a))
end;

function Tan(a : Single) : Single; { ������� tg(a) }
begin
  Tan:=Sin(a)/Cos(a)
end;

function CoTan(a : Single) : Single; { ��������� ctg(a) }
begin
  CoTan:=Cos(a)/Sin(a)
end;

function Sec(a : Single) : Single; { ������ sec(a) }
begin
  Sec:=1/Cos(a)
end;

function CoSec(a : Single) : Single; { �������� cosec(a) }
begin
  CoSec:=1/Sin(a)
end;

function ArcSin(a : Single) : Single; { �������� arcsin(a) }
begin
  ArcSin:=ArcTan(a/Sqrt(1-a*a))
end;

function ArcCos(a : Single) : Single; { ���������� arccos(a) }
begin
  ArcCos:=Pi/2-ArcSin(a)
end;

function ArcCoTan(a : Single) : Single; { ������������ arcctg(a) }
begin
  ArcCoTan:=Pi/2-ArcTan(a)
end;

function Deg(a,b : Single) : Single; { (a) � ������� (b) }
begin
  Deg:=Exp(b*Ln(a))
end;

function Root(a,b : Single) : Single; { ������ ������� (b) �� (a) }
begin
  Root:=Exp(Ln(a)/b)
end;

function ArcTng(x,y : Single) : Single;
var
  l,tmp : Single;
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

end.


