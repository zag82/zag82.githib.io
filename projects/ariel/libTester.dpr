program libTester;

uses
  Forms,
  mainTester in 'src\mainTester.pas' {fmLibTester},
  test_libData in 'src\test_libData.pas',
  HeaderExchanger in 'src\HeaderExchanger.pas' {fmHeaderExchanger};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmLibTester, fmLibTester);
  Application.Run;
end.
