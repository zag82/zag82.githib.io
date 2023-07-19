unit CalibTestDevice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxControls,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, StdCtrls, cxButtons,
  ExtCtrls, SignalData, cxDBLookupComboBox;

type
  TfmCalibTestDevice = class(TForm)
    pnl: TPanel;
    btOK: TcxButton;
    md: TdxMemData;
    ds: TDataSource;
    tv: TcxGridDBTableView;
    lv: TcxGridLevel;
    gr: TcxGrid;
    mdVOLUME: TStringField;
    mdDIST: TIntegerField;
    mdEXT: TBooleanField;
    mdAXIAL: TBooleanField;
    mdWASTE: TBooleanField;
    mdpos1: TIntegerField;
    mdpos2: TIntegerField;
    mdvol: TStringField;
    mdchannel: TIntegerField;
    mdqr: TIntegerField;
    tvVOLUME: TcxGridDBColumn;
    tvDIST: TcxGridDBColumn;
    tvEXT: TcxGridDBColumn;
    tvAXIAL: TcxGridDBColumn;
    tvWASTE: TcxGridDBColumn;
    tvpos1: TcxGridDBColumn;
    tvpos2: TcxGridDBColumn;
    tvvol: TcxGridDBColumn;
    tvchannel: TcxGridDBColumn;
    tvqr: TcxGridDBColumn;
    dsResult: TDataSource;
    mdResult: TdxMemData;
    mdResultID: TIntegerField;
    mdResultNAME: TStringField;
    procedure btOKClick(Sender: TObject);
    procedure tvCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure addSignalData(nDefs: integer; var defs: array of TCalibDefect; var defParams: array of TDefectParams);
  end;

var
  fmCalibTestDevice: TfmCalibTestDevice;

implementation

{$R *.dfm}
uses MainAriel;

procedure TfmCalibTestDevice.addSignalData(nDefs: integer; var defs: array of TCalibDefect; var defParams: array of TDefectParams);
var
  i: integer;
begin
  md.DisableControls;
  md.Open;
  for i := 0 to nDefs - 1 do
  begin
    md.Append;
    mdVOLUME.Value := FloatToStrF(defs[i].volume, ffFixed, 6,2);
    mdDIST.Value := Round(defs[i].dist);
    mdEXT.Value := defs[i].isExt;
    mdAXIAL.Value := defs[i].isAxial;
    mdWASTE.Value := defs[i].isWaste;
    mdpos1.Value := defParams[i].pos1;
    mdpos2.Value := defParams[i].pos2;
    mdvol.Value := FloatToStrF(defParams[i].volume, ffFixed, 6,2);
    mdchannel.Value := defParams[i].channel;
    mdqr.Value := Ord(defParams[i].qualityRes);
    md.Post;
  end;
  md.EnableControls;
  md.Refresh
end;

procedure TfmCalibTestDevice.btOKClick(Sender: TObject);
begin
  md.Close;
  mdResult.Close;
  Close;
end;

procedure TfmCalibTestDevice.FormCreate(Sender: TObject);
begin
  mdResult.Open;
end;

procedure TfmCalibTestDevice.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_ESCAPE) then
    btOKClick(self);
end;

procedure TfmCalibTestDevice.tvCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  with fmMainAriel do
  begin
    // отображение рамок дефекта
    if mdDefectsID.Value > 0 then
    begin
      mv.gPos1 := mdpos1.Value;
      mv.gPos2 := mdpos2.Value;
      mv.correctFramePos();
      UpdatePartGraphs();
    end;
  end;
end;

end.
