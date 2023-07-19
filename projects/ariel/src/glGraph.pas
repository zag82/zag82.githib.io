unit glGraph;

interface

uses
  openGL, ExtCtrls, Windows, Complx, Graphics;

type
  TGraphPoint=array[0..1]of GLdouble;

  TglGraph=class
  private
    // данные
    FData: array of TComplex;
    FCapacity: integer;
    FCount: integer;
    FAmplitude: double;
    FMaxPoints: integer;
    // элементы интерфейса
    FPanel: TPanel;
    DC: HDC;
    hrc: HGLRC;
    procedure SetDCPixelFormat;
    function glDivider(): double;
    function glX(x, y: double; iPanel: integer): TGraphPoint;
    procedure glVert(x, y: double; iPanel: integer);
    procedure setCount(num: integer);
  public
    // создание, инициализаци€ и удаление
    constructor Create(pnl: TPanel);
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

uses color_data;

{$REGION '—истема'}
procedure TglGraph.SetDCPixelFormat;
var
  pfd : TPixelFormatDescriptor;
  nPixelFormat : Integer;
begin
  FillChar (pfd, SizeOf (pfd), 0);
  pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(dc,@pfd);
  SetPixelFormat (dc, nPixelFormat, @pfd);
end;

function TglGraph.glDivider(): double;
begin
  Result := 2 * (FPanel.ClientWidth - FPanel.ClientHeight) / FPanel.ClientWidth - 1;
end;

function TglGraph.glX(x,y:double; iPanel: integer):TGraphPoint;
var
  pDivider: double;
begin
  pDivider := glDivider();
  if iPanel = 1 then
  begin
    // реальна€ компонента
    Result[0] := x / FMaxPoints * (pDivider + 1) - 1;
    Result[1] := (y + FAmplitude) / FAmplitude / 2;
    if Result[0] < -1 then Result[0] := -1;
    if Result[0] > pDivider then Result[0] := pDivider;
    if Result[1] < 0 then Result[1] := 0;
    if Result[1] > 1 then Result[1] := 1;
  end
  else if iPanel = 2 then
  begin
    // мнима€ компонента
    Result[0] := x / FMaxPoints * (pDivider + 1) - 1;
    Result[1] := (y + FAmplitude) / FAmplitude / 2 - 1;
    if Result[0] < -1 then Result[0] := -1;
    if Result[0] > pDivider then Result[0] := pDivider;
    if Result[1] < -1 then Result[1] := -1;
    if Result[1] > 0 then Result[1] := 0;
  end
  else
  begin
    // годограф
    Result[0] := (1 - pDivider) * (x + FAmplitude) / FAmplitude / 2  + pDivider;
    Result[1] := (y + FAmplitude) / FAmplitude  - 1;
    if Result[0] < pDivider then Result[0] := pDivider;
    if Result[0] > 1 then Result[0] := 1;
    if Result[1] < -1 then Result[1] := -1;
    if Result[1] > 1 then Result[1] := 1;
  end;
end;

procedure TglGraph.glVert(x,y:double; iPanel: integer);
var gp:TGraphPoint;
begin
  gp:=glX(x,y, iPanel);
  glVertex2d(gp[0],gp[1]);
end;

procedure TglGraph.setCount(num: integer);
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
constructor TglGraph.Create(pnl: TPanel);
begin
  FCapacity := 10;
  setCount(11);
  FCount := 0;
  FAmplitude := 10.0;
  FMaxPoints := 10;
  // элементы интерфейса
  FPanel := pnl;
  DC := GetDC(FPanel.Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
end;

procedure TglGraph.InitData();
begin
  // пока не пон€тно зачем
end;

procedure TglGraph.FreeData();
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(hrc);
  ReleaseDC(FPanel.Handle, DC);
  DeleteDC(DC);
end;

{$ENDREGION}

{$REGION 'манипул€ции с данными'}
procedure TglGraph.Clear();
begin
  FCount := 0;
end;

procedure TglGraph.AddXY(x, y: double);
begin
  inc(FCount);
  setCount(FCount);
  FData[FCount-1].re := x;
  FData[FCount-1].Im := y;
end;


procedure TglGraph.SetMaxPoints(num: integer);
begin
  FMaxPoints := num;
end;

procedure TglGraph.SetAmplitude(m: double);
begin
  FAmplitude := m;
end;

{$ENDREGION}

// параметры отображени€ данных
procedure TglGraph.PaintData(cl: TColor);
var
  i:integer;
  pDivider: double;
  r,g,b: double;
begin

  cl2gl(cl, r, g, b);
  pDivider := glDivider();
  // готовим отображение
  wglMakeCurrent(DC, hrc);
  glViewPort (0, 0, FPanel.ClientWidth, FPanel.ClientHeight); // область вывода
  glClearColor(0.0, 0.0, 0.0, 0.5); // цвет фона
  glClear(GL_COLOR_BUFFER_BIT);     // очистка буфера цвета
  glOrtho(-1, 1, -1, 1, 0, 0);
  glLineWidth(0.1);
  //glEnable(GL_LINE_SMOOTH);
  //glEnable(GL_BLEND);
  //glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  // рисуем оси
  glLineWidth(2.0);
  glColor(64, 64, 64);
  glBegin(GL_LINES);
    // годограф
    glVertex(pDivider, 0);
    glVertex(1, 0);
    glVertex(0.5*(1+pDivider), -1);
    glVertex(0.5*(1+pDivider), 1);
    // компоненты
    glVertex(-1, 0.5);
    glVertex(pDivider, 0.5);
    glVertex(-1, -0.5);
    glVertex(pDivider, -0.5);
  glEnd;
  glLineWidth(1.0);
  glColor(1.0, 1.0, 1.0);
  glBegin(GL_LINES);
    glVertex(-1, 0);
    glVertex(pDivider, 0);
    glVertex(pDivider, -1);
    glVertex(pDivider, 1);
  glEnd;
  // рисуем данные
  glColor(r, g, b);
  glBegin(GL_LINE_STRIP);
  for i := 0 to FCount - 1 do
    glVert(i, FData[i].re, 1);
  glEnd();
  glBegin(GL_LINE_STRIP);
  for i := 0 to FCount - 1 do
    glVert(i, FData[i].im, 2);
  glEnd();
  glBegin(GL_LINE_STRIP);
  for i := 0 to FCount - 1 do
    glVert(FData[i].re, FData[i].im, 3);
  glEnd();
  // рисуем линию конца данных
  glLineWidth(1.0);
  glColor(0.0, 0.0, 1.0);
  glBegin(GL_LINES);
    glVert(FCount, -FAmplitude, 1);
    glVert(FCount, FAmplitude, 1);
    glVert(FCount, -FAmplitude, 2);
    glVert(FCount, FAmplitude, 2);
  glEnd;
  // содержимое буфера - на экран
  SwapBuffers(DC);
end;

end.
