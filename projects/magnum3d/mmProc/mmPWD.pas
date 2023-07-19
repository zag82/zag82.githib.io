unit mmPWD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmPWD = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPWD: TfmPWD;

implementation

{$R *.dfm}
uses cm_ini;

procedure TfmPWD.FormCreate(Sender: TObject);
begin
  pw.usr:=ComboBox1.ItemIndex+1;
  pw.password[1]:='1';
  pw.password[2]:='2';
  pw.password[3]:='3';
  pw.password[4]:='4';
end;

procedure TfmPWD.Button2Click(Sender: TObject);
begin
  pw.usr:=0;
  Close;
end;

procedure TfmPWD.Button1Click(Sender: TObject);
begin
  pw.usr:=ComboBox1.ItemIndex+1;
  with pw do
    if usr=4 then
      Close
    else
      if Edit1.Text=password[usr] then
        Close
      else
        ShowMessage('Wrong Password'#10#13'If you do not know password'#10#13'Login using GUEST name (no password expected)');
end;

end.
