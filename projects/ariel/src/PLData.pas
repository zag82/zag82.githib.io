unit PLData;

interface

const
  DEVICE_TCP_DATA_PORT = '5003';
  DEVICE_TCP_PARAM_PORT = '5001';

  // MType parameter values
  // from client to device
  MSG_TYPE_QUERY = $00;    // query the value of the parameter
  MSG_TYPE_DATASET = $01;  // set the value of the parameter
  MSG_TYPE_DATASTEP = $02; // increment or decrement the value of the parameter
  MSG_TYPE_COMMAND = $03;  // trigger an action (e.g. Balancing)
  // from device to client
  MSG_TYPE_REMORE = $81;   // response to request, more to follow
  MSG_TYPE_RELAST = $82;   // last response to request
  MSG_TYPE_BUSY = $83;     // the device is busy for some time from now on
  MSG_TYPE_EVENT = $80;    // message without request

  // DType parameter values
  DATA_TYPE_NONE = $00;   // no data, length must be zero
  DATA_TYPE_BYTE = $01;   // byte data, can be any number
  DATA_TYPE_INT16 = $02;  // 16 bit ints, Length must be multiple of 2
  DATA_TYPE_INT32 = $03;  // 32 bit ints, Length must be multiple of 4
  DATA_TYPE_TEXT8 = $05;  // 8 bit chars, interpreted as string, NULL terminated

  // ID values
  // Parametrization procedure
  MSG_Login = $0001;
  MSG_UserLEvel = $08D1;
  MSG_DevInfo = $0008;
  MSG_DevType = $0009;
  MSG_DevName = $000A;
  MSG_DevVendor = $000B;
  MSG_DevRelease = $000C;
  MSG_DevSerno = $000D;
  MSG_DevDriver = $000E;
  MSG_DevId = $000F;
  MSG_DevOs = $0010;
  MSG_NumChan = $0811;
  MSG_ModuleList = $08D3;

  MSG_SaveSetting = $0024;
  MSG_ActivateSetting = $0023;
  MSG_ConfigData = $08D0;

  MSG_DrvFreq = $0801;
  MSG_DrvAmpl = $0802;
  MSG_VoltRange = $0835;

  MSG_PreAmp = $0813;
  MSG_AutoPreAmp = $0831;
  MSG_BWLimit = $0834;
  MSG_MainAmp = $0814;
  MSG_SpreadX = $0815;
  MSG_SpreadY = $0816;

  MSG_Phase = $0817;
  MSG_Liftoff = $0830;
  MSG_DotPosX = $081A;
  MSG_DotPosY = $081B;

  MSG_FilterType = $081C;
  MSG_HiPass = $0818;
  MSG_LoPass = $0819;
  MSG_Balance = $0840;
  MSG_BalParam = $0847;

  MSG_IOCounterReset = $0911;
  MSG_IOCounterMode = $0912;
  MSG_IOCounterPageList = $0913;

  // MUX parameters
  MSG_MuxStart = $08C1;
  MSG_MuxEnd = $08C2;
  MSG_MuxSamples = $08C3;

  // Acquisition procedure
  MSG_DataBlock = $1200;
  MSG_TriggerMode = $1201;
  MSG_TriggerAddress = $1202;
  MSG_TriggerDecimation = $1203;
  MSG_TriggerMask = $1204;
  MSG_TriggerValue = $1205;
  MSG_Data = $1206;
  MSG_DataLoss = $1207;
  MSG_PreferredSize = $1211;
  MSG_MaxMode = $1212;

  CH_ALL = $FFFF;

type
  TPLPrefix = array [0..3] of AnsiChar;
  TTextResponse = array [0..7] of AnsiChar;

const
  MAGIC_PREFIX:TPLPrefix = ('E', 'S', 'R', #00);

type
  TPLMessageHeader = record
    Prefix: TPLPrefix; // magic string for device error check
    Count: word;       // message counter
    MType: byte;       // message type
    DType: byte;       // type of data attached
    ID: word;          // message ID
    Index1: word;      // Index1 from 0 to $FFFE, $FFFF for broadcast
    Index2: word;      // Index2 from 0 to $FFFE, $FFFF for broadcast
    Length: word;      // length in bytes of the following data
  end;

  TPLStructDataAcquisition=record
    statusSlotAddress: byte;
    statusDataValid: byte;
    statusSubChannel:byte;
    statusModuleSpecific: byte;
    dataY: SmallInt;
    dataX: SmallInt;
  end;

  TPLSendDataStruct<T> = class
  private
    FNumber: integer;
    FData: array of T;
  public
    function getData(index: integer):T;
    constructor Create(var data: array of T);
    procedure FreeData();
  end;


implementation

{$REGION 'TPLSendDataStruct - реализация методов'}
function TPLSendDataStruct<T>.getData(index: integer):T;
begin
  Result := FData[index];
end;

constructor TPLSendDataStruct<T>.Create(var data: array of T);
var i: integer;
begin
  FNumber := Length(data);
  SetLength(FData, FNumber);
  for i := 0 to FNumber - 1 do
    FData[i] := data[i];
end;

procedure TPLSendDataStruct<T>.FreeData();
begin
  FNumber := 0;
  FData := nil;
end;
{$ENDREGION}
end.
