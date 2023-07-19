unit gl_ob;

interface
uses
  opengl, cm_ini, cmData, Graphics, ComVars;

function glX(x:float):float;
procedure cl2gl(cl:TColor; var r,g,b:float);
procedure oglWireSector(sec:TSector);
procedure oglWireBlock(blc:TBlock);
procedure oglWireTriBlock(ttb:TTriBlock);
procedure oglWireTriSec(tts:TTriSec);
procedure oglWireTetrahedron(iElement:int);
procedure oglSolidTetrahedron(iElement:int);
procedure oglBound3D;
procedure DrawPlane;

implementation

uses
  cmVars, p3_data;

function glX(x:float):float;
var m,k:float;
begin
  if axa.mesh_s=0 then k:=0 else k:=axa.by;
  m:=max(axa.bx,max(k,axa.bz));
  if m<1e-5 then m:=max(tt.bx,tt.bz);
  Result:=x/m;
end;

procedure cl2gl(cl:TColor; var r,g,b:float);
var a1,a2,a3:int;
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

procedure oglWireSector(sec:TSector);
var
  alpha,dAlpha:float;
  j,n:int;
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  Case sec.ax_dir of
    1:begin // along x
        n:=Round((sec.bt-sec.al)/10);
        dAlpha:=(sec.bt-sec.al)/n/180*pi;
        for j:=1 to n+1 do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
           glBegin(GL_QUADS);
             glVertex3f(glX(sec.xx),glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)));
             glVertex3f(glX(sec.xx),glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)));
             glVertex3f(glX(sec.xx+sec.h),glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)));
             glVertex3f(glX(sec.xx+sec.h),glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)));
           glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.xx),glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.xx),glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)));
          glEnd;
        end;
        ///
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.xx),glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.xx),glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.xx),glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.xx+sec.h),glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.xx),glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)));
          glEnd;
        end;
      end;
    2:begin // along y
        n:=Round((sec.bt-sec.al)/10);
        dAlpha:=(sec.bt-sec.al)/n/180*pi;
        for j:=1 to n+1 do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.yy),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.yy),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.yy+sec.h),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.yy+sec.h),glX(sec.r1*sin(alpha)));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.yy),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.yy),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.yy),glX(sec.r2*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.yy),glX(sec.r1*sin(alpha+dAlpha)));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.yy+sec.h),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.yy+sec.h),glX(sec.r2*sin(alpha)));
            glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.yy+sec.h),glX(sec.r2*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.yy+sec.h),glX(sec.r1*sin(alpha+dAlpha)));
          glEnd;
        end;
        ///
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.yy),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.yy+sec.h),glX(sec.r1*sin(alpha)));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.yy+sec.h),glX(sec.r1*sin(alpha+dAlpha)));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.yy),glX(sec.r1*sin(alpha+dAlpha)));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.yy),glX(sec.r2*sin(alpha)));
              glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.yy+sec.h),glX(sec.r2*sin(alpha)));
              glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.yy+sec.h),glX(sec.r2*sin(alpha+dAlpha)));
              glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.yy),glX(sec.r2*sin(alpha+dAlpha)));
            glEnd;
        end;
      end;
    3:begin // along z
        n:=Round((sec.bt-sec.al)/10);
        dAlpha:=(sec.bt-sec.al)/n/180*pi;
        for j:=1 to n+1 do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)),glX(sec.zz));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)),glX(sec.zz));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)),glX(sec.zz+sec.h));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)),glX(sec.zz));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)),glX(sec.zz));
            glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)),glX(sec.zz));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)),glX(sec.zz));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)),glX(sec.zz+sec.h));
          glEnd;
        end;
        ///
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)),glX(sec.zz));
            glVertex3f(glX(sec.r1*cos(alpha)),glX(sec.r1*sin(alpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r1*cos(alpha+dAlpha)),glX(sec.r1*sin(alpha+dAlpha)),glX(sec.zz));
          glEnd;
        end;
        for j:=1 to n do
        begin
          alpha:=sec.al/180*pi+dAlpha*(j-1);
          glBegin(GL_QUADS);
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)),glX(sec.zz));
            glVertex3f(glX(sec.r2*cos(alpha)),glX(sec.r2*sin(alpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)),glX(sec.zz+sec.h));
            glVertex3f(glX(sec.r2*cos(alpha+dAlpha)),glX(sec.r2*sin(alpha+dAlpha)),glX(sec.zz));
          glEnd;
        end;
      end;
  end;
end;

procedure oglWireBlock(blc:TBlock);
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glBegin(GL_QUADS);
    glVertex3f(glX(blc.x_1),glX(blc.y_1),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_1),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_2),glX(blc.z_1));
    glVertex3f(glX(blc.x_1),glX(blc.y_2),glX(blc.z_1));
    //
    glVertex3f(glX(blc.x_1),glX(blc.y_1),glX(blc.z_2));
    glVertex3f(glX(blc.x_2),glX(blc.y_1),glX(blc.z_2));
    glVertex3f(glX(blc.x_2),glX(blc.y_2),glX(blc.z_2));
    glVertex3f(glX(blc.x_1),glX(blc.y_2),glX(blc.z_2));
    //
    glVertex3f(glX(blc.x_1),glX(blc.y_1),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_1),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_1),glX(blc.z_2));
    glVertex3f(glX(blc.x_1),glX(blc.y_1),glX(blc.z_2));
    //
    glVertex3f(glX(blc.x_1),glX(blc.y_2),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_2),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_2),glX(blc.z_2));
    glVertex3f(glX(blc.x_1),glX(blc.y_2),glX(blc.z_2));
    //
    glVertex3f(glX(blc.x_1),glX(blc.y_1),glX(blc.z_1));
    glVertex3f(glX(blc.x_1),glX(blc.y_2),glX(blc.z_1));
    glVertex3f(glX(blc.x_1),glX(blc.y_2),glX(blc.z_2));
    glVertex3f(glX(blc.x_1),glX(blc.y_1),glX(blc.z_2));
    //
    glVertex3f(glX(blc.x_2),glX(blc.y_1),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_2),glX(blc.z_1));
    glVertex3f(glX(blc.x_2),glX(blc.y_2),glX(blc.z_2));
    glVertex3f(glX(blc.x_2),glX(blc.y_1),glX(blc.z_2));
  glEnd;
end;

procedure oglWireTriBlock(ttb:TTriBlock);
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glBegin(GL_QUADS);
    glVertex3f(glX(ttb.x1),glX(ttb.y_min),glX(ttb.z1));
    glVertex3f(glX(ttb.x2),glX(ttb.y_min),glX(ttb.z2));
    glVertex3f(glX(ttb.x2),glX(ttb.y_max),glX(ttb.z2));
    glVertex3f(glX(ttb.x1),glX(ttb.y_max),glX(ttb.z1));
    //
    glVertex3f(glX(ttb.x3),glX(ttb.y_min),glX(ttb.z3));
    glVertex3f(glX(ttb.x2),glX(ttb.y_min),glX(ttb.z2));
    glVertex3f(glX(ttb.x2),glX(ttb.y_max),glX(ttb.z2));
    glVertex3f(glX(ttb.x3),glX(ttb.y_max),glX(ttb.z3));
    //
    glVertex3f(glX(ttb.x1),glX(ttb.y_min),glX(ttb.z1));
    glVertex3f(glX(ttb.x3),glX(ttb.y_min),glX(ttb.z3));
    glVertex3f(glX(ttb.x3),glX(ttb.y_max),glX(ttb.z3));
    glVertex3f(glX(ttb.x1),glX(ttb.y_max),glX(ttb.z1));
  glEnd;
end;

procedure oglWireTriSec(tts:TTriSec);
var
  alpha,dAlpha:float;
  j,n:int;
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  n:=Round((tts.bt-tts.al)/10);
  dAlpha:=(tts.bt-tts.al)/n/180*pi;
  for j:=1 to n+1 do
  begin
    alpha:=tts.al/180*pi+dAlpha*(j-1);
    glBegin(GL_TRIANGLES);
      glVertex3f(glX(tts.x1*cos(alpha)),glX(tts.x1*sin(alpha)),glX(tts.z1));
      glVertex3f(glX(tts.x2*cos(alpha)),glX(tts.x2*sin(alpha)),glX(tts.z2));
      glVertex3f(glX(tts.x3*cos(alpha)),glX(tts.x3*sin(alpha)),glX(tts.z3));
    glEnd;
  end;
  for j:=1 to n do
  begin
    alpha:=tts.al/180*pi+dAlpha*(j-1);
    glBegin(GL_LINES);
      glVertex3f(glX(tts.x1*cos(alpha)),glX(tts.x1*sin(alpha)),glX(tts.z1));
      glVertex3f(glX(tts.x1*cos(alpha+dAlpha)),glX(tts.x1*sin(alpha+dAlpha)),glX(tts.z1));
      //
      glVertex3f(glX(tts.x2*cos(alpha)),glX(tts.x2*sin(alpha)),glX(tts.z2));
      glVertex3f(glX(tts.x2*cos(alpha+dAlpha)),glX(tts.x2*sin(alpha+dAlpha)),glX(tts.z2));
      //
      glVertex3f(glX(tts.x3*cos(alpha)),glX(tts.x3*sin(alpha)),glX(tts.z3));
      glVertex3f(glX(tts.x3*cos(alpha+dAlpha)),glX(tts.x3*sin(alpha+dAlpha)),glX(tts.z3));
    glEnd;
  end;
end;

procedure getNormals(x1,x2,y1,y2,z1,z2:float;var nx,ny,nz:float);
var mm:float;
begin
  nx:=z2*y1-z1*y2;
  ny:=x2*z1-x1*z2;
  nz:=y2*x1-y1*x2;
  mm:=sqrt(sqr(nx)+sqr(ny)+sqr(nz));
  if mm<1e-25 then mm:=1;
  nx:=nx/mm;
  ny:=ny/mm;
  nz:=nz/mm;
end;

procedure oglTriangle(x1,y1,z1,x2,y2,z2,x3,y3,z3:float; k:boolean);
var xx1,xx2,yy1,yy2,zz1,zz2:float;
    nx,ny,nz:float;
begin
  xx1:=x2-x1;
  xx2:=x3-x1;
  yy1:=y2-y1;
  yy2:=y3-y1;
  zz1:=z2-z1;
  zz2:=z3-z1;
  getNormals(xx1,xx2,yy1,yy2,zz1,zz2,nx,ny,nz);
  glBegin(GL_TRIANGLES);
    if k then glNormal3f(nx,ny,nz);
    glVertex3f(glX(x1),glX(y1),glX(z1));
    glVertex3f(glX(x2),glX(y2),glX(z2));
    glVertex3f(glX(x3),glX(y3),glX(z3));
  glEnd;
end;

procedure oglTetrahedron(iElement:int; k:boolean);
var x1,y1,z1,x2,y2,z2,x3,y3,z3:float;
    i:int;
begin
  glDisable(GL_LINE_STIPPLE);
  i:=iElement;
  // 1
  x1:=Crd_x[ATopology[i][1]];
  x2:=Crd_x[ATopology[i][2]];
  x3:=Crd_x[ATopology[i][3]];
    y1:=Crd_y[ATopology[i][1]];
    y2:=Crd_y[ATopology[i][2]];
    y3:=Crd_y[ATopology[i][3]];
      z1:=Crd_z[ATopology[i][1]];
      z2:=Crd_z[ATopology[i][2]];
      z3:=Crd_z[ATopology[i][3]];
  oglTriangle(x1,y1,z1,x2,y2,z2,x3,y3,z3,k);
  // 2
  x1:=Crd_x[ATopology[i][1]];
  x2:=Crd_x[ATopology[i][2]];
  x3:=Crd_x[ATopology[i][4]];
    y1:=Crd_y[ATopology[i][1]];
    y2:=Crd_y[ATopology[i][2]];
    y3:=Crd_y[ATopology[i][4]];
      z1:=Crd_z[ATopology[i][1]];
      z2:=Crd_z[ATopology[i][2]];
      z3:=Crd_z[ATopology[i][4]];
  oglTriangle(x1,y1,z1,x2,y2,z2,x3,y3,z3,k);
  // 3
  x1:=Crd_x[ATopology[i][4]];
  x2:=Crd_x[ATopology[i][2]];
  x3:=Crd_x[ATopology[i][3]];
    y1:=Crd_y[ATopology[i][4]];
    y2:=Crd_y[ATopology[i][2]];
    y3:=Crd_y[ATopology[i][3]];
      z1:=Crd_z[ATopology[i][4]];
      z2:=Crd_z[ATopology[i][2]];
      z3:=Crd_z[ATopology[i][3]];
  oglTriangle(x1,y1,z1,x2,y2,z2,x3,y3,z3,k);
  // 4
  x1:=Crd_x[ATopology[i][1]];
  x2:=Crd_x[ATopology[i][4]];
  x3:=Crd_x[ATopology[i][3]];
    y1:=Crd_y[ATopology[i][1]];
    y2:=Crd_y[ATopology[i][4]];
    y3:=Crd_y[ATopology[i][3]];
      z1:=Crd_z[ATopology[i][1]];
      z2:=Crd_z[ATopology[i][4]];
      z3:=Crd_z[ATopology[i][3]];
  oglTriangle(x1,y1,z1,x2,y2,z2,x3,y3,z3,k);
end;

procedure oglWireTetrahedron(iElement:int);
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  oglTetrahedron(iElement,false);
end;

procedure oglSolidTetrahedron(iElement:int);
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
  oglTetrahedron(iElement,true);
end;

procedure oglBound3D;
var i,n:int;
    alpha,dAlpha:float;
    blc:TBlock;
    ph:float;
begin
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  if axa.mesh_s=0 then
  begin
    if axa.adpt=0 then
    begin
      ph:=axa.ay*pi/180;
      glBegin(GL_LINE_LOOP);
        glVertex3f(glX(axa.ax*cos(ph)),glX(axa.ax*sin(ph)),glX(axa.az));
        glVertex3f(glX(axa.bx*cos(ph)),glX(axa.bx*sin(ph)),glX(axa.az));
        glVertex3f(glX(axa.bx*cos(ph)),glX(axa.bx*sin(ph)),glX(axa.bz));
        glVertex3f(glX(axa.ax*cos(ph)),glX(axa.ax*sin(ph)),glX(axa.bz));
      glEnd;
      ph:=axa.by*pi/180;
      glBegin(GL_LINE_LOOP);
        glVertex3f(glX(axa.ax*cos(ph)),glX(axa.ax*sin(ph)),glX(axa.az));
        glVertex3f(glX(axa.bx*cos(ph)),glX(axa.bx*sin(ph)),glX(axa.az));
        glVertex3f(glX(axa.bx*cos(ph)),glX(axa.bx*sin(ph)),glX(axa.bz));
        glVertex3f(glX(axa.ax*cos(ph)),glX(axa.ax*sin(ph)),glX(axa.bz));
      glEnd;
      //
      n:=Round((axa.by-axa.ay)/10);
      dAlpha:=(axa.by-axa.ay)/n/180*pi;
      glBegin(GL_LINE_STRIP);
      for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(axa.ax*cos(alpha)),glX(axa.ax*sin(alpha)),glX(axa.az)); end;
      glEnd;
      glBegin(GL_LINE_STRIP);
      for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(axa.ax*cos(alpha)),glX(axa.ax*sin(alpha)),glX(axa.bz)); end;
      glEnd;
      glBegin(GL_LINE_STRIP);
      for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(axa.bx*cos(alpha)),glX(axa.bx*sin(alpha)),glX(axa.bz)); end;
      glEnd;
      glBegin(GL_LINE_STRIP);
      for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(axa.bx*cos(alpha)),glX(axa.bx*sin(alpha)),glX(axa.az)); end;
      glEnd;
    end
    else
    begin
      blc:=TBlock.Create(1,'aaa');
      with axa do blc.SetData(ax,ax,az,bx,bx,bz);
      oglWireBlock(blc);
      blc.Free;
    end
  end
  else
  begin
    blc:=TBlock.Create(1,'aaa');
    with axa do blc.SetData(ax,ay,az,bx,by,bz);
    oglWireBlock(blc);
    blc.Free;
  end;
end;

procedure DrawPlane;
var k:int;
    i,n:int;
    alpha,dAlpha:float;
    a,b:float;
begin
  glLineWidth(1.0);
  glLineStipple(1,$FFF0);
  glEnable(GL_LINE_STIPPLE);
  glColor3f (0.0, 0.0, 0.0);
  if axa.mesh_s=1 then //carthesian
  case v_Plane of
    0:begin
        k:=Num2Cube(v_ProfDist,1,1);
        glBegin(GL_LINE_LOOP);
          glVertex3f(glX(crX[k]),glX(axa.ay),glX(axa.az));
          glVertex3f(glX(crX[k]),glX(axa.by),glX(axa.az));
          glVertex3f(glX(crX[k]),glX(axa.by),glX(axa.bz));
          glVertex3f(glX(crX[k]),glX(axa.ay),glX(axa.bz));
        glEnd;
      end;
    1:begin
        k:=Num2Cube(1,v_ProfDist,1);
        glBegin(GL_LINE_LOOP);
          glVertex3f(glX(axa.ax),glX(crY[k]),glX(axa.az));
          glVertex3f(glX(axa.bx),glX(crY[k]),glX(axa.az));
          glVertex3f(glX(axa.bx),glX(crY[k]),glX(axa.bz));
          glVertex3f(glX(axa.ax),glX(crY[k]),glX(axa.bz));
        glEnd;
      end;
    2:begin
        k:=Num2Cube(1,1,v_ProfDist);
        glBegin(GL_LINE_LOOP);
          glVertex3f(glX(axa.ax),glX(axa.ay),glX(crZ[k]));
          glVertex3f(glX(axa.bx),glX(axa.ay),glX(crZ[k]));
          glVertex3f(glX(axa.bx),glX(axa.by),glX(crZ[k]));
          glVertex3f(glX(axa.ax),glX(axa.by),glX(crZ[k]));
        glEnd;
      end;
  end
  else
  begin
  a:=axa.ay/180*pi;
  b:=axa.by/180*pi;
  case v_Plane of
    0:begin
        k:=Num2Cube(v_ProfDist,1,1);
        n:=Round((axa.by-axa.ay)/10);
        dAlpha:=(axa.by-axa.ay)/n/180*pi;
        glBegin(GL_LINE_STRIP);
        for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(crR[k]*cos(alpha)),glX(crR[k]*sin(alpha)),glX(axa.az)); end;
        glEnd;
        glBegin(GL_LINE_STRIP);
        for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(crR[k]*cos(alpha)),glX(crR[k]*sin(alpha)),glX(axa.bz)); end;
        glEnd;
        glBegin(GL_LINES);
          glVertex3f(glX(crR[k]*cos(a)),glX(crR[k]*sin(a)),glX(axa.az));
          glVertex3f(glX(crR[k]*cos(a)),glX(crR[k]*sin(a)),glX(axa.bz));
          glVertex3f(glX(crR[k]*cos(b)),glX(crR[k]*sin(b)),glX(axa.az));
          glVertex3f(glX(crR[k]*cos(b)),glX(crR[k]*sin(b)),glX(axa.bz));
        glEnd;
      end;
    1:begin
        k:=Num2Cube(1,v_ProfDist,1);
        glBegin(GL_LINE_LOOP);
          glVertex3f(glX(axa.ax*cos(crFi[k])),glX(axa.ax*sin(crFi[k])),glX(axa.az));
          glVertex3f(glX(axa.bx*cos(crFi[k])),glX(axa.bx*sin(crFi[k])),glX(axa.az));
          glVertex3f(glX(axa.bx*cos(crFi[k])),glX(axa.bx*sin(crFi[k])),glX(axa.bz));
          glVertex3f(glX(axa.ax*cos(crFi[k])),glX(axa.ax*sin(crFi[k])),glX(axa.bz));
        glEnd;
      end;
    2:begin
        k:=Num2Cube(1,1,v_ProfDist);
        n:=Round((axa.by-axa.ay)/10);
        dAlpha:=(axa.by-axa.ay)/n/180*pi;
        glBegin(GL_Lines);
          glVertex3f(glX(axa.ax*cos(a)),glX(axa.ax*sin(a)),glX(crZ[k]));
          glVertex3f(glX(axa.bx*cos(a)),glX(axa.bx*sin(a)),glX(crZ[k]));
          glVertex3f(glX(axa.ax*cos(b)),glX(axa.ax*sin(b)),glX(crZ[k]));
          glVertex3f(glX(axa.bx*cos(b)),glX(axa.bx*sin(b)),glX(crZ[k]));
        glEnd;
        glBegin(GL_LINE_STRIP);
        for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(axa.ax*cos(alpha)),glX(axa.ax*sin(alpha)),glX(crZ[k])); end;
        glEnd;
        glBegin(GL_LINE_STRIP);
        for i:=1 to n+1 do begin alpha:=axa.ay/180*pi+dAlpha*(i-1); glVertex3f(glX(axa.bx*cos(alpha)),glX(axa.bx*sin(alpha)),glX(crZ[k])); end;
        glEnd;
      end;
    end;
  end;
  glDisable(GL_LINE_STIPPLE);
end;

end.
