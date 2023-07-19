unit UserScriptData;

interface

uses
  ScripterInit,
  atScripter,
  atScript,
  Generics.Collections,

  MainEloView;


type
  TErrorPosition = record
    row: integer;
    col: integer;
  end;

  TChannelDataList = class;

  TScriptDispatcher = class
  strict private
    class var FScript: TScriptDispatcher;
    constructor Create();
    destructor Destroy; override;
  private
    FScripter: TatScripter;

    FChannels:   TChannelDataList;

    FData: TObject;
    FErrorMsg: string;
    FErrorPosition: TErrorPosition;
    procedure RegisterClasses;

    procedure AddParamProc(AMachine: TatVirtualMachine);
    procedure ClearParamsProc(AMachine: TatVirtualMachine);
    procedure GetChannelsItemProc(AMachine: TatVirtualMachine);

    procedure ScripterCompileError(Sender: TObject; var msg: string; row, col: integer; var ShowException: boolean);
    procedure ScripterRuntimeError(Sender: TObject; var msg: string; row, col: integer; var ShowException: boolean);
  public
    class function GetInstance(): TScriptDispatcher;

    function ExecuteScript(AText: String; AData: TObject): Variant;

    property Channels: TChannelDataList read FChannels;
    property ErrorMessage: string read FErrorMsg;
    property ErrorPosition: TErrorPosition read FErrorPosition;
  end;

  TChannelData = class
  strict private
    FData: TChannelViewData;
    function GetAmplitude: double;
    function GetChannel: integer;
    function GetFrequency: integer;
    function GetPhase: double;
    function GetPhaseRad: double;
    function GetSubChannel: integer;
  public
    constructor Create(const AData: TChannelViewData);

    property Channel: integer read GetChannel;
    property SubChannel: integer read GetSubChannel;
    property Frequency: integer read GetFrequency;
    property Amplitude: double read GetAmplitude;
    property Phase: double read GetPhase;
    property PhaseRad: double read GetPhaseRad;
  end;

  TChannelDataList = class
  strict private
    FData: TList<TChannelData>;
    function GetCount: integer;
    function GetItem(AIndex: integer): TChannelData;
    function Compare(A, B: TChannelData): integer;
    procedure qSort(left, right: integer);
  public
    constructor Create();
    destructor Destroy; override;

    procedure Clear;
    procedure AddItem(const AData: TChannelViewData);
    procedure Sort;

    property Items[AIndex: integer]: TChannelData read GetItem;
    property Count: integer read GetCount;
  end;

implementation

uses
  ap_SysUtils,
  ap_Classes,
  ap_Variants,
  ap_Contnrs,
  ap_StrUtils,
  ap_DateUtils,
  ap_Dialogs,
  System.SysUtils,
  System.Classes,

  UserScripts;

{$REGION 'Load and handlers'}
procedure TScriptDispatcher.RegisterClasses;
begin
  FScripter.OnCompileError := ScripterCompileError;
  FScripter.OnRuntimeError := ScripterRuntimeError;

  FScripter.AddLibrary(TatSysUtilsLibrary);
  FScripter.AddLibrary(TatClassesLibrary);
  FScripter.AddLibrary(TatVariantsLibrary);
  FScripter.AddLibrary(TatContnrsLibrary);
  FScripter.AddLibrary(TatStrUtilsLibrary);
  FScripter.AddLibrary(TatDateUtilsLibrary);
  FScripter.AddLibrary(TatDialogsLibrary);

  FScripter.DefineClassByRTTI(TChannelData);

  with FScripter.DefineClassByRTTI(TChannelDataList) do
  begin
    DefineProp('Items', TatTypeKind.tkClass, GetChannelsItemProc, nil,  TChannelData, False, 1);
  end;

  FScripter.DefineMethod('ClearResults', 0, TatTypeKind.tkNone, nil, ClearParamsProc, False, 0, '');
  FScripter.DefineMethod('AddParamValue', 2, TatTypeKind.tkNone, nil, AddParamProc, False, 0, 'const ParamName: string; const ParamValue: Variant');

  FScripter.AddObject('Channels', FChannels);
end;

procedure TScriptDispatcher.ScripterCompileError(Sender: TObject; var msg: string; row, col: integer; var ShowException: boolean);
begin
  FErrorMsg := 'Ошибка компиляции скрипта!' + #10 + 'Строка: ' + IntToStr(row) + ', колонка: ' + IntToStr(col) + #10 + 'Сообщение: ' + msg;
  FErrorPosition.row := row;
  FErrorPosition.col := col;
  ShowException := false;
  msg := '';
end;

procedure TScriptDispatcher.ScripterRuntimeError(Sender: TObject; var msg: string; row, col: integer; var ShowException: boolean);
begin
  FErrorMsg := 'Ошибка выполнения скрипта!' + #10 + 'Строка: ' + IntToStr(row) + ', колонка: ' + IntToStr(col) + #10 + 'Сообщение: ' + msg;
  FErrorPosition.row := row;
  FErrorPosition.col := col;
  ShowException := false;
  msg := '';
end;

{$ENDREGION 'Load and handlers'}

{$REGION 'TScriptDispatcher'}
procedure TScriptDispatcher.GetChannelsItemProc(AMachine: TatVirtualMachine);
begin
  with AMachine do
    ReturnOutputArgValue(TChannelDataList(CurrentObject).Items[GetArrayIndex(0)]);
end;

procedure TScriptDispatcher.ClearParamsProc(AMachine: TatVirtualMachine);
begin
  With AMachine do
  begin
    TResultsDataSource(FData).Clear;
  end;
end;

procedure TScriptDispatcher.AddParamProc(AMachine: TatVirtualMachine);
var
  rd: TResultData;
begin
  With AMachine do
  begin
    rd.paramName := GetInputArgAsString(0);
    rd.paramValue := GetInputArg(1);

    TResultsDataSource(FData).AddResult(rd.paramName, rd.paramValue);
  end;
end;

constructor TScriptDispatcher.Create();
begin
  FScripter := TatScripter.Create(nil);
  FChannels := TChannelDataList.Create;

  // регистрируем наши классы в скриптере
  RegisterClasses();

  FErrorMsg := '';
  FErrorPosition.row := -1;
  FErrorPosition.col := -1;

end;

destructor TScriptDispatcher.Destroy;
begin
  FChannels.Free;
  FScripter.Free;
  inherited;
end;

function TScriptDispatcher.ExecuteScript(AText: String; AData: TObject): Variant;
begin
  FData := AData;
  FErrorMsg := '';
  FScripter.SourceCode.Text := AText;
  Result := FScripter.Execute;
  FScripter.EventBroker.UnsetAllEvents;
  FScripter.SourceCode.Clear;
end;

class function TScriptDispatcher.GetInstance(): TScriptDispatcher;
begin
  if TScriptDispatcher.FScript = nil then
    TScriptDispatcher.FScript := TScriptDispatcher.Create();

  Result := TScriptDispatcher.FScript;
end;

{$ENDREGION 'TScriptDispatcher'}

{$REGION 'TChannelData'}
constructor TChannelData.Create(const AData: TChannelViewData);
begin
  FData := AData;
end;

function TChannelData.GetAmplitude: double;
begin
  Result := FData.Amp;
end;

function TChannelData.GetChannel: integer;
begin
  Result := FData.iChannel div 1000 + 1;
end;

function TChannelData.GetFrequency: integer;
begin
  Result := FData.Frequency;
end;

function TChannelData.GetPhase: double;
begin
  Result := FData.Phase;
end;

function TChannelData.GetPhaseRad: double;
begin
  Result := FData.Phase * pi / 180;
end;

function TChannelData.GetSubChannel: integer;
begin
  Result := FData.iChannel mod 1000;
end;
{$ENDREGION}

{$REGION 'TChannelDataList'}
constructor TChannelDataList.Create;
begin
  FData := TList<TChannelData>.Create;
end;

destructor TChannelDataList.Destroy;
begin
  Clear;
  FData.Free;
  inherited;
end;

procedure TChannelDataList.AddItem(const AData: TChannelViewData);
var
  cd: TChannelData;
begin
  cd := TChannelData.Create(AData);
  FData.Add(cd);
end;

procedure TChannelDataList.Clear;
var
  i: integer;
begin
  for i := 0 to FData.Count - 1 do
    FData[i].Free;
  FData.Clear;
end;

function TChannelDataList.GetCount: integer;
begin
  Result := FData.Count;
end;

function TChannelDataList.GetItem(AIndex: integer): TChannelData;
begin
  Result := FData[AIndex];
end;

procedure TChannelDataList.Sort;
begin
  qSort(0, FData.Count - 1);
end;

function TChannelDataList.Compare(A, B: TChannelData): integer;
begin
  if A.Channel < B.Channel then
    Result := -1
  else if A.Channel > b.Channel then
    Result := 1
  else
  begin
    if A.SubChannel < B.SubChannel then
      Result := -1
    else if A.SubChannel > B.SubChannel then
      Result := 1
    else
      Result := 0;
  end;
end;

procedure TChannelDataList.qSort(left, right: integer);
var
  i, j: integer;
  center: TChannelData;
  x: TChannelData;
begin
  i := left;
	j := right;
  center := nil;
  if i <= j then
    center := FData[(left + right) div 2];
	while(i <= j)do
  begin
		while (Compare(FData[i], center) < 0) and (i < right) do
			inc(i);
		while (Compare(FData[j], center) > 0) and (j > left) do
			dec(j);
		if (i <= j) then
    begin
			x := FData[i];
			FData[i] := FData[j];
			FData[j] := x;
			//
			inc(i);
			dec(j);
    end;
  end;
	if (left < j) then
		qSort(left, j);
	if (right > i) then
		qSort(i, right);
end;

{$ENDREGION}

end.
