unit DeviceInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxContainer, Menus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  dxmdaset, StdCtrls, cxButtons, cxGroupBox, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, ExtCtrls;

type
  TfmDeviceInfo = class(TForm)
    pnlControl: TPanel;
    gbInfo: TcxGroupBox;
    btOk: TcxButton;
    lbInfo: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure passData(dInfo: string);
  end;

var
  fmDeviceInfo: TfmDeviceInfo;

implementation

{$R *.dfm}

procedure TfmDeviceInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

procedure TfmDeviceInfo.passData(dInfo: string);
begin
  lbInfo.Caption := dInfo;
  //Caption := 'W = ' + IntToStr(lbInfo.Width) + ' : H = ' + IntToStr(lbInfo.Height);
end;

procedure TfmDeviceInfo.btOkClick(Sender: TObject);
begin
  Close;
end;

end.
