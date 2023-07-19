unit p3_data;

interface
uses cm_ini, opengl, controls,Windows, gl_ob, Graphics;

type
  TModuleScale=record
    FD_sc:float;
    In_sc:float;
    SP_sc:float;
    // steady state
    FD_re:float;
    In_re:float;
    VP_re:float;
    // eddy current
    FD_ec:float;
    In_ec:float;
    VP_ec:float;
    EC_ec:float;
    PV_ec:float;
    ED_ec:float;
  end;

  TVector=record
    x:float;
    y:float;
    z:float;
    r:float;
    ph:float;
    ml:float;
  end;

  TcxVector=record
    x:TComplex;
    y:TComplex;
    z:TComplex;
    r:TComplex;
    ph:TComplex;
    ml:TComplex;
  end;

  TFullScale=record
    FD_sc:TVector;
    In_sc:TVector;
    SP_sc:float;
    // steady state
    FD_re:TVector;
    In_re:TVector;
    VP_re:TVector;
    // eddy current
    FD_ec:TcxVector;
    In_ec:TcxVector;
    VP_ec:TcxVector;
    EC_ec:TcxVector;
    PV_ec:TcxVector;
    ED_ec:TcxVector;
  end;

var
  /////////////////////////
  gr_Num:int;
  grVal_X:array of float;
  grVal_Y:array of float;
  /////////////////////////
  pCanClose:boolean=false;
  // move and rotate
  angleX:GLfloat;
  angleY:GLfloat;
  angleZ:GLfloat;
  transX:GLfloat;
  transY:GLfloat;
  LastX:integer;
  LastY:integer;
  Down:boolean;
  btn:TMouseButton;
  // zoom and scale
  pr_zoom:float=1;
  pr_scale:float=1;
  // logical vars
  bMesh:boolean=false;
  bSolid:boolean=false;
  bBound:boolean=true;
  bObject:boolean=true;
  bAir:boolean=false;
  bLight:boolean=false;
  bValue:boolean=false;
  vDir1:int;
  vDir2:int;
  vDir3:int;
  // contols
  v_Plane:int;
  v_Visualisation:int;
  v_Value:int;
  v_Component:int;
  v_Part:int;

  v_Dir:byte;
  v_ProfDist:int;
  v_GrapDist:int;
  // results
  v_nx,v_ny,v_nz:int;
  nCubes:int;
  rm:TModuleScale;
  rma:TFullScale;
  rmi:TFullScale;

  crX,crY,crZ:array of float;
  crR,crFi:array of float;  // fi in radians

  FD_sc:array of TVector;
  In_sc:array of TVector;
  SP_sc:array of float;

  FD_re:array of TVector;
  In_re:array of TVector;
  VP_re:array of TVector;

  FD_ec:array of TcxVector;
  In_ec:array of TcxVector;
  VP_ec:array of TcxVector;
  EC_ec:array of TcxVector;
  PV_ec:array of TcxVector;
  ED_ec:array of TcxVector;

  bGraphReDraw:boolean;
  slNum:int;
  bslColor:boolean;
  slTri:array of array [1..4] of int;
  procedure createTri;

  function Num2Cube(ncx,ncy,ncz:int):int;

procedure InitData;
procedure GenerateRes3d;
procedure FreeRes3d;

function GetValue(i:int):float;
function GetVector(i:int; var v:TVector):boolean;
function GetVecScale:float;
procedure GetScalarScale(var m1,m2:float);

function LineColorR(a : float) : Int;
function LineColorG(a : float) : Int;
function LineColorB(a : float) : Int;
function RBColor(a : float) : Int;
function GRColor(a : float) : Int;

procedure FillGraphVal;

implementation

uses ComVars,cmVars, compute_vectorsunit, complx,SysUtils, Math, specmat;

function RainBowFunction(a,f,e1,e2,e3 : float) : Int;
var
  tmp1,tmp2 : float;
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

function LineColorR(a : float) : Int;
begin
  Result:=RainBowFunction(a,1,2.1,3,4)+Round(RainBowFunction(a,0.1,10,10,4)/2.5)
end;

function LineColorG(a : float) : Int;
begin
  Result:=RainBowFunction(a,0.6,2.5,2.8,3)
end;

function LineColorB(a : float) : Int;
begin
  Result:=RainBowFunction(a,0.3,3.5,4,3)
end;

function RBColor(a : float) : Int;
begin
  Result:=RGB(LineColorR(a),LineColorG(a),LineColorB(a))
end;

function GRColor(a : float) : Int;
begin
  Result:=RGB(Round(a*255),Round(a*255),Round(a*255));
end;

function GetVecScale:float;
begin
  Result:=0;
  Case Task of
    0..2:Case v_value of
           0:Result:=rm.FD_sc;
           1:Result:=rm.In_sc;
           2:Result:=rm.SP_sc;
         end;
    3:Case v_Value of
        0:Result:=rm.FD_re;
        1:Result:=rm.In_re;
        2:Result:=rm.VP_re;
      end;
    5:Case v_value of
        0:Result:=rm.FD_ec;
        1:Result:=rm.In_ec;
        2:Result:=rm.VP_ec;
        3:Result:=rm.EC_ec;
        4:Result:=rm.PV_ec;
        5:Result:=rm.ED_ec;
      end;
  end;
end;

procedure GetScalarScale(var m1,m2:float);
begin
  m1:=0;
  m2:=0;
  Case Task of
    0..2:Case v_value of
           0:Case v_Component of
               0:begin  m1:=rmi.FD_sc.ml; m2:=rma.FD_sc.ml; end;
               1:begin  m1:=rmi.FD_sc.x;  m2:=rma.FD_sc.x;  end;
               2:begin  m1:=rmi.FD_sc.y;  m2:=rma.FD_sc.y;  end;
               3:begin  m1:=rmi.FD_sc.z;  m2:=rma.FD_sc.z;  end;
               4:begin  m1:=rmi.FD_sc.r;  m2:=rma.FD_sc.r;  end;
               5:begin  m1:=rmi.FD_sc.ph; m2:=rma.FD_sc.ph; end;
               6:begin  m1:=rmi.FD_sc.z;  m2:=rma.FD_sc.z;  end;
             end;
           1:Case v_Component of
               0:begin  m1:=rmi.In_sc.ml; m2:=rma.In_sc.ml; end;
               1:begin  m1:=rmi.In_sc.x;  m2:=rma.In_sc.x;  end;
               2:begin  m1:=rmi.In_sc.y;  m2:=rma.In_sc.y;  end;
               3:begin  m1:=rmi.In_sc.z;  m2:=rma.In_sc.z;  end;
               4:begin  m1:=rmi.In_sc.r;  m2:=rma.In_sc.r;  end;
               5:begin  m1:=rmi.In_sc.ph; m2:=rma.In_sc.ph; end;
               6:begin  m1:=rmi.In_sc.z;  m2:=rma.In_sc.z;  end;
             end;
           2:begin  m1:=rmi.SP_sc; m2:=rma.SP_sc; end;
         end;
    3:Case v_value of
        0:Case v_Component of
            0:begin  m1:=rmi.FD_re.ml; m2:=rma.FD_re.ml; end;
            1:begin  m1:=rmi.FD_re.x;  m2:=rma.FD_re.x;  end;
            2:begin  m1:=rmi.FD_re.y;  m2:=rma.FD_re.y;  end;
            3:begin  m1:=rmi.FD_re.z;  m2:=rma.FD_re.z;  end;
            4:begin  m1:=rmi.FD_re.r;  m2:=rma.FD_re.r;  end;
            5:begin  m1:=rmi.FD_re.ph; m2:=rma.FD_re.ph; end;
            6:begin  m1:=rmi.FD_re.z;  m2:=rma.FD_re.z;  end;
          end;
        1:Case v_Component of
            0:begin  m1:=rmi.In_re.ml; m2:=rma.In_re.ml; end;
            1:begin  m1:=rmi.In_re.x;  m2:=rma.In_re.x;  end;
            2:begin  m1:=rmi.In_re.y;  m2:=rma.In_re.y;  end;
            3:begin  m1:=rmi.In_re.z;  m2:=rma.In_re.z;  end;
            4:begin  m1:=rmi.In_re.r;  m2:=rma.In_re.r;  end;
            5:begin  m1:=rmi.In_re.ph; m2:=rma.In_re.ph; end;
            6:begin  m1:=rmi.In_re.z;  m2:=rma.In_re.z;  end;
          end;
        2:Case v_Component of
            0:begin  m1:=rmi.VP_re.ml; m2:=rma.VP_re.ml; end;
            1:begin  m1:=rmi.VP_re.x;  m2:=rma.VP_re.x;  end;
            2:begin  m1:=rmi.VP_re.y;  m2:=rma.VP_re.y;  end;
            3:begin  m1:=rmi.VP_re.z;  m2:=rma.VP_re.z;  end;
            4:begin  m1:=rmi.VP_re.r;  m2:=rma.VP_re.r;  end;
            5:begin  m1:=rmi.VP_re.ph; m2:=rma.VP_re.ph; end;
            6:begin  m1:=rmi.VP_re.z;  m2:=rma.VP_re.z;  end;
          end;
      end;
    5:Case v_value of
        0:Case v_Component of
            0:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.ml); m2:=CAbs(rma.FD_ec.ml); end;
                1:begin  m1:=rmi.FD_ec.ml.Re; m2:=rma.FD_ec.ml.Re; end;
                2:begin  m1:=rmi.FD_ec.ml.Im; m2:=rma.FD_ec.ml.Im; end;
              end;
            1:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.x); m2:=CAbs(rma.FD_ec.x); end;
                1:begin  m1:=rmi.FD_ec.x.Re; m2:=rma.FD_ec.x.Re; end;
                2:begin  m1:=rmi.FD_ec.x.Im; m2:=rma.FD_ec.x.Im; end;
              end;
            2:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.y); m2:=CAbs(rma.FD_ec.y); end;
                1:begin  m1:=rmi.FD_ec.y.Re; m2:=rma.FD_ec.y.Re; end;
                2:begin  m1:=rmi.FD_ec.y.Im; m2:=rma.FD_ec.y.Im; end;
              end;
            3:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.z); m2:=CAbs(rma.FD_ec.z); end;
                1:begin  m1:=rmi.FD_ec.z.Re; m2:=rma.FD_ec.z.Re; end;
                2:begin  m1:=rmi.FD_ec.z.Im; m2:=rma.FD_ec.z.Im; end;
              end;
            4:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.r); m2:=CAbs(rma.FD_ec.r); end;
                1:begin  m1:=rmi.FD_ec.r.Re; m2:=rma.FD_ec.r.Re; end;
                2:begin  m1:=rmi.FD_ec.r.Im; m2:=rma.FD_ec.r.Im; end;
              end;
            5:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.ph); m2:=CAbs(rma.FD_ec.ph); end;
                1:begin  m1:=rmi.FD_ec.ph.Re; m2:=rma.FD_ec.ph.Re; end;
                2:begin  m1:=rmi.FD_ec.ph.Im; m2:=rma.FD_ec.ph.Im; end;
              end;
            6:case v_part of
                0:begin  m1:=CAbs(rmi.FD_ec.z); m2:=CAbs(rma.FD_ec.z); end;
                1:begin  m1:=rmi.FD_ec.z.Re; m2:=rma.FD_ec.z.Re; end;
                2:begin  m1:=rmi.FD_ec.z.Im; m2:=rma.FD_ec.z.Im; end;
              end;
          end;
        1:Case v_Component of
            0:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.ml); m2:=CAbs(rma.In_ec.ml); end;
                1:begin  m1:=rmi.In_ec.ml.Re; m2:=rma.In_ec.ml.Re; end;
                2:begin  m1:=rmi.In_ec.ml.Im; m2:=rma.In_ec.ml.Im; end;
              end;
            1:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.x); m2:=CAbs(rma.In_ec.x); end;
                1:begin  m1:=rmi.In_ec.x.Re; m2:=rma.In_ec.x.Re; end;
                2:begin  m1:=rmi.In_ec.x.Im; m2:=rma.In_ec.x.Im; end;
              end;
            2:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.y); m2:=CAbs(rma.In_ec.y); end;
                1:begin  m1:=rmi.In_ec.y.Re; m2:=rma.In_ec.y.Re; end;
                2:begin  m1:=rmi.In_ec.y.Im; m2:=rma.In_ec.y.Im; end;
              end;
            3:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.z); m2:=CAbs(rma.In_ec.z); end;
                1:begin  m1:=rmi.In_ec.z.Re; m2:=rma.In_ec.z.Re; end;
                2:begin  m1:=rmi.In_ec.z.Im; m2:=rma.In_ec.z.Im; end;
              end;
            4:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.r); m2:=CAbs(rma.In_ec.r); end;
                1:begin  m1:=rmi.In_ec.r.Re; m2:=rma.In_ec.r.Re; end;
                2:begin  m1:=rmi.In_ec.r.Im; m2:=rma.In_ec.r.Im; end;
              end;
            5:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.ph); m2:=CAbs(rma.In_ec.ph); end;
                1:begin  m1:=rmi.In_ec.ph.Re; m2:=rma.In_ec.ph.Re; end;
                2:begin  m1:=rmi.In_ec.ph.Im; m2:=rma.In_ec.ph.Im; end;
              end;
            6:case v_part of
                0:begin  m1:=CAbs(rmi.In_ec.z); m2:=CAbs(rma.In_ec.z); end;
                1:begin  m1:=rmi.In_ec.z.Re; m2:=rma.In_ec.z.Re; end;
                2:begin  m1:=rmi.In_ec.z.Im; m2:=rma.In_ec.z.Im; end;
              end;
          end;
        2:Case v_Component of
            0:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.ml); m2:=CAbs(rma.VP_ec.ml); end;
                1:begin  m1:=rmi.VP_ec.ml.Re; m2:=rma.VP_ec.ml.Re; end;
                2:begin  m1:=rmi.VP_ec.ml.Im; m2:=rma.VP_ec.ml.Im; end;
              end;
            1:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.x); m2:=CAbs(rma.VP_ec.x); end;
                1:begin  m1:=rmi.VP_ec.x.Re; m2:=rma.VP_ec.x.Re; end;
                2:begin  m1:=rmi.VP_ec.x.Im; m2:=rma.VP_ec.x.Im; end;
              end;
            2:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.y); m2:=CAbs(rma.VP_ec.y); end;
                1:begin  m1:=rmi.VP_ec.y.Re; m2:=rma.VP_ec.y.Re; end;
                2:begin  m1:=rmi.VP_ec.y.Im; m2:=rma.VP_ec.y.Im; end;
              end;
            3:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.z); m2:=CAbs(rma.VP_ec.z); end;
                1:begin  m1:=rmi.VP_ec.z.Re; m2:=rma.VP_ec.z.Re; end;
                2:begin  m1:=rmi.VP_ec.z.Im; m2:=rma.VP_ec.z.Im; end;
              end;
            4:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.r); m2:=CAbs(rma.VP_ec.r); end;
                1:begin  m1:=rmi.VP_ec.r.Re; m2:=rma.VP_ec.r.Re; end;
                2:begin  m1:=rmi.VP_ec.r.Im; m2:=rma.VP_ec.r.Im; end;
              end;
            5:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.ph); m2:=CAbs(rma.VP_ec.ph); end;
                1:begin  m1:=rmi.VP_ec.ph.Re; m2:=rma.VP_ec.ph.Re; end;
                2:begin  m1:=rmi.VP_ec.ph.Im; m2:=rma.VP_ec.ph.Im; end;
              end;
            6:case v_part of
                0:begin  m1:=CAbs(rmi.VP_ec.z); m2:=CAbs(rma.VP_ec.z); end;
                1:begin  m1:=rmi.VP_ec.z.Re; m2:=rma.VP_ec.z.Re; end;
                2:begin  m1:=rmi.VP_ec.z.Im; m2:=rma.VP_ec.z.Im; end;
              end;
          end;
        3:Case v_Component of
            0:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.ml); m2:=CAbs(rma.EC_ec.ml); end;
                1:begin  m1:=rmi.EC_ec.ml.Re; m2:=rma.EC_ec.ml.Re; end;
                2:begin  m1:=rmi.EC_ec.ml.Im; m2:=rma.EC_ec.ml.Im; end;
              end;
            1:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.x); m2:=CAbs(rma.EC_ec.x); end;
                1:begin  m1:=rmi.EC_ec.x.Re; m2:=rma.EC_ec.x.Re; end;
                2:begin  m1:=rmi.EC_ec.x.Im; m2:=rma.EC_ec.x.Im; end;
              end;
            2:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.y); m2:=CAbs(rma.EC_ec.y); end;
                1:begin  m1:=rmi.EC_ec.y.Re; m2:=rma.EC_ec.y.Re; end;
                2:begin  m1:=rmi.EC_ec.y.Im; m2:=rma.EC_ec.y.Im; end;
              end;
            3:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.z); m2:=CAbs(rma.EC_ec.z); end;
                1:begin  m1:=rmi.EC_ec.z.Re; m2:=rma.EC_ec.z.Re; end;
                2:begin  m1:=rmi.EC_ec.z.Im; m2:=rma.EC_ec.z.Im; end;
              end;
            4:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.r); m2:=CAbs(rma.EC_ec.r); end;
                1:begin  m1:=rmi.EC_ec.r.Re; m2:=rma.EC_ec.r.Re; end;
                2:begin  m1:=rmi.EC_ec.r.Im; m2:=rma.EC_ec.r.Im; end;
              end;
            5:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.ph); m2:=CAbs(rma.EC_ec.ph); end;
                1:begin  m1:=rmi.EC_ec.ph.Re; m2:=rma.EC_ec.ph.Re; end;
                2:begin  m1:=rmi.EC_ec.ph.Im; m2:=rma.EC_ec.ph.Im; end;
              end;
            6:case v_part of
                0:begin  m1:=CAbs(rmi.EC_ec.z); m2:=CAbs(rma.EC_ec.z); end;
                1:begin  m1:=rmi.EC_ec.z.Re; m2:=rma.EC_ec.z.Re; end;
                2:begin  m1:=rmi.EC_ec.z.Im; m2:=rma.EC_ec.z.Im; end;
              end;
          end;
        4:Case v_Component of
            0:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.ml); m2:=CAbs(rma.PV_ec.ml); end;
                1:begin  m1:=rmi.PV_ec.ml.Re; m2:=rma.PV_ec.ml.Re; end;
                2:begin  m1:=rmi.PV_ec.ml.Im; m2:=rma.PV_ec.ml.Im; end;
              end;
            1:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.x); m2:=CAbs(rma.PV_ec.x); end;
                1:begin  m1:=rmi.PV_ec.x.Re; m2:=rma.PV_ec.x.Re; end;
                2:begin  m1:=rmi.PV_ec.x.Im; m2:=rma.PV_ec.x.Im; end;
              end;
            2:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.y); m2:=CAbs(rma.PV_ec.y); end;
                1:begin  m1:=rmi.PV_ec.y.Re; m2:=rma.PV_ec.y.Re; end;
                2:begin  m1:=rmi.PV_ec.y.Im; m2:=rma.PV_ec.y.Im; end;
              end;
            3:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.z); m2:=CAbs(rma.PV_ec.z); end;
                1:begin  m1:=rmi.PV_ec.z.Re; m2:=rma.PV_ec.z.Re; end;
                2:begin  m1:=rmi.PV_ec.z.Im; m2:=rma.PV_ec.z.Im; end;
              end;
            4:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.r); m2:=CAbs(rma.PV_ec.r); end;
                1:begin  m1:=rmi.PV_ec.r.Re; m2:=rma.PV_ec.r.Re; end;
                2:begin  m1:=rmi.PV_ec.r.Im; m2:=rma.PV_ec.r.Im; end;
              end;
            5:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.ph); m2:=CAbs(rma.PV_ec.ph); end;
                1:begin  m1:=rmi.PV_ec.ph.Re; m2:=rma.PV_ec.ph.Re; end;
                2:begin  m1:=rmi.PV_ec.ph.Im; m2:=rma.PV_ec.ph.Im; end;
              end;
            6:case v_part of
                0:begin  m1:=CAbs(rmi.PV_ec.z); m2:=CAbs(rma.PV_ec.z); end;
                1:begin  m1:=rmi.PV_ec.z.Re; m2:=rma.PV_ec.z.Re; end;
                2:begin  m1:=rmi.PV_ec.z.Im; m2:=rma.PV_ec.z.Im; end;
              end;
          end;
        5:Case v_Component of
            0:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.ml); m2:=CAbs(rma.ED_ec.ml); end;
                1:begin  m1:=rmi.ED_ec.ml.Re; m2:=rma.ED_ec.ml.Re; end;
                2:begin  m1:=rmi.ED_ec.ml.Im; m2:=rma.ED_ec.ml.Im; end;
              end;
            1:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.x); m2:=CAbs(rma.ED_ec.x); end;
                1:begin  m1:=rmi.ED_ec.x.Re; m2:=rma.ED_ec.x.Re; end;
                2:begin  m1:=rmi.ED_ec.x.Im; m2:=rma.ED_ec.x.Im; end;
              end;
            2:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.y); m2:=CAbs(rma.ED_ec.y); end;
                1:begin  m1:=rmi.ED_ec.y.Re; m2:=rma.ED_ec.y.Re; end;
                2:begin  m1:=rmi.ED_ec.y.Im; m2:=rma.ED_ec.y.Im; end;
              end;
            3:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.z); m2:=CAbs(rma.ED_ec.z); end;
                1:begin  m1:=rmi.ED_ec.z.Re; m2:=rma.ED_ec.z.Re; end;
                2:begin  m1:=rmi.ED_ec.z.Im; m2:=rma.ED_ec.z.Im; end;
              end;
            4:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.r); m2:=CAbs(rma.ED_ec.r); end;
                1:begin  m1:=rmi.ED_ec.r.Re; m2:=rma.ED_ec.r.Re; end;
                2:begin  m1:=rmi.ED_ec.r.Im; m2:=rma.ED_ec.r.Im; end;
              end;
            5:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.ph); m2:=CAbs(rma.ED_ec.ph); end;
                1:begin  m1:=rmi.ED_ec.ph.Re; m2:=rma.ED_ec.ph.Re; end;
                2:begin  m1:=rmi.ED_ec.ph.Im; m2:=rma.ED_ec.ph.Im; end;
              end;
            6:case v_part of
                0:begin  m1:=CAbs(rmi.ED_ec.z); m2:=CAbs(rma.ED_ec.z); end;
                1:begin  m1:=rmi.ED_ec.z.Re; m2:=rma.ED_ec.z.Re; end;
                2:begin  m1:=rmi.ED_ec.z.Im; m2:=rma.ED_ec.z.Im; end;
              end;
          end;
      end;
  end;
end;

function GetValue(i:int):float; // for profile
begin
  Result:=0;
  Case Task of
    0..2:Case v_Value of
           0:Case v_Component of
               0:Result:=FD_sc[i].ml;
               1:Result:=FD_sc[i].x;
               2:Result:=FD_sc[i].y;
               3:Result:=FD_sc[i].z;
               4:Result:=FD_sc[i].r;
               5:Result:=FD_sc[i].ph;
               6:Result:=FD_sc[i].z;
             end;
           1:Case v_Component of
               0:Result:=In_sc[i].ml;
               1:Result:=In_sc[i].x;
               2:Result:=In_sc[i].y;
               3:Result:=In_sc[i].z;
               4:Result:=In_sc[i].r;
               5:Result:=In_sc[i].ph;
               6:Result:=In_sc[i].z;
             end;
           2:Result:=SP_sc[i];
         end;
    3:Case v_Value of
        0:Case v_Component of
            0:Result:=FD_re[i].ml;
            1:Result:=FD_re[i].x;
            2:Result:=FD_re[i].y;
            3:Result:=FD_re[i].z;
            4:Result:=FD_re[i].r;
            5:Result:=FD_re[i].ph;
            6:Result:=FD_re[i].z;
          end;
        1:Case v_Component of
            0:Result:=In_re[i].ml;
            1:Result:=In_re[i].x;
            2:Result:=In_re[i].y;
            3:Result:=In_re[i].z;
            4:Result:=In_re[i].r;
            5:Result:=In_re[i].ph;
            6:Result:=In_re[i].z;
          end;
        2:Case v_Component of
            0:Result:=VP_re[i].ml;
            1:Result:=VP_re[i].x;
            2:Result:=VP_re[i].y;
            3:Result:=VP_re[i].z;
            4:Result:=VP_re[i].r;
            5:Result:=VP_re[i].ph;
            6:Result:=VP_re[i].z;
          end;
      end;
    5:Case v_Value of
        0:Case v_Component of
            0:Case v_Part of 0:Result:=CAbs(FD_ec[i].ml); 1:Result:=FD_ec[i].ml.Re; 2:Result:=FD_ec[i].ml.Im; end;
            1:Case v_Part of 0:Result:=CAbs(FD_ec[i].x);  1:Result:=FD_ec[i].x.Re;  2:Result:=FD_ec[i].x.Im;  end;
            2:Case v_Part of 0:Result:=CAbs(FD_ec[i].y);  1:Result:=FD_ec[i].y.Re;  2:Result:=FD_ec[i].y.Im;  end;
            3:Case v_Part of 0:Result:=CAbs(FD_ec[i].z);  1:Result:=FD_ec[i].z.Re;  2:Result:=FD_ec[i].z.Im;  end;
            4:Case v_Part of 0:Result:=CAbs(FD_ec[i].r);  1:Result:=FD_ec[i].r.Re;  2:Result:=FD_ec[i].r.Im;  end;
            5:Case v_Part of 0:Result:=CAbs(FD_ec[i].ph); 1:Result:=FD_ec[i].ph.Re; 2:Result:=FD_ec[i].ph.Im; end;
            6:Case v_Part of 0:Result:=CAbs(FD_ec[i].z);  1:Result:=FD_ec[i].z.Re;  2:Result:=FD_ec[i].z.Im;  end;
          end;
        1:Case v_Component of
            0:Case v_Part of 0:Result:=CAbs(In_ec[i].ml); 1:Result:=In_ec[i].ml.Re; 2:Result:=In_ec[i].ml.Im; end;
            1:Case v_Part of 0:Result:=CAbs(In_ec[i].x);  1:Result:=In_ec[i].x.Re;  2:Result:=In_ec[i].x.Im;  end;
            2:Case v_Part of 0:Result:=CAbs(In_ec[i].y);  1:Result:=In_ec[i].y.Re;  2:Result:=In_ec[i].y.Im;  end;
            3:Case v_Part of 0:Result:=CAbs(In_ec[i].z);  1:Result:=In_ec[i].z.Re;  2:Result:=In_ec[i].z.Im;  end;
            4:Case v_Part of 0:Result:=CAbs(In_ec[i].r);  1:Result:=In_ec[i].r.Re;  2:Result:=In_ec[i].r.Im;  end;
            5:Case v_Part of 0:Result:=CAbs(In_ec[i].ph); 1:Result:=In_ec[i].ph.Re; 2:Result:=In_ec[i].ph.Im; end;
            6:Case v_Part of 0:Result:=CAbs(In_ec[i].z);  1:Result:=In_ec[i].z.Re;  2:Result:=In_ec[i].z.Im;  end;
          end;
        2:Case v_Component of
            0:Case v_Part of 0:Result:=CAbs(VP_ec[i].ml); 1:Result:=VP_ec[i].ml.Re; 2:Result:=VP_ec[i].ml.Im; end;
            1:Case v_Part of 0:Result:=CAbs(VP_ec[i].x);  1:Result:=VP_ec[i].x.Re;  2:Result:=VP_ec[i].x.Im;  end;
            2:Case v_Part of 0:Result:=CAbs(VP_ec[i].y);  1:Result:=VP_ec[i].y.Re;  2:Result:=VP_ec[i].y.Im;  end;
            3:Case v_Part of 0:Result:=CAbs(VP_ec[i].z);  1:Result:=VP_ec[i].z.Re;  2:Result:=VP_ec[i].z.Im;  end;
            4:Case v_Part of 0:Result:=CAbs(VP_ec[i].r);  1:Result:=VP_ec[i].r.Re;  2:Result:=VP_ec[i].r.Im;  end;
            5:Case v_Part of 0:Result:=CAbs(VP_ec[i].ph); 1:Result:=VP_ec[i].ph.Re; 2:Result:=VP_ec[i].ph.Im; end;
            6:Case v_Part of 0:Result:=CAbs(VP_ec[i].z);  1:Result:=VP_ec[i].z.Re;  2:Result:=VP_ec[i].z.Im;  end;
          end;
        3:Case v_Component of
            0:Case v_Part of 0:Result:=CAbs(EC_ec[i].ml); 1:Result:=EC_ec[i].ml.Re; 2:Result:=EC_ec[i].ml.Im; end;
            1:Case v_Part of 0:Result:=CAbs(EC_ec[i].x);  1:Result:=EC_ec[i].x.Re;  2:Result:=EC_ec[i].x.Im;  end;
            2:Case v_Part of 0:Result:=CAbs(EC_ec[i].y);  1:Result:=EC_ec[i].y.Re;  2:Result:=EC_ec[i].y.Im;  end;
            3:Case v_Part of 0:Result:=CAbs(EC_ec[i].z);  1:Result:=EC_ec[i].z.Re;  2:Result:=EC_ec[i].z.Im;  end;
            4:Case v_Part of 0:Result:=CAbs(EC_ec[i].r);  1:Result:=EC_ec[i].r.Re;  2:Result:=EC_ec[i].r.Im;  end;
            5:Case v_Part of 0:Result:=CAbs(EC_ec[i].ph); 1:Result:=EC_ec[i].ph.Re; 2:Result:=EC_ec[i].ph.Im; end;
            6:Case v_Part of 0:Result:=CAbs(EC_ec[i].z);  1:Result:=EC_ec[i].z.Re;  2:Result:=EC_ec[i].z.Im;  end;
          end;
        4:Case v_Component of
            0:Case v_Part of 0:Result:=CAbs(PV_ec[i].ml); 1:Result:=PV_ec[i].ml.Re; 2:Result:=PV_ec[i].ml.Im; end;
            1:Case v_Part of 0:Result:=CAbs(PV_ec[i].x);  1:Result:=PV_ec[i].x.Re;  2:Result:=PV_ec[i].x.Im;  end;
            2:Case v_Part of 0:Result:=CAbs(PV_ec[i].y);  1:Result:=PV_ec[i].y.Re;  2:Result:=PV_ec[i].y.Im;  end;
            3:Case v_Part of 0:Result:=CAbs(PV_ec[i].z);  1:Result:=PV_ec[i].z.Re;  2:Result:=PV_ec[i].z.Im;  end;
            4:Case v_Part of 0:Result:=CAbs(PV_ec[i].r);  1:Result:=PV_ec[i].r.Re;  2:Result:=PV_ec[i].r.Im;  end;
            5:Case v_Part of 0:Result:=CAbs(PV_ec[i].ph); 1:Result:=PV_ec[i].ph.Re; 2:Result:=PV_ec[i].ph.Im; end;
            6:Case v_Part of 0:Result:=CAbs(PV_ec[i].z);  1:Result:=PV_ec[i].z.Re;  2:Result:=PV_ec[i].z.Im;  end;
          end;
        5:Case v_Component of
            0:Case v_Part of 0:Result:=CAbs(ED_ec[i].ml); 1:Result:=ED_ec[i].ml.Re; 2:Result:=ED_ec[i].ml.Im; end;
            1:Case v_Part of 0:Result:=CAbs(ED_ec[i].x);  1:Result:=ED_ec[i].x.Re;  2:Result:=ED_ec[i].x.Im;  end;
            2:Case v_Part of 0:Result:=CAbs(ED_ec[i].y);  1:Result:=ED_ec[i].y.Re;  2:Result:=ED_ec[i].y.Im;  end;
            3:Case v_Part of 0:Result:=CAbs(ED_ec[i].z);  1:Result:=ED_ec[i].z.Re;  2:Result:=ED_ec[i].z.Im;  end;
            4:Case v_Part of 0:Result:=CAbs(ED_ec[i].r);  1:Result:=ED_ec[i].r.Re;  2:Result:=ED_ec[i].r.Im;  end;
            5:Case v_Part of 0:Result:=CAbs(ED_ec[i].ph); 1:Result:=ED_ec[i].ph.Re; 2:Result:=ED_ec[i].ph.Im; end;
            6:Case v_Part of 0:Result:=CAbs(ED_ec[i].z);  1:Result:=ED_ec[i].z.Re;  2:Result:=ED_ec[i].z.Im;  end;
          end;
      end;
  end;
end;

function GetVector(i:int; var v:TVector):boolean; // for projection and map
begin
  Result:=true;
  Case Task of
    0..2:Case v_value of
           0:v:=FD_sc[i];
           1:v:=In_sc[i];
           2:begin Result:=false; v.x:=SP_sc[i]; end;
         end;
    3:Case v_Value of
        0:v:=FD_re[i];
        1:v:=In_re[i];
        2:v:=VP_re[i];
      end;
    5:Case v_value of
        0:Case v_Part of
            0:begin v.x:=CAbs(FD_ec[i].x); v.y:=CAbs(FD_ec[i].y); v.z:=CAbs(FD_ec[i].z); v.r:=CAbs(FD_ec[i].r); v.ph:=CAbs(FD_ec[i].ph); end;
            1:begin v.x:=FD_ec[i].x.Re; v.y:=FD_ec[i].y.Re; v.z:=FD_ec[i].z.Re; v.r:=FD_ec[i].r.Re; v.ph:=FD_ec[i].ph.Re; end;
            2:begin v.x:=FD_ec[i].x.Im; v.y:=FD_ec[i].y.Im; v.z:=FD_ec[i].z.Im; v.r:=FD_ec[i].r.Im; v.ph:=FD_ec[i].ph.Im; end;
          end;
        1:Case v_Part of
            0:begin v.x:=CAbs(In_ec[i].x); v.y:=CAbs(In_ec[i].y); v.z:=CAbs(In_ec[i].z); v.r:=CAbs(In_ec[i].r); v.ph:=CAbs(In_ec[i].ph); end;
            1:begin v.x:=In_ec[i].x.Re; v.y:=In_ec[i].y.Re; v.z:=In_ec[i].z.Re; v.r:=In_ec[i].r.Re; v.ph:=In_ec[i].ph.Re; end;
            2:begin v.x:=In_ec[i].x.Im; v.y:=In_ec[i].y.Im; v.z:=In_ec[i].z.Im; v.r:=In_ec[i].r.Im; v.ph:=In_ec[i].ph.Im; end;
          end;
        2:Case v_Part of
            0:begin v.x:=CAbs(VP_ec[i].x); v.y:=CAbs(VP_ec[i].y); v.z:=CAbs(VP_ec[i].z); v.r:=CAbs(VP_ec[i].r); v.ph:=CAbs(VP_ec[i].ph); end;
            1:begin v.x:=VP_ec[i].x.Re; v.y:=VP_ec[i].y.Re; v.z:=VP_ec[i].z.Re; v.r:=VP_ec[i].r.Re; v.ph:=VP_ec[i].ph.Re; end;
            2:begin v.x:=VP_ec[i].x.Im; v.y:=VP_ec[i].y.Im; v.z:=VP_ec[i].z.Im; v.r:=VP_ec[i].r.Im; v.ph:=VP_ec[i].ph.Im; end;
          end;
        3:Case v_Part of
            0:begin v.x:=CAbs(EC_ec[i].x); v.y:=CAbs(EC_ec[i].y); v.z:=CAbs(EC_ec[i].z); v.r:=CAbs(EC_ec[i].r); v.ph:=CAbs(EC_ec[i].ph); end;
            1:begin v.x:=EC_ec[i].x.Re; v.y:=EC_ec[i].y.Re; v.z:=EC_ec[i].z.Re; v.r:=EC_ec[i].r.Re; v.ph:=EC_ec[i].ph.Re; end;
            2:begin v.x:=EC_ec[i].x.Im; v.y:=EC_ec[i].y.Im; v.z:=EC_ec[i].z.Im; v.r:=EC_ec[i].r.Im; v.ph:=EC_ec[i].ph.Im; end;
          end;
        4:Case v_Part of
            0:begin v.x:=CAbs(PV_ec[i].x); v.y:=CAbs(PV_ec[i].y); v.z:=CAbs(PV_ec[i].z); v.r:=CAbs(PV_ec[i].r); v.ph:=CAbs(PV_ec[i].ph); end;
            1:begin v.x:=PV_ec[i].x.Re; v.y:=PV_ec[i].y.Re; v.z:=PV_ec[i].z.Re; v.r:=PV_ec[i].r.Re; v.ph:=PV_ec[i].ph.Re; end;
            2:begin v.x:=PV_ec[i].x.Im; v.y:=PV_ec[i].y.Im; v.z:=PV_ec[i].z.Im; v.r:=PV_ec[i].r.Im; v.ph:=PV_ec[i].ph.Im; end;
          end;
        5:Case v_Part of
            0:begin v.x:=CAbs(ED_ec[i].x); v.y:=CAbs(ED_ec[i].y); v.z:=CAbs(ED_ec[i].z); v.r:=CAbs(ED_ec[i].r); v.ph:=CAbs(ED_ec[i].ph); end;
            1:begin v.x:=ED_ec[i].x.Re; v.y:=ED_ec[i].y.Re; v.z:=ED_ec[i].z.Re; v.r:=ED_ec[i].r.Re; v.ph:=ED_ec[i].ph.Re; end;
            2:begin v.x:=ED_ec[i].x.Im; v.y:=ED_ec[i].y.Im; v.z:=ED_ec[i].z.Im; v.r:=ED_ec[i].r.Im; v.ph:=ED_ec[i].ph.Im; end;
          end;
      end;
  end;
end;

function Num2Cube(ncx,ncy,ncz:int):int;
begin
  Result:=(ncz-1)*v_nx*v_ny+(ncy-1)*v_nx+ncx
end;

procedure InitData;
begin
  v_nx:=axa.nnx-1;
  v_ny:=axa.nny-1;
  v_nz:=axa.nnz-1;
  nCubes := v_nx * v_ny * v_nz;
end;

// axial parameters and modules
procedure OtherParams(var v:TVector; x,y:float);
var
  si,co:float;
  mm:float;
begin
  v.ml:=sqrt(sqr(v.x)+sqr(v.y)+sqr(v.z));
  mm:=sqrt(sqr(x)+sqr(y));
  if mm<1e-20 then mm:=1;
  si:=y/mm;
  co:=x/mm;
  v.r:=v.x*co+v.y*si;
  v.ph:=-v.x*si+v.y*co;
end;

procedure OtherParams_cx(var v:TcxVector; x,y:float);
var
  si,co:float;
  mm:float;
begin
  v.ml:=CSqrt(CAdd(CADD(Csqr(v.x),Csqr(v.y)),Csqr(v.z)));
  mm:=sqrt(sqr(x)+sqr(y));
  if mm<1e-20 then mm:=1;
  si:=y/mm;
  co:=x/mm;
  v.r:=CAdd(CMul(v.x,CConv(co)),CMul(v.y,CConv(si)));
  v.ph:=CAdd(CMul(CNeg(v.x),CConv(si)),CMul(v.y,CConv(co)));
end;

/// Module extremums
function MaxModuleF(var a:array of float):float;// max scalar module
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nCubes do if Abs(a[i])>m then m:=Abs(a[i]);
  Result:=m;
end;

function MaxModule(var a:array of TVector):float;
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nCubes do if a[i].ml>m then m:=a[i].ml;
  Result:=m;
end;

function MaxModule_cx(var a:array of TcxVector):float;
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nCubes do if CAbs(a[i].ml)>m then m:=CAbs(a[i].ml);
  Result:=m;
end;

/////// min/max vector calculations
function MaxVector(var a:array of TVector):TVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nCubes do if a[i].x>m  then m:=a[i].x;  Result.x:=m;
  m:=0; for i:=1 to nCubes do if a[i].y>m  then m:=a[i].y;  Result.y:=m;
  m:=0; for i:=1 to nCubes do if a[i].z>m  then m:=a[i].z;  Result.z:=m;
  m:=0; for i:=1 to nCubes do if a[i].ml>m then m:=a[i].ml; Result.ml:=m;
  m:=0; for i:=1 to nCubes do if a[i].r>m  then m:=a[i].r;  Result.r:=m;
  m:=0; for i:=1 to nCubes do if a[i].ph>m then m:=a[i].ph; Result.ph:=m;
end;

function MinVector(var a:array of TVector):TVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nCubes do if a[i].x<m  then m:=a[i].x;  Result.x:=m;
  m:=0; for i:=1 to nCubes do if a[i].y<m  then m:=a[i].y;  Result.y:=m;
  m:=0; for i:=1 to nCubes do if a[i].z<m  then m:=a[i].z;  Result.z:=m;
  m:=0; for i:=1 to nCubes do if a[i].ml<m then m:=a[i].ml; Result.ml:=m;
  m:=0; for i:=1 to nCubes do if a[i].r<m  then m:=a[i].r;  Result.r:=m;
  m:=0; for i:=1 to nCubes do if a[i].ph<m then m:=a[i].ph; Result.ph:=m;
end;

function cMaxVector(var a:array of TcxVector):TcxVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nCubes do if a[i].x.Re>m  then m:=a[i].x.Re;  Result.x.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].x.Im>m  then m:=a[i].x.Im;  Result.x.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].y.Re>m  then m:=a[i].y.Re;  Result.y.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].y.Im>m  then m:=a[i].y.Im;  Result.y.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].z.Re>m  then m:=a[i].z.Re;  Result.z.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].z.Im>m  then m:=a[i].z.Im;  Result.z.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].ml.Re>m then m:=a[i].ml.Re; Result.ml.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].ml.Im>m then m:=a[i].ml.Im; Result.ml.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].r.Re>m  then m:=a[i].r.Re;  Result.r.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].r.Im>m  then m:=a[i].r.Im;  Result.r.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].ph.Re>m then m:=a[i].ph.Re; Result.ph.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].ph.Im>m then m:=a[i].ph.Im; Result.ph.Im:=m;
end;

function cMinVector(var a:array of TcxVector):TcxVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nCubes do if a[i].x.Re<m  then m:=a[i].x.Re;  Result.x.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].x.Im<m  then m:=a[i].x.Im;  Result.x.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].y.Re<m  then m:=a[i].y.Re;  Result.y.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].y.Im<m  then m:=a[i].y.Im;  Result.y.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].z.Re<m  then m:=a[i].z.Re;  Result.z.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].z.Im<m  then m:=a[i].z.Im;  Result.z.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].ml.Re<m then m:=a[i].ml.Re; Result.ml.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].ml.Im<m then m:=a[i].ml.Im; Result.ml.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].r.Re<m  then m:=a[i].r.Re;  Result.r.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].r.Im<m  then m:=a[i].r.Im;  Result.r.Im:=m;
  //
  m:=0; for i:=1 to nCubes do if a[i].ph.Re<m then m:=a[i].ph.Re; Result.ph.Re:=m;
  m:=0; for i:=1 to nCubes do if a[i].ph.Im<m then m:=a[i].ph.Im; Result.ph.Im:=m;
end;

function cMaxF(var a:array of float):float;
var i:int; m:float;
begin
  m:=0; for i:=1 to nCubes do if a[i]>m  then m:=a[i];  Result:=m;
end;

function cMinF(var a:array of float):float;
var i:int; m:float;
begin
  m:=0; for i:=1 to nCubes do if a[i]<m  then m:=a[i];  Result:=m;
end;

////////////////////////////////////////////////////////////////////////////////
//                  Main 3d Resultant Field generator                         //
////////////////////////////////////////////////////////////////////////////////
procedure GenerateRes3d;
var i,j:int;
    iElement:int;
    v:TVector;
    vx:TcxVector;
    xx,yy,zz:float;
begin
  SetLength(crX,nCubes+1);
  SetLength(crY,nCubes+1);
  SetLength(crZ,nCubes+1);
  SetLength(crR,nCubes+1);
  SetLength(crFi,nCubes+1);
  // scalar
  SetLength(FD_sc,nCubes+1);
  SetLength(In_sc,nCubes+1);
  SetLength(SP_sc,nCubes+1);
  // steady state
  SetLength(FD_re,nCubes+1);
  SetLength(In_re,nCubes+1);
  SetLength(VP_re,nCubes+1);
  // eddy curent
  SetLength(FD_ec,nCubes+1);
  SetLength(In_ec,nCubes+1);
  SetLength(VP_ec,nCubes+1);
  SetLength(EC_ec,nCubes+1);
  SetLength(PV_ec,nCubes+1);
  SetLength(ED_ec,nCubes+1);
  // filling data
  for i:=1 to nCubes do
  begin
    for j:=1 to tic do
    begin
      iElement:=tic*i-j+1;
      axa.GetCenter(iElement,xx,yy,zz);
      crX[i]:=crX[i]+xx;
      crY[i]:=crY[i]+yy;
      crZ[i]:=crZ[i]+zz;
      Case task of
        0..2:begin
            Compute_Vectors(iElement);
            FD_sc[i].x:=FD_sc[i].x+FluxDensity_X;
            FD_sc[i].y:=FD_sc[i].y+FluxDensity_Y;
            FD_sc[i].z:=FD_sc[i].z+FluxDensity_Z;
            In_sc[i].x:=In_sc[i].x+HIntensity_X;
            In_sc[i].y:=In_sc[i].y+HIntensity_Y;
            In_sc[i].z:=In_sc[i].z+HIntensity_Z;
            SP_sc[i]:=SP_sc[i]+avResult;
          end;
        3:begin
            Compute_RealVectors(iElement);
            FD_re[i].x:=FD_re[i].x+RSide_X;
            FD_re[i].y:=FD_re[i].y+RSide_Y;
            FD_re[i].z:=FD_re[i].z+RSide_Z;

//            FD_re[i].x:=FD_re[i].x+FluxDensity_X;
//            FD_re[i].y:=FD_re[i].y+FluxDensity_Y;
//            FD_re[i].z:=FD_re[i].z+FluxDensity_Z;

            In_re[i].x:=In_re[i].x+HIntensity_X;
            In_re[i].y:=In_re[i].y+HIntensity_Y;
            In_re[i].z:=In_re[i].z+HIntensity_Z;
            VP_re[i].x:=VP_re[i].x+avResult_X;
            VP_re[i].y:=VP_re[i].y+avResult_Y;
            VP_re[i].z:=VP_re[i].z+avResult_Z;
          end;
        5:begin
            Compute_ComplexVectors(iElement);
            FD_ec[i].x:=CAdd(FD_ec[i].x,cFluxDensity_X);
            FD_ec[i].y:=CAdd(FD_ec[i].y,cFluxDensity_Y);
            FD_ec[i].z:=CAdd(FD_ec[i].z,cFluxDensity_Z);
            In_ec[i].x:=CAdd(In_ec[i].x,cHIntensity_X);
            In_ec[i].y:=CAdd(In_ec[i].y,cHIntensity_Y);
            In_ec[i].z:=CAdd(In_ec[i].z,cHIntensity_Z);
            VP_ec[i].x:=CAdd(VP_ec[i].x,cavResult_X);
            VP_ec[i].y:=CAdd(VP_ec[i].y,cavResult_Y);
            VP_ec[i].z:=CAdd(VP_ec[i].z,cavResult_Z);
            ED_ec[i].x:=CAdd(ED_ec[i].x,cEIntensity_X);
            ED_ec[i].y:=CAdd(ED_ec[i].y,cEIntensity_Y);
            ED_ec[i].z:=CAdd(ED_ec[i].z,cEIntensity_Z);
            PV_ec[i].x:=Cadd(PV_ec[i].x,cPoynting_X);
            PV_ec[i].y:=Cadd(PV_ec[i].y,cPoynting_Y);
            PV_ec[i].z:=Cadd(PV_ec[i].z,cPoynting_Z);
            EC_ec[i].x:=CAdd(EC_ec[i].x,cEddyCurrent_X);
            EC_ec[i].y:=CAdd(EC_ec[i].y,cEddyCurrent_Y);
            EC_ec[i].z:=CAdd(EC_ec[i].z,cEddyCurrent_Z);
          end;
      end;
    end;
    crX[i]:=crX[i]/tic;
    crY[i]:=crY[i]/tic;
    crZ[i]:=crZ[i]/tic;
    crR[i]:=sqrt(sqr(crX[i])+sqr(crY[i]));
    crFi[i]:=ArcTng(crX[i],crY[i]);  // in radians
    Case task of
      0..2:begin
          FD_sc[i].x:=FD_sc[i].x/tic;
          FD_sc[i].y:=FD_sc[i].y/tic;
          FD_sc[i].z:=FD_sc[i].z/tic;
          In_sc[i].x:=In_sc[i].x/tic;
          In_sc[i].y:=In_sc[i].y/tic;
          In_sc[i].z:=In_sc[i].z/tic;
          SP_sc[i]:=SP_sc[i]/tic;
        end;
      3:begin
          FD_re[i].x:=FD_re[i].x/tic;
          FD_re[i].y:=FD_re[i].y/tic;
          FD_re[i].z:=FD_re[i].z/tic;
          In_re[i].x:=In_re[i].x/tic;
          In_re[i].y:=In_re[i].y/tic;
          In_re[i].z:=In_re[i].z/tic;
          VP_re[i].x:=VP_re[i].x/tic;
          VP_re[i].y:=VP_re[i].y/tic;
          VP_re[i].z:=VP_re[i].z/tic;
        end;
      5:begin
          FD_ec[i].x:=CDiv(FD_ec[i].x,CConv(tic));
          FD_ec[i].y:=CDiv(FD_ec[i].y,CConv(tic));
          FD_ec[i].z:=CDiv(FD_ec[i].z,CConv(tic));
          In_ec[i].x:=CDiv(In_ec[i].x,CConv(tic));
          In_ec[i].y:=CDiv(In_ec[i].y,CConv(tic));
          In_ec[i].z:=CDiv(In_ec[i].z,CConv(tic));
          VP_ec[i].x:=CDiv(VP_ec[i].x,CConv(tic));
          VP_ec[i].y:=CDiv(VP_ec[i].y,CConv(tic));
          VP_ec[i].z:=CDiv(VP_ec[i].z,CConv(tic));
          ED_ec[i].x:=CDiv(ED_ec[i].x,CConv(tic));
          ED_ec[i].y:=CDiv(ED_ec[i].y,CConv(tic));
          ED_ec[i].z:=CDiv(ED_ec[i].z,CConv(tic));
          PV_ec[i].x:=CDiv(PV_ec[i].x,CConv(tic));
          PV_ec[i].y:=CDiv(PV_ec[i].y,CConv(tic));
          PV_ec[i].z:=CDiv(PV_ec[i].z,CConv(tic));
          EC_ec[i].x:=CDiv(EC_ec[i].x,CConv(tic));
          EC_ec[i].y:=CDiv(EC_ec[i].y,CConv(tic));
          EC_ec[i].z:=CDiv(EC_ec[i].z,CConv(tic));
        end;
    end;
  end;
  for i:=1 to nCubes do
    if task<5 then
    begin
      v:=FD_sc[i]; OtherParams(v,crX[i],crY[i]); FD_sc[i]:=v;
      v:=In_sc[i]; OtherParams(v,crX[i],crY[i]); In_sc[i]:=v;
      v:=FD_re[i]; OtherParams(v,crX[i],crY[i]); FD_re[i]:=v;
      v:=In_re[i]; OtherParams(v,crX[i],crY[i]); In_re[i]:=v;
      v:=VP_re[i]; OtherParams(v,crX[i],crY[i]); VP_re[i]:=v;
    end
    else
    begin
      vx:=FD_ec[i]; OtherParams_cx(vx,crX[i],crY[i]); FD_ec[i]:=vx;
      vx:=In_ec[i]; OtherParams_cx(vx,crX[i],crY[i]); In_ec[i]:=vx;
      vx:=VP_ec[i]; OtherParams_cx(vx,crX[i],crY[i]); VP_ec[i]:=vx;
      vx:=EC_ec[i]; OtherParams_cx(vx,crX[i],crY[i]); EC_ec[i]:=vx;
      vx:=PV_ec[i]; OtherParams_cx(vx,crX[i],crY[i]); PV_ec[i]:=vx;
      vx:=ED_ec[i]; OtherParams_cx(vx,crX[i],crY[i]); ED_ec[i]:=vx;
    end;
  // module scale
  rm.FD_sc:=MaxModule(FD_sc);
  rm.In_sc:=MaxModule(In_sc);
  rm.SP_sc:=MaxModuleF(SP_sc);
  rm.FD_re:=MaxModule(FD_re);
  rm.In_re:=MaxModule(In_re);
  rm.VP_re:=MaxModule(VP_re);
  rm.FD_ec:=MaxModule_cx(FD_ec);
  rm.In_ec:=MaxModule_cx(In_ec);
  rm.VP_ec:=MaxModule_cx(VP_ec);
  rm.EC_ec:=MaxModule_cx(EC_ec);
  rm.PV_ec:=MaxModule_cx(PV_ec);
  rm.ED_ec:=MaxModule_cx(ED_ec);
  // maximal scale
  rma.FD_sc:=MaxVector(FD_sc);
  rma.In_sc:=MaxVector(In_sc);
  rma.SP_sc:=cMaxF(SP_sc);
  rma.FD_re:=MaxVector(FD_re);
  rma.In_re:=MaxVector(In_re);
  rma.VP_re:=MaxVector(VP_re);
  rma.FD_ec:=cMaxVector(FD_ec);
  rma.In_ec:=cMaxVector(In_ec);
  rma.VP_ec:=cMaxVector(VP_ec);
  rma.EC_ec:=cMaxVector(EC_ec);
  rma.PV_ec:=cMaxVector(PV_ec);
  rma.ED_ec:=cMaxVector(ED_ec);
  // minimal scale
  rmi.FD_sc:=MinVector(FD_sc);
  rmi.In_sc:=MinVector(In_sc);
  rmi.SP_sc:=cMinF(SP_sc);
  rmi.FD_re:=MinVector(FD_re);
  rmi.In_re:=MinVector(In_re);
  rmi.VP_re:=MinVector(VP_re);
  rmi.FD_ec:=cMinVector(FD_ec);
  rmi.In_ec:=cMinVector(In_ec);
  rmi.VP_ec:=cMinVector(VP_ec);
  rmi.EC_ec:=cMinVector(EC_ec);
  rmi.PV_ec:=cMinVector(PV_ec);
  rmi.ED_ec:=cMinVector(ED_ec);
end;

procedure FreeRes3d;
begin
  crX:=nil;
  crY:=nil;
  crZ:=nil;
  crR:=nil;
  crFi:=nil;
  // scalar
  FD_sc:=nil;
  In_sc:=nil;
  SP_sc:=nil;
  // steady state
  FD_re:=nil;
  In_re:=nil;
  VP_re:=nil;
  // eddy curent
  FD_ec:=nil;
  In_ec:=nil;
  VP_ec:=nil;
  EC_ec:=nil;
  PV_ec:=nil;
  ED_ec:=nil;
  ///////////
  grVal_X:=nil;
  grVal_Y:=nil;
  slTri:=nil;
end;

procedure FillGraphVal;
var i,k:int;
    a,x:float;
begin
  Case v_Dir of
    0:gr_Num:=v_nx;
    1:gr_Num:=v_ny;
    2:gr_Num:=v_nz;
  end;
  SetLength(grVal_X,gr_Num+1);
  SetLength(grVal_Y,gr_Num+1);
  for i:=1 to gr_Num do
  begin
    Case v_dir of
      0:begin if v_Plane=1 then k:=Num2Cube(i,v_ProfDist,v_GrapDist) else k:=Num2Cube(i,v_GrapDist,v_ProfDist); x:=crX[k]; end;
      1:begin if v_Plane=0 then k:=Num2Cube(v_ProfDist,i,v_GrapDist) else k:=Num2Cube(v_GrapDist,i,v_ProfDist); x:=crY[k]; end;
      2:begin if v_Plane=0 then k:=Num2Cube(v_ProfDist,v_GrapDist,i) else k:=Num2Cube(v_GrapDist,v_ProfDist,i); x:=crZ[k]; end;
    end;
    a:=GetValue(k);
    grVal_X[i]:=x;
    grVal_Y[i]:=a;
  end;
end;

function Get_LineF(a:float; j:int;var x1,y1,x2,y2:float; id:int):boolean;
var f:boolean;
    i:int;
    a1,a2:float;
    v1,v2,w1,w2:float;
begin
  f:=false;
  Result:=false;
  for i:=1 to 3 do
  begin
    a1:=GetValue(slTri[j][i]);
    a2:=GetValue(slTri[j][i+1]);
    Case id of
      1:begin
          v1:=crX[slTri[j][i]];
          v2:=crX[slTri[j][i+1]];
          w1:=crY[slTri[j][i]];
          w2:=crY[slTri[j][i+1]];
        end;
      2:begin
          v1:=crX[slTri[j][i]];
          v2:=crX[slTri[j][i+1]];
          w1:=crZ[slTri[j][i]];
          w2:=crZ[slTri[j][i+1]];
        end;
      3:begin
          v1:=crY[slTri[j][i]];
          v2:=crY[slTri[j][i+1]];
          w1:=crZ[slTri[j][i]];
          w2:=crZ[slTri[j][i+1]];
        end;
      4:begin
          v1:=crX[slTri[j][i]];
          v2:=crX[slTri[j][i+1]];
          w1:=crY[slTri[j][i]];
          w2:=crY[slTri[j][i+1]];
        end;
      5:begin
          v1:=crR[slTri[j][i]];
          v2:=crR[slTri[j][i+1]];
          w1:=crZ[slTri[j][i]];
          w2:=crZ[slTri[j][i+1]];
        end;
      6:begin
          v1:=crFi[slTri[j][i]];
          v2:=crFi[slTri[j][i+1]];
          w1:=crZ[slTri[j][i]];
          w2:=crZ[slTri[j][i+1]];
        end;
    end;
    if not f then
    begin
      if (a1<a2)and(a1<=a)and(a<=a2)then
      begin
        x1:=v1+(a-a1)*(v2-v1)/(a2-a1);
        y1:=w1+(a-a1)*(w2-w1)/(a2-a1);
        f:=true;
      end;
      if (a2<a1)and(a2<=a)and(a<=a1)then
      begin
        x1:=v1+(a-a1)*(v2-v1)/(a2-a1);
        y1:=w1+(a-a1)*(w2-w1)/(a2-a1);
        f:=true;
      end;
    end
    else
    begin
      if (a1<a2)and(a1<=a)and(a<=a2)then
      begin
        x2:=v1+(a-a1)*(v2-v1)/(a2-a1);
        y2:=w1+(a-a1)*(w2-w1)/(a2-a1);
        Result:=true;
      end;
      if (a2<a1)and(a2<=a)and(a<=a1)then
      begin
        x2:=v1+(a-a1)*(v2-v1)/(a2-a1);
        y2:=w1+(a-a1)*(w2-w1)/(a2-a1);
        Result:=true;
      end;
    end;
  end;
end;

procedure createTri;
var n1,n2:int;
    i,j:int;
    k,nn:int;
    x1,x2,y1,y2,zz:float;
    a,a_min,a_max:float;
    cl:TColor;
    r,g,b:float;
    ii:int;
    tmp:float;
begin
  GetScalarScale(a_min,a_max);
  DrawPlane;
  case v_Plane of
    0:begin n1:=v_ny; n2:=v_nz; end;
    1:begin n1:=v_nx; n2:=v_nz; end;
    2:begin n1:=v_nx; n2:=v_ny; end;
  end;
  nn:=2*(n1-1)*(n2-1);
  SetLength(slTri,1+nn);
  for i:=1 to n1-1 do
  for j:=1 to n2-1 do
  begin
    k:=j+(i-1)*(n2-1);
    Case v_plane of
      0:begin
          slTri[2*k-1][1]:=Num2Cube(v_ProfDist,i,j); slTri[2*k-1][2]:=Num2Cube(v_ProfDist,i+1,j); slTri[2*k-1][3]:=Num2Cube(v_ProfDist,i,j+1);slTri[2*k-1][4]:=Num2Cube(v_ProfDist,i,j);
          slTri[2*k][1]:=Num2Cube(v_ProfDist,i+1,j+1); slTri[2*k][2]:=Num2Cube(v_ProfDist,i+1,j); slTri[2*k][3]:=Num2Cube(v_ProfDist,i,j+1); slTri[2*k][4]:=Num2Cube(v_ProfDist,i+1,j+1);
        end;
      1:begin
          slTri[2*k-1][1]:=Num2Cube(i,v_ProfDist,j); slTri[2*k-1][2]:=Num2Cube(i+1,v_ProfDist,j); slTri[2*k-1][3]:=Num2Cube(i,v_ProfDist,j+1); slTri[2*k-1][4]:=Num2Cube(i,v_ProfDist,j);
          slTri[2*k][1]:=Num2Cube(i+1,v_ProfDist,j+1); slTri[2*k][2]:=Num2Cube(i+1,v_ProfDist,j); slTri[2*k][3]:=Num2Cube(i,v_ProfDist,j+1); slTri[2*k][4]:=Num2Cube(i+1,v_ProfDist,j+1);
        end;
      2:begin
          slTri[2*k-1][1]:=Num2Cube(i,j,v_ProfDist); slTri[2*k-1][2]:=Num2Cube(i+1,j,v_ProfDist); slTri[2*k-1][3]:=Num2Cube(i,j+1,v_ProfDist); slTri[2*k-1][4]:=Num2Cube(i,j,v_ProfDist);
          slTri[2*k][1]:=Num2Cube(i+1,j+1,v_ProfDist); slTri[2*k][2]:=Num2Cube(i+1,j,v_ProfDist); slTri[2*k][3]:=Num2Cube(i,j+1,v_ProfDist); slTri[2*k][4]:=Num2Cube(i+1,j+1,v_ProfDist);
        end;
    end;
  end;
  if axa.mesh_s=1 then
    Case v_plane of
      0:begin k:=Num2Cube(v_ProfDist,1,1); zz:=crX[k]; end;
      1:begin k:=Num2Cube(1,v_ProfDist,1); zz:=crY[k]; end;
      2:begin k:=Num2Cube(1,1,v_ProfDist); zz:=crZ[k]; end;
    end
  else
    Case v_plane of
      0:begin k:=Num2Cube(v_ProfDist,1,1); zz:=crR[k]; end;
      1:begin k:=Num2Cube(1,v_ProfDist,1); zz:=crFi[k]; end;
      2:begin k:=Num2Cube(1,1,v_ProfDist); zz:=crZ[k]; end;
    end;
  ii:=3-v_Plane;
  if axa.mesh_s<>1 then ii:=ii+3;
  for i:=1 to slNum do
  begin
    a:=a_min+i*(a_max-a_min)/(slNum+1);
    tmp:=(a_max-a_min); if tmp<1e-30 then tmp:=1;
    if bslColor then cl:=RBColor((a-a_min)/tmp) else cl:=GRColor((a-a_min)/tmp);
    cl2gl(cl,r,g,b);
    glColor3f(r,g,b);
    for j:=1 to nn do
    begin
      if not Get_LineF(a,j,x1,y1,x2,y2,ii) then continue;
      glBegin(GL_LINES);
      if axa.mesh_s=1 then
        Case v_plane of
          0:begin
              glVertex3f(glX(zz),glX(x1),glX(y1));
              glVertex3f(glX(zz),glX(x2),glX(y2));
            end;
          1:begin
              glVertex3f(glX(x1),glX(zz),glX(y1));
              glVertex3f(glX(x2),glX(zz),glX(y2));
            end;
          2:begin
              glVertex3f(glX(x1),glX(y1),glX(zz));
              glVertex3f(glX(x2),glX(y2),glX(zz));
            end;
        end
      else
        Case v_plane of
          0:begin
              glVertex3f(glX(zz*cos(x1)),glX(zz*sin(x1)),glX(y1));
              glVertex3f(glX(zz*cos(x2)),glX(zz*sin(x2)),glX(y2));
            end;
          1:begin
              glVertex3f(glX(x1*cos(zz)),glX(x1*sin(zz)),glX(y1));
              glVertex3f(glX(x2*cos(zz)),glX(x2*sin(zz)),glX(y2));
            end;
          2:begin
              glVertex3f(glX(x1),glX(y1),glX(zz));
              glVertex3f(glX(x2),glX(y2),glX(zz));
            end;
        end;
      glEnd;
    end;
  end;
end;

end.

