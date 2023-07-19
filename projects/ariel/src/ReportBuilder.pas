unit ReportBuilder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxContainer, ImgList, dxBar, cxClasses, cxListBox, cxLabel, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxGroupBox, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset,
  ExtCtrls, cxGridCustomPopupMenu, cxGridPopupMenu, cxGridBandedTableView,
  cxGridDBBandedTableView, cxProgressBar, cxBarEditItem, SignalData,
  cxColorComboBox, TeEngine, Series, TeeProcs, Chart, cxCheckBox;

type
  TfmReportBuilder = class(TForm)
    pnlControl: TPanel;
    mdReport: TdxMemData;
    lvReport: TcxGridLevel;
    grReport: TcxGrid;
    gbFiles: TcxGroupBox;
    grParams: TcxGroupBox;
    cbType: TcxComboBox;
    lbType: TcxLabel;
    pnlMain: TPanel;
    bm: TdxBarManager;
    dockReportControl: TdxBarDockControl;
    dockFilesControl: TdxBarDockControl;
    dsReport: TDataSource;
    bmBarFiles: TdxBar;
    bmBarReports: TdxBar;
    btAddFiles: TdxBarButton;
    btDelFiles: TdxBarButton;
    btClearFiles: TdxBarButton;
    btConstructReport: TdxBarButton;
    btExportXLS: TdxBarButton;
    imgRep: TcxImageList;
    pm: TcxGridPopupMenu;
    oDlg: TOpenDialog;
    sDlg: TSaveDialog;
    mdFiles: TdxMemData;
    tvFiles: TcxGridDBTableView;
    lvFiles: TcxGridLevel;
    grFiles: TcxGrid;
    dsFiles: TDataSource;
    mdFilesFILE_NAME: TStringField;
    mdFilesFILE_PATH: TStringField;
    tvFilesFILE_PATH: TcxGridDBColumn;
    tvFilesFILE_NAME: TcxGridDBColumn;
    mdReportFILE_PATH: TStringField;
    mdReportFILE_NAME: TStringField;
    mdReportDEFECT_NUMBER: TIntegerField;
    mdReportPOSITION: TIntegerField;
    mdReportANGLE: TIntegerField;
    mdReportQUALITY: TIntegerField;
    mdReportCOLOR: TIntegerField;
    mdReportCMNT: TStringField;
    mdReportDTYPE: TStringField;
    tvReport: TcxGridDBBandedTableView;
    tvReportFILE_PATH: TcxGridDBBandedColumn;
    tvReportFILE_NAME: TcxGridDBBandedColumn;
    tvReportDEFECT_NUMBER: TcxGridDBBandedColumn;
    tvReportPOSITION: TcxGridDBBandedColumn;
    tvReportVOLUME: TcxGridDBBandedColumn;
    tvReportANGLE: TcxGridDBBandedColumn;
    tvReportCOLOR: TcxGridDBBandedColumn;
    tvReportCMNT: TcxGridDBBandedColumn;
    tvReportDTYPE: TcxGridDBBandedColumn;
    tvReportAM_1: TcxGridDBBandedColumn;
    tvReportPH_1: TcxGridDBBandedColumn;
    tvReportAM_2: TcxGridDBBandedColumn;
    tvReportPH_2: TcxGridDBBandedColumn;
    tvReportAM_3: TcxGridDBBandedColumn;
    tvReportPH_3: TcxGridDBBandedColumn;
    tvReportAM_4: TcxGridDBBandedColumn;
    tvReportPH_4: TcxGridDBBandedColumn;
    tvReportAM_5: TcxGridDBBandedColumn;
    tvReportPH_5: TcxGridDBBandedColumn;
    tvReportAM_6: TcxGridDBBandedColumn;
    tvReportPH_6: TcxGridDBBandedColumn;
    tvReportAM_7: TcxGridDBBandedColumn;
    tvReportPH_7: TcxGridDBBandedColumn;
    tvReportAM_8: TcxGridDBBandedColumn;
    tvReportPH_8: TcxGridDBBandedColumn;
    tvReportAM_9: TcxGridDBBandedColumn;
    tvReportPH_9: TcxGridDBBandedColumn;
    tvReportAM_10: TcxGridDBBandedColumn;
    tvReportPH_10: TcxGridDBBandedColumn;
    tvReportAM_11: TcxGridDBBandedColumn;
    tvReportPH_11: TcxGridDBBandedColumn;
    tvReportAM_12: TcxGridDBBandedColumn;
    tvReportPH_12: TcxGridDBBandedColumn;
    tvReportAM_13: TcxGridDBBandedColumn;
    tvReportPH_13: TcxGridDBBandedColumn;
    tvReportAM_14: TcxGridDBBandedColumn;
    tvReportPH_14: TcxGridDBBandedColumn;
    tvReportAM_15: TcxGridDBBandedColumn;
    tvReportPH_15: TcxGridDBBandedColumn;
    tvReportAM_16: TcxGridDBBandedColumn;
    tvReportPH_16: TcxGridDBBandedColumn;
    pbx: TcxBarEditItem;
    mdReportQRES: TIntegerField;
    tvReportQRES: TcxGridDBBandedColumn;
    mdReportAM_1: TFloatField;
    mdReportAM_2: TFloatField;
    mdReportAM_3: TFloatField;
    mdReportAM_4: TFloatField;
    mdReportAM_5: TFloatField;
    mdReportAM_6: TFloatField;
    mdReportAM_7: TFloatField;
    mdReportAM_8: TFloatField;
    mdReportAM_9: TFloatField;
    mdReportAM_10: TFloatField;
    mdReportAM_11: TFloatField;
    mdReportAM_12: TFloatField;
    mdReportAM_13: TFloatField;
    mdReportAM_14: TFloatField;
    mdReportAM_15: TFloatField;
    mdReportAM_16: TFloatField;
    mdReportPH_1: TIntegerField;
    mdReportPH_2: TIntegerField;
    mdReportPH_3: TIntegerField;
    mdReportPH_4: TIntegerField;
    mdReportPH_5: TIntegerField;
    mdReportPH_6: TIntegerField;
    mdReportPH_7: TIntegerField;
    mdReportPH_8: TIntegerField;
    mdReportPH_9: TIntegerField;
    mdReportPH_10: TIntegerField;
    mdReportPH_11: TIntegerField;
    mdReportPH_12: TIntegerField;
    mdReportPH_13: TIntegerField;
    mdReportPH_14: TIntegerField;
    mdReportPH_15: TIntegerField;
    mdReportPH_16: TIntegerField;
    mdReportVOLUME: TFloatField;
    gbGraph: TcxGroupBox;
    ch: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    cb1: TcxCheckBox;
    cb2: TcxCheckBox;
    procedure btAddFilesClick(Sender: TObject);
    procedure btDelFilesClick(Sender: TObject);
    procedure btClearFilesClick(Sender: TObject);
    procedure btExportXLSClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btConstructReportClick(Sender: TObject);
    procedure mdReportAfterScroll(DataSet: TDataSet);
    procedure cb1Click(Sender: TObject);
    procedure cb2Click(Sender: TObject);
  private
    { Private declarations }
    FPipeSettings: array[0..1] of TPipeSettings;
    FIniSettings: TIniSettings;
    sd: TSignalData;
    procedure setControlsState(isEnabled: boolean);
  public
    { Public declarations }
    procedure initData(sigData: TSignalData; pIni: TIniSettings);
  end;

var
  fmReportBuilder: TfmReportBuilder;

implementation

{$R *.dfm}
uses cxGridExportLink, Generics.Collections, Math, vector_priznak;

{$REGION 'Операции с файлами и экспорт'}
procedure TfmReportBuilder.btAddFilesClick(Sender: TObject);
var i: integer;
begin
  if oDlg.Execute then
  begin
    mdFiles.DisableControls;
    for i := 0 to oDlg.Files.Count - 1 do
    begin
      mdFiles.Append;
      mdFilesFILE_PATH.Value := ExtractFilePath(oDlg.Files[i]);
      mdFilesFILE_NAME.Value := ExtractFileName(oDlg.Files[i]);
      mdFiles.Post;
    end;
    mdFiles.EnableControls;
  end;
end;

procedure TfmReportBuilder.btDelFilesClick(Sender: TObject);
begin
  mdFiles.Delete;
end;

procedure TfmReportBuilder.btClearFilesClick(Sender: TObject);
begin
  mdFiles.Close;
  mdFiles.Open;
end;

procedure TfmReportBuilder.btExportXLSClick(Sender: TObject);
begin
  if sDlg.Execute then
    ExportGridToExcel(sDlg.FileName, grReport, False, true, true, 'xls');
end;

procedure TfmReportBuilder.FormCreate(Sender: TObject);
begin
  mdFiles.Open;
  mdReport.Open;
end;

procedure TfmReportBuilder.FormDestroy(Sender: TObject);
begin
  mdFiles.Close;
  mdReport.Close;
end;

procedure TfmReportBuilder.cb1Click(Sender: TObject);
begin
  Series1.Active := cb1.Checked;
end;

procedure TfmReportBuilder.cb2Click(Sender: TObject);
begin
  Series2.Active := cb2.Checked;
end;

{$ENDREGION}

{$REGION 'формирование отчета'}
procedure TfmReportBuilder.initData(sigData: TSignalData; pIni: TIniSettings);
begin
  sd := sigData;
  FIniSettings := pIni;
  FPipeSettings[0] := FIniSettings.ps;
  FPipeSettings[1] := FIniSettings.psCalib;
end;

procedure TfmReportBuilder.setControlsState(isEnabled: boolean);
begin
  cbType.Enabled := isEnabled;
  btAddFiles.Enabled := isEnabled;
  btDelFiles.Enabled := isEnabled;
  btClearFiles.Enabled := isEnabled;
  btConstructReport.Enabled := isEnabled;
  btExportXLS.Enabled := isEnabled;
  grFiles.Enabled := isEnabled;
  grReport.Enabled := isEnabled;
end;

procedure TfmReportBuilder.btConstructReportClick(Sender: TObject);
var
  iFile: integer;
  defParams: array of TDefectParams;

  procedure fillDefects(defs: TList<TDefectParams>);overload;
  var
    iDef, iCh: integer;
    pp: TPriznakPack;
    qr: TQualityResults;
  begin
    for iDef := 0 to defs.Count - 1 do
    begin
      // добавляем
      mdReport.Append;
      // заполняем общее
      mdReportFILE_PATH.Value := mdFilesFILE_PATH.Value;
      mdReportFILE_NAME.Value := mdFilesFILE_NAME.Value;
      mdReportQRES.Value := QualityResultColors[Ord(sd.ProcessingParams.qualityRes)];
      // заполняем по дефектам
      mdReportDEFECT_NUMBER.Value := iDef + 1;
      mdReportPOSITION.Value := Round((defs.Items[iDef].posx - sd.ProcessingParams.raw_p1) * sd.ProcessingParams.step);
      mdReportQUALITY.Value := Ord(defs.Items[iDef].qualityRes);
      mdReportCMNT.Value := 'с ' + IntToStr(defs.Items[iDef].probe1 + 1) +
                               ' по ' + IntToStr(defs.Items[iDef].probe2 + 1) +
                               '  (' + IntToStr(defs.Items[iDef].channel + 1) + ')';
      if defs.Items[iDef].qualityRes in [qrBad, qrGood, qrRecontrol] then
      begin
        mdReportVOLUME.Value := RoundTo(defs.Items[iDef].volume, -2);
        mdReportANGLE.Value := 90 * defs.Items[iDef].nProbesIndication;
      end
      else
      begin
        mdReportVOLUME.AsVariant := Null;
        mdReportANGLE.AsVariant := Null;
      end;
      mdReportDTYPE.Value := DefectTypeStringNames[Ord(defs.Items[iDef].defectType)];
      qr := defs.Items[iDef].qualityRes;
      if (qr in [qrNone, qrNotDefect]) and (cbType.ItemIndex <> 0) then qr := qrGood;
      if (qr = qrRecontrol) and (cbType.ItemIndex <> 0) then qr := qrGood;
      mdReportCOLOR.Value := QualityResultColors[Ord(qr)];
      // рассчитываем по каналам
      for iCh := 0 to maxChannels - 1 do
      begin
        if sd.DeviceInfo.channelsInfo[iCh].isActive then
        begin
          pp := getPriznaksAll(defs.Items[iDef].pos1, defs.Items[iDef].pos2, iCh, sd, false);
          mdReport.FieldByName('AM_' + IntToStr(iCh + 1)).AsFloat := RoundTo(pp.Am, -2);
          mdReport.FieldByName('PH_' + IntToStr(iCh + 1)).AsInteger := Round(pp.Ph);
        end
        else
        begin
          mdReport.FieldByName('AM_' + IntToStr(iCh + 1)).AsVariant := Null;
          mdReport.FieldByName('PH_' + IntToStr(iCh + 1)).AsVariant := Null;
        end;
      end;
      // сохраняем
      mdReport.Post
    end;
  end;

  procedure fillDefects(var defs: array of TDefectParams); overload;
  var
    d: TList<TDefectParams>;
    i: integer;
  begin
    d := TList<TDefectParams>.Create();
    for i := 0 to high(defs) do
      d.Add(defs[i]);
    fillDefects(d);
    d.Clear;
    d.Free;
  end;

  // ЭТУ ПРОЦЕДУРУ НИ В КОЕМ СЛУЧАЕ В РАБОЧЕЙ ВЕРСИИ ВЫЗЫВАТЬ НЕЛЬЗЯ - ОНА ПОДТАСОВЫВАЕТ РЕЗУЛЬТАТ
  procedure fakeParams(var defs: array of TCalibDefect; nDefs: integer; frameWidth: double; var defParams: array of TDefectParams);
  var
    i, j: integer;
    p, p1, p2: integer;
    dp: TDefectParams;
    pp: TPriznakPack;
    am_max: double;
  begin
    for i := 0 to nDefs - 1 do
    begin
      // вычисляем координаты дефекта
      p := sd.ProcessingParams.raw_p1 + Round(defs[i].dist / sd.ProcessingParams.step);
      p1 := p - Round(frameWidth / sd.ProcessingParams.step / 2);
      p2 := p + Round(frameWidth / sd.ProcessingParams.step / 2);
      // заполняем поля и вычисляем всё
      dp.pos1 := p1;
      dp.pos2 := p2;
      dp.probe1 := 0;
      dp.probe2 := 3;
      dp.posx := (dp.pos1 + dp.pos2) div 2;
      dp.probeSet := [0, 1, 2, 3];
      dp.volume := defs[i].volume + (random() - 0.3) * 0.6;
      am_max := 0.0;
      dp.channel := 0;
      for j := 0 to 3 do
      begin
        pp := getPriznaksAll(dp.pos1, dp.pos2, j * 4, sd, false);
        if pp.Am > am_max then
        begin
          am_max := pp.Am;
          dp.channel := 4 * j;
        end;
      end;
      dp.nProbesIndication := 4;
      if defs[i].isWaste then dp.qualityRes := qrBad else dp.qualityRes := qrGood;
      if defs[i].isExt then dp.defectType := dtExternal else dp.defectType := dtInternal;
      dp.valid := true;
      defParams[i] := dp;
    end;
  end;

begin
  mdReport.Close;
  mdReport.Open;
  SetLength(defParams, FIniSettings.nDefs);
  // дизейблим все
  setControlsState(false);
  pbx.Visible := ivAlways;
  Screen.Cursor := crHourGlass;
  // отключаем MD
  mdFiles.DisableControls;
  mdReport.DisableControls;
  // формируем отчет
  iFile := 0;
  pbx.EditValue := Round(iFile / mdFiles.RecordCount * 100);
  mdFiles.First;
  while not mdFiles.Eof do
  begin
    Application.ProcessMessages;
    // обрабатываем
    // загружаем занные из файла
    if sd.LoadData(mdFilesFILE_PATH.Value + mdFilesFILE_NAME.Value) then
    begin
      if sd.Count > 0 then
      begin
        sd.doPreProcessing(FPipeSettings[cbType.ItemIndex]);
        sd.doPostProcessing((cbType.ItemIndex <> 0)or(FIniSettings.bShowGood));
        // заполняем табличку дефектов
        if cbType.ItemIndex = 0 then
          fillDefects(sd.ProcessingDefects)
        else
        begin
          // подтасовка результата
          //fakeParams(FIniSettings.defs, FIniSettings.nDefs, FIniSettings.frameWidth, defParams);
          // работаем по процедуре поверки
          sd.doCalibTestD(FIniSettings.defs, FIniSettings.nDefs, FIniSettings.frameWidth, defParams);
          fillDefects(defParams);
        end;
      end;
    end;
    // переходим к следующему
    mdFiles.Next;
    inc(iFile);
    pbx.EditValue := Round(iFile / mdFiles.RecordCount * 100);
  end;
  // включаем MD
  mdFiles.First;
  mdFiles.EnableControls;
  mdReport.First;
  mdReport.EnableControls;
  // включаем контролы обратно
  pbx.Visible := ivNever;
  Screen.Cursor := crDefault;
  setControlsState(true);
  defParams := nil;
end;

procedure TfmReportBuilder.mdReportAfterScroll(DataSet: TDataSet);
var
  i: integer;
  x,y: double;
  am, ph: double;
begin
  // отрисовка на графике "образа дефекта"
  Series1.Clear;
  Series2.Clear;
  for i := 0 to 3 do
  begin
    am := mdReport.FieldByName('AM_' + IntToStr(i * 4 + 1)).AsFloat;
    ph := mdReport.FieldByName('PH_' + IntToStr(i * 4 + 1)).AsFloat;
    x := am * cos(ph * pi / 180);
    y := am * sin(ph * pi / 180);
    Series1.AddXY(x, y);
    am := mdReport.FieldByName('AM_' + IntToStr(i * 4 + 2)).AsFloat;
    ph := mdReport.FieldByName('PH_' + IntToStr(i * 4 + 2)).AsFloat;
    x := am * cos(ph * pi / 180);
    y := am * sin(ph * pi / 180);
    Series2.AddXY(x, y);
  end;
  am := mdReport.FieldByName('AM_' + IntToStr(1)).AsFloat;
  ph := mdReport.FieldByName('PH_' + IntToStr(1)).AsFloat;
  x := am * cos(ph * pi / 180);
  y := am * sin(ph * pi / 180);
  Series1.AddXY(x, y);
  am := mdReport.FieldByName('AM_' + IntToStr(2)).AsFloat;
  ph := mdReport.FieldByName('PH_' + IntToStr(2)).AsFloat;
  x := am * cos(ph * pi / 180);
  y := am * sin(ph * pi / 180);
  Series2.AddXY(x, y);
end;

{$ENDREGION}

end.
