unit p2_data;

interface

uses
  cm_ini, common_main2d, cmVars, graphics, cmData, Windows;

type
  TModuleScale=record
    FD_sc:float;
    In_sc:float;
    SP_sc:float;
    mu_sc:float;
    // steady state
    FD_re:float;
    In_re:float;
    VP_re:float;
    mu_re:float;
    // eddy current
    FD_ec:float;
    In_ec:float;
    VP_ec:float;
  end;

  TVector=record
    x:float;
    z:float;
    ml:float;
  end;

  TcxVector=record
    x:TComplex;
    z:TComplex;
    ml:TComplex;
  end;

  TFullScale=record
    FD_sc:TVector;
    In_sc:TVector;
    SP_sc:float;
    mu_sc:float;
    // steady state
    FD_re:TVector;
    In_re:TVector;
    VP_re:float;
    mu_re:float;
    // eddy current
    FD_ec:TcxVector;
    In_ec:TcxVector;
    VP_ec:TComplex;
  end;

var
  //////////////////////
  slTri:array of array [1..4] of int;
  //////////////////////
  dd_fit:boolean;
  iR,iZ:int;
  /////////////////////////////
  // Resultant field parameters
  // results
  v_nr,v_nz:int;
  nQuads:int;
  rm:TModuleScale;
  rma:TFullScale;
  rmi:TFullScale;

  crR,crZ:array of float;

  FD_sc:array of TVector;
  In_sc:array of TVector;
  SP_sc:array of float;
  mu_sc:array of float;

  FD_re:array of TVector;
  In_re:array of TVector;
  VP_re:array of float;
  mu_re:array of float;

  FD_ec:array of TcxVector;
  In_ec:array of TcxVector;
  VP_ec:array of TComplex;
  /////////////////////////////
  pCanClose:boolean=false;
  ////////////////
  pp_zoom:float;
  pp_scale:float;
  bMesh:boolean=false;
  bObject:boolean=true;
  bBound:boolean=true;
  bAxis:boolean=true;
  bAir:boolean=false;
  bRuler:boolean=false;
  pp_transX:float=0.0;
  pp_transY:float=0.0;
  p_Visualization:int=0;
  p_Value:int=0;
  p_Objects:int=1;
  p_Component:int=0;
  p_Part:int=0;
  b_Gray:boolean=false;
  b_Black:boolean=false;
  v_Slices:int=10;

procedure createTri;
procedure createSmooth;

// transformation functions
function glR(r:float):float;
function glZ(z:float):float;
procedure cl2gl(cl:TColor; var r,g,b:float);
function LineColorR(a : float) : Int;
function LineColorG(a : float) : Int;
function LineColorB(a : float) : Int;
function RBColor(a : float) : Int;
function GRColor(a : float) : Int;

// result operations
procedure InitData2d;
procedure GenerateRes2d;
procedure FreeRes2d;

function GetValue(i:int):float;
function GetVector(i:int; var v:TVector):boolean;
function GetVecScale:float;
procedure GetScalarScale(var m1,m2:float);

implementation

uses ss_main2d, el_main2d, ec_main2d,complx, Math,SysUtils, comp_vec, OpenGL,
  ComVars;

function GetVecScale:float;
begin
  Result:=0;
  Case Task of
    0..2:Case p_value of
           0:Result:=rm.FD_sc;
           1:Result:=rm.In_sc;
           2:Result:=rm.SP_sc;
           3:Result:=rm.mu_sc;
         end;
    3:Case p_Value of
        0:Result:=rm.FD_re;
        1:Result:=rm.In_re;
        2:Result:=rm.VP_re;
        3:Result:=rm.mu_re;
      end;
    5:Case p_value of
        0:Result:=rm.FD_ec;
        1:Result:=rm.In_ec;
        2:Result:=rm.VP_ec;
      end;
  end;
end;

procedure GetScalarScale(var m1,m2:float);
begin
  m1:=0;
  m2:=0;
  Case Task of
    0..2:Case p_value of
           0:Case p_Component of
               0:begin  m1:=rmi.FD_sc.ml; m2:=rma.FD_sc.ml; end;
               1:begin  m1:=rmi.FD_sc.x;  m2:=rma.FD_sc.x;  end;
               2:begin  m1:=rmi.FD_sc.z;  m2:=rma.FD_sc.z;  end;
             end;
           1:Case p_Component of
               0:begin  m1:=rmi.In_sc.ml; m2:=rma.In_sc.ml; end;
               1:begin  m1:=rmi.In_sc.x;  m2:=rma.In_sc.x;  end;
               2:begin  m1:=rmi.In_sc.z;  m2:=rma.In_sc.z;  end;
             end;
           2:begin  m1:=rmi.SP_sc; m2:=rma.SP_sc; end;
           3:begin  m1:=rmi.mu_sc; m2:=rma.mu_sc; end;
         end;
    3:Case p_value of
        0:Case p_Component of
            0:begin  m1:=rmi.FD_re.ml; m2:=rma.FD_re.ml; end;
            1:begin  m1:=rmi.FD_re.x;  m2:=rma.FD_re.x;  end;
            2:begin  m1:=rmi.FD_re.z;  m2:=rma.FD_re.z;  end;
          end;
        1:Case p_Component of
            0:begin  m1:=rmi.In_re.ml; m2:=rma.In_re.ml; end;
            1:begin  m1:=rmi.In_re.x;  m2:=rma.In_re.x;  end;
            2:begin  m1:=rmi.In_re.z;  m2:=rma.In_re.z;  end;
          end;
        2:begin  m1:=rmi.VP_re; m2:=rma.VP_re; end;
        3:begin  m1:=rmi.mu_re; m2:=rma.mu_re; end;
      end;
    5:Case p_value of
        0:Case p_Component of
            0:case p_part of
                0:begin  m1:=CAbs(rmi.FD_ec.ml); m2:=CAbs(rma.FD_ec.ml); end;
                1:begin  m1:=rmi.FD_ec.ml.Re; m2:=rma.FD_ec.ml.Re; end;
                2:begin  m1:=rmi.FD_ec.ml.Im; m2:=rma.FD_ec.ml.Im; end;
              end;
            1:case p_part of
                0:begin  m1:=0{CAbs(rmi.FD_ec.x)}; m2:=CAbs(rma.FD_ec.x); end;
                1:begin  m1:=rmi.FD_ec.x.Re; m2:=rma.FD_ec.x.Re; end;
                2:begin  m1:=rmi.FD_ec.x.Im; m2:=rma.FD_ec.x.Im; end;
              end;
            2:case p_part of
                0:begin  m1:=0{CAbs(rmi.FD_ec.z)}; m2:=CAbs(rma.FD_ec.z); end;
                1:begin  m1:=rmi.FD_ec.z.Re; m2:=rma.FD_ec.z.Re; end;
                2:begin  m1:=rmi.FD_ec.z.Im; m2:=rma.FD_ec.z.Im; end;
              end;
          end;
        1:Case p_Component of
            0:case p_part of
                0:begin  m1:=0{CAbs(rmi.In_ec.ml)}; m2:=CAbs(rma.In_ec.ml); end;
                1:begin  m1:=rmi.In_ec.ml.Re; m2:=rma.In_ec.ml.Re; end;
                2:begin  m1:=rmi.In_ec.ml.Im; m2:=rma.In_ec.ml.Im; end;
              end;
            1:case p_part of
                0:begin  m1:=0{CAbs(rmi.In_ec.x)}; m2:=CAbs(rma.In_ec.x); end;
                1:begin  m1:=rmi.In_ec.x.Re; m2:=rma.In_ec.x.Re; end;
                2:begin  m1:=rmi.In_ec.x.Im; m2:=rma.In_ec.x.Im; end;
              end;
            2:case p_part of
                0:begin  m1:=0{CAbs(rmi.In_ec.z)}; m2:=CAbs(rma.In_ec.z); end;
                1:begin  m1:=rmi.In_ec.z.Re; m2:=rma.In_ec.z.Re; end;
                2:begin  m1:=rmi.In_ec.z.Im; m2:=rma.In_ec.z.Im; end;
              end;
          end;
        2:case p_part of
            0:begin  m1:=0{CAbs(rmi.VP_ec)}; m2:=CAbs(rma.VP_ec); end;
            1:begin  m1:=rmi.VP_ec.Re; m2:=rma.VP_ec.Re; end;
            2:begin  m1:=rmi.VP_ec.Im; m2:=rma.VP_ec.Im; end;
          end;
      end;
  end;
end;

function GetValue(i:int):float; // for profile
begin
  Result:=0;
  Case Task of
    0..2:Case p_Value of
           0:Case p_Component of
               0:Result:=FD_sc[i].ml;
               1:Result:=FD_sc[i].x;
               2:Result:=FD_sc[i].z;
             end;
           1:Case p_Component of
               0:Result:=In_sc[i].ml;
               1:Result:=In_sc[i].x;
               2:Result:=In_sc[i].z;
             end;
           2:Result:=SP_sc[i];
           3:Result:=mu_sc[i];
         end;
    3:Case p_Value of
        0:Case p_Component of
            0:Result:=FD_re[i].ml;
            1:Result:=FD_re[i].x;
            2:Result:=FD_re[i].z;
          end;
        1:Case p_Component of
            0:Result:=In_re[i].ml;
            1:Result:=In_re[i].x;
            2:Result:=In_re[i].z;
          end;
        2:Result:=VP_re[i];
        3:Result:=mu_re[i];
      end;
    5:Case p_Value of
        0:Case p_Component of
            0:Case p_Part of 0:Result:=CAbs(FD_ec[i].ml); 1:Result:=FD_ec[i].ml.Re; 2:Result:=FD_ec[i].ml.Im; end;
            1:Case p_Part of 0:Result:=CAbs(FD_ec[i].x);  1:Result:=FD_ec[i].x.Re;  2:Result:=FD_ec[i].x.Im;  end;
            2:Case p_Part of 0:Result:=CAbs(FD_ec[i].z);  1:Result:=FD_ec[i].z.Re;  2:Result:=FD_ec[i].z.Im;  end;
          end;
        1:Case p_Component of
            0:Case p_Part of 0:Result:=CAbs(In_ec[i].ml); 1:Result:=In_ec[i].ml.Re; 2:Result:=In_ec[i].ml.Im; end;
            1:Case p_Part of 0:Result:=CAbs(In_ec[i].x);  1:Result:=In_ec[i].x.Re;  2:Result:=In_ec[i].x.Im;  end;
            2:Case p_Part of 0:Result:=CAbs(In_ec[i].z);  1:Result:=In_ec[i].z.Re;  2:Result:=In_ec[i].z.Im;  end;
          end;
        2:Case p_Part of 0:Result:=CAbs(VP_ec[i]); 1:Result:=VP_ec[i].Re; 2:Result:=VP_ec[i].Im; end;
      end;
  end;
end;

function GetVector(i:int; var v:TVector):boolean; // for projection and map
begin
  Result:=true;
  Case Task of
    0..2:Case p_value of
           0:v:=FD_sc[i];
           1:v:=In_sc[i];
           2:begin Result:=false; v.x:=SP_sc[i]; end;
           3:begin Result:=false; v.x:=mu_sc[i]; end;
         end;
    3:Case p_Value of
        0:v:=FD_re[i];
        1:v:=In_re[i];
        2:begin Result:=false; v.x:=VP_re[i]; end;
        3:begin Result:=false; v.x:=mu_re[i]; end;
      end;
    5:Case p_value of
        0:Case p_Part of
            0:begin v.x:=CAbs(FD_ec[i].x); v.z:=CAbs(FD_ec[i].z); end;
            1:begin v.x:=FD_ec[i].x.Re; v.z:=FD_ec[i].z.Re; end;
            2:begin v.x:=FD_ec[i].x.Im; v.z:=FD_ec[i].z.Im; end;
          end;
        1:Case p_Part of
            0:begin v.x:=CAbs(In_ec[i].x); v.z:=CAbs(In_ec[i].z); end;
            1:begin v.x:=In_ec[i].x.Re; v.z:=In_ec[i].z.Re; end;
            2:begin v.x:=In_ec[i].x.Im; v.z:=In_ec[i].z.Im; end;
          end;
        2:begin
            Result:=false;
            Case p_Part of
              0:v.x:=CAbs(VP_ec[i]);
              1:v.x:=VP_ec[i].Re;
              2:v.x:=VP_ec[i].Im;
            end;
          end;
      end;
  end;
end;

/////////////////////////////////////////////
//              Graphic                    //
/////////////////////////////////////////////

function glR(r:float):float;
begin
  if dd_fit then
    Result:=-0.9+1.8*r/max(tt.bx,tt.bz-tt.az)
  else
    Result:=-0.9+1.8*r/tt.bx;
end;

function glZ(z:float):float;
begin
  if dd_fit then
    Result:=-0.9+1.8*(z-tt.az)/max(tt.bx,tt.bz-tt.az)
  else
    Result:=-0.9+1.8*(z-tt.az)/(tt.bz-tt.az);
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

////////////////////////////////////////////////////////////////////////////////
//                   Inintiation and generation                               //
////////////////////////////////////////////////////////////////////////////////
procedure InitData2d;
begin
  v_nr:=tt.nnx-1;
  v_nz:=tt.nnz-1;
  nQuads := v_nr * v_nz;
end;

// axial parameters and modules
procedure OtherParams(var v:TVector);
begin
  v.ml:=sqrt(sqr(v.x)+sqr(v.z));
end;

procedure OtherParams_cx(var v:TcxVector);
begin
  v.ml:=CSqrt(CAdd(Csqr(v.x),Csqr(v.z)));
end;

/// Module extremums
function MaxModuleF(var a:array of float):float;// max scalar module
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nQuads do if Abs(a[i])>m then m:=Abs(a[i]);
  Result:=m;
end;

function MaxModuleFx(var a:array of TComplex):float;// max complex scalar module
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nQuads do if CAbs(a[i])>m then m:=CAbs(a[i]);
  Result:=m;
end;

function MaxModule(var a:array of TVector):float;
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nQuads do if a[i].ml>m then m:=a[i].ml;
  Result:=m;
end;

function MaxModule_cx(var a:array of TcxVector):float;
var i:int;
    m:float;
begin
  m:=0;
  for i:=1 to nQuads do if CAbs(a[i].ml)>m then m:=CAbs(a[i].ml);
  Result:=m;
end;

/////// min/max vector calculations
function MaxVector(var a:array of TVector):TVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i].x>m  then m:=a[i].x;  Result.x:=m;
  m:=0; for i:=1 to nQuads do if a[i].z>m  then m:=a[i].z;  Result.z:=m;
  m:=0; for i:=1 to nQuads do if a[i].ml>m then m:=a[i].ml; Result.ml:=m;
end;

function MinVector(var a:array of TVector):TVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i].x<m  then m:=a[i].x;  Result.x:=m;
  m:=0; for i:=1 to nQuads do if a[i].z<m  then m:=a[i].z;  Result.z:=m;
  m:=0; for i:=1 to nQuads do if a[i].ml<m then m:=a[i].ml; Result.ml:=m;
end;

function cMaxVector(var a:array of TcxVector):TcxVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i].x.Re>m  then m:=a[i].x.Re;  Result.x.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].x.Im>m  then m:=a[i].x.Im;  Result.x.Im:=m;
  //
  m:=0; for i:=1 to nQuads do if a[i].z.Re>m  then m:=a[i].z.Re;  Result.z.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].z.Im>m  then m:=a[i].z.Im;  Result.z.Im:=m;
  //
  m:=0; for i:=1 to nQuads do if a[i].ml.Re>m then m:=a[i].ml.Re; Result.ml.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].ml.Im>m then m:=a[i].ml.Im; Result.ml.Im:=m;
end;

function cMinVector(var a:array of TcxVector):TcxVector;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i].x.Re<m  then m:=a[i].x.Re;  Result.x.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].x.Im<m  then m:=a[i].x.Im;  Result.x.Im:=m;
  //
  m:=0; for i:=1 to nQuads do if a[i].z.Re<m  then m:=a[i].z.Re;  Result.z.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].z.Im<m  then m:=a[i].z.Im;  Result.z.Im:=m;
  //
  m:=0; for i:=1 to nQuads do if a[i].ml.Re<m then m:=a[i].ml.Re; Result.ml.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].ml.Im<m then m:=a[i].ml.Im; Result.ml.Im:=m;
end;

function cMaxVectorF(var a:array of TComplex):TComplex;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i].Re>m  then m:=a[i].Re;  Result.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].Im>m  then m:=a[i].Im;  Result.Im:=m;
end;

function cMinVectorF(var a:array of TComplex):TComplex;
var i:int;
    m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i].Re<m  then m:=a[i].Re;  Result.Re:=m;
  m:=0; for i:=1 to nQuads do if a[i].Im<m  then m:=a[i].Im;  Result.Im:=m;
end;

function cMaxF(var a:array of float):float;
var i:int; m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i]>m  then m:=a[i];  Result:=m;
end;

function cMinF(var a:array of float):float;
var i:int; m:float;
begin
  m:=0; for i:=1 to nQuads do if a[i]<m  then m:=a[i];  Result:=m;
end;

////////////////////////////////////////////////////////////////////////////////
//                  Main 2D Resultant Field generator                         //
////////////////////////////////////////////////////////////////////////////////
procedure GenerateRes2D;
var i,j:int;
    iElement:int;
    v:TVector;
    vx:TcxVector;
    xx,yy,zz:float;
    iM:int;
    cc:TComplex;
begin
//  nQuads:=tt.NTriangles;
  SetLength(crZ,nQuads+1);
  SetLength(crR,nQuads+1);
  // scalar
  SetLength(FD_sc,nQuads+1);
  SetLength(In_sc,nQuads+1);
  SetLength(SP_sc,nQuads+1);
  SetLength(mu_sc,nQuads+1);
  // steady state
  SetLength(FD_re,nQuads+1);
  SetLength(In_re,nQuads+1);
  SetLength(VP_re,nQuads+1);
  SetLength(mu_re,nQuads+1);
  // eddy curent
  SetLength(FD_ec,nQuads+1);
  SetLength(In_ec,nQuads+1);
  SetLength(VP_ec,nQuads+1);
  // filling data
  for i:=1 to nQuads do
  begin
    for j:=1 to 2 do
    begin
      iElement:=2*i-j+1;
      tt.GetCenter(iElement,xx,zz);
      crR[i]:=crR[i]+xx;
      crZ[i]:=crZ[i]+zz;
      Case task of
        0..2:begin
            ComputeVec_sc(iElement);
            FD_sc[i].x:=FD_sc[i].x+FD_X;
            FD_sc[i].z:=FD_sc[i].z+FD_Z;
            In_sc[i].x:=In_sc[i].x+HIn_X;
            In_sc[i].z:=In_sc[i].z+HIn_Z;
            SP_sc[i]:=SP_sc[i]+avRes;
            mu_sc[i]:=mu_sc[i]+mu_rel;
          end;
        3:begin
            ComputeVec_re(iElement);
            FD_re[i].x:=FD_re[i].x+FD_X;
            FD_re[i].z:=FD_re[i].z+FD_Z;
            In_re[i].x:=In_re[i].x+HIn_X;
            In_re[i].z:=In_re[i].z+HIn_Z;
            VP_re[i]:=VP_re[i]+avRes;
            mu_re[i]:=mu_re[i]+mu_rel;
          end;
        5:begin
            iM:=tt.Topology[iElement][0];
            ComputeVec_ec(iElement);
            FD_ec[i].x:=CAdd(FD_ec[i].x,cFD_X);
            FD_ec[i].z:=CAdd(FD_ec[i].z,cFD_Z);
            In_ec[i].x:=CAdd(In_ec[i].x,cHIn_X);
            In_ec[i].z:=CAdd(In_ec[i].z,cHIn_Z);
            cc:=CMul(CDConv(0,mt.frequency*2*Pi*mt.Sigma[iM]),cavRes);
            //In_ec[i].x.re:=In_ec[i].x.Re+mt.Sigma[iM]*cc.Re;
            //In_ec[i].x.im:=In_ec[i].x.im+mt.Sigma[iM]*cc.im;
            VP_ec[i]:=CAdd(VP_ec[i],cc{cavRes});
          end;
      end;
    end;
    crR[i]:=crR[i]/2;
    crZ[i]:=crZ[i]/2;
    Case task of
      0..2:begin
          FD_sc[i].x:=FD_sc[i].x/2;
          FD_sc[i].z:=FD_sc[i].z/2;
          In_sc[i].x:=In_sc[i].x/2;
          In_sc[i].z:=In_sc[i].z/2;
          SP_sc[i]:=SP_sc[i]/2;
          mu_sc[i]:=mu_sc[i]/2;
        end;
      3:begin
          FD_re[i].x:=FD_re[i].x/2;
          FD_re[i].z:=FD_re[i].z/2;
          In_re[i].x:=In_re[i].x/2;
          In_re[i].z:=In_re[i].z/2;
          VP_re[i]:=VP_re[i]/2;
          mu_re[i]:=mu_re[i]/2;
        end;
      5:begin
          FD_ec[i].x:=CDiv(FD_ec[i].x,CConv(2));
          FD_ec[i].z:=CDiv(FD_ec[i].z,CConv(2));
          In_ec[i].x:=CDiv(In_ec[i].x,CConv(2));
          In_ec[i].z:=CDiv(In_ec[i].z,CConv(2));
          VP_ec[i]:=CDiv(VP_ec[i],CConv(2));
        end;
    end;
  end;
  for i:=1 to nQuads do
    if task<5 then
    begin
      v:=FD_sc[i]; OtherParams(v); FD_sc[i]:=v;
      v:=In_sc[i]; OtherParams(v); In_sc[i]:=v;
      v:=FD_re[i]; OtherParams(v); FD_re[i]:=v;
      v:=In_re[i]; OtherParams(v); In_re[i]:=v;
    end
    else
    begin
      vx:=FD_ec[i]; OtherParams_cx(vx); FD_ec[i]:=vx;
      vx:=In_ec[i]; OtherParams_cx(vx); In_ec[i]:=vx;
    end;
  // module scale
  rm.FD_sc:=MaxModule(FD_sc);
  rm.In_sc:=MaxModule(In_sc);
  rm.SP_sc:=MaxModuleF(SP_sc);
  rm.mu_sc:=MaxModuleF(mu_sc);
  /////
  rm.FD_re:=MaxModule(FD_re);
  rm.In_re:=MaxModule(In_re);
  rm.VP_re:=MaxModuleF(VP_re);
  rm.mu_re:=MaxModuleF(mu_re);
  /////
  rm.FD_ec:=MaxModule_cx(FD_ec);
  rm.In_ec:=MaxModule_cx(In_ec);
  rm.VP_ec:=MaxModuleFx(VP_ec);
  // maximal scale
  rma.FD_sc:=MaxVector(FD_sc);
  rma.In_sc:=MaxVector(In_sc);
  rma.SP_sc:=cMaxF(SP_sc);
  rma.mu_sc:=cMaxF(mu_sc);
  //////
  rma.FD_re:=MaxVector(FD_re);
  rma.In_re:=MaxVector(In_re);
  rma.VP_re:=cMaxF(VP_re);
  rma.mu_re:=cMaxF(mu_re);
  //////
  rma.FD_ec:=cMaxVector(FD_ec);
  rma.In_ec:=cMaxVector(In_ec);
  rma.VP_ec:=cMaxVectorF(VP_ec);
  // minimal scale
  rmi.FD_sc:=MinVector(FD_sc);
  rmi.In_sc:=MinVector(In_sc);
  rmi.SP_sc:=cMinF(SP_sc);
  rmi.mu_sc:=cMinF(mu_sc);
  //////
  rmi.FD_re:=MinVector(FD_re);
  rmi.In_re:=MinVector(In_re);
  rmi.VP_re:=cMinF(VP_re);
  rmi.mu_re:=cMinF(mu_re);
  //////
  rmi.FD_ec:=cMinVector(FD_ec);
  rmi.In_ec:=cMinVector(In_ec);
  rmi.VP_ec:=cMinVectorF(VP_ec);
end;

procedure FreeRes2D;
begin
  crZ:=nil;
  crR:=nil;
  // scalar
  FD_sc:=nil;
  In_sc:=nil;
  SP_sc:=nil;
  mu_sc:=nil;
  // steady state
  FD_re:=nil;
  In_re:=nil;
  VP_re:=nil;
  mu_re:=nil;
  // eddy curent
  FD_ec:=nil;
  In_ec:=nil;
  VP_ec:=nil;
  ///////////
  slTri:=nil;
end;

function Get_LineF(a:float; j:int;var x1,y1,x2,y2:float):boolean;
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
    ////
    v1:=crR[slTri[j][i]];
    v2:=crR[slTri[j][i+1]];
    w1:=crZ[slTri[j][i]];
    w2:=crZ[slTri[j][i+1]];
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
    x1,x2,y1,y2:float;
    a,a_min,a_max:float;
    cl:TColor;
    r,g,b:float;
    tmp:float;
begin
  GetScalarScale(a_min,a_max);
  n1:=v_nr;
  n2:=v_nz;
  nn:=2*(n1-1)*(n2-1);
  SetLength(slTri,1+nn);
  for i:=1 to n1-1 do
  for j:=1 to n2-1 do
  begin
    k:=j+(i-1)*(n2-1);
    slTri[2*k-1][1]:=tt.Num2Quad(i,j);
    slTri[2*k-1][2]:=tt.Num2Quad(i+1,j);
    slTri[2*k-1][3]:=tt.Num2Quad(i,j+1);
    slTri[2*k-1][4]:=tt.Num2Quad(i,j);
    slTri[2*k][1]:=tt.Num2Quad(i+1,j+1);
    slTri[2*k][2]:=tt.Num2Quad(i+1,j);
    slTri[2*k][3]:=tt.Num2Quad(i,j+1);
    slTri[2*k][4]:=tt.Num2Quad(i+1,j+1);
  end;
  for i:=1 to v_Slices do
  begin
    a:=a_min+i*(a_max-a_min)/(v_Slices+1);
    tmp:=(a_max-a_min); if tmp<1e-30 then tmp:=1;
    if b_Gray then cl:=GRColor((a-a_min)/tmp) else cl:=RBColor((a-a_min)/tmp);
    if b_black then cl:=clBlack;
    cl2gl(cl,r,g,b);
    glColor3f(r,g,b);
    for j:=1 to nn do
    begin
      if not Get_LineF(a,j,x1,y1,x2,y2) then continue;
      glBegin(GL_LINES);
        glVertex2f(glR(x1),glZ(y1));
        glVertex2f(glR(x2),glZ(y2));
      glEnd;
    end;
  end;
end;

procedure createSmooth;
var n1,n2:int;
    i,j:int;
    k,nn:int;
    x1,y1:float;
    a,a_min,a_max:float;
    cl:TColor;
    r,g,b:float;
    tmp:float;
    cPotential:TComplex;
    cT:TComplex;
begin
  GetScalarScale(a_min,a_max);
  n1:=v_nr;
  n2:=v_nz;
  nn:=2*(n1-1)*(n2-1);
  SetLength(slTri,1+nn);
  for i:=1 to n1-1 do
  for j:=1 to n2-1 do
  begin
    k:=j+(i-1)*(n2-1);
    slTri[2*k-1][1]:=tt.Num2Quad(i,j);
    slTri[2*k-1][2]:=tt.Num2Quad(i+1,j);
    slTri[2*k-1][3]:=tt.Num2Quad(i,j+1);
    slTri[2*k-1][4]:=tt.Num2Quad(i,j);
    slTri[2*k][1]:=tt.Num2Quad(i+1,j+1);
    slTri[2*k][2]:=tt.Num2Quad(i+1,j);
    slTri[2*k][3]:=tt.Num2Quad(i,j+1);
    slTri[2*k][4]:=tt.Num2Quad(i+1,j+1);
  end;
  for i:=1 to tt.NTriangles do
  begin
    glBegin(GL_TRIANGLES);
    for j:=1 to 3 do
    begin
      cPotential:=TFlatECTask(tt).vMatr[tt.Topology[i][j]];
      cT:=CMul(CPotential,CDConv(0,mt.frequency*2*Pi*mt.Sigma[tt.Topology[i][0]]));
      a:=cT.re;
      x1:=tt.Nodes[tt.Topology[i][j]][1];
      y1:=tt.Nodes[tt.Topology[i][j]][2];
      tmp:=(a_max-a_min); if tmp<1e-30 then tmp:=1;
      cl:=RBColor((a-a_min)/tmp);
      cl2gl(cl,r,g,b);
      glColor3f(r,g,b);
      glVertex2f(glR(x1),glZ(y1));
    end;
    glEnd();
  end;
end;

end.
