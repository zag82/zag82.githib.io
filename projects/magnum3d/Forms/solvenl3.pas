unit solvenl3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, ExtCtrls, TeeProcs, Chart, ComCtrls, StdCtrls,
  Spin;

type
  TfmNonLine3 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Chart1: TChart;
    Chart2: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TPointSeries;
    Button3: TButton;
    Series4: TLineSeries;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNonLine3: TfmNonLine3;

implementation

uses cm_ini, cmData, pre_proc, cmVars, ax_add, nonline2d,
  Compute_VectorsUnit, ComVars;

{$R *.dfm}

procedure TfmNonLine3.FormCreate(Sender: TObject);
var i:int;
    mm:int;
begin
  if Task=2 then
  begin
    Button1.Enabled:=true;
    Button3.Enabled:=false;
  end
  else
  begin
    Button1.Enabled:=false;
    Button3.Enabled:=true;
  end;
  PageControl1.ActivePageIndex:=0;
  mm:=1;
  Series3.Clear;
  Series3.AddXY(0,0);
  Series2.Clear;
  for i:=1 to mt.nm[mm] do
    Series2.AddXY(mt.HH[mm][i],mt.BB[mm][i]);
  Series4.Clear;
  if task=2 then
    for i:=1 to mt.nm[mm] do Series4.AddXY(mt.HH[mm][i],mt.GetBH(mt.HH[mm][i],mm))
  else
    for i:=1 to mt.nm[mm] do Series4.AddXY(mt.GetBH(mt.BB[mm][i],mm),mt.BB[mm][i]);
  Edit3.Text:=FloatToStrF(mt.a[mm],ffFixed,6,4);
  Edit4.Text:=FloatToStrF(mt.b[mm],ffFixed,6,4);
end;

procedure TfmNonLine3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmNonLine3:=nil;
end;

procedure TfmNonLine3.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmNonLine3.Button1Click(Sender: TObject);
var i,j,k:int;
    h1:array of float;
    e0,err,w3:float;
    k1:int;
    v1,v2:float;
    a,b,c:mxtyp2;
    rav,ar:float;
    nl3:TSolutionNL;
    v3:TSolution3d;
    nol:array of boolean;
begin
{  SetLength(nol,mt.NMaterials);
  for i:=0 to mt.NMaterials-1 do
    if mt.nlProperty[i]=1 then
    begin
      mt.nlProperty[i]:=0;
      nol[i]:=true;
    end
    else
      nol[i]:=false;   }
//  fmMain.HideItemClick(Self);
  Series1.Clear;
  mt.GenerateAllProperties(Task);
  Button4Click(Self);
  fmPreprocessor.TabSheet6Show(Application);
  fmPreprocessor.TabSheet6Exit(application);
  axa.nds:=false;
  axa.SetShower(nil,nil,nil);
  ///////////////////////////
  Hm:=nil;
  H1:=nil;
  axa.GenerateNodes(1,1);
  axa.GenerateTopology;
  SetLength(H1,NElements+1);
  SetLength(Hm,NElements+1);
  SetLength(vm,NElements+1);
  k:=0;
  e0:=1;
  repeat
    // remember previous step
    for i:=1 to NElements do h1[i]:=Hm[i];
    // starting solution
    axa.GenerateNodes(1,1);
    axa.GenerateTopology;
    axa.GenerateBounds(bnd3,NBnd3);
    axa.GenerateTopMat;
    axa.GenerateSources;
    v3:=TSolution3d.Create(false);
    v3.CreateMatrix;
    w3:=v3.RunSolution(ps.wError3d,ps.wMIter3d);
    a_LoadResults(Task,0);
    // define H distribution
    for i:=1 to NElements do
    begin
      Compute_Vectors(i);
      Hm[i]:=sqrt(sqr(HIntensity_X)+sqr(HIntensity_Y)+sqr(HIntensity_Z));
    end;
    // calculate error
    err:=0;
    for i:=1 to NElements do err:=err+Abs(h1[i]-hm[i]);
    // next step
    inc(k);
    if k=1 then e0:=err;
    err:=err/e0;
    Series1.AddXY(k,err);
    Chart1.Refresh;
    Edit1.Text:=IntToStr(k);
    Edit1.Refresh;
    Edit2.Text:=FloatToStrF(err,ffGeneral,10,1);
    Edit2.Refresh;
    ////
    Series3.XValues[0]:=Hm[200];
    Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    ////
    Chart2.Refresh;
//    sleep(1000);
  until (err<ps.wError_n)or(k>=ps.wMIter_n);
//  until (k>=4);
  v3.Free;
//  for i:=0 to mt.NMaterials-1 do
//    if nol[i] then mt.nlProperty[i]:=1;
  // Newton-Raphson
{  repeat
    // remember previous step
    for i:=1 to tt.NTriangles do h1[i]:=Hm[i];
    for i:=1 to NPoints do vm[i]:=ResultSc[i];
    // starting solution
    axa.GenerateNodes(1,1);
    axa.GenerateTopology;
    axa.GenerateBounds(bnd3,NBnd3);
    axa.GenerateTopMat;
    axa.GenerateSources;
    nl3:=TSolutionNL.Create;
    nl3.CreateMatrix;
    w3:=nl3.RunSolution(ps.wError_d,ps.wMIter_d);
    a_LoadResults(Task,0);
    // define H distribution
    for i:=1 to NPoints do ResultSc[i]:=ResultSc[i]+vm[i];
    for i:=1 to NElements do
    begin
      Compute_Vectors(i);
      Hm[i]:=sqrt(sqr(HIntensity_X)+sqr(HIntensity_Y)+sqr(HIntensity_Z));
    end;
    // calculate error
    err:=0;
    for i:=1 to NElements do err:=err+Abs(h1[i]-hm[i]);
    // next step
    inc(k);
    if k=1 then e0:=err;
    err:=err/e0;
    Series1.AddXY(k,err);
    Chart1.Refresh;
    Edit1.Text:=IntToStr(k);
    Edit1.Refresh;
    Edit2.Text:=FloatToStrF(err,ffGeneral,10,1);
    Edit2.Refresh;
    ////
    Series3.XValues[0]:=Hm[200];
    Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    ////
    Chart2.Refresh;
//    sleep(1000);
  until (err<ps.wError_n)or(k>=ps.wMIter_n);         }
  a_SaveDataFile('sresult.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));
  H1:=nil;
  vm:=nil;
//  fmMain.RestoreItemClick(Self);
end;

procedure TfmNonLine3.Button3Click(Sender: TObject);
var i,j,k:int;
    h1:array of float;
    e0,err,w3:float;
    k1:int;
    v1,v2:float;
    a,b,c:mxtyp2;
    rav,ar:float;
    nl3:TSolutionNL;
    v3:TSolution3d;
begin
//  fmMain.HideItemClick(Self);
  Series1.Clear;
  mt.GenerateAllProperties(Task);
  Button4Click(Self);
  fmPreprocessor.TabSheet6Show(Application);
  fmPreprocessor.TabSheet6Exit(application);
  axa.nds:=false;
  axa.SetShower(nil,nil,nil);
  ///////////////////////////
  Hm:=nil;
  H1:=nil;
  SetLength(H1,NElements+1);
  SetLength(Hm,NElements+1);
  SetLength(vmx,NElements+1);
  SetLength(vmy,NElements+1);
  SetLength(vmz,NElements+1);
  k:=0;
  e0:=1;
  repeat
    // remember previous step
    for i:=1 to NElements do h1[i]:=Hm[i];
    // starting solution
    axa.GenerateNodes(1,1);
    axa.GenerateTopology;
    axa.GenerateBounds(bnd3,NBnd3);
    axa.GenerateTopMat;
    axa.GenerateSources;
    v3:=TSolution3d.Create(false);
    v3.CreateAllMatrixRE;
    w3:=v3.RunSolutionRE(ps.wError3d,ps.wMIter3d);
    a_LoadResults(Task,0);
    // define H distribution
    for i:=1 to NElements do
    begin
      Compute_RealVectors(i);
      Hm[i]:=sqrt(sqr(FluxDensity_X)+sqr(FluxDensity_Y)+sqr(FluxDensity_Z));
    end;
    // calculate error
    err:=0;
    for i:=1 to NElements do err:=err+Abs(h1[i]-hm[i]);
    // next step
    inc(k);
    if k=1 then e0:=err;
    err:=err/e0;
    Series1.AddXY(k,err);
    Chart1.Refresh;
    Edit1.Text:=IntToStr(k);
    Edit1.Refresh;
    Edit2.Text:=FloatToStrF(err,ffGeneral,10,1);
    Edit2.Refresh;
    ////
    Series3.XValues[0]:=Hm[200];
    Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    ////
    Chart2.Refresh;
//    sleep(1000);
  until (k>=2);
  v3.Free;
  SetLength(Result_X,NPoints+1);
  SetLength(Result_Y,NPoints+1);
  SetLength(Result_Z,NPoints+1);
  // Newton-Raphson
  repeat
    // remember previous step
    for i:=1 to NElements do h1[i]:=Hm[i];
    for i:=1 to NPoints do
    begin
     vmx[i]:=Result_X[i];
     vmy[i]:=Result_Y[i];
     vmz[i]:=Result_Z[i];
    end;
    // starting solution
    axa.GenerateNodes(1,1);
    axa.GenerateTopology;
    axa.GenerateBounds(bnd3,NBnd3);
    axa.GenerateTopMat;
    axa.GenerateSources;
    nl3:=TSolutionNL.Create;
    nl3.CreateAllMatrixRE;
    w3:=nl3.RunSolutionRE(ps.wError3d,ps.wMIter3d);
    a_LoadResults(Task,0);
    // define H distribution
    for i:=1 to NPoints do
    begin
     Result_X[i]:=Result_X[i]+vmx[i];
     Result_Y[i]:=Result_Y[i]+vmy[i];
     Result_Z[i]:=Result_Z[i]+vmz[i];
    end;
    for i:=1 to NElements do
    begin
      Compute_RealVectors(i);
      Hm[i]:=sqrt(sqr(FluxDensity_X)+sqr(FluxDensity_Y)+sqr(FluxDensity_Z));
    end;
    // calculate error
    err:=0;
    for i:=1 to NElements do err:=err+Abs(h1[i]-hm[i]);
    // next step
    inc(k);
    if k=1 then e0:=err;
    err:=err/e0;
    Series1.AddXY(k,err);
    Chart1.Refresh;
    Edit1.Text:=IntToStr(k);
    Edit1.Refresh;
    Edit2.Text:=FloatToStrF(err,ffGeneral,10,1);
    Edit2.Refresh;
    ////
    Series3.XValues[0]:=Hm[200];
    Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    ////
    Chart2.Refresh;
//    sleep(1000);
  until (err<ps.wError_n)or(k>=ps.wMIter_n);
  H1:=nil;
  vmx:=nil;
  vmy:=nil;
  vmz:=nil;
//  fmMain.RestoreItemClick(Self);
end;

procedure TfmNonLine3.Button4Click(Sender: TObject);
var i:int;
    mm:int;
begin
  mm:=1;
  mt.a[mm]:=StrToFloat(Edit3.Text);
  mt.b[mm]:=StrToFloat(Edit4.Text);
  Series4.Clear;
  if task=2 then
    for i:=1 to mt.nm[mm] do Series4.AddXY(mt.HH[mm][i],mt.GetBH(mt.HH[mm][i],mm))
  else
    for i:=1 to mt.nm[mm] do Series4.AddXY(mt.GetBH(mt.BB[mm][i],mm),mt.BB[mm][i]);
end;

end.
