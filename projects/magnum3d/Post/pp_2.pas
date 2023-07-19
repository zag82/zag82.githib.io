unit pp_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ActnList;

type
  TfmPostProcessor2 = class(TForm)
    Timer1: TTimer;
    ActionList1: TActionList;
    actSave: TAction;
    sDlgPic: TSaveDialog;
    actSaveGrid: TAction;
    sDlgGrid: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSaveGridExecute(Sender: TObject);
  private
    { Private declarations }
    LastX:integer;
    LastY:integer;
    Down:boolean;
  public
    { Public declarations }
    DC : HDC;
    hrc : HGLRC;
    procedure SetDCPixelFormat;
  end;

var
  fmPostProcessor2: TfmPostProcessor2;

implementation

{$R *.dfm}
uses p2_data, openGL,cmVars, cmData,cm_ini, comPlx, pre_proc;

var
  fontOffset : GLuint;

 rasters : Array [0..94, 0..12] of GLUByte = (
($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
($00, $00, $18, $18, $00, $00, $18, $18, $18, $18, $18, $18, $18),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $36, $36, $36, $36),
($00, $00, $00, $66, $66, $ff, $66, $66, $ff, $66, $66, $00, $00),
($00, $00, $18, $7e, $ff, $1b, $1f, $7e, $f8, $d8, $ff, $7e, $18),
($00, $00, $0e, $1b, $db, $6e, $30, $18, $0c, $76, $db, $d8, $70),
($00, $00, $7f, $c6, $cf, $d8, $70, $70, $d8, $cc, $cc, $6c, $38),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $1c, $0c, $0e),
($00, $00, $0c, $18, $30, $30, $30, $30, $30, $30, $30, $18, $0c),
($00, $00, $30, $18, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $18, $30),
($00, $00, $00, $00, $99, $5a, $3c, $ff, $3c, $5a, $99, $00, $00),
($00, $00, $00, $18, $18, $18, $ff, $ff, $18, $18, $18, $00, $00),
($00, $00, $30, $18, $1c, $1c, $00, $00, $00, $00, $00, $00, $00),
($00, $00, $00, $00, $00, $00, $ff, $ff, $00, $00, $00, $00, $00),
($00, $00, $00, $38, $38, $00, $00, $00, $00, $00, $00, $00, $00),
($00, $60, $60, $30, $30, $18, $18, $0c, $0c, $06, $06, $03, $03),
($00, $00, $3c, $66, $c3, $e3, $f3, $db, $cf, $c7, $c3, $66, $3c),
($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $78, $38, $18),
($00, $00, $ff, $c0, $c0, $60, $30, $18, $0c, $06, $03, $e7, $7e),
($00, $00, $7e, $e7, $03, $03, $07, $7e, $07, $03, $03, $e7, $7e),
($00, $00, $0c, $0c, $0c, $0c, $0c, $ff, $cc, $6c, $3c, $1c, $0c),
($00, $00, $7e, $e7, $03, $03, $07, $fe, $c0, $c0, $c0, $c0, $ff),
($00, $00, $7e, $e7, $c3, $c3, $c7, $fe, $c0, $c0, $c0, $e7, $7e),
($00, $00, $30, $30, $30, $30, $18, $0c, $06, $03, $03, $03, $ff),
($00, $00, $7e, $e7, $c3, $c3, $e7, $7e, $e7, $c3, $c3, $e7, $7e),
($00, $00, $7e, $e7, $03, $03, $03, $7f, $e7, $c3, $c3, $e7, $7e),
($00, $00, $00, $38, $38, $00, $00, $38, $38, $00, $00, $00, $00),
($00, $00, $30, $18, $1c, $1c, $00, $00, $1c, $1c, $00, $00, $00),
($00, $00, $06, $0c, $18, $30, $60, $c0, $60, $30, $18, $0c, $06),
($00, $00, $00, $00, $ff, $ff, $00, $ff, $ff, $00, $00, $00, $00),
($00, $00, $60, $30, $18, $0c, $06, $03, $06, $0c, $18, $30, $60),
($00, $00, $18, $00, $00, $18, $18, $0c, $06, $03, $c3, $c3, $7e),
($00, $00, $3f, $60, $cf, $db, $d3, $dd, $c3, $7e, $00, $00, $00),
($00, $00, $c3, $c3, $c3, $c3, $ff, $c3, $c3, $c3, $66, $3c, $18),
($00, $00, $fe, $c7, $c3, $c3, $c7, $fe, $c7, $c3, $c3, $c7, $fe),
($00, $00, $7e, $e7, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $e7, $7e),
($00, $00, $fc, $ce, $c7, $c3, $c3, $c3, $c3, $c3, $c7, $ce, $fc),
($00, $00, $ff, $c0, $c0, $c0, $c0, $fc, $c0, $c0, $c0, $c0, $ff),
($00, $00, $c0, $c0, $c0, $c0, $c0, $c0, $fc, $c0, $c0, $c0, $ff),
($00, $00, $7e, $e7, $c3, $c3, $cf, $c0, $c0, $c0, $c0, $e7, $7e),
($00, $00, $c3, $c3, $c3, $c3, $c3, $ff, $c3, $c3, $c3, $c3, $c3),
($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18, $7e),
($00, $00, $7c, $ee, $c6, $06, $06, $06, $06, $06, $06, $06, $06),
($00, $00, $c3, $c6, $cc, $d8, $f0, $e0, $f0, $d8, $cc, $c6, $c3),
($00, $00, $ff, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0),
($00, $00, $c3, $c3, $c3, $c3, $c3, $c3, $db, $ff, $ff, $e7, $c3),
($00, $00, $c7, $c7, $cf, $cf, $df, $db, $fb, $f3, $f3, $e3, $e3),
($00, $00, $7e, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e7, $7e),
($00, $00, $c0, $c0, $c0, $c0, $c0, $fe, $c7, $c3, $c3, $c7, $fe),
($00, $00, $3f, $6e, $df, $db, $c3, $c3, $c3, $c3, $c3, $66, $3c),
($00, $00, $c3, $c6, $cc, $d8, $f0, $fe, $c7, $c3, $c3, $c7, $fe),
($00, $00, $7e, $e7, $03, $03, $07, $7e, $e0, $c0, $c0, $e7, $7e),
($00, $00, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $ff),
($00, $00, $7e, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3),
($00, $00, $18, $3c, $3c, $66, $66, $c3, $c3, $c3, $c3, $c3, $c3),
($00, $00, $c3, $e7, $ff, $ff, $db, $db, $c3, $c3, $c3, $c3, $c3),
($00, $00, $c3, $66, $66, $3c, $3c, $18, $3c, $3c, $66, $66, $c3),
($00, $00, $18, $18, $18, $18, $18, $18, $3c, $3c, $66, $66, $c3),
($00, $00, $ff, $c0, $c0, $60, $30, $7e, $0c, $06, $03, $03, $ff),
($00, $00, $3c, $30, $30, $30, $30, $30, $30, $30, $30, $30, $3c),
($00, $03, $03, $06, $06, $0c, $0c, $18, $18, $30, $30, $60, $60),
($00, $00, $3c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $3c),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $c3, $66, $3c, $18),
($ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $38, $30, $70),
($00, $00, $7f, $c3, $c3, $7f, $03, $c3, $7e, $00, $00, $00, $00),
($00, $00, $fe, $c3, $c3, $c3, $c3, $fe, $c0, $c0, $c0, $c0, $c0),
($00, $00, $7e, $c3, $c0, $c0, $c0, $c3, $7e, $00, $00, $00, $00),
($00, $00, $7f, $c3, $c3, $c3, $c3, $7f, $03, $03, $03, $03, $03),
($00, $00, $7f, $c0, $c0, $fe, $c3, $c3, $7e, $00, $00, $00, $00),
($00, $00, $30, $30, $30, $30, $30, $fc, $30, $30, $30, $33, $1e),
($7e, $c3, $03, $03, $7f, $c3, $c3, $c3, $7e, $00, $00, $00, $00),
($00, $00, $c3, $c3, $c3, $c3, $c3, $c3, $fe, $c0, $c0, $c0, $c0),
($00, $00, $18, $18, $18, $18, $18, $18, $18, $00, $00, $18, $00),
($38, $6c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $00, $00, $0c, $00),
($00, $00, $c6, $cc, $f8, $f0, $d8, $cc, $c6, $c0, $c0, $c0, $c0),
($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18, $78),
($00, $00, $db, $db, $db, $db, $db, $db, $fe, $00, $00, $00, $00),
($00, $00, $c6, $c6, $c6, $c6, $c6, $c6, $fc, $00, $00, $00, $00),
($00, $00, $7c, $c6, $c6, $c6, $c6, $c6, $7c, $00, $00, $00, $00),
($c0, $c0, $c0, $fe, $c3, $c3, $c3, $c3, $fe, $00, $00, $00, $00),
($03, $03, $03, $7f, $c3, $c3, $c3, $c3, $7f, $00, $00, $00, $00),
($00, $00, $c0, $c0, $c0, $c0, $c0, $e0, $fe, $00, $00, $00, $00),
($00, $00, $fe, $03, $03, $7e, $c0, $c0, $7f, $00, $00, $00, $00),
($00, $00, $1c, $36, $30, $30, $30, $30, $fc, $30, $30, $30, $00),
($00, $00, $7e, $c6, $c6, $c6, $c6, $c6, $c6, $00, $00, $00, $00),
($00, $00, $18, $3c, $3c, $66, $66, $c3, $c3, $00, $00, $00, $00),
($00, $00, $c3, $e7, $ff, $db, $c3, $c3, $c3, $00, $00, $00, $00),
($00, $00, $c3, $66, $3c, $18, $3c, $66, $c3, $00, $00, $00, $00),
($c0, $60, $60, $30, $18, $3c, $66, $66, $c3, $00, $00, $00, $00),
($00, $00, $ff, $60, $30, $18, $0c, $06, $ff, $00, $00, $00, $00),
($00, $00, $0f, $18, $18, $18, $38, $f0, $38, $18, $18, $18, $0f),
($18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18),
($00, $00, $f0, $18, $18, $18, $1c, $0f, $1c, $18, $18, $18, $f0),
($00, $00, $00, $00, $00, $00, $06, $8f, $f1, $60, $00, $00, $00));

procedure makeRasterFont;
var
  i : GLuint;
begin
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
  fontOffset := glGenLists (128);
  For i := 32 to 126 do begin
    glNewList(i + fontOffset, GL_COMPILE);
      glBitmap(8, 13, pp_transX,-pp_TransY, 10.0, 0.0, @rasters[i-32]);
    glEndList;
  end;
end;

procedure printString(s : String);
begin
  glPushAttrib (GL_LIST_BIT);
  glListBase(fontOffset);
  glCallLists(length(s), GL_UNSIGNED_BYTE, PChar(s));
  glPopAttrib;
end;

procedure TfmPostProcessor2.SetDCPixelFormat;
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat(dc,@pfd);
 SetPixelFormat (dc, nPixelFormat, @pfd);
end;

procedure TfmPostProcessor2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if pCanClose then
    Action:=caFree
  else
    Action:=caMinimize;
end;

procedure TfmPostProcessor2.FormCreate(Sender: TObject);
begin
  fmPreprocessor.Timer1.Enabled:=false;
  DC := GetDC(Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0.5, 0.5, 0.75, 1.0);
  makeRasterFont;
end;

procedure TfmPostProcessor2.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC(DC);
  if fmPreprocessor<>nil then fmPreprocessor.Timer1.Enabled:=true;
end;


procedure TfmPostProcessor2.Timer1Timer(Sender: TObject);
begin
  InvalidateRect(Handle,nil,false);
end;

procedure TfmPostProcessor2.FormResize(Sender: TObject);
begin
// glViewport(0, 0, ClientWidth, ClientHeight);
// glLoadIdentity;
{ glFrustum (vLeft, vRight, vBottom, vTop, vNear, vFar);    // задаем перспективу
 // этот фрагмент нужен для придания трёхмерности
 glTranslatef(0.0, 0.0, -8.0);   // перенос объекта - ось Z
 glRotatef(30.0, 1.0, 0.0, 0.0); // поворот объекта - ось X
 glRotatef(70.0, 0.0, 1.0, 0.0); // поворот объекта - ось Y
}
 InvalidateRect(Handle, nil, False);
end;

procedure TfmPostProcessor2.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down:=true;
  LastX:=X;
  LastY:=Y;
end;

procedure TfmPostProcessor2.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if down then
  begin
    pp_transX:=pp_transX+2*(X-LastX)/ClientWidth;
    pp_transY:=pp_transY-2*(Y-LastY)/ClientHeight;
    LastX:=X;
    LastY:=Y;
    InvalidateRect(Handle,nil,false);
  end;
end;

procedure TfmPostProcessor2.FormMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down:=false;
end;

procedure TfmPostProcessor2.FormPaint(Sender: TObject);
var i,j,n:int;
    mgo:TMGObject;
    blc:TBlock;
    sec:TSector;
    ttb:TTriBlock;
    tts:TTriSec;
    im:int;
    r,g,b:float;
    cl:TColor;
    ///
    v:TVector;
    ffx:float;
    a_mod,a_min,a_max:float;
    alpha,dAlpha:float;
begin
  wglMakeCurrent(DC, hrc);
  glViewPort (0, 0, ClientWidth, ClientHeight); // область вывода
  glClearColor(0.5, 0.5, 0.5, 1.0); // цвет фона
  glClear (GL_COLOR_BUFFER_BIT);      // очистка буфера цвета
  glOrtho(-1, 1, -1, 1, 0, 0);
  glTranslateF(pp_transX,pp_transY,0.0);
  glScale(pp_zoom,pp_zoom,1.0);
  // mesh
  if bMesh then
  begin
    glLineWidth(1.0);
    glDisable(GL_LINE_STIPPLE);
    for i:=1 to tt.NTriangles do
    begin
      if (tt.Topology[i][0]=mt.DefaultMaterial)and(not bAir) then continue;
      //solid
      im:=tt.Topology[i][0];
      cl:=mt.mmColor[im];
      cl2gl(cl,r,g,b);
      glColor3f (r, g, b);
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
      glBegin(GL_TRIANGLES);
        glVertex2f(glR(tt.Nodes[tt.Topology[i][1]][1]),glZ(tt.Nodes[tt.Topology[i][1]][2]));
        glVertex2f(glR(tt.Nodes[tt.Topology[i][2]][1]),glZ(tt.Nodes[tt.Topology[i][2]][2]));
        glVertex2f(glR(tt.Nodes[tt.Topology[i][3]][1]),glZ(tt.Nodes[tt.Topology[i][3]][2]));
      glEnd;
      // wire
      glColor3f (0.0, 0.75, 0.0);
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
      glBegin(GL_TRIANGLES);
        glVertex2f(glR(tt.Nodes[tt.Topology[i][1]][1]),glZ(tt.Nodes[tt.Topology[i][1]][2]));
        glVertex2f(glR(tt.Nodes[tt.Topology[i][2]][1]),glZ(tt.Nodes[tt.Topology[i][2]][2]));
        glVertex2f(glR(tt.Nodes[tt.Topology[i][3]][1]),glZ(tt.Nodes[tt.Topology[i][3]][2]));
      glEnd;
    end;
  end;
  // field projection
  if p_Visualization=1 then
  begin
    a_mod:=GetVecScale;
    GetScalarScale(a_min,a_max);
    if a_mod<1e-30 then a_mod:=1;
    for i:=1 to nQuads do
    begin
      if GetVector(i,v) then
      begin // vector
        glLineWidth(1.0);
        glColor3f (0.0, 0.0, 1.0);
        glBegin(GL_LINES);
          glVertex2f(glR(crR[i]),glZ(crZ[i]));
          glVertex2f(glR(crR[i])-0.5*pp_scale*v.x/a_mod,glZ(crZ[i])-0.5*pp_scale*v.z/a_mod);
        glEnd;
      end
      else
      begin
        glPointSize(pp_scale*20);
        if (a_max-a_min)>1e-30 then
          cl:=RBColor((v.x-a_min)/(a_max-a_min))
        else
          cl:=RBColor((v.x-a_min));
        cl2gl(cl,r,g,b);
        glColor3f(r,g,b);
        glBegin(GL_POINTS);
          glVertex2f(glR(crR[i]),glZ(crZ[i]));
        glEnd;
      end;
    end;
  end;
  // Point Slices
  if p_Visualization=2 then
  begin
    GetScalarScale(a_min,a_max);
    for i:=1 to nQuads do
    begin
      glPointSize(pp_scale*20);
      ffx:=GetValue(i);
      begin
        if (a_max-a_min)>1e-30 then cl:=RBColor((ffx-a_min)/(a_max-a_min))
        else cl:=RBColor((ffx-a_min));
        cl2gl(cl,r,g,b);
        glColor3f(r,g,b);
        glBegin(GL_POINTS);
          glVertex2f(glR(crR[i]),glZ(crZ[i]));
        glEnd;
      end;
    end;
  end;
  // Linearized Slices
  if p_Visualization=3 then
  begin
    createTri;
  end;
  // Smooth Slices
  if p_Visualization=4 then
  begin
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
    createSmooth;
   { GetScalarScale(a_min,a_max);
    for i:=1 to nQuads do
    begin
      ffx:=GetValue(i);
      begin
        if (a_max-a_min)>1e-30 then cl:=RBColor((ffx-a_min)/(a_max-a_min))
        else cl:=RBColor((ffx-a_min));
        cl2gl(cl,r,g,b);
        glColor3f(r,g,b);
        glBegin(GL_POINTS);
          glVertex2f(glR(crR[i]),glZ(crZ[i]));
        glEnd;
      end;
    end; }
  end;
  // objects
  if bObject then
  begin
    glLineWidth(1.0);
    glDisable(GL_LINE_STIPPLE);
    if bAir and (p_Objects=2) then
    begin
      glColor(1.0,1.0,1.0);
      glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
      glBegin(GL_QUADS);
        glVertex2f(glR(tt.ax),glZ(tt.az));
        glVertex2f(glR(tt.bx),glZ(tt.az));
        glVertex2f(glR(tt.bx),glZ(tt.bz));
        glVertex2f(glR(tt.ax),glZ(tt.bz));
      glEnd;
    end;
    for i:=0 to ob.Count-1 do
    begin
      mgo:=TMGObject(ob.Items[i]);
      im:=mgo.iMaterial;
      if im=tt.defMat then continue;
      cl:=mt.mmColor[im];
      cl2gl(cl,r,g,b);
      glColor3f (r,g,b);
      if mgo is TBlock then
      begin
        blc:=TBlock(ob.Items[i]);
        if (blc.y_1<=0) and (blc.y_2>=0) then
        begin
          if p_Objects=1 then
            glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
          else
            glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
          glBegin(GL_QUADS);
            glVertex2f(glR(blc.x_1),glZ(blc.z_1));
            glVertex2f(glR(blc.x_2),glZ(blc.z_1));
            glVertex2f(glR(blc.x_2),glZ(blc.z_2));
            glVertex2f(glR(blc.x_1),glZ(blc.z_2));
          glEnd;
        end;
      end
      else if mgo is TSector then
      begin
        sec:=TSector(ob.Items[i]);
        Case sec.ax_dir of
          1:if (sec.al<=0)and(sec.bt>=0) then
            begin
              if p_Objects=1 then
                glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
              else
                glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
              glBegin(GL_QUADS);
                glVertex2f(glR(sec.xx),glZ(sec.r1));
                glVertex2f(glR(sec.xx),glZ(sec.r2));
                glVertex2f(glR(sec.xx+sec.h),glZ(sec.r2));
                glVertex2f(glR(sec.xx+sec.h),glZ(sec.r1));
              glEnd;
            end;
          2:if (sec.yy<=0)and((sec.yy+sec.h)>=0) then
            begin
              if p_Objects=1 then
                glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
              else
                glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
              n:=Round((sec.bt-sec.al)/5);
              dAlpha:=(sec.bt-sec.al)/n/180*pi;
              for j:=1 to n do
              begin
                alpha:=sec.al/180*pi+dAlpha*(j-1);
                glBegin(GL_QUADS);
                  glVertex2f(glR(sec.r1*cos(alpha)),glZ(sec.r1*sin(alpha)));
                  glVertex2f(glR(sec.r2*cos(alpha)),glZ(sec.r2*sin(alpha)));
                  glVertex2f(glR(sec.r2*cos(alpha+dAlpha)),glZ(sec.r2*sin(alpha+dAlpha)));
                  glVertex2f(glR(sec.r1*cos(alpha+dAlpha)),glZ(sec.r1*sin(alpha+dAlpha)));
                glEnd;
              end;
            end;
          3:if (sec.al<=0)and(sec.bt>=0) then
            begin
              if p_Objects=1 then
                glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
              else
                glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
              glBegin(GL_QUADS);
                glVertex2f(glR(sec.r1),glZ(sec.zz));
                glVertex2f(glR(sec.r2),glZ(sec.zz));
                glVertex2f(glR(sec.r2),glZ(sec.zz+sec.h));
                glVertex2f(glR(sec.r1),glZ(sec.zz+sec.h));
              glEnd;
            end;
        end;
      end
      else if mgo is TTriBlock then
      begin
        ttb:=TTriBlock(ob.Items[i]);
        if p_Objects=1 then
          glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
        else
          glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        glBegin(GL_Triangles);
          glVertex2f(glR(ttb.x1),glZ(ttb.z1));
          glVertex2f(glR(ttb.x2),glZ(ttb.z2));
          glVertex2f(glR(ttb.x3),glZ(ttb.z3));
        glEnd;
      end
      else if mgo is TTriSec then
      begin
        tts:=TTriSec(ob.Items[i]);
        if p_Objects=1 then
          glPolygonMode(GL_FRONT_AND_BACK, GL_LINE)
        else
          glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        glBegin(GL_Triangles);
          glVertex2f(glR(tts.x1),glZ(tts.z1));
          glVertex2f(glR(tts.x2),glZ(tts.z2));
          glVertex2f(glR(tts.x3),glZ(tts.z3));
        glEnd;
      end;
    end;
  end;
  // Axis
  if bAxis then
  begin
    glLineWidth(1.2);
    glColor3f (0.0, 0.0, 0.4);
    glDisable(GL_LINE_STIPPLE);
    glBegin(GL_LINES);
      glVertex2f(-0.9,-1.0);
      glVertex2f(-0.9, 1.0);
      glVertex2f(-0.9,glZ(0));
      glVertex2f( 1.0,glZ(0));
    glEnd;
    glRasterPos2f(-0.95,glZ(0));
    printString('0');
    glRasterPos2f(0.95,glZ(0));
    printString('r');
    glRasterPos2f(-0.95,0.95);
    printString('z');
  end;
  // Bound
  if bBound then
  begin
    glLineWidth(1.0);
    glColor3f (0.0, 0.0, 0.0);
    glLineStipple(1,$FFF0);
    glEnable(GL_LINE_STIPPLE);
    glBegin(GL_LINE_LOOP);
      glVertex2f (glR(tt.ax),glZ(tt.az));
      glVertex2f (glR(tt.ax),glZ(tt.bz));
      glVertex2f (glR(tt.bx),glZ(tt.bz));
      glVertex2f (glR(tt.bx),glZ(tt.az));
    glEnd;
  end;
  // Rulers
  if bRuler then
  begin
    n:=iR+(iz-1)*v_nr;
    glLineWidth(2);
    glColor3f (0.0, 0.0, 0.0);
    glLineStipple(1,$CCCC);
    glEnable(GL_LINE_STIPPLE);
    glBegin(GL_LINES);
      glVertex2f(glR(crR[n]),glZ(tt.az));
      glVertex2f(glR(crR[n]),glZ(tt.bz));
      glVertex2f(glR(tt.ax),glZ(crZ[n]));
      glVertex2f(glR(tt.bx),glZ(crZ[n]));
    glEnd;
    glColor3f (1.0, 1.0, 1.0);
    glPointSize(5);
    glBegin(GL_POINTS);
      glVertex2f(glR(crR[n]),glZ(crZ[n]));
    glEnd;
  end;
  glDisable(GL_LINE_STIPPLE);
  // returning coordinate system
  glScale(1/pp_zoom,1/pp_zoom,1.0);
  glTranslateF(-pp_transX,-pp_transY,0.0);
  SwapBuffers(DC);         // содержимое буфера - на экран
end;

procedure TfmPostProcessor2.actSaveExecute(Sender: TObject);
begin
  height:=600;
  width:=400;
end;

procedure TfmPostProcessor2.actSaveGridExecute(Sender: TObject);
var
  i,j,k:integer;
  f:TextFile;
  v:double;
begin
  if sDlgGrid.Execute then
  begin
    AssignFile(f,sDlgGrid.FileName);
    Rewrite(f);
    writeln(f,'Text');
    write(f,0,#09);
    for j:=1 to v_nz do
    begin
      v:=crZ[1+(j-1)*v_nr]*1e3;
      write(f,v:8:3,#09);
    end;
    writeln(f);
    for i:=1 to v_nr do
    begin
      v:=crR[i]*1e3;
      write(f,v:8:3,#09);
      for j:=1 to v_nz do
      begin
        k:=i+(j-1)*v_nr;
        v:=GetValue(k);
        write(f,v,#09);
      end;
      writeln(f);
    end;
    CloseFile(f);
  end;
end;

end.
