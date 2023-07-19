unit mmPass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmPass = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:integer;
  end;

var
  fmPass: TfmPass;

implementation

uses cm_ini;

{$R *.dfm}

procedure TfmPass.FormCreate(Sender: TObject);
begin
  id:=0;
end;

procedure TfmPass.Button2Click(Sender: TObject);
begin
  id:=0;
  Close;
end;

procedure TfmPass.Button1Click(Sender: TObject);
begin
  if Edit1.Text<>pw.password[1] then
    id:=0
  else
    id:=1;
  Close;
end;

end.
