program ArielAquire;

uses
  Forms,
  MainArielAq in 'src\MainArielAq.pas' {fmMainArielAquire},
  SignalData in 'src\SignalData.pas',
  PLData in 'src\PLData.pas',
  PLThread in 'src\PLThread.pas',
  PLThreadProcData in 'src\PLThreadProcData.pas',
  PLThreadProcessor in 'src\PLThreadProcessor.pas',
  PLThreadProcSettings in 'src\PLThreadProcSettings.pas',
  about in 'src\about.pas' {fmAbout},
  DeviceSettings in 'src\DeviceSettings.pas' {fmDeviceSettings},
  DeviceInfo in 'src\DeviceInfo.pas' {fmDeviceInfo},
  DeviceSettingsCh in 'src\DeviceSettingsCh.pas' {fmDeviceSettingsCh},
  detail_editor in 'src\detail_editor.pas' {fmDetailEditor},
  CommonSettings in 'src\CommonSettings.pas' {fmCommonSettings},
  azFileVersion in 'src\azFileVersion.pas',
  DataMod in 'src\DataMod.pas' {dm: TDataModule},
  glGraph in 'src\glGraph.pas',
  ecGraph in 'src\ecGraph.pas',
  UserMode in 'src\UserMode.pas' {fmUserMode},
  GrdDelphi in 'lib\GrdDelphi.pas',
  licGrd in 'lib\licGrd.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ariel Aquire';
  Application.CreateForm(Tdm, dm);
  if dm.isLicenced then
  begin
    Application.CreateForm(TfmMainArielAquire, fmMainArielAquire);
    Application.Run;
  end;
end.
