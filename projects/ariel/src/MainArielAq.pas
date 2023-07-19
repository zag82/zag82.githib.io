unit MainArielAq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxLabel, DB, dxmdaset, ActnList, ImgList, dxBar, cxClasses,
  cxDropDownEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid, ExtCtrls,
  cxTextEdit, cxMaskEdit, cxSpinEdit, cxSpinButton, StdCtrls, cxButtons,
  cxGroupBox, cxPC, dxStatusBar, PLData, PLThread, PLThreadProcData,
  PLThreadProcessor, PLThreadProcSettings, SignalData, cxDBLookupComboBox,
  glGraph, dxBarExtItems, cxNavigator;

type
  TfmMainArielAquire = class(TForm)
    stBar: TdxStatusBar;
    pnlCollect: TPanel;
    grDeviceData: TcxGrid;
    tvDeviceData: TcxGridTableView;
    tvDeviceDataColumn1: TcxGridColumn;
    tvDeviceDataColumn2: TcxGridColumn;
    tvDeviceDataColumn3: TcxGridColumn;
    tvDeviceDataColumn4: TcxGridColumn;
    tvDeviceDataColumn5: TcxGridColumn;
    tvDeviceDataColumn6: TcxGridColumn;
    tvDeviceDataColumn7: TcxGridColumn;
    lvDeviceData: TcxGridLevel;
    bmMenu: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bmMenuBar1: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarSubItem4: TdxBarSubItem;
    dxBarButton6: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton11: TdxBarButton;
    imgs: TcxImageList;
    acts: TActionList;
    actSave: TAction;
    actExit: TAction;
    actAbout: TAction;
    actConnect: TAction;
    actDisconnect: TAction;
    actDeviceSettings: TAction;
    actDeviceInfo: TAction;
    sDlg: TSaveDialog;
    actSettings: TAction;
    actStart: TAction;
    actFinish: TAction;
    actBallance: TAction;
    actAmplificationUp: TAction;
    actAmplificationDown: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    mdCommonSettings: TdxMemData;
    dsCommonSettings: TDataSource;
    mdCommonSettingsIP: TStringField;
    mdCommonSettingsDECIMATION: TIntegerField;
    mdCommonSettingsSERIES_MAX: TIntegerField;
    mdCommonSettingsFNAME1: TStringField;
    mdCommonSettingsFNAME2: TStringField;
    mdCommonSettingsFNAME3: TStringField;
    mdCommonSettingsPART_INC: TIntegerField;
    mdCommonSettingsDATA_FILE_PATH: TStringField;
    mdCommonSettingsPRIORITY: TIntegerField;
    tm: TTimer;
    mdCommonSettingsSHOW_DLG: TBooleanField;
    mdCommonSettingsAUTO_START: TBooleanField;
    mdCommonSettingsAUTO_STOP: TBooleanField;
    mdCommonSettingsSTART_CONDITION: TIntegerField;
    mdCommonSettingsSTOP_CONDITION: TIntegerField;
    mdCommonSettingsSTART_VALUE: TFloatField;
    mdCommonSettingsSTOP_VALUE: TFloatField;
    mdCommonSettingsAUTO_CHANNEL: TIntegerField;
    mdCommonSettingsAUTO_PART: TIntegerField;
    pnlGlGraps: TPanel;
    lbAmp: TdxBarStatic;
    btAdmin: TdxBarButton;
    actUserMode: TAction;
    dxBarButton12: TdxBarButton;
    mdCommonSettingsTRIGGER_TYPE: TIntegerField;
    tmLic: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnlCollectResize(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actDisconnectExecute(Sender: TObject);
    procedure actDeviceSettingsExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actConnectUpdate(Sender: TObject);
    procedure actDisconnectUpdate(Sender: TObject);
    procedure actDeviceInfoExecute(Sender: TObject);
    procedure actStartExecute(Sender: TObject);
    procedure actFinishExecute(Sender: TObject);
    procedure actAmplificationDownExecute(Sender: TObject);
    procedure actAmplificationUpExecute(Sender: TObject);
    procedure tvDeviceDataCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actStartUpdate(Sender: TObject);
    procedure actFinishUpdate(Sender: TObject);
    procedure actSettingsUpdate(Sender: TObject);
    procedure tmTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure actUserModeExecute(Sender: TObject);
    procedure actBallanceExecute(Sender: TObject);
    procedure tmLicTimer(Sender: TObject);
  private
    { Private declarations }
    FDeviceInfo: string;
    FDevicePresetData: TDeviceInfo;
    FDeviceInfoData: TDeviceInfo;
    FUserMode: integer;
    FSeriesMaxValue: Integer;
    FChannel: integer;
    FAquireData: boolean;
    FCurrentFileIndex: integer;
    RootDir: string;
    nextDataFileName: string;
    procedure setSeriesMaxValue(value: integer);
    procedure setChannel(value: integer);
    procedure setAquireData(value: boolean);
    procedure plGetChannelsInfo();
    procedure plStartAquisition();
    procedure loadSettings();
    procedure saveSettings();
    procedure updateSetings();
    procedure preConnectActions();
    procedure postDisconnectActions();
    procedure getFileName();
    procedure UpdateStatusPanel;
  public
    { Public declarations }
    OldDataValue: double;
    // элементы сбора данных
    iAmpl: integer;
    isConnected: boolean;
    plSet: TPLThreadProcessorSettings;
    plData: TPLThreadProcessorData;
    signalCollect: TSignalData;
    grData: TglGraph;
    procedure plOnTcpMessage(msgType: TTCPMessageType; msgText: AnsiString);
    procedure plDeviceResponse(header: TPLMessageHeader; var data: array of integer);
    procedure plDeviceDataShow(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition);
    procedure plDeviceGetTextInfo(header: TPLMessageHeader; var data: array of TTextResponse);
    property seriesMaxValue: integer read FSeriesMaxValue write SetSeriesMaxValue;
    property channel: integer read FChannel write SetChannel;
    property bAquireData: boolean read FAquireData write SetAquireData;
    procedure AmplificationChange();
    procedure loadPresetData(fName: string);
  end;

var
  fmMainArielAquire: TfmMainArielAquire;

implementation

uses about, DeviceInfo, DeviceSettings, CommonSettings, DataMod, UserMode,
  licGrd;

{$R *.dfm}
const
  fileNameSettingsAquire = 'arielaq.dat';

var
  cntData: int64 = 0;

{$REGION 'PL'}
procedure TfmMainArielAquire.setSeriesMaxValue(value: integer);
begin
  FSeriesMaxValue := value;
  grData.SetMaxPoints(value);
end;

procedure TfmMainArielAquire.setChannel(value: integer);
begin
  FChannel := value;
  grData.Clear;
end;

procedure TfmMainArielAquire.setAquireData(value: boolean);
begin
  FAquireData := value;
end;

procedure TfmMainArielAquire.plGetChannelsInfo();
var i: integer;
begin
  // посылаем запросы на получение информации по настройкам каналов
  for i := 0 to maxChannels - 1 do
  begin
    // основные параметры
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DrvFreq, 0, i, [FDevicePresetData.channelsInfo[i].frequency]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DrvAmpl, 0, i, [FDevicePresetData.channelsInfo[i].drive]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_MainAmp, 0, i, [FDevicePresetData.channelsInfo[i].amplification]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_FilterType, 0, i, [FDevicePresetData.channelsInfo[i].filterType]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_HiPass, 0, i, [FDevicePresetData.channelsInfo[i].hiPass]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_LoPass, 0, i, [FDevicePresetData.channelsInfo[i].lowPass]);
    // дополнительные параметры
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_Phase, 0, i, [FDevicePresetData.addChannelsInfo[i].phase]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_SpreadX, 0, i, [FDevicePresetData.addChannelsInfo[i].x_spread]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_SpreadY, 0, i, [FDevicePresetData.addChannelsInfo[i].y_spread]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DotPosX, 0, i, [FDevicePresetData.addChannelsInfo[i].x_dot]);
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DotPosY, 0, i, [FDevicePresetData.addChannelsInfo[i].y_dot]);
    plSet.pl.sendData(MSG_TYPE_QUERY, DATA_TYPE_NONE, MSG_MuxSamples, 0, i, []);
  end;
  plSet.pl.sendData(MSG_TYPE_QUERY, DATA_TYPE_NONE, MSG_MuxStart, 0, 0, []);
  plSet.pl.sendData(MSG_TYPE_QUERY, DATA_TYPE_NONE, MSG_MuxEnd, 0, 0, []);
  plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_BWLimit, 0, 0, [FDevicePresetData.bwLimit]);

  plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_PreAmp, 0, 0, [FDevicePresetData.preAmp]);
  // запросы по информации о приборе
  plSet.pl.sendData(MSG_TYPE_QUERY, DATA_TYPE_NONE, MSG_DevInfo, 0, 0, []);
  // запрос пользовательского уровня
  plSet.pl.sendData(MSG_TYPE_QUERY, DATA_TYPE_NONE, MSG_UserLEvel, 0, 0, []);
end;

procedure TfmMainArielAquire.plStartAquisition();
var
  i: integer;
  dataBlocks: array [0..maxChannels] of integer;
begin
  seriesMaxValue := mdCommonSettingsSERIES_MAX.Value;
  dataBlocks[0] := $0000;
  for i := 1 to maxChannels do
    dataBlocks[i]:= $0100 + i - 1;
  grData.Clear;
  // отправляем запросы
  // выключаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerMode, 0, 0, [$00]);
  // устанвливаем блок данных
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT16, MSG_DataBlock, 0, 0, dataBlocks);
  // устанавливаем децимацию
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerDecimation, 0, 0, [mdCommonSettingsDECIMATION.Value]);
  // включаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerMode, 0, 0, [mdCommonSettingsTRIGGER_TYPE.Value]);
end;

procedure TfmMainArielAquire.plOnTcpMessage(msgType: TTCPMessageType; msgText: AnsiString);
begin
  if(msgType = tmtConnected)then
  begin
    if plSet.pl.isConnected then plGetChannelsInfo();
    if plData.pl.isConnected then plStartAquisition();
    isConnected := true;
  end
  else if(msgType = tmtDisconnected)then
  begin
    isConnected := false;
  end
  else if(msgType = tmtError)then
  begin
    ShowMessage(msgText);
    isConnected := false;
  end;
end;

procedure TfmMainArielAquire.plDeviceResponse(header: TPLMessageHeader; var data: array of integer);
begin
  tvDeviceData.DataController.BeginFullUpdate;
  Case header.ID of
    MSG_DrvFreq: begin
      FDeviceInfoData.channelsInfo[header.Index2].frequency := data[0];
      tvDeviceData.DataController.Values[header.Index2, 1] := data[0];
    end;
    MSG_DrvAmpl: begin
      FDeviceInfoData.channelsInfo[header.Index2].drive := data[0];
      tvDeviceData.DataController.Values[header.Index2, 2] := Round(data[0]/10);
    end;
    MSG_MainAmp: begin
      FDeviceInfoData.channelsInfo[header.Index2].amplification := data[0];
      tvDeviceData.DataController.Values[header.Index2, 3] := Round(data[0]/10);
    end;
    MSG_FilterType: begin
      FDeviceInfoData.channelsInfo[header.Index2].filterType := data[0];
      tvDeviceData.DataController.Values[header.Index2, 4] := data[0];
    end;
    MSG_HiPass: begin
      FDeviceInfoData.channelsInfo[header.Index2].hiPass := data[0];
      tvDeviceData.DataController.Values[header.Index2, 5] := Round(data[0]/10);
    end;
    MSG_LoPass: begin
      FDeviceInfoData.channelsInfo[header.Index2].lowPass := data[0];
      tvDeviceData.DataController.Values[header.Index2, 6] := Round(data[0]/10);
    end;
    MSG_PreAmp: begin
      FDeviceInfoData.preAmp := data[0];
    end;
    MSG_UserLEvel: begin
      FUserMode := data[0];
    end;
    MSG_BalParam: begin
      //ShowMessage(IntToStr(data[0]));
    end;
    // дополнительные параметры
    MSG_Phase: FDeviceInfoData.addChannelsInfo[header.Index2].phase := data[0];
    MSG_SpreadX: FDeviceInfoData.addChannelsInfo[header.Index2].x_spread := data[0];
    MSG_SpreadY: FDeviceInfoData.addChannelsInfo[header.Index2].y_spread := data[0];
    MSG_DotPosX: FDeviceInfoData.addChannelsInfo[header.Index2].x_dot := data[0];
    MSG_DotPosY: FDeviceInfoData.addChannelsInfo[header.Index2].y_dot := data[0];
    MSG_MuxSamples: FDeviceInfoData.addChannelsInfo[header.Index2].mux_time := data[0];
    // мультиплексор и др.
    MSG_MuxStart: FDeviceInfoData.mux_start := data[0];
    MSG_MuxEnd: FDeviceInfoData.mux_finish := data[0];
    MSG_BWLimit: FDeviceInfoData.bwLimit := data[0];
  End;
  tvDeviceData.DataController.EndFullUpdate;
end;

procedure TfmMainArielAquire.plDeviceDataShow(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition);
var
  i: integer;
  numInD: integer;
  currentChannel: integer;
  isNewRound: boolean;
  CurrentDataValue: double;
  bAutoAction: boolean;

  function CheckAutoCondition(oldValue, CurValue: double; isAuto: boolean; condition: integer; thresh: double):boolean;
  begin
    Result := false;
    if isAuto then
    begin
      if condition = 1 then
        // больше (фронт возрастания)
        Result := (CurValue >= thresh) and (oldValue < thresh)
      else
        // меньше (фронт спада)
        Result := (CurValue <= thresh) and (oldValue > thresh);
    end;
  end;

begin
  currentChannel := -1;
  numInD := Length(data);
  for i := 0 to (numInD - 1) do
  begin
    // статус
    if ((data[i].statusDataValid shr 7) = 1)and
        (data[i].statusSlotAddress = 1)and
        (data[i].statusSubChannel = channel) then
    begin
      if grData.Count > seriesMaxValue then grData.Clear;
      grData.AddXY(data[i].dataX * 10 / 32768, data[i].dataY * 10 / 32768);
    end;
    // для случая сбора - запоминаем все это хозяйство в массив
    if bAquireData and((data[i].statusDataValid shr 7) = 1)and(data[i].statusSlotAddress = 1)then
    begin
      currentChannel := data[i].statusSubChannel;
      isNewRound := (currentChannel = 0);
      signalCollect.addDataPL(data[i], isNewRound);
    end;
    // отслеживание автоматического запуска и автоматической остановки
    if ((data[i].statusDataValid shr 7) = 1)and(data[i].statusSlotAddress = 1)and(data[i].statusSubChannel = (mdCommonSettingsAUTO_CHANNEL.Value - 1)) then
    begin
      if mdCommonSettingsAUTO_PART.Value = 1 then
        CurrentDataValue := data[i].dataX * 10 / 32768
      else
        CurrentDataValue := data[i].dataY * 10 / 32768;
    end
    else
      CurrentDataValue := OldDataValue;
    if bAquireData then
    begin
      // проверяем условия автоматической остановки
      bAutoAction := CheckAutoCondition(OldDataValue, CurrentDataValue, mdCommonSettingsAUTO_STOP.Value, mdCommonSettingsSTOP_CONDITION.Value, mdCommonSettingsSTOP_VALUE.Value);
      if bAutoAction then
        actFinishExecute(self);
    end
    else
    begin
      // проверяем условия автоматического запуска
      bAutoAction := CheckAutoCondition(OldDataValue, CurrentDataValue, mdCommonSettingsAUTO_START.Value, mdCommonSettingsSTART_CONDITION.Value, mdCommonSettingsSTART_VALUE.Value);
      if bAutoAction then
        actStartExecute(self);
    end;
    OldDataValue := CurrentDataValue;
  end;
end;

procedure TfmMainArielAquire.plDeviceGetTextInfo(header: TPLMessageHeader; var data: array of TTextResponse);
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 0 to Length(data) - 1 do
    s := s + data[i];
  FDeviceInfo := s;
end;

{$ENDREGION}

{$REGION 'Основной блок'}
procedure TfmMainArielAquire.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if isConnected then
  begin
    Action := caNone;
    ShowMessage('Необходимо сперва отсоединиться от прибора.');
  end
  else
  begin
    saveSettings();
    Action := caFree;
  end;
end;

procedure TfmMainArielAquire.FormCreate(Sender: TObject);
begin
  RootDir := ExtractFilePath(Application.ExeName);
  grData := TglGraph.Create(pnlGlGraps);
  grData.InitData;
  tm.Enabled := true;
  // параметры работы с прибором
  iAmpl := 0;
  isConnected := false;
  channel := 0;
  seriesMaxValue := 3000;
  ///
  FDeviceInfo := '';
  mdCommonSettings.Open;
  loadSettings();
  updateSetings();
  // загрузка параметров из файла
  loadPresetData(RootDir + 'ariel-config.ini');
  // состояние окна
  actAmplificationUp.ShortCut := ShortCut(VK_UP, [ssCtrl]);
  actAmplificationDown.ShortCut := ShortCut(VK_DOWN, [ssCtrl]);
  WindowState := wsMaximized;
  AmplificationChange();
  signalCollect := TSignalData.Create();
end;

procedure TfmMainArielAquire.loadPresetData(fName: string);
var i: integer;
begin
  FDevicePresetData := loadPresetIniData(fName);
  for i := 0 to maxChannels - 1 do
  begin
    FDeviceInfoData.channelsInfo[i].isActive := FDevicePresetData.channelsInfo[i].isActive;
    FDeviceInfoData.channelsInfo[i].bAbs := FDevicePresetData.channelsInfo[i].bAbs;
  end;
end;

procedure TfmMainArielAquire.FormDestroy(Sender: TObject);
begin
  mdCommonSettings.Close;
  signalCollect.FreeData;
  signalCollect.Free;
  grData.FreeData;
  grData.Free;
end;

procedure TfmMainArielAquire.FormPaint(Sender: TObject);
begin
  grData.PaintData(clYellow);
end;

procedure TfmMainArielAquire.pnlCollectResize(Sender: TObject);
begin
  grDeviceData.Height := 326;
end;

{$ENDREGION}

{$REGION 'Обработчики действий'}
procedure TfmMainArielAquire.actAboutExecute(Sender: TObject);
begin
  fmAbout := TfmAbout.Create(Application);
  fmAbout.ShowModal;
  fmAbout.Free;
end;

procedure TfmMainArielAquire.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMainArielAquire.actSaveExecute(Sender: TObject);
const
  ps: TPipeSettings = (zoneStart: 10; zoneFinish: 10; pipeLength: 1000);
var
  bSave: boolean;
begin
  sDlg.FileName := mdCommonSettingsDATA_FILE_PATH.Value + nextDataFileName;
  // сохранение файла
  if mdCommonSettingsSHOW_DLG.Value then
    bSave := sDlg.Execute()
  else
    bSave := true;
  if bSave then
  begin
    signalCollect.fillDeviceInfo(FDeviceInfoData);
    signalCollect.SaveData(sDlg.FileName);
    Inc(FCurrentFileIndex);
  end;
end;

procedure TfmMainArielAquire.actSettingsExecute(Sender: TObject);
begin
  // Установки
  mdCommonSettings.Edit;
  fmCommonSettings := TfmCommonSettings.Create(Self);
  fmCommonSettings.ShowModal;
  if fmCommonSettings.idRes = 1 then
  begin
    mdCommonSettings.Post;
    updateSetings();
  end
  else
  begin
    mdCommonSettings.Cancel;
  end;
  fmCommonSettings.Free;
end;

procedure TfmMainArielAquire.actSettingsUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := not isConnected;
  pnlCollect.Enabled := isConnected;
end;

procedure TfmMainArielAquire.actConnectExecute(Sender: TObject);
begin
  tmLic.Enabled := true;
  OldDataValue := 0.0;
  preConnectActions();
  // соединяемся с прибором
  plSet.Start;
  plData.Start;
  // прописываем параметры
  FDeviceInfoData.triggerType := mdCommonSettingsTRIGGER_TYPE.Value;
  FDeviceInfoData.decimation := mdCommonSettingsDECIMATION.Value;
end;

procedure TfmMainArielAquire.actConnectUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := not isConnected;
  pnlCollect.Enabled := isConnected;
end;

procedure TfmMainArielAquire.actDisconnectExecute(Sender: TObject);
begin
  // выключаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$00]);
  // отсоединяемся от прибора
  plSet.Finish;
  plData.Finish;
  // отсоединились и довольны
  postDisconnectActions();
  tmLic.Enabled := false;
end;

procedure TfmMainArielAquire.actDisconnectUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := (isConnected and (not bAquireData));
end;

procedure TfmMainArielAquire.actDeviceInfoExecute(Sender: TObject);
var
  i: integer;
begin
  fmDeviceInfo := TfmDeviceInfo.Create(Application);
  fmDeviceInfo.passData(FDeviceInfo);
  fmDeviceInfo.ShowModal;
  fmDeviceInfo.Free;
end;

procedure TfmMainArielAquire.actDeviceSettingsExecute(Sender: TObject);
var
  i:integer;
begin
  fmDeviceSettings := TfmDeviceSettings.Create(Application);
  // копируем данные для редактирования настроек
  fmDeviceSettings.loadData(FDeviceInfoData);
  fmDeviceSettings.ShowModal;
  if fmDeviceSettings.idRes = 1 then
  begin
    // все измененные данные отправляем запрос на изменение
    if fmDeviceSettings.bPreAmpChanged then
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_PreAmp, 0, 0, [StrToInt(fmDeviceSettings.edPreAmp.Text) * 10]);
    if fmDeviceSettings.bBWLimitChanged then
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_BWLimit, 0, 0, [fmDeviceSettings.edBWLimit.EditValue]);
    fmDeviceSettings.mdDeviceData.DisableControls;
    fmDeviceSettings.mdDeviceData.First;
    while not fmDeviceSettings.mdDeviceData.Eof do
    begin
      if (fmDeviceSettings.mdDeviceDataCHANGED.Value) then
      begin
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DrvFreq, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataFREQ.Value]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DrvAmpl, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataDRV.Value * 10]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_MainAmp, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataAMP.Value * 10]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_FilterType, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataFILTER_TYPE.Value]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_HiPass, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataHIGH_PASS.Value * 10]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_LoPass, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataLOW_PASS.Value * 10]);
        ///
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_Phase, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataPHASE.Value * 10]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_SpreadX, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataSPREADX.Value * 10]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_SpreadY, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataSPREADY.Value * 10]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DotPosX, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataDOTX.Value]);
        plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DotPosY, 0, fmDeviceSettings.mdDeviceDataID.Value - 1, [fmDeviceSettings.mdDeviceDataDOTY.Value]);
      end;
      fmDeviceSettings.mdDeviceData.Next;
    end;
    fmDeviceSettings.mdDeviceData.EnableControls;
  end;
  fmDeviceSettings.mdDeviceData.Close;
  fmDeviceSettings.Free;
end;

procedure TfmMainArielAquire.actUserModeExecute(Sender: TObject);
var um: integer;
begin
  // смена пользовательского режима
  fmUserMode := TfmUserMode.Create(Application);
  fmUserMode.setUserLevelValue(FUserMode);
  fmUserMode.ShowModal;
  if fmUserMode.iRes = 1 then
  begin
    if fmUserMode.cb.ItemIndex = 0 then
      um := 1
    else
      um := 15;
    plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_UserLEvel, 0, 0, [um]);
  end;
  fmUserMode.Free;
end;

procedure TfmMainArielAquire.actBallanceExecute(Sender: TObject);
begin
  // балансировка
  //plSet.pl.sendData(MSG_TYPE_COMMAND, DATA_TYPE_NONE, MSG_Balance, CH_ALL, 0, []);

end;

{$ENDREGION}

{$REGION 'Сбор информации'}
procedure TfmMainArielAquire.AmplificationChange();
var
  m: double;
begin
  m := 10 * exp(-iAmpl * ln(2));
  grData.SetAmplitude(m);
  lbAmp.Caption := 'Amp.: ' + FloatToStrF(m, ffGeneral, 4, 4) + ' V';
end;

procedure TfmMainArielAquire.UpdateStatusPanel;
begin
  getFileName;
  // показываем в интерфейсе измененные значения настроечных параметров
  stBar.Panels[0].Text := 'IP: ' + mdCommonSettingsIP.Value;
  stBar.Panels[1].Text := 'Path: ' + mdCommonSettingsDATA_FILE_PATH.Value;
  stBar.Panels[2].Text := 'File: ' + nextDataFileName;
end;

procedure TfmMainArielAquire.actAmplificationDownExecute(Sender: TObject);
begin
  if iAmpl > -20 then Dec(iAmpl);
  AmplificationChange();
end;

procedure TfmMainArielAquire.actAmplificationUpExecute(Sender: TObject);
begin
  if iAmpl < 20 then Inc(iAmpl);
  AmplificationChange();
end;

procedure TfmMainArielAquire.tmLicTimer(Sender: TObject);
begin
  if not lv.isLicenseValid() then
  begin
    ShowMessage('Ключ защиты не обнаружен. Программа будет закрыта.');
    Application.Terminate;
  end;
end;

procedure TfmMainArielAquire.tmTimer(Sender: TObject);
begin
  InvalidateRect(Handle, nil, false);
end;

procedure TfmMainArielAquire.tvDeviceDataCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  channel := ACellViewInfo.GridRecord.Values[0] - 1;
  AHandled := true;
end;

procedure TfmMainArielAquire.actStartExecute(Sender: TObject);
begin
  // готовим данные для заполнения
  signalCollect.InitData;
  grData.Clear;
  // включаем запись
  bAquireData := true;
end;

procedure TfmMainArielAquire.actStartUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := isConnected and (not bAquireData);
  if bAquireData then
    pnlCollect.Color := clRed
  else
    pnlCollect.Color := clBtnFace;
end;

procedure TfmMainArielAquire.actFinishExecute(Sender: TObject);
begin
  // останавливаем запись
  bAquireData := false;
  // готовимся к сохранению данных в файл
  actSaveExecute(Sender);
  // обновляем имя файла для сохранения
  UpdateStatusPanel();
end;

procedure TfmMainArielAquire.actFinishUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := isConnected and (bAquireData);
end;

{$ENDREGION}

{$REGION 'Настройки и автоматизация сбора'}
procedure TfmMainArielAquire.loadSettings();
var
  fName: string;
  isLoaded: boolean;
begin
  isLoaded := false;
  fName := RootDir + fileNameSettingsAquire;
  if FileExists(fName) then
  begin
    try
      mdCommonSettings.LoadFromBinaryFile(fName);
      isLoaded := true;
    except
      isLoaded := false;
    end;
  end;
  if not isLoaded then
  begin
    // если не получилось загрузить - задаем значения по умолчанию
    mdCommonSettings.Append;
    mdCommonSettingsIP.Value := '10.8.2.218';
    mdCommonSettingsDECIMATION.Value := 800;
    mdCommonSettingsSERIES_MAX.Value := 5000;
    mdCommonSettingsFNAME1.Value := '000';
    mdCommonSettingsFNAME2.Value := '000';
    mdCommonSettingsFNAME3.Value := '000';
    mdCommonSettingsPART_INC.Value := 3;
    mdCommonSettingsDATA_FILE_PATH.Value := RootDir;
    mdCommonSettingsPRIORITY.Value := 3;
    mdCommonSettingsSHOW_DLG.Value :=true;
    mdCommonSettingsAUTO_START.Value := false;
    mdCommonSettingsAUTO_STOP.Value := false;
    mdCommonSettingsSTART_CONDITION.Value := 1;
    mdCommonSettingsSTOP_CONDITION.Value := 1;
    mdCommonSettingsSTART_VALUE.Value := 10.0;
    mdCommonSettingsSTOP_VALUE.Value := 10.0;
    mdCommonSettingsAUTO_CHANNEL.Value := 1;
    mdCommonSettingsAUTO_PART.Value := 1;
    mdCommonSettingsTRIGGER_TYPE.Value := 1;
    mdCommonSettings.Post;
  end;
end;

procedure TfmMainArielAquire.saveSettings();
begin
  mdCommonSettings.SaveToBinaryFile(RootDir + fileNameSettingsAquire);
end;

procedure TfmMainArielAquire.updateSetings();
var
  s0: string;
begin
  if mdCommonSettingsPART_INC.Value = 1 then
  begin
    s0 := mdCommonSettingsFNAME1.Value;
  end
  else if mdCommonSettingsPART_INC.Value = 2 then
  begin
    s0 := mdCommonSettingsFNAME2.Value;
  end
  else if mdCommonSettingsPART_INC.Value = 3 then
  begin
    s0 := mdCommonSettingsFNAME3.Value;
  end;
  while (Length(s0) > 0)and(s0[1] = '0') do Delete(s0, 1, 1);
  if Length(s0) = 0 then
    FCurrentFileIndex := 0
  else
    FCurrentFileIndex := StrToInt(s0);
  UpdateStatusPanel;
end;

procedure TfmMainArielAquire.preConnectActions();
begin
  ///
  plSet := TPLThreadProcessorSettings.Create(mdCommonSettingsIP.Value);
  plSet.pl.FreeOnTerminate := true;
  plSet.pl.Priority := TThreadPriority(mdCommonSettingsPRIORITY.Value);
  plSet.pl.OnTCPMessage := plOnTcpMessage;
  plSet.pl.OnDeviceResponse := plDeviceResponse;
  plSet.pl.OnDeviceGetTextInfo := plDeviceGetTextInfo;
  ///
  plData := TPLThreadProcessorData.Create(mdCommonSettingsIP.Value);
  plData.pl.FreeOnTerminate := true;
  plData.pl.Priority := TThreadPriority(mdCommonSettingsPRIORITY.Value);
  plData.pl.OnTCPMessage := plOnTcpMessage;
  plData.pl.OnDeviceResponse := plDeviceResponse;
  plData.pl.OnDeviceDataShow := plDeviceDataShow;
end;

procedure TfmMainArielAquire.postDisconnectActions();
begin
  ///
  plSet.Free;
  plData.Free;
end;

procedure TfmMainArielAquire.getFileName();
var
  s, s0: string;
begin
  s0 := IntToStr(FCurrentFileIndex);
  while length(s0) < 3 do s0 := '0' + s0;
  s := 'DAP';
  if mdCommonSettingsPART_INC.Value = 1 then
  begin
    s := s + s0 + 'P' + mdCommonSettingsFNAME2.Value + 'P' + mdCommonSettingsFNAME3.Value;
  end
  else if mdCommonSettingsPART_INC.Value = 2 then
  begin
    s := s + mdCommonSettingsFNAME1.Value + 'P' + s0 + 'P' + mdCommonSettingsFNAME3.Value;
  end
  else if mdCommonSettingsPART_INC.Value = 3 then
  begin
    s := s + mdCommonSettingsFNAME1.Value + 'P' + mdCommonSettingsFNAME2.Value + 'P' + s0;
  end;
  s := s + '.dar';
  nextDataFileName := s;
end;
{$ENDREGION}

end.
