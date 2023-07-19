unit solve2d;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, Gauges,
  ComCtrls;

type
  TfmSolver2 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Gauge1: TGauge;
    Chart1: TChart;
    Series1: TLineSeries;
    Button1: TButton;
    GroupBox6: TGroupBox;
    Label16: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Bevel5: TBevel;
    eFullError: TEdit;
    eNumIt: TEdit;
    eError: TEdit;
    eIter: TEdit;
    Button11: TButton;
    Label14: TLabel;
    eTime: TEdit;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    StartTime:TDateTime;
    TaskTime:TDateTime;
  public
    { Public declarations }
    procedure ShowTime;
  end;

var
  fmSolver2: TfmSolver2;

implementation

{$R *.dfm}
uses cmData, cmVars, pre_proc, common_main2d, el_main2d, ss_main2d, ec_main2d,
  complx,cmProc;

procedure TfmSolver2.ShowTime;
begin
  TaskTime:=Time-StartTime;
  eTime.Text:=TimeToStr(TaskTime);
  eTime.Refresh;
end;

procedure TfmSolver2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
  fmSolver2:=nil;
end;

procedure TfmSolver2.FormCreate(Sender: TObject);
begin
  eFullError.Text:=FloatToStrF(ps.wError2d,ffGeneral,6,3);
  eNumIt.Text:=IntToStr(ps.wMIter2d);
end;

procedure TfmSolver2.Button1Click(Sender: TObject);
var
  w1,w3:float;
  i,w2:int;
begin
  StartTime:=time;
  w1:=ps.wError2d;
  w2:=ps.wMIter2d;
{  w1:=StrToFloat(eFullError.Text);
  w2:=StrToInt(eNumIt.Text);}

  // starting solution
  tt.PrepareMatrix;
  tt.PrepareSolution;
  i:=0;
  repeat
    w3:=tt.MakeSolutionStep;
    i:=i+1;
    eIter.Text:=IntToStr(i);
    eIter.Refresh;
    eError.Text:=FloatToStrF(w3,ffGeneral,10,1);
    eError.Refresh;
    Series1.AddXY(i,w3);
    Chart1.Refresh;
  until (i>=w2)or(w3<w1);
  Button11.Enabled:=true;
  // finish solution
  ShowTime;
  if wAuto_CloseS then close;
end;

procedure TfmSolver2.Button11Click(Sender: TObject);
var w2,i0,i:int;
    w3:double;
begin
  StartTime:=Time;
  w2:=StrToInt(eNumIt.Text);
  i0:=StrToInt(eIter.Text);;
  i:=i0;
  repeat
    w3:=tt.MakeSolutionStep;
    i:=i+1;
    eIter.Text:=IntToStr(i);
    eIter.Refresh;
    eError.Text:=FloatToStrF(w3,ffGeneral,10,1);
    eError.Refresh;
    Series1.AddXY(i,w3);
    Chart1.Refresh;
  until i>=w2+i0;
end;

procedure TfmSolver2.Button2Click(Sender: TObject);
begin
  StartTime:=Time;
  Series1.Clear;
  // reassign main class variable
  mt.GenerateAllProperties(Task);
  fmPreprocessor.TabSheet6Show(self);
  tt.ReleaseVars();
  tt.Free;
  Case Task of
    0..2:tt:=TFlatELTask.Create;
    3:tt:=TFlatSSTask.Create;
    5:tt:=TFlatECTask.Create;
  end;
  tt.SetShower(Gauge1,Label1,GroupBox1);
  fmPreprocessor.TabSheet6Exit(self);
  // prepare to solution
  tt.GenerateNodes();
  tt.GenerateTopology();
  tt.GenerateTopMat();
  tt.GenerateSources();
  tt.GenerateBounds(bnd2,Nbnd2);
  ShowTime;
end;

procedure TfmSolver2.FormActivate(Sender: TObject);
begin
  if wAuto_StartS then
  begin
    Button2Click(self);
    Button1Click(self);
  end;
end;

end.

