unit child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, FileCtrl, StdCtrls, ExtCtrls, ComCtrls, ShellCtrls;

type
  TfmChild = class(TForm)
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    FilterComboBox1: TFilterComboBox;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmChild: TfmChild;

implementation

{$R *.dfm}

procedure TfmChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmChild.FileListBox1Click(Sender: TObject);
begin
  RichEdit1.Lines.LoadFromFile(FileListBox1.FileName);
end;

end.
