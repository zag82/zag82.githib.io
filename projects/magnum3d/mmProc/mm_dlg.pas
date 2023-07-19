unit mm_dlg;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Grids, ExtCtrls;

type
  TfmMDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    se: TSpinEdit;
    sg: TStringGrid;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Button3: TButton;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure seChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:int;
    ss:string;
    ii:float;
    procedure UpdateAll;
  end;

var
  fmMDlg: TfmMDlg;

implementation

{$R *.dfm}

procedure TfmMDlg.UpdateAll;
begin
  Label6.Caption:=ss;
  Label7.Caption:=ss;
  Label8.Caption:=ss;
  ii:=1;
  if ss='mm' then ii:=1000;
  if ss='Hz' then ii:=1;
  if ss='deg' then ii:=1;
  if ss='MSm/m' then ii:=1e-6;
  sg.Cells[0,0]:='Values ('+ss+')';
end;

procedure TfmMDlg.FormCreate(Sender: TObject);
begin
  id:=0;
end;

procedure TfmMDlg.Button2Click(Sender: TObject);
begin
  id:=0;
  Close;
end;

procedure TfmMDlg.Button1Click(Sender: TObject);
begin
  id:=1;
  Close;
end;

procedure TfmMDlg.seChange(Sender: TObject);
var i:int;
begin
  sg.RowCount:=se.Value+1;
  for i:=1 to se.Value do
    if sg.Cells[0,i]='' then sg.Cells[0,i]:='0.000';
end;

procedure TfmMDlg.Button3Click(Sender: TObject);
var m1,m2,ms:float;
    num:int;
    vv:array of float;
    i,k:int;
    vl1:float;
begin
  vv:=nil;
  m1:=StrToFloat(Edit1.Text);
  m2:=StrToFloat(Edit2.Text);
  ms:=StrToFloat(Edit3.Text);
  num:=Round((m2-m1)/ms)+1;
  SetLength(vv,num+1);
  for i:=1 to num do vv[i]:=m1+(i-1)*ms;
  k:=ComboBox1.ItemIndex+1;
  vl1:=StrToFloat(sg.Cells[0,1]);
  if k=2 then for i:=1 to num do vv[i]:=vv[i]+vl1;
  for i:=1 to se.Value do
    if i<=num then
      sg.Cells[0,i]:=FloatToStrF(vv[i],ffFixed,8,3);
  vv:=nil;
end;

end.
