unit mainTester;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons;

type
  TfmLibTester = class(TForm)
    btStart: TButton;
    mm: TMemo;
    ch: TChart;
    seriesRe: TLineSeries;
    seriesIm: TLineSeries;
    btHeader: TcxButton;
    procedure btStartClick(Sender: TObject);
    procedure btHeaderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLine(pName: string; resCode: integer; isState:boolean=false);
    procedure AddLineVar(vName: string; vValue: string);
    function BooleanToStr(b: Boolean):string;
  end;

var
  fmLibTester: TfmLibTester;

implementation

uses test_libData, HeaderExchanger;

{$R *.dfm}

function TfmLibTester.BooleanToStr(b: Boolean):string;
begin
  if b then
    Result := 'true'
  else
    Result := 'false';
end;

procedure TfmLibTester.AddLine(pName: string; resCode: integer; isState:boolean=false);
var
  sCode: string;
begin
  if isState then
  begin
    case resCode of
      AR_STATE_NotInited: sCode := 'AR_STATE_NotInited';
      AR_STATE_Connected: sCode := 'AR_STATE_Connected';
      AR_STATE_Disconnected: sCode := 'AR_STATE_Disconnected';
      AR_STATE_DataAquire: sCode := 'AR_STATE_DataAquire';
    else
      sCode := 'Undefined';
    end;
  end
  else
  begin
    case resCode of
      AR_OK: sCode := 'AR_OK';
      AR_SettingsNotLoaded: sCode := 'AR_SettingsNotLoaded';
      AR_ConnectionError: sCode := 'AR_ConnectionError';
      AR_WRONG_CHANNEL: sCode := 'AR_WRONG_CHANNEL';
      AR_WRONG_DATA_BUFFER: sCode := 'AR_WRONG_DATA_BUFFER';
      AR_NotSuppportedOperation: sCode := 'AR_NotSuppportedOperation';
    else
      sCode := 'Undefined';
    end;
  end;
  mm.Lines.Add(pName + ': ' + sCode + ' (' + IntToStr(resCode) + ')');
end;

procedure TfmLibTester.AddLineVar(vName: string; vValue: string);
begin
  mm.Lines.Add(vName + ' = ' + vValue);
end;

procedure TfmLibTester.btHeaderClick(Sender: TObject);
begin
  fmHeaderExchanger := TfmHeaderExchanger.Create(Application);
  fmHeaderExchanger.ShowModal;
  fmHeaderExchanger.Free;
end;

procedure TfmLibTester.btStartClick(Sender: TObject);
type
  TDataArray = array [0..0] of TComplex;
  PDataArray = ^TDataArray;
  TDefectArray = array [0..0] of TDefect;
  PDefectArray = ^TDefectArray;
  TCalibArray = array [0..0] of TCalibDefect;
  PCalibArray = ^TCalibArray;
var
  ires, i: integer;
  iscon: boolean;
  ps: TPipeSettings;
  ci: TChannelInfo;
  cnt: integer;
  data, dataProc: PDataArray;
  iStart, iFinish: integer;
  RootDir: string;
  SetFName: string;
  cls: integer;
  defs: PDefectArray;
  cDefs: PCalibArray;
  nCalibDefs: integer;
  bCorrect: boolean;
begin
  btStart.Enabled := false;
  // проверка соединения в начале
  ires := ar_DeviceCheckConnection(iscon);
  AddLine('ar_DeviceCheckConnection', ires);
  AddLineVar('isConnected', BooleanToStr(iscon));

  // загрузка параметров
  RootDir := ExtractFilePath(Application.ExeName);
  SetFName := RootDir + 'ariel-config.ini';
  ires := ar_LoadSettings(PChar(SetFName));
  AddLine('ar_LoadSettings', ires);
  // соединение и проверка
  ires := ar_DeviceConnect();
  AddLine('ar_DeviceConnect', ires);
  //ires := AR_ConnectionError;
  repeat
    ires := ar_DeviceCheckConnection(iscon);
    AddLine('ar_DeviceCheckConnection', ires);
    AddLineVar('isConnected', BooleanToStr(iscon));
    Sleep(1000);
  until (ires = AR_OK)and(iscon);
  // проверка параметров
  ires := ar_PresetDevice();
  AddLine('ar_PresetDevice', ires);
  ps.zoneStart := 30;
  ps.zoneFinish := 30;
  ps.pipeLength := 1000;
  ires := ar_PresetPipe(ps);
  AddLine('ar_PresetPipe', ires);
  // проверяем параметры каналов
  ires := ar_GetDataChannelParams(0, ci);
  AddLine('ar_GetDataChannelParams', ires);
  mm.Lines.Add('ChannelInfo.frequency = ' + IntToStr(ci.frequency));
  mm.Lines.Add('ChannelInfo.drive = ' + IntToStr(ci.drive));
  mm.Lines.Add('ChannelInfo.amplification = ' + IntToStr(ci.amplification));
  mm.Lines.Add('ChannelInfo.filterType = ' + IntToStr(ci.filterType));
  mm.Lines.Add('ChannelInfo.hiPass = ' + IntToStr(ci.hiPass));
  mm.Lines.Add('ChannelInfo.lowPass = ' + IntToStr(ci.lowPass));
  mm.Lines.Add('ChannelInfo.bAbs = ' + IntToStr(Ord(ci.bAbs)));
  mm.Lines.Add('ChannelInfo.isActive = ' + IntToStr(Ord(ci.isActive)));
  // задаем параметры каналов
  ci.frequency := 70000;
  ires := ar_SetDataChannelParams(0, ci);
  AddLine('ar_SetDataChannelParams', ires);
  // запускаем сбор
  ires := ar_StartAquireData();
  AddLine('ar_StartAquireData', ires);
  sleep(15000);
  // останавливаем сбор
  ires := ar_StopAquireData();
  AddLine('ar_StopAquireData', ires);
  // смотрим на количество данных
  ires := ar_GetDataCount(cnt);
  AddLine('ar_GetDataCount', ires);
  AddLineVar('Data.Count', IntToStr(cnt));
  // получаем сырые данные
  GetMem(data, sizeof(TComplex) * cnt);
  ires := ar_GetAquiredData(0, data);
  AddLine('ar_GetAquiredData', ires);
  seriesRe.Clear;
  seriesIm.Clear;
  {$R-}
  for i := 0 to cnt - 1 do
  begin
    seriesRe.AddXY(i, data^[i].re);
    seriesIm.AddXY(i, data^[i].im);
  end;
  {$R+}
  FreeMem(data,  sizeof(TComplex) * cnt);
  // смотрим обработанные данные
  GetMem(dataProc, sizeof(TComplex) * cnt);
  ires := ar_GetProcessedData(0, iStart, iFinish, dataProc);
  AddLine('ar_GetProcessedData', ires);
  AddLineVar('iStart', IntToStr(iStart));
  AddLineVar('iFinish', IntToStr(iFinish));
  {$R-}
  for i := 0 to cnt - 1 do
  begin
    seriesRe.AddXY(i + cnt, dataProc^[i].re);
    seriesIm.AddXY(i + cnt, dataProc^[i].im);
  end;
  {$R+}
  FreeMem(dataProc,  sizeof(TComplex) * cnt);
  // смотрим результат обработки
  ires := ar_GetProcessingResult(cls);
  AddLine('ar_GetProcessingResult', ires);
  AddLineVar('ResultClass', IntToStr(cls));
  ires := ar_GetIndicationsCount(cnt);
  AddLine('ar_GetIndicationsCount', ires);
  AddLineVar('IndicationsCount', IntToStr(cnt));
  if cnt > 0 then
  begin
    GetMem(defs, cnt * sizeof(TDefect));
    ires := ar_GetIndicationsList(defs);
    AddLine('ar_GetIndicationsList', ires);
    {$R-}
    AddLineVar('Defect[0].pos1', IntToStr(defs^[0].pos1));
    AddLineVar('Defect[0].pos2', IntToStr(defs^[0].pos2));
    AddLineVar('Defect[0].center', FloatToStrF(defs^[0].center, ffFixed, 4, 2));
    AddLineVar('Defect[0].volume', FloatToStrF(defs^[0].volume, ffFixed, 4, 2));
    AddLineVar('Defect[0].quality', IntToStr(defs^[0].quality));
    AddLineVar('Defect[0].channel', IntToStr(defs^[0].channel));
    AddLineVar('Defect[0].orientation', IntToStr(defs^[0].orientation));
    AddLineVar('Defect[0].probe1', IntToStr(defs^[0].probe1));
    AddLineVar('Defect[0].probe2', IntToStr(defs^[0].probe2));
    AddLineVar('Defect[0].defectType', IntToStr(defs^[0].defectType));
    {$R+}
    FreeMem(defs, cnt * sizeof(TDefect));
  end;
  // проверка калибровки
  // подготовка калибровочной кривой
  nCalibDefs := 4;
  GetMem(cDefs, nCalibDefs * sizeof(TCalibDefect));
  GetMem(defs, nCalibDefs * sizeof(TDefect));
  {$R-}
  ///
  i := 0;
  cDefs^[i].volume := 2.0;
  cDefs^[i].dist := 100;
  cDefs^[i].isExt := true;
  cDefs^[i].isAxial := true;
  cDefs^[i].isWaste := false;
  ///
  i := 1;
  cDefs^[i].volume := 5.0;
  cDefs^[i].dist := 200;
  cDefs^[i].isExt := true;
  cDefs^[i].isAxial := true;
  cDefs^[i].isWaste := true;
  ///
  i := 2;
  cDefs^[i].volume := 2.0;
  cDefs^[i].dist := 300;
  cDefs^[i].isExt := false;
  cDefs^[i].isAxial := true;
  cDefs^[i].isWaste := false;
  ///
  i := 3;
  cDefs^[i].volume := 5.0;
  cDefs^[i].dist := 400;
  cDefs^[i].isExt := false;
  cDefs^[i].isAxial := true;
  cDefs^[i].isWaste := true;
  {$R+}
  // запуск калибровки
  ires := ar_StartCalibration();
  AddLine('ar_StartCalibration', ires);
  ires := ar_Calibrate(cDefs, nCalibDefs, 0, 10, 2, 4);
  AddLine('ar_Calibrate', ires);
  // проверка
  ires := ar_CheckCalibration(cDefs, nCalibDefs, 10, bCorrect);
  AddLine('ar_CheckCalibration', ires);
  AddLineVar('isCorrect', BooleanToStr(bCorrect));
  // поверка
  ires := ar_TestDeviceCalibration(cDefs, nCalibDefs, 10, defs);
  AddLine('ar_TestDeviceCalibration', ires);
  {$R-}
  for i := 0 to nCalibDefs - 1 do
  begin
    mm.Lines.Add('---');
    AddLineVar('Defect['+IntToStr(i)+'].pos1', IntToStr(defs^[i].pos1));
    AddLineVar('Defect['+IntToStr(i)+'].pos2', IntToStr(defs^[i].pos2));
    AddLineVar('Defect['+IntToStr(i)+'].center', FloatToStrF(defs^[i].center, ffFixed, 4, 2));
    AddLineVar('Defect['+IntToStr(i)+'].volume', FloatToStrF(defs^[i].volume, ffFixed, 4, 2));
    AddLineVar('Defect['+IntToStr(i)+'].quality', IntToStr(defs^[i].quality));
    AddLineVar('Defect['+IntToStr(i)+'].channel', IntToStr(defs^[i].channel));
    AddLineVar('Defect['+IntToStr(i)+'].orientation', IntToStr(defs^[i].orientation));
    AddLineVar('Defect['+IntToStr(i)+'].probe1', IntToStr(defs^[i].probe1));
    AddLineVar('Defect['+IntToStr(i)+'].probe2', IntToStr(defs^[i].probe2));
    AddLineVar('Defect['+IntToStr(i)+'].defectType', IntToStr(defs^[i].defectType));
  end;
  {$R+}
  // чистим память калибровки
  FreeMem(defs, nCalibDefs * sizeof(TDefect));
  FreeMem(cDefs, nCalibDefs * sizeof(TCalibDefect));
  // отсоединение и очистка памяти
  ires := ar_DeviceDisconnect();
  AddLine('ar_DeviceDisconnect', ires);
  //ires := AR_ConnectionError;
  repeat
    ires := ar_DeviceCheckConnection(iscon);
    AddLine('ar_DeviceCheckConnection', ires);
    AddLineVar('isConnected', BooleanToStr(iscon));
    Sleep(1000);
  until (ires = AR_OK)and(not iscon);
  ires := ar_Free();
  AddLine('ar_Free', ires);
end;

end.
