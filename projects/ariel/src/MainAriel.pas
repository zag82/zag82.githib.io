unit MainAriel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsdxStatusBarPainter, dxStatusBar, dxBar,
  cxClasses, dxSkinscxPCPainter, cxPC, PlatformDefaultStyleActnCtrls, ActnList,
  ActnMan, ImgList, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, TeEngine,
  ExtCtrls, TeeProcs, Chart, cxGroupBox, Series, dxmdaset, Menus, StdCtrls,
  cxButtons, cxTextEdit, cxMaskEdit, cxSpinEdit, cxSpinButton,
  cxDBLookupComboBox, SignalData, cxLabel, cxDropDownEdit, movements,
  cxColorComboBox, dxBarExtItems, glGraphHuge, Generics.Collections,
  ReportBuilder, cxNavigator;

type
  TfmMainAriel = class(TForm)
    bmMenu: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    stBar: TdxStatusBar;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarSubItem4: TdxBarSubItem;
    imgs: TcxImageList;
    dxBarSubItem6: TdxBarSubItem;
    acts: TActionList;
    dxBarButton4: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton10: TdxBarButton;
    actOpen: TAction;
    actExit: TAction;
    actAbout: TAction;
    pnlControl: TPanel;
    pnlOneCh: TPanel;
    pnlOneFull: TPanel;
    pnlOneGraph: TPanel;
    pnlOneReIm: TPanel;
    chOneFullIm: TChart;
    chOneFullRe: TChart;
    chOneGod: TChart;
    chOneIm: TChart;
    chOneRe: TChart;
    mdFilterType: TdxMemData;
    mdFilterTypeID: TIntegerField;
    mdFilterTypeNAME: TStringField;
    dsFilterType: TDataSource;
    oDlg: TOpenDialog;
    seriesOneGod: TFastLineSeries;
    seriesOneRe: TFastLineSeries;
    seriesOneIm: TFastLineSeries;
    seriesOneFullRe: TFastLineSeries;
    seriesOneFullIm: TFastLineSeries;
    bmMenuBar2: TdxBar;
    dxBarDockControl1: TdxBarDockControl;
    lvParams: TcxGridLevel;
    grParams: TcxGrid;
    seriesOnePointsRe: TPointSeries;
    tvParams: TcxGridTableView;
    tvParamsColumn1: TcxGridColumn;
    tvParamsColumn2: TcxGridColumn;
    tvParamsColumn3: TcxGridColumn;
    tvParamsColumn4: TcxGridColumn;
    tvParamsColumn5: TcxGridColumn;
    tvParamsColumn6: TcxGridColumn;
    actAmplificationUp: TAction;
    actAmplificationDown: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton5: TdxBarButton;
    seriesOnePointsIm: TPointSeries;
    seriesOnePointsGod: TPointSeries;
    actNextFile: TAction;
    actPrevFile: TAction;
    tvDefects: TcxGridDBTableView;
    lvDefects: TcxGridLevel;
    grDefects: TcxGrid;
    actProcessed: TAction;
    btProcessed: TdxBarButton;
    actSaveText: TAction;
    sDlg: TSaveDialog;
    btSaveText: TdxBarButton;
    mdDefects: TdxMemData;
    mdDefectsID: TIntegerField;
    mdDefectsPOSITION: TIntegerField;
    mdDefectsVolume: TStringField;
    mdDefectsANGLE: TIntegerField;
    mdDefectsQUALITY: TIntegerField;
    dsDefects: TDataSource;
    mdDefectsCOLOR: TIntegerField;
    tvDefectsPOSITION: TcxGridDBColumn;
    tvDefectsVolume: TcxGridDBColumn;
    tvDefectsANGLE: TcxGridDBColumn;
    tvDefectsQUALITY: TcxGridDBColumn;
    tvDefectsCOLOR: TcxGridDBColumn;
    dxBarButton8: TdxBarButton;
    mdDefectsCMNT: TStringField;
    tvDefectsCMNT: TcxGridDBColumn;
    btCalib: TdxBarButton;
    btCheck: TdxBarButton;
    btViewParams: TdxBarButton;
    actViewSettings: TAction;
    btCalibStart: TdxBarButton;
    btCalibTestDevice: TdxBarButton;
    lbAmp: TdxBarStatic;
    cbView: TdxBarCombo;
    cbChannel: TdxBarCombo;
    cbType: TdxBarCombo;
    btPrev: TdxBarButton;
    btNext: TdxBarButton;
    lbFilePos: TdxBarStatic;
    tm: TTimer;
    actSaveParams: TAction;
    actCalibStart: TAction;
    actCalib: TAction;
    actCalibCheck: TAction;
    actTestDevice: TAction;
    actView: TAction;
    actType: TAction;
    actChannel: TAction;
    pnlGraphData: TPanel;
    mdDefectsDTYPE: TStringField;
    tvDefectsDTYPE: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    actReport: TAction;
    actProcCalibration: TAction;
    actProcProduction: TAction;
    dxBarButton3: TdxBarButton;
    dxBarButton7: TdxBarButton;
    tmLic: TTimer;
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnlOneChResize(Sender: TObject);
    procedure pnlOneFullResize(Sender: TObject);
    procedure pnlOneGraphResize(Sender: TObject);
    procedure pnlOneReImResize(Sender: TObject);
    procedure chOneReBeforeDrawAxes(Sender: TObject);
    procedure chOneFullReBeforeDrawAxes(Sender: TObject);
    procedure chOneReMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chOneReMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chOneReMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chOneFullReMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chOneFullReMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chOneFullReMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure actAmplificationUpExecute(Sender: TObject);
    procedure actAmplificationDownExecute(Sender: TObject);
    procedure tvParamsCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actProcessedExecute(Sender: TObject);
    procedure actSaveTextExecute(Sender: TObject);
    procedure mdDefectsAfterScroll(DataSet: TDataSet);
    procedure tvDefectsCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure actViewSettingsExecute(Sender: TObject);
    procedure projectOpenedUpdate(Sender: TObject);
    procedure projectNotWorkUpdate(Sender: TObject);
    procedure actSaveParamsExecute(Sender: TObject);
    procedure actCalibStartExecute(Sender: TObject);
    procedure actCalibExecute(Sender: TObject);
    procedure actCalibCheckExecute(Sender: TObject);
    procedure actTestDeviceExecute(Sender: TObject);
    procedure tmTimer(Sender: TObject);
    procedure actPrevFileExecute(Sender: TObject);
    procedure actNextFileExecute(Sender: TObject);
    procedure actProcCalibrationExecute(Sender: TObject);
    procedure actProcProductionExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure tmLicTimer(Sender: TObject);
  private
    { Private declarations }
    FProcType: TProcType;
    FIniSettings: TIniSettings;
    FDataFileName: AnsiString;
    procedure prepareGraphs(p1, p2: integer);
    procedure loadIniSettings(fName: string);
    procedure postOpenAction(fName: string; pType: TProcType);
  public
    { Public declarations }
    bRaw: boolean;
    iAmpl: integer;
    iCurrentChannel: integer;
    mv: TMovement;
    signalAnalyse: TSignalData;
    bProjectOpened: boolean;
    grData: TglGraphMulti;
    procedure drawGodographData();
    procedure UpdatePartGraphs();
    procedure AmplificationChange();
    procedure channelsChange(iCh:integer);
    function getFilesInFolder(fName: AnsiString): TList<AnsiString>;
    function getFileCurrentPosition(list: TList<AnsiString>; fName: AnsiString): integer;
  end;

var
  fmMainAriel: TfmMainAriel;

implementation

uses about, vector_priznak, Math, Complx, Clipbrd, DeviceSettings,
  CalibTestDevice, IniFiles, licGrd;

{$R *.dfm}

{$REGION 'Работа с файлами'}
function TfmMainAriel.getFilesInFolder(fName: AnsiString): TList<AnsiString>;
var
  sExt: AnsiString;
  sPath: AnsiString;
  sr: TSearchRec;
  fList: TList<AnsiString>;
begin
  fList := TList<AnsiString>.Create();
  sPath := ExtractFilePath(fName);
  sExt := ExtractFileExt(fName);
  if FindFirst(sPath + '*' + sExt, faAnyFile, sr) = 0 then
  begin
    repeat
      fList.Add(sPath + sr.Name);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  fList.Sort;
  Result := fList;
end;

function TfmMainAriel.getFileCurrentPosition(list: TList<AnsiString>; fName: AnsiString): integer;
var
  sName:string;
  i:integer;
begin
  Result := -1;
  for i := 0 to list.Count - 1 do
    if AnsiUpperCase(list[i]) = AnsiUpperCase(fName) then
    begin
      Result := i;
      break;
    end;
end;

procedure TfmMainAriel.loadIniSettings(fName: string);
var
  f: TIniFile;
  i: integer;
begin
  // заполняем из файла структуру FIniSettings
  f := TIniFile.Create(fName);
  // параметры обработки
  FIniSettings.bShowGood := f.ReadBool('common', 'showGoodDefects', false);
  FIniSettings.threshNotDefect := f.ReadFloat('common', 'ndThresh', 0.5);
  FIniSettings.bUseAmlitudeInsteadOfVolume := f.ReadBool('common', 'bamp', false);
  FIniSettings.recontrolRange := f.ReadFloat('common', 'RecontrolRange', 0.5);
  // общие параметры
  FIniSettings.nDefs := f.ReadInteger('calib', 'nDefs', 0);
  FIniSettings.iDefect := f.ReadInteger('calib', 'iDefect', 0);
  FIniSettings.frameWidth := f.ReadFloat('calib', 'frameWidth', 10);
  FIniSettings.calibValue := f.ReadFloat('calib', 'calibValue', 10);
  FIniSettings.calibThreshold := f.ReadFloat('calib', 'calibThreshold', 5);
  // дефекты калибровочной
  SetLength(FIniSettings.defs, FIniSettings.nDefs);
  for i := 0 to FIniSettings.nDefs - 1 do
  begin
    FIniSettings.defs[i].volume := f.ReadFloat('defect'+IntToStr(i), 'volume', 1.0);
    FIniSettings.defs[i].dist := f.ReadFloat('defect'+IntToStr(i), 'dist', 10.0);
    FIniSettings.defs[i].isExt := f.ReadBool('defect'+IntToStr(i), 'isExt', true);
    FIniSettings.defs[i].isAxial := f.ReadBool('defect'+IntToStr(i), 'isAxial', true);
    FIniSettings.defs[i].isWaste := f.ReadBool('defect'+IntToStr(i), 'isWaste', false);
  end;
  // параметры трубки
  FIniSettings.ps.zoneStart :=  f.ReadFloat('pipeParams', 'zoneStart', 0.0);
  FIniSettings.ps.zoneFinish :=  f.ReadFloat('pipeParams', 'zoneFinish', 0.0);
  FIniSettings.ps.pipeLength :=  f.ReadFloat('pipeParams', 'pipeLength', 100.0);
  // параметры калибровочной трубки
  FIniSettings.psCalib.zoneStart :=  f.ReadFloat('calibPipeParams', 'zoneStart', 0.0);
  FIniSettings.psCalib.zoneFinish :=  f.ReadFloat('calibPipeParams', 'zoneFinish', 0.0);
  FIniSettings.psCalib.pipeLength :=  f.ReadFloat('calibPipeParams', 'pipeLength', 100.0);
  // очистка памяти
  f.Free;
end;

procedure TfmMainAriel.FormCreate(Sender: TObject);
begin
  bProjectOpened := false;
  DecimalSeparator := '.';
  grData := TglGraphMulti.Create(pnlGraphData);
  grData.InitData;
  // параметры работы с сигналами
  bRaw := true;
  iAmpl := 0;
  AmplificationChange();
  iCurrentChannel := 0;
  // состояние окна
  actAmplificationUp.ShortCut := ShortCut(VK_UP, [ssCtrl]);
  actAmplificationDown.ShortCut := ShortCut(VK_DOWN, [ssCtrl]);
  actPrevFile.ShortCut := ShortCut(VK_LEFT, [ssCtrl]);
  actNextFile.ShortCut := ShortCut(VK_RIGHT, [ssCtrl]);
  WindowState := wsMaximized;
  // загрузка параметров из файла
  FProcType := ptProduction;
  loadIniSettings(ExtractFilePath(Application.ExeName) + 'ariel.ini');
  // создание структур для хранения и отображения
  signalAnalyse := TSignalData.Create();
  signalAnalyse.setAddParams(FIniSettings.bUseAmlitudeInsteadOfVolume, FIniSettings.threshNotDefect, FIniSettings.recontrolRange);
  mv := TMovement.Create();
  mv.InitData(0, 100);
end;

procedure TfmMainAriel.FormDestroy(Sender: TObject);
begin
  mdFilterType.Close;
  signalAnalyse.FreeData;
  signalAnalyse.Free;
  mv.Free;
  grData.FreeData;
  grData.Free;
end;

procedure TfmMainAriel.FormPaint(Sender: TObject);
begin
  grData.PaintData();
  ///
  chOneIm.Refresh;
  chOneRe.Refresh;
  chOneFullRe.Repaint();
  chOneFullIm.Repaint();
  if mv.isNewPositions(mv.gPos1, mv.gPos2) then
  begin
    drawGodographData();
    stBar.Panels[1].Text := IntToStr(mv.gPos2 - mv.gPos1);
    stBar.Panels[2].Text := IntToStr((mv.gPos2 + mv.gPos1)div 2);
    if signalAnalyse.ProcessingParams.step > 0 then
    begin
      stBar.Panels[1].Text := stBar.Panels[1].Text + ' (' + IntToStr(Round((mv.gPos2 - mv.gPos1) * signalAnalyse.ProcessingParams.step)) + ' мм)';
      stBar.Panels[2].Text := stBar.Panels[2].Text + ' (' + IntToStr(Round(((mv.gPos2 + mv.gPos1) * 0.5 - signalAnalyse.ProcessingParams.raw_p1) * signalAnalyse.ProcessingParams.step)) + ' мм)';
    end;
  end;
  chOneGod.Refresh;
end;

procedure TfmMainAriel.actAboutExecute(Sender: TObject);
begin
  fmAbout := TfmAbout.Create(Application);
  fmAbout.ShowModal;
  fmAbout.Free;
end;

procedure TfmMainAriel.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMainAriel.projectNotWorkUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := bProjectOpened;
end;

procedure TfmMainAriel.projectOpenedUpdate(Sender: TObject);
begin
  (sender as TAction).Enabled := bProjectOpened;
end;

procedure TfmMainAriel.postOpenAction(fName: string; pType: TProcType);
var
  i: integer;
  fNameProc: string;
  pSettings: TPipeSettings;
begin
  // выбираем параметры обработки
  if pType = ptProduction then
    pSettings := FIniSettings.ps
  else
    pSettings := FIniSettings.psCalib;
  // загружаем занные из файла
  if signalAnalyse.LoadData(fName) then
  begin
    if signalAnalyse.Count > 0 then
    begin
      bProjectOpened := true;
      fNameProc := ChangeFileExt(fName, '.apr');
      if FileExists(fNameProc) then
        signalAnalyse.LoadProcessing(fNameProc)
      else
      begin
        signalAnalyse.doPreProcessing(pSettings);
        signalAnalyse.doPostProcessing(FiniSettings.bShowGood);
        // TODO: пока не сохряняем обработку для целей отладки
        //signalAnalyse.SaveProcessing(fNameProc);
      end;
      // подготовка
      if signalAnalyse.ProcessingParams.isProcessed and (not bRaw) then
        prepareGraphs(signalAnalyse.ProcessingParams.position1, signalAnalyse.ProcessingParams.position2)
      else
        prepareGraphs(0, signalAnalyse.Count - 1);
      // переключение канала
      iCurrentChannel := 0;
      channelsChange(iCurrentChannel);
{      tvParams.Controller.GridView.
      tvParams.DataController.BeginFullUpdate;}
//      tvParams.DataController.SelectRows(1, 1);
{      tvParams.DataController.EndFullUpdate;}
//      tvParams.Controller.SelectCells(tvParamsColumn1, tvParamsColumn6, 1, 1);
      Caption := 'Ariel - ' + ExtractFileName(fName);
      // заполняем табличку значениями частот
      tvParams.DataController.BeginFullUpdate;
      for i := 0 to maxChannels - 1 do
      begin
        tvParams.DataController.Values[i, 1] := signalAnalyse.DeviceInfo.channelsInfo[i].frequency;
        tvParams.DataController.Values[i, 4] := Ord(signalAnalyse.DeviceInfo.channelsInfo[i].bAbs);
        tvParams.DataController.Values[i, 5] := Ord(signalAnalyse.DeviceInfo.channelsInfo[i].isActive);
      end;
      tvParams.DataController.EndFullUpdate;
      // заполняем табличку дефектов
      mdDefects.DisableControls;
      mdDefects.Close;
      mdDefects.Open;
      for i := 0 to signalAnalyse.ProcessingDefects.Count - 1 do
      begin
        mdDefects.Append;
        mdDefectsID.Value := i + 1;
        mdDefectsPOSITION.Value := Round((signalAnalyse.ProcessingDefects.Items[i].posx - signalAnalyse.ProcessingParams.raw_p1) * signalAnalyse.ProcessingParams.step);
        mdDefectsQUALITY.Value := Ord(signalAnalyse.ProcessingDefects.Items[i].qualityRes);
        mdDefectsCMNT.Value := ' ' + IntToStr(signalAnalyse.ProcessingDefects.Items[i].probe1 + 1) +
                               ' - ' + IntToStr(signalAnalyse.ProcessingDefects.Items[i].probe2 + 1) +
                               '  (' + IntToStr(signalAnalyse.ProcessingDefects.Items[i].channel + 1) + ')';
        if signalAnalyse.ProcessingDefects.Items[i].qualityRes in [qrBad, qrGood, qrRecontrol] then
        begin
          mdDefectsVolume.Value := FloatToStrF(signalAnalyse.ProcessingDefects.Items[i].volume, ffFixed, 4, 1);
          mdDefectsANGLE.Value := 90 * signalAnalyse.ProcessingDefects.Items[i].nProbesIndication;
        end
        else
        begin
          mdDefectsVolume.Value := '';
          mdDefectsANGLE.AsVariant := Null;
        end;
        mdDefectsDTYPE.Value := DefectTypeStringNames[Ord(signalAnalyse.ProcessingDefects.Items[i].defectType)];
        mdDefectsCOLOR.Value := QualityResultColors[Ord(signalAnalyse.ProcessingDefects.Items[i].qualityRes)];
        mdDefects.Post;
      end;
      mdDefects.First;
      mdDefects.EnableControls;
      // общие данные по обработке
      case signalAnalyse.ProcessingParams.qualityRes of
        qrNone: TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[0].IndicatorType := sitOff;
        qrGood: TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[0].IndicatorType := sitGreen;
        qrRecontrol: TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[0].IndicatorType := sitYellow;
        qrBad: TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[0].IndicatorType := sitRed;
      end;
      if signalAnalyse.Calibrated then
        TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[1].IndicatorType := sitTeal
      else
        TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[1].IndicatorType := sitPurple;
      stBar.Refresh;
    end
    else
      ShowMessage('Файл не содержит данных');
  end
  else
    ShowMessage('Ошибка при чтении файла данных');
end;

procedure TfmMainAriel.actOpenExecute(Sender: TObject);
var
  list: TList<AnsiString>;
  iFilePos: integer;
begin
  // загрузка файла
  if oDlg.Execute then
  begin
    postOpenAction(oDlg.FileName, FProcType);
    FDataFileName := oDlg.FileName;
    list := getFilesInFolder(FDataFileName);
    iFilePos := getFileCurrentPosition(list, FDataFileName);
    if iFilePos >= 0 then
      lbFilePos.Caption := IntToStr(iFilePos + 1) + ' / ' + IntToStr(list.Count)
    else
      lbFilePos.Caption := '0 / 0';
    list.Free;
    tmLic.Enabled := true;
  end;
end;

procedure TfmMainAriel.actSaveTextExecute(Sender: TObject);
var
  f: TextFile;
  i, j: integer;
  cx: TComplex;
begin
  // сохранение в текст только сырых данных
  if sDlg.Execute then
  begin
    AssignFile(f, sDlg.FileName);
    Rewrite(f);
    for i := 0 to signalAnalyse.Count - 1 do
    begin
      for j := 0 to maxChannels - 1 do
      begin
        cx := signalAnalyse.getData(j, i, true);
        write(f, cx.re:15, #09, cx.im:15, #09);
      end;
      writeln(f);
    end;
    CloseFile(f);
  end;
end;

procedure TfmMainAriel.actNextFileExecute(Sender: TObject);
var
  list: TList<AnsiString>;
  iFilePos: integer;
begin
  list := getFilesInFolder(FDataFileName);
  iFilePos := getFileCurrentPosition(list, FDataFileName) + 1;
  if iFilePos < list.Count then
  begin
    FDataFileName := list[iFilePos];
    postOpenAction(FDataFileName, FProcType);
    lbFilePos.Caption := IntToStr(iFilePos + 1) + ' / ' + IntToStr(list.Count);
  end;
  list.Free;
end;

procedure TfmMainAriel.actPrevFileExecute(Sender: TObject);
var
  list: TList<AnsiString>;
  iFilePos: integer;
begin
  list := getFilesInFolder(FDataFileName);
  iFilePos := getFileCurrentPosition(list, FDataFileName) - 1;
  if iFilePos >= 0 then
  begin
    FDataFileName := list[iFilePos];
    postOpenAction(FDataFileName, FProcType);
    lbFilePos.Caption := IntToStr(iFilePos + 1) + ' / ' + IntToStr(list.Count);
  end;
  list.Free;
end;

{$ENDREGION}

{$REGION 'Вид'}
procedure TfmMainAriel.actProcProductionExecute(Sender: TObject);
begin
  // обработка реального изделия
  actProcProduction.Checked := true;
  FProcType := ptProduction;
  postOpenAction(FDataFileName, FProcType);
end;

procedure TfmMainAriel.actProcCalibrationExecute(Sender: TObject);
begin
  // обработка калибровочной трубки
  actProcCalibration.Checked := true;
  FProcType := ptCalibration;
  postOpenAction(FDataFileName, FProcType);
end;

procedure TfmMainAriel.prepareGraphs(p1, p2: integer);
begin
  mv.InitData(p1, p2);
  // подготовка графиков
  chOneFullRe.BottomAxis.SetMinMax(p1, p2);
  chOneFullIm.BottomAxis.SetMinMax(p1, p2);
  chOneRe.BottomAxis.SetMinMax(p1, p2);
  chOneIm.BottomAxis.SetMinMax(p1, p2);
end;

procedure TfmMainAriel.actProcessedExecute(Sender: TObject);
begin
  // переоткрываем обработанные данные
  bRaw := not btProcessed.Down;
  if signalAnalyse.ProcessingParams.isProcessed and (not bRaw) then
    prepareGraphs(signalAnalyse.ProcessingParams.position1, signalAnalyse.ProcessingParams.position2)
  else
    prepareGraphs(0, signalAnalyse.Count - 1);
  // обновление канала
  channelsChange(iCurrentChannel);
end;

procedure TfmMainAriel.actViewSettingsExecute(Sender: TObject);
var
  i: integer;
begin
  // показать форму настроек сбора данных
  fmDeviceSettings := TfmDeviceSettings.Create(Application);
  fmDeviceSettings.setState(false);
  // копируем данные для редактирования настроек
  fmDeviceSettings.loadData(signalAnalyse.DeviceInfo);
  fmDeviceSettings.ShowModal;
  fmDeviceSettings.mdDeviceData.Close;
  fmDeviceSettings.Free;
end;

procedure TfmMainAriel.actAmplificationDownExecute(Sender: TObject);
begin
  if iAmpl > -20 then Dec(iAmpl);
  AmplificationChange();
end;

procedure TfmMainAriel.actAmplificationUpExecute(Sender: TObject);
begin
  if iAmpl < 20 then Inc(iAmpl);
  AmplificationChange();
end;

procedure TfmMainAriel.AmplificationChange();
var
  m, dm: double;
begin
  m := 10 * exp(-iAmpl * ln(2));
  chOneRe.LeftAxis.SetMinMax(-m, m);
  chOneIm.LeftAxis.SetMinMax(-m, m);
  chOneFullRe.LeftAxis.SetMinMax(-m, m);
  chOneFullIm.LeftAxis.SetMinMax(-m, m);
  chOneGod.LeftAxis.SetMinMax(-m, m);
  chOneGod.BottomAxis.SetMinMax(-m, m);
  if m>100 then dm:=20
  else if m>50 then dm:=10
  else if m>20 then dm:=4
  else if m>10 then dm:=2
  else if m>5 then dm:=1
  else if m>2 then dm:=0.4
  else if m>1 then dm:=0.2
  else if m>0.5 then dm:=0.1
  else if m>0.2 then dm:=0.04
  else if m>0.1 then dm:=0.02
  else dm:=0.01;
  chOneRe.LeftAxis.Increment := dm;
  chOneIm.LeftAxis.Increment := dm;
  chOneFullRe.LeftAxis.Increment := dm;
  chOneFullIm.LeftAxis.Increment := dm;
  chOneGod.BottomAxis.Increment := dm;
  chOneGod.LeftAxis.Increment := dm;
  lbAmp.Caption := 'Amp.: ' + FloatToStrF(m, ffGeneral, 4, 4) + ' V';
end;

procedure TfmMainAriel.channelsChange(iCh:integer);
var
  i, iChannel: integer;
  cx: TComplex;
begin
  iChannel := iCh;
  seriesOneRe.Clear;
  seriesOneIm.Clear;
  seriesOneFullRe.Clear;
  seriesOneFullIm.Clear;
  for i := 0 to signalAnalyse.Count - 1 do
  begin
    cx := signalAnalyse.getData(iChannel, i, bRaw);
    seriesOneFullRe.AddXY(i, cx.re);
    seriesOneFullIm.AddXY(i, cx.im);
    seriesOneRe.AddXY(i, cx.re);
    seriesOneIm.AddXY(i, cx.im);
  end;
  mv.setNewPosition;
  InvalidateRect(Handle, nil, false);
end;

procedure TfmMainAriel.tvDefectsCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  mdDefectsAfterScroll(mdDefects);
end;

procedure TfmMainAriel.tvParamsCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  iChannel: integer;
begin
  iChannel := ACellViewInfo.GridRecord.Values[0] - 1;
  iCurrentChannel := iChannel;
  channelsChange(iChannel);
  AHandled := true;
end;

procedure TfmMainAriel.mdDefectsAfterScroll(DataSet: TDataSet);
begin
  // отображение рамок дефекта
  if mdDefectsID.Value > 0 then
  begin
    mv.gPos1 := signalAnalyse.ProcessingDefects.Items[mdDefectsID.Value - 1].pos1;
    mv.gPos2 := signalAnalyse.ProcessingDefects.Items[mdDefectsID.Value - 1].pos2;
    mv.correctFramePos();
    UpdatePartGraphs();
  end;
end;

{$ENDREGION}

{$REGION 'Операции'}
procedure TfmMainAriel.actSaveParamsExecute(Sender: TObject);
var
  i: integer;
  s, line: string;
  iCh: integer;
  am, ph: string;
begin
  // собираем пачку данных
  s := '';
  for i := 0 to maxChannels - 1 do
  begin
    iCh := i + 1;
    if signalAnalyse.DeviceInfo.channelsInfo[i].isActive then
    begin
      am := tvParams.DataController.Values[i, 2];
      ph := tvParams.DataController.Values[i, 3];
    end
    else
    begin
      am := '';
      ph := '';
    end;
    line := am + #09 + ph + #09;
    s := s + line;
  end;
  // кладем данные в буфер
  Clipboard.SetTextBuf(PChar(s));
end;

procedure TfmMainAriel.actTestDeviceExecute(Sender: TObject);
var
  defParams: array of TDefectParams;
begin
  // делаем поверку
  SetLength(defParams, FIniSettings.nDefs);
  signalAnalyse.doCalibTestD(FIniSettings.defs, FIniSettings.nDefs, FIniSettings.frameWidth, defParams);
  fmCalibTestDevice := TfmCalibTestDevice.Create(Application);
  fmCalibTestDevice.addSignalData(FIniSettings.nDefs, FIniSettings.defs, defParams);
  fmCalibTestDevice.ShowModal;
  fmCalibTestDevice.Free;
  defParams := nil;
end;

procedure TfmMainAriel.actCalibCheckExecute(Sender: TObject);
begin
  // проверяем калибровку
  if signalAnalyse.doCalibCheck(FIniSettings.defs, FIniSettings.nDefs, FIniSettings.frameWidth) then
    ShowMessage('Калибровка НОРМАЛЬНАЯ')
  else
    ShowMessage('ОШИБКА КАЛИБРОВКИ');
end;

procedure TfmMainAriel.actCalibExecute(Sender: TObject);
begin
  // калибровка
  signalAnalyse.doPreProcessing(FIniSettings.psCalib);
  signalAnalyse.doCalib(FIniSettings.defs, FIniSettings.nDefs, FIniSettings.iDefect, FIniSettings.frameWidth, FIniSettings.calibValue, FIniSettings.calibThreshold);
  postOpenAction(FDataFileName, ptCalibration);
end;

procedure TfmMainAriel.actCalibStartExecute(Sender: TObject);
begin
  // начинаем новый цикл калибровок
  signalAnalyse.doCalibStart();
  // обновляем индикаторы
  if signalAnalyse.Calibrated then
    TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[1].IndicatorType := sitTeal
  else
    TdxStatusBarStateIndicatorPanelStyle(stBar.Panels[3].PanelStyle).Indicators.Items[1].IndicatorType := sitPurple;
  stBar.Refresh;
end;

procedure TfmMainAriel.actReportExecute(Sender: TObject);
begin
  // запуск отчета
  if signalAnalyse.Calibrated then
  begin
    fmReportBuilder := TfmReportBuilder.Create(Application);
    fmReportBuilder.initData(signalAnalyse, FIniSettings);
    fmReportBuilder.ShowModal;
    fmReportBuilder.Free;
    postOpenAction(FDataFileName, FProcType);
  end
  else
    ShowMessage('Калибровка не выполнена!'#10#13'Выполните калибровку перед формированием отчета.');
end;

{$ENDREGION}

{$REGION 'Обработка'}
procedure TfmMainAriel.tmLicTimer(Sender: TObject);
begin
  if not lv.isLicenseValid() then
  begin
    ShowMessage('Ключ защиты не обнаружен. Программа будет закрыта.');
    Application.Terminate;
  end;
end;

procedure TfmMainAriel.tmTimer(Sender: TObject);
begin
  InvalidateRect(Handle, nil, false);
end;

procedure TfmMainAriel.pnlOneChResize(Sender: TObject);
begin
  pnlOneFull.Height := Round(pnlOneCh.Height * 0.4);
end;

procedure TfmMainAriel.pnlOneFullResize(Sender: TObject);
begin
  chOneFullRe.Height := pnlOneFull.Height div 2;
end;

procedure TfmMainAriel.pnlOneGraphResize(Sender: TObject);
begin
  chOneGod.Width := chOneGod.Height;
end;

procedure TfmMainAriel.pnlOneReImResize(Sender: TObject);
begin
  chOneRe.Height := pnlOneReIm.Height div 2;
end;

procedure TfmMainAriel.chOneFullReBeforeDrawAxes(Sender: TObject);
var
  x1,x2,y1,y2:integer;
  cl:TColor;
begin
  with (sender as TChart).LeftAxis do
  begin
    y1:=CalcPosValue(Maximum)+1;
    y2:=CalcPosValue(Minimum)-1;
  end;
  with (sender as TChart).Canvas do
  begin
    Pen.Style:=psSolid;
    Brush.Style:=bsSolid;
    // внутренняя рамка
    cl:=clBlue;
    Pen.Color:=cl;
    Brush.Color:=cl;
    x1:=(sender as TChart).BottomAxis.CalcPosValue(mv.gPos1);
    x2:=(sender as TChart).BottomAxis.CalcPosValue(mv.gPos2);
    Rectangle(x1-1,y1,x1+1,y2);
    Rectangle(x2-1,y1,x2+1,y2);
    // основная рамка
    cl:=clBlue;
    Pen.Color:=cl;
    Brush.Color:=cl;
    x1:=(sender as TChart).BottomAxis.CalcPosValue(mv.iPos1);
    x2:=(sender as TChart).BottomAxis.CalcPosValue(mv.iPos2);
    Rectangle(x1-2,y1,x1+2,y2);
    Rectangle(x2-2,y1,x2+2,y2);
  end;
end;

procedure TfmMainAriel.chOneFullReMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mv.onMouseDown(Button, Shift, X, Y);
  chOneFullReMouseMove(Sender, Shift, X, Y);
end;

procedure TfmMainAriel.chOneFullReMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
const
  cMin_px=8;
var
  ps:integer;
  cMin:integer;
begin
  if mv.capt then
  begin
    cMin:=Round((sender as TChart).BottomAxis.CalcPosPoint(cMin_px)-(sender as TChart).BottomAxis.CalcPosPoint(0));
    if (mv.bt=mbLeft) and mv.bLeftBorder then
    begin
      ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X));
      mv.moveBigLeft(ps,cMin);
      UpdatePartGraphs();
    end
    else if (mv.bt=mbLeft) and mv.bRightBorder then
    begin
      ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X));
      mv.moveBigRight(ps,cMin);
      UpdatePartGraphs();
    end
    else if (mv.bt=mbRight) and (not (ssCtrl in Shift)) then
    begin // правая кнопка мыши - изменение размеров области выделения
      ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X)-(sender as TChart).BottomAxis.CalcPosPoint(mv.oldX));
      mv.moveBigBothSym(ps,cMin);
      mv.oldX:=X;
      UpdatePartGraphs();
    end
    else if (mv.bt = mbLeft) and (not (ssCtrl in Shift)) then
    begin  // левая кнопка мыши - перемещение выделенной области
      ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X));//-(sender as TChart).BottomAxis.CalcPosPoint(oldX));
      mv.moveBigBoth(ps,cMin);
      UpdatePartGraphs();
    end;
  end
  else
  begin
    mv.moveChart((sender as TChart), X, mv.iPos1, mv.iPos2);
  end;
end;

procedure TfmMainAriel.chOneFullReMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mv.onMouseUp();
end;

procedure TfmMainAriel.chOneReBeforeDrawAxes(Sender: TObject);
var
  x1,x2,y1,y2:integer;
  cl:TColor;
begin
  with (sender as TChart).LeftAxis do
  begin
    y1:=CalcPosValue(Maximum)+1;
    y2:=CalcPosValue(Minimum)-1;
  end;
  // вывод внутренней рамки
  cl:=clBlue;
  with (sender as TChart).Canvas do
  begin
    Pen.Color:=cl;
    Pen.Style:=psSolid;
    Brush.Color:=cl;
    Brush.Style:=bsSolid;
    x1:=(sender as TChart).BottomAxis.CalcPosValue(mv.gPos1);
    x2:=(sender as TChart).BottomAxis.CalcPosValue(mv.gPos2);
    Rectangle(x1-2,y1,x1+2,y2);
    Rectangle(x2-2,y1,x2+2,y2);
    // прицельная полоска
    x1:=(x1+x2) div 2;
    Pen.Color:=clRed;
    Pen.Style:=psDash;
    Brush.Color:=clRed;
    Brush.Style:=bsClear;
    MoveTo(x1, y1);
    LineTo(x1,y2);
  end;
end;


procedure TfmMainAriel.chOneReMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mv.onMouseDown(Button, Shift, X, Y);
  chOneReMouseMove(sender, shift, x, y);
end;

procedure TfmMainAriel.chOneReMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  cDelta=5;
  cMin_px=8;
  cNamesChart:array[1..2]of string=('Re (В)','Im (В)');
var
  ps:integer;
  cMin:integer;
begin
  if mv.capt then
  begin
    cMin:=Round((sender as TChart).BottomAxis.CalcPosPoint(cMin_px)-(sender as TChart).BottomAxis.CalcPosPoint(0));
    if (mv.bt=mbLeft) and (not (ssCtrl in Shift)) then
    begin // левая - основная кнопка мыши - перемещение границ
      if(mv.bLeftBorder) then
      begin // движение левой границы
        ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X));
        mv.moveLeftBorder(ps,cMin);  // для активной рамки
        InvalidateRect(Handle,nil,false);
      end
      else if (mv.bRightBorder)then
      begin // двигаем правую границу
        ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X));
        mv.moveRightBorder(ps,cMin); // для активной рамки
        InvalidateRect(Handle,nil,false);
      end
      else {if bFrameScroll then}
      begin  // прокрутка графика - левая клавиша
        ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X));//-(sender as TChart).BottomAxis.CalcPosPoint(oldX));
        mv.moveBothBorders(ps,cMin);  // для активной рамки
        InvalidateRect(Handle,nil,false);
      end;
    end
    else if (mv.bt = mbRight) and (not (ssCtrl in Shift)) then
    begin  // правая мыши - сужение, расширение графика
      // кусок графика
      cMin := Round(chOneRe.BottomAxis.CalcPosPoint(cMin_px) - chOneRe.BottomAxis.CalcPosPoint(0));
      ps:=Round((sender as TChart).BottomAxis.CalcPosPoint(X)-(sender as TChart).BottomAxis.CalcPosPoint(mv.oldX));
      mv.oldX:=X;
      mv.moveBothSym(ps, cMin);
      UpdatePartGraphs();
    end;
  end
  else
  begin
    mv.moveChart((sender as TChart), X, mv.gPos1, mv.gPos2);
  end;
end;

procedure TfmMainAriel.chOneReMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mv.onMouseUp();
end;

procedure TfmMainAriel.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
const
  cMin_px=8;
var
  ps:integer;
  cMin:integer;

  // в качестве "p" - используется координата экранная!!!
  function isMouseOnControl(control: TControl; p: TPoint): boolean;
  var
    localPoint: TPoint;
  begin
    localPoint := control.ScreenToClient(p);
    Result := (localPoint.X >= 0) and (localPoint.Y >= 0) and
              (localPoint.X < control.Width) and (localPoint.Y < control.Height);
  end;

begin
  if isMouseOnControl(chOneFullRe, MousePos) or isMouseOnControl(chOneFullIm, MousePos) then
  begin
    // полный график
    cMin := Round(chOneRe.BottomAxis.CalcPosPoint(cMin_px) - chOneRe.BottomAxis.CalcPosPoint(0));
    ps := WheelDelta;
    mv.moveBigBothSym(ps, cMin);
    UpdatePartGraphs();
  end
  else if isMouseOnControl(chOneRe, MousePos) or isMouseOnControl(chOneIm, MousePos) then
  begin
    // кусок графика
    cMin := Round(chOneRe.BottomAxis.CalcPosPoint(cMin_px) - chOneRe.BottomAxis.CalcPosPoint(0));
    ps := WheelDelta;
    mv.moveBothSym(ps, cMin);
    InvalidateRect(Handle, nil, false);
  end;
  Handled := true;
end;

procedure TfmMainAriel.drawGodographData();
var
  i, iChannel: integer;
  cx: TComplex;
  pp: TPriznakPack;
  pk1, pk2: integer;
begin
  iChannel := iCurrentChannel;
  seriesOneGod.Clear;
  for i := mv.gPos1 to mv.gPos2 do
  begin
    cx := signalAnalyse.getData(iChannel, i, bRaw);
    seriesOneGod.AddXY(cx.re, cx.im);
  end;
  // чистим годографы с точками
  seriesOnePointsRe.Clear;
  seriesOnePointsIm.Clear;
  seriesOnePointsGod.Clear;
  // считаем амплитуды и фазы
  tvParams.DataController.BeginFullUpdate;
  for i := 0 to maxChannels - 1 do
    if signalAnalyse.DeviceInfo.channelsInfo[i].isActive then
    begin
      // вычисляем признаки
      pp := getPriznaksAll(mv.gPos1, mv.gPos2, i, signalAnalyse, bRaw);
      pk1 := mv.gPos1 + pp.k1;
      pk2 := mv.gPos1 + pp.k2;
      // рисуем в табличке
      tvParams.DataController.Values[i, 2] := RoundTo(pp.Am, -2);
      tvParams.DataController.Values[i, 3] := Round(pp.Ph);
      // ставим точки на годографе
      if (iCurrentChannel = i) and (not signalAnalyse.DeviceInfo.channelsInfo[i].bAbs) then
      begin
        if (seriesOneRe.Count > 0) and (seriesOneIm.Count > 0) then
        begin
          // рисуем точки на годографе
          seriesOnePointsGod.AddXY(seriesOneRe.YValue[pk1], seriesOneIm.YValue[pk1],'',clRed);
          seriesOnePointsGod.AddXY(seriesOneRe.YValue[pk2], seriesOneIm.YValue[pk2],'',clGreen);
          seriesOnePointsGod.AddXY(seriesOneRe.YValue[pk2], seriesOneIm.YValue[pk2],'',clGreen);
          // рисуем точки на компонентах сигнала
          seriesOnePointsRe.AddXY(pk1, seriesOneRe.YValue[pk1],'',clRed);
          seriesOnePointsRe.AddXY(pk2, seriesOneRe.YValue[pk2],'',clGreen);
          seriesOnePointsRe.AddXY(pk2, seriesOneRe.YValue[pk2],'',clGreen);
          seriesOnePointsIm.AddXY(pk1, seriesOneIm.YValue[pk1],'',clRed);
          seriesOnePointsIm.AddXY(pk2, seriesOneIm.YValue[pk2],'',clGreen);
          seriesOnePointsIm.AddXY(pk2, seriesOneIm.YValue[pk2],'',clGreen);
        end;
      end;
    end;
  tvParams.DataController.EndFullUpdate;
end;

procedure TfmMainAriel.UpdatePartGraphs();
begin
  chOneIm.BottomAxis.SetMinMax(mv.ipos1, mv.ipos2);
  chOneRe.BottomAxis.SetMinMax(mv.ipos1, mv.ipos2);
  InvalidateRect(Handle,nil,false);
end;

{$ENDREGION}

end.
