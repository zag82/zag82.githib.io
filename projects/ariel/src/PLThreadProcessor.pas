unit PLThreadProcessor;

interface

uses PLThread, PLData, Sockets, Classes;

type
  TSyncDataStruct=record
    header: TPLMessageHeader;
    data: array of TPLStructDataAcquisition;
  end;

  TSyncResponseStruct=record
    header: TPLMessageHeader;
    data: array of integer;
  end;

  TSyncTextInfoStruct=record
    header: TPLMessageHeader;
    data: array of TTextResponse;
  end;

  TOnDeviceError = procedure() of object;
  TOnDataEvent = procedure(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition) of object;
  TOnGetTextResponseEvent = procedure(header: TPLMessageHeader; var data: array of TTextResponse) of object;
  TOnGetValueResponseEvent = procedure(header: TPLMessageHeader; var data: array of integer) of object;

  TPLThreadProcessor = class(TPLThread)
  private
    syncDataStruct: TSyncDataStruct;
    syncResponseStruct: TSyncResponseStruct;
    syncTextInfoStruct: TSyncTextInfoStruct;
    FUseSyncMethods: boolean;
  protected
    procedure recieveDataProcessor(tcp: TTcpClient);
    procedure readIPStream(ms: TMemoryStream; tcp: TTcpClient; cnt: integer);
    // ���������������� ���������
    procedure deviceDataShow(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition);
    procedure deviceResponse(header: TPLMessageHeader; var data: array of integer);
    procedure deviceGetTextInfo(header: TPLMessageHeader; var data: array of TTextResponse);
    // ���������������� ���������
    procedure syncDeviceDataShow();
    procedure syncDeviceResponse();
    procedure syncDeviceGetTextInfo();
  public
    OnDeviceError: TOnDeviceError;
    OnDeviceDataShow: TOnDataEvent;
    OnDeviceDataLoss: TOnDeviceError;
    OnDeviceResponse: TOnGetValueResponseEvent;
    OnDeviceGetTextInfo: TOnGetTextResponseEvent;
    constructor Create(host, port:AnsiString);
    procedure setSyncState(bUseSyncMethods: boolean);
  end;

implementation

uses WinSock, Windows;

{$REGION '�������������'}
procedure TPLThreadProcessor.deviceDataShow(header: TPLMessageHeader; var data: array of TPLStructDataAcquisition);
var i, n: integer;
begin
  // ������� ����������
  syncDataStruct.header := header;
  n := Length(data);
  SetLength(syncDataStruct.data, n);
  for i := 0 to n - 1 do
    syncDataStruct.data[i] := data[i];
  // �������� ������������������ �������
  Synchronize(syncDeviceDataShow);
end;

procedure TPLThreadProcessor.deviceResponse(header: TPLMessageHeader; var data: array of integer);
var i, n: integer;
begin
  // ������� ����������
  syncResponseStruct.header := header;
  n := Length(data);
  SetLength(syncResponseStruct.data, n);
  for i := 0 to n - 1 do
    syncResponseStruct.data[i] := data[i];
  // �������� ������������������ �������
  Synchronize(syncDeviceResponse);
end;

procedure TPLThreadProcessor.deviceGetTextInfo(header: TPLMessageHeader; var data: array of TTextResponse);
var i, n: integer;
begin
  // ������� ����������
  syncTextInfoStruct.header := header;
  n := Length(data);
  SetLength(syncTextInfoStruct.data, n);
  for i := 0 to n - 1 do
    syncTextInfoStruct.data[i] := data[i];
  // �������� ������������������ �������
  Synchronize(syncDeviceGetTextInfo);
end;

procedure TPLThreadProcessor.syncDeviceDataShow();
begin
  if Assigned(OnDeviceDataShow) then
    OnDeviceDataShow(syncDataStruct.header, syncDataStruct.data);
end;

procedure TPLThreadProcessor.syncDeviceResponse();
begin
  if Assigned(OnDeviceResponse) then
    OnDeviceResponse(syncResponseStruct.header, syncResponseStruct.data);
end;

procedure TPLThreadProcessor.syncDeviceGetTextInfo();
begin
  if Assigned(OnDeviceGetTextInfo) then
    OnDeviceGetTextInfo(syncTextInfoStruct.header, syncTextInfoStruct.data);
end;

{$ENDREGION}

procedure TPLThreadProcessor.readIPStream(ms: TMemoryStream; tcp: TTcpClient; cnt: integer);
var
  inBytes: array of byte;
  len, ActualLen, resLen: integer;
  addr: TSockAddr;
begin
  addr := tcp.GetSocketAddr(tcp.RemoteHost, tcp.RemotePort);
  // ��������� ��� ������ � ����� ms �� ������ tcp ������� ���� �������� cnt
  SetLength(inBytes, cnt);
  // ������� ����� ���������� ������
  ms.Clear;
  // ���������
  len := cnt;
  repeat
    ActualLen := tcp.ReceiveFrom(inBytes[0], len, addr, resLen);
    ms.WriteBuffer(inBytes[0], ActualLen);
    len := len - ActualLen;
    if len <> 0 then
      Sleep(50);
  until (len = 0);
  // ��������� ��������� � ������ ������ � ������, ���� ����� ����� ���� ������ �� ����
  ms.Seek(0, soFromBeginning);
  // ������ ������
  inBytes := nil;
end;

procedure TPLThreadProcessor.recieveDataProcessor(tcp: TTcpClient);
var
  ms: TMemoryStream;
  inH: TPLMessageHeader;
  numInD: integer;
  inD: array of TPLStructDataAcquisition;
  inDint: array of integer;
  inDtext: array of TTextResponse;
  lenD: integer;
  len, ActualLen: integer;
  I: Integer;
begin
  ms := TMemoryStream.Create();
  try
    // ������ �� ������
    // ���������
    readIPStream(ms, tcp, sizeof(inH));
    ms.ReadBuffer(inH, sizeof(inH));
    if inH.Prefix <> MAGIC_PREFIX then
    begin
      if Assigned(OnDeviceError) then
      begin
        if FUseSyncMethods then
          Synchronize(OnDeviceError)
        else
          OnDeviceError;
      end;
    end
    else
    begin
      // ��������� ������
      case inH.DType of
        DATA_TYPE_NONE: lenD := 0;
        DATA_TYPE_BYTE: lenD := 1;
        DATA_TYPE_INT16: lenD := 2;
        DATA_TYPE_INT32: lenD := 4;
        DATA_TYPE_TEXT8: lenD := 8;
      else
        lenD := 1;
      end;
      if inH.Length > 0 then
      begin
        // ������ ���������� ������, ����� ����� ����������� � ����
        readIPStream(ms, tcp, inH.Length);
        // ��������� ������ �� ����������
        if (inH.MType = MSG_TYPE_EVENT) and (inH.ID = MSG_Data) then
        begin
          // ��� ������ � ������������� ������ � ��������
          lenD := sizeOf(TPLStructDataAcquisition);
          numInD := inH.Length div lenD;
          SetLength(inD, numInD);
          for I := 0 to numInD - 1 do
            ms.ReadBuffer(inD[i], lenD);
          // �������� ������ �����������
          if FUseSyncMethods then
            // ��������� ������ � ���������� �� � ������������������ ������
            deviceDataShow(inH, inD)
          else
          begin
            if Assigned(OnDeviceDataShow) then
              OnDeviceDataShow(inH, inD);
          end;
        end
        else
        begin
          // ��� ��������� �������
          numInD := inH.Length div lenD;
          if inH.DType = DATA_TYPE_TEXT8 then
          begin
            SetLength(inDtext, numInD);
            for I := 0 to numInD - 1 do
              ms.ReadBuffer(inDtext[i], lenD);
            // �������� ������ �����������
            if FUseSyncMethods then
              deviceGetTextInfo(inH, inDtext)
            else
            begin
              if Assigned(OnDeviceGetTextInfo) then
                OnDeviceGetTextInfo(inH, inDtext);
            end;
          end
          else
          begin
            SetLength(inDint, numInD);
            for I := 0 to numInD - 1 do
              ms.ReadBuffer(inDint[i], lenD);
            // �������� ������ �����������
            if (inH.MType = MSG_TYPE_EVENT) and (inH.ID = MSG_DataLoss) then
            begin
              if Assigned(OnDeviceDataLoss) then
              begin
                if FUseSyncMethods then
                  Synchronize(OnDeviceDataLoss)
                else
                  OnDeviceDataLoss();
              end;
            end
            else
            begin
              if FUseSyncMethods then
                deviceResponse(inH, inDint)
              else
              begin
                if Assigned(OnDeviceResponse) then
                  OnDeviceResponse(inH, inDint);
              end;
            end;
          end;
        end;
      end;
    end;
  finally
    ms.Free;
  end;
end;

constructor TPLThreadProcessor.Create(host, port:AnsiString);
begin
  inherited Create(host, port);
  FUseSyncMethods := true;
  OnRecieveData := recieveDataProcessor;
end;

procedure TPLThreadProcessor.setSyncState(bUseSyncMethods: boolean);
begin
  FUseSyncMethods := bUseSyncMethods;
end;

end.
