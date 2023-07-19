unit DeviceSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, Menus, cxContainer, cxGroupBox, StdCtrls,
  cxButtons, ExtCtrls, dxmdaset, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxLabel,
  cxTextEdit, cxDBLookupComboBox, SignalData, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit;

type
  TfmDeviceSettings = class(TForm)
    tvParams: TcxGridDBTableView;
    lvParams: TcxGridLevel;
    grParams: TcxGrid;
    pnlControl: TPanel;
    pnlTop: TPanel;
    btSave: TcxButton;
    btExit: TcxButton;
    gbCommon: TcxGroupBox;
    mdDeviceData: TdxMemData;
    mdDeviceDataID: TIntegerField;
    mdDeviceDataFREQ: TIntegerField;
    mdDeviceDataDRV: TIntegerField;
    mdDeviceDataAMP: TIntegerField;
    mdDeviceDataFILTER_TYPE: TIntegerField;
    mdDeviceDataLOW_PASS: TIntegerField;
    mdDeviceDataHIGH_PASS: TIntegerField;
    dsDeviceData: TDataSource;
    mdDeviceDataCHANGED: TBooleanField;
    tvParamsID: TcxGridDBColumn;
    tvParamsFREQ: TcxGridDBColumn;
    tvParamsDRV: TcxGridDBColumn;
    tvParamsAMP: TcxGridDBColumn;
    tvParamsFILTER_TYPE: TcxGridDBColumn;
    tvParamsLOW_PASS: TcxGridDBColumn;
    tvParamsHIGH_PASS: TcxGridDBColumn;
    tvParamsCHANGED: TcxGridDBColumn;
    edPreAmp: TcxTextEdit;
    lbPreAmp: TcxLabel;
    lbBWLimit: TcxLabel;
    lbMUXStart: TcxLabel;
    lbMuxEnd: TcxLabel;
    lbDecimation: TcxLabel;
    lbTriggerType: TcxLabel;
    edMUXStart: TcxTextEdit;
    edMuxEnd: TcxTextEdit;
    edDecimation: TcxTextEdit;
    edTriggerType: TcxLookupComboBox;
    mdTriggerType: TdxMemData;
    dsTriggerType: TDataSource;
    mdDeviceDataPHASE: TIntegerField;
    mdDeviceDataSPREADX: TIntegerField;
    mdDeviceDataSPREADY: TIntegerField;
    mdDeviceDataDOTX: TIntegerField;
    mdDeviceDataDOTY: TIntegerField;
    mdDeviceDataMUXTIME: TIntegerField;
    mdTriggerTypeID: TIntegerField;
    mdTriggerTypeNAME: TStringField;
    tvParamsPHASE: TcxGridDBColumn;
    tvParamsSPREADX: TcxGridDBColumn;
    tvParamsSPREADY: TcxGridDBColumn;
    tvParamsDOTX: TcxGridDBColumn;
    tvParamsDOTY: TcxGridDBColumn;
    tvParamsMUXTIME: TcxGridDBColumn;
    dsBWLimit: TDataSource;
    mdBWLimit: TdxMemData;
    mdBWLimitID: TIntegerField;
    mdBWLimitNAME: TStringField;
    edBWLimit: TcxLookupComboBox;
    procedure btExitClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvParamsCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edPreAmpPropertiesChange(Sender: TObject);
    procedure tvParamsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edBWLimitPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idRes: integer;
    bPreAmpChanged: boolean;
    bBWLimitChanged: boolean;
    bStateWritable: boolean;
    procedure setState(bWrite: boolean);
    procedure changeLine();
    procedure loadData(dp: TDeviceInfo);
  end;

var
  fmDeviceSettings: TfmDeviceSettings;

implementation

{$R *.dfm}

uses DeviceSettingsCh, DataMod;

procedure TfmDeviceSettings.loadData(dp: TDeviceInfo);
var
  i: integer;
begin
  mdDeviceData.Open;
  for i := 0 to maxChannels - 1 do
  begin
    mdDeviceData.Append;
    mdDeviceDataID.Value := i + 1;
    mdDeviceDataFREQ.Value := dp.channelsInfo[i].frequency;
    mdDeviceDataDRV.Value := Round(dp.channelsInfo[i].drive / 10);
    mdDeviceDataAMP.Value := Round(dp.channelsInfo[i].amplification / 10);
    mdDeviceDataFILTER_TYPE.Value := dp.channelsInfo[i].filterType;
    mdDeviceDataLOW_PASS.Value := Round(dp.channelsInfo[i].lowPass / 10);
    mdDeviceDataHIGH_PASS.Value := Round(dp.channelsInfo[i].hiPass / 10);
    ///
    mdDeviceDataPHASE.Value := Round(dp.addChannelsInfo[i].phase / 10);
    mdDeviceDataSPREADX.Value := Round(dp.addChannelsInfo[i].x_spread / 10);
    mdDeviceDataSPREADY.Value := Round(dp.addChannelsInfo[i].y_spread / 10);
    mdDeviceDataDOTX.Value := dp.addChannelsInfo[i].x_dot;
    mdDeviceDataDOTY.Value := dp.addChannelsInfo[i].y_dot;
    mdDeviceDataMUXTIME.Value := dp.addChannelsInfo[i].mux_time * 4;
    ///
    mdDeviceDataCHANGED.Value := false;
    mdDeviceData.Post;
  end;
  mdDeviceData.First;
  edPreAmp.Text := IntToStr(Round(dp.preAmp / 10));
  edBWLimit.EditValue := dp.bwLimit;
  edMUXStart.Text := IntToStr(dp.bwLimit);
  edMUXStart.Text := IntToStr(dp.mux_start + 1);
  edMuxEnd.Text := IntToStr(dp.mux_finish + 1);
  edDecimation.Text := IntToStr(dp.decimation);
  edTriggerType.EditValue := dp.triggerType;
end;

procedure TfmDeviceSettings.setState(bWrite: boolean);
begin
  bStateWritable := bWrite;
  // обновляем элементы интерфейса
  edPreAmp.Properties.ReadOnly := not bStateWritable;
  edBWLimit.Enabled := bStateWritable;
  btSave.Visible := bStateWritable;
  if bStateWritable then
    btExit.Caption := 'Cancel'
  else
    btExit.Caption := 'Exit';
end;

procedure TfmDeviceSettings.changeLine();
begin
  if bStateWritable then
  begin
    // изменение данных
    mdDeviceData.Edit;
    fmDeviceSettingsCh := TfmDeviceSettingsCh.Create(self);
    fmDeviceSettingsCh.ShowModal;
    if fmDeviceSettingsCh.idRes = 1 then
    begin
      mdDeviceDataCHANGED.Value := true;
      mdDeviceData.Post;
    end
    else
    begin
      mdDeviceData.Cancel;
    end;
    fmDeviceSettingsCh.Free;
  end;
end;

procedure TfmDeviceSettings.btExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfmDeviceSettings.btSaveClick(Sender: TObject);
begin
  idRes := 1;
  Close;
end;

procedure TfmDeviceSettings.edBWLimitPropertiesChange(Sender: TObject);
begin
  bBWLimitChanged := true;
end;

procedure TfmDeviceSettings.edPreAmpPropertiesChange(Sender: TObject);
begin
  bPreAmpChanged := true;
end;

procedure TfmDeviceSettings.FormCreate(Sender: TObject);
begin
  idRes := 0;
  bPreAmpChanged := false;
  bBWLimitChanged := false;
  mdTriggerType.Open;
  mdBWLimit.Open;
  setState(true);
end;

procedure TfmDeviceSettings.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

procedure TfmDeviceSettings.tvParamsCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  changeLine();
end;

procedure TfmDeviceSettings.tvParamsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    changeLine();
end;

end.
