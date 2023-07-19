unit glGraphHuge;

interface

uses
  openGL, ExtCtrls, Windows, Complx, Graphics;

type
  TGraphPoint=array[0..1]of GLdouble;

  TglGraphMulti=class
  private
    // ������
    FData: array of TComplex;
    FCapacity: integer;
    FCount: integer;
    FAmplitude: double;
    FMaxPoints: integer;
    // �������� ����������
    FPanel: TPanel;
    DC: HDC;
    hrc: HGLRC;
    procedure SetDCPixelFormat;
    function glDivider(): double;
    function glX(x, y: double; iPanel: integer): TGraphPoint;
    procedure glVert(x, y: double; iPanel: integer);
    procedure setCount(num: integer);
  public
    // ��������, ������������� � ��������
    constructor Create(pnl: TPanel);
    procedure InitData();
    procedure FreeData();
    // ����������� � �������
    property Count: integer read FCount;
    procedure Clear();
    procedure AddXY(x, y: double);
    procedure SetMaxPoints(num: integer);
    procedure SetAmplitude(m: double);
    // ��������� ����������� ������
    procedure PaintData();
  end;

implementation

uses color_data;

{$REGION '�������'}
procedure TglGraphMulti.SetDCPixelFormat;
var
  pfd : TPixelFormatDescriptor;
  nPixelFormat : Integer;
begin
  FillChar (pfd, SizeOf (pfd), 0);
  pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat := ChoosePixelFormat(dc,@pfd);
  SetPixelFormat (dc, nPixelFormat, @pfd);
end;

function TglGraphMulti.glDivider(): double;
begin
  Result := 2 * (FPanel.ClientWidth - FPanel.ClientHeight) / FPanel.ClientWidth - 1;
end;

function TglGraphMulti.glX(x,y:double; iPanel: integer):TGraphPoint;
var
  pDivider: double;
begin
  pDivider := glDivider();
  if iPanel = 1 then
  begin
    // �������� ����������
    Result[0] := x / FMaxPoints * (pDivider + 1) - 1;
    Result[1] := (y + FAmplitude) / FAmplitude / 2;
    if Result[0] < -1 then Result[0] := -1;
    if Result[0] > pDivider then Result[0] := pDivider;
    if Result[1] < 0 then Result[1] := 0;
    if Result[1] > 1 then Result[1] := 1;
  end
  else if iPanel = 2 then
  begin
    // ������ ����������
    Result[0] := x / FMaxPoints * (pDivider + 1) - 1;
    Result[1] := (y + FAmplitude) / FAmplitude / 2 - 1;
    if Result[0] < -1 then Result[0] := -1;
    if Result[0] > pDivider then Result[0] := pDivider;
    if Result[1] < -1 then Result[1] := -1;
    if Result[1] > 0 then Result[1] := 0;
  end
  else
  begin
    // ��������
    Result[0] := (1 - pDivider) * (x + FAmplitude) / FAmplitude / 2  + pDivider;
    Result[1] := (y + FAmplitude) / FAmplitude  - 1;
    if Result[0] < pDivider then Result[0] := pDivider;
    if Result[0] > 1 then Result[0] := 1;
    if Result[1] < -1 then Result[1] := -1;
    if Result[1] > 1 then Result[1] := 1;
  end;
end;

procedure TglGraphMulti.glVert(x,y:double; iPanel: integer);
var gp:TGraphPoint;
begin
  gp:=glX(x,y, iPanel);
  glVertex2d(gp[0],gp[1]);
end;

procedure TglGraphMulti.setCount(num: integer);
begin
  FCount := num;
  if FCount > FCapacity then
  begin
    FCapacity := FCount + Round(FCount * 0.2);
    SetLength(FData, FCapacity);
  end;
end;

{$ENDREGION}

{$REGION '��������, ������������� � ��������'}
constructor TglGraphMulti.Create(pnl: TPanel);
begin
  FCapacity := 10;
  setCount(11);
  FCount := 0;
  FAmplitude := 10.0;
  FMaxPoints := 10;
  // �������� ����������
  FPanel := pnl;
  DC := GetDC(FPanel.Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
end;

procedure TglGraphMulti.InitData();
begin
  // ���� �� ������� �����
end;

procedure TglGraphMulti.FreeData();
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(hrc);
  ReleaseDC(FPanel.Handle, DC);
  DeleteDC(DC);
end;

{$ENDREGION}

{$REGION '����������� � �������'}
procedure TglGraphMulti.Clear();
begin
  FCount := 0;
end;

procedure TglGraphMulti.AddXY(x, y: double);
begin
  inc(FCount);
  setCount(FCount);
  FData[FCount-1].re := x;
  FData[FCount-1].Im := y;
end;


procedure TglGraphMulti.SetMaxPoints(num: integer);
begin
  FMaxPoints := num;
end;

procedure TglGraphMulti.SetAmplitude(m: double);
begin
  FAmplitude := m;
end;

{$ENDREGION}

// ��������� ����������� ������
procedure TglGraphMulti.PaintData();
var
  i:integer;
  pDivider: double;
  r,g,b: double;
  cl: TColor;
begin
  cl := clYellow;
  cl2gl(cl, r, g, b);
  pDivider := glDivider();
  // ������� �����������
  wglMakeCurrent(DC, hrc);
  glViewPort (0, 0, FPanel.ClientWidth, FPanel.ClientHeight); // ������� ������
  glClearColor(0.0, 0.0, 0.0, 0.5); // ���� ����
  glClear(GL_COLOR_BUFFER_BIT);     // ������� ������ �����
  glOrtho(-1, 1, -1, 1, 0, 0);
  glLineWidth(0.1);
  // ������ ���
  glLineWidth(2.0);
  glColor(64, 64, 64);
  glBegin(GL_LINES);
    // ��������
    glVertex(pDivider, 0);
    glVertex(1, 0);
    glVertex(0.5*(1+pDivider), -1);
    glVertex(0.5*(1+pDivider), 1);
    // ����������
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
  // ������ ������
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
  // ���������� ������ - �� �����
  SwapBuffers(DC);
end;

end.
