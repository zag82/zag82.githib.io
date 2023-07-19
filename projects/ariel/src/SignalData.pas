unit SignalData;

interface

uses PLData, ComPlx, Generics.Collections, Graphics;

const
  MAX_PROBES = 4;
  QualityResultColors: array [0..3] of TColor = (clWhite, clLime, clYellow, clRed);
  DefectTypeStringNames: array [0..2] of AnsiString = ('EXT', 'INT', '');

var
  NEED_STORE_LIB: boolean;
  LIB_STORAGE_PATH: string;

type
  TClassificatorStruct = record
    ph1: double;
    ph2: double;
    phb: double;
    pha1: double;
    pha2: double;
    // параметры для внутренних дефектов
    a1: array[0..MAX_PROBES - 1] of double;
    b1: array[0..MAX_PROBES - 1] of double;
    // параметры для внешних дефектов
    a2: array[0..MAX_PROBES - 1] of double;
    b2: array[0..MAX_PROBES - 1] of double;
    // пороги разбраковки
    v1: double;
    v2: double;
    va: double;
    vnd: double;
  end;

const
  kf:double = 10 / 32768;
  maxChannels = 16; // физическое количество каналов в приборе
  fileHeaderSize = 2048; // размер шапки файла с данными
  versionNumber:integer = 1; // номер версии файлов данных

  PHASE_CALIB: double = -75.0;
  PROC_CLASS_DEFAULT: TClassificatorStruct = (ph1: -130; ph2: -55; phb: -90; pha1: 45; pha2: 130;
          a1: (1.0, 1.0, 1.0, 1.0);
          b1: (0.0, 0.0, 0.0, 0.0);
          a2: (1.0, 1.0, 1.0, 1.0);
          b2: (0.0, 0.0, 0.0, 0.0);
          v1: 2.2; v2: 3.0; va: 3.5; vnd: 0.5);

  // настройки системы (из файла потом)
  PROC_THRESH_PREP: double = 7;    // связано с усилениями по каналам (нам важен канал 1)
  PROC_MASK_EXTRACT: double = 5.0; // связано с базой ВТП

var
  PROC_THRESH_EXTRACT: double = 2.0;   // должно быть пересчитано при калибровке

type
  TSignalLine = array [0..maxChannels-1] of TComplexInt;

  TChannelInfo = record
    frequency: integer;
    drive: integer;
    amplification: integer;
    filterType: integer;
    hiPass: integer;
    lowPass: integer;
    bAbs: boolean;
    isActive: boolean;
  end;

  TChannelAddInfo = record
    phase: integer;
    x_spread: integer;
    y_spread: integer;
    x_dot: integer;
    y_dot: integer;
    mux_time: integer;
  end;

  TDeviceChannelParametersList = array [0..maxChannels-1] of TChannelInfo;
  TDeviceChannelAddParametersList = array [0..maxChannels-1] of TChannelAddInfo;

  TDeviceInfo = record
    channelsInfo: TDeviceChannelParametersList;
    preAmp: integer;
    addChannelsInfo: TDeviceChannelAddParametersList;
    triggerType: integer;
    decimation: integer;
    bwLimit: integer;
    mux_start: integer;
    mux_finish: integer;
    ip1: byte;
    ip2: byte;
    ip3: byte;
    ip4: byte;
    buf: array [1..(fileHeaderSize - (4 * 6 + 4) - sizeOf(TDeviceChannelParametersList) - sizeOf(TDeviceChannelAddParametersList))]of byte;
  end;

  TQualityResults = (qrNone = 0, qrGood, qrRecontrol, qrBad, qrNotDefect);
  TDefectType = (dtExternal = 0, dtInternal, dtNone);
  TProbeIndex = 0..3;
  TProbeSet = set of TProbeIndex;

  TExtractFrames = packed record
    pos1: integer;    // начало рамки
    pos2: integer;    // конец рамки
    posx: integer;    // центр рамки
    channel: integer; // канал, на котором выделена рамка
    mValue: double;   // максимальное значение функции преобразования внутри рамки
    valid: boolean;   // должна остаться в конечном списке рамка или нет
    am: double;
    ph: double;
    qr: TQualityResults;
    vl: double;
  end;

  TDefectParams = packed record
    // координаты
    pos1: integer;   // начало рамки
    pos2: integer;   // конец рамки
    posx: integer;   // центр рамки
    probe1: integer; // начальный датчик, сработавший на этой индикации
    probe2: integer; // конечный датчик, сработавший на этой индикации
    probeSet: TProbeSet;
    // параметры
    volume: double;
    channel: integer;
    nProbesIndication: integer; // количество сработавших датчиков
    qualityRes: TQualityResults; // результат классификации дефекта
    defectType: TDefectType; // тип дефекта
    // вспомогательные поля
    valid: boolean;   // должна остаться в конечном списке рамка или нет
  end;

  TProcData = packed record
    isProcessed: boolean;
    step: double;
    raw_p1: integer;    // границы трубки полностью (без учета зоны контроля)
    raw_p2: integer;
    position1: integer; // границы с учетом зоны неконтроля
    position2: integer;
    avg: array [0..maxChannels-1] of TComplex;
    eta: array [0..maxChannels-1] of TComplex;
    qualityRes: TQualityResults;
  end;

  TCalibDefect = packed record
    volume: double;	  // объём дефекта
    dist: double;	    // расстояние от края калибровочной трубки до центра дефекта (мм)
    isExt: boolean;	  // внешний = true, внутренний = false
    isAxial: boolean;	// проточка = true, лыска/сверление = false
    isWaste: boolean;	// брак = true, годен = false
  end;

  TPipeSettings = packed record
    zoneStart: double;
    zoneFinish: double;
    pipeLength: double;
  end;

  TIniSettings = packed record
    bShowGood: boolean;
    bUseAmlitudeInsteadOfVolume: boolean;
    threshNotDefect: double;
    recontrolRange: double;
    ///
    nDefs: integer;
    defs: array of TCalibDefect;
    iDefect: integer;
    frameWidth: double;
    calibValue: double;
    calibThreshold: double;
    ps: TPipeSettings;
    psCalib: TPipeSettings;
  end;

  TProcType = (ptProduction = 0, ptCalibration);

  TSignalData=class
  private
    FRecontrolRange: double;
    FUseAmplitude: boolean;
    FNotDefectThresh: double;
    function isFramesIntersects(pd1, pd2: TDefectParams): boolean;overload;
    function isFramesIntersects(pd1, pd2: TExtractFrames): boolean;overload;
    function isProbesNearBorder(pd1, pd2: TDefectParams): boolean;
    function isProbesNear(pd1, pd2: TDefectParams): boolean;
    function getProbeNumber(ch: integer): integer;overload;  // нумерация с 0
    function getProbeNumber(efr: TExtractFrames): integer;overload;  // нумерация с 0
    function copyFrameStructure(efr: TExtractFrames): TDefectParams;
  private
    devInfo: TDeviceInfo;
    devData: array of TSignalLine;
    procData: TProcData;
    procDefects: TList<TDefectParams>;
    FCapacity: integer;
    FCount: integer;
    FNumCalibrationAttempt: integer;
    FCalibrated: boolean;
    FClassificator: TClassificatorStruct;
    FClassificator2: TClassificatorStruct;
    FThreshold: double;
    procedure SetCount(value: integer);
    procedure setData(iChannel, index: integer; value: TComplexInt);
    // процедуры обработки дефектов
    function Gauss(t: double; p: integer): TComplex;
    function GetEnergyFuncGauss(iChannel, index, msk: integer; b: double): TComplex;
    function getDefectParams(dp: TDefectParams): TDefectParams;
    procedure calcIndicationType(am, ph: double; cs: TClassificatorStruct; iProbe: integer;  var vl: double; var qr:TQualityResults; var dt:TDefectType);
    function calcParamsEFrames(fr: TExtractFrames): TExtractFrames;
  public
    procedure QSort(dp: TList<TExtractFrames>; left, right: integer);overload;
    procedure QSort(dp: TList<TDefectParams>; left, right: integer);overload;
    function RunDefectExtractorGauss(thresh, mask: double; iChannel: integer; var wvx, wvy: array of double):TList<TExtractFrames>;
    // основные
    constructor Create;
    procedure setAddParams(bUseAmp: boolean; ndThresh: double; recRange: double);
    procedure InitData;
    procedure fillDeviceInfo(di: TDeviceInfo);
    function LoadData(fName: string): boolean;
    procedure SaveData(fName: string);
    procedure LoadProcessing(fName: string);
    procedure SaveProcessing(fName: string);
    // обработка
    procedure doCalibStart();
    procedure doCalib(var defs: array of TCalibDefect; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double);
    function doCalibCheck(var defs: array of TCalibDefect; nDefs: integer; frameWidth: double): boolean;
    procedure doCalibTestD(var defs: array of TCalibDefect; nDefs: integer; frameWidth: double; var defParams: array of TDefectParams);
    procedure doPreProcessing(pipeSettings: TPipeSettings);
    procedure doPostProcessing(bShowGood: boolean = false);
    procedure FreeData;
    // манипуляции с данными
    property Calibrated: boolean read FCalibrated;
    property Count: integer read FCount write SetCount;
    property Capacity: integer read FCapacity;
    property DeviceInfo: TDeviceInfo read devInfo;
    property ProcessingParams: TProcData read procData;
    property ProcessingDefects: TList<TDefectParams> read procDefects;
    function getData(iChannel, index: integer; isRaw: boolean): TComplex;
    procedure addDataPL(pld: TPLStructDataAcquisition; isNew: boolean);
  end;

function loadPresetIniData(fileName: string): TDeviceInfo;

implementation

uses Classes, SysUtils, vector_priznak, IniFiles;

function loadPresetIniData(fileName: string): TDeviceInfo;
var
  bDataOnTimer: boolean;
  sIP: AnsiString;
  dev: TDeviceInfo;
  f: TIniFile;
  i: integer;
  ps1: integer;
begin
  // заполняем из файла структуру
  f := TIniFile.Create(fileName);
  sIP := f.ReadString('connection', 'IP', '10.8.2.218');
  // отладочные параметры
  NEED_STORE_LIB := f.ReadBool('debug', 'need_store', false);
  LIB_STORAGE_PATH := f.ReadString('debug', 'store_path', 'c:\');
  // параметры соединения
  sIP := f.ReadString('connection', 'IP', '10.8.2.218');
  //
  ps1 := pos('.', sIP);
  dev.ip1 := StrToInt(copy(sIP, 1, ps1 - 1));
  sIP := copy(sIP, ps1 + 1, Length(sIP) - ps1);
  //
  ps1 := pos('.', sIP);
  dev.ip2 := StrToInt(copy(sIP, 1, ps1 - 1));
  sIP := copy(sIP, ps1 + 1, Length(sIP) - ps1);
  //
  ps1 := pos('.', sIP);
  dev.ip3 := StrToInt(copy(sIP, 1, ps1 - 1));
  sIP := copy(sIP, ps1 + 1, Length(sIP) - ps1);
  dev.ip4 := StrToInt(sIP);
  //
  dev.decimation := f.ReadInteger('connection','decimation', 800);
  bDataOnTimer := f.ReadBool('connection', 'DataOnTimer', true);
  if bDataOnTimer then
    dev.triggerType := 1
  else
    dev.triggerType := 3;
  // общие параметры
  dev.preAmp := f.ReadInteger('common', 'nDefs', 200);
  dev.bwLimit := f.ReadInteger('common', 'bwLimit', 3);
  dev.mux_start := f.ReadInteger('common', 'mux_start', 1);
  dev.mux_finish := f.ReadInteger('common', 'mux_finish', 16);
  // параметры по каналам
  for i := 0 to maxChannels - 1 do
  begin
    dev.channelsInfo[i].frequency := f.ReadInteger('channel'+IntToStr(i), 'frequency', 50000);
    dev.channelsInfo[i].drive := f.ReadInteger('channel'+IntToStr(i), 'drive', 1000);
    dev.channelsInfo[i].amplification := f.ReadInteger('channel'+IntToStr(i), 'amplification', 200);
    dev.channelsInfo[i].filterType := f.ReadInteger('channel'+IntToStr(i), 'filterType', 0);
    dev.channelsInfo[i].hiPass := f.ReadInteger('channel'+IntToStr(i), 'hiPass', 100);
    dev.channelsInfo[i].lowPass := f.ReadInteger('channel'+IntToStr(i), 'lowPass', 200);
    dev.channelsInfo[i].bAbs := f.ReadBool('channel'+IntToStr(i), 'abs', false);
    dev.channelsInfo[i].isActive := f.ReadBool('channel'+IntToStr(i), 'active', true);
    ///
    dev.addChannelsInfo[i].phase := f.ReadInteger('channel'+IntToStr(i), 'phase', 0);
    dev.addChannelsInfo[i].x_spread := f.ReadInteger('channel'+IntToStr(i), 'x_spread', 0);
    dev.addChannelsInfo[i].y_spread := f.ReadInteger('channel'+IntToStr(i), 'y_spread', 0);
    dev.addChannelsInfo[i].x_dot := f.ReadInteger('channel'+IntToStr(i), 'x_dot', 0);
    dev.addChannelsInfo[i].y_dot := f.ReadInteger('channel'+IntToStr(i), 'y_dot', 0);
    dev.addChannelsInfo[i].mux_time := f.ReadInteger('channel'+IntToStr(i), 'mux_time', 0);
  end;
  // очистка памяти
  f.Free;
  Result := dev;
end;

{$REGION 'Основные'}
constructor TSignalData.Create;
begin
  procDefects := TList<TDefectParams>.Create();
  FThreshold := 0;
  FClassificator := PROC_CLASS_DEFAULT;
  FNumCalibrationAttempt := 0;
  FCalibrated := false;
end;

procedure TSignalData.setAddParams(bUseAmp: boolean; ndThresh: double; recRange: double);
begin
  FUseAmplitude := bUseAmp;
  FNotDefectThresh := ndThresh;
  FRecontrolRange := recRange;
end;

procedure TSignalData.InitData;
begin
  procData.isProcessed := false;
  procDefects.Clear;
  Count := 0;
end;

procedure TSignalData.fillDeviceInfo(di: TDeviceInfo);
begin
  devInfo := di;
end;

function TSignalData.LoadData(fName: string):boolean;
var
  f: TFileStream;
  i, iVer, cnt: integer;
begin
  Result := true;
  InitData;
  f := TFileStream.Create(fName, fmOpenRead or fmShareDenyNone);
  try
    f.ReadBuffer(iVer, sizeOf(versionNumber));
    if(iVer = versionNumber)then
    begin
      try
        f.ReadBuffer(devInfo, sizeOf(devInfo));
        f.ReadBuffer(cnt, 4);
        Count := cnt;
        for i := 0 to cnt - 1 do
          f.ReadBuffer(devData[i], sizeOf(TSignalLine));
      except
        Result := false;
      end;
    end
    else
    begin
      Result := false;
    end;
  finally
    f.Free;
  end;
end;

procedure TSignalData.SaveData(fName: string);
var
  f: TFileStream;
  i: integer;
begin
  f := TFileStream.Create(fName, fmCreate);
  try
    f.WriteBuffer(versionNumber, sizeOf(versionNumber));
    f.WriteBuffer(devInfo, sizeOf(devInfo));
    f.WriteBuffer(Count, 4);
    for i := 0 to Count - 1 do
      f.WriteBuffer(devData[i], sizeOf(TSignalLine));
  finally
    f.Free;
  end;
end;

procedure TSignalData.FreeData;
begin
  devData := nil;
  FCapacity := 0;
  FCount := 0;
  procDefects.Clear;
  procDefects.Free;
end;

procedure TSignalData.LoadProcessing(fName: string);
var
  f: TFileStream;
  i, iVer, cnt: integer;
  dp: TDefectParams;
begin
  f := TFileStream.Create(fName, fmOpenRead or fmShareDenyNone);
  try
    f.ReadBuffer(iVer, sizeOf(versionNumber));
    if(iVer = versionNumber)then
    begin
      try
        f.ReadBuffer(procData, sizeOf(procData));
        f.ReadBuffer(cnt, 4);
        procDefects.Clear;
        for i := 0 to cnt - 1 do
        begin
          f.ReadBuffer(dp, sizeOf(TDefectParams));
          procDefects.Add(dp);
        end;
      except
        procData.isProcessed := false;
      end;
    end
    else
    begin
      procData.isProcessed := false;
    end;
  finally
    f.Free;
  end;
end;

procedure TSignalData.SaveProcessing(fName: string);
var
  f: TFileStream;
  i: integer;
  dp: TDefectParams;
begin
  f := TFileStream.Create(fName, fmCreate);
  try
    f.WriteBuffer(versionNumber, sizeOf(versionNumber));
    f.WriteBuffer(procData, sizeOf(procData));
    f.WriteBuffer(procDefects.Count, 4);
    for i := 0 to procDefects.Count - 1 do
    begin
      dp := procDefects.Items[i];
      f.WriteBuffer(dp, sizeOf(TDefectParams));
    end;
  finally
    f.Free;
  end;
end;

{$ENDREGION}

{$REGION 'Сервисные функции'}
function TSignalData.isFramesIntersects(pd1, pd2: TDefectParams): boolean;
begin
  //Result := (Abs(pd1.pos2 - pd1.pos1) + Abs(pd2.pos2 - pd2.pos1)) > Abs(pd1.pos1 + pd1.pos2 - pd2.pos1 - pd2.pos2);
  Result := (pd1.pos1 < pd2.pos2) and (pd2.pos1 < pd1.pos2);
end;

function TSignalData.isFramesIntersects(pd1, pd2: TExtractFrames): boolean;
begin
  //Result := (Abs(pd1.pos2 - pd1.pos1) + Abs(pd2.pos2 - pd2.pos1)) > Abs(pd1.pos1 + pd1.pos2 - pd2.pos1 - pd2.pos2);
  Result := (pd1.pos1 < pd2.pos2) and (pd2.pos1 < pd1.pos2);
end;

function TSignalData.isProbesNearBorder(pd1, pd2: TDefectParams): boolean;
begin
  Result := ((pd1.probe2 = 3) and (pd2.probe1 = 0)) or ((pd2.probe2 = 3) and (pd1.probe1 = 0));
end;

function TSignalData.isProbesNear(pd1, pd2: TDefectParams): boolean;
begin
  Result := ((pd2.probe1 - pd1.probe2) <= 1) or ((pd1.probe1 - pd2.probe2) <= 1);
end;

function TSignalData.getProbeNumber(ch: integer): integer;  // нумерация с 0
const NUM_CHANELS_PER_PROBE: integer = 4;
begin
  Result := (ch div NUM_CHANELS_PER_PROBE);
end;

function TSignalData.getProbeNumber(efr: TExtractFrames): integer;  // нумерация с 0
begin
  Result := getProbeNumber(efr.channel + 1);
end;


function TSignalData.copyFrameStructure(efr: TExtractFrames): TDefectParams;
var dp: TDefectParams;
begin
  // копируем поля
  dp.pos1 := efr.pos1;
  dp.pos2 := efr.pos2;
  dp.posx := efr.posx;
  dp.probeSet := [getProbeNumber(efr.channel)];
  dp.volume := 0.0;
  dp.channel := -1;
  dp.nProbesIndication := 0;
  dp.qualityRes := efr.qr;
  dp.valid := true;
  // передаем на выход
  Result := dp;
end;

{$ENDREGION}

{$REGION 'Манипуляции с даными'}
procedure TSignalData.SetCount(value: integer);
begin
  FCount := value;
  if FCount > FCapacity then
  begin
    FCapacity := 2 * FCount;
    SetLength(devData, FCapacity);
  end;
end;

function TSignalData.getData(iChannel, index: integer; isRaw: boolean): TComplex;
var
  cx: TComplex;
begin
  if count > 0 then
  begin
    cx.re := devData[index][iChannel].re * kf;
    cx.im := devData[index][iChannel].im * kf;
    if devInfo.channelsInfo[iChannel].bAbs then
      cx := CNeg(cx);
    if not isRaw then
      cx := CMul(CSub(cx, procData.avg[iChannel]), procData.eta[iChannel]);
  end
  else
  begin
    cx := CNull;
  end;
  Result := cx;
end;

procedure TSignalData.setData(iChannel, index: integer; value: TComplexInt);
begin
  devData[index][iChannel] := value;
end;

procedure TSignalData.addDataPL(pld: TPLStructDataAcquisition; isNew: boolean);
var
  cx: TComplexInt;
  index: integer;
begin
  // если надо создать новый, то наращиваем массив данных
  if isNew then
  begin
    Count := Count + 1;
  end;
  // закидываем в последний элемент данные
  index := Count - 1;
  cx.re := pld.dataX;
  cx.im := pld.dataY;
  setData(pld.statusSubChannel, index, cx);
end;

// калибровка
procedure TSignalData.doCalibStart();
begin
  FCalibrated := false;
  FNumCalibrationAttempt := 0;
end;

procedure TSignalData.doCalib(var defs: array of TCalibDefect; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double);
var
  pz: TPriznakPack;
  i, j, p, p1, p2: integer;
  cRaw, cEtalon: TComplex;
  cl: TClassificatorStruct;

  procedure classificationThresholdCalc(var c: TClassificatorStruct; iFrequency: integer);
  var
    i, j, p, p1, p2: integer;
    phInt, phExt: double;
    n1, n2: integer;
  begin
    // вычисляем аппроксимации
    n1 := 0;
    n2 := 0;
    phInt := 0;
    phExt := 0;
    for j := 0 to maxChannels - 1 do
      if devInfo.channelsInfo[j].isActive and (not devInfo.channelsInfo[j].bAbs) and ((j mod 4) + 1 = iFrequency) then
      begin
        for i := 0 to nDefs - 1 do
        begin
          p := procData.raw_p1 + Round(defs[i].dist / procData.step);
          p1 := p - Round(frameWidth / procData.step / 2);
          p2 := p + Round(frameWidth / procData.step / 2);
          pz := getPriznaksAll(p1, p2, j, self, false);
          if defs[i].isExt then
          begin
            inc(n2);
            phExt := phExt + pz.Ph;
          end
          else
          begin
            inc(n1);
            phInt := phInt + pz.Ph;
          end;
        end;
      end;
    if n1 > 0 then phInt := phInt / n1;
    if n2 > 0 then phExt := phExt / n2;
    c.phb := phInt + Abs(phInt - phExt) / 4;
  end;

  procedure approximationCalc(var c: TClassificatorStruct; iChannel, iProbe: integer);
  type
    TArray2 = array[1..2]of double;
    TArray22 = array[1..2, 1..2]of double;
  var
    i, p, p1, p2: integer;
    mxExt, mxInt: TArray22;
    vectInt, vectExt: TArray2;
    n1, n2: integer;
  begin
    // вычисляем аппроксимации
    n1 := 0;
    n2 := 0;
    vectExt[1] := 0; vectExt[2] := 0;
    vectInt[1] := 0; vectInt[2] := 0;
    mxExt[1,1] := 0; mxExt[1,2] := 0; mxExt[2,1] := 0; mxExt[2,2] := 0;
    mxInt[1,1] := 0; mxInt[1,2] := 0; mxInt[2,1] := 0; mxInt[2,2] := 0;
    for i := 0 to nDefs - 1 do
    begin
      p := procData.raw_p1 + Round(defs[i].dist / procData.step);
      p1 := p - Round(frameWidth / procData.step / 2);
      p2 := p + Round(frameWidth / procData.step / 2);
      pz := getPriznaksAll(p1, p2, iChannel, self, false);
      if defs[i].isExt then
      begin
        inc(n2);
        mxExt[1,1] := mxExt[1,1] + pz.Am * pz.Am;
        mxExt[1,2] := mxExt[1,2] + pz.Am;
        mxExt[2,1] := mxExt[2,1] + pz.Am;
        mxExt[2,2] := mxExt[2,2] + 1;
        vectExt[1] := vectExt[1] + pz.Am * defs[i].volume;
        vectExt[2] := vectExt[2] + defs[i].volume;
      end
      else
      begin
        inc(n1);
        mxInt[1,1] := mxInt[1,1] + pz.Am * pz.Am;
        mxInt[1,2] := mxInt[1,2] + pz.Am;
        mxInt[2,1] := mxInt[2,1] + pz.Am;
        mxInt[2,2] := mxInt[2,2] + 1;
        vectInt[1] := vectInt[1] + pz.Am * defs[i].volume;
        vectInt[2] := vectInt[2] + defs[i].volume;
      end;
    end;
    if n1 > 0 then
    begin
      c.a1[iProbe] := (vectInt[1] * mxInt[2,2] - vectInt[2] * mxInt[1,2]) / (mxInt[1,1] * mxInt[2,2] - mxInt[1,2] * mxInt[2,1]);
      c.b1[iProbe] := (vectInt[2] * mxInt[1,1] - vectInt[1] * mxInt[2,1]) / (mxInt[1,1] * mxInt[2,2] - mxInt[1,2] * mxInt[2,1]);
    end;
    if n2 > 0 then
    begin
      c.a2[iProbe] := (vectExt[1] * mxExt[2,2] - vectExt[2] * mxExt[1,2]) / (mxExt[1,1] * mxExt[2,2] - mxExt[1,2] * mxExt[2,1]);
      c.b2[iProbe] := (vectExt[2] * mxExt[1,1] - vectExt[1] * mxExt[2,1]) / (mxExt[1,1] * mxExt[2,2] - mxExt[1,2] * mxExt[2,1]);
    end;
  end;

begin
  // в этой процедуре необходимо рассчитать все параметры FClassificator, eta и PROC_THRESH_EXTRACT
  PROC_THRESH_EXTRACT := calibValue;
  // пересчитываем eta
  cEtalon.re := calibValue * cos(PHASE_CALIB * pi / 180);
  cEtalon.im := calibValue * sin(PHASE_CALIB * pi / 180);
  p := procData.raw_p1 + Round(defs[iDefect].dist / procData.step);
  p1 := p - Round(frameWidth / procData.step / 2);
  p2 := p + Round(frameWidth / procData.step / 2);
  for i := 0 to maxChannels - 1 do
    if devInfo.channelsInfo[i].isActive and (not devInfo.channelsInfo[i].bAbs) then
    begin
      pz := getPriznaksAll(p1, p2, i, self, true);
      cRaw.re := pz.Am * cos(pz.Ph * pi / 180);
      cRaw.im := pz.Am * sin(pz.Ph * pi / 180);
      procData.eta[i] := CDiv(cEtalon, cRaw);
    end;
  // рассчитываем параметры классификатора
  cl := PROC_CLASS_DEFAULT;
  cl.v2 := calibThreshold;
  cl.v1 := cl.v2 - FRecontrolRange;
  cl.va := cl.v2;
  cl.vnd := FNotDefectThresh;
  // рассчитываем аппроксимации для обеих частот
  classificationThresholdCalc(cl, 1);
  for i := 0 to MAX_PROBES - 1 do
    approximationCalc(cl, i * 4, i);
  FClassificator := cl;
  classificationThresholdCalc(cl, 2);
  for i := 0 to MAX_PROBES - 1 do
    approximationCalc(cl, i * 4 + 1, i);
  FClassificator2 := cl;
  FCalibrated := true;
end;

function TSignalData.doCalibCheck(var defs: array of TCalibDefect; nDefs: integer; frameWidth: double): boolean;
var
  i: integer;
  bRes: boolean;
  qr: TQualityResults;
  defParams: array of TDefectParams;
begin
  // просматриваем все дефекты на калибровочной трубке
  SetLength(defParams, nDefs);
  doCalibTestD(defs, nDefs, frameWidth, defParams);
  // определяем корректность
  bRes := true;
  for i := 0 to nDefs - 1 do
  begin
    qr := defParams[i].qualityRes;
    bRes := bRes and (((qr = qrBad) and (defs[i].isWaste)) or ((qr <> qrBad) and (not defs[i].isWaste)));
  end;
  // очищаем результат
  defParams := nil;
  // передаем выходное значение
  Result := bRes;
end;

procedure TSignalData.doCalibTestD(var defs: array of TCalibDefect; nDefs: integer; frameWidth: double; var defParams: array of TDefectParams);
var
  i: integer;
  p, p1, p2: integer;
  dp: TDefectParams;
begin
  for i := 0 to nDefs - 1 do
  begin
    // вычисляем координаты дефекта
    p := procData.raw_p1 + Round(defs[i].dist / procData.step);
    p1 := p - Round(frameWidth / procData.step / 2);
    p2 := p + Round(frameWidth / procData.step / 2);
    // заполняем поля и вычисляем всё
    dp.pos1 := p1;
    dp.pos2 := p2;
    dp.probe1 := 0;
    dp.probe2 := 3;
    dp := getDefectParams(dp);
    defParams[i] := dp;
  end;
end;

procedure TSignalData.doPreProcessing(pipeSettings: TPipeSettings);
var
  i, j, p1, p2: integer;
  avg: TComplex;

  procedure FindWorkArea();
  var
    i: Integer;
    bSignal: boolean;
  begin
    // ищем начало трубки
    bSignal := false;
    p1 := -1;
    for i := 0 to Count - 1 do
    begin
      if CAbs(getData(0, i, true)) > PROC_THRESH_PREP then
      begin
        if bSignal then
        begin
          if CAbs(getData(0, i, true)) > CAbs(getData(0, p1, true)) then
            p1 := i;
        end
        else
        begin
          bSignal := true;
          p1 := i;
        end;
      end
      else
      begin
        if bSignal then break;
      end;
    end;
    if p1 < 0 then
      p1 := 0;
    // ищем окончание трубки
    bSignal := false;
    p2 := -1;
    for i := Count - 1 downto 0 do
    begin
      if CAbs(getData(0, i, true)) > PROC_THRESH_PREP then
      begin
        if bSignal then
        begin
          if CAbs(getData(0, i, true)) > CAbs(getData(0, p2, true)) then
            p2 := i;
        end
        else
        begin
          bSignal := true;
          p2 := i;
        end;
      end
      else
      begin
        if bSignal then break;
      end;
    end;
    if p2 < 0 then
      p2 := Count - 1;
  end;

begin
  try
    // определяем начало и конец рабочей зоны трубки
    FindWorkArea();
    // рассчитываем шаг сканирования  и зону контроля
    procData.step := pipeSettings.pipeLength / abs(p2 - p1);
    procData.raw_p1 := p1;
    procData.raw_p2 := p2;
    procData.position1 := p1 + Round(pipeSettings.zoneStart / procData.step);
    procData.position2 := p2 - Round(pipeSettings.zoneFinish / procData.step);
    // убираем постоянную составляющую
    for i := 0 to maxChannels - 1 do
    begin
      avg := CNull;
      if devInfo.channelsInfo[i].isActive then
      begin
        for j := procData.position1 to procData.position2 do
          avg := CAdd(avg, getData(i, j, true));
        avg := CDiv(avg, CConv(procData.position2 - procData.position1 + 1));
      end;
      procData.avg[i] := avg;
      if (not devInfo.channelsInfo[i].isActive) then
      begin
        // для неактивных каналов устанавливаем значение в 0;
        procdata.eta[i] := CNull;
      end
      else if (devInfo.channelsInfo[i].bAbs) then
      begin
        // для абсолютных каналов не меняем ничего
        procData.eta[i] := CConv(1.0);
      end
      else
      begin
        if not FCalibrated then
        begin
          procData.eta[i].re := 1.0;
          procData.eta[i].im := 0.0;
        end;
      end;
    end;
    // завершение обработки
    procData.isProcessed := true;
  except
    procData.isProcessed := false;
  end;
end;

procedure TSignalData.doPostProcessing(bShowGood: boolean = false);
var
  i, j, p1, p2: integer;
  avg: TComplex;
  x, y: array of double;
  defs: TList<TExtractFrames>;
  efr: TExtractFrames;
  pd: TDefectParams;
begin
  if procData.isProcessed and Calibrated then
  begin
    try
      // осуществляем поиск индикаций
      // выделяем память под 2 массива
      SetLength(x, Count);
      SetLength(y, Count);
      // производим выделение дефектов на активных дифференциальных каналах
      procDefects.Clear;
      defs := TList<TExtractFrames>.Create();
      for i := 0 to maxChannels - 1 do
        if devInfo.channelsInfo[i].isActive and (not devInfo.channelsInfo[i].bAbs) then
        begin
          //
          defs.AddRange(RunDefectExtractorGauss(PROC_THRESH_EXTRACT, PROC_MASK_EXTRACT, i, x, y));
        end;
      x := nil;
      y := nil;
      // для каждой рамки вычисляем дополнительные параметры
      for i := 0 to defs.Count - 1 do
        defs.Items[i] := calcParamsEFrames(defs.Items[i]);
      // сортируем индикации и объединяем пересекающиеся
      if defs.Count > 0 then QSort(defs, 0, defs.Count - 1);
      // сперва пробуем отсечь пересечения на одном датчике для разных каналов
      // определяем пересекающиеся и выбираем только с бОльшим значением амплитуды
      i := 0;
      while i < defs.Count do
      begin
        j := i + 1;
        while (defs.Items[i].valid) and (j < defs.Count) do
        begin
          if isFramesIntersects(defs.Items[i], defs.Items[j]){ and (getProbeNumber(defs.Items[i]) = getProbeNumber(defs.Items[j]))} then
          begin
            // вторая рамка
            efr := defs.Items[j];
            efr.valid := (defs.Items[j].am > defs.Items[i].am);
            defs.Items[j] := efr;
            // первая рамка
            efr := defs.Items[i];
            efr.valid := (defs.Items[i].am >= defs.Items[j].am);
            defs.Items[i] := efr;
          end;
          j := j + 1;
        end;
        i := i + 1;
      end;
      // удаляем лишние рамки
      i := 0;
      while i < defs.Count do
      begin
        if defs.Items[i].valid then
          i := i + 1
        else
          defs.Delete(i);
      end;
      // перегоняем рамки в новый массив
      for i := 0 to defs.Count - 1 do
        procDefects.Add(copyFrameStructure(defs.Items[i]));
      defs.Clear;
      defs.Free;
{      // снова просматриваем пересечения уже для различных датчиков
      i := 0;
      while i < procDefects.Count do
      begin
        if procDefects.Items[i].valid then
        begin
          for j := i + 1 to procDefects.Count - 1 do
            if isFramesIntersects(procDefects.Items[i], procDefects.Items[j])and
              //(procDefects.Items[j].qualityRes = procDefects.Items[i].qualityRes)and
              //isProbesNear(procDefects.Items[i], procDefects.Items[j]) and
              procDefects.Items[j].valid then
            begin
              // дизейблим j-го
              pd := procDefects.Items[j];
              pd.valid := false;
              procDefects.Items[j] := pd;
              // для i-го совмещаем рамки
              pd := procDefects.Items[i];
              pd.pos1 := min(procDefects.Items[i].pos1, procDefects.Items[j].pos1);
              pd.pos2 := max(procDefects.Items[i].pos2, procDefects.Items[j].pos2);
              pd.probeSet := pd.probeSet + procDefects.Items[j].probeSet;
              //pd.probe1 := min(procDefects.Items[i].probe1, procDefects.Items[j].probe1);
              //pd.probe2 := max(procDefects.Items[i].probe2, procDefects.Items[j].probe2);
              procDefects.Items[i] := pd;
            end;
        end;
        i := i + 1;
      end;    }
      // удаляем лишнее
{      i := 0;
      while i < procDefects.Count do
      begin
        if procDefects.Items[i].valid then
          i := i + 1
        else
          procDefects.Delete(i);
      end;         }
      // определяем оставшиеся параметры
      for i := 0 to procDefects.Count - 1 do
        procDefects.Items[i] := getDefectParams(procDefects.Items[i]);
      // удалем лишнее
      i := 0;
      while i < procDefects.Count do
      begin
        if procDefects.Items[i].valid and (procDefects.Items[i].qualityRes <> qrNotDefect) then
        begin
          if (not bShowGood) and (procDefects.Items[i].qualityRes = qrGood) then
            procDefects.Delete(i)
          else
            i := i + 1;
        end
        else
          procDefects.Delete(i);
      end;
      // сортируем индикации под конец
      if procDefects.Count > 0 then QSort(procDefects, 0, procDefects.Count - 1);
      // определяем результат для всей трубки
      procData.qualityRes := qrGood;
      for i := 0 to procDefects.Count - 1 do
        if procDefects.Items[i].qualityRes > procData.qualityRes then
          procData.qualityRes := procDefects.Items[i].qualityRes;
      // завершение обработки
      procData.isProcessed := true;
    except
      procData.isProcessed := false;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'процедуры обработки дефектов'}
procedure TSignalData.QSort(dp: TList<TExtractFrames>; left, right: integer);
var
  i, j: integer;
  center: TExtractFrames;
begin
  i := left;
	j := right;
	center := dp.Items[(left + right) div 2];
	while(i <= j)do
  begin
		while ((dp.Items[i].posx < center.posx) and (i < right)) do
			inc(i);
		while ((dp.Items[j].posx > center.posx) and (j > left)) do
			dec(j);
		if (i <= j) then
    begin
      dp.Exchange(i, j);
			//
			inc(i);
			dec(j);
    end;
  end;
	if (left < j) then
		QSort(dp, left, j);
	if (right > i) then
		QSort(dp, i, right);
end;

procedure TSignalData.QSort(dp: TList<TDefectParams>; left, right: integer);
var
  i, j: integer;
  center: TDefectParams;
begin
  i := left;
	j := right;
	center := dp.Items[(left + right) div 2];
	while(i <= j)do
  begin
		while ((dp.Items[i].posx < center.posx) and (i < right)) do
			inc(i);
		while ((dp.Items[j].posx > center.posx) and (j > left)) do
			dec(j);
		if (i <= j) then
    begin
      dp.Exchange(i, j);
			//
			inc(i);
			dec(j);
    end;
  end;
	if (left < j) then
		QSort(dp, left, j);
	if (right > i) then
		QSort(dp, i, right);
end;

// Функция вычисляет "p"-ю производную функции Гаусса
function TSignalData.Gauss(t: double; p: integer): TComplex;
var
  mn, cf: double;

  function pw(x:double; a:integer):double;
  var i: integer;
      s: double;
  begin
    s := 1;
    for i := 1 to a do
      s := s * x;
    Result := s;
  end;

begin
  mn := 0;
  Case p of
    1: mn := t;
    2: mn := 1 - t * t;
    3: mn := pw(t, 3) - 3 * t;
    4: mn := -1 * pw(t, 4) + 6 * pw(t, 2) - 3;
    5: mn := pw(t, 5) - 10 * pw(t, 3) + 15 * t;
    6: mn := -1 * pw(t, 6) + 15 * pw(t, 4) - 45 * pw(t, 2) + 15;
    7: mn := 0;
    8: mn := -1 * pw(t, 8) + 28 * pw(t, 6) - 210 * pw(t, 4) + 420 * pw(t, 2) - 105;
    9: mn := 0;
    10:mn := 0;
  end;
  Case p of
    1: cf := 1.7864876835;
    2: cf := 1.077292607;
    3: cf := 0.7661263355;
    4: cf := 0.3818307898;
    5: cf := 0.1854957322;
    6: cf := 0.0776949666;
    7: cf := 0.0306928332;
    8: cf := 0.0111529662;
    9: cf := 3.8310077873E-3;
    10:cf := 1.2410765691E-3;
  end;
  Result.re := 1 * cf * exp(-t * t) * mn / sqrt(2);
  Result.im := 0;
end;

// расчет энергетической функции преобразования для комплексного сигнала
function TSignalData.GetEnergyFuncGauss(iChannel, index, msk: integer; b: double): TComplex;
var
  i: integer;
  e: TComplex;
begin
  e := CNull;
  for i := -msk to msk do
    e := CAdd(e, CMul(getData(iChannel, index + i, false), Gauss(i / b, 1)));
  Result := e;
end;

{ процедура обнаружения дефектов с использованием CWT }
function TSignalData.RunDefectExtractorGauss(thresh, mask: double; iChannel: integer; var wvx, wvy: array of double):TList<TExtractFrames>;
var
  msk: integer;
  i, j, nDefX: integer;
  cx: TComplex;
  dp: TExtractFrames;
  bSignal: boolean;
  bCoeff: double;
  defs: TList<TExtractFrames>;

  procedure dFind(var wv: array of double);
  var
    m: double;
    i, j: integer;
  begin
    bSignal:=false;
    for i := procData.position1 to procData.position2 do
      if abs(wv[i]) > thresh then
      begin
        if bSignal then
          dp.Pos2 := i
        else
        begin
          bSignal := true;
          dp.Pos1 := i;
          dp.Pos2 := i;
        end;
      end
      else
      begin
        if (bSignal) then
        begin
          m := abs(wv[dp.pos1]);
          for j := dp.pos1 to dp.pos2 do
            if abs(wv[j]) > m then m := abs(wv[j]);
          dp.channel := iChannel;
          dp.mValue := m;
          dp.valid := true;
          defs.Add(dp);
        end;
        bSignal := false;
      end;
  end;

  procedure dCorrect(var wv:array of double; iStart, iFinish: integer);
  var i, j: integer;
  begin
    for i := iStart to iFinish do
    begin
      dp := defs.Items[i];
      if wv[dp.pos1] > 0 then
      begin
        for j := dp.pos1 downto procData.position1 + 1 do
          if (wv[j-1] > wv[j])and(wv[j] < wv[j+1]) then
          begin
            dp.pos1 := j + 1;
            break;
          end;
        for j := dp.pos2 to procData.position2 - 1 do
          if (wv[j-1] > wv[j])and(wv[j] < wv[j+1]) then
          begin
            dp.pos2 := j - 1;
            break;
          end;
      end
      else
      begin
        for j := dp.pos1 downto procData.position1 + 1 do
          if (wv[j-1] < wv[j])and(wv[j] > wv[j+1]) then
          begin
            dp.pos1 := j + 1;
            break;
          end;
        for j := dp.pos2 to procData.position2 - 1 do
          if (wv[j-1] < wv[j])and(wv[j] > wv[j+1]) then
          begin
            dp.pos2 := j - 1;
            break;
          end;
      end;
      dp.posx := (dp.pos1 + dp.pos2) div 2;
      defs.Items[i] := dp;
    end;
  end;

begin
  msk:=Round(mask / procData.step);
  bCoeff := mask / procData.step / 3.0;
  defs := TList<TExtractFrames>.Create();
  defs.Clear;
  // генерация массива преобразования
  for i := procData.position1 + msk to procData.position2 - msk do
  begin
    cx := GetEnergyFuncGauss(iChannel, i, msk, bCoeff);
    wvx[i] := cx.re;
    wvy[i] := cx.im;
  end;
  // поиск дефектов на трубке
  dFind(wvx);
  // корректировка рамок
  dCorrect(wvx, 0, defs.Count - 1);
  // выделение для мнимой компоненты
  nDefX := defs.Count;
  dFind(wvy);
  // корректировка рамок
  dCorrect(wvy, nDefX, defs.Count - 1);
  // сортируем рамки
  if defs.Count > 0 then QSort(defs, 0, defs.Count - 1);
  // определяем пересекающиеся и выбираем только с бОльшим значением модуля функции преобразования
  i := 0;
  while i < defs.Count do
  begin
    j := i + 1;
    while (defs.Items[i].valid) and (j < defs.Count) do
    begin
      if isFramesIntersects(defs.Items[i], defs.Items[j]) then
      begin
        // вторая рамка
        dp := defs.Items[j];
        dp.valid := (defs.Items[j].mValue > defs.Items[i].mValue);
        defs.Items[j] := dp;
        // первая рамка
        dp := defs.Items[i];
        dp.valid := (defs.Items[i].mValue > defs.Items[j].mValue);
        defs.Items[i] := dp;
      end;
      j := j + 1;
    end;
    i := i + 1;
  end;
  // удаляем лишние рамки
  i := 0;
  while i < defs.Count do
  begin
    if defs.Items[i].valid then
      i := i + 1
    else
      defs.Delete(i);
  end;
  // передаем результат
  Result := defs;
end;

{ процедура расчета параметров амплитуды, фазы, класса и объема дефекта для рамки конкретного канала }
function TSignalData.calcParamsEFrames(fr: TExtractFrames): TExtractFrames;
var
  pp: TPriznakPack;
  vl: double;
  qr: TQualityResults;
  dt: TDefectType;
  center, frameW: integer;
begin
  Result := fr;
  pp := getPriznaksAll(fr.pos1, fr.pos2, fr.channel, self, false);
  Result.am := pp.Am;
  Result.ph := pp.Ph;
  if (fr.channel mod 4) = 0 then
    calcIndicationType(pp.Am, pp.Ph, FClassificator, getProbeNumber(fr), vl, qr, dt)
  else
    calcIndicationType(pp.Am, pp.Ph, FClassificator2, getProbeNumber(fr), vl, qr, dt);
  Result.vl := vl;
  Result.qr := qr;
  if Result.qr = qrRecontrol then Result.qr := qrBad;
  Result.valid := true; //not(qr in [qrNotDefect]);
  // корректируем границы рамок
  Result.posx := fr.pos1 + (pp.k1 + pp.k2) div 2;
  frameW := min(abs(fr.posx - fr.pos1), abs(fr.posx - fr.pos2));
  Result.pos1 := Result.posx - frameW;
  Result.pos2 := Result.posx + frameW;
  if Result.pos1 < 0 then Result.pos1 := 0;
  if Result.pos2 >= Count then Result.pos2 := count - 1;
end;

procedure TSignalData.calcIndicationType(am, ph: double; cs: TClassificatorStruct; iProbe: integer;  var vl: double; var qr:TQualityResults; var dt:TDefectType);
var
  v1, v2: double;
begin
  // на всякий случай для обеих вариантов рассчитаем объём
  v1 := cs.a1[iProbe] * am + cs.b1[iProbe];
  v2 := cs.a2[iProbe] * am + cs.b2[iProbe];
  // сперва определимся дефект это или нет
  if (cs.ph1 <= ph) and (ph <= cs.ph2) then
  begin
    // определимся внешний или внутренний
    if ph < cs.phb then
    begin
      dt := dtInternal;
      vl := v1;
    end
    else
    begin
      dt := dtExternal;
      vl := v2;
    end;
    // определяем класс
    if vl > cs.v2 then
      qr := qrBad
    else if vl > cs.v1 then
      qr := qrRecontrol
    else if vl > cs.vnd then
      qr := qrGood
    else
      qr := qrNotDefect;
  end
  else if (cs.pha1 <= ph) and (ph <= cs.pha2) then
  begin
    dt := dtNone;
    // скорее всего антидефект или фигня какая-то
    vl := v2; // для внешних
    if vl > cs.va then
      qr := qrNone
    else
      qr := qrNotDefect;
  end
  else
  begin
    // в этой зоне точно фигня какая-то
    vl := 0.0;
    qr := qrNotDefect;
    dt := dtNone;
  end;
end;

function TSignalData.getDefectParams(dp: TDefectParams): TDefectParams;
type
  TResVol = record
    amp: double;
    qr: TQualityResults;
    qrAdd: TQualityResults;
    vl: double;
    dt: TDefectType;
  end;
var
  dt1, dt2: TDefectType;
  qr1, qr2: TQualityResults;
  vm, v1, v2: double;
  rv: array[0..MAX_PROBES-1]of TResVol;
  pp1, pp2: TPriznakPack;
  i, iv: integer;
  am1, am2: double;

  function checkProbe(p1, p2, ip: integer): boolean;
  begin
    if p2 - p1 >= 0 then
      Result := (p1 <= ip) and (ip <= p2)
    else
      Result := (p1 <= ip) or (ip <= p2);
  end;

  function getProbe12(d: TDefectParams):TDefectParams;
  var
    p1, p2: integer;
  begin
    Result := d;
    case d.nProbesIndication of
      1: begin
           p1 := iv;
           p2 := iv;
         end;
      2: begin
           if d.probeSet = [0, 1] then begin p1 := 0; p2 := 1; end
           else if d.probeSet = [1, 2] then begin p1 := 1; p2 := 2; end
           else if d.probeSet = [2, 3] then begin p1 := 2; p2 := 3; end
           else begin p1 := 3; p2 := 0; end;
         end;
      3: begin
           if d.probeSet = [0, 1, 2] then begin p1 := 0; p2 := 2; end
           else if d.probeSet = [1, 2, 3] then begin p1 := 1; p2 := 3; end
           else if d.probeSet = [2, 3, 0] then begin p1 := 2; p2 := 0; end
           else begin p1 := 3; p2 := 1; end;
         end;
      4: begin
           p1 := 0;
           p2 := MAX_PROBES - 1;
         end;
    end;
    Result.probe1 := p1;
    Result.probe2 := p2;
  end;

begin
  Result := dp;
  Result.posx := (dp.pos1 + dp.pos2) div 2;
  // определяем доминирующие параметры по частотам
  for i := 0 to MAX_PROBES-1 do
  begin
    // первая частота
    pp1 := getPriznaksAll(dp.pos1, dp.pos2, i * 4, self, false);
    calcIndicationType(pp1.Am, pp1.Ph, FClassificator, i, v1, qr1, dt1);
    // вторая частота
    pp2 := getPriznaksAll(dp.pos1, dp.pos2, i * 4 + 1, self, false);
    calcIndicationType(pp2.Am, pp2.Ph, FClassificator2, i, v2, qr2, dt2);
    // определяем суммарный результат
    rv[i].amp := pp1.Am;
    rv[i].vl := v1;
    rv[i].qr := qr1;
    rv[i].qrAdd := qr2;
    rv[i].dt := dt1;
  end;
  // просматриваем все датчики и выбираем с максимальным объемом или амплитудой
  iv := -1;
  vm := 0.0;
  for i := 0 to MAX_PROBES-1 do
  begin
    if FUseAmplitude then
    begin
      if rv[i].amp > vm then
      begin
        vm := rv[i].amp;
        iv := i;
      end;
    end
    else
    begin
      if rv[i].vl > vm then
      begin
        vm := rv[i].vl;
        iv := i;
      end;
    end;
  end;
  // попытка интегральной оценки
{  vm := 0.0;
  for i := 0 to MAX_PROBES-1 do
    vm := vm + rv[i].vl;}
  // записываем параметры
  if iv < 0 then
  begin
    Result.qualityRes := qrNotDefect;
    Result.channel := -1;
    Result.volume := 0.0;
    Result.defectType := dtNone;
    // количество датчиков
    Result.probe1 := 0;
    Result.probe2 := 0;
    Result.probeSet := [];
    Result.nProbesIndication := 0;
  end
  else
  begin
    //if rv[iv].qr = rv[i].qrAdd then
      Result.qualityRes := rv[iv].qr;
    //else
    //  Result.qualityRes := qrRecontrol;
    Result.volume := rv[iv].vl;//vm / MAX_PROBES;
    Result.channel := iv * 4;
    Result.defectType := rv[iv].dt;
    // считаем количество датчиков с индикациями
    Result.nProbesIndication := 0;
    Result.probeSet := [];
    for i := 0 to MAX_PROBES - 1 do
      if rv[i].qr in [qrGood, qrBad, qrRecontrol, qrNone] then
      begin
        Result.nProbesIndication := Result.nProbesIndication + 1;
        Result.probeSet := Result.probeSet + [i];
      end;
    Result := getProbe12(Result);
  end;
end;

{$ENDREGION}

end.
