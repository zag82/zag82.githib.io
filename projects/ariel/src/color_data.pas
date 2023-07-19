unit color_data;

interface

uses graphics;

procedure cl2gl(cl:TColor; var r,g,b:double);
function RBColor(a : double) : Integer;
function GRColor(a : double) : Integer;

implementation

uses Math, Windows;


/////////////////////////////////////////////
//              Graphic                    //
/////////////////////////////////////////////
procedure cl2gl(cl:TColor; var r,g,b:double);
var a1,a2,a3:integer;
    cc:LongInt;
begin
  cc:=cl;
  a3:=(cc and $00FF0000)shr 16;
  a2:=(cc and $0000FF00)shr 8;
  a1:=(cc and $000000FF);
  r:=a1/256;
  g:=a2/256;
  b:=a3/256;
end;

function RainBowFunction(a,f,e1,e2,e3 : double) : Integer;
var
  tmp1,tmp2 : double;
begin
  tmp1:=Abs((a-f)*e1);
  tmp1:=Power(tmp1,e3);
  tmp2:=Abs((a-f)*e2);
  tmp2:=Power(tmp2,e3);
  if (a-f)<0 then
    Result:=Round(255*Exp(-tmp1))
  else
    Result:=Round(255*Exp(-tmp2))
end;

function LineColorR(a : double) : Integer;
begin
  Result:=RainBowFunction(a,1,2.1,3,4)+Round(RainBowFunction(a,0.1,10,10,4)/2.5)
end;

function LineColorG(a : double) : Integer;
begin
  Result:=RainBowFunction(a,0.6,2.5,2.8,3)
end;

function LineColorB(a : double) : Integer;
begin
  Result:=RainBowFunction(a,0.3,3.5,4,3)
end;

function RBColor(a : double) : Integer;
begin
  Result:=RGB(LineColorR(a),LineColorG(a),LineColorB(a))
end;

function GRColor(a : double) : Integer;
begin
  Result:=RGB(Round(a*255),Round(a*255),Round(a*255));
end;


end.
