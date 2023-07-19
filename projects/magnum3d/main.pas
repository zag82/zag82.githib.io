unit main;

interface

uses pre_proc,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, Menus, ActnList, ImgList, AppEvnts;

const
  WM_MYICONNOTIFY = WM_USER + 123;

type
  TfmMain = class(TForm)
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N51: TMenuItem;
    aNew: TAction;
    aOpen: TAction;
    aSave: TAction;
    aSaveAs: TAction;
    aClose: TAction;
    aExit: TAction;
    aAbout: TAction;
    aHelpContents: TAction;
    aDevGuide: TAction;
    aSupMPEI: TAction;
    aSupETI: TAction;
    aViewer: TAction;
    aTile: TAction;
    aCascade: TAction;
    aArrange: TAction;
    aParameters: TAction;
    aSysInfo: TAction;
    aToolBar: TAction;
    aSolve2d: TAction;
    aSolve3d: TAction;
    aEddyCurrent: TAction;
    ImageList2: TImageList;
    ToolBar2: TToolBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    oDlg: TOpenDialog;
    sDlg: TSaveDialog;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    ToolBar3: TToolBar;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolBar4: TToolBar;
    N69: TMenuItem;
    N70: TMenuItem;
    Viewer1: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    aMagnets: TAction;
    aPostProc: TAction;
    aViewRes: TAction;
    aTextEd: TAction;
    aRunScript: TAction;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton2: TToolButton;
    N50: TMenuItem;
    aPost2D: TAction;
    ToolBar5: TToolBar;
    ToolButton3: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    aSolveDef: TAction;
    ToolButton1: TToolButton;
    N100: TMenuItem;
    N44: TMenuItem;
    N64: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    aSignal: TAction;
    PopupMenu1: TPopupMenu;
    HideItem: TMenuItem;
    RestoreItem: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Queues1: TMenuItem;
    RunQueue1: TMenuItem;
    aaaa1: TMenuItem;
    N71: TMenuItem;
    ToolButton6: TToolButton;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    aSolveNL3: TAction;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    N2DSquareprofiler1: TMenuItem;
    N88: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N53Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure aAboutExecute(Sender: TObject);
    procedure aTileExecute(Sender: TObject);
    procedure aCascadeExecute(Sender: TObject);
    procedure aArrangeExecute(Sender: TObject);
    procedure aViewerExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aNewExecute(Sender: TObject);
    procedure aOpenExecute(Sender: TObject);
    procedure aSaveExecute(Sender: TObject);
    procedure aSaveAsExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aSaveUpdate(Sender: TObject);
    procedure aSaveAsUpdate(Sender: TObject);
    procedure aCloseUpdate(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure N60Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure N63Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure aSolve2dExecute(Sender: TObject);
    procedure aSolve3dExecute(Sender: TObject);
    procedure aEddyCurrentExecute(Sender: TObject);
    procedure aSolve2dUpdate(Sender: TObject);
    procedure aSolve3dUpdate(Sender: TObject);
    procedure aEddyCurrentUpdate(Sender: TObject);
    procedure aViewResUpdate(Sender: TObject);
    procedure aViewResExecute(Sender: TObject);
    procedure aSysInfoExecute(Sender: TObject);
    procedure aSysInfoUpdate(Sender: TObject);
    procedure aToolBarExecute(Sender: TObject);
    procedure aMagnetsExecute(Sender: TObject);
    procedure aMagnetsUpdate(Sender: TObject);
    procedure aParametersExecute(Sender: TObject);
    procedure aSupMPEIExecute(Sender: TObject);
    procedure aSupETIExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aPostProcExecute(Sender: TObject);
    procedure aPostProcUpdate(Sender: TObject);
    procedure aPost2DExecute(Sender: TObject);
    procedure aPost2DUpdate(Sender: TObject);
    procedure aSignalExecute(Sender: TObject);
    procedure aSignalUpdate(Sender: TObject);
    procedure HideItemClick(Sender: TObject);
    procedure RestoreItemClick(Sender: TObject);
    procedure aTextEdExecute(Sender: TObject);
    procedure aTextEdUpdate(Sender: TObject);
    procedure aRunScriptExecute(Sender: TObject);
    procedure aRunScriptUpdate(Sender: TObject);
    procedure aSolveDefUpdate(Sender: TObject);
    procedure aSolveDefExecute(Sender: TObject);
    procedure ApplicationEvents1ShowHint(var HintStr: String;
      var CanShow: Boolean; var HintInfo: THintInfo);
    procedure RunQueue1Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure aSolveNL3Update(Sender: TObject);
    procedure aSolveNL3Execute(Sender: TObject);
    procedure N76Click(Sender: TObject);
    procedure N77Click(Sender: TObject);
    procedure N2DSquareprofiler1Click(Sender: TObject);
    procedure N88Click(Sender: TObject);
  private
    { Private declarations }
    ShownOnce: Boolean;
  public
    { Public declarations }
    ewx:boolean;
    procedure WMICON(var msg: TMessage); message WM_MYICONNOTIFY;
    procedure WMSYSCOMMAND(var msg: TMessage);message WM_SYSCOMMAND;
    procedure RestoreMainForm;
    procedure HideMainForm;
    procedure CreateTrayIcon(n:Integer);
    procedure DeleteTrayIcon(n:Integer);
    ////////////////////////////////////
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}
uses registry,
    Splash, cmData, common_main2d, cm_ini, cmVars, solve2d, control_ec, el_main2d,
    ss_main2d, ec_main2d, child, solve3d, app_view,systeminformation,tlbrs,
    control_ss, cmParams, vi_2, vi_3, comvars, ec_signal, multiedit, multisolve,
     ShellApi, shlobj, solvenl, ec_queue, opt_1, solvenl3, ss_auto, op2d,
  optim, ec_auto;

var reg:TRegistry;
    ids:int;

procedure TfmMain.WMICON(var msg: TMessage);
var P : TPoint;
begin
 case msg.LParam of
 WM_RBUTTONDOWN:
  begin
   GetCursorPos(p);
   SetForegroundWindow(Application.MainForm.Handle);
   PopupMenu1.Popup(P.X, P.Y);
  end;
 WM_LBUTTONDBLCLK : RestoreItemClick(Self);
 end;
end;

procedure TfmMain.WMSYSCOMMAND(var msg: TMessage);
begin
 inherited;
 if (Msg.wParam=SC_MINIMIZE) then HideItemClick(Self);
end;

procedure TfmMain.HideMainForm;
begin
  Application.ShowMainForm := False;
  ShowWindow(Application.Handle, SW_HIDE);
  ShowWindow(Application.MainForm.Handle, SW_HIDE);
end;

procedure TfmMain.RestoreMainForm;
var i,j : Integer;
begin
  Application.ShowMainForm := True;
  ShowWindow(Application.Handle, SW_SHOW);
  ShowWindow(Application.MainForm.Handle, SW_SHOW);
  if not ShownOnce then
  begin
    for I := 0 to Application.MainForm.ComponentCount -1 do
      if Application.MainForm.Components[I] is TWinControl then
        with Application.MainForm.Components[I] as TWinControl do
          if Visible then
          begin
            ShowWindow(Handle, SW_SHOWDEFAULT);
            for J := 0 to ComponentCount -1 do
              if Components[J] is TWinControl then
                ShowWindow((Components[J] as TWinControl).Handle, SW_SHOWDEFAULT);
          end;
    ShownOnce := True;
  end;
end;

procedure TfmMain.CreateTrayIcon(n:Integer);
var nidata : TNotifyIconData;
begin
 with nidata do
  begin
   cbSize := SizeOf(TNotifyIconData);
   Wnd := Self.Handle;
   uID := 1;
   uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
   uCallBackMessage := WM_MYICONNOTIFY;
   hIcon := Application.Icon.Handle;
   StrPCopy(szTip,Application.Title);
  end;
  Shell_NotifyIcon(NIM_ADD, @nidata);
end;

procedure TfmMain.DeleteTrayIcon(n:Integer);
var nidata : TNotifyIconData;
begin
 with nidata do
  begin
   cbSize := SizeOf(TNotifyIconData);
   Wnd := Self.Handle;
   uID := 1;
  end;
  Shell_NotifyIcon(NIM_DELETE, @nidata);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  ewx:=false;
  ///////////////////
  ShownOnce:= False;
  CreateTrayIcon(1);
  RestoreItem.Enabled := False;
  ////////////////////////////
  prAllowClose:=false;
  ids:=0;
  // registration
{  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CLASSES_ROOT;
  with reg do
  begin
    /////////////////////
    // *.mm3
    OpenKey('\.mm3',true);
    WriteString('','MagNum3D.Special');
    /////////////////////
    OpenKey('\MagNum3D.Special',true);
    WriteString('','MagNum3D multidata files');
    OpenKey('\MagNum3D.Special\DefaultIcon',true);
    WriteString('',Application.ExeName+',2');
    /////////////////////
    // *.mg3
    OpenKey('\.mg3',true);
    WriteString('','MagNum3D.Document');
    /////////////////////
    OpenKey('\MagNum3D.Document',true);
    WriteString('','MagNum3D project files');
    OpenKey('\MagNum3D.Document\DefaultIcon',true);
    WriteString('',Application.ExeName+',1');
    /////////////////////////////////////////
    OpenKey('\MagNum3D.Document\shell',true);
    OpenKey('\MagNum3D.Document\shell\open',true);
    OpenKey('\MagNum3D.Document\shell\open\command',true);
    WriteString('',Application.ExeName+' "%1"');
  end;
  reg.CloseKey;
  reg.Free;
  reg:=nil;  }
  // startup
  prOpened:=false;
  ProjectName:='';
  ProjectPath:='';
  RootDir:=ExtractFilePath(Application.ExeName);
  WindowState:=wsMaximized;
  // loading system data
  a_LoadMainData;
  ToolBar1.Visible:=_v1;
  ToolBar2.Visible:=_v2;
  ToolBar3.Visible:=_v3;
  ToolBar4.Visible:=_v4;
  ToolBar5.Visible:=_v5;
  {if wSeparator=0 then} DecimalSeparator:='.'{ else DecimalSeparator:=','};
  // command string analize
  if ParamCount=1 then ids:=1;
end;

procedure TfmMain.N24Click(Sender: TObject);
begin
  fmSplash:=TfmSplash.Create(Application);
  fmSplash.BitBtn1.Visible:=true;
  fmSplash.ShowModal;
  fmSplash.Free;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ewx then
  begin
    Action:=caFree;
//    sd.Execute;
  end
  else
  begin
    Action:=caNone;
    if prOpened then aCloseExecute(Self);
    if not prOpened then
    if MessageDlg('Do you want to exit MagNum3D ?',mtConfirmation,[mbYes,mbNo],-1)=mrYes then
    begin
      _v1:=Toolbar1.Visible;
      _v2:=Toolbar2.Visible;
      _v3:=Toolbar3.Visible;
      _v4:=Toolbar4.Visible;
      _v5:=Toolbar5.Visible;
      a_SaveMainData;
      //////////////////
      DeleteTrayIcon(1);
      //////////////////
      Action:=caFree;
    end;
  end;
end;

procedure TfmMain.N37Click(Sender: TObject);
begin
  if tt.Nodes<>nil then
  begin
    Screen.Cursor:=crHourGlass;
    a_SaveNodes2;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmMain.N38Click(Sender: TObject);
begin
  if tt.Topology<>nil then
  begin
    Screen.Cursor:=crHourGlass;
    a_SaveTopology2;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmMain.N39Click(Sender: TObject);
begin
  if tt.Sources<>nil then
  begin
    Screen.Cursor:=crHourGlass;
    a_SaveSources2;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmMain.N40Click(Sender: TObject);
begin
  if Task<0 then exit;
  Screen.Cursor:=crHourGlass;
  Case Task of
    0..2:if TFlatELTask(tt).Bounds<>nil then a_SaveBounds2_re;
    3:if TFlatSSTask(tt).Bounds<>nil then a_SaveBounds2_re;
    5:if TFlatECTask(tt).Bounds<>nil then a_SaveBounds2_cx;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N52Click(Sender: TObject);
begin
  if Task<0 then exit;
  Screen.Cursor:=crHourGlass;
  Case Task of
    0..2:if TFlatELTask(tt).RightSide<>nil then a_SaveRSide_re;
    3:if TFlatSSTask(tt).RightSide<>nil then a_SaveRSide_re;
    5:if TFlatECTask(tt).RightSide<>nil then a_SaveRSide_cx;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N53Click(Sender: TObject);
begin
  if Task<0 then exit;
  Screen.Cursor:=crHourGlass;
  Case Task of
    0..2:if TFlatELTask(tt).Matrix<>nil then a_SaveMatrix2_re;
    3:if TFlatSSTask(tt).Matrix<>nil then a_SaveMatrix2_re;
    5:if TFlatECTask(tt).Matrix<>nil then a_SaveMatrix2_cx;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N55Click(Sender: TObject);
begin
  if Task<0 then exit;
  Screen.Cursor:=crHourGlass;
  Case Task of
    0..2:if TFlatELTask(tt).Vmatr<>nil then a_SaveResult2_sc;
    3:if TFlatSSTask(tt).Vmatr<>nil then a_SaveResult2_re;
    5:if TFlatECTask(tt).Vmatr<>nil then a_SaveResult2_cx;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N56Click(Sender: TObject);
begin
  N37Click(Self);
  N38Click(Self);
  N39Click(Self);
  N40Click(Self);
  N52Click(Self);
  N53Click(Self);
  N55Click(Self);
end;

procedure TfmMain.aAboutExecute(Sender: TObject);
begin
  fmSplash:=TfmSplash.Create(Application);
  fmSplash.BitBtn1.Visible:=true;
  fmSplash.ShowModal;
  fmSplash.Free;
end;

procedure TfmMain.aTileExecute(Sender: TObject);
begin
  Tile;
end;

procedure TfmMain.aCascadeExecute(Sender: TObject);
begin
  Cascade;
end;

procedure TfmMain.aArrangeExecute(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TfmMain.aViewerExecute(Sender: TObject);
var dd6:TfmChild;
begin
  dd6:=TfmChild.Create(Application);
  dd6.Show;
end;

procedure TfmMain.aExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.aNewExecute(Sender: TObject);
begin
  if prOpened then aCloseExecute(Self);
  if not prOpened then
  begin
    prOpened:=true;
    ProjectName:='';
    ProjectPath:='';
    Caption:=capMain;
    a_LoadEmptyProject;
    fmPreProcessor:=TfmPreProcessor.Create(Application);
    fmPreProcessor.Show;
  end;
end;

procedure TfmMain.aOpenExecute(Sender: TObject);
begin
  oDlg.FileName:='';
  if prOpened then aCloseExecute(Self);
  if not prOpened then
  if oDlg.Execute then
  begin
//    a_LoadProject(oDlg.FileName);
    a_LoadProject_2(oDlg.FileName);
    if prError then exit;
    prOpened:=true;
    ProjectName:=ExtractFileName(oDlg.FileName);
    ProjectPath:=ExtractFilePath(oDlg.FileName);
    Caption:='<'+IntToStr(Task)+'> ( '+ProjectName+' ) - '+capMain;
    ChDir(ProjectPath);
    fmPreProcessor:=TfmPreProcessor.Create(Application);
    fmPreProcessor.Show;
  end;
end;

procedure TfmMain.aSaveExecute(Sender: TObject);
begin
  if ProjectName<>'' then
  begin // saving
    Caption:='<'+IntToStr(Task)+'> ( '+ProjectName+' ) - '+capMain;
    ChDir(ProjectPath);
//    a_SaveProject(ProjectName);
    a_SaveProject_2(ProjectName);
  end
  else // Saving dialog
    aSaveAsExecute(Self);
end;

procedure TfmMain.aSaveAsExecute(Sender: TObject);
begin
  sDlg.FileName:='';
  if sDlg.Execute then
  begin
    ProjectName:=ExtractFileName(sDlg.FileName);
    ProjectPath:=ExtractFilePath(sDlg.FileName);
    aSaveExecute(Self);
  end;
end;

procedure TfmMain.aCloseExecute(Sender: TObject);
var i:int;
begin
  if MessageDlg('Do you really want to close project?',mtConfirmation,[mbYes,mbNo],-1)=mrYes then
  begin // need to close
    prAllowClose:=true;
    prOpened:=false;
    ProjectName:='';
    ProjectPath:='';
    Caption:=capMain;
    if fmVInspector3<>nil then fmVInspector3.Close;
    if fmVInspector2<>nil then fmVInspector2.Close;
    for i:=MDIChildCount-1 downto 0 do
      MDIChildren[I].Close;
  end;
end;

procedure TfmMain.aSaveUpdate(Sender: TObject);
begin
  aSave.Enabled:=prOpened;
end;

procedure TfmMain.aSaveAsUpdate(Sender: TObject);
begin
  aSaveAs.Enabled:=prOpened;
end;

procedure TfmMain.aCloseUpdate(Sender: TObject);
begin
  aClose.Enabled:=prOpened;
end;

procedure TfmMain.N70Click(Sender: TObject);
begin
  ToolBar1.Visible:=not(ToolBar1.Visible);
end;

procedure TfmMain.N34Click(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  a_SavePoints3;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N35Click(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  a_SaveTopology3;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N36Click(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  a_SaveSources3;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N58Click(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  a_SaveBounds3;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N60Click(Sender: TObject);
begin
  N60.Checked:=not(N60.Checked);
end;

procedure TfmMain.N61Click(Sender: TObject);
begin
  N61.Checked:=not(N61.Checked);
end;

procedure TfmMain.N63Click(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  a_SaveResult3;
  Screen.Cursor:=crDefault;
end;

procedure TfmMain.N32Click(Sender: TObject);
begin
  N34Click(Self);
  N35Click(Self);
  N36Click(Self);
  N58Click(Self);
  N60Click(Self);
  N61Click(Self);
  N63Click(Self);
end;

procedure TfmMain.aSolve2dExecute(Sender: TObject);
begin
  if fmSolver2=nil then
  begin
    fmSolver2:=TfmSolver2.Create(Application);
    fmSolver2.Show;
  end
  else
    fmSolver2.WindowState:=wsNormal;
end;

procedure TfmMain.aSolve3dExecute(Sender: TObject);
begin
  if fmSolver3d=nil then
  begin
    fmSolver3d:=TfmSolver3d.Create(Application);
    fmSolver3d.Show;
  end
  else
    fmSolver3d.WindowState:=wsNormal;
end;

procedure TfmMain.aEddyCurrentExecute(Sender: TObject);
begin
  if fmControlCenterEC=nil then
  begin
    fmControlCenterEC:=TfmControlCenterEC.Create(Application);
    fmControlCenterEC.Show;
  end
  else
    fmControlCenterEC.WindowState:=wsNormal;
end;

procedure TfmMain.aSolve2dUpdate(Sender: TObject);
begin
  aSolve2d.Enabled:=prOpened;
end;

procedure TfmMain.aSolve3dUpdate(Sender: TObject);
begin
  aSolve3d.Enabled:=prOpened;
end;

procedure TfmMain.aEddyCurrentUpdate(Sender: TObject);
begin
  aEddyCurrent.Enabled:=(prOpened and (Task=5));
end;

procedure TfmMain.aViewResUpdate(Sender: TObject);
begin
  aViewRes.Enabled:=prOpened;
end;

procedure TfmMain.aViewResExecute(Sender: TObject);
begin
  if fmSolveView=nil then
  begin
    fmSolveView:=TfmSolveView.Create(Application);
    fmSolveView.Show;
  end
  else
    fmSolveView.WindowState:=wsNormal;
end;

procedure TfmMain.aSysInfoExecute(Sender: TObject);
begin
  fmSysInfo:=TfmSysInfo.Create(Application);
  fmSysInfo.Show;
end;

procedure TfmMain.aSysInfoUpdate(Sender: TObject);
begin
  aSysInfo.Enabled:=(fmSysInfo=nil);
end;

procedure TfmMain.aToolBarExecute(Sender: TObject);
begin
  fmToolbars:=TfmToolBars.Create(Application);
  fmToolBars.ShowModal;
  fmToolBars.Free;
end;

procedure TfmMain.aMagnetsExecute(Sender: TObject);
begin
  fmControlM:=TfmControlM.Create(Application);
  fmControlM.Show;
end;

procedure TfmMain.aMagnetsUpdate(Sender: TObject);
begin
  aMagnets.Enabled:=prOpened and((Task=3)or(task=2));
end;

procedure TfmMain.aParametersExecute(Sender: TObject);
begin
  fmParams:=TfmParams.Create(Application);
  fmParams.ShowModal;
  fmParams.Free;
end;

procedure TfmMain.aSupMPEIExecute(Sender: TObject);
begin
  //WinExec(PChar('explorer.exe http://www.mpei.ac.ru'),SW_SHOW);
end;

procedure TfmMain.aSupETIExecute(Sender: TObject);
begin
  //WinExec(PChar('explorer.exe http://eti.mpei.ac.ru'),SW_SHOW);
end;

procedure TfmMain.FormShow(Sender: TObject);
var FName:string;
begin
  // command string analize
  if ids<>0 then
  begin
    FName:=ParamStr(1);
    a_LoadProject_2(FName);
    if prError then exit;
    prOpened:=true;
    ProjectName:=ExtractFileName(FName);
    ProjectPath:=ExtractFilePath(FName);
    Caption:='<'+IntToStr(Task)+'> ( '+ProjectName+' ) - '+capMain;
    ChDir(ProjectPath);
    fmPreProcessor:=TfmPreProcessor.Create(Application);
    fmPreProcessor.Show;
    ///////////////////
    ids:=0;
  end;
end;

procedure TfmMain.aPostProcExecute(Sender: TObject);
begin
  if fmVInspector3=nil then
  begin
    fmVInspector3:=TfmVInspector3.Create(Application);
    fmVInspector3.Show;
  end
  else
    fmVInspector3.WindowState:=wsNormal;
end;

procedure TfmMain.aPostProcUpdate(Sender: TObject);
var vis:boolean;
begin
  vis:=true;
  if not prOpened then vis:=false;
  if axa=nil then vis:=false;
  if ATopology=nil then vis:=false;
  if vis then
    Case task of
      0..2:vis:=(ResultSc<>nil);
      3:vis:=(Result_X<>nil);
      5:vis:=(Result_Xc<>nil);
    end;
  aPostProc.Enabled:=vis;
end;

procedure TfmMain.aPost2DExecute(Sender: TObject);
begin
  if fmVInspector2=nil then
  begin
    fmVInspector2:=TfmVInspector2.Create(Application);
    fmVInspector2.Show;
  end
  else
    fmVInspector2.WindowState:=wsNormal;
end;

procedure TfmMain.aPost2DUpdate(Sender: TObject);
var vis:boolean;
begin
  vis:=true;
  if not prOpened then vis:=false;
  if tt=nil then vis:=false;
  if vis then
    Case task of
      0..2:vis:=(TFlatELTask(tt).Vmatr<>nil);
      3:vis:=(TFlatSSTask(tt).Vmatr<>nil);
      5:vis:=(TFlatECTask(tt).Vmatr<>nil);
    end;
  aPost2D.Enabled:=vis;
end;

procedure TfmMain.aSignalExecute(Sender: TObject);
begin
  if fmSignal=nil then
  begin
    fmSignal:=TfmSignal.Create(Application);
    fmSignal.Show;
  end
  else
    fmSignal.WindowState:=wsNormal;
end;

procedure TfmMain.aSignalUpdate(Sender: TObject);
var vis:boolean;
begin
  vis:=true;
  if not prOpened then vis:=false;
  if tt=nil then vis:=false;
  if axa=nil then vis:=false;
  if Task<>5 then vis:=false;
  if vis then
    vis:=(TFlatECTask(tt).Vmatr<>nil)or(Result_xc<>nil);
  aSignal.Enabled:=vis;
end;

procedure TfmMain.HideItemClick(Sender: TObject);
begin
  HideMainForm;
//  CreateTrayIcon(1);
  Application.Minimize;
  HideItem.Enabled := False;
  RestoreItem.Enabled := True;
end;

procedure TfmMain.RestoreItemClick(Sender: TObject);
begin
  RestoreMainForm;
//  DeleteTrayIcon(1);
  Application.Restore;
  RestoreItem.Enabled := False;
  HideItem.Enabled := True;
end;

procedure TfmMain.aTextEdExecute(Sender: TObject);
begin
  if fmMultiEdit=nil then
  begin
    fmMultiEdit:=TfmMultiEdit.Create(Application);
    fmMultiEdit.Show;
  end
  else
    fmMultiEdit.WindowState:=wsNormal;
end;

procedure TfmMain.aTextEdUpdate(Sender: TObject);
begin
  aTextEd.Enabled:=(prOpened)and(Task=5);
end;

procedure TfmMain.aRunScriptExecute(Sender: TObject);
var i:int;
    b:boolean;
begin
  fmMultiSolve:=TfmMultiSolve.Create(Application);
  fmMultiSolve.ShowModal;
  b:=fmMultiSolve.CheckBox1.Checked;
  fmMultiSolve.Free;
  fmMultiSolve:=nil;
  //////////////////////
  // close
  prAllowClose:=true;
  prOpened:=false;
  ProjectName:='';
  ProjectPath:='';
  Caption:=capMain;
  if fmVInspector3<>nil then fmVInspector3.Close;
  if fmVInspector2<>nil then fmVInspector2.Close;
  for i:=MDIChildCount-1 downto 0 do MDIChildren[I].Close;
  /////////////////////
  // reopen
  if not b then
  begin
    a_LoadProject_2(oDlg.FileName);
    if prError then exit;
    prOpened:=true;
    ProjectName:=ExtractFileName(oDlg.FileName);
    ProjectPath:=ExtractFilePath(oDlg.FileName);
    Caption:='<'+IntToStr(Task)+'> ( '+ProjectName+' ) - '+capMain;
    ChDir(ProjectPath);
    fmPreProcessor:=TfmPreProcessor.Create(Application);
    fmPreProcessor.Show;
  end
  else
  begin
    _v1:=Toolbar1.Visible;
    _v2:=Toolbar2.Visible;
    _v3:=Toolbar3.Visible;
    _v4:=Toolbar4.Visible;
    _v5:=Toolbar5.Visible;
    a_SaveMainData;
    DeleteTrayIcon(1);
    /////////////////////////////
    ewx:=true;
    Close;
  end;
end;

procedure TfmMain.aRunScriptUpdate(Sender: TObject);
begin
  aRunScript.Enabled:=(prOpened)and(Task=5);
end;

procedure TfmMain.aSolveDefUpdate(Sender: TObject);
begin
  aSolveDef.Enabled:=(prOpened)and((Task=3)or(Task=2));
end;

procedure TfmMain.aSolveDefExecute(Sender: TObject);
begin
  fmSolveNl:=TfmSolveNl.Create(Application);
  fmSolveNl.Show;
end;

procedure TfmMain.ApplicationEvents1ShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  StatusBar1.SimpleText:=HintInfo.HintStr;
end;

procedure TfmMain.RunQueue1Click(Sender: TObject);
begin
  fmQueue:=TfmQueue.Create(Application);
  fmQueue.ShowModal;
  fmQueue.Free;
end;

procedure TfmMain.N71Click(Sender: TObject);
begin
  fmMFOptimization:=TfmMFOptimization.Create(Application);
  fmMFOptimization.ShowModal;
  fmMFOptimization.Free;
end;

procedure TfmMain.aSolveNL3Update(Sender: TObject);
begin
  aSolveNL3.Enabled:=(prOpened)and((Task=3)or(Task=2));
end;

procedure TfmMain.aSolveNL3Execute(Sender: TObject);
begin
  if fmNonLine3=nil then
  begin
    fmNonLine3:=TfmNonLine3.Create(Application);
    fmNonLine3.Show;
  end
  else
    fmNonLine3.WindowState:=wsNormal;
end;

procedure TfmMain.N76Click(Sender: TObject);
begin
  if fmAutoMag=nil then
  begin
    fmAutoMag:=TfmAutoMag.Create(Application);
    fmAutoMag.Show;
  end
  else
    fmAutoMag.WindowState:=wsNormal;
end;

procedure TfmMain.N77Click(Sender: TObject);
begin
  if fmOp2d=nil then
  begin
    fmOp2d:=TfmOp2d.Create(Application);
    fmOp2d.Show;
  end
  else
    fmOp2d.WindowState:=wsNormal;
end;

procedure TfmMain.N2DSquareprofiler1Click(Sender: TObject);
begin
  if fmOptim=nil then
  begin
    fmOptim:=TfmOptim.Create(Application);
    fmOptim.Show;
  end
  else
    fmOptim.WindowState:=wsNormal;
end;

procedure TfmMain.N88Click(Sender: TObject);
begin
  if fmAutoEC=nil then
  begin
    fmAutoEC:=TfmAutoEC.Create(Application);
    fmAutoEC.Show;
  end
  else
    fmAutoEC.WindowState:=wsNormal;
end;

end.



