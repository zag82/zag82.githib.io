unit ecGraph;

interface

uses
  ExtCtrls, Windows, Complx, Graphics;

type
  TCanvasArea=record
    // точки на экране
    x1: integer;
    x2: integer;
    y1: integer;
    y2: integer;
    // точки в реальных единицах
    vx1: double;
    vx2: double;
    vy1: double;
    vy2: double;
    procedure setScreenRect(sx1, sx2, sy1, sy2: integer);
    procedure setValueRect(rx1, rx2, ry1, ry2: double);
    function getRect(): TRect;
    function Xvalue2screen(v: double): integer;
    function Yvalue2screen(v: double): integer;
  end;

  TecGraph=class
  private
    // данные
    FData: array of TComplex;
    FCapacity: integer;
    FCount: integer;
    FAmplitude: double;
    FMaxPoints: integer;
    // элементы интерфейса
    FPanel: TPaintBox;
    c: TCanvas;
    areas: array[0..2] of TCanvasArea;
    procedure recalcAreas();
    procedure setCount(num: integer);
  public
    // создание, инициализаци€ и удаление
    constructor Create(pnl: TPaintBox);
    procedure InitData();
    procedure FreeData();
    // манипул€ции с данными
    property Count: integer read FCount;
    procedure Clear();
    procedure AddXY(x, y: double);
    procedure SetMaxPoints(num: integer);
    procedure SetAmplitude(m: double);
    // параметры отображени€ данных
    procedure PaintData(cl: TColor);
  end;

implementation

uses Types;

const
  delta: integer = 2;


{$REGION '—истема'}
procedure TCanvasArea.setScreenRect(sx1, sx2, sy1, sy2: integer);
begin
  x1 := sx1;
  x2 := sx2;
  y1 := sy1;
  y2 := sy2;
end;

procedure TCanvasArea.setValueRect(rx1, rx2, ry1, ry2: double);
begin
  vx1 := rx1;
  vx2 := rx2;
  vy1 := ry1;
  vy2 := ry2;
end;

function TCanvasArea.getRect(): TRect;
begin
  Result.Left := x1;
  Result.Right := x2 + 1;
  Result.Top := y1;
  Result.Bottom := y2 + 1;
end;

function TCanvasArea.Xvalue2screen(v: double): integer;
begin
  Result := x1 + delta + Round((x2 - x1 - 2 * delta) * (v - vx1) / (vx2 - vx1));
end;

function TCanvasArea.Yvalue2screen(v: double): integer;
begin
  Result := y2 - delta + Round((y1 - y2 + 2 * delta) * (v - vy1) / (vy2 - vy1));
end;

procedure TecGraph.recalcAreas();
var
  w, h: integer;
begin
  w := FPanel.Width;
  h := FPanel.Height;
  // экранные координаты
  areas[0].setScreenRect(0, w-h, 0, h div 2);
  areas[1].setScreenRect(0, w-h, h div 2, h);
  areas[2].setScreenRect(w-h, w, 0, h);
  // обновл€ем параметры областей
  areas[0].setValueRect(0, FMaxPoints, -FAmplitude, FAmplitude);
  areas[1].setValueRect(0, FMaxPoints, -FAmplitude, FAmplitude);
  areas[2].setValueRect(-FAmplitude, FAmplitude, -FAmplitude, FAmplitude);
end;

procedure TecGraph.setCount(num: integer);
begin
  FCount := num;
  if FCount > FCapacity then
  begin
    FCapacity := FCount + Round(FCount * 0.2);
    SetLength(FData, FCapacity);
  end;
end;

{$ENDREGION}

{$REGION 'создание, инициализаци€ и удаление'}
constructor TecGraph.Create(pnl: TPaintBox);
begin
  setLength(FData, 10);
  FCapacity := 10;
  FCount := 0;
  FAmplitude := 10.0;
  FMaxPoints := 10;
  // элементы интерфейса
  FPanel := pnl;
  //c := FPanel.Canvas;
end;

procedure TecGraph.InitData();
begin
  // пока не пон€тно зачем
end;

procedure TecGraph.FreeData();
begin
  FData := nil;
end;

{$ENDREGION}

{$REGION 'манипул€ции с данными'}
procedure TecGraph.Clear();
begin
  FCount := 0;
end;

procedure TecGraph.AddXY(x, y: double);
begin
  inc(FCount);
  setCount(FCount);
  FData[FCount-1].re := x;
  FData[FCount-1].Im := y;
end;


procedure TecGraph.SetMaxPoints(num: integer);
begin
  FMaxPoints := num;
end;

procedure TecGraph.SetAmplitude(m: double);
begin
  FAmplitude := m;
end;

{$ENDREGION}

// параметры отображени€ данных
procedure TecGraph.PaintData(cl: TColor);
var
  bm: TBitmap;
  i:integer;
  r: TRect;

  procedure setColors(penColor, brushColor: TColor; brushStyle: TBrushStyle = bsClear; penStyle: TPenStyle = psSolid);
  begin
    c.Pen.Style := penStyle;
    c.Brush.Style := brushStyle;
    c.Pen.Color := penColor;
    c.Brush.Color := brushColor;
  end;

begin
  bm := TBitmap.Create();
  try
    bm.SetSize(FPanel.Width, FPanel.Height);
    c := bm.Canvas;
    // готовим отображение
    recalcAreas();
    c.Pen.Width := 1;
    // рисуем границы областей
    setColors(clWhite, clBlack);
    for i := 0 to 2 do
      c.Rectangle(areas[i].getRect());
    // рисуем оси
    setColors(clGray, clBlack);
    c.Pen.Width := 2;
    c.MoveTo(areas[0].x1 + 1, areas[0].Yvalue2screen(0));
    c.LineTo(areas[0].x2 - 1, areas[0].Yvalue2screen(0));
    c.MoveTo(areas[1].x1 + 1, areas[1].Yvalue2screen(0));
    c.LineTo(areas[1].x2 - 1, areas[1].Yvalue2screen(0));
    // годограф
    c.MoveTo(areas[2].x1 + 1, areas[2].Yvalue2screen(0));
    c.LineTo(areas[2].x2 - 1, areas[2].Yvalue2screen(0));
    c.MoveTo(areas[2].Xvalue2screen(0), areas[2].y1 + 1);
    c.LineTo(areas[2].Xvalue2screen(0), areas[2].y2 - 1);
    // рисуем данные
    c.Pen.Width := 1;
    setColors(cl, clBlack);
    c.MoveTo(areas[0].Xvalue2screen(0), areas[0].Yvalue2screen(9 * cos(0 / 10000 * 5 * pi)));
    for i := 1 to 10000 do
      c.LineTo(areas[0].Xvalue2screen(i/1000), areas[0].Yvalue2screen(9 * cos(i / 10000 * 5 * pi)));
    c.MoveTo(areas[1].Xvalue2screen(0), areas[1].Yvalue2screen(9 * cos(0 / 10000 * 15 * Pi + 2*pi/3)));
    for i := 1 to 10000 do
      c.LineTo(areas[1].Xvalue2screen(i/1000), areas[1].Yvalue2screen(9 * cos(i / 10000 * 15 * Pi + 2*pi/3)));
    c.MoveTo(areas[2].Xvalue2screen(9 * cos(0 / 10000 * 5 * pi)), areas[2].Yvalue2screen(9 * cos(0 / 10000 * 15 * Pi + 2*pi/3)));
    for i := 1 to 10000 do
      c.LineTo(areas[2].Xvalue2screen(9 * cos(i / 10000 * 5 * pi)), areas[2].Yvalue2screen(9 * cos(i / 10000 * 15 * Pi + 2*pi/3)));
    // содержимое буфера - на экран
    r := Rect(0, 0, FPanel.Width, FPanel.Height);
    FPanel.Canvas.CopyMode := cmSrcCopy;
    FPanel.Canvas.CopyRect(r, c, r);
  finally
    c := nil;
    bm.FreeImage;
    bm.Free;
  end;
end;

end.

