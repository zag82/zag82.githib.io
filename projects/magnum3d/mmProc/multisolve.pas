unit multisolve;

interface

uses pre_proc, main, cmData,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, Buttons, ExtCtrls;

type
  TfmMultiSolve = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    oDlg: TOpenDialog;
    Timer1: TTimer;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    gg: TGauge;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure mmd_Solver;
  end;

var
  fmMultiSolve: TfmMultiSolve;

implementation

{$R *.dfm}
uses mm_data, mm_solve, cm_ini, complx, cmVars, vi_3, vi_2, mmPass;
var kkk:int=0;
    mm:int;

procedure TfmMultiSolve.mmd_Solver;
var SumVars:array of Cardinal;
    chan:array of Cardinal;
    sum:Cardinal;
    i:Cardinal;
    j,n,nn:int;
    signal:array of TComplex;
    sg_def:array of TComplex;
    sg:TComplex;
    st:string;
    f:TextFile;
    sTime:TDateTime;
    sOut:string;
begin
  //////////////////////////
  SetLength(SumVars,mp.num+1);
  SumVars[mp.num]:=mp.vMulti[mp.num,1].nVars;
  for j:=mp.num-1 downto 1 do
    SumVars[j]:=mp.vMulti[j,1].nVars*SumVars[j+1];
  SetLength(chan,mp.num+1);
  for i:=1 to SumVars[1] do
  begin
    sum:=i-1;
    for j:=1 to mp.num-1 do
    begin
      chan[j]:=(sum div SumVars[j+1]);
      sum:=(sum mod SumVars[j+1]);
    end;
    chan[mp.num]:=sum;
    for j:=1 to mp.num do chan[j]:=chan[j]+1;
    /////////////////////////////////////////
    for j:=1 to mp.num do
      for n:=1 to mp.nMulti[j] do
        mp.SetValue(j,n,chan[j]);
    /////////////////////////////////////////
    st:=GetFileName(chan);
    if sum=0 then
    begin
      AssignFile(f,st);
      Rewrite(f);
      writeln(f,'Data_file');
      writeln(f);
      CloseFile(f);
//      sTime:=Time;
      nn:=1;
    end;
    /////////////////////////////
    // prepare
    Solution_Prepare;
    Case mp.solMet of
      1:mm_Solve_2d;
      2:mm_Solve_3d;
      3:mm_Solve_23(mm);
      4:mm_Solve_33;
    end;
    SetLength(signal,mp.numGage+1);
    SetLength(sg_def,mp.numGage+1);
    for j:=1 to mp.numGage do
      Case mp.solMet of
        1:signal[j]:=GetSignal(1,mp.vGage[j]);
        2:signal[j]:=GetSignal(2,mp.vGage[j]);
        3:begin
            signal[j]:=GetSignal(1,mp.vGage[j]);
            sg_def[j]:=GetSignal(2,mp.vGage[j]);
            signal[j]:=CAdd(signal[j],sg_def[j]);
          end;
        4:begin
            signal[j]:=GetSignal(2,mp.vGage[j]); // full
            a_LoadResults(Task,2);
            sg_def[j]:=GetSignal(2,mp.vGage[j]); //defect
          end;
      end;
    Case mp.outStyle of
      1:begin
          Append(f);
          sOut:=mp.GetValS(mp.num,1,nn,0);
          write(f,' ',nn:3,'. ',sOut,' ');
          inc(nn);
          for j:=1 to mp.numGage do write(f,' ',1e6*signal[j].re:20,' ',1e6*signal[j].im:20);
          write(f,' * ');
          if mp.solMet>2 then for j:=1 to mp.numGage do write(f,' ',1e6*sg_def[j].re:15,' ',1e6*sg_def[j].im:15);
          writeln(f);
          CloseFile(f);
        end;
      2:begin
          Append(f);
          sOut:=mp.GetValS(mp.num,1,nn,0);
          write(f,' ',nn:3,'. ',sOut,' ');
          inc(nn);
          sg:=Signal[1];
          for j:=2 to mp.numGage do sg:=CAdd(sg,signal[j]);
          write(f,' ',1e6*sg.re:15,' ',1e6*sg.im:15);
          write(f,' * ');
          if mp.solMet>2 then
          begin
            sg:=Sg_def[1];
            for j:=2 to mp.numGage do sg:=CAdd(sg,sg_def[j]);
            write(f,' ',1e6*sg.re:15,' ',1e6*sg.im:15);
          end;
          writeln(f);
          CloseFile(f);
        end;
      3:begin
          Append(f);
          sOut:=mp.GetValS(mp.num,1,nn,0);
          write(f,' ',nn:3,'. ',sOut,' ');
          inc(nn);
          sg:=Signal[1];
          for j:=2 to mp.numGage do sg:=CSub(sg,signal[j]);
          write(f,' ',1e6*sg.re:15,' ',1e6*sg.im:15);
          write(f,' * ');
          if mp.solMet>2 then
          begin
            sg:=Sg_def[1];
            for j:=2 to mp.numGage do sg:=CSub(sg,sg_def[j]);
            write(f,' ',1e6*sg.re:15,' ',1e6*sg.im:15);
          end;
          writeln(f);
          CloseFile(f);
        end;
    end;
  end;
  // free vars
  sumVars:=nil;
  chan:=nil;
  signal:=nil;
  sg_def:=nil;
end;

procedure TfmMultiSolve.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMultiSolve.SpeedButton1Click(Sender: TObject);
begin
  if oDlg.Execute then
  begin
    Edit1.Text:=oDlg.FileName;
    MultiLoad(oDlg.FileName);
    Button1.Enabled:=true;
  end;
end;

procedure TfmMultiSolve.Button1Click(Sender: TObject);
var i:int;
    time_1:TDateTime;
begin
  time_1:=Time;
  if wHide then fmMain.HideItemClick(Self)
  else Timer1.Enabled:=true;
  //////////////////////////
  mmd_Solver;
  //////////////////////////
  if wHide then fmMain.RestoreItemClick(Self)
  else Timer1.Enabled:=false;
  Label4.Caption:=TimeToStr(Time-time_1);
  if CheckBox1.Checked then Close;
end;

procedure TfmMultiSolve.CheckBox1Click(Sender: TObject);
var ii:int;
begin
  if CheckBox1.Checked then
  begin
    fmPass:=TfmPass.Create(Application);
    fmPass.ShowModal;
    ii:=fmPass.id;
    fmPass.Free;
    if ii=0 then CheckBox1.Checked:=false
    else CheckBox1.Checked:=true;
  end;
end;

procedure TfmMultiSolve.Timer1Timer(Sender: TObject);
begin
  if kkk>1000 then Timer1.Enabled:=false;
  if gg.Progress>=100 then
  begin
    kkk:=kkk+1;
    if gg.BackColor=clWhite then
    begin
      gg.BackColor:=clBlack;
      gg.ForeColor:=clWhite;
    end
    else
    begin
      gg.BackColor:=clWhite;
      gg.ForeColor:=clBlack;
    end;;
    gg.Progress:=0;
  end
  else
    gg.Progress:=gg.Progress+5;
end;

procedure TfmMultiSolve.FormCreate(Sender: TObject);
var i:int;
begin
  ComboBox1.Items.Clear;
  for i:=0 to mt.nMaterials-1 do
    ComboBox1.Items.Add(IntToStr(i+1)+' - '+mt.mmName[i]);
  ComboBox1.ItemIndex:=0;
  mm:=0;
end;

procedure TfmMultiSolve.ComboBox1Change(Sender: TObject);
begin
  mm:=ComboBox1.ItemIndex;
end;

end.
