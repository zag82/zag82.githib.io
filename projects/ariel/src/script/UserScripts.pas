unit UserScripts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvMemo, dxBar, cxClasses, Vcl.ActnList,
  cxPC, dxDockControl, dxDockPanel, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridLevel, cxGrid,

  MainEloView,

  Generics.Collections, atScript, atScripter, AdvmPS, dxStatusBar, cxContainer,
  cxLabel;

const
  resSaveConfirmation = 'Изменения не сохранены, сохранить?';
  resCaption = 'Пользовательские скрипты';
  resNewScript = 'Новый скрипт';

type
  TResultData = record
    paramName:  string;
    paramValue: Variant;
  end;

  TfmUserScriptsForm = class(TForm)
    bmScripts: TdxBarManager;
    mmScript: TAdvMemo;
    bmScriptsBarMenu: TdxBar;
    bmScriptsBarTools: TdxBar;
    miFile: TdxBarSubItem;
    miOperations: TdxBarSubItem;
    miRun: TdxBarButton;
    miNew: TdxBarButton;
    miOpen: TdxBarButton;
    miSave: TdxBarButton;
    miSaveAs: TdxBarButton;
    miExit: TdxBarButton;
    actsScripts: TActionList;
    actNew: TAction;
    actOpen: TAction;
    actSave: TAction;
    actSaveAs: TAction;
    actExit: TAction;
    actRun: TAction;
    oDlg: TOpenDialog;
    sDlg: TSaveDialog;
    dockRight: TdxDockSite;
    dockBottom: TdxDockSite;
    pnlLogs: TdxDockPanel;
    pnlResults: TdxDockPanel;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dxLayoutDockSite2: TdxLayoutDockSite;
    lvResults: TcxGridLevel;
    grResults: TcxGrid;
    tvResults: TcxGridTableView;
    AdvPascalMemoStyler1: TAdvPascalMemoStyler;
    tvResultsColumnName: TcxGridColumn;
    tvResultsColumnValue: TcxGridColumn;
    status: TdxStatusBar;
    lbLog: TcxLabel;
    procedure actExitExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure actSaveAsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmScriptChange(Sender: TObject);
    procedure mmScriptCursorChange(Sender: TObject);
    procedure lbLogDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    FOwner: TfmMainEloView;
    FModified: boolean;
    FFileName: string;
    procedure InitForm;
    procedure SetModified(AValue: boolean);
    procedure SetFileName(AValue: String);
    procedure UpdateCaption();
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    function IsNew(): boolean;

    property Modified: boolean read FModified write SetModified;
    property FileName: string read FFileName write SetFileName;

    class procedure Execute(AOwner: TfmMainEloView);
    class function GetInstance(): TfmUserScriptsForm;
  end;

  TResultsDataSource = class(TcxCustomDataSource)
  private
    FView: TcxGridTableView;
    FData: TList<TResultData>;
  protected
    function GetRecordCount: Integer; override;
    function GetValue(ARecordHandle: TcxDataRecordHandle;AItemHandle: TcxDataItemHandle): Variant; override;
    //function GetDisplayText(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): string;  Override;
  public
    constructor Create(AView: TcxGridTableView);
    destructor Destroy; override;
    procedure AddResult(AName: string; AValue: Variant);
    procedure Clear;
  end;


implementation

uses
  UserScriptData;

{$R *.dfm}

{$REGION 'Class'}
class function TfmUserScriptsForm.GetInstance(): TfmUserScriptsForm;
var
  i: integer;
begin
  // находит первую форму текущего типа
  Result := nil;
  for i := 0 to Application.ComponentCount - 1 do
    if Application.Components[i] is TfmUserScriptsForm then
    begin
      Result := TfmUserScriptsForm(Application.Components[i]);
      break;
    end;
end;

class procedure TfmUserScriptsForm.Execute(AOwner: TfmMainEloView);
begin
  with Self.Create(Application) do
  begin
    FOwner := AOwner;
    InitForm;
    Show;
  end;
end;
{$ENDREGION 'Class'}

{$REGION 'MAIN'}
procedure TfmUserScriptsForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := fmMainEloView.Handle;
end;

procedure TfmUserScriptsForm.InitForm;
begin
  tvResults.DataController.CustomDataSource := TResultsDataSource.Create(tvResults);

  FFileName := '';
  FModified := False;
  UpdateCaption;
  actNewExecute(Self);
end;

function TfmUserScriptsForm.IsNew: boolean;
begin
  Result := (Trim(mmScript.Lines.Text) = '') and (FileName = '');
end;

procedure TfmUserScriptsForm.lbLogDblClick(Sender: TObject);
begin
  // переходим на ошибку
  if TScriptDispatcher.GetInstance().ErrorMessage <> '' then
  begin
    mmScript.CurX := TScriptDispatcher.GetInstance().ErrorPosition.col - 1;
    mmScript.CurY := TScriptDispatcher.GetInstance().ErrorPosition.row - 1;
    mmScript.SetFocus;
  end;
end;

procedure TfmUserScriptsForm.mmScriptChange(Sender: TObject);
begin
  Modified := true;
end;

procedure TfmUserScriptsForm.SetModified(AValue: boolean);
begin
  FModified := AValue;
  UpdateCaption;
end;

procedure TfmUserScriptsForm.SetFileName(AValue: String);
begin
  FFileName := AValue;
  UpdateCaption;
end;

procedure TfmUserScriptsForm.UpdateCaption();
var
  sCap: string;
begin
  sCap := resCaption + ' - ' ;
  if FileName = '' then
    sCap := sCap + resNewScript
  else
    sCap := sCap + FileName;

  if Modified then
    sCap := sCap + '*';

  Caption := sCap;
end;

procedure TfmUserScriptsForm.mmScriptCursorChange(Sender: TObject);
begin
  status.Panels[0].Text := Format('Позиция: строка %d, колонка %d', [mmScript.CurY + 1, mmScript.CurX + 1]);
end;

procedure TfmUserScriptsForm.FormActivate(Sender: TObject);
begin
  Self.AlphaBlend := False;
  Self.AlphaBlendValue := 255;
end;

procedure TfmUserScriptsForm.FormDeactivate(Sender: TObject);
begin
//  Self.AlphaBlend := True;
//  Self.AlphaBlendValue := 127;
end;

procedure TfmUserScriptsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // пробуем сохранить
  if (Modified) and (not IsNew) then
    if MessageDlg(resSaveConfirmation, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      actSaveExecute(Sender);
  // чистим память
  tvResults.DataController.CustomDataSource.Free;
  Action := caFree;
end;

{$ENDREGION 'MAIN'}

{$REGION 'Main operations'}
procedure TfmUserScriptsForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmUserScriptsForm.actNewExecute(Sender: TObject);
begin
  // новый скрипт
  if (Modified) and (not IsNew) then
  begin
    if MessageDlg(resSaveConfirmation, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      actSaveExecute(Sender);
  end;

  // текст скрипта
  mmScript.Lines.Clear;
  Modified := True;
  FileName := '';

  // результат выполнения
  TResultsDataSource(tvResults.DataController.CustomDataSource).Clear;
  lbLog.Caption := '';
end;

procedure TfmUserScriptsForm.actOpenExecute(Sender: TObject);
begin
  if (Modified) and (not IsNew) then
  begin
    if MessageDlg(resSaveConfirmation, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      actSaveExecute(Sender);
  end;

  // открываем скрипт
  if oDlg.Execute then
  begin
    FileName := oDlg.FileName;
    mmScript.Lines.LoadFromFile(FileName);
    Modified := False;

    TResultsDataSource(tvResults.DataController.CustomDataSource).Clear;
    lbLog.Caption := '';
  end;
end;

procedure TfmUserScriptsForm.actSaveExecute(Sender: TObject);
begin
  // сохранение
  if FileName = '' then
    actSaveAsExecute(Sender)
  else
  begin
    mmScript.Lines.SaveToFile(FileName);
    Modified := False;
  end;
end;

procedure TfmUserScriptsForm.actSaveUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Modified;
end;

procedure TfmUserScriptsForm.actSaveAsExecute(Sender: TObject);
begin
  // сохранение под другим именем
  if sDlg.Execute then
  begin
    mmScript.Lines.SaveToFile(sDlg.FileName);
    FileName := sDlg.FileName;
    Modified := False;
  end;
end;

procedure TfmUserScriptsForm.actRunExecute(Sender: TObject);
var
  i: integer;
  ch: TChannelDataList;
begin
  // запуск скрипта
  lbLog.Caption := '';
  try
    // заполнение данными
    ch  := TScriptDispatcher.GetInstance().Channels;
    ch.Clear;
    for i := 0 to fmMainEloView.DataChannels.Count - 1 do
      ch.AddItem(fmMainEloView.DataChannels.GetItem(i));
    ch.Sort;

    // выполнение скрипта
    TScriptDispatcher.GetInstance().ExecuteScript(mmScript.Lines.Text, tvResults.DataController.CustomDataSource);
  finally
    if TScriptDispatcher.GetInstance().ErrorMessage <> '' then
      lbLog.Caption := TScriptDispatcher.GetInstance().ErrorMessage
    else
      lbLog.Caption := 'Скрипт выполнен успешно';
  end;
end;

{$ENDREGION 'Main operations'}

{$REGION 'TResultsDataSource'}
constructor TResultsDataSource.Create(AView: TcxGridTableView);
var
  rd: TResultData;
begin
  FView := AView;
  FData := TList<TResultData>.Create;

  rd.paramName  := 'Число';
  rd.paramValue := 23;
  FData.Add(rd);

  rd.paramName  := 'Строка';
  rd.paramValue := 'Кое что';
  FData.Add(rd);

  rd.paramName  := 'Значение';
  rd.paramValue := 2.35;
  FData.Add(rd);

  DataChanged;
end;

destructor TResultsDataSource.Destroy;
begin
  FData.Free;
  inherited;
end;

function TResultsDataSource.GetRecordCount: Integer;
begin
  Result := FData.Count;
end;

function TResultsDataSource.GetValue(ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant;
var
  iRow, iCol: integer;
begin
  iRow := Integer(ARecordHandle);
  iCol := Integer(AItemHandle);
  if iCol = 0 then
    Result := FData[iRow].paramName
  else
    Result := FData[iRow].paramValue;
end;

procedure TResultsDataSource.AddResult(AName: string; AValue: Variant);
var
  rd: TResultData;
begin
  rd.paramName  := AName;
  rd.paramValue := AValue;
  FData.Add(rd);

  DataChanged;
end;

procedure TResultsDataSource.Clear;
begin
  FData.Clear;
  DataChanged;
end;
{$ENDREGION 'TResultsDataSource'}

end.
