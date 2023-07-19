unit mm_dir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TfmDirs = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    s:string;
  end;

var
  fmDirs: TfmDirs;

implementation

{$R *.dfm}

procedure TfmDirs.Button2Click(Sender: TObject);
begin
  s:='';
  Close;
end;

procedure TfmDirs.Button1Click(Sender: TObject);
begin
  s:=DirectoryListBox1.Directory;
  Close;
end;

procedure TfmDirs.FormCreate(Sender: TObject);
begin
  s:='';
end;

end.
