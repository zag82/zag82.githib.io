unit cmData;

interface

Uses cm_ini, specMat, Graphics, Classes;

////////////////////////////////////////////////////////////////////////////////
//                            Материалы                                       //
////////////////////////////////////////////////////////////////////////////////
Type
  TParams=record
    wError2d:float;
    wMIter2d:int;
    wSMeth2d:int;
    /////////////////
    wError3d:float;
    wMIter3d:int;
    wSMeth3d:int;
    ////////////////
    wError_d:float;
    wMIter_d:int;
    wSMeth_d:int;
    ////////////////
    wError_n:float;
    wMIter_n:int;
    wSMeth_n:int;
  end;

  TMaterials=class
  private
  public
    a:array of float;
    b:array of float;
    c:array of float;
    Frequency:float;
    nMaterials:int;              // число материалов
    DefaultMaterial:int;         // материа окружающей среды
    mmName:array of st80;      // название материала
    mmColor:array of TColor;     // цвет отображения материала
    Sigma:array of float;
    MuProperty:array of float;
    Epsilon:array of float;
    ////////////////////////////
    nlProperty:array of int;
    nlFile:array of st80;
    nm:array of int;
    BB:array of array of float;
    HH:array of array of float;
    MMu:array of array of float;
    ////////////////////////////
    Anisotropy_X:array of float;
    Anisotropy_Y:array of float;
    Anisotropy_Z:array of float;
    VecProperty:array of float;
    ScProperty:array of float;
    procedure LoadFileBH(k:int);
    procedure ChangeNum;
    procedure GenerateAllProperties(iTask:int);
    procedure ReleaseData;
    procedure CalcKoefficients(a0,b0,c0:float; im:int);
    function Prop(iElement,iMater:int):float;
    function dMuH2(iElement,iMater:int):float;
    function GetBH(h:float; im:int):float;
  end;

////////////////////////////////////////////////////////////////////////////////
//                             Объекты                                        //
////////////////////////////////////////////////////////////////////////////////
Type
  { Основной класс геометрических объектов }
  TMgObject=class(TObject)
  protected
    { защищенные переменные }
  public
    { общедоступные процедуры }
    Name:St80;
    iMaterial:int;
    sr_1:float;
    sr_2:float;
    sr_3:float;
    sr_4:float;
    sr_kind:byte;
    constructor Create(m:int; nm:string);
    procedure DataLoad(q1,q2,q3,q4:float; kn:byte);
    function GetMaterial:int;
    ///////////////////////
    function Ro(x,y,z:float):float;virtual;abstract;
    function Phi(x,y,z:float):float;virtual;abstract;
    ///////////////////////
    function Jx(x,y,z:float):float;virtual;abstract;
    function Jy(x,y,z:float):float;virtual;abstract;
    function Jz(x,y,z:float):float;virtual;abstract;
    ////////////////////////
    function Bx(x,y,z:float):float;virtual;abstract;
    function By(x,y,z:float):float;virtual;abstract;
    function Bz(x,y,z:float):float;virtual;abstract;
    function IsPointInside(x,y,z:float):boolean;virtual;abstract;
  end;

  { Наследуемый класс кругового сектора }
  TSector=class(TMgObject)
  public
    { Public declarations }
    xx:float;
    yy:float;
    zz:float;
    r1:float;
    r2:float;
    al:float;
    bt:float;
    h:float;
    ax_dir:byte;
    constructor Create(m:int; nm:string);
    function IsPointInside(x,y,z:float):boolean;override;
    procedure SetData(x,y,z,r_min,r_max,alpha,betta,hh:float;dir:st1);
    ///////////////////////
    function Ro(x,y,z:float):float;override;
    function Phi(x,y,z:float):float;override;
    ///////////////////////
    function Jx(x,y,z:float):float;override;
    function Jy(x,y,z:float):float;override;
    function Jz(x,y,z:float):float;override;
    ////////////////////////
    function Bx(x,y,z:float):float;override;
    function By(x,y,z:float):float;override;
    function Bz(x,y,z:float):float;override;
  end;

  { Наследуемый класс прямоугольного параллепипеда }
  TBlock=class(TMgObject)
  public
    { Public declarations }
    x_1:float;
    y_1:float;
    z_1:float;
    x_2:float;
    y_2:float;
    z_2:float;
    constructor Create(m:int; nm:string);
    function IsPointInside(x,y,z:float):boolean;override;
    procedure SetData(x1,y1,z1,x2,y2,z2:float);
    ///////////////////////
    function Ro(x,y,z:float):float;override;
    function Phi(x,y,z:float):float;override;
    ///////////////////////
    function Jx(x,y,z:float):float;override;
    function Jy(x,y,z:float):float;override;
    function Jz(x,y,z:float):float;override;
    ////////////////////////
    function Bx(x,y,z:float):float;override;
    function By(x,y,z:float):float;override;
    function Bz(x,y,z:float):float;override;
  end;

  { Наследуемый класс треугольного сектора }
  TTriBlock=class(TMgObject)
  public
    { Public declarations }
    x1,x2,x3:float;
    z1,z2,z3:float;
    y_min,y_max:float;
    constructor Create(m:int; nm:string);
    function IsPointInside(x,y,z:float):boolean;override;
    procedure SetData(x_1,z_1,x_2,z_2,x_3,z_3,y_1,y_2:float);
    ///////////////////////
    function Ro(x,y,z:float):float;override;
    function Phi(x,y,z:float):float;override;
    ///////////////////////
    function Jx(x,y,z:float):float;override;
    function Jy(x,y,z:float):float;override;
    function Jz(x,y,z:float):float;override;
    ////////////////////////
    function Bx(x,y,z:float):float;override;
    function By(x,y,z:float):float;override;
    function Bz(x,y,z:float):float;override;
  end;

  TTriSec=class(TMgObject)
  public
    { Public declarations }
    x1,x2,x3:float;
    z1,z2,z3:float;
    al,bt:float;
    constructor Create(m:int; nm:string);
    function IsPointInside(x,y,z:float):boolean;override;
    procedure SetData(x_1,z_1,x_2,z_2,x_3,z_3, alpha,betta:float);
    ///////////////////////
    function Ro(x,y,z:float):float;override;
    function Phi(x,y,z:float):float;override;
    ///////////////////////
    function Jx(x,y,z:float):float;override;
    function Jy(x,y,z:float):float;override;
    function Jz(x,y,z:float):float;override;
    ////////////////////////
    function Bx(x,y,z:float):float;override;
    function By(x,y,z:float):float;override;
    function Bz(x,y,z:float):float;override;
  end;

////////////////////////////////////////////////////////////////////////////////
//                        Конец определения данных                            //
////////////////////////////////////////////////////////////////////////////////
Var
  ps:TParams;
  mt:TMaterials;
  ob:TList;

  Hm:array of float;
  vm:array of float;
  vmx,vmy,vmz:array of float;

procedure SetDefaultParams;
procedure ClearParams;

implementation

uses cmVars, f_simplex2;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////  Класс материалов  ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
procedure TMaterials.CalcKoefficients(a0,b0,c0:float; im:int);
var i,k:int;
    a_,b_,c_:float;
    a1,b1,c1:float;
    s1,s2:float;
begin
  a_:=a0;
  b_:=b0;
  c_:=c0;
  for i:=1 to 100 do
  begin
    s1:=0; for k:=1 to nm[im] do s1:=s1+a_*HH[im][k]*BB[im][k]/(HH[im][k]+1/b_);
    s2:=0; for k:=1 to nm[im] do s2:=s2+sqr(a_)*HH[im][k]*ln(b_*HH[im][k]+1)/(b_*HH[im][k]+1);
    b1:=s1/s2;
    s1:=0; for k:=1 to nm[im] do s1:=s1+BB[im][k]*ln(b1*HH[im][k]+1);
    s2:=0; for k:=1 to nm[im] do s2:=s2+sqr(ln(b1*HH[im][k]+1));
    a1:=s1/s2;
{    s1:=0; for k:=1 to nm[im] do s1:=s1+BB[im][k]*(1-exp(-b_*sqr(HH[im][k]))+c_*HH[im][k]);
    s2:=0; for k:=1 to nm[im] do s2:=s2+sqr(1-exp(-b_*sqr(HH[im][k]))+c_*HH[im][k]);
    a1:=s1/s2;
    s1:=0; for k:=1 to nm[im] do s1:=s1+a_*HH[im][k]*(BB[im][k]-a_*(1-exp(-b_*sqr(HH[im][k]))));
    s2:=0; for k:=1 to nm[im] do s2:=s2+sqr(a_*HH[im][k]);
    c1:=s1/s2;
    s1:=0; for k:=1 to nm[im] do s1:=s1+sqr(HH[im][k])*(a_-exp(-b_*sqr(HH[im][k]))*(a_*(1+c_*HH[im][k])-BB[im][k]));
    s2:=0; for k:=1 to nm[im] do s2:=s2+2*a_*sqr(HH[im][k])*sqr(HH[im][k]);
    b1:=b0;//s1/s2;}
    a_:=a1;
    b_:=b1;
    c_:=c1;
  end;
  a[im]:=a_;
  b[im]:=b_;
  c[im]:=c_;
end;

function TMaterials.Prop(iElement,iMater:int):float;
var
  h,a1,b1:float;
begin
  if nlProperty[iMater]=0 then
  begin
    if Task<=2 then
      Result:=ScProperty[iMater]
    else
      Result:=VecProperty[iMater];
  end
  else
  begin
    h:=Hm[iElement];
    a1:=a[iMater];
    b1:=b[iMater];
    if Task=2 then
    begin
      Result:=a1/(b1+h);
    end
    else
    begin
      if h>a1 then Result:=0
      else Result:=b1/(a1-h);
    end;
  end;
end;

function TMaterials.GetBH(h:float; im:int):float;
var a1,b1,c1:float;
begin
  a1:=a[iM];
  b1:=b[iM];
  c1:=c[iM];
  if Task=2 then
    Result:=a1*h/(h+b1)
  else
  begin
    if h>a1 then h:=a1;
    Result:=b1*h/(a1-h);
  end;
end;

function TMaterials.dMuH2(iElement,iMater:int):float;
var
  h,a1,b1:float;
begin
  if nlProperty[iMater]=0 then Result:=0
  else
  begin
    h:=Hm[iElement];
    a1:=a[iMater];
    b1:=b[iMater];
    if Task=2 then
    begin
      if h<1e-10 then h:=1e-10;
      Result:=-a1/(2*h*sqr(h+b1));
    end
    else
    begin
      if h<1e-10 then h:=1e-10;
      if h>a1 then Result:=0
      else Result:=b1/(2*h*sqr(a1-h));
    end;
  end;
end;

procedure TMaterials.LoadFileBH(k:int);
var f:TextFile;
    i,nn:int;
    a1,a2:float;
begin
  AssignFile(f,nlFile[k]);
  Reset(f);
  readln(f);
  readln(f,nn);
  readln(f);
  nm[k]:=nn;
  SetLength(BB[k],nn+1);
  SetLength(HH[k],nn+1);
  SetLength(MMu[k],nn+1);
  for i:=1 to nn do
  begin
    readln(f,a2,a1);
    BB[k,i]:=a1;
    HH[k,i]:=a2;
    if (a2<1e-20)or(a1<1e-20) then MMu[k,i]:=1 else
    begin
      if Task=2 then MMu[k,i]:=a1/a2 else MMu[k,i]:=a2/a1;
    end;
  end;
  CloseFile(f);
end;

procedure TMaterials.ChangeNum;
begin
  SetLength(mmName,nMaterials);
  SetLength(mmColor,nMaterials);
  SetLength(Sigma,nMaterials);
  SetLength(MuProperty,nMaterials);
  SetLength(Epsilon,nMaterials);
  ////////////////////////////
  SetLength(nlProperty,nMaterials);
  SetLength(nlFile,nMaterials);
  SetLength(nm,nMaterials);
  SetLength(BB,nMaterials);
  SetLength(HH,nMaterials);
  SetLength(MMu,nMaterials);
  SetLength(a,nMaterials);
  SetLength(b,nMaterials);
  SetLength(c,nMaterials);
  ////////////////////////////
  SetLength(Anisotropy_X,nMaterials);
  SetLength(Anisotropy_Y,nMaterials);
  SetLength(Anisotropy_Z,nMaterials);
end;

procedure TMaterials.ReleaseData;
begin
  ScProperty:=nil;
  VecProperty:=nil;
end;

procedure TMaterials.GenerateAllProperties(iTask:int);
var i:int;
    sxa,sxb:double;
begin
  ReleaseData;
  if iTask<=2 then
    SetLength(ScProperty,nMaterials)
  else
    SetLength(VecProperty,nMaterials);
  for i:=0 to NMaterials-1 do
    case iTask of
      0:ScProperty[i]:=Eps0*Epsilon[i];
      1:ScProperty[i]:=Sigma[i];
      2:ScProperty[i]:=Mu0*MuProperty[i];
      3..5:VecProperty[i]:=1/(Mu0*MuProperty[i])
    end;
  for i:=0 to NMaterials-1 do if nlProperty[i]=1 then LoadFileBH(i);
  for i:=0 to NMaterials-1 do if nlProperty[i]=1 then
  begin
    fsx:=TFixedSimplex.Create;
    fsx.Starter(i);
    fsx.SolveSimplex(2,1000,0.01,10,sxa,sxb);
    a[i]:=sxa;
    b[i]:=sxb{*1e-8};
    fsx.Free;
  end;
end;

{==============================================================================}
{                   Основной класс геометрических объектов                     }
{        TMgObject                                                             }
{==============================================================================}
constructor TMgObject.Create(m:int; nm:string);
begin
  iMaterial:=m;
  Name:=nm;
  inherited Create;
end;

function TMgObject.GetMaterial:int;
begin
  Result:=iMaterial;
end;

procedure TMgObject.DataLoad(q1,q2,q3,q4:float; kn:byte);
begin
  sr_1:=q1;
  sr_2:=q2;
  sr_3:=q3;
  sr_4:=q4;
  sr_kind:=kn;
end;

{==============================================================================}
{              Наследуемый класс прямоугольного параллепипеда                  }
{        TBlock                                                                }
{==============================================================================}
constructor TBlock.Create(m:int; nm:string);
begin
  inherited Create(m,nm);
end;

function TBlock.IsPointInside(x,y,z:float):boolean;
const delta=1e-11;
var
  r_1,r_2,r_3:boolean;
begin
  r_1:=(delta<=x-x_1)and(delta<=x_2-x);
  r_2:=(delta<=y-y_1)and(delta<=y_2-y);
  r_3:=(delta<=z-z_1)and(delta<=z_2-z);
  Result:=(r_1)and(r_2)and(r_3);
end;

procedure TBlock.SetData(x1,y1,z1,x2,y2,z2:float);
begin
  x_1:=x1;
  y_1:=y1;
  z_1:=z1;
  x_2:=x2;
  y_2:=y2;
  z_2:=z2;
end;

///////////////////////
function TBlock.Ro(x,y,z:float):float;
begin
  if (sr_kind=1)and(IsPointInside(x,y,z)) then Result:=sr_1 else Result:=0;
end;

function TBlock.Phi(x,y,z:float):float;
begin
  if (sr_kind=3)and(IsPointInside(x,y,z)) then Result:=sr_4 else Result:=0;
end;

////////////////////////
function TBlock.Jx(x,y,z:float):float;
begin
  if (sr_kind=3)and(IsPointInside(x,y,z)) then Result:=sr_1 else Result:=0;
end;

function TBlock.Jy(x,y,z:float):float;
begin
  if (sr_kind=3)and(IsPointInside(x,y,z)) then Result:=sr_2 else Result:=0;
end;

function TBlock.Jz(x,y,z:float):float;
begin
  if (sr_kind=3)and(IsPointInside(x,y,z)) then Result:=sr_3 else Result:=0;
end;

////////////////////////
function TBlock.Bx(x,y,z:float):float;
begin
  if (sr_kind=2)and(IsPointInside(x,y,z)) then Result:=sr_1 else Result:=0;
end;

function TBlock.By(x,y,z:float):float;
begin
  if (sr_kind=2)and(IsPointInside(x,y,z)) then Result:=sr_2 else Result:=0;
end;

function TBlock.Bz(x,y,z:float):float;
begin
  if (sr_kind=2)and(IsPointInside(x,y,z)) then Result:=sr_3 else Result:=0;
end;

{==============================================================================}
{                   Наследуемый класс кругового сектора                        }
{        TSector                                                               }
{==============================================================================}
constructor TSector.Create(m:int; nm:string);
begin
  inherited Create(m,nm);
end;

function TSector.IsPointInside(x,y,z:float):boolean;
const delta=1e-15;
var rr,phi:float;
    r_1,r_2,r_3:boolean;
begin
  Case ax_dir of
    1:begin
        rr:=sqrt(sqr(z)+sqr(y));
        phi:=ArcTng(z,y)/pi*180;
        r_1:=(delta<=x-xx)and(delta<=xx+h-x);
        r_2:=(delta<=phi-al)and(delta<=bt-phi);
        r_3:=(delta<=rr-r1)and(delta<=r2-rr);
        Result:=(r_1)and(r_2)and(r_3);
      end;
    2:begin
        rr:=sqrt(sqr(x)+sqr(z));
        phi:=ArcTng(x,z)/pi*180;
        r_1:=(delta<=y-yy)and(delta<=yy+h-y);
        r_2:=(delta<=phi-al)and(delta<=bt-phi);
        r_3:=(delta<=rr-r1)and(delta<=r2-rr);
        Result:=(r_1)and(r_2)and(r_3);
      end;
    3:begin
        rr:=sqrt(sqr(x)+sqr(y));
        phi:=ArcTng(x,y)/pi*180;
        r_1:=(delta<=z-zz)and(delta<=zz+h-z);
        r_2:=(delta<=phi-al)and(delta<=bt-phi);
        r_3:=(delta<=rr-r1)and(delta<=r2-rr);
        Result:=(r_1)and(r_2)and(r_3);
      end;
  else
    Result:=false;
  end;
end;

procedure TSector.SetData(x,y,z,r_min,r_max,alpha,betta,hh:float;dir:st1);
begin
  xx:=x;
  yy:=y;
  zz:=z;
  r1:=r_min;
  r2:=r_max;
  al:=alpha;
  bt:=betta;
  h:=hh;
  if dir='X' then ax_dir:=1
  else if dir='Y' then ax_dir:=2
  else if dir='Z' then ax_dir:=3;
end;

///////////////////////
function TSector.Ro(x,y,z:float):float;
begin
  if (sr_kind=1)and(IsPointInside(x,y,z)) then Result:=sr_1 else Result:=0;
end;

function TSector.Phi(x,y,z:float):float;
begin
  if (sr_kind=3)and(IsPointInside(x,y,z)) then Result:=sr_4 else Result:=0;
end;

////////////////////////
function TSector.Jx(x,y,z:float):float;
var cc,ss,rr:float;
begin
  Result:=0;
  if (sr_kind=3)and(IsPointInside(x,y,z)) then
    Case ax_dir of
      1:Result:=sr_3;
      2:begin
          rr:=sqrt(sqr(x)+sqr(z));
          cc:=x/rr;
          ss:=z/rr;
          Result:=sr_1*cc-sr_2*ss;
        end;
      3:begin
          rr:=sqrt(sqr(x)+sqr(y));
          cc:=x/rr;
          ss:=y/rr;
          Result:=sr_1*cc-sr_2*ss;
        end;
    end
  else Result:=0;
end;

function TSector.Jy(x,y,z:float):float;
var cc,ss,rr:float;
begin
  Result:=0;
  if (sr_kind=3)and(IsPointInside(x,y,z)) then
    Case ax_dir of
      1:begin
          rr:=sqrt(sqr(z)+sqr(y));
          cc:=y/rr;
          ss:=z/rr;
          Result:=sr_1*cc-sr_2*ss;
        end;
      2:Result:=sr_3;
      3:begin
          rr:=sqrt(sqr(x)+sqr(y));
          cc:=x/rr;
          ss:=y/rr;
          Result:=sr_1*ss+sr_2*cc;
        end;
    end
  else Result:=0;
end;

function TSector.Jz(x,y,z:float):float;
var cc,ss,rr:float;
begin
  Result:=0;
  if (sr_kind=3)and(IsPointInside(x,y,z)) then
    Case ax_dir of
      1:begin
          rr:=sqrt(sqr(z)+sqr(y));
          cc:=y/rr;
          ss:=z/rr;
          Result:=sr_1*ss+sr_2*cc;
        end;
      2:begin
          rr:=sqrt(sqr(x)+sqr(z));
          cc:=x/rr;
          ss:=z/rr;
          Result:=sr_1*ss+sr_2*cc;
        end;
      3:Result:=sr_3;
    end
  else Result:=0;
end;

////////////////////////
function TSector.Bx(x,y,z:float):float;
var cc,ss,rr:float;
begin
  Result:=0;
  if (sr_kind=2)and(IsPointInside(x,y,z)) then
    Case ax_dir of
      1:Result:=sr_3;
      2:begin
          rr:=sqrt(sqr(x)+sqr(z));
          cc:=x/rr;
          ss:=z/rr;
          Result:=sr_1*cc-sr_2*ss;
        end;
      3:begin
          rr:=sqrt(sqr(x)+sqr(y));
          cc:=x/rr;
          ss:=y/rr;
          Result:=sr_1*cc-sr_2*ss;
        end;
    end
  else Result:=0;
end;

function TSector.By(x,y,z:float):float;
var cc,ss,rr:float;
begin
  Result:=0;
  if (sr_kind=2)and(IsPointInside(x,y,z)) then
    Case ax_dir of
      1:begin
          rr:=sqrt(sqr(z)+sqr(y));
          cc:=y/rr;
          ss:=z/rr;
          Result:=sr_1*cc-sr_2*ss;
        end;
      2:Result:=sr_3;
      3:begin
          rr:=sqrt(sqr(x)+sqr(y));
          cc:=x/rr;
          ss:=y/rr;
          Result:=sr_1*ss+sr_2*cc;
        end;
    end
  else Result:=0;
end;

function TSector.Bz(x,y,z:float):float;
var cc,ss,rr:float;
begin
  Result:=0;
  if (sr_kind=2)and(IsPointInside(x,y,z)) then
    Case ax_dir of
      1:begin
          rr:=sqrt(sqr(z)+sqr(y));
          cc:=y/rr;
          ss:=z/rr;
          Result:=sr_1*ss+sr_2*cc;
        end;
      2:begin
          rr:=sqrt(sqr(x)+sqr(z));
          cc:=x/rr;
          ss:=z/rr;
          Result:=sr_1*ss+sr_2*cc;
        end;
      3:Result:=sr_3;
    end
  else Result:=0;
end;

{==============================================================================}
{                   Наследуемый класс кругового сектора                        }
{        TTriSec                                                               }
{==============================================================================}
constructor TTriSec.Create(m:int; nm:string);
begin
  inherited Create(m,nm);
end;

function TTriSec.IsPointInside(x,y,z:float):boolean;
const delta=1e-11;
var rr,phi:float;
    r_1,r_2,r_3:boolean;
    s1,s2,s3,ss:float;
  function Det(a1,a2,a3,b1,b2,b3,c1,c2,c3:float):float;
  begin
    Result:=0.5*Abs( a1*(b2*c3-b3*c2)+a2*(b3*c1-b1*c3)+a3*(b1*c2-b2*c1) );
  end;
begin
  rr:=sqrt(sqr(x)+sqr(y));
  phi:=ArcTng(x,y)/pi*180;
  s1:=Det(1,x1,z1,1,x2,z2,1,rr,z);
  s2:=Det(1,x1,z1,1,x3,z3,1,rr,z);
  s3:=Det(1,x2,z2,1,x3,z3,1,rr,z);
  ss:=Det(1,x1,z1,1,x2,z2,1,x3,z3);
  r_2:=(delta<=phi-al)and(delta<=bt-phi);
  r_1:=(Abs(ss-s1-s2-s3)<=delta);
  Result:=(r_1)and(r_2);
end;

procedure TTriSec.SetData(x_1,z_1,x_2,z_2,x_3,z_3, alpha,betta:float);
begin
  x1:=x_1; z1:=z_1;
  x2:=x_2; z2:=z_2;
  x3:=x_3; z3:=z_3;
  al:=alpha;
  bt:=betta;
end;

///////////////////////
function TTriSec.Ro(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriSec.Phi(x,y,z:float):float;
begin
  Result:=0;
end;

////////////////////////
function TTriSec.Jx(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriSec.Jy(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriSec.Jz(x,y,z:float):float;
begin
  Result:=0;
end;

////////////////////////
function TTriSec.Bx(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriSec.By(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriSec.Bz(x,y,z:float):float;
begin
  Result:=0;
end;

{==============================================================================}
{                   Наследуемый класс кругового сектора                        }
{        TTriBlock                                                               }
{==============================================================================}
constructor TTriBlock.Create(m:int; nm:string);
begin
  inherited Create(m,nm);
end;

function TTriBlock.IsPointInside(x,y,z:float):boolean;
const delta=1e-11;
var r_1,r_2:boolean;
    s1,s2,s3,ss:float;
  function Det(a1,a2,a3,b1,b2,b3,c1,c2,c3:float):float;
  begin
    Result:=0.5*Abs( a1*(b2*c3-b3*c2)+a2*(b3*c1-b1*c3)+a3*(b1*c2-b2*c1) );
  end;
begin
  s1:=Det(1,x1,z1,1,x2,z2,1,x,z);
  s2:=Det(1,x1,z1,1,x3,z3,1,x,z);
  s3:=Det(1,x2,z2,1,x3,z3,1,x,z);
  ss:=Det(1,x1,z1,1,x2,z2,1,x3,z3);
  r_2:=(delta<=y-y_min)and(delta<=y_max-y);
  r_1:=(Abs(ss-s1-s2-s3)<=delta);
  Result:=(r_1)and(r_2);
end;

procedure TTriBlock.SetData(x_1,z_1,x_2,z_2,x_3,z_3, y_1,y_2:float);
begin
  x1:=x_1; z1:=z_1;
  x2:=x_2; z2:=z_2;
  x3:=x_3; z3:=z_3;
  y_min:=y_1;
  y_max:=y_2;
end;

///////////////////////
function TTriBlock.Ro(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriBlock.Phi(x,y,z:float):float;
begin
  Result:=0;
end;

////////////////////////
function TTriBlock.Jx(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriBlock.Jy(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriBlock.Jz(x,y,z:float):float;
begin
  Result:=0;
end;

////////////////////////
function TTriBlock.Bx(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriBlock.By(x,y,z:float):float;
begin
  Result:=0;
end;

function TTriBlock.Bz(x,y,z:float):float;
begin
  Result:=0;
end;


{==============================================================================}
{======================   Конец реализации классов   ==========================}
{==============================================================================}
procedure SetDefaultParams;
begin
  ///////////////
  ps.wError2d:=1e-8;
  ps.wMIter2d:=400;
  ps.wSMeth2d:=0;
  //
  ps.wError3d:=1e-3;
  ps.wMIter3d:=100;
  ps.wSMeth3d:=0;
  //
  ps.wError_d:=1e-7;
  ps.wMIter_d:=100;
  ps.wSMeth_d:=0;
  //
  ps.wError_n:=1e-5;
  ps.wMIter_n:=10;
  ps.wSMeth_n:=0;
  ///////////////
end;

procedure ClearParams;
begin
  ///////////////
  ps.wError2d:=0;
  ps.wMIter2d:=0;
  ps.wSMeth2d:=0;
  //
  ps.wError3d:=0;
  ps.wMIter3d:=0;
  ps.wSMeth3d:=0;
  //
  ps.wError_d:=0;
  ps.wMIter_d:=0;
  ps.wSMeth_d:=0;
  //
  ps.wError_n:=0;
  ps.wMIter_n:=0;
  ps.wSMeth_n:=0;
  ///////////////
end;

end.

