unit main2;

interface

uses PLThreadProcSettings, PLThread, PLData, PLThreadProcData,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, TeeProcs, Chart, ExtCtrls;

const
  maxPointsTMP = 3500;

type
  TCXComponents = record
    re: integer;
    im: integer;
    am: double;
    ph: double;
  end;

  TProbeLine = array [0..15] of TCXComponents;

  TfmMain2 = class(TForm)
    mm: TMemo;
    bt3: TButton;
    Button2: TButton;
    Button3: TButton;
    pnlCharts: TPanel;
    Chart2: TChart;
    Series3: TFastLineSeries;
    Chart1: TChart;
    Series2: TFastLineSeries;
    Series1: TFastLineSeries;
    bt2: TButton;
    Button1: TButton;
    pnlGraphs: TPanel;
    pnlTop: TPanel;
    cbxChannel: TComboBox;
    cbxPart: TComboBox;
    Label1: TLabel;
    pnlControl: TPanel;
    Label2: TLabel;
    pnl: TPaintBox;
    tm: TTimer;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure bt2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bt3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure pnlChartsResize(Sender: TObject);
    procedure pnlGraphsResize(Sender: TObject);
    procedure cbxChannelClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure pnlPaint(Sender: TObject);
    procedure tmTimer(Sender: TObject);
  private
    { Private declarations }
    FSeriesMaxValue: Integer;
    FChannel: integer;
    FPart: integer;
    FNumPoints: integer;
    signals: array [0..maxPointsTMP] of TProbeLine;
    procedure setSeriesMaxValue(value: integer);
    procedure setChannel(value: integer);
    procedure setPart(value: integer);
    procedure setNumPoints(value: integer);
  public
    { Public declarations }
    plSet: TPLThreadProcessorSettings;
    plData: TPLThreadProcessorData;
    procedure plOnTcpMessage(msgType: TTCPMessageType; msgText: AnsiString);
    procedure plDeviceResponse(header: TPLMessageHeader; var data: array of integer);
    procedure plDeviceData(header: TPLMessageHeader; data: array of TPLStructDataAcquisition);
    property seriesMaxValue: integer read FSeriesMaxValue write SetSeriesMaxValue;
    property channel: integer read FChannel write SetChannel;
    property part: integer read FPart write SetPart;
    property numPoints: integer read FNumPoints write setNumPoints;
    procedure drawMap(iCur, jCur: integer);
  end;

var
  fmMain2: TfmMain2;

implementation

{$R *.dfm}

uses main, color_data;

procedure TfmMain2.drawMap(iCur, jCur: integer);
var
  h, w: integer;
  minV, rangeV: double;
  x1, x2, y1, y2: integer;
  cl: tColor;
begin
  case part of
    0, 1: begin minV := -32000; rangeV := 64000; end;
    2: begin minV := 0; rangeV := 16000; end;
    3: begin minV := -180; rangeV := 360; end;
  end;
  h := pnl.Height;
  w := pnl.Width;
  // вырисовываем на канве что получилось
  with pnl.Canvas do
  begin
    // считаем координаты
    x1 := Round((iCur + 0) * (w / seriesMaxValue));
    x2 := Round((iCur + 1) * (w / seriesMaxValue));
    y1 := Round((jCur + 0) * (h / 16));
    y2 := Round((jCur + 1) * (h / 16));
    // задаем цвета
    case part of
      0: cl := RBColor((signals[iCur][jCur].re - minV) / rangeV);
      1: cl := RBColor((signals[iCur][jCur].im - minV) / rangeV);
      2: cl := RBColor((signals[iCur][jCur].am - minV) / rangeV);
      3: cl := RBColor((signals[iCur][jCur].ph - minV) / rangeV);
    end;
    // рисуем
    pen.Color := cl;
    brush.Color := cl;
    Rectangle(x1, y1, x2, y2);
  end;
end;

procedure TfmMain2.setSeriesMaxValue(value: integer);
begin
  FSeriesMaxValue := value;
  Chart1.BottomAxis.Maximum := value;
end;

procedure TfmMain2.tmTimer(Sender: TObject);
begin
  tm.Enabled := false;
  InvalidateRect(Handle, nil, false);
end;

procedure TfmMain2.setChannel(value: integer);
begin
  FChannel := value;
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  numPoints := 0;
end;

procedure TfmMain2.setPart(value: integer);
begin
  FPart := value;
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  numPoints := 0;
end;

procedure TfmMain2.setNumPoints(value: integer);
begin
  FNumPoints := value;
end;

procedure TfmMain2.plOnTcpMessage(msgType: TTCPMessageType; msgText: AnsiString);
begin
  mm.Lines.Add(msgText);
end;

procedure TfmMain2.pnlChartsResize(Sender: TObject);
begin
  Chart2.Width := pnlCharts.Height;
end;

procedure TfmMain2.pnlGraphsResize(Sender: TObject);
begin
  panel1.Height := pnlGraphs.Height div 2;
end;

procedure TfmMain2.pnlPaint(Sender: TObject);
var
  h, w: integer;
  i, j: integer;
begin
  h := pnl.Height;
  w := pnl.Width;
  // вырисовываем на канве что получилось
  with pnl.Canvas do
  begin
    // заливаем все
    Pen.Color := clBlack;
    Brush.Color := clBlack;
    Rectangle(0, 0, w, h);
    // бежим по данным
    for i := 0 to numPoints - 1 do
    begin
      for j:= 0 to 15 do
      begin
        drawMap(i, j);
      end;
    end;
  end;
end;

procedure TfmMain2.bt2Click(Sender: TObject);
begin
  plSet.pl.sendData(MSG_TYPE_QUERY, DATA_TYPE_NONE, $0801, 0, 0, []);
end;

procedure TfmMain2.plDeviceResponse(header: TPLMessageHeader; var data: array of integer);
var i: integer;
begin
  mm.Lines.Add('data recieved:');
  for I := 0 to high(data) do
    mm.Lines.Add('['+IntToStr(i)+'] - '+IntToStr(data[i]));
end;

procedure TfmMain2.plDeviceData(header: TPLMessageHeader; data: array of TPLStructDataAcquisition);
var
  i: integer;
  numInD: integer;
  iCur, jCur: integer;
begin
  numInD := Length(data);
  for I := 0 to (numInD - 1) do
  begin
    // статус
    if ((data[i].statusDataValid shr 7) = 1)and
        (data[i].statusSlotAddress = 1)and
        (data[i].statusSubChannel = channel) then
    begin
      if Series2.Count > seriesMaxValue then
      begin
        Series2.Clear;
        Series1.Clear;
        Series3.Clear;
        numPoints := 0;
        pnl.Refresh;
      end;
      Series2.Add(data[i].dataX);
      Series1.Add(data[i].dataY);
      Series3.AddXY(data[i].dataX, data[i].dataY);
      numPoints := numPoints + 1;
      signals[numPoints - 1][channel].re := data[i].dataX;
      signals[numPoints - 1][channel].im := data[i].dataY;
      drawMap(numPoints - 1, channel);
      //pnl.Refresh;
    end;
    // заполняем двумерный масив
{    if ((data[i].statusDataValid shr 7) = 1)and
        (data[i].statusSlotAddress = 1) then
    begin
      if jCur = 0 then numPoints := numPoints + 1;
      iCur := numPoints - 1;
      jCur := data[i].statusSubChannel;
      signals[iCur][jCur].re := data[i].dataX;
      signals[iCur][jCur].im := data[i].dataY;
      signals[iCur][jCur].am := 0;//sqrt(sqr(data[i].dataX) + sqr(data[i].dataY));
      signals[iCur][jCur].ph := 0;
      // рисуем
      drawMap(iCur, jCur);
    end;           }
  end;
  //InvalidateRect(Handle, nil, false);
  //tm.Enabled := true;
end;

procedure TfmMain2.bt3Click(Sender: TObject);
var
  i: integer;
  dataBlocks: array [0..16] of integer;
begin
  seriesMaxValue := 3000;
  dataBlocks[0] := $0000;
  for i := 1 to 16 do
    dataBlocks[i]:= $0100 + i - 1;
  Series2.Clear;
  Series1.Clear;
  Series3.Clear;
  // отправляем запросы
  // выключаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$00]);
  // устанвливаем блок данных
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT16, $1200, 0, 0, dataBlocks);
  // устанавливаем децимацию
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1203, 0, 0, [10]);
  // включаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$01]);
end;

procedure TfmMain2.Button1Click(Sender: TObject);
begin
  plSet.Finish;
  plData.Finish;
end;

procedure TfmMain2.Button2Click(Sender: TObject);
var
  i: integer;
  dataBlocks: array [0..16] of integer;
begin
  seriesMaxValue := 300;
  dataBlocks[0] := $0000;
  for i := 1 to 16 do
    dataBlocks[i]:= $0100 + i - 1;
  Series2.Clear;
  Series1.Clear;
  Series3.Clear;
  // отправляем запросы
  // выключаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$00]);
  // устанвливаем блок данных
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT16, $1200, 0, 0, dataBlocks);
  // устанавливаем маску и адрес триггера
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1202, 0, 0, [$0000]);
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1204, 0, 0, [$0000, $ffff]);
  // включаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$03]);
end;

procedure TfmMain2.Button3Click(Sender: TObject);
begin
  // выключаем триггер
  plData.pl.sendData(MSG_TYPE_DATASET, DATA_TYPE_INT32, $1201, 0, 0, [$00]);
end;

procedure TfmMain2.cbxChannelClick(Sender: TObject);
begin
  channel := cbxChannel.ItemIndex;
end;

procedure TfmMain2.FormCreate(Sender: TObject);
begin
  WindowState := wsMaximized;
  mm.Lines.Clear;
  channel := 0;
  part := 0;
  numPoints := 0;
  ///
  plSet := TPLThreadProcessorSettings.Create('10.8.2.218');
  plSet.pl.OnTCPMessage := plOnTcpMessage;
  plSet.pl.OnDeviceResponse := plDeviceResponse;
  plSet.Start;
  ///
  plData := TPLThreadProcessorData.Create('10.8.2.218');
  plData.pl.OnTCPMessage := plOnTcpMessage;
  plData.pl.OnDeviceResponse := plDeviceResponse;
  plData.pl.OnDeviceData := plDeviceData;
  plData.Start;
end;

procedure TfmMain2.FormPaint(Sender: TObject);
begin
  pnl.Refresh;
end;

end.
