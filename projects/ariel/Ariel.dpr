program Ariel;

uses
  Forms,
  about in 'src\about.pas' {fmAbout},
  color_data in 'src\color_data.pas',
  MainAriel in 'src\MainAriel.pas' {fmMainAriel},
  SignalData in 'src\SignalData.pas',
  movements in 'src\movements.pas',
  detail_editor in 'src\detail_editor.pas' {fmDetailEditor},
  Complx in 'src\Complx.pas',
  vector_priznak in 'src\vector_priznak.pas',
  azFileVersion in 'src\azFileVersion.pas',
  DataMod in 'src\DataMod.pas' {dm: TDataModule},
  DeviceSettings in 'src\DeviceSettings.pas' {fmDeviceSettings},
  CalibTestDevice in 'src\CalibTestDevice.pas' {fmCalibTestDevice},
  glGraphHuge in 'src\glGraphHuge.pas',
  ReportBuilder in 'src\ReportBuilder.pas' {fmReportBuilder},
  licGrd in 'lib\licGrd.pas',
  GrdDelphi in 'lib\GrdDelphi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ariel';
  Application.CreateForm(Tdm, dm);
  if dm.isLicenced then
  begin
    Application.CreateForm(TfmMainAriel, fmMainAriel);
    Application.Run;
  end;
end.
