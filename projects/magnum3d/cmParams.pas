unit cmParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin;

type
  TfmParams = class(TForm)
    GroupBox3: TGroupBox;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    se1: TSpinEdit;
    Label1: TLabel;
    CheckBox4: TCheckBox;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    ComboBox2: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParams: TfmParams;

implementation

{$R *.dfm}
uses cm_ini, cmVars;

procedure TfmParams.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmParams.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmParams.FormCreate(Sender: TObject);
begin
  CheckBox1.Checked:=wAuto_StartS;
  CheckBox2.Checked:=wAuto_CloseS;
  CheckBox3.Checked:=wSaveTop;
  CheckBox4.Checked:=wHide;
  ComboBox1.ItemIndex:=wSeparator;
  RadioGroup1.ItemIndex:=ord(wTPR);
  se1.Value:=tic;
end;

procedure TfmParams.Button1Click(Sender: TObject);
begin
  wAuto_StartS:=CheckBox1.Checked;
  wAuto_CloseS:=CheckBox2.Checked;
  wSaveTop:=CheckBox3.Checked;
  wHide:=CheckBox4.Checked;
  wSeparator:=ComboBox1.ItemIndex;
  if wSeparator=0 then DecimalSeparator:='.' else DecimalSeparator:=',';
  wTPR:=TThreadPriority(RadioGroup1.ItemIndex);
  tic:=se1.Value;
  Close;
end;

end.
