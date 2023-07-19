{*------------------------------------------------------------------------------
  Модуль определения комплексного типа данных и операций над ним

  Содержит процедуры, реализующие математические операции над комплексными
  числами

  @Author    Кафедра ЭИ, МЭИ(ТУ), Москва 2005-2007
  @Version   4.0 Build 255
-------------------------------------------------------------------------------}
unit Complx;
interface

type
  TComplexInt = record
    re: smallint;
    im: smallint;
  end;

  /// тип комплексных чисел
  TComplex=record
    re:double; /// действительная часть комплексного числа
    im:double; /// мнимая часть комплексного числа
  end;

const
  /// комплексный ноль
  CNull : TComplex = (re:0; im:0);

function CAdd(a,b : TComplex) : TComplex;     // сложение
function CSub(a,b : TComplex) : TComplex;     // вычитание
function CMul(a,b : TComplex) : TComplex;     // умножение
function CDiv(a,b : TComplex) : TComplex;     // деление
function CAbs(a : TComplex) : double;         // модуль
function CPhase(a : TComplex) : double;       // фаза в радианах
function CPhaseD(a : TComplex) : double;      // фаза в градусах
function CInv(a : TComplex) : TComplex;       // комплексно-сопряженное число
function CSqr(a : TComplex) : TComplex;       // возведение в квадрат
function CSqrt(a : TComplex) : TComplex;      // извлечение квадратного корня
function CLn(a : TComplex) : TComplex;        // натуральный логарифм
function CExp(a : TComplex) : TComplex;       // экспонента
function CSin(a : TComplex) : TComplex;       // синус комплексного аргумента
function CCos(a : TComplex) : TComplex;       // косинус комплексного аргумента
function CSh(a : TComplex) : TComplex;        // гиперболический синус
function CCh(a : TComplex) : TComplex;        // гиперболический косинус
function CTg(a : TComplex) : TComplex;        // гиперболический тангенс

{
  преобразование вещественного числа к комплексному

  a - действительная часть
  b - мнимая часть
}
function CConv(a : double) : TComplex;
function CDConv(a,b : double) : TComplex;

function CNeg(a : TComplex) : TComplex;       // унарный минус

procedure CAddTo(var a:TComplex; b:TComplex);
procedure CSubTo(var a:TComplex; b:TComplex);
procedure CMulTo(var a:TComplex; b:TComplex);
procedure CDivTo(var a:TComplex; b:TComplex);

// Mathematical functions
function Sh(a : double) : double; { синус гиперболический sh(a) }
function Ch(a : double) : double; { косинус гиперболический ch(a) }
function ArcTng(x,y : double) : double; { yгол междy вектоpом (x,y) и осью OX }

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
  синус гиперболический sh(a)
                                                                                
  @param a   параметр функции гиперболического синуса
  @return double     синус гиперболический
------------------------------------------------------------------------------*}
function Sh(a : double) : double;
begin
  Sh:=(Exp(a)-Exp(-a))/2
end;

{*------------------------------------------------------------------------------
  косинус гиперболический ch(a)
                                                                                
  @param a   параметр функции гиперболического косинуса
  @return double   косинус гиперболический  
------------------------------------------------------------------------------*}
function Ch(a : double) : double;
begin
  Ch:=(Exp(a)+Exp(-a))/2
end;

{*------------------------------------------------------------------------------
  арктангенс - возвращает значение угла в диапазоне (-pi; pi]
                                                                                
  @param x   действительная компонента
  @param y   мнимая компонента
  @return double   арктангенс отношения y к x  
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
  сложение двух комплексных чисел
                                                                                
  @param a   первое слагаемое
  @param b   второе слагаемое
  @return TComplex   сумма  
------------------------------------------------------------------------------*}
function CAdd(a,b : TComplex) : TComplex;
begin
  CAdd.Re:=a.Re+b.Re;
  CAdd.Im:=a.Im+b.Im
end;

{*------------------------------------------------------------------------------
  вычитание двух комплексных чисел
                                                                                
  @param a   уменьшаемое
  @param b   вычитаемое
  @return TComplex   разность  
------------------------------------------------------------------------------*}
function CSub(a,b : TComplex) : TComplex;
begin
  CSub.Re:=a.Re-b.Re;
  CSub.Im:=a.Im-b.Im
end;

{*------------------------------------------------------------------------------
  умножение двух комплексных чисел
                                                                                
  @param a   первый множитель
  @param b   второй множитель
  @return TComplex   произведение  
------------------------------------------------------------------------------*}
function CMul(a,b : TComplex) : TComplex;
begin
  CMul.Re:=a.Re*b.Re-a.Im*b.Im;
  CMul.Im:=a.Im*b.Re+a.Re*b.Im
end;

{*------------------------------------------------------------------------------
  деление двух комплексных чисел
                                                                                
  @param a   делимое
  @param b   делитель
  @return TComplex   частное  
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
  модуль комплексного числа
                                                                                
  @param a   комплексное значение
  @return double   модуль  
------------------------------------------------------------------------------*}
function CAbs(a : TComplex) : double;
begin
  CAbs:=Sqrt(a.Re*a.Re+a.Im*a.Im)
end;

{*------------------------------------------------------------------------------
  вычисление фазы комплексного значения
                                                                                
  @param a   комплексное значение
  @return double   фаза комплексного значения (рад)  
------------------------------------------------------------------------------*}
function CPhase(a : TComplex) : double;    // фаза в радианах
begin
  Result:=ArcTng(a.Re,a.Im);
end;

{*------------------------------------------------------------------------------
  вычисление фазы комплексного значения,
  результат возвращается в градусах
                                                                                
  @param a   комплексное занчение
  @return double   фаза комплексного значения (градусы)  
------------------------------------------------------------------------------*}
function CPhaseD(a : TComplex) : double;  // фаза в градусах
begin
  Result:=CPhase(a)*180/pi;
  if Result>180 then Result:=Result-360; 
end;

{*------------------------------------------------------------------------------
  комплексно сопряженное значение
  если x=a+i*b, то его комплексно сопряженное значение x*=a-i*b
                                                                                
  @param a   комплексное значение
  @return TComplex   комплексно сопряженно значение  
------------------------------------------------------------------------------*}
function CInv(a : TComplex) : TComplex;
begin
  CInv.Re:=a.Re;
  CInv.Im:=-a.Im;
end;

{*------------------------------------------------------------------------------
  вычисление квадрата комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   квадрат комплексного значения  
------------------------------------------------------------------------------*}
function CSqr(a : TComplex) : TComplex;
begin
  CSqr.Re:=a.Re*a.Re-a.Im*a.Im;
  CSqr.Im:=2*a.Re*a.Im
end;

{*------------------------------------------------------------------------------
  вычисление квадратного корня комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   квадратный корень комплексного значения  
------------------------------------------------------------------------------*}
function CSqrt(a : TComplex) : TComplex;
begin
  CSqrt.Re:=Sqrt((a.Re+Sqrt(a.Re*a.Re+a.Im*a.Im))/2);
  CSqrt.Im:=Sqrt((-a.Re+Sqrt(a.Re*a.Re+a.Im*a.Im))/2)
end;

{*------------------------------------------------------------------------------
  вычисление натурального логарифма комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   натуральный логарифм комплексного значения  
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
  вычисление экспоненты комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   экспонента комплексного значения  
------------------------------------------------------------------------------*}
function CExp(a : TComplex) : TComplex;
begin
  CExp.Re:=Exp(a.Re)*Cos(a.Im);
  CExp.Im:=Exp(a.Re)*Sin(a.Im)
end;

{*------------------------------------------------------------------------------
  вычисление синуса комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   синус комплексного значения  
------------------------------------------------------------------------------*}
function CSin(a : TComplex) : TComplex;
begin
  CSin.Re:=Sin(a.Re)*Ch(a.Im);
  CSin.Im:=Cos(a.Re)*Sh(a.Im)
end;

{*------------------------------------------------------------------------------
  вычисление косинуса комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   косинус комплексного значения  
------------------------------------------------------------------------------*}
function CCos(a : TComplex) : TComplex;
begin
  CCos.Re:=Cos(a.Re)*Ch(a.Im);
  CCos.Im:=-Sin(a.Re)*Sh(a.Im)
end;

{*------------------------------------------------------------------------------
  вычисление гиперболического синуса комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   гиперболический синус комплексного значения  
------------------------------------------------------------------------------*}
function CSh(a : TComplex) : TComplex;
begin
  CSh.Re:=Sh(a.Re)*Cos(a.Im);
  CSh.Im:=Ch(a.Re)*Sin(a.Im)
end;

{*------------------------------------------------------------------------------
  вычисление гиперболического косинуса комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   гиперболический косинус комплексного значения  
------------------------------------------------------------------------------*}
function CCh(a : TComplex) : TComplex;
begin
  CCh.Re:=Ch(a.Re)*Cos(a.Im);
  CCh.Im:=Sh(a.Re)*Cos(a.Im)
end;

{*------------------------------------------------------------------------------
  вычисление тангенса комплексного значения
                                                                                
  @param a   комплексное значение
  @return TComplex   тангенс комплексного значения  
------------------------------------------------------------------------------*}
function CTg(a : TComplex) : TComplex;
begin
  CTg.Re:=Sin(2*a.Re)/(Cos(2*a.Re)+Ch(2*a.Im));
  CTg.Im:=Sh(2*a.Im)/(Cos(2*a.Re)+Ch(2*a.Im))
end;

{*------------------------------------------------------------------------------
  преобразование вещественных чисел в комплексные
  с=a+i*0
                                                                                
  @param a   вещественное число - действительная часть комплексного значения
  @return TComplex   комплексное число  
------------------------------------------------------------------------------*}
function CConv(a : double) : TComplex;
begin
  CConv.Re:=a;
  CConv.Im:=0
end;

{*------------------------------------------------------------------------------
  преобразование вещественных чисел в комплексные
  с=a+i*b
                                                                                
  @param a   действительная часть
  @param b   мнимая часть
  @return TComplex   комплексное число  
------------------------------------------------------------------------------*}
function CDConv(a,b : double) : TComplex;
begin
  CDConv.Re:=a;
  CDConv.Im:=b
end;

{*------------------------------------------------------------------------------
  вычисление негативного значения комплексного числа
  вызов фукнции b:=CNeg(a)
  эквивалентен математической операции b=-a
                                                                                
  @param a   комплексное значение
  @return TComplex   негативное значение комплексного числа  
------------------------------------------------------------------------------*}
function CNeg(a : TComplex) : TComplex;
begin
  CNeg.Re:=-a.re;
  CNeg.Im:=-a.im
end;

{*------------------------------------------------------------------------------
  Сложение двух комплексных исел с присвоением результата первой переменной
  Вызов функции CAddTo(a,b);
  эквивалентен a:=CAdd(a,b);
                                                                                
  @param a   первое слагаемое и результат сложения (сумма)
  @param b   второе слагаемое
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
  Вычитание двух комплексных исел с присвоением результата первой переменной
  Вызов функции CSubTo(a,b);
  эквивалентен a:=CSub(a,b);
                                                                                
  @param a   уменьшаемое и результат вычитания (разность)
  @param b   вычитаемое
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
  Перемножение двух комплексных исел с присвоением результата первой переменной
  Вызов функции CMulTo(a,b);
  эквивалентен a:=CMul(a,b);
                                                                                
  @param a   первый множитель и результат перемножения (произведение)
  @param b   второй множитель
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
  Деление двух комплексных исел с присвоением результата первой переменной
  Вызов функции CDivTo(a,b);
  эквивалентен a:=CDiv(a,b);
                                                                                
  @param a   делимое и результат деления (частное)
  @param b   делитель
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
