unit test_libData;

interface

Const
  AR_OK = 0;
  AR_SettingsNotLoaded = 1;
  AR_ConnectionError = 2;
  AR_WRONG_CHANNEL = 3;
  AR_WRONG_DATA_BUFFER = 4;

  AR_NotSuppportedOperation = $80;

  AR_STATE_NotInited = 0;
  AR_STATE_Connected = 1;
  AR_STATE_Disconnected = 2;
  AR_STATE_DataAquire = 3;

  AR_CLASS_None = 0;
  AR_CLASS_Proper = 1;
  AR_CLASS_Recontrol = 2;
  AR_CLASS_Waste = 3;

type
  TComplex = packed record
    re: double;
    im: double;
  end;

  TPipeSettings = packed record
    zoneStart: double;
    zoneFinish: double;
    pipeLength: double;
  end;

  TChannelInfo = packed record
    frequency: integer;
    drive: integer;
    amplification: integer;
    filterType: integer;
    hiPass: integer;
    lowPass: integer;
    bAbs: boolean;
    isActive: boolean;
  end;

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

  TCalibDefect = packed record
    volume: double;	  // объём дефекта
    dist: double;	    // расстояние от края калибровочной трубки до центра дефекта (мм)
    isExt: boolean;	  // внешний = true, внутренний = false
    isAxial: boolean;	// проточка = true, лыска/сверление = false
    isWaste: boolean;	// брак = true, годен = false
  end;

// модуль для перечисления функций экспорта библиотеки
function ar_LoadSettings(fName: PChar): integer; stdcall;
function ar_Free(): integer; stdcall;
// работа с прибором
function ar_DeviceConnect(): integer; stdcall;
function ar_DeviceDisconnect(): integer; stdcall;
function ar_DeviceCheckConnection(var connected: boolean): integer; stdcall;
// сбор данных
function ar_StartAquireData(): integer; stdcall;
function ar_StopAquireData(): integer; stdcall;
// настройки обработки
function ar_PresetDevice(): integer; stdcall;
function ar_PresetPipe(ps: TPipeSettings): integer; stdcall;
function ar_StartCalibration(): integer;
function ar_Calibrate(defs: Pointer; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double): integer; stdcall;
function ar_CheckCalibration(defs: Pointer; nDefs: integer; frameWidth: double; var isCorrect: boolean): integer; stdcall;
function ar_TestDeviceCalibration(defs: Pointer; nDefs: integer; frameWidth: double; defParams: Pointer): integer; stdcall;
// получение результатов
function ar_GetDataCount(var cnt: integer): integer; stdcall;
function ar_GetDataChannelParams(iChannel: integer; var ci: TChannelInfo): integer; stdcall;
function ar_SetDataChannelParams(iChannel: integer; ci: TChannelInfo): integer; stdcall;
// обработка данных
function ar_GetAquiredData(iChannel: integer; p: Pointer): integer; stdcall;
function ar_GetProcessedData(iChannel: integer; var z1, z2: integer; p: Pointer): integer; stdcall;
// результаты обработки
function ar_GetProcessingResult(var ClassResult: integer): integer; stdcall;
function ar_GetIndicationsCount(var count: integer): integer; stdcall;
function ar_GetIndicationsList(p: Pointer): integer; stdcall;

implementation

const
  libariel = 'libariel.dll';

// модуль для перечисления функций экспорта библиотеки
function ar_LoadSettings; external libariel;
function ar_Free; external libariel;
// работа с прибором
function ar_DeviceConnect; external libariel;
function ar_DeviceDisconnect; external libariel;
function ar_DeviceCheckConnection; external libariel;
// сбор данных
function ar_StartAquireData; external libariel;
function ar_StopAquireData; external libariel;
// настройки обработки
function ar_PresetDevice; external libariel;
function ar_PresetPipe; external libariel;
function ar_StartCalibration; external libariel;
function ar_Calibrate; external libariel;
function ar_CheckCalibration; external libariel;
function ar_TestDeviceCalibration; external libariel;
// получение результатов
function ar_GetDataCount; external libariel;
function ar_GetDataChannelParams; external libariel;
function ar_SetDataChannelParams; external libariel;
// обработка данных
function ar_GetAquiredData; external libariel;
function ar_GetProcessedData; external libariel;
// результаты обработки
function ar_GetProcessingResult; external libariel;
function ar_GetIndicationsCount; external libariel;
function ar_GetIndicationsList; external libariel;

end.
