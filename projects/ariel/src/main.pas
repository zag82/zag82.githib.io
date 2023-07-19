unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, Sockets, TeEngine, Series, ExtCtrls,
  TeeProcs, Chart;

type
  TfmArielMain = class(TForm)
    mMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    pc: TPageControl;
    tsControl: TTabSheet;
    tsAcquire: TTabSheet;
    Label1: TLabel;
    cbxMType: TComboBox;
    Label3: TLabel;
    cbxDType: TComboBox;
    Label4: TLabel;
    edID: TEdit;
    Label5: TLabel;
    edIndex1: TEdit;
    Label6: TLabel;
    edIndex2: TEdit;
    Label7: TLabel;
    edData: TEdit;
    btSendSettings: TButton;
    mm: TMemo;
    Label2: TLabel;
    mLog: TMemo;
    ma: TMemo;
    mLogAq: TMemo;
    Label8: TLabel;
    btAquire: TButton;
    Label9: TLabel;
    cbxMType2: TComboBox;
    Label10: TLabel;
    cbxDType2: TComboBox;
    Label11: TLabel;
    edID2: TEdit;
    Label12: TLabel;
    edIndex1_a: TEdit;
    Label13: TLabel;
    edIndex2_a: TEdit;
    Label14: TLabel;
    edData2: TEdit;
    btEndRead: TButton;
    Chart1: TChart;
    Series2: TFastLineSeries;
    Series1: TFastLineSeries;
    btAcquireCounter: TButton;
    pnlCharts: TPanel;
    Chart2: TChart;
    Series3: TFastLineSeries;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btSendSettingsClick(Sender: TObject);
    procedure btAquireClick(Sender: TObject);
    procedure btEndReadClick(Sender: TObject);
    procedure btAcquireCounterClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
  private
    readFinished: Boolean;
    FSeriesMaxValue: Integer;
    { Private declarations }
    procedure setSeriesMaxValue(value: integer);
    procedure readDeviceData(var tcp:TTCPClient);
    procedure readDeviceDataThread(var tcp:TTCPClient);
    procedure setTriggerMode(mode:integer);
  public
    { Public declarations }
    globalCount: integer;
    procedure sendSettingsData(var tcp:TTCPClient; mtype, dtype:byte; id, ix1, ix2: word; data: array of integer);
    property seriesMaxValue: integer read FSeriesMaxValue write SetSeriesMaxValue;
  end;

var
  fmArielMain: TfmArielMain;

implementation

uses about, dm, cmn, winSock, main2, MainAriel;

{$R *.dfm}

procedure TfmArielMain.setSeriesMaxValue(value: integer);
begin
  FSeriesMaxValue := value;
  Chart1.BottomAxis.Maximum := value;
end;

{$REGION 'Сбор данных'}
procedure TfmArielMain.sendSettingsData(var tcp:TTCPClient; mtype, dtype:byte; id, ix1, ix2: word; data: array of integer);
var
  inH, outH: TPLMessageHeader;
  inD: array of byte;
  addr: TSockAddr;
  len: integer;
  lenD: word;
  i:integer;
  tmpB: byte;
  tmpW: word;
begin
  // готовим переменные
  case dtype of
    0: lenD := 0;
    1: lenD := 1;
    2: lenD := 2;
    3: lenD := 4;
  else
    lenD := 8;
    dtype := 5;
  end;
  // готовим исходные данные
  outH.Prefix := MAGIC_PREFIX;
  outH.Count := globalCount;
  outH.MType := mtype;
  outH.DType := dtype;
  outH.ID := id;
  outH.Index1 := ix1;
  outH.Index2 := ix2;
  outH.Length := lenD * Length(data);
  // соединяемся
  addr := tcp.GetSocketAddr(tcp.RemoteHost, tcp.RemotePort);
  // шлем запрос
  tcp.SendTo(outH, sizeof(outH), addr);
  if lenD > 0 then
  begin
    for i := 0 to High(data) do
      Case dtype of
        1: begin tmpB := data[i]; tcp.SendTo(tmpB, lenD, addr); end;
        2: begin tmpW := data[i]; tcp.SendTo(tmpW, lenD, addr); end;
        3: tcp.SendTo(data[i], lenD, addr);
      End;
  end;
  // получаем ответ
  repeat
    tcp.ReceiveFrom(inH, sizeof(inH), addr, len);
    // получаем данные
    SetLength(inD, inH.Length);
    for i := 0 to inH.Length - 1 do
      tcp.ReceiveFrom(inD[i], 1, addr, len);
    // печатаем все о присланном ответе
    ma.Lines.Add('Prefix: ' + inH.Prefix[0] + inH.Prefix[1] + inH.Prefix[2]);
    ma.Lines.Add('Count: ' + IntToStr(inH.Count));
    ma.Lines.Add('MType: ' + IntToStr(inH.MType));
    ma.Lines.Add('DType: ' + IntToStr(inH.DType));
    ma.Lines.Add('ID: ' + IntToStr(inH.ID));
    ma.Lines.Add('Index1: ' + IntToStr(inH.Index1));
    ma.Lines.Add('Index2: ' + IntToStr(inH.Index2));
    ma.Lines.Add('Length: ' + IntToStr(inH.Length));
    ma.Lines.Add('');
    //ma.Lines.Add('Data: ' + IntToStr(inD));
    inc(globalCount);
    if (inH.MType < $80) or (inH.MType > $85) then break;
  until inH.MType = $82;
  inD := nil
end;

procedure TfmArielMain.readDeviceData(var tcp:TTCPClient);
type
  TPLAckData=record
    statusSlotAddress: byte;
    statusDataValid: byte;
    statusSubChannel:byte;
    statusModuleSpecific: byte;
    dataY: SmallInt;
    dataX: SmallInt;
  end;
var
  inH: TPLMessageHeader;
  numInD: integer;
  inD: array of TPLAckData;
  addr: TSockAddr;
  len: integer;
  I: Integer;
begin
  // читаем данные из сокета
  // соединяемся
  addr := tcp.GetSocketAddr(tcp.RemoteHost, tcp.RemotePort);
  tcp.ReceiveFrom(inH, sizeof(inH), addr, len);
  // получаем данные
  numInD := inH.Length div sizeof(TPLAckData);
  setLength(inD, numInD);
  for I := 0 to numInD - 1 do
    tcp.ReceiveFrom(inD[i], sizeOf(TPLAckData), addr, len);
  // печатаем все о присланном ответе
  ma.Lines.Add('---');
  ma.Lines.Add('Data count: ' + IntToStr(numInD));
{  ma.Lines.Add('---');
  ma.Lines.Add('Prefix: ' + inH.Prefix[0] + inH.Prefix[1] + inH.Prefix[2]);
  ma.Lines.Add('Count: ' + IntToStr(inH.Count));
  ma.Lines.Add('MType: ' + IntToStr(inH.MType));
  ma.Lines.Add('DType: ' + IntToStr(inH.DType));
  ma.Lines.Add('ID: ' + IntToStr(inH.ID));
  ma.Lines.Add('Index1: ' + IntToStr(inH.Index1));
  ma.Lines.Add('Index2: ' + IntToStr(inH.Index2));
  ma.Lines.Add('Length: ' + IntToStr(inH.Length));
  ma.Lines.Add('');         }
  for I := 0 to (numInD - 1) do
  begin
    // статус
    if ((inD[i].statusDataValid shr 7) = 1)and
        (inD[i].statusSlotAddress = 0){and
        (inD[i].statusSubChannel = 0)} then
    //  Series2.Add(inD[i].statusDataValid);
      Series2.Add(inD[i].dataY shl 8 + inD[i].dataX);
{    inD[2*i+1]
    if(odd(i))then
    begin
      // данные

    end
    else
    begin
      // статус
    end;
    Series2.Add(inD[i]);  }
  end;
  //  ma.Lines.Add('Data: ' + IntToStr(inD[i]));
  inc(globalCount);
end;

procedure TfmArielMain.readDeviceDataThread(var tcp:TTCPClient);
type
  TPLAckData=record
    statusSlotAddress: byte;
    statusDataValid: byte;
    statusSubChannel:byte;
    statusModuleSpecific: byte;
    dataY: SmallInt;
    dataX: SmallInt;
  end;
var
  inH: TPLMessageHeader;
  numInD: integer;
  inD: array of TPLAckData;
  addr: TSockAddr;
  len: integer;
  I: Integer;
begin
  // проверяем есть ли что-то в буфере сокета
  if tcp.BytesReceived > 0 then
  begin
    // читаем данные из сокета
    addr := tcp.GetSocketAddr(tcp.RemoteHost, tcp.RemotePort);
    tcp.ReceiveFrom(inH, sizeof(inH), addr, len);
    // получаем данные
    numInD := inH.Length div sizeof(TPLAckData);
    setLength(inD, numInD);
    for I := 0 to numInD - 1 do
      tcp.ReceiveFrom(inD[i], sizeOf(TPLAckData){*numInD}, addr, len);
    // печатаем все о присланном ответе
//    ma.Lines.Add('---');
//    ma.Lines.Add('Data count: ' + IntToStr(numInD));
  {  ma.Lines.Add('---');
    ma.Lines.Add('Prefix: ' + inH.Prefix[0] + inH.Prefix[1] + inH.Prefix[2]);
    ma.Lines.Add('Count: ' + IntToStr(inH.Count));
    ma.Lines.Add('MType: ' + IntToStr(inH.MType));
    ma.Lines.Add('DType: ' + IntToStr(inH.DType));
    ma.Lines.Add('ID: ' + IntToStr(inH.ID));
    ma.Lines.Add('Index1: ' + IntToStr(inH.Index1));
    ma.Lines.Add('Index2: ' + IntToStr(inH.Index2));
    ma.Lines.Add('Length: ' + IntToStr(inH.Length));
    ma.Lines.Add('');         }
    for I := 0 to (numInD - 1) do
    begin
      // статус
      if ((inD[i].statusDataValid shr 7) = 1)and
          (inD[i].statusSlotAddress = 1)and
          (inD[i].statusSubChannel = 0) then
      begin
        if Series2.Count > seriesMaxValue then begin Series2.Clear; Series1.Clear; Series3.Clear; end;
        Series2.Add(inD[i].dataX);
        Series1.Add(inD[i].dataY);
        Series3.AddXY(inD[i].dataX, inD[i].dataY);
        //Series2.Add(inD[i].dataY shl 8 + inD[i].dataX);

      end;
    end;
    inc(globalCount);
  end;
end;

procedure TfmArielMain.setTriggerMode(mode:integer);
begin

end;
{$ENDREGION}


procedure TfmArielMain.N4Click(Sender: TObject);
begin
  fmAbout := TfmAbout.Create(Application);
  fmAbout.ShowModal;
  fmAbout.Free;
end;

procedure TfmArielMain.N6Click(Sender: TObject);
begin
  fmMain2 := TfmMain2.Create(Application);
  fmMain2.ShowModal;
  fmMain2.Free;
end;

procedure TfmArielMain.N7Click(Sender: TObject);
begin
  fmMainAriel := TfmMainAriel.Create(Application);
  fmMainAriel.ShowModal;
  fmMainAriel.Free;
end;

procedure TfmArielMain.N3Click(Sender: TObject);
begin
  Close;
end;

procedure TfmArielMain.FormCreate(Sender: TObject);
begin
  mm.Lines.Clear;
  mLog.Lines.Clear;
  ma.Lines.Clear;
  mLogAq.Lines.Clear;
  globalCount := 0;
end;

{$REGION 'Управление прибором'}
procedure TfmArielMain.btSendSettingsClick(Sender: TObject);
var
  inH, outH: TPLMessageHeader;
  inD, outD: integer;
  addr: TSockAddr;
  len: integer;
  dtype, mtype: byte;
  id, ix1, ix2, lenD: word;
begin
  mm.Lines.Clear;
  mLog.Lines.Clear;
  // готовим переменные
  mtype := cbxMType.ItemIndex;
  dtype := cbxDType.ItemIndex;
  case dtype of
    0: lenD := 0;
    1: lenD := 1;
    2: lenD := 2;
    3: lenD := 4;
  else
    lenD := 8;
    dtype := 5;
  end;
  id := StrToInt(edID.Text);
  ix1 := StrToInt(edIndex1.Text);
  ix2 := StrToInt(edIndex2.Text);
  // готовим исходные данные
  outH.Prefix := MAGIC_PREFIX;
  outH.Count := globalCount;
  outH.MType := mtype;
  outH.DType := dtype;
  outH.ID := id;
  outH.Index1 := ix1;
  outH.Index2 := ix2;
  outH.Length := lenD;
  outD := StrToInt(edData.Text);
  // соединяемся
  dataMod.tcpPL.Connect;
  addr := dataMod.tcpPL.GetSocketAddr(dataMod.tcpPL.RemoteHost, dataMod.tcpPL.RemotePort);
  // шлем запрос
  dataMod.tcpPL.SendTo(outH, sizeof(outH), addr);
  if lenD > 0 then
    dataMod.tcpPL.SendTo(outD, sizeof(outD), addr);
  // получаем ответ
  repeat
    dataMod.tcpPL.ReceiveFrom(inH, sizeof(inH), addr, len);
    // получаем данные
    dataMod.tcpPL.ReceiveFrom(inD, sizeOf(inD), addr, len);
    // печатаем все о присланном ответе
    mm.Lines.Add('Prefix: ' + inH.Prefix[0] + inH.Prefix[1] + inH.Prefix[2]);
    mm.Lines.Add('Count: ' + IntToStr(inH.Count));
    mm.Lines.Add('MType: ' + IntToStr(inH.MType));
    mm.Lines.Add('DType: ' + IntToStr(inH.DType));
    mm.Lines.Add('ID: ' + IntToStr(inH.ID));
    mm.Lines.Add('Index1: ' + IntToStr(inH.Index1));
    mm.Lines.Add('Index2: ' + IntToStr(inH.Index2));
    mm.Lines.Add('Length: ' + IntToStr(inH.Length));
    mm.Lines.Add('');
    mm.Lines.Add('Data: ' + IntToStr(inD));
    inc(globalCount);
    if (inH.MType < $80) or (inH.MType > $85) then break;
  until inH.MType = $82;
  // разъединяемся
  dataMod.tcpPL.Disconnect;
end;

procedure TfmArielMain.btAcquireCounterClick(Sender: TObject);
var
  inH, outH: TPLMessageHeader;
  inD, outD: integer;
  addr: TSockAddr;
  len: integer;
  dtype, mtype: byte;
  id, ix1, ix2, lenD, i: word;
  dataBlocks: array [0..16] of integer;
begin
  seriesMaxValue := 300;
  dataBlocks[0] := $0000;
  for i  := 1 to 16 do
    dataBlocks[i]:= $0100 + i - 1;
  dataMod.bShow := false;
  Series2.Clear;
  Series1.Clear;
  ma.Lines.Clear;
  mLogAq.Lines.Clear;
  // соединяемся
  dataMod.tcpPL_Aqc.Connect;
  // отправляем запросы
  // выключаем триггер
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$00]);
  // устанвливаем блок данных
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT16, $1200, 0, 0, dataBlocks);
  // устанавливаем маску и адрес триггера
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1202, 0, 0, [$0000]);
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1204, 0, 0, [$0000, $ffff]);
  // включаем триггер
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$03]);
  // начинаем слушать приходящие данные
  readFinished := false;
  while not readFinished do
  begin
    Application.ProcessMessages;
    readDeviceDataThread(dataMod.tcpPL_Aqc);
  end;
  //self.readDeviceData(dataMod.tcpPL_Aqc);
  //self.readDeviceData(dataMod.tcpPL_Aqc);
  dataMod.bShow := true;
  // разъединяемся
  dataMod.tcpPL_Aqc.Disconnect;
end;

procedure TfmArielMain.btAquireClick(Sender: TObject);
var
  inH, outH: TPLMessageHeader;
  inD, outD: integer;
  addr: TSockAddr;
  len: integer;
  dtype, mtype: byte;
  id, ix1, ix2, lenD, i: word;
  dataBlocks: array [0..16] of integer;
begin
  seriesMaxValue := 3000;
  dataBlocks[0] := $0000;
  for i  := 1 to 16 do
    dataBlocks[i]:= $0100 + i - 1;
  dataMod.bShow := false;
  Series2.Clear;
  Series1.Clear;
  ma.Lines.Clear;
  mLogAq.Lines.Clear;
  // соединяемся
  dataMod.tcpPL_Aqc.Connect;
  // отправляем запросы
  // выключаем триггер
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$00]);
  // устанвливаем блок данных
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT16, $1200, 0, 0, dataBlocks);
  // устанавливаем децимацию
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1203, 0, 0, [400]);
  // устанавливаем предпочитаемый размер данных
  //sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1211, 0, 0, [10000]);
  // включаем триггер
  sendSettingsData(dataMod.tcpPL_Aqc, MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$01]);
  // начинаем слушать приходящие данные
  readFinished := false;
  while not readFinished do
  begin
    Application.ProcessMessages;
    readDeviceDataThread(dataMod.tcpPL_Aqc);
  end;
  dataMod.bShow := true;
  // разъединяемся
  dataMod.tcpPL_Aqc.Disconnect;
end;

procedure TfmArielMain.btEndReadClick(Sender: TObject);
begin
  readFinished := true;
end;
{$ENDREGION}

end.
