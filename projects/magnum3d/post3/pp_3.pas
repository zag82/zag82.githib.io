unit pp_3;

interface

uses openGL, cm_ini, vi_3,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TfmPostProcessor3 = class(TForm)
    Timer1: TTimer;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    DC : HDC;
    hrc : HGLRC;
    procedure SetDCPixelFormat;
  end;

var
  fmPostProcessor3: TfmPostProcessor3;

implementation

{$R *.DFM}
uses p3_data, gl_ob, cmVars, cmData, comPlx, pre_proc, ComVars, graph_3;

const
  FLightAmbient : Array[0..3] of GLfloat = (0.5, 0.5, 0.5, 1.0);
  FLightDiffuse : Array[0..3] of GLfloat = (0.5, 0.5, 0.5, 1.0);
  FLightSpecular: Array[0..3] of GLfloat = (0.5, 0.5, 0.5, 1.0);

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

  posit : Array [0..3] of GLFloat =  (12, 12, 12.5, 1);
  ps2:array[0..3]of GLFloat= (12, 12, 12.5, 1);//(-12, 12, 12.5, 1);
  ps3:array[0..3]of GLFloat=(12, -12, 12.5, 1);
  ps4:array[0..3]of GLFloat=(-12,-12, 12.5, 1);

procedure makeRasterFont;
var
  i : GLuint;
begin
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
  fontOffset := glGenLists (128);
  For i := 32 to 126 do begin
    glNewList(i + fontOffset, GL_COMPILE);
      glBitmap(8, 13, transX,-TransY, 10.0, 0.0, @rasters[i-32]);
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

procedure TfmPostProcessor3.SetDCPixelFormat;
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat(dc,@pfd);
 SetPixelFormat (dc, nPixelFormat, @pfd);
end;

procedure TfmPostProcessor3.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if pCanClose then
    Action:=caFree
  else
    Action:=caMinimize;
end;

procedure TfmPostProcessor3.FormCreate(Sender: TObject);
begin
  fmPreprocessor.Timer1.Enabled:=false;
  DC := GetDC(Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0.5, 0.5, 0.5, 1.0);
  ///////////////////////
  glEnable(GL_DEPTH_TEST);
  makeRasterFont;
end;

procedure TfmPostProcessor3.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC(DC);
  if fmPreprocessor<>nil then fmPreprocessor.Timer1.Enabled:=true;
end;

procedure TfmPostProcessor3.Timer1Timer(Sender: TObject);
begin
  InvalidateRect(Handle,nil,false);
end;

procedure TfmPostProcessor3.FormResize(Sender: TObject);
begin
  InvalidateRect(Handle, nil, False);
end;

procedure TfmPostProcessor3.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down:=true;
  LastX:=X;
  LastY:=Y;
  btn:=Button;
end;

procedure TfmPostProcessor3.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if down then
  begin
    if btn=mbLeft then
    begin
      if angleX<360 then angleX:=angleX+360*(Y-LastY)/ClientHeight else angleX:=0;
      if angleZ<360 then angleZ:=angleZ+360*(X-LastX)/ClientWidth else angleZ:=0;
      LastX:=X;
      LastY:=Y;
    end
    else
    begin
      transX:=transX+4*(X-LastX)/ClientWidth/pr_zoom;
      transY:=transY+4*(Y-LastY)/ClientHeight/pr_zoom;
      LastX:=X;
      LastY:=Y;
    end;
    InvalidateRect(Handle,nil,false);
  end
  else
  begin
//    posit[0]:=-2+4*(X{-LastX})/ClientWidth;
//    posit[1]:=2-4*(Y{-LastY})/ClientHeight;
    LastX:=X;
    LastY:=Y;
  end;
end;

procedure TfmPostProcessor3.FormMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down:=false;
end;

procedure TfmPostProcessor3.FormPaint(Sender: TObject);
var i,j,k:int;
    mgo:TMGObject;
    blc:TBlock;
    sec:TSector;
    ttb:TTriBlock;
    tts:TTRiSec;
    im:int;
    cl:TColor;
    r,g,b:float;
    v:TVector;
    a,a_min,a_max,a_mod:float;
    n1,n2:int;
    mm,si,co:float;

  procedure DrawAxProf(k:int);
  begin
    mm:=sqrt(sqr(crX[k])+sqr(crY[k]));
    if mm<1e-30 then mm:=1;
    si:=crY[k]/mm;
    co:=crX[k]/mm;
    a:=GetValue(k);
    if v_Plane=0 then
      glVertex3f(glX(crX[k])+0.1*pr_scale*a/a_mod*co,glX(crY[k])+0.1*pr_scale*a/a_mod*si,glX(crZ[k]))
    else
      glVertex3f(glX(crX[k])-0.1*pr_scale*a/a_mod*si,glX(crY[k])+0.1*pr_scale*a/a_mod*co,glX(crZ[k]));
  end;

begin
  wglMakeCurrent(DC, hrc);
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode (GL_PROJECTION);
  glLoadIdentity;
  glMatrixMode (GL_MODELVIEW);
  glLoadIdentity;
  glOrtho(-2, 2, -2, 2, -2, 50);
  glEnable(GL_COLOR_MATERIAL);
  glShadeModel(GL_smooth);
  // shifting and rotation
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glTranslatef(0.0, 0.0, -10.0);
  // turn on/off the light
  glScalef(pr_zoom,pr_zoom,pr_zoom);
  glTranslatef(transX,-transY,0);
  if bLight then
  begin
    glPOintSize(10);
    glColor3f(0.0,1.0,0.0);
    glBegin(GL_POINTS);
      glVertex3f(posit[0],posit[1],posit[2]);
    glEnd;
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
//    glEnable(GL_LIGHT1);
//    glEnable(GL_LIGHT2);
//    glEnable(GL_LIGHT3);
    glLightfv(GL_LIGHT0, GL_POSITION, @posit);
//    glLightfv(GL_LIGHT1, GL_POSITION, @ps2);
//    glLightfv(GL_LIGHT2, GL_POSITION, @ps3);
//    glLightfv(GL_LIGHT3, GL_POSITION, @ps4);
  end
  else
  begin
    glDisable(GL_LIGHTING);
    glDisable(GL_LIGHT0);
  end;
  glRotatef(angleX,1,0,0);
  glRotatef(angleY,0,1,0);
  glRotatef(angleZ,0,0,1);
  /////////////
  // wire objects
  if bObject then
  begin
    for i:=0 to ob.Count-1 do
    begin
      mgo:=TMGObject(ob.Items[i]);
      im:=mgo.GetMaterial;
      cl:=mt.mmColor[im];
      cl2gl(cl,r,g,b);
      glColor3f(r,g,b);
      if mgo is TBlock then
      begin
        blc:=TBlock(mgo);
        oglWireBlock(blc);
      end
      else if mgo is TSector then
      begin
        sec:=TSector(mgo);
        oglWireSector(sec);
      end
      else if mgo is TTriBlock then
      begin
        ttb:=TTriBlock(mgo);
        oglWireTriBlock(ttb);
      end
      else if mgo is TTriSec then
      begin
        tts:=TTriSec(mgo);
        oglWireTriSec(tts);
      end;
    end;
  end;
  /////////////
  // solid objects
  if bSolid then
  begin
    for i:=1 to NElements do
    begin
      if (ATopology[i][0]=mt.DefaultMaterial)and(not bAir) then continue;
      im:=ATopology[i][0];
      cl:=mt.mmColor[im];
      cl2gl(cl,r,g,b);
      glColor3f(r,g,b);
      oglSolidTetrahedron(i);
    end;
  end;
  /////////////
  // mesh
  if bMesh then
  begin
    glColor3f(0,0.75,0);
    for i:=1 to NElements do
    begin
      if (ATopology[i][0]=mt.DefaultMaterial)and(not bAir) then continue;
      oglWireTetrahedron(i);
    end;
  end;
  /////////////
  // axis
  if bBound then
  begin
    glColor3f(0,0,0);
    glBegin(GL_lines);
      glVertex3f(0.0,0.0,0.0);
      glVertex3f(1.1,0.0,0.0);
      glVertex3f(0.0,0.0,0.0);
      glVertex3f(0.0,1.1,0.0);
      glVertex3f(0.0,0.0,0.0);
      glVertex3f(0.0,0.0,1.1);
    glEnd;
    // axis names
    glRasterPos3f(1.1,0,0);
    printString('X');
    glRasterPos3f(0,1.1,0);
    printString('Y');
    glRasterPos3f(0,0,1.1);
    printString('Z');
    // Bounds
    glColor3f(0,0,0);
    oglBound3D;
  end;
  ///////////////
  // fields
  if v_Visualisation=1 then     // map
  begin
    a_mod:=GetVecScale;
    GetScalarScale(a_min,a_max);
    if a_mod<1e-30 then a_mod:=1;
    for i:=1 to nCubes do
    begin
      if GetVector(i,v) then
      begin // vector
        glLineWidth(1.0);
        glColor3f (0.0, 0.0, 1.0);
        glBegin(GL_LINES);
          glVertex3f(glX(crX[i]),glX(crY[i]),glX(crZ[i]));
          glVertex3f(glX(crX[i])-0.1*pr_scale*v.x/a_mod,glX(crY[i])-0.1*pr_scale*v.y/a_mod,glX(crZ[i])-0.1*pr_scale*v.z/a_mod);
        glEnd;
      end
      else
      begin
        glPointSize(pr_scale*2);
        if (a_max-a_min)>1e-30 then
          cl:=RBColor((v.x-a_min)/(a_max-a_min))
        else
          cl:=RBColor((v.x-a_min));
        cl2gl(cl,r,g,b);
        glColor3f(r,g,b);
        glBegin(GL_POINTS);
          glVertex3f(glX(crX[i]),glX(crY[i]),glX(crZ[i]));
        glEnd;
      end;
    end;
  end;
  if v_Visualisation=2 then // projection
  begin
    a_mod:=GetVecScale;
    GetScalarScale(a_min,a_max);
    if a_mod<1e-30 then a_mod:=1;
    case v_Plane of
      0:begin n1:=v_ny; n2:=v_nz; end;
      1:begin n1:=v_nx; n2:=v_nz; end;
      2:begin n1:=v_nx; n2:=v_ny; end;
    end;
    DrawPlane;
    for i:=1 to n1 do
    for j:=1 to n2 do
    begin
      Case v_plane of
        0:k:=Num2Cube(v_ProfDist,i,j);
        1:k:=Num2Cube(i,v_ProfDist,j);
        2:k:=Num2Cube(i,j,v_ProfDist);
      end;
      if GetVector(k,v) then
      begin // vector
        glLineWidth(1.0);
        glColor3f (0.0, 0.0, 1.0);
        if axa.mesh_s=1 then  // carthesian
        begin
        glBegin(GL_LINES);
          glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k]));
          Case v_Plane of
            0:glVertex3f(glX(crX[k]),glX(crY[k])-0.1*pr_scale*v.y/a_mod,glX(crZ[k])-0.1*pr_scale*v.z/a_mod);
            1:glVertex3f(glX(crX[k])-0.1*pr_scale*v.x/a_mod,glX(crY[k]),glX(crZ[k])-0.1*pr_scale*v.z/a_mod);
            2:glVertex3f(glX(crX[k])-0.1*pr_scale*v.x/a_mod,glX(crY[k])-0.1*pr_scale*v.y/a_mod,glX(crZ[k]));
          end;
        glEnd;
        end
        else     // cylindrical
        begin
        mm:=sqrt(sqr(crX[k])+sqr(crY[k]));
        if mm<1e-30 then mm:=1;
        si:=crY[k]/mm;
        co:=crX[k]/mm;
        glBegin(GL_LINES);
          glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k]));
          Case v_Plane of
            0:glVertex3f(glX(crX[k])+0.1*pr_scale*v.ph/a_mod*si,glX(crY[k])-0.1*pr_scale*v.ph/a_mod*co,glX(crZ[k])-0.1*pr_scale*v.z/a_mod);
            1:glVertex3f(glX(crX[k])-0.1*pr_scale*v.r/a_mod*co,glX(crY[k])-0.1*pr_scale*v.r/a_mod*si,glX(crZ[k])-0.1*pr_scale*v.z/a_mod);
            2:glVertex3f(glX(crX[k])-0.1*pr_scale*v.x/a_mod,glX(crY[k])-0.1*pr_scale*v.y/a_mod,glX(crZ[k]));
          end;
        glEnd;
        end;
      end
      else
      begin
        glPointSize(pr_scale*2);
        if (a_max-a_min)>1e-30 then
          cl:=RBColor((v.x-a_min)/(a_max-a_min))
        else
          cl:=RBColor((v.x-a_min));
        cl2gl(cl,r,g,b);
        glColor3f(r,g,b);
        glBegin(GL_POINTS);
          glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k]));
        glEnd;
      end;
    end;
  end;
  if v_Visualisation=3 then // profile
  begin
    FillGraphVal;
    a_mod:=GetVecScale;
    GetScalarScale(a_min,a_max);
    if a_mod<1e-30 then a_mod:=1;
    case v_Plane of
      0:begin n1:=v_ny; n2:=v_nz; end;
      1:begin n1:=v_nx; n2:=v_nz; end;
      2:begin n1:=v_nx; n2:=v_ny; end;
    end;
    DrawPlane;
    glLineWidth(1.0);
    for i:=1 to n1-1 do
    for j:=1 to n2-1 do
    begin
      glColor3f (0.0, 0.0, 1.0);
      if axa.mesh_s=1 then  // carthesian
        Case v_plane of
        0:begin
            glBegin(GL_QUADS);
              k:=Num2Cube(v_ProfDist,i,j);     a:=GetValue(k); glVertex3f(glX(crX[k])+0.1*pr_scale*a/a_mod,glX(crY[k]),glX(crZ[k]));
              k:=Num2Cube(v_ProfDist,i+1,j);   a:=GetValue(k); glVertex3f(glX(crX[k])+0.1*pr_scale*a/a_mod,glX(crY[k]),glX(crZ[k]));
              k:=Num2Cube(v_ProfDist,i+1,j+1); a:=GetValue(k); glVertex3f(glX(crX[k])+0.1*pr_scale*a/a_mod,glX(crY[k]),glX(crZ[k]));
              k:=Num2Cube(v_ProfDist,i,j+1);   a:=GetValue(k); glVertex3f(glX(crX[k])+0.1*pr_scale*a/a_mod,glX(crY[k]),glX(crZ[k]));
            glEnd;
          end;
        1:begin
            glBegin(GL_QUADS);
              k:=Num2Cube(i,v_ProfDist,j);     a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k])+0.1*pr_scale*a/a_mod,glX(crZ[k]));
              k:=Num2Cube(i+1,v_ProfDist,j);   a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k])+0.1*pr_scale*a/a_mod,glX(crZ[k]));
              k:=Num2Cube(i+1,v_ProfDist,j+1); a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k])+0.1*pr_scale*a/a_mod,glX(crZ[k]));
              k:=Num2Cube(i,v_ProfDist,j+1);   a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k])+0.1*pr_scale*a/a_mod,glX(crZ[k]));
            glEnd;
          end;
        2:begin
            glBegin(GL_QUADS);
              k:=Num2Cube(i,j,v_ProfDist);     a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
              k:=Num2Cube(i+1,j,v_ProfDist);   a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
              k:=Num2Cube(i+1,j+1,v_ProfDist); a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
              k:=Num2Cube(i,j+1,v_ProfDist);   a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
            glEnd;
          end;
        end
      else   // cylindrical
      begin
        Case v_plane of
        0:begin
            glBegin(GL_QUADS);
              k:=Num2Cube(v_ProfDist,i,j);     DrawAxProf(k);
              k:=Num2Cube(v_ProfDist,i+1,j);   DrawAxProf(k);
              k:=Num2Cube(v_ProfDist,i+1,j+1); DrawAxProf(k);
              k:=Num2Cube(v_ProfDist,i,j+1);   DrawAxProf(k);
            glEnd;
          end;
        1:begin
            glBegin(GL_QUADS);
              k:=Num2Cube(i,v_ProfDist,j);     DrawAxProf(k);
              k:=Num2Cube(i+1,v_ProfDist,j);   DrawAxProf(k);
              k:=Num2Cube(i+1,v_ProfDist,j+1); DrawAxProf(k);
              k:=Num2Cube(i,v_ProfDist,j+1);   DrawAxProf(k);
            glEnd;
          end;
        2:begin
            glBegin(GL_QUADS);
              k:=Num2Cube(i,j,v_ProfDist);     a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
              k:=Num2Cube(i+1,j,v_ProfDist);   a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
              k:=Num2Cube(i+1,j+1,v_ProfDist); a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
              k:=Num2Cube(i,j+1,v_ProfDist);   a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod);
            glEnd;
          end;
        end
      end;
    end;
    glEnable(GL_POINT_SMOOTH);
    glPointSize(5);
    glColor3f(1.0,1.0,0.0);
    glBegin(GL_POINTS);
    for i:=1 to gr_Num do
    begin
      if axa.mesh_s=1 then  // carthesian
        Case v_plane of
        0:begin if v_Dir=1 then k:=Num2Cube(v_ProfDist,i,v_GrapDist) else k:=Num2Cube(v_ProfDist,v_GrapDist,i); a:=GetValue(k); glVertex3f(glX(crX[k])+0.1*pr_scale*a/a_mod,glX(crY[k]),glX(crZ[k])); end;
        1:begin if v_Dir=0 then k:=Num2Cube(i,v_ProfDist,v_GrapDist) else k:=Num2Cube(v_GrapDist,v_ProfDist,i); a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k])+0.1*pr_scale*a/a_mod,glX(crZ[k])); end;
        2:begin if v_Dir=0 then k:=Num2Cube(i,v_GrapDist,v_ProfDist) else k:=Num2Cube(v_GrapDist,i,v_ProfDist); a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod); end;
        end
      else   // cylindrical
        Case v_plane of
        0:begin if v_Dir=1 then k:=Num2Cube(v_ProfDist,i,v_GrapDist) else k:=Num2Cube(v_ProfDist,v_GrapDist,i); DrawAxProf(k); end;
        1:begin if v_Dir=0 then k:=Num2Cube(i,v_ProfDist,v_GrapDist) else k:=Num2Cube(v_GrapDist,v_ProfDist,i); DrawAxProf(k); end;
        2:begin if v_Dir=0 then k:=Num2Cube(i,v_GrapDist,v_ProfDist) else k:=Num2Cube(v_GrapDist,i,v_ProfDist); a:=GetValue(k); glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k])+0.1*pr_scale*a/a_mod); end;
        end
    end;
    glEnd;
    glDisable(GL_POINT_SMOOTH);
    if (bGraphReDraw)and(fmVInspector3.cbx.Checked) then
    begin
      fmGraph3.LoadGraphic;
      bGraphReDraw:=false;
    end;
  end;
  if v_Visualisation=4 then   // slices
  begin
    createTri;
  end;
  ////////////////////////////
  // Value vision
  if bValue then
  begin
    k:=Num2Cube(vDir1,vDir2,vDir3);
    glEnable(GL_POINT_SMOOTH);
    glPointSize(10);
    glColor3f (1.0, 1.0, 1.0);
    glBegin(GL_POINTS);
    if axa.mesh_s=1 then  // carthesian
      glVertex3f(glX(crX[k]),glX(crY[k]),glX(crZ[k]))
    else
      glVertex3f(glX(crR[k]*cos(crFi[k])),glX(crR[k]*sin(crFi[k])),glX(crZ[k]));
    glEnd;
    glDisable(GL_POINT_SMOOTH);
  end;
  // restore previous settings
  glScalef(1/pr_zoom,1/pr_zoom,1/pr_zoom);
  glRotatef(angleX,-1,0,0);
  glRotatef(angleY,0,-1,0);
  glRotatef(angleZ,0,0,-1);
  glTranslatef(-transX,transY,0);
  glTranslatef(0.0, 0.0, 10.0);
  glFlush();
  SwapBuffers(DC);
end;

procedure TfmPostProcessor3.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_UP:   posit[1]:=posit[1]+0.1;
    VK_DOWN: posit[1]:=posit[1]-0.1;
    VK_Left: posit[0]:=posit[0]-0.1;
    VK_RIGHT:posit[0]:=posit[0]+0.1;
    VK_F5:   posit[2]:=posit[2]+0.1;
    VK_F6:   posit[2]:=posit[2]-0.1;
    VK_F7:   posit[3]:=posit[3]+0.1;
    VK_F8:   posit[3]:=posit[3]-0.1;
  end;
  Self.Caption:=FloatToStrF(posit[0],ffFixed,5,2)+':'+
                FloatToStrF(posit[1],ffFixed,5,2)+':'+
                FloatToStrF(posit[2],ffFixed,5,2)+':'+
                FloatToStrF(posit[3],ffFixed,5,2);
end;

end.
