unit solvenl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls,
  Grids;

type
  TfmSolveNl = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Chart1: TChart;
    Series1: TLineSeries;
    Chart2: TChart;
    Series2: TLineSeries;
    Series3: TPointSeries;
    Button3: TButton;
    TabSheet3: TTabSheet;
    sg: TStringGrid;
    Series4: TLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSolveNl: TfmSolveNl;

implementation

uses cmData, cmVars, common_main2d, el_main2d, ss_main2d, cm_ini, pre_proc,
  main;

{$R *.dfm}

procedure TfmSolveNl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmSolveNl.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmSolveNl.Button1Click(Sender: TObject);
var i,j,k:int;
    h1:array of float;
    e0,err,w3:float;
    k1:int;
    v1,v2:float;
    a,b,c:mxtyp2;
    rav,ar:float;
begin
//  fmMain.HideItemClick(Self);

  Series1.Clear;
  mt.GenerateAllProperties(Task);
  fmPreprocessor.TabSheet6Show(Application);
  fmPreprocessor.TabSheet6Exit(application);
  tt.nds:=false;
  tt.SetShower(nil,nil,nil);
  ///////////////////////////
  Hm:=nil;
  H1:=nil;
  SetLength(H1,tt.NTriangles+1);
  SetLength(Hm,tt.NTriangles+1);
  k:=0;
  e0:=1;
  repeat
    // remember previous step
    for i:=1 to tt.NTriangles do h1[i]:=Hm[i];
    // starting solution
    tt.GenerateNodes();
    tt.GenerateTopology();
    tt.GenerateBounds(bnd2,Nbnd2);
    tt.GenerateTopMat();
    tt.GenerateSources();
    tt.PrepareMatrix;
    tt.PrepareSolution;
    j:=0;
    repeat
      w3:=tt.MakeSolutionStep;
      j:=j+1;
    until (j>=ps.wMIter2d)or(w3<ps.wError2d);
    // define H distribution
    for i:=1 to tt.NTriangles do
    begin
      tt.ElementMatrix(i,ar,rav,a,b,c);
      // FluxDensity X and Z
      v1:=0;
      v2:=0;
      if Task=2 then
        for k1:=1 to 3 do
        begin
          v1:=v1-b[k1]*TFlatELTask(tt).vMatr[tt.Topology[i,k1]];
          v2:=v2-c[k1]*TFlatELTask(tt).vMatr[tt.Topology[i,k1]];
        end
      else
        for k1:=1 to 3 do
        begin
          v1:=v1-c[k1]*TFlatSSTask(tt).vMatr[tt.Topology[i,k1]];
          v2:=v2+b[k1]*TFlatSSTask(tt).vMatr[tt.Topology[i,k1]];
        end;
      v1:=v1/2/ar;
      v2:=v2/2/ar;
      Hm[i]:=sqrt(sqr(v1)+sqr(v2));
    end;
    // calculate error
    err:=0;
    for i:=1 to tt.NTriangles do
      err:=err+Abs(h1[i]-hm[i]);
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
    if task=2 then
    begin
      Series3.XValues[0]:=Hm[200];
      Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    end
    else
    begin
      Series3.YValues[0]:=Hm[200];
      Series3.XValues[0]:=Hm[200]*mt.Prop(200,1);
//      Series3.YValues[0]:=Hm[5640];
//      Series3.XValues[0]:=Hm[5640]*mt.Prop(5640,2);
    end;
    Chart2.Refresh;
  //  sleep(1000);
  until (err<ps.wError_n)or(k>=ps.wMIter_n);

//  Hm:=nil;
  H1:=nil;

//  fmMain.RestoreItemClick(Self);
end;

procedure TfmSolveNl.FormCreate(Sender: TObject);
var i:int;
    mm:int;
begin
  PageControl1.ActivePageIndex:=0;
  mm:=1;
  Series3.Clear;
  Series3.AddXY(0,0);
//  Series2.Clear;
//  for i:=1 to mt.nm[mm] do Series2.AddXY(mt.HH[mm][i],mt.BB[mm][i]);
  Series4.Clear;
  if task=2 then
    for i:=1 to mt.nm[mm] do Series4.AddXY(mt.HH[mm][i],mt.GetBH(mt.HH[mm][i],mm))
  else
    for i:=1 to mt.nm[mm] do Series4.AddXY(mt.GetBH(mt.BB[mm][i],mm),mt.BB[mm][i]);
end;

procedure TfmSolveNl.Button3Click(Sender: TObject);
var i,j,k:int;
    h1:array of float;
    e0,err,w3:float;
    k1:int;
    v1,v2:float;
    a,b,c:mxtyp2;
    rav,ar:float;
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
      nol[i]:=false;}
//  fmMain.HideItemClick(Self);
  Series1.Clear;
  mt.GenerateAllProperties(Task);
  fmPreprocessor.TabSheet6Show(Application);
  fmPreprocessor.TabSheet6Exit(application);
  tt.nds:=false;
  tt.SetShower(nil,nil,nil);
  ///////////////////////////
  Hm:=nil;
  H1:=nil;
  SetLength(H1,tt.NTriangles+1);
  SetLength(Hm,tt.NTriangles+1);
  SetLength(vm,tt.NTriangles+1);
  k:=0;
  e0:=1;
  repeat
    // remember previous step
    for i:=1 to tt.NTriangles do h1[i]:=Hm[i];
    // starting solution
    tt.GenerateNodes();
    tt.GenerateTopology();
    tt.GenerateBounds(bnd2,Nbnd2);
    tt.GenerateTopMat();
    tt.GenerateSources();
    tt.PrepareMatrix;
    tt.PrepareSolution;
    j:=0;
    repeat
      w3:=tt.MakeSolutionStep;
      j:=j+1;
    until (j>=ps.wMIter2d)or(w3<ps.wError2d);
    // define H distribution
    for i:=1 to tt.NTriangles do
    begin
      tt.ElementMatrix(i,ar,rav,a,b,c);
      // FluxDensity X and Z
      v1:=0;
      v2:=0;
      if Task=2 then
        for k1:=1 to 3 do
        begin
          v1:=v1-b[k1]*TFlatELTask(tt).vMatr[tt.Topology[i,k1]];
          v2:=v2-c[k1]*TFlatELTask(tt).vMatr[tt.Topology[i,k1]];
        end
      else
        for k1:=1 to 3 do
        begin
          v1:=v1-c[k1]*TFlatSSTask(tt).vMatr[tt.Topology[i,k1]];
          v2:=v2+b[k1]*TFlatSSTask(tt).vMatr[tt.Topology[i,k1]];
        end;
      v1:=v1/2/ar;
      v2:=v2/2/ar;
      Hm[i]:=sqrt(sqr(v1)+sqr(v2));
    end;
    // calculate error
    err:=0;
    for i:=1 to tt.NTriangles do
      err:=err+Abs(h1[i]-hm[i]);
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
    if task=2 then
    begin
      Series3.XValues[0]:=Hm[200];
      Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    end
    else
    begin
      Series3.YValues[0]:=Hm[200];
      Series3.XValues[0]:=Hm[200]*mt.Prop(200,1);
    end;
    Chart2.Refresh;
//    sleep(1000);
  until (k>=2);
{  for i:=0 to mt.NMaterials-1 do
    if nol[i] then mt.nlProperty[i]:=1;}
  if Task=2
  then SetLength(TFlatELTask(tt).vMatr,tt.NNodes+1)
  else SetLength(TFlatSSTask(tt).vMatr,tt.NNodes+1);
   // Newton-Raphson
  repeat
    // remember previous step
    for i:=1 to tt.NTriangles do h1[i]:=Hm[i];
    if Task=2
    then for i:=1 to tt.NNodes do vm[i]:=TFlatELTask(tt).vMatr[i]
    else for i:=1 to tt.NNodes do vm[i]:=TFlatSSTask(tt).vMatr[i];
    // starting solution
    tt.GenerateNodes();
    tt.GenerateTopology();
    tt.GenerateBounds(bnd2,Nbnd2);
    tt.GenerateTopMat();
    tt.GenerateSources();
    tt.CreateNLMatrix;
    tt.PrepareSolution;
    j:=0;
    repeat
      w3:=tt.MakeSolutionStep;
      j:=j+1;
    until (j>=ps.wMIter2d)or(w3<ps.wError2d);
    // define H distribution
    if Task=2
    then for i:=1 to tt.NNodes do TFlatELTask(tt).vMatr[i]:=TFlatELTask(tt).vMatr[i]+vm[i]
    else for i:=1 to tt.NNodes do TFlatSSTask(tt).vMatr[i]:=TFlatSSTask(tt).vMatr[i]+vm[i];
    for i:=1 to tt.NTriangles do
    begin
      tt.ElementMatrix(i,ar,rav,a,b,c);
      // FluxDensity X and Z
      v1:=0;
      v2:=0;
      if Task=2 then
        for k1:=1 to 3 do
        begin
          v1:=v1-b[k1]*TFlatELTask(tt).vMatr[tt.Topology[i,k1]];
          v2:=v2-c[k1]*TFlatELTask(tt).vMatr[tt.Topology[i,k1]];
        end
      else
        for k1:=1 to 3 do
        begin
          v1:=v1-c[k1]*TFlatSSTask(tt).vMatr[tt.Topology[i,k1]];
          v2:=v2+b[k1]*TFlatSSTask(tt).vMatr[tt.Topology[i,k1]];
        end;
      v1:=v1/2/ar;
      v2:=v2/2/ar;
      Hm[i]:=sqrt(sqr(v1)+sqr(v2));
    end;
    // calculate error
    err:=0;
    for i:=1 to tt.NTriangles do
      err:=err+Abs(h1[i]-hm[i]);
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
    if task=2 then
    begin
      Series3.XValues[0]:=Hm[200];
      Series3.YValues[0]:=Hm[200]*mt.Prop(200,1);
    end
    else
    begin
      Series3.YValues[0]:=Hm[200];
      Series3.XValues[0]:=Hm[200]*mt.Prop(200,1);
    end;           
    Chart2.Refresh;
//    sleep(1000);
  until (err<ps.wError_n)or(k>=ps.wMIter_n);
  H1:=nil;
  vm:=nil;
//  fmMain.RestoreItemClick(Self);
end;

end.
