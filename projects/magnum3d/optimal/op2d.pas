unit op2d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, ExtCtrls, Buttons, TeEngine, Series,
  TeeProcs, Chart, ExtDlgs, Spin;

type
  TfmOp2d = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    gbb: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    sg: TStringGrid;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Chart1: TChart;
    oDlg: TOpenDialog;
    sDlg: TSaveDialog;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    sgg: TStringGrid;
    Label20: TLabel;
    Label21: TLabel;
    Bevel2: TBevel;
    Button3: TButton;
    Series2: TAreaSeries;
    Series1: TLineSeries;
    Button4: TButton;
    Button5: TButton;
    oDlg2: TOpenDialog;
    sDlg2: TSavePictureDialog;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    se: TSpinEdit;
    Button6: TButton;
    oDlg3: TOpenDialog;
    sDlg3: TSaveDialog;
    Button7: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmOp2d: TfmOp2d;

implementation

uses simp, godog, cm_ini, cmVars, cmData, main;

{$R *.dfm}

procedure TfmOp2d.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmOp2d.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmOp2d:=nil;
end;

procedure TfmOp2d.SpeedButton1Click(Sender: TObject);
begin
  if oDlg.Execute then Edit6.Text:=oDlg.FileName;
end;

procedure TfmOp2d.SpeedButton2Click(Sender: TObject);
begin
  if sDlg.Execute then Edit7.Text:=sDlg.FileName;
end;

procedure TfmOp2d.Button1Click(Sender: TObject);
var
  prof,stp,err:vector;
  i,k:int;
  rm,dz:float;
  q:int;
begin
  q:=ComboBox1.ItemIndex;
  fmMain.HideItemClick(Self);
  ///
  for i:=1 to m do stp[i]:=StrToFloat(Edit4.Text)/1000;
  for i:=1 to n do err[i]:=StrToFloat(Edit5.Text);
  for i:=1 to m do prof[i]:=StrToFloat(sg.Cells[0,i])/1e3;
  ////////////
  dz:=StrToFloat(Edit1.Text)/1000;
  rm:=StrToFloat(Edit2.Text)/1000;
  if q=0 then
  begin
    ob.Add(TOpSec.Create(mt.DefaultMaterial,'Defect_profile'));
    k:=ob.Count-1;
    TOpSec(ob.Items[k]).SetData(0,dz,rm,0,90);
    TOpSec(ob.Items[k]).DataLoad(0,0,0,0,0);
    TOpSec(ob.Items[k]).profile:=prof;
  end
  else
  begin
    ob.Add(TOpSecR.Create(mt.DefaultMaterial,'Defect_profile'));
    k:=ob.Count-1;
    TOpSecR(ob.Items[k]).SetData(0,dz,rm,0,90);
    TOpSecR(ob.Items[k]).DataLoad(0,0,0,0,0);
    TOpSecR(ob.Items[k]).profile:=prof;
  end;
  ////////////
  opt:=TOptimize.Create;
  opt.SetData(Edit6.Text,Edit7.Text);
  opt.profile:=prof;
  ////////////
  sx:=TSimplex.Create(se.value,prof,stp,err);
  sx.mmax:=StrToFloat(Edit3.Text)/1000;
  sx.Optimize;
  ///
    Series1.Clear;
    for i:=1 to m do
      if q=0 then
        Series1.AddXY(dz*(i-5)*1e3,sx.mean[i]*1e3)
      else
        Series1.AddXY(dz*(i-5.5)*1e3,sx.mean[i]*1e3);
    if q<>0 then
      Series1.AddXY(dz*(m-4.5)*1e3,sx.mean[m]*1e3);
    Label13.Caption:=IntToStr(sx.niter);
    Label14.Caption:=FloatToStrF(sx.mean[n]*100,ffGeneral,6,1);
    Label15.Caption:=FloatToStrF(sx.error[n]*100,ffGeneral,6,1);
  //////////////////////
  for i:=1 to m do
  begin
    sgg.Cells[0,i]:=FloatToStrF(dz*(i-5)*1e3,ffFixed,6,3);
    sgg.Cells[1,i]:=FloatToStrF(sx.mean[i]*1e3,ffFixed,6,3);
  end;
  sx.Free;
  opt.FreeData;
  opt.Free;
  ob.Delete(ob.Count-1);
  //////////////////////
  fmMain.RestoreItemClick(Self);
end;

procedure TfmOp2d.FormCreate(Sender: TObject);
var i:int;
begin
  PageControl1.ActivePageIndex:=0;
  sg.Cells[0,0]:='Depth (mm)';
  for i:=1 to m do sg.Cells[0,i]:='0.5';
  /////////////////////////////////////
  sgg.Cells[0,0]:='Coord (mm)';
  sgg.Cells[1,0]:='Reconstruct';
  sgg.Cells[2,0]:='Real flaw';
  /////////////////////////////////////
end;

procedure TfmOp2d.Button3Click(Sender: TObject);
var i:int;
    s1,s2:vector;
    sm,sx:float;
begin
  for i:=1 to m do
  begin
    s1[i]:=StrToFloat(sgg.Cells[1,i]);
    s2[i]:=StrToFloat(sgg.Cells[2,i]);
  end;
  sm:=0;
  sx:=0;
  for i:=1 to m do
  begin
    sx:=sx+s2[i];
    sm:=sm+abs(s1[i]-s2[i]);
  end;
  if Abs(sx)>1e-20 then sm:=sm/sx;
  Label20.Caption:=FloatToStrF(sm*100,ffGeneral,6,1);
end;

procedure TfmOp2d.Button4Click(Sender: TObject);
begin
  if sDlg2.Execute then Chart1.SaveToBitmapFile(sDlg2.FileName);
end;

procedure TfmOp2d.Button5Click(Sender: TObject);
var num,i:int;
    a,b:double;
    f:TextFile;
begin
  if oDlg2.Execute then
  begin
    AssignFile(f,oDlg2.FileName);
    Reset(f);
    readln(f,num);
    Series2.Clear;
    for i:=1 to num do
    begin
      readln(f,a,b);
      Series2.AddXY(a,b);
    end;
    CloseFile(f);
  end;
end;

procedure TfmOp2d.CheckBox1Click(Sender: TObject);
begin
  Series1.Stairs:=CheckBox1.Checked;
end;

procedure TfmOp2d.Button6Click(Sender: TObject);
var num,i:int;
    a,b:double;
    f:TextFile;
begin
  if oDlg3.Execute then
  begin
    AssignFile(f,oDlg3.FileName);
    Reset(f);
    readln(f,num);
    Series1.Clear;
    for i:=1 to num do
    begin
      readln(f,a,b);
      Series1.AddXY(a,b);
    end;
    CloseFile(f);
  end;
end;

procedure TfmOp2d.Button7Click(Sender: TObject);
var num,i:int;
    a,b:double;
    f:TextFile;
begin
  if sDlg3.Execute then
  begin
    AssignFile(f,sDlg3.FileName);
    ReWrite(f);
    num:=Series1.Count;
    writeln(f,num);
    for i:=1 to num do
    begin
      a:=Series1.XValue[i-1];
      b:=Series1.YValue[i-1];
      writeln(f,a:6:3,#09,b:6:3);
    end;
    CloseFile(f);
  end;
end;

end.
