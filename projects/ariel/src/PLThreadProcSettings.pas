unit PLThreadProcSettings;

interface

uses PLData, PLThreadProcessor;

type
  TPLThreadProcessorSettings=class
  public
    pl: TPLThreadProcessor;
    constructor Create(host: AnsiString);
    procedure Start;
    procedure Finish;
    // установка и получение значений
  end;

implementation

constructor TPLThreadProcessorSettings.Create(host: AnsiString);
begin
  pl := TPLThreadProcessor.Create(host, DEVICE_TCP_PARAM_PORT);
end;

procedure TPLThreadProcessorSettings.Start;
begin
  pl.Connect;
  pl.Start;
end;

procedure TPLThreadProcessorSettings.Finish;
begin
  pl.ThreadStop;
end;

end.
