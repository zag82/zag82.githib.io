unit control_ec;

interface

uses cm_ini, main,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TeeProcs, TeEngine, Chart, ExtCtrls, StdCtrls, Buttons, CheckLst,
  ComCtrls, Gauges, Series;

type
  TOldObject=record
    nm:string;
    num:int;
    k:byte; // sort of object ( block or sector )
    z1,z2,z3:float;
  end;

  TfmControlCenterEC = class(TForm)
    Panel1: TPanel;
    Chart1: TChart;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Bevel1: TBevel;
    Series1: TLineSeries;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    CheckListBox1: TCheckListBox;
    ComboBox3: TComboBox;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Gauge1: TGauge;
    SpeedButton3: TSpeedButton;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Label13: TLabel;
    Label14: TLabel;
    Button3: TButton;
    Label15: TLabel;
    Label16: TLabel;
    ComboBox4: TComboBox;
    Label17: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GageCount:int;
    Gage:array of TOldObject;
    StepCount:int;
    s_pos:array of float;    // positions of gage
    sg2d:array of TComplex;  // axial solution
    sg3d:array of TComplex;  // volume solution
    sg_f:array of TComplex;  // full solution
    sg_d:array of TComplex;  // defect solution
    procedure aPreView;
    procedure aStoreSignals;
    procedure SaveGod;
  end;

var
  fmControlCenterEC: TfmControlCenterEC;

implementation

{$R *.dfm}
uses
  cmVars, cmData, pre_proc, common_main2d, ec_main2d, cmProc, ComPlx, ax_add,
  solve_Thread, comVars, ss_main2d;

procedure TfmControlCenterEC.SaveGod;
var f:TextFile;
    i:integer;
    vv:TComplex;
begin
  if StepCount<>0 then
  begin
//    vv:=CDConv(4.993465E-0003,3.597519E-0002);
    vv:=CNull;
    for i:=1 to StepCount do sg2d[i]:=CSub(sg2d[i],vv);
    AssignFile(f,'godographEC.txt');
    Rewrite(f);
    writeln(f,StepCount);
    for i:=1 to StepCount do
      writeln(f,1e6/14.56*sg2d[i].re:15,#09,1e6/14.56*sg2d[i].im:15);
    CloseFile(f);
  end;
end;

procedure TfmControlCenterEC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  fmControlCenterEC:=nil;
end;

procedure TfmControlCenterEC.Button2Click(Sender: TObject);
begin
  // releasing variables
  Gage:=nil;
  s_pos:=nil;
  sg2d:=nil;
  sg3d:=nil;
  sg_f:=nil;
  sg_d:=nil;
  // close form method
  Close;
end;

procedure TfmControlCenterEC.FormCreate(Sender: TObject);
var i:int;
begin
  s_pos:=nil;
  sg2d:=nil;
  sg3d:=nil;
  sg_f:=nil;
  sg_d:=nil;
  PageControl1.ActivePageIndex:=0;
  for i:=0 to ob.Count-1 do ComboBox4.Items.Add(TMgObject(ob.Items[i]).Name);
  for i:=0 to ob.Count-1 do ListBox2.Items.Add(TMgObject(ob.Items[i]).Name);
  for i:=0 to mt.nMaterials-1 do ComboBox1.Items.Add(IntToStr(i)+' - '+mt.mmName[i]);
  ComboBox1.ItemIndex:=0;
  ComboBox4.ItemIndex:=0;
  ActiveControl:=ListBox1;
end;

procedure TfmControlCenterEC.Button1Click(Sender: TObject);
var
  ddf,ddf2:int;
  mm,k:int;  // material and task
  i,j,e:int;
  w3:float;
  pos1,pos2,sp:float; // positions of gage
  vl3:TSolution3d;
  df:TApproximateSolution;
  rr:float;
  rm:int;
  secs:array of int;
  sTime:TDateTime;
  ccl:int;
  f:TextFile;
begin
  fmMain.HideItemClick(Self);

  ccl:=ComboBox4.ItemIndex;
  sTime:=Time;

  Chart1.LeftAxis.Logarithmic:=true;

  ddf:=axa.defMat;

  PageControl1.ActivePageIndex:=0;
  Series1.Active:=true;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  Gage:=nil;
  mm:=ComboBox1.ItemIndex;
  k:=ComboBox2.ItemIndex+1;
  // gage positions
  pos1:=StrToFloat(Edit1.Text)/1000;
  pos2:=StrToFloat(Edit2.Text)/1000;
  sp:=StrToFloat(Edit3.Text)/1000;
  StepCount:=Round((pos2-pos1)/sp)+1;
  // signal arrays
  SetLength(s_pos,StepCount+1);
  SetLength(sg2d,StepCount+1);
  SetLength(sg3d,StepCount+1);
  SetLength(sg_d,StepCount+1);
  SetLength(sg_f,StepCount+1);
  // gage paramters
  GageCount:=ListBox1.Items.Count;
  SetLength(Gage,GageCount);
  // filling
  for i:=0 to GageCount-1 do
  begin
    e:=0;
    for j:=0 to ob.Count-1 do
      if TMgObject(ob.Items[j]).Name=ListBox1.Items[i] then
        e:=j;
    gage[i].nm:=ListBox1.Items[i];
    gage[i].num:=e;
    if TMgObject(ob.Items[e])is TBlock then
    begin
      gage[i].k:=1;
      gage[i].z1:=TBlock(ob.Items[e]).z_1;
      gage[i].z2:=TBlock(ob.Items[e]).z_2;
    end
    else if TMgObject(ob.Items[e])is TSector then
    begin
      gage[i].k:=2;
      gage[i].z1:=TSector(ob.Items[e]).zz;
      gage[i].z2:=0.0;
    end
    else if TMgObject(ob.Items[e])is TTriSec then
    begin
      gage[i].k:=4;
      gage[i].z1:=TTriSec(ob.Items[e]).z1;
      gage[i].z2:=TTriSec(ob.Items[e]).z2;
      gage[i].z3:=TTriSec(ob.Items[e]).z3;
    end;
  end;
{  AssignFile(f,'signal.log');
  Rewrite(f);
  writeln(f,'Starting calculations');
  writeln(f);
  CloseFile(f);}

  // main loop
  for i:=1 to StepCount do
  begin
    // new position
    for j:=0 to GageCount-1 do
      if gage[j].k=1 then //block
      begin
        TBlock(ob.Items[gage[j].num]).z_1:=gage[j].z1+pos1+(i-1)*sp;
        TBlock(ob.Items[gage[j].num]).z_2:=gage[j].z2+pos1+(i-1)*sp;
      end
      else if gage[j].k=2 then // sector
      begin
        TSector(ob.Items[gage[j].num]).zz:=gage[j].z1+pos1+(i-1)*sp;
      end
      else if gage[j].k=4 then
      begin
        TTriSec(ob.Items[gage[j].num]).z1:=gage[j].z1+pos1+(i-1)*sp;
        TTriSec(ob.Items[gage[j].num]).z2:=gage[j].z2+pos1+(i-1)*sp;
        TTriSec(ob.Items[gage[j].num]).z3:=gage[j].z3+pos1+(i-1)*sp;
      end;
    // process view
    s_pos[i]:=pos1+(i-1)*sp;
    Label14.Caption:=FloatToStrF(1e3*s_pos[i],ffFixed,6,3);
    GroupBox3.Refresh;
    // operations
    Case k of
      1:begin // 2d signal
          Series1.Clear;
          ddf2:=tt.defMat;
          // reassign main class variable
          mt.GenerateAllProperties(Task);
          fmPreprocessor.TabSheet6Show(self);
          tt.ReleaseVars();
          tt.Free;
          tt:=TFlatECTask.Create;
          tt.SetShower(Gauge1,Label12,GroupBox3);
          fmPreprocessor.TabSheet6Exit(self);
          // prepare to solution
          tt.GenerateNodes();
          tt.GenerateTopology();
          tt.GenerateBounds(bnd2,Nbnd2);
          // define solution arrays
          tt.GenerateTopMat();
          tt.GenerateSources();
          // starting solution
          tt.PrepareMatrix;
          tt.PrepareSolution;
          j:=0;
          repeat
            w3:=tt.MakeSolutionStep;
            j:=j+1;
            Series1.AddXY(j,w3);
            Chart1.Refresh;
          until (j>=ps.wMIter2d)or(w3<ps.wError2d);
          ///////////////////////////////////////
          with TSector(ob.Items[ccl])do
          begin
            rm:=iMaterial;
            rr:=(r1+r2)/2;
          end;
          sg2d[i]:=GetSignal_Axial_2(rm,rr);
          rm:=rm+1;
          sg_d[i]:=GetSignal_Axial_2(rm,rr);
          //sg2d[i]:=CSub(sg2d[i],sg_d[i]);
          sg_d[i]:=CNull;
        end;
      2:begin // 2d+3d defect
          Series1.Clear;
          if i=1 then
          begin
            // reassign main class variable
            mt.GenerateAllProperties(Task);
            fmPreprocessor.TabSheet6Show(self);
            tt.ReleaseVars();
            tt.Free;
            tt:=TFlatECTask.Create;
            tt.SetShower(Gauge1,Label12,GroupBox3);
            axa.SetShower(Gauge1,Label12,GroupBox3);
            fmPreprocessor.TabSheet6Exit(self);
            // prepare to solution
            tt.GenerateNodes();
            tt.GenerateTopology();
            tt.GenerateBounds(bnd2,Nbnd2);
            ///////////////
            axa.PrepareData;
            axa.GenerateNodes(1,1);
            axa.GenerateTopology();
            axa.GenerateBounds(bnd3,Nbnd3);
          end;
          tt.GenerateTopMat();
          tt.GenerateSources();
          axa.GenerateTopMat();
          axa.GenerateSources;
          // starting solution
          tt.PrepareMatrix;
          tt.PrepareSolution;
          j:=0;
          repeat
            w3:=tt.MakeSolutionStep;
            j:=j+1;
            Series1.AddXY(j,w3);
            Chart1.Refresh;
          until (j>=ps.wMIter2d)or(w3<ps.wError2d);
          expa:=nil;
          expa:=TExpansionClass.Create();
          expa.SetShower(Gauge1,Label12,GroupBox3);
          expa.ExpandSolutionEC;
          expa.Free;
          Series1.Clear;
          df:=TApproximateSolution.Create(false);
          df.SetShower(gauge1,Label12,GroupBox3,Chart1,Series1);
          df.PrepareDataEC(mm);
          df.CreateAllMatrixEC(mm);
          df.RunSolutionEC(ps.wError_d,ps.wMIter_d);
          df.Free;
          with TSector(ob.Items[ccl])do
          begin
            rm:=iMaterial;
            rr:=(r1+r2)/2;
          end;
          a_LoadResults(Task,1);
          sg2d[i]:=GetSignal_3d_1(rm,rr);
          rm:=mt.nMaterials-1;
          sg_d[i]:=GetSignal_3d_1(rm,rr);
          with TSector(ob.Items[ccl])do
          begin
            rm:=iMaterial;
            rr:=(r1+r2)/2;
          end;
          a_LoadResults(Task,2);
          sg3d[i]:=GetSignal_3D_1(rm,rr);
          rm:=mt.nMaterials-1;
          sg_f[i]:=GetSignal_3D_1(rm,rr);
          sg2d[i]:=CAdd(sg2d[i],sg3d[i]);
          sg_d[i]:=CAdd(sg_d[i],sg_f[i]);
        end;
      3:begin // 3d solution
          Series1.Clear;
          if i=1 then
          begin
            // reassign main class variable
            mt.GenerateAllProperties(Task);
            axa.SetShower(Gauge1,Label12,GroupBox3);
            // prepare to solution
            axa.PrepareData;
            axa.GenerateNodes(1,1);
            axa.GenerateTopology();
            axa.GenerateBounds(bnd3,Nbnd3);
          end;
          axa.GenerateTopMat();
          axa.GenerateSources;
          // starting solution
          vl3:=TSolution3d.Create(false);
          vl3.SetShower(gauge1,Label12,GroupBox3,Chart1,Series1);
          vl3.CreateAllMatrixEC;
          vl3.RunSolutionEC(ps.wError3d,ps.wMIter3d);
          vl3.Free;
          a_LoadResults(Task,0);  // full
          with TSector(ob.Items[ccl])do
          begin
            rm:=iMaterial;
            rr:=(r1+r2)/2;
          end;
          sg3d[i]:=GetSignal_3D_1(rm,rr);
          rm:=mt.nMaterials-1;
          sg_d[i]:=GetSignal_3D_1(rm,rr);
          sg3d[i]:=CAdd(sg3d[i],sg_d[i]);
          sg_d[i]:=CNull;
        end;
        4:begin // 3d-3d-defect
          Series1.Clear;
          axa.defMat:=ddf;
          if i=1 then
          begin
            // reassign main class variable
            mt.GenerateAllProperties(Task);
            axa.SetShower(Gauge1,Label12,GroupBox3);
            // prepare to solution
            axa.PrepareData;
            axa.GenerateNodes(1,1);
            axa.GenerateTopology();
            axa.GenerateBounds(bnd3,Nbnd3);
          end;
          axa.GenerateTopMat();
          axa.GenerateSources;
          // starting solution
          vl3:=TSolution3d.Create(false);
          vl3.SetShower(gauge1,Label12,GroupBox3,Chart1,Series1);
          vl3.CreateAllMatrixEC;
          vl3.RunSolutionEC(ps.wError3d,ps.wMIter3d);
          vl3.Free;
          ///////////
          Series1.Clear;
          axa.defMat:=-1;
          a_LoadResults(Task,0);
          axa.GenerateTopMat();
          axa.GenerateSources;
          // starting solution
          Series1.Clear;
          df:=TApproximateSolution.Create(false);
          df.SetShower(gauge1,Label12,GroupBox3,Chart1,Series1);
          df.PrepareDataEC(mm);
          df.CreateAllMatrixEC(mm);
          df.RunSolutionEC(ps.wError_d,ps.wMIter_d);
          df.Free;
          with TSector(ob.Items[ccl])do
          begin
            rm:=iMaterial;
            rr:=(r1+r2)/2;
          end;
          a_LoadResults(Task,0);
          sg2d[i]:=GetSignal_3d_1(rm,rr);
          rm:=mt.nMaterials-1;
          sg_d[i]:=GetSignal_3d_1(rm,rr);
          with TSector(ob.Items[ccl])do
          begin
            rm:=iMaterial;
            rr:=(r1+r2)/2;
          end;
          a_LoadResults(Task,2);
          sg3d[i]:=GetSignal_3D_1(rm,rr);
          rm:=mt.nMaterials-1;
          sg_f[i]:=GetSignal_3D_1(rm,rr);
        end;
    end;
{    Append(f);
    write(f,' ',i:3,' ',TimeToStr(Time-sTime),'  ');
    write(f,1e6*sg2d[i].re:15,' ',1e6*sg2d[i].im:15,'  ');
    write(f,1e6*sg_d[i].re:15,' ',1e6*sg_d[i].im:15,'  ');
    write(f,1e6*sg3d[i].re:15,' ',1e6*sg3d[i].im:15,'  ');
    write(f,1e6*sg_f[i].re:15,' ',1e6*sg_f[i].im:15,'  ');
    writeln(f);
    CloseFile(F);  }
    //
  end;
  // releasing gage
  for i:=0 to GageCount-1 do
    if gage[i].k=1 then //block
    begin
      TBlock(ob.Items[gage[i].num]).z_1:=gage[i].z1;
      TBlock(ob.Items[gage[i].num]).z_2:=gage[i].z2;
    end
    else if gage[i].k=2 then // sector
    begin
      TSector(ob.Items[gage[i].num]).zz:=gage[i].z1;
    end
    else if gage[i].k=4 then
    begin
      TTriSec(ob.Items[gage[i].num]).z1:=gage[i].z1;
      TTriSec(ob.Items[gage[i].num]).z2:=gage[i].z2;
      TTriSec(ob.Items[gage[i].num]).z3:=gage[i].z3;
    end;
  gage:=nil;
  PageControl1.Enabled:=true;
  aPreView;

  axa.defMat:=ddf;
  Chart1.LeftAxis.Logarithmic:=false;
  Label16.Caption:=TimeToStr(Time-sTime);
  fmMain.RestoreItemClick(Self);
  SaveGod;
end;

procedure TfmControlCenterEC.SpeedButton2Click(Sender: TObject);
var k:int;
begin
  k:=ListBox2.ItemIndex;
  if k>=0 then
    ListBox1.Items.Add(ListBox2.Items[k]);
end;

procedure TfmControlCenterEC.SpeedButton1Click(Sender: TObject);
var k:int;
begin
  k:=ListBox1.ItemIndex;
  if k>=0 then
    ListBox1.Items.Delete(k);
end;

procedure TfmControlCenterEC.SpeedButton3Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

procedure TfmControlCenterEC.aPreView;
var i:int;
begin
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  for i:=0 to 4 do
    Chart1.Series[i].Active:=CheckListBox1.Checked[i];
  for i:=1 to StepCount do
  begin
    Case ComboBox3.ItemIndex of
      0:begin
          Series2.AddXY(s_pos[i]*1e3,sg2d[i].re*1e6);
          Series3.AddXY(s_pos[i]*1e3,sg_d[i].re*1e6);
          Series4.AddXY(s_pos[i]*1e3,sg_f[i].re*1e6);
          Series5.AddXY(s_pos[i]*1e3,sg3d[i].re*1e6);
        end;
      1:begin
          Series2.AddXY(s_pos[i]*1e3,sg2d[i].im*1e6);
          Series3.AddXY(s_pos[i]*1e3,sg_d[i].im*1e6);
          Series4.AddXY(s_pos[i]*1e3,sg_f[i].im*1e6);
          Series5.AddXY(s_pos[i]*1e3,sg3d[i].im*1e6);
        end;
      2:begin
          Series2.AddXY(s_pos[i]*1e3,CAbs(sg2d[i])*1e6);
          Series3.AddXY(s_pos[i]*1e3,CAbs(sg_d[i])*1e6);
          Series4.AddXY(s_pos[i]*1e3,CAbs(sg_f[i])*1e6);
          Series5.AddXY(s_pos[i]*1e3,CAbs(sg3d[i])*1e6);
        end;
    end;
  end;
end;

procedure TfmControlCenterEC.CheckListBox1ClickCheck(Sender: TObject);
begin
  aPreView;
end;

procedure TfmControlCenterEC.aStoreSignals;
var f:TextFile;
    i:int;
begin
  Screen.Cursor:=crHourGlass;
  if StepCount<>0 then
  begin
    AssignFile(f,'SignalEC.txt');
    Rewrite(f);
    writeln(f,'[Andrew signal format]');
    writeln(f);
    writeln(f,'Signals from Eddy Current inspections');
    writeln(f);
    writeln(f,StepCount);
    writeln(f);
    writeln(f,'Coordinate | Signal 2d | Signal Defect | Signal 3d | Signal Full');
    for i:=1 to StepCount do
    begin
      write(f,' ',s_pos[i]:6:3,'  ');
      write(f,sg2d[i].re:15,' +j ',sg2d[i].im:15,{' (',CAbs(sg2d[i]):15,' // ',CPhase(sg2d[i]),' )}'  ');
      write(f,sg_d[i].re:15,' +j ',sg_d[i].im:15,{' (',CAbs(sg_d[i]):15,' // ',CPhase(sg_d[i]),' )}'  ');
      write(f,sg3d[i].re:15,' +j ',sg3d[i].im:15,{' (',CAbs(sg3d[i]):15,' // ',CPhase(sg3d[i]),' )}'  ');
      write(f,sg_f[i].re:15,' +j ',sg_f[i].im:15,{' (',CAbs(sg_f[i]):15,' // ',CPhase(sg_f[i]),' )}'  ');
      writeln(f);
    end;
    writeln(f);
    writeln(f,'You can use this file later');
    writeln(f);
    CloseFile(f);
  end;
  Screen.Cursor:=crDefault;
end;

procedure TfmControlCenterEC.Button3Click(Sender: TObject);
begin
  aStoreSignals;
end;

end.
