unit control_ss;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmControlM = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    CheckBox2: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmControlM: TfmControlM;

implementation

uses ss_multi, cm_ini, cmVars;

{$R *.dfm}

procedure TfmControlM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmControlM:=nil;
end;

procedure TfmControlM.Button1Click(Sender: TObject);
var sm:TMagnetSignal;
    zz:float;
    mi:boolean;
    nn:int;
begin
  mi:=checkbox2.Checked;
  if mi then
    nn:=61
  else
    nn:=31;
  zz:=(4+StrToFloat(Edit1.Text))/1000;
  if CheckBox1.Checked then zz:=-zz;
  sm:=TMagnetSignal.Create;
  sm.SetData(0.0033,0.0082,nn,13,zz);
  sm.minus:=mi;
  sm.GenerateFullMatrix;
  sm.SaveResToFile('bx.txt',1);
  sm.SaveResToFile('by.txt',2);
  sm.SaveResToFile('bz.txt',3);
  sm.FreeData;
  sm.Free;
end;

procedure TfmControlM.FormCreate(Sender: TObject);
begin
  a_LoadResults(Task,0);
end;

end.
