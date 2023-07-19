unit PLThreadProcData;

interface

uses PLData, PLThreadProcessor;

type
  TPLThreadProcessorData=class
  public
    pl: TPLThreadProcessor;
    constructor Create(host: AnsiString);
    procedure Start;
    procedure Finish;
  end;

implementation

constructor TPLThreadProcessorData.Create(host: AnsiString);
begin
  pl := TPLThreadProcessor.Create(host, DEVICE_TCP_DATA_PORT);

end;

procedure TPLThreadProcessorData.Start;
begin
  pl.Connect;
  pl.Start;
end;

procedure TPLThreadProcessorData.Finish;
begin
  pl.ThreadStop;
end;

end.
