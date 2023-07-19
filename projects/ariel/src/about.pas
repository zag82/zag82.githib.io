unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, azFileVersion;

type
  TfmAbout = class(TForm)
    gbInfo: TGroupBox;
    btOK: TButton;
    Image1: TImage;
    lbCaption: TcxLabel;
    lbDescr: TcxLabel;
    lbCopy: TcxLabel;
    lbAuthor: TcxLabel;
    lbWeb: TcxLabel;
    lbVersion: TcxLabel;
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.dfm}

procedure TfmAbout.btOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfmAbout.FormCreate(Sender: TObject);
begin
  lbCaption.Caption := Application.Title;
  lbVersion.Caption := 'Версия: ' + GetVersionValue;
end;

procedure TfmAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

end.
