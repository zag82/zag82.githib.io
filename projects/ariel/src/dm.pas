unit dm;

interface

uses
  SysUtils, Classes, Sockets, ScktComp, Controls;

type
  TdataMod = class(TDataModule)
    tcpPL: TTcpClient;
    tcpPL_Aqc: TTcpClient;
    procedure tcpPLConnect(Sender: TObject);
    procedure tcpPLDisconnect(Sender: TObject);
    procedure tcpPLSend(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure tcpPLReceive(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure tcpPLError(Sender: TObject; SocketError: Integer);
    procedure tcpPL_AqcConnect(Sender: TObject);
    procedure tcpPL_AqcDisconnect(Sender: TObject);
    procedure tcpPL_AqcError(Sender: TObject; SocketError: Integer);
    procedure tcpPL_AqcReceive(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure tcpPL_AqcSend(Sender: TObject; Buf: PAnsiChar;
      var DataLen: Integer);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bShow: boolean;
  end;

var
  dataMod: TdataMod;

implementation

uses main;

{$R *.dfm}

procedure TdataMod.DataModuleCreate(Sender: TObject);
begin
  bShow := true;
end;

procedure TdataMod.tcpPLConnect(Sender: TObject);
begin
  fmArielMain.mLog.Lines.Add('Connected to PL500 at port 5001');
end;

procedure TdataMod.tcpPLDisconnect(Sender: TObject);
begin
  fmArielMain.mLog.Lines.Add('Disconnected from PL500 at port 5001');
end;

procedure TdataMod.tcpPLSend(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var i: integer;
begin
  if bShow then
  begin
    fmArielMain.mLog.Lines.Add('Send data. Length='+IntToStr(DataLen)+'bytes');
    for i := 0 to DataLen-1 do
      fmArielMain.mLog.Lines.Add('Buffer['+IntToStr(i)+'] = ' + IntToStr(Ord(Buf[i])));
  end;
end;

procedure TdataMod.tcpPLReceive(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var i: integer;
begin
  if bShow then
  begin
    fmArielMain.mLog.Lines.Add('Recieve data. Length='+IntToStr(DataLen)+'bytes');
    for i := 0 to DataLen-1 do
      fmArielMain.mLog.Lines.Add('Buffer['+IntToStr(i)+'] = ' + IntToStr(Ord(Buf[i])));
  end;
end;

procedure TdataMod.tcpPLError(Sender: TObject;
  SocketError: Integer);
begin
  fmArielMain.mLog.Lines.Add('Error occured. SocketErrorNumber: '+IntToStr(SocketError));
end;

procedure TdataMod.tcpPL_AqcConnect(Sender: TObject);
begin
  fmArielMain.mLogAq.Lines.Add('Connected to PL500 at port 5003');
end;

procedure TdataMod.tcpPL_AqcDisconnect(Sender: TObject);
begin
  fmArielMain.mLogAq.Lines.Add('Disconnected from PL500 at port 5003');
end;

procedure TdataMod.tcpPL_AqcError(Sender: TObject; SocketError: Integer);
begin
  fmArielMain.mLogAq.Lines.Add('Error occured. SocketErrorNumber: '+IntToStr(SocketError));
end;

procedure TdataMod.tcpPL_AqcReceive(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var i: integer;
begin
  if bShow then
  begin
    fmArielMain.mLogAq.Lines.Add('Data recieved. Length='+IntToStr(DataLen)+'bytes');
    for i := 0 to DataLen - 1 do
      fmArielMain.mLogAq.Lines.Add('['+IntToStr(i)+'] = ' + IntToStr(Ord(Buf[i])));
  end;
end;

procedure TdataMod.tcpPL_AqcSend(Sender: TObject; Buf: PAnsiChar;
  var DataLen: Integer);
var i: integer;
begin
  if bShow then
  begin
    fmArielMain.mLogAq.Lines.Add('Data send. Length='+IntToStr(DataLen)+'bytes');
    for i := 0 to DataLen-1 do
      fmArielMain.mLogAq.Lines.Add('['+IntToStr(i)+'] = ' + IntToStr(Ord(Buf[i])));
  end;
end;

end.
