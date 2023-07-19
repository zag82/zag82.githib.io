unit HeaderExchanger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, cxButtons, cxLabel, cxListBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit;

const
  HEADER_LENGTH = 2048;
type
  THeader = array [0..HEADER_LENGTH - 1] of byte;

  TfmHeaderExchanger = class(TForm)
    edIniFile: TcxButtonEdit;
    lbFiles: TcxListBox;
    lbIniFile: TcxLabel;
    lbFile: TcxLabel;
    btRun: TcxButton;
    btAdd: TcxButton;
    btClear: TcxButton;
    oDlg: TOpenDialog;
    procedure edIniFilePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btAddClick(Sender: TObject);
    procedure btClearClick(Sender: TObject);
    procedure btRunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function readHeader(f: AnsiString):THeader;
    procedure writeHeader(f: AnsiString; h: THeader);
  end;

var
  fmHeaderExchanger: TfmHeaderExchanger;

implementation

{$R *.dfm}

function TfmHeaderExchanger.readHeader(f: AnsiString):THeader;
var
  fs: TFileStream;
  h: THeader;
begin
  fs := TFileStream.Create(f, fmOpenRead or fmShareDenyNone);
  fs.Read(h, HEADER_LENGTH);
  fs.Free;
  Result := h;
end;

procedure TfmHeaderExchanger.writeHeader(f: AnsiString; h: THeader);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(f, fmOpenWrite);
  fs.Seek(0, soFromBeginning);
  fs.Write(h, HEADER_LENGTH);
  fs.Free;
end;

procedure TfmHeaderExchanger.btAddClick(Sender: TObject);
begin
  if oDlg.Execute then
    lbFiles.Items.AddStrings(oDlg.Files);
end;

procedure TfmHeaderExchanger.btClearClick(Sender: TObject);
begin
  lbFiles.Clear;
end;

procedure TfmHeaderExchanger.btRunClick(Sender: TObject);
var
  i: integer;
  fName: AnsiString;
  h: THeader;
begin
  h := readHeader(edIniFile.Text);
  for i := 0 to lbFiles.Count - 1 do
    writeHeader(lbFiles.Items[i], h);
end;

procedure TfmHeaderExchanger.edIniFilePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if oDlg.Execute then
    edIniFile.Text := oDlg.FileName;
end;

end.
