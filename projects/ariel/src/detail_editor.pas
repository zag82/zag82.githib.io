unit detail_editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, ActnList, StdCtrls, cxButtons,
  ExtCtrls, cxGraphics, cxLookAndFeels;

type
  TfmDetailEditor = class(TForm)
    pnlControl: TPanel;
    btOk: TcxButton;
    btCancel: TcxButton;
    acts: TActionList;
    actOK: TAction;
    actCancel: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    idRes:integer;
  end;

var
  fmDetailEditor: TfmDetailEditor;

implementation

{$R *.dfm}

procedure TfmDetailEditor.FormCreate(Sender: TObject);
begin
  idRes:=0;
end;

procedure TfmDetailEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_ESCAPE) then
    actCancelExecute(self);
end;

procedure TfmDetailEditor.actOKExecute(Sender: TObject);
begin
  self.ActiveControl:=btOk;
  idRes:=1;
  Close;
end;

procedure TfmDetailEditor.actCancelExecute(Sender: TObject);
begin
  self.ActiveControl:=btCancel;
  Close;
end;

end.
