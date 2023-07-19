unit libExport;

interface

uses libMain, SignalData, ComPlx;

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

function ar_LoadSettings(fName: PChar): integer; stdcall;
begin
  Result := lm.LoadSettings(fName);
end;

function ar_Free(): integer; stdcall;
begin
  Result := lm.FreeData();
end;

// ������ � ��������
function ar_DeviceConnect(): integer; stdcall;
begin
  Result := lm.DeviceConnect();
end;

function ar_DeviceDisconnect(): integer; stdcall;
begin
  Result := lm.DeviceDisconnect();
end;

function ar_DeviceCheckConnection(var connected: boolean): integer; stdcall;
begin
  Result := lm.DeviceCheckConnection(connected);
end;

// ���� ������
function ar_StartAquireData(): integer; stdcall;
begin
  Result := lm.startAquireData();
end;

function ar_StopAquireData(): integer; stdcall;
begin
  Result := lm.stopAquireData();
end;

// ��������� ���������
function ar_PresetDevice(): integer; stdcall;
begin
  Result := lm.presetDevice();
end;

// ��������� ���������� ��� ���������� �����
function ar_PresetPipe(ps: TPipeSettings): integer; stdcall;
begin
  Result := lm.presetPipe(ps);
end;

function ar_StartCalibration(): integer;
begin
  Result := lm.calibrationPrepare();
end;

function ar_Calibrate(defs: Pointer; nDefs, iDefect: integer; frameWidth, calibValue, calibThreshold: double): integer; stdcall;
begin
  Result := lm.calibrationStart(defs, nDefs, iDefect, frameWidth, calibValue, calibThreshold);
end;

function ar_CheckCalibration(defs: Pointer; nDefs: integer; frameWidth: double; var isCorrect: boolean): integer; stdcall;
begin
  Result := lm.calibrationCheck(defs, nDefs, frameWidth, isCorrect);
end;

function ar_TestDeviceCalibration(defs: Pointer; nDefs: integer; frameWidth: double; defParams: Pointer): integer; stdcall;
begin
  Result := lm.calibrationTestDevice(defs, nDefs, frameWidth, defParams);
end;

// ��������� �����������
function ar_GetDataCount(var cnt: integer): integer; stdcall;
begin
  Result := lm.getDataCount(cnt);
end;

function ar_GetDataChannelParams(iChannel: integer; var ci: TChannelInfo): integer; stdcall;
begin
  Result := lm.getDataChannelParams(iChannel, ci);
end;

function ar_SetDataChannelParams(iChannel: integer; ci: TChannelInfo): integer; stdcall;
begin
  Result := lm.setDataChannelParams(iChannel, ci);
end;

// ��������� ������
function ar_GetAquiredData(iChannel: integer; p: Pointer): integer; stdcall;
begin
  Result := lm.getAquiredData(iChannel, p);
end;

function ar_GetProcessedData(iChannel: integer; var z1, z2: integer; p: Pointer): integer; stdcall;
begin
  Result := lm.getProcessedData(iChannel, z1, z2, p);
end;

// ���������� ���������
function ar_GetProcessingResult(var ClassResult: integer): integer; stdcall;
begin
  Result := lm.getProcessingResult(ClassResult);
end;

function ar_GetIndicationsCount(var count: integer): integer; stdcall;
begin
  Result := lm.getIndicationsCount(count);
end;

function ar_GetIndicationsList(p: Pointer): integer; stdcall;
begin
  Result := lm.getIndicationsList(p);
end;

end.
