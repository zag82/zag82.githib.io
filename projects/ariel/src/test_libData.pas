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
	  pos1: integer;	// ������� ������ ���������
    pos2: integer;	// ������� ����� ���������
    center: double; // ���������� ������ ��������� (� �� ������������ ������ �������)
    volume: double; // ����� ������� � ��������� (0, ���� ���������� ��������)
    quality: integer; // ��������� ������������� �� ������ ��������: AR_CLASS_None, AR_CLASS_Proper, AR_CLASS_Recontrol ��� AR_CLASS_Waste
    channel: integer; // ����� �� �������� ������������ ��������
    orientation: integer; // ������������ ������ �������
    probe1: integer; // ��������� ������, ����������� �� ���� ���������
    probe2: integer; // �������� ������, ����������� �� ���� ���������
    defectType: integer; // ��� ������� 0-�������, 1-����������
    res3: integer; // ��������������� ��� �������� �������������
    dres0: double; // ��������������� ��� �������� �������������
    dres1: double; // ��������������� ��� �������� �������������
    dres2: double; // ��������������� ��� �������� �������������
    dres3: double; // ��������������� ��� �������� �������������
  end;

  TCalibDefect = packed record
    volume: double;	  // ����� �������
    dist: double;	    // ���������� �� ���� ������������� ������ �� ������ ������� (��)
    isExt: boolean;	  // ������� = true, ���������� = false
    isAxial: boolean;	// �������� = true, �����/��������� = false
    isWaste: boolean;	// ���� = true, ����� = false
  end;

// ������ ��� ������������ ������� �������� ����������
function ar_LoadSettings(fName: PChar): integer; stdcall;
function ar_Free(): integer; stdcall;
// ������ � ��������
function ar_DeviceConnect(): integer; stdcall;
function ar_DeviceDisconnect(): integer; stdcall;
function ar_DeviceCheckConnection(var connected: boolean): integer; stdcall;
// ���� ������
function ar_StartAquireData(): integer; stdcall;
function ar_StopAquireData(): integer; stdcall;
// ��������� ���������
function ar_PresetDevice(): integer; stdcall;
function ar_PresetPipe(ps: TPipeSettings): integer; stdcall;
function ar_StartCalibration(): integer;
function ar_Calibrate(defs: Pointer; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double): integer; stdcall;
function ar_CheckCalibration(defs: Pointer; nDefs: integer; frameWidth: double; var isCorrect: boolean): integer; stdcall;
function ar_TestDeviceCalibration(defs: Pointer; nDefs: integer; frameWidth: double; defParams: Pointer): integer; stdcall;
// ��������� �����������
function ar_GetDataCount(var cnt: integer): integer; stdcall;
function ar_GetDataChannelParams(iChannel: integer; var ci: TChannelInfo): integer; stdcall;
function ar_SetDataChannelParams(iChannel: integer; ci: TChannelInfo): integer; stdcall;
// ��������� ������
function ar_GetAquiredData(iChannel: integer; p: Pointer): integer; stdcall;
function ar_GetProcessedData(iChannel: integer; var z1, z2: integer; p: Pointer): integer; stdcall;
// ���������� ���������
function ar_GetProcessingResult(var ClassResult: integer): integer; stdcall;
function ar_GetIndicationsCount(var count: integer): integer; stdcall;
function ar_GetIndicationsList(p: Pointer): integer; stdcall;

implementation

const
  libariel = 'libariel.dll';

// ������ ��� ������������ ������� �������� ����������
function ar_LoadSettings; external libariel;
function ar_Free; external libariel;
// ������ � ��������
function ar_DeviceConnect; external libariel;
function ar_DeviceDisconnect; external libariel;
function ar_DeviceCheckConnection; external libariel;
// ���� ������
function ar_StartAquireData; external libariel;
function ar_StopAquireData; external libariel;
// ��������� ���������
function ar_PresetDevice; external libariel;
function ar_PresetPipe; external libariel;
function ar_StartCalibration; external libariel;
function ar_Calibrate; external libariel;
function ar_CheckCalibration; external libariel;
function ar_TestDeviceCalibration; external libariel;
// ��������� �����������
function ar_GetDataCount; external libariel;
function ar_GetDataChannelParams; external libariel;
function ar_SetDataChannelParams; external libariel;
// ��������� ������
function ar_GetAquiredData; external libariel;
function ar_GetProcessedData; external libariel;
// ���������� ���������
function ar_GetProcessingResult; external libariel;
function ar_GetIndicationsCount; external libariel;
function ar_GetIndicationsList; external libariel;

end.
