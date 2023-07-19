unit PLThread;

interface

uses Classes, Sockets, PLData;

type
  TTCPMessageType = (tmtConnected = 0, tmtDisconnected, tmtError);

  TOnRecieveData = procedure(tcp: TTcpClient) of object;
  TOnTCPMessage = procedure(msgType: TTCPMessageType; msgText: AnsiString) of object;

  TPLThread=class(TThread)
  private
    function getConnected():boolean;
    procedure tcpPLConnect(Sender: TObject);
    procedure tcpPLDisconnect(Sender: TObject);
    procedure tcpPLError(Sender: TObject; SocketError: Integer);
  protected
    counter: integer;
    tcp: TTcpClient;
    bRun: boolean;
    procedure Execute;  override;
  public
    OnRecieveData: TOnRecieveData;
    OnTCPMessage: TOnTCPMessage;
    procedure ThreadStop;
    property isConnected: boolean read getConnected;
    constructor Create(host, port:AnsiString);
    procedure Connect;
    procedure Disconnect;
    procedure sendData(MType, DType: byte; ID, Index1, Index2: word; data: array of integer);
  end;

implementation

uses winSock, SysUtils;

{$REGION 'Соединения'}
function TPLThread.getConnected():boolean;
begin
  Result := tcp.Connected;
end;

procedure TPLThread.tcpPLConnect(Sender: TObject);
begin
  if Assigned(OnTCPMessage) then
    OnTCPMessage(tmtConnected, 'Connected to PL500 at port ' + tcp.RemotePort);
end;

procedure TPLThread.tcpPLDisconnect(Sender: TObject);
begin
  if Assigned(OnTCPMessage) then
    OnTCPMessage(tmtDisconnected, 'Disconnected from PL500 at port ' + tcp.RemotePort);
end;

procedure TPLThread.tcpPLError(Sender: TObject; SocketError: Integer);
begin
  if Assigned(OnTCPMessage) then
    OnTCPMessage(tmtError, 'Error occured. SocketErrorNumber: '+IntToStr(SocketError));
end;

procedure TPLThread.Connect;
begin
  if not tcp.Connected then
    tcp.Connect;
end;

procedure TPLThread.Disconnect;
begin
  if tcp.Connected then
    tcp.Disconnect;
end;

{$ENDREGION}

{$REGION 'Передача данных'}
constructor TPLThread.Create(host, port:AnsiString);
begin
  inherited Create(true);
  counter := 1;
  bRun := true;
  // создаем клиентское соединение с предпочтительными настройками
  tcp := TTcpClient.Create(nil);
  tcp.BlockMode := bmBlocking;
  tcp.RemoteHost := host;
  tcp.RemotePort := port;
  // регистрируем обработчиков событий
  tcp.OnConnect := tcpPLConnect;
  tcp.OnDisconnect := tcpPLDisconnect;
  tcp.OnError := tcpPLError;
end;

procedure TPLThread.sendData(MType, DType: byte; ID, Index1, Index2: word; data: array of integer);
var
  outH: TPLMessageHeader;
  lenD: word;
  i:integer;
  tmpB: byte;
  tmpW: word;
  addr: TSockAddr;
begin
  addr := tcp.GetSocketAddr(tcp.RemoteHost, tcp.RemotePort);
  // готовим переменные
  case DType of
    DATA_TYPE_NONE: lenD := 0;
    DATA_TYPE_BYTE: lenD := 1;
    DATA_TYPE_INT16: lenD := 2;
    DATA_TYPE_INT32: lenD := 4;
    DATA_TYPE_TEXT8: lenD := 8;
  else
    lenD := 8;
  end;
  // готовим исходные данные
  outH.Prefix := MAGIC_PREFIX;
  outH.Count := counter;
  outH.MType := MType;
  outH.DType := DType;
  outH.ID := ID;
  outH.Index1 := Index1;
  outH.Index2 := Index2;
  outH.Length := lenD * Length(data);
  // шлем запрос
  tcp.SendTo(outH, sizeof(outH), addr);
  if lenD > 0 then
  begin
    for i := 0 to High(data) do
      Case DType of
        1: begin tmpB := data[i]; tcp.SendTo(tmpB, lenD, addr); end;
        2: begin tmpW := data[i]; tcp.SendTo(tmpW, lenD, addr); end;
        3: tcp.SendTo(data[i], lenD, addr);
      End;
  end;
  inc(counter);
end;

procedure TPLThread.Execute;
begin
  while bRun do
  begin
    if tcp.Connected then
    begin
      if tcp.WaitForData(10) then
      begin
        if Assigned(OnRecieveData) then
          OnRecieveData(tcp);
      end;
    end
    else
      bRun := false;
  end;
  tcp.Disconnect;
end;

procedure TPLThread.ThreadStop;
begin
  bRun := false;
end;
{$ENDREGION}

end.
