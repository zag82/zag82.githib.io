unit UserMode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxTextEdit, cxMaskEdit, cxDropDownEdit, StdCtrls,
  cxButtons, cxGroupBox;

type
  TfmUserMode = class(TForm)
    gb: TcxGroupBox;
    btOK: TcxButton;
    cb: TcxComboBox;
    btCancel: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    iRes: integer;
    procedure setUserLevelValue(ul: integer);
  end;

var
  fmUserMode: TfmUserMode;

implementation

{$R *.dfm}

procedure TfmUserMode.btCancelClick(Sender: TObject);
begin
  iRes := 0;
  Close;
end;

procedure TfmUserMode.setUserLevelValue(ul: integer);
begin
  if ul > 10 then
    cb.ItemIndex := 1
  else
    cb.ItemIndex := 0;
end;

procedure TfmUserMode.btOKClick(Sender: TObject);
begin
  iRes := 1;
  Close;
end;

procedure TfmUserMode.FormCreate(Sender: TObject);
begin
  iRes := 0;
end;

procedure TfmUserMode.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

end.
