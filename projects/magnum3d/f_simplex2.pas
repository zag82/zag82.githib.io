unit f_simplex2;

interface
uses cm_ini, cmData;

type
  TSimplexPoint=record
    x,y,f:double;
    n:integer;
    Rang:byte;
  end;

  TSimplexTriangle=array [1..3] of integer;

  TFixedSimplex=class
  private
    nn:array [1..3] of integer;
    im:integer;
  public
    num:TSimplexTriangle;
    fNum:integer;
    fData:array of TSimplexPoint;
    procedure Starter(iMaterial:integer);
    procedure SolveSimplex(x0,y0:double; dx,dy:double; var xr,yr:double);
    procedure SetRealRangs;
    procedure SetRangs;
    procedure CalcNewPoint(iPoint:integer; var xn,yn:double);
  end;

var
  fsx:TFixedSimplex;

function GetFunctionValue(x,y:double; im:integer):double;

implementation

function GetFunctionValue(x,y:double; im:integer):double;
var i:int;
    s:double;
begin
  s:=0;
  for i:=1 to mt.nm[im] do
//    s:=s+abs(mt.BB[im][i]-x*(1-exp(-y*1e-8*sqr(mt.HH[im][i])+y*1e-6*mt.HH[im][i])));
    s:=s+abs(mt.BB[im][i]-x*mt.HH[im][i]/(y+mt.HH[im][i]));
  Result:=s;
end;

procedure TFixedSimplex.Starter(iMaterial:integer);
begin
  im:=iMaterial;
end;

procedure TFixedSimplex.SolveSimplex(x0,y0:double; dx,dy:double; var xr,yr:double);
var b:TSimplexPoint;
    i:integer;
    xn,yn:double;
    count,k,kk:integer;
begin
  xr:=x0;
  yr:=y0;
  for i:=1 to 3 do num[i]:=i;
  fNum:=3;
  SetLength(fData,fNum+1);
  b.x:=x0;
  b.y:=y0;
  b.n:=1;
  b.f:=GetFunctionValue(b.x,b.y,im);
  fData[1]:=b;
  b.x:=x0+dx;
  b.y:=y0;
  b.n:=1;
  b.f:=GetFunctionValue(b.x,b.y,im);
  fData[2]:=b;
  b.x:=x0;
  b.y:=y0+dy;
  b.n:=1;
  b.f:=GetFunctionValue(b.x,b.y,im);
  fData[3]:=b;
  k:=1;
  //////////////////
  SetRealRangs;
  for i:=1 to 3 do
    if fData[num[i]].Rang=3 then
    begin
      k:=i;
      CalcNewPoint(i,xn,yn);
      inc(fNum);
      SetLength(fData,fNum+1);
      b.x:=xn;
      b.y:=yn;
      b.n:=0;
      b.f:=GetFunctionValue(b.x,b.y,im);
      fData[fNum]:=b;
    end;
  repeat
    num[k]:=fNum;
    for i:=1 to 3 do inc(fData[num[i]].n);
    //////////////////
    SetRangs;
    for i:=1 to 3 do
      if fData[num[i]].Rang=3 then
      begin
        fData[num[i]].Rang:=3;
        k:=i;
        CalcNewPoint(i,xn,yn);
        inc(fNum);
        SetLength(fData,fNum+1);
        b.x:=xn;
        b.y:=yn;
        b.n:=0;
        b.f:=GetFunctionValue(b.x,b.y,im);
        fData[fNum]:=b;
      end;
    count:=0;
    kk:=1;
    for i:=1 to 3 do
      if fData[num[i]].Rang=1 then
      begin
        count:=fData[num[i]].n;
        kk:=i;
      end;
  until (count>=17)or(fNum>=30000);
  xr:=fData[num[kk]].x;
  yr:=fData[num[kk]].y;
end;

procedure TFixedSimplex.SetRealRangs;
var i:integer;
    vv:array [1..3] of double;
    im:integer;
    mm:double;
begin
  for i:=1 to 3 do
    vv[i]:=fData[num[i]].f;
  mm:=vv[1];
  im:=1;
  for i:=1 to 3 do
    if mm<vv[i] then
    begin
      mm:=vv[i];
      im:=i;
    end;
  nn[im]:=3;
  Case im of
    1:if vv[2]>=vv[3] then begin nn[2]:=2; nn[3]:=1; end else begin nn[2]:=1; nn[3]:=2; end;
    2:if vv[1]>=vv[3] then begin nn[1]:=2; nn[3]:=1; end else begin nn[1]:=1; nn[3]:=2; end;
    3:if vv[1]>=vv[2] then begin nn[1]:=2; nn[2]:=1; end else begin nn[1]:=1; nn[2]:=2; end;
  end;
  for i:=1 to 3 do
    fData[num[i]].Rang:=nn[i];
end;

procedure TFixedSimplex.SetRangs;
var i:integer;
    vv:array [1..3] of double;
    im:integer;
begin
  for i:=1 to 3 do
    vv[i]:=fData[num[i]].f;
  im:=1;
  for i:=1 to 3 do
    if nn[i]=2 then begin nn[i]:=3; im:=i; end;
  Case im of
    1:if vv[2]>=vv[3] then begin nn[2]:=2; nn[3]:=1; end else begin nn[2]:=1; nn[3]:=2; end;
    2:if vv[1]>=vv[3] then begin nn[1]:=2; nn[3]:=1; end else begin nn[1]:=1; nn[3]:=2; end;
    3:if vv[1]>=vv[2] then begin nn[1]:=2; nn[2]:=1; end else begin nn[1]:=1; nn[2]:=2; end;
  end;
  for i:=1 to 3 do
    fData[num[i]].Rang:=nn[i];
end;

procedure TFixedSimplex.CalcNewPoint(iPoint:integer; var xn,yn:double);
var i:integer;
    sx,sy:double;
begin
  sx:=0;
  sy:=0;
  for i:=1 to 3 do
    if i<>iPoint then
    begin
      sx:=sx+fData[num[i]].x;
      sy:=sy+fData[num[i]].y;
    end;
  sx:=sx/2;
  sy:=sy/2;
  xn:=2*sx-fData[num[iPoint]].x;
  yn:=2*sy-fData[num[iPoint]].y;
end;

end.
