{$N+}
unit SpecMat;
{ Дополнительные к Паскалю математические функции }
interface

function Sign(a : Integer) : Integer; { сигнатура }
function Sh(a : Single) : Single; { синус гиперболический sh(a) }
function Th(a : Single) : Single; { тангенс гиперболический th(a) }
function Sch(a : Single) : Single; { секанс гиперболический sch(a) }
function Ch(a : Single) : Single; { косинус гиперболический ch(a) }
function Coth(a : Single) : Single; { котангенс гиперболический cth(a) }
function Cosch(a : Single) : Single; { косеканс гиперболический csch(a) }
function Tan(a : Single) : Single; { тангенс tg(a) }
function CoTan(a : Single) : Single; { котангенс ctg(a) }
function Sec(a : Single) : Single; { секанс sec(a) }
function CoSec(a : Single) : Single; { косеканс cosec(a) }
function ArcSin(a : Single) : Single; { арксинус arcsin(a) }
function ArcCos(a : Single) : Single; { арккосинус arccos(a) }
function ArcCoTan(a : Single) : Single; { арккотангенс arcctg(a) }
function Deg(a,b : Single) : Single; { (a) в степени (b) }
function Root(a,b : Single) : Single; { корень степени (b) из (a) }
function ArcTng(x,y : Single) : Single; { yгол междy вектоpом (x,y) и осью OX }

implementation

function Sign(a : Integer) : Integer; { сигнатура }
begin
  Sign:=0;
  if a>0 then
    Sign:=1
  else if a<0 then
    Sign:=-1
end;

function Sh(a : Single) : Single; { синус гиперболический sh(a) }
begin
  Sh:=(Exp(a)-Exp(-a))/2
end;

function Th(a : Single) : Single; { тангенс гиперболический th(a) }
begin
  Th:=(Exp(a)-Exp(-a))/(Exp(a)+Exp(-a))
end;

function Sch(a : Single) : Single; { секанс гиперболический sch(a) }
begin
  Sch:=2/(Exp(a)+Exp(-a))
end;

function Ch(a : Single) : Single; { косинус гиперболический ch(a) }
begin
  Ch:=(Exp(a)+Exp(-a))/2
end;

function Coth(a : Single) : Single; { котангенс гиперболический cth(a) }
begin
  Coth:=(Exp(a)+Exp(-a))/(Exp(a)-Exp(-a))
end;

function Cosch(a : Single) : Single; { косеканс гиперболический csch(a) }
begin
  Cosch:=2/(Exp(a)-Exp(-a))
end;

function Tan(a : Single) : Single; { тангенс tg(a) }
begin
  Tan:=Sin(a)/Cos(a)
end;

function CoTan(a : Single) : Single; { котангенс ctg(a) }
begin
  CoTan:=Cos(a)/Sin(a)
end;

function Sec(a : Single) : Single; { секанс sec(a) }
begin
  Sec:=1/Cos(a)
end;

function CoSec(a : Single) : Single; { косеканс cosec(a) }
begin
  CoSec:=1/Sin(a)
end;

function ArcSin(a : Single) : Single; { арксинус arcsin(a) }
begin
  ArcSin:=ArcTan(a/Sqrt(1-a*a))
end;

function ArcCos(a : Single) : Single; { арккосинус arccos(a) }
begin
  ArcCos:=Pi/2-ArcSin(a)
end;

function ArcCoTan(a : Single) : Single; { арккотангенс arcctg(a) }
begin
  ArcCoTan:=Pi/2-ArcTan(a)
end;

function Deg(a,b : Single) : Single; { (a) в степени (b) }
begin
  Deg:=Exp(b*Ln(a))
end;

function Root(a,b : Single) : Single; { корень степени (b) из (a) }
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


