unit solve3d;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, Gauges,
  ComCtrls, Spin;

type
  TfmSolver3d = class(TForm)
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
    ggb: TGroupBox;
    lb: TLabel;
    gg: TGauge;
    Label14: TLabel;
    Button1: TButton;
    eTime: TEdit;
    Button2: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    ComboBox1: TComboBox;
    se2: TSpinEdit;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    StartTime:TDateTime;
    TaskTime:TDateTime;
  public
    { Public declarations }
    procedure ShowTime;
  end;

var
  fmSolver3d: TfmSolver3d;

implementation

{$R *.dfm}
uses cmData, cmVars, pre_proc, common_main2d, el_main2d, ss_main2d, ec_main2d,
  ax_add, comvars, complx, solve_thread, cmProc;

procedure TfmSolver3d.ShowTime;
begin
  TaskTime:=Time-StartTime;
  eTime.Text:=TimeToStr(TaskTime);
  eTime.Refresh;
end;


procedure TfmSolver3d.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
  fmSolver3d:=nil;
end;

procedure TfmSolver3d.FormCreate(Sender: TObject);
begin
  se2.MinValue:=0;
  se2.MaxValue:=mt.nMaterials-1;
  se2.Value:=0;
  eFullError.Text:=FloatToStrF(ps.wError3d,ffGeneral,6,3);
  eNumIt.Text:=IntToStr(ps.wMIter3d);
end;

procedure TfmSolver3d.Button2Click(Sender: TObject);
begin
  StartTime:=Time;
  Series1.Clear;
  // reassign main class variable
  mt.GenerateAllProperties(Task);
  expa:=TExpansionClass.Create();
  expa.SetShower(GG,LB,GGB);
  axa.SetShower(GG,Lb,GGB);
  axa.PrepareData;
  // prepare to solution
  axa.GenerateNodes(1,1);
  ShowTime;
  axa.GenerateTopology();
  ShowTime;
  axa.GenerateTopMat();
  ShowTime;
  axa.GenerateSources;
  ShowTime;
  axa.GenerateBounds(bnd3,Nbnd3);
  ShowTime;
  if ComboBox1.ItemIndex=1 then
  begin
    Case Task of
      0..2:expa.ExpandSolutionEL;
      3:expa.ExpandSolutionRE;
      5:expa.ExpandSolutionEC;
    end;
    a_LoadResults(Task,0);
  end;
  expa.Free;
  if wSaveTop then
  begin
    a_SaveDataFile('coordx.dat',Crd_X[0],(NPoints+1)*SizeOf(Crd_x[0]));
    a_SaveDataFile('coordy.dat',Crd_Y[0],(NPoints+1)*SizeOf(Crd_y[0]));
    a_SaveDataFile('coordz.dat',Crd_Z[0],(NPoints+1)*SizeOf(Crd_z[0]));
    a_SaveDataFile('topology.dat',ATopology[0],(NElements+1)*SizeOf(ATopology[0]));
  end;
end;

procedure TfmSolver3d.Button1Click(Sender: TObject);
var
  w1,w3:float;
  w2,m,k:int;
  df:TApproximateSolution;
  vol3:TSolution3d;
begin
  StartTime:=Time;
  m:=se2.Value;
  w1:=StrToFloat(eFullError.Text);
  w2:=StrToInt(eNumIt.Text);
  w3:=0;
  k:=Combobox1.ItemIndex;
  if k=1 then
  begin
    { Solution }
    df:=TApproximateSolution.Create(true);
    df.SetShower(GG,LB,GGB,Chart1,Series1);
    Case Task of
      0:begin
          df.PrepareData(m);
          df.CreateMatrix;
          w3:=df.RunSolution(w1,w2);
        end;
      3:begin
          df.PrepareDataRE(m);
          df.CreateAllMatrixRE(m);
          w3:=df.RunSolutionRE(w1,w2);
        end;
      5:begin
          df.PrepareDataEC(m);
          df.CreateAllMatrixEC(m);
          w3:=df.RunSolutionEC(w1,w2);
        end;
    end;
    df.Free;
    a_LoadResults(Task,2);
  end
  else
  begin
    vol3:=TSolution3d.Create(true);
    vol3.SetShower(GG,LB,GGB,Chart1,Series1);
    Case Task of
      0..2:begin
          vol3.CreateMatrix();
          w3:=vol3.RunSolution(w1,w2);
        end;
      3:begin
          vol3.CreateAllMatrixRe;
          w3:=vol3.RunSolutionRE(w1,w2);
        end;
      5:begin
          vol3.CreateAllMatrixEC;
          w3:=vol3.RunSolutionEC(w1,w2);
        end;
    end;
    vol3.Free;
    a_LoadResults(Task,0);
  end;
  { Display results }
  eError.Text:=FloatToStrF(w3,ffGeneral,10,1);
  eError.Refresh;
  ShowTime;
  //Button11.Enabled:=true;
  // finish solution
end;

procedure TfmSolver3d.ComboBox1Change(Sender: TObject);
begin
  se2.Visible:=(ComboBox1.ItemIndex=1);
  label1.Visible:=se2.Visible;
end;

end.
