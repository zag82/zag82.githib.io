unit uni_mesh;

interface

uses cm_ini, cmData, cmVars;

Const
  MaxTriangles=50;

Type
  TUniMesh=class
  private
    no:int;
    oo:array of float;
    /// Delanau Treangulation
    function InCircle(xp, yp, x1, y1, x2, y2, x3, y3, xc, yc,r: Double): Boolean;
    function WhichSide(xp, yp, x1, y1, x2, y2: Double): Integer;
    function Triangulate(nvert: Integer): Integer;
    /// Point Distribution
    procedure SetPoints;
  public
    nPts:int;
    nEls:int;
    crX:array of float;
    crY:array of float;
    Top:array {[0..MaxTriangles]} of TTriangle;
    procedure LoadData(s:string);
    procedure FreeData;
    procedure GenerateUniMesh;
  end;

Var
  um:TUniMesh;
  umEnable:boolean=false;

implementation

var
  Complete : array of Boolean;
  Edges: array[0..2]of array{,0..MaxTriangles * 3]} of LongInt;

function TUniMesh.InCircle(xp, yp, x1, y1, x2, y2, x3, y3, xc, yc,r: Double): Boolean;
//Return TRUE if the point (xp,yp) lies inside the circumcircle
//made up by points (x1,y1) (x2,y2) (x3,y3)
//The circumcircle centre is returned in (xc,yc) and the radius r
//NOTE: A point on the edge is inside the circumcircle
var
  eps: Double;
  m1: Double;
  m2: Double;
  mx1: Double;
  mx2: Double;
  my1: Double;
  my2: Double;
  dx: Double;
  dy: Double;
  rsqr: Double;
  drsqr: Double;
begin
  eps:= 1e-10;
  Result:=false;
  if (Abs(y1-y2)<eps) and (Abs(y2-y3)<eps) then
  begin
    Exit;
  end;
  if Abs(y2-y1)<eps then
  begin
    m2 := -(x3 - x2) / (y3 - y2);
    mx2 := (x2 + x3) / 2;
    my2 := (y2 + y3) / 2;
    xc := (x2 + x1) / 2;
    yc := m2 * (xc - mx2) + my2;
  end
  else if Abs(y3 - y2) < eps then
  begin
    m1 := -(x2 - x1) / (y2 - y1);
    mx1 := (x1 + x2) / 2;
    my1 := (y1 + y2) / 2;
    xc := (x3 + x2) / 2;
    yc := m1 * (xc - mx1) + my1;
  end
  else
  begin
    m1 := -(x2 - x1) / (y2 - y1);
    m2 := -(x3 - x2) / (y3 - y2);
    mx1 := (x1 + x2) / 2;
    mx2 := (x2 + x3) / 2;
    my1 := (y1 + y2) / 2;
    my2 := (y2 + y3) / 2;
    xc := (m1 * mx1 - m2 * mx2 + my2 - my1) / (m1 - m2);
    yc := m1 * (xc - mx1) + my1;
  end;
  dx := x2 - xc;
  dy := y2 - yc;
  rsqr := dx * dx + dy * dy;
  r := Sqr(rsqr);
  dx := xp - xc;
  dy := yp - yc;
  drsqr := dx * dx + dy * dy;
  if drsqr <= rsqr then Result:=true;
end;

function TUniMesh.WhichSide(xp, yp, x1, y1, x2, y2: Double): Integer;
//Determines which side of a line the point (xp,yp) lies.
//The line goes from (x1,y1) to (x2,y2)
//Returns -1 for a point to the left
//         0 for a point on the line
//        +1 for a point to the right
var
  equation: Double;
begin
  equation := ((yp - y1) * (x2 - x1)) - ((y2 - y1) * (xp - x1));
  if equation > 0 then
     WhichSide := -1
  else if equation = 0 then
     WhichSide := 0
  else
     WhichSide := 1;
end;

function TUniMesh.Triangulate(nvert: Integer): Integer;
//Takes as input NVERT vertices in arrays Vertex()
//Returned is a list of NTRI triangular faces in the array
//Triangle(). These triangles are arranged in clockwise order.
var
  Nedge: LongInt;
  //For Super Triangle
  xmin: Double;
  xmax: Double;
  ymin: Double;
  ymax: Double;
  xmid: Double;
  ymid: Double;
  dx: Double;
  dy: Double;
  dmax: Double;
  //General Variables
  i : Integer;
  j : Integer;
  k : Integer;
  ntri : Integer;
  xc : Double;
  yc : Double;
  r : Double;
  inc : Boolean;
begin
  //Find the maximum and minimum vertex bounds.
  //This is to allow calculation of the bounding triangle
  xmin := Crx[1];
  ymin := crY[1];
  xmax := xmin;
  ymax := ymin;
  for i:=2 to nvert do
  begin
    if crX[i] < xmin then xmin := crX[i];
    if crX[i] > xmax then xmax := crX[i];
    if crY[i] < ymin then ymin := crY[i];
    if crY[i] > ymax then ymax := crY[i];
  end;
  dx := xmax - xmin;
  dy := ymax - ymin;
  if dx > dy then
    dmax := dx
  else
    dmax := dy;
  xmid := (xmax + xmin) / 2;
  ymid := (ymax + ymin) / 2;
  //Set up the supertriangle
  //This is a triangle which encompasses all the sample points.
  //The supertriangle coordinates are added to the end of the
  //vertex list. The supertriangle is the first triangle in
  //the triangle list.
  crX[nvert+1]:=(xmid - 2 * dmax);
  crY[nvert+1]:=(ymid - dmax);
  crX[nvert+2]:=xmid;
  crY[nvert+2]:=(ymid + 2 * dmax);
  crX[nvert+3]:=(xmid + 2 * dmax);
  crY[nvert+3]:=(ymid - dmax);
  ntri:=1;
  ///
  SetLength(Top,ntri+1);
  SetLength(Complete,ntri+1);
  SetLength(Edges[1],3*ntri+1);
  SetLength(Edges[2],3*ntri+1);
  ///
  Top[1][1]:=nvert+1;
  Top[1][2]:=nvert+2;
  Top[1][3]:=nvert+3;
  Complete[1]:=false;
  //Include each point one at a time into the existing mesh
  for i := 1 to nvert do
  begin
    nedge := 0;
    //Set up the edge buffer.
    //If the point (Vertex(i).x,Vertex(i).y) lies inside the circumcircle then the
    //three edges of that triangle are added to the edge buffer.
    j:=0;
    repeat
      j:=j+1;
      if not Complete[j] then
      begin
        inc:=InCircle(crX[i],
                      crY[i],
                      crX[Top[j][1]], crY[Top[j][1]],
                      crX[Top[j][2]], crY[Top[j][2]],
                      crX[Top[j][3]], crY[Top[j][3]],
                      xc, yc, r);
        //Include this if points are sorted by X
        //If (xc + r) < crX[i] Then
        //   complete[j] := True
        //Else
        if inc then
        begin
          Edges[1, Nedge + 1] := Top[j][1];
          Edges[2, Nedge + 1] := Top[j][2];
          Edges[1, Nedge + 2] := Top[j][2];
          Edges[2, Nedge + 2] := Top[j][3];
          Edges[1, Nedge + 3] := Top[j][3];
          Edges[2, Nedge + 3] := Top[j][1];
          Nedge := Nedge + 3;
          Top[j][1]:=Top[ntri][1];
          Top[j][2]:=Top[ntri][2];
          Top[j][3]:=Top[ntri][3];
          Complete[j] := Complete[ntri];
          j:=j-1;
          ntri:=ntri-1;
        end;
      end;
    until j>=ntri;
    // Tag multiple edges
    // Note: if all triangles are specified anticlockwise then all
    // interior edges are opposite pointing in direction.
    for j:=1 to Nedge-1 do
    begin
      if not(Edges[1,j]=0) and not(Edges[2,j]=0) then
      begin
        for k:=j+1 to Nedge do
        begin
          if not(Edges[1,k]=0) and not(Edges[2,k]=0) then
          begin
            if Edges[1,j]=Edges[2,k] then
            begin
              if Edges[2,j]=Edges[1,k] then
              begin
                Edges[1,j]:=0;
                Edges[2,j]:=0;
                Edges[1,k]:=0;
                Edges[2,k]:=0;
              end;
            end;
          end;
        end;
      end;
    end;
    //  Form new triangles for the current point
    //  Skipping over any tagged edges.
    //  All edges are arranged in clockwise order.
    for j:=1 to Nedge do
    begin
      if not(Edges[1,j]=0) and not(Edges[2,j]=0) then
      begin
        ntri:=ntri+1;
        ///
        SetLength(Top,ntri+1);
        SetLength(Complete,ntri+1);
        SetLength(Edges[1],3*ntri+1);
        SetLength(Edges[2],3*ntri+1);
        ///
        Top[ntri][1]:=Edges[1,j];
        Top[ntri][2]:=Edges[2,j];
        Top[ntri][3]:=i;
        Complete[ntri]:=false;
      end;
    end;
  end;
  //Remove triangles with supertriangle vertices
  //These are triangles which have a vertex number greater than NVERT
  i:=0;
  repeat
    i:=i+1;
    if (Top[i][1]>nvert)or(Top[i][2]>nvert)or(Top[i][3]>nvert) then
    begin
      Top[i][1]:=Top[ntri][1];
      Top[i][2]:=Top[ntri][2];
      Top[i][3]:=Top[ntri][3];
      i:=i-1;
      ntri:=ntri-1;
    end;
  until i>=ntri;
  Triangulate:=ntri;
end;

////////////////////////////////////////////////////////////////////////////////
//                                Main Functions                              //
////////////////////////////////////////////////////////////////////////////////
procedure TUniMesh.LoadData(s:string);
var i:int;
    f:TextFile;
    vv:float;
    sum:float;
begin
  AssignFile(f,s);
  Reset(f);
  readln(f,no);
  readln(f);
  SetLength(oo,no);
  for i:=1 to no do
  begin
    readln(f,vv);
    oo[i-1]:=vv;
  end;
  CloseFile(f);
end;

procedure TUniMesh.FreeData;
var i,j:int;
begin
  nPts:=0;
  nEls:=0;
  crX:=nil;
  crY:=nil;
  Top:=nil;
  Complete:=nil;
  Edges[1]:=nil;
  Edges[2]:=nil;
{  for i:=1 to MaxTriangles do
  begin
    Top[i][1]:=0;
    Top[i][2]:=0;
    Top[i][3]:=0;
    Complete[i]:=false;
  end;
  for i:=0 to 2 do
    for j:=0 to MaxTriangles*3 do
      Edges[i,j]:=0;}
end;

procedure TUniMesh.GenerateUniMesh;
begin
  FreeData;
  SetPoints;
  nEls:=Triangulate(nPts);
end;

procedure TUniMesh.SetPoints;
var i,i1,o1,j,k:int;
    n,k_num:int;
    x,y:double;
    flag:boolean; // can place point
    x0,y0:array of double;
    ddx,ddy,dds:array of double;
    obi:array of int;
    mgo:TMgObject;
    sec:Tsector;
    tts:TTriSec;
    dx,dy,ds:double;

    function IsNearPoint(x,y:double; dx,dy:double):boolean;
    var i:integer;
        xx,yy:double;
        fl:boolean;
    begin
      fl:=false;
      for i:=1 to nPts do
      begin
        xx:=crx[i];
        yy:=cry[i];
        if (sqr(x-xx)/sqr(dx)+sqr(y-yy)/sqr(dy))<1 then
        begin
          fl:=true;
          break;
        end;
      end;
      Result:=fl;
    end;

    function max(a,b:integer):integer;
    begin
      if(a>b)then
        Result:=a
      else
        Result:=b;
    end;

    procedure LayOnBorder(x0,y0,x1,y1:double; stepX,stepY:double);
    var i:integer;
        num1,num2,num:integer;
        x,y:double;
        flag:boolean;
    begin
      num1:=Round(Abs(x1-x0)/stepX);
      num2:=Round(Abs(y1-y0)/stepY);
      num:=max(num1,num2);
      for i:=0 to num do
      begin
        flag:=true;
        x:=x0+(x1-x0)/num*i;
        y:=y0+(y1-y0)/num*i;
        if IsNearPoint(x,y,stepX/4,stepY/4) then flag:=false;
        if flag then
        begin
          nPts:=nPts+1;
          SetLength(crx,nPts+1);
          SetLength(cry,nPts+1);
          crx[nPts]:=x;
          cry[nPts]:=y;
        end;
      end;
    end;

begin
  n:=round(sqrt(tt.NNodes));
  dx:=(tt.bx-tt.ax)/n;
  dy:=(tt.bz-tt.az)/n;
  ds:=sqrt(sqr(dx)+sqr(dy));
  k_num:=4;
  SetLength(x0,k_num+1);
  SetLength(y0,k_num+1);
  x0[1]:=tt.ax;
  y0[1]:=tt.az;
  x0[2]:=tt.ax;
  y0[2]:=tt.bz;
  x0[3]:=tt.bx;
  y0[3]:=tt.bz;
  x0[4]:=tt.bx;
  y0[4]:=tt.az;
  LayOnBorder(x0[1],y0[1],x0[2],y0[2],0.876*dx,0.876*dy);
  LayOnBorder(x0[2],y0[2],x0[3],y0[3],0.876*dx,0.876*dy);
  LayOnBorder(x0[3],y0[3],x0[4],y0[4],0.876*dx,0.876*dy);
  LayOnBorder(x0[4],y0[4],x0[1],y0[1],0.876*dx,0.876*dy);
  SetLength(obi,k_num+1);
  SetLength(ddx,k_num+1);
  SetLength(ddy,k_num+1);
  SetLength(dds,k_num+1);
  for i:=1 to 4 do
  begin
    ddx[i]:=dx;
    ddy[i]:=dy;
    dds[i]:=ds;
    obi[i]:=-1;
  end;
  for i:=0 to ob.Count-1 do
  begin
    mgo:=TMgObject(ob.items[i]);
    if mgo is TSector then
    begin
      sec:=TSector(mgo);
      k_num:=k_num+4;
      SetLength(x0,k_num+1);
      SetLength(y0,k_num+1);
      x0[k_num-3]:=sec.xx+sec.r1;
      y0[k_num-3]:=sec.zz+sec.h;
      x0[k_num-2]:=sec.xx+sec.r1;
      y0[k_num-2]:=sec.zz;
      x0[k_num-1]:=sec.xx+sec.r2;
      y0[k_num-1]:=sec.zz;
      x0[k_num]:=sec.xx+sec.r2;
      y0[k_num]:=sec.zz+sec.h;
      SetLength(ddx,k_num+1);
      SetLength(ddy,k_num+1);
      SetLength(dds,k_num+1);
      SetLength(obi,k_num+1);
      for j:=1 to 4 do
      begin
        ddx[k_num-j+1]:=dx/oo[i+1];
        ddy[k_num-j+1]:=dy/oo[i+1];
        dds[k_num-j+1]:=ds/oo[i+1];
        obi[k_num-j+1]:=i;
      end;
      LayOnBorder(x0[k_num-3],y0[k_num-3],x0[k_num-2],y0[k_num-2],ddx[k_num],ddy[k_num]);
      LayOnBorder(x0[k_num-2],y0[k_num-2],x0[k_num-1],y0[k_num-1],ddx[k_num],ddy[k_num]);
      LayOnBorder(x0[k_num-1],y0[k_num-1],x0[k_num-0],y0[k_num-0],ddx[k_num],ddy[k_num]);
      LayOnBorder(x0[k_num-0],y0[k_num-0],x0[k_num-3],y0[k_num-3],ddx[k_num],ddy[k_num]);
    end
    else if mgo is TTriSec then
    begin
      tts:=TTriSec(mgo);
      k_num:=k_num+3;
      SetLength(x0,k_num+1);
      SetLength(y0,k_num+1);
      x0[k_num-2]:=tts.x1;
      y0[k_num-2]:=tts.z1;
      x0[k_num-1]:=tts.x2;
      y0[k_num-1]:=tts.z2;
      x0[k_num]:=tts.x3;
      y0[k_num]:=tts.z3;
      LayOnBorder(x0[k_num-2],y0[k_num-2],x0[k_num-1],y0[k_num-1],0.76*dx,0.76*dy);
      LayOnBorder(x0[k_num-1],y0[k_num-1],x0[k_num-0],y0[k_num-0],0.76*dx,0.76*dy);
      LayOnBorder(x0[k_num-0],y0[k_num-0],x0[k_num-2],y0[k_num-2],0.76*dx,0.76*dy);
    end;
  end;
  for i:=1 to 2*n do
  begin
    for k:=1 to k_num do
    for j:=1 to 12*i do
    begin
      x:=x0[k]+(i*dds[k]*cos(2*pi*j/(12*i)));
      y:=y0[k]+(i*dds[k]*sin(2*pi*j/(12*i)));
      flag:=true;
      if x<tt.ax then x:=tt.ax;
      if y<tt.az then y:=tt.az;
      if x>tt.bx then x:=tt.bx;
      if y>tt.bz then y:=tt.bz;
      o1:=-1;
      for i1:=0 to ob.Count-1 do
        if TMgObject(ob.Items[i1]).IsPointInside(x,1e-10,y) then
        begin
          o1:=i1
        end;
      if obi[k]<>o1 then
        if (i<=3) then
          flag:=true
        else
          flag:=false;
      if IsNearPoint(x,y,ddx[k],ddy[k]) then flag:=false;
      //  if (i<=3) then flag:=true;
      if flag then
      begin
        nPts:=nPts+1;
        SetLength(crx,nPts+1);
        SetLength(cry,nPts+1);
        crx[nPts]:=x;
        cry[nPts]:=y;
      end;
    end;
  end; 
  SetLength(crx,nPts+1+3);
  SetLength(cry,nPts+1+3);
  x0:=nil;
  y0:=nil;
  ddx:=nil;
  ddy:=nil;
  dds:=nil;
  obi:=nil;
end;

////////////////////////////////////////////////////////////////////////////////
//                                  END OF FILE                               //
////////////////////////////////////////////////////////////////////////////////

end.
