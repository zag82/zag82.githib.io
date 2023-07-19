unit optim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, Buttons;

type
  TfmOptim = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
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
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    se: TSpinEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    GroupBox4: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Edit7: TEdit;
    Edit10: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    oDlg: TOpenDialog;
    sDlg: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmOptim: TfmOptim;

implementation

{$R *.dfm}
uses simp2, god2, cm_ini, cmVars, cmData, main;

procedure TfmOptim.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmOptim:=nil;
end;

procedure TfmOptim.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmOptim.Button1Click(Sender: TObject);
var
  prof,stp,err:vector;
  i,k:int;
  rm:float;
  q:int;
begin
  fmMain.HideItemClick(Self);
  ///
  prof[1]:=StrToFloat(Edit1.Text)/1e3;
  prof[2]:=StrToFloat(Edit2.Text)/1e3;
  stp[1]:=StrToFloat(Edit3.Text)/1e3;
  stp[2]:=StrToFloat(Edit4.Text)/1e3;
  rm:=StrToFloat(Edit5.Text)/1e3;
  for i:=1 to n do err[i]:=StrToFloat(Edit6.Text);
  ////////////
  ob.Add(TSector.Create(mt.DefaultMaterial,'Defect_profile'));
  k:=ob.Count-1;
  TSector(ob.Items[k]).SetData(0,0,-prof[1]/2,rm-prof[2],rm,0,90,prof[1],'Z');
  TSector(ob.Items[k]).DataLoad(0,0,0,0,0);
  ////////////
  opt:=TOptimize.Create;
  opt.SetData(Edit7.Text,Edit10.Text);
  opt.profile:=prof;
  ////////////
  sx:=TSimplex.Create(se.value,prof,stp,err);
  sx.mmax:=0.015;
  sx.Optimize;
  ///
  Edit8.Text:=FloatToStrF(sx.mean[1]*1e3,ffFixed,6,3);
  Edit9.Text:=FloatToStrF(sx.mean[2]*1e3,ffFixed,6,3);
  //////////////////////
  sx.Free;
  opt.FreeData;
  opt.Free;
  ob.Delete(ob.Count-1);
  //////////////////////
  fmMain.RestoreItemClick(Self);
end;

procedure TfmOptim.SpeedButton1Click(Sender: TObject);
begin
  if oDlg.Execute then Edit7.Text:=oDlg.FileName;
end;

procedure TfmOptim.SpeedButton2Click(Sender: TObject);
begin
  if sDlg.Execute then Edit10.Text:=sDlg.FileName;
end;

end.
