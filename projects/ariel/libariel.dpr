library libariel;

uses
  SysUtils,
  Classes,
  libMain in 'src\libMain.pas',
  libExport in 'src\libExport.pas',
  libOperationData in 'src\libOperationData.pas',
  Complx in 'src\Complx.pas',
  SignalData in 'src\SignalData.pas',
  PLThreadProcSettings in 'src\PLThreadProcSettings.pas',
  PLData in 'src\PLData.pas',
  PLThread in 'src\PLThread.pas',
  PLThreadProcData in 'src\PLThreadProcData.pas',
  PLThreadProcessor in 'src\PLThreadProcessor.pas';

exports
  ar_LoadSettings,  // validated
  ar_Free,          // validated

  ar_DeviceConnect,         // validated
  ar_DeviceDisconnect,      // validated
  ar_DeviceCheckConnection, // validated

  ar_StartAquireData,       // validated
  ar_StopAquireData,        // validated

  ar_PresetDevice,          // validated
  ar_PresetPipe,            // validated
  ar_StartCalibration,      // validated
  ar_Calibrate,             // validated
  ar_CheckCalibration,      // validated
  ar_TestDeviceCalibration, // validated

  ar_GetDataCount,          // validated
  ar_GetDataChannelParams,  // validated
  ar_SetDataChannelParams,  // validated

  ar_GetAquiredData,        // validated
  ar_GetProcessedData,      // validated

  ar_GetProcessingResult,   // validated
  ar_GetIndicationsCount,   // validated
  ar_GetIndicationsList;    // validated

{$R *.res}
begin
  // סמחהאול מבתוךע הכÿ נאבמעû
  lm := TLibMain.Create();
  lm.InitData();
end.
