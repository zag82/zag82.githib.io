unit libMain;

interface

uses
  PLData, PLThread, PLThreadProcData, PLThreadProcessor, PLThreadProcSettings,
  SignalData, ComPlx;

type
  TSettingsPack = record
    IP: string;
    decimation: integer;
    triggerType: integer;
  end;

type
  TDefect = packed record
	  pos1: integer;	// граница начала индикации
    pos2: integer;	// граница конца индикации
    center: double; // координата центра индикации (в мм относительно начала изделия)
    volume: double; // объём дефекта в индикации (0, если невозможно измерить)
    quality: integer; // результат классификации из набора констант: AR_CLASS_None, AR_CLASS_Proper, AR_CLASS_Recontrol или AR_CLASS_Waste
    channel: integer; // канал по которому производится браковка
    orientation: integer; // азимутальный размер дефекта
    probe1: integer; // начальный датчик, сработавший на этой индикации
    probe2: integer; // конечный датчик, сработавший на этой индикации
    defectType: integer; // тип дефекта 0-внешний, 1-внутренний
    res3: integer; // зарезервировано для будущего использования
    dres0: double; // зарезервировано для будущего использования
    dres1: double; // зарезервировано для будущего использования
    dres2: double; // зарезервировано для будущего использования
    dres3: double; // зарезервировано для будущего использования
  end;

  TLibMain = class
  private
    function getTDefect(dp: TDefectParams): TDefect;
  private
    FCounterLimit: integer;
    FCounter: integer;
    ///
    FState: integer;
    FPipeSettings: TPipeSettings;
    FSettingsPack: TSettingsPack;
    { Private declarations }
    FConnectResult: integer;
    FDeviceInfo: TDeviceInfo;
    FDevicePresetData: TDeviceInfo;
    FAquireData: boolean;
    procedure setAquireData(value: boolean);
    procedure plGetChannelsInfo();
    procedure plStartAquisition();
    procedure plOnTcpMessage(msgType: TTCPMessageType; msgText: AnsiString);
    procedure plDeviceResponse(header: TPLMessageHeader; var data: array of integer);
    procedure plDeviceData(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition);
  public
    // элементы сбора данных
    isConnected: boolean;
    plSet: TPLThreadProcessorSettings;
    plData: TPLThreadProcessorData;
    signalCollect: TSignalData;
    procedure InitData();
    function FreeData(): integer;
    // настройка и подготовка данных
    function LoadSettings(fName: string): integer;
    // работа с прибором
    function DeviceConnect(): integer;
    function DeviceDisconnect(): integer;
    function DeviceCheckConnection(var connected: boolean): integer;
    // сбор данных
    property bAquireData: boolean read FAquireData write SetAquireData;
    function presetDevice(): integer;
    function presetPipe(ps: TPipeSettings): integer;
    function startAquireData(): integer;
    function stopAquireData(): integer;
    // настройки обработки
    function calibrationPrepare(): integer;
    function calibrationStart(defs: Pointer; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double): integer;
    function calibrationCheck(defs: Pointer; nDefs: integer; frameWidth: double; var isCorrect: boolean): integer;
    function calibrationTestDevice(defs: Pointer; nDefs: integer; frameWidth: double; defParams: Pointer): integer;
    // получение результатов
    function getDataCount(var cnt: integer): integer;
    function getDataChannelParams(iChannel: integer; var ci: TChannelInfo): integer;
    function setDataChannelParams(iChannel: integer; ci: TChannelInfo): integer;
    // обработка данных
    function getAquiredData(iChannel: integer; pa: Pointer): integer;
    function getProcessedData(iChannel: integer; var zonePos1, zonePos2: integer; pa: Pointer): integer;
    // результаты обработки
    function getProcessingResult(var qResult: integer): integer;
    function getIndicationsCount(var cnt: integer): integer;
    function getIndicationsList(pd: Pointer): integer;
  end;

var
  lm: TLibMain;

implementation

uses libOperationData, SysUtils, DateUtils;

{$REGION 'PL'}
procedure TLibMain.setAquireData(value: boolean);
begin
  FAquireData := value;
end;

procedure TLibMain.plGetChannelsInfo();
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
end;

procedure TLibMain.plStartAquisition();
var
  i: integer;
  dataBlocks: array [0..maxChannels] of integer;
begin
  dataBlocks[0] := $0000;
  for i := 1 to maxChannels do
    dataBlocks[i]:= $0100 + i - 1;
  // отправляем запросы
  // выключаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerMode, 0, 0, [$00]);
  // устанвливаем блок данных
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT16, MSG_DataBlock, 0, 0, dataBlocks);
  // устанавливаем децимацию
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerDecimation, 0, 0, [FSettingsPack.decimation]);
  // включаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerMode, 0, 0, [FSettingsPack.triggerType]);
end;

procedure TLibMain.plOnTcpMessage(msgType: TTCPMessageType; msgText: AnsiString);
begin
  if(msgType = tmtConnected)then
  begin
    if plSet.pl.isConnected and plData.pl.isConnected then plStartAquisition();
    isConnected := true;
    FState := AR_STATE_Connected;
    FConnectResult := AR_OK;
  end
  else if(msgType = tmtDisconnected)then
  begin
    isConnected := false;
    FState := AR_STATE_Disconnected;
    FConnectResult := AR_OK;
  end
  else if(msgType = tmtError)then
  begin
    FConnectResult := AR_ConnectionError;
    isConnected := false;
    if FState = AR_STATE_Connected then FState := AR_STATE_Disconnected;
  end;
end;

procedure TLibMain.plDeviceResponse(header: TPLMessageHeader; var data: array of integer);
const
  CPresetParams:array[0..6]of integer = (MSG_DrvFreq, MSG_DrvAmpl, MSG_MainAmp, MSG_FilterType, MSG_HiPass, MSG_LoPass, MSG_PreAmp);
var
  i: integer;
begin
  Case header.ID of
    MSG_DrvFreq: FDeviceInfo.channelsInfo[header.Index2].frequency := data[0];
    MSG_DrvAmpl: FDeviceInfo.channelsInfo[header.Index2].drive := data[0];
    MSG_MainAmp: FDeviceInfo.channelsInfo[header.Index2].amplification := data[0];
    MSG_FilterType: FDeviceInfo.channelsInfo[header.Index2].filterType := data[0];
    MSG_HiPass: FDeviceInfo.channelsInfo[header.Index2].hiPass := data[0];
    MSG_LoPass: FDeviceInfo.channelsInfo[header.Index2].lowPass := data[0];
    MSG_PreAmp: FDeviceInfo.preAmp := data[0];
  End;
  for i := 0 to high(CPresetParams) do
    if header.ID = CPresetParams[i] then
    begin
      Inc(FCounter);
      break;
    end;
end;

procedure TLibMain.plDeviceData(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition);
var
  i: integer;
  numInD: integer;
  currentChannel: integer;
  isNewRound: boolean;
begin
  numInD := Length(data);
  for i := 0 to (numInD - 1) do
  begin
    // для случая сбора - запоминаем все это хозяйство в массив
    if ((data[i].statusDataValid shr 7) = 1)and
        (data[i].statusSlotAddress = 1)and
        bAquireData then
    begin
      currentChannel := data[i].statusSubChannel;
      isNewRound := (currentChannel = 0);
      signalCollect.addDataPL(data[i], isNewRound);
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Основной блок'}
procedure TLibMain.InitData();
var
  i: integer;
begin
  // параметры работы с прибором
  FPipeSettings.zoneStart := 0.0;
  FPipeSettings.zoneFinish := 0.0;
  FPipeSettings.pipeLength := 1000;
  FState := AR_STATE_Disconnected;
  isConnected := false;
  FConnectResult := AR_OK;
  ///
  for i := 0 to maxChannels - 1 do
  begin
    FDeviceInfo.channelsInfo[i].bAbs := (i in [2, 6, 10, 14]);
    FDeviceInfo.channelsInfo[i].isActive := not (i in [3, 7, 11, 15]);
  end;
  signalCollect := TSignalData.Create();
  signalCollect.setAddParams(true, 0.5, 0.5); // TODO: check value for Gennady
end;

function TLibMain.FreeData(): integer;
begin
  if FState = AR_STATE_Disconnected then
  begin
    signalCollect.FreeData;
    signalCollect.Free;
    FState := AR_STATE_NotInited;
    Result := AR_Ok;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.LoadSettings(fName: string): integer;
begin
  if FState = AR_STATE_Disconnected then
  begin
    Result := AR_Ok;
    try
      if FileExists(fName) then
      begin
        FDevicePresetData := loadPresetIniData(fName);
        FSettingsPack.IP := IntToStr(FDevicePresetData.ip1) + '.' + IntToStr(FDevicePresetData.ip2) + '.' + IntToStr(FDevicePresetData.ip3) + '.' + IntToStr(FDevicePresetData.ip4);
        FSettingsPack.decimation := FDevicePresetData.decimation;
        FSettingsPack.triggerType := FDevicePresetData.triggerType;
      end
      else
        Result := AR_SettingsNotLoaded;
    except
      Result := AR_SettingsNotLoaded;
    end;
  end
  else
    Result := AR_NotSuppportedOperation;
end;
{$ENDREGION}

{$REGION 'Работа с прибором'}
function TLibMain.DeviceConnect(): integer;
begin
  if FState = AR_STATE_Disconnected then
  begin
    ///
    plSet := TPLThreadProcessorSettings.Create(FSettingsPack.IP);
    plSet.pl.FreeOnTerminate := true;
    plSet.pl.OnTCPMessage := plOnTcpMessage;
    plSet.pl.OnDeviceResponse := plDeviceResponse;
    plSet.pl.setSyncState(false);
    ///
    plData := TPLThreadProcessorData.Create(FSettingsPack.IP);
    plData.pl.FreeOnTerminate := true;
    plData.pl.OnTCPMessage := plOnTcpMessage;
    plData.pl.OnDeviceResponse := plDeviceResponse;
    plData.pl.OnDeviceDataShow := plDeviceData;
    plData.pl.setSyncState(false);
    ///
    plSet.Start;
    plData.Start;
    FConnectResult := AR_OK;
    ///
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.DeviceDisconnect(): integer;
begin
  if FState = AR_STATE_Connected then
  begin
    // выключаем триггер
    plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_TriggerMode, 0, 0, [$00]);
    // отсоединяемся от прибора
    plSet.Finish;
    plData.Finish;
    FState := AR_STATE_Disconnected;
    FConnectResult := AR_OK;
    // отсоединились и довольны
    plSet.Free;
    plData.Free;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.DeviceCheckConnection(var connected: boolean): integer;
begin
  connected := isConnected;
  Result := FConnectResult;
end;
{$ENDREGION}

{$REGION 'Сбор данных'}
function TLibMain.presetDevice(): integer;
begin
  if FState = AR_STATE_Connected then
  begin
    // загоняем в прибор все заранее предопределенные настройки
    FCounterLimit := 6 * 16 + 1;
    FCounter := 0;
    plGetChannelsInfo();
    while FCounter < FCounterLimit do
      Sleep(100);
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.presetPipe(ps: TPipeSettings): integer;
begin
  if FState = AR_STATE_Connected then
  begin
    // сохраняем параметры
    FPipeSettings := ps;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.startAquireData(): integer;
begin
  if FState = AR_STATE_Connected then
  begin
    // готовим данные для заполнения
    signalCollect.InitData;
    // включаем запись
    FState := AR_STATE_DataAquire;
    bAquireData := true;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.stopAquireData(): integer;
var
  sMonth, sDay, sRec: string;
  fMask, fName: string;
  iRec, iFileNumber: integer;
  sr: TSearchRec;

  function getFileNumber(f: string; iPart: integer): integer;
  begin
    Result := 0;
  end;

begin
  if FState = AR_STATE_DataAquire then
  begin
    // останавливаем запись
    bAquireData := false;
    signalCollect.fillDeviceInfo(FDeviceInfo);
    signalCollect.doPreProcessing(FPipeSettings);
    signalCollect.doPostProcessing();
    if NEED_STORE_LIB then
    begin
      sDay := IntToStr(DayOfTheMonth(now));
      while length(sDay) < 3 do sDay  := '0' + sDay;
      sMonth := IntToStr(MonthOfTheYear(now));
      while length(sMonth) < 3 do sMonth  := '0' + sMonth;
      fMask := 'DAP' + sMonth + 'P' + sDay + 'P';
      iRec := 0;
      if FindFirst(LIB_STORAGE_PATH + fMask + '*.dar', faAnyFile, sr) = 0 then
      begin
        repeat
          iFileNumber := getFileNumber(sr.Name, 3);
          if iFileNumber > iRec  then
            iRec := iFileNumber;
        until FindNext(sr) <> 0;
        FindClose(sr);
      end;
      sRec := IntToStr(iRec + 1);
      while length(sRec) < 3 do sRec := '0' + sRec;
      fName := LIB_STORAGE_PATH + fMask + sRec + '.dar';
      signalCollect.SaveData(fName);
    end;
    FState := AR_STATE_Connected;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

{$ENDREGION}

{$REGION 'настройки обработки'}
function TLibMain.calibrationPrepare(): integer;
begin
  if FState = AR_STATE_Connected then
  begin
    signalCollect.doCalibStart();
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;

end;

function TLibMain.calibrationStart(defs: Pointer; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double): integer;
type
  TCalibArray = array[0..0]of TCalibDefect;
  PCalibArray = ^TCalibArray;
var
  i: integer;
  cd: TCalibDefect;
  pc: PCalibArray;
  d: array of TCalibDefect;
begin
  if FState = AR_STATE_Connected then
  begin
    SetLength(d, nDefs);
    pc := defs;
    {$R-}
    for i := 0 to nDefs - 1 do
    begin
      cd := pc^[i];
      d[i] := cd;
    end;
    {$R+}
    signalCollect.doCalib(d, nDefs, iDefect, frameWidth, calibValue, CalibThreshold);
    d := nil;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.calibrationCheck(defs: Pointer; nDefs: integer; frameWidth: double; var isCorrect: boolean): integer;
type
  TCalibArray = array[0..0]of TCalibDefect;
  PCalibArray = ^TCalibArray;
var
  i: integer;
  cd: TCalibDefect;
  pc: PCalibArray;
  d: array of TCalibDefect;
begin
  if FState = AR_STATE_Connected then
  begin
    SetLength(d, nDefs);
    pc := defs;
    {$R-}
    for i := 0 to nDefs - 1 do
    begin
      cd := pc^[i];
      d[i] := cd;
    end;
    {$R+}
    isCorrect := signalCollect.doCalibCheck(d, nDefs, frameWidth);
    d := nil;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.calibrationTestDevice(defs: Pointer; nDefs: integer; frameWidth: double; defParams: Pointer): integer;
type
  TCalibArray = array[0..0]of TCalibDefect;
  PCalibArray = ^TCalibArray;
  TDefsArray = array[0..0]of TDefect;
  PDefsArray = ^TDefsArray;
var
  i: integer;
  cd: TCalibDefect;
  df: TDefect;
  pcArray: PCalibArray;
  ppArray: PDefsArray;
  d: array of TCalibDefect;
  p: array of TDefectParams;
begin
  if FState = AR_STATE_Connected then
  begin
    // выделение памяти и подключение переменных к указателям
    SetLength(d, nDefs);
    SetLength(p, nDefs);
    pcArray := defs;
    ppArray := defParams;
    // передача данных о дефектах
    {$R-}
    for i := 0 to nDefs - 1 do
    begin
      cd := pcArray^[i];
      d[i] := cd;
    end;
    {$R+}
    // обработка данных
    signalCollect.doCalibTestD(d, nDefs, frameWidth, p);
    // передача данных о параметрах дефектов
    {$R-}
    for i := 0 to nDefs - 1 do
    begin
      df := getTDefect(p[i]);
      ppArray^[i] := df;
    end;
    {$R+}
    // очистка памяти и выход
    d := nil;
    p := nil;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

{$ENDREGION}

{$REGION 'получение результатов'}
function TLibMain.getDataCount(var cnt: integer): integer;
begin
  if FState in [AR_STATE_Connected, AR_STATE_Disconnected] then
  begin
    cnt := signalCollect.Count;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.getDataChannelParams(iChannel: integer; var ci: TChannelInfo): integer;
begin
  if FState in [AR_STATE_Connected, AR_STATE_Disconnected] then
  begin
    if (iChannel >= 0) and (iChannel < maxChannels) then
    begin
      ci := FDeviceInfo.channelsInfo[iChannel];
      Result := AR_OK;
    end
    else
      Result := AR_WRONG_CHANNEL;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.setDataChannelParams(iChannel: integer; ci: TChannelInfo): integer;
begin
  if FState in [AR_STATE_Connected] then
  begin
    if (iChannel >= 0) and (iChannel < maxChannels) then
    begin
      FCounterLimit := 6;
      FCounter := 0;
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DrvFreq, 0, iChannel, [ci.frequency]);
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_DrvAmpl, 0, iChannel, [ci.drive]);
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_MainAmp, 0, iChannel, [ci.amplification]);
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_FilterType, 0, iChannel, [ci.filterType]);
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_HiPass, 0, iChannel, [ci.hiPass]);
      plSet.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, MSG_LoPass, 0, iChannel, [ci.lowPass]);
      while FCounter < FCounterLimit do
        Sleep(10);
      Result := AR_OK;
    end
    else
      Result := AR_WRONG_CHANNEL;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

{$ENDREGION}

{$REGION 'Обработка данных'}
function TLibMain.getAquiredData(iChannel: integer; pa: Pointer): integer;
type
  TCXArray = array[0..0]of TComplex;
  PCXArray = ^TCXArray;
var
  i: integer;
  cx: TComplex;
  pc: PCXArray;
begin
  if FState in [AR_STATE_Connected, AR_STATE_Disconnected] then
  begin
    if (iChannel >= 0) and (iChannel < maxChannels) then
    begin
      try
        pc := pa;
        {$R-}
        for i := 0 to signalCollect.Count - 1 do
        begin
          cx := signalCollect.getData(iChannel, i, true);
          pc^[i] := cx;
        end;
        {$R+}
        Result := AR_OK;
      except
        Result := AR_WRONG_DATA_BUFFER;
      end;
    end
    else
      Result := AR_WRONG_CHANNEL;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.getProcessedData(iChannel: integer; var zonePos1, zonePos2: integer; pa: Pointer): integer;
type
  TCXArray = array[0..0]of TComplex;
  PCXArray = ^TCXArray;
var
  i: integer;
  cx: TComplex;
  pc: PCXArray;
begin
  if FState in [AR_STATE_Connected, AR_STATE_Disconnected] then
  begin
    if (iChannel >= 0) and (iChannel < maxChannels)and(signalCollect.ProcessingParams.isProcessed) then
    begin
      try
        zonePos1 := signalCollect.ProcessingParams.position1;
        zonePos2 := signalCollect.ProcessingParams.position2;
        pc := pa;
        {$R-}
        for i := 0 to signalCollect.Count - 1 do
        begin
          if(i < zonePos1)or(i > zonePos2)then
            cx := CNull
          else
          begin
            cx := signalCollect.getData(iChannel, i, false);
          end;
          pc^[i] := cx;
        end;
        {$R+}
        Result := AR_OK;
      except
        Result := AR_WRONG_DATA_BUFFER;
      end;
    end
    else
      Result := AR_WRONG_CHANNEL;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

{$ENDREGION}

{$REGION 'результаты обработки'}
function TLibMain.getTDefect(dp: TDefectParams): TDefect;
var
  df: TDefect;
begin
  // преобразует структуру внутреннего представления информации о дефекте к виду для экспорта в библиотеку
  df.pos1 := dp.pos1;
  df.pos2 := dp.pos2;
  df.center := (dp.posx - signalCollect.ProcessingParams.position1) * signalCollect.ProcessingParams.step;
  df.volume := dp.volume;
  df.quality := Ord(dp.qualityRes);
  df.channel := dp.channel;
  df.orientation := 90 * dp.nProbesIndication;
  df.probe1 := dp.probe1;
  df.probe2 := dp.probe2;
  df.defectType := Ord(dp.defectType);
  ///
  df.res3 := 3;
  df.dres0 := 0.0;
  df.dres1 := 0.0;
  df.dres2 := 0.0;
  df.dres3 := 0.0;
  ///
  Result := df;
end;

function TLibMain.getProcessingResult(var qResult: integer): integer;
begin
  if (FState in [AR_STATE_Connected, AR_STATE_Disconnected]) and (signalCollect.ProcessingParams.isProcessed) then
  begin
    qResult := Ord(signalCollect.ProcessingParams.qualityRes);
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.getIndicationsCount(var cnt: integer): integer;
begin
  if (FState in [AR_STATE_Connected, AR_STATE_Disconnected]) and (signalCollect.ProcessingParams.isProcessed) then
  begin
    cnt := signalCollect.ProcessingDefects.Count;
    Result := AR_OK;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

function TLibMain.getIndicationsList(pd: Pointer): integer;
type
  TDefsArray = array[0..0]of TDefect;
  PDefsArray = ^TDefsArray;
var
  i: integer;
  df: TDefect;
  pDefs: PDefsArray;
begin
  if (FState in [AR_STATE_Connected, AR_STATE_Disconnected]) and (signalCollect.ProcessingParams.isProcessed) then
  begin
    try
      pDefs := pd;
      {$R-}
      for i := 0 to signalCollect.ProcessingDefects.Count - 1 do
      begin
        df := getTDefect(signalCollect.ProcessingDefects.Items[i]);
        pDefs^[i] := df;
      end;
      {$R+}
      Result := AR_OK;
    except
      Result := AR_WRONG_DATA_BUFFER;
    end;
  end
  else
    Result := AR_NotSuppportedOperation;
end;

{$ENDREGION}

end.
