program magnum3d_ec3;

uses
  Forms,
  main in 'main.pas' {fmMain},
  splash in 'splash.pas' {fmSplash},
  pre_proc in 'Forms\pre_proc.pas' {fmPreprocessor},
  cm_ini in 'common\cm_ini.pas',
  cmData in 'common\cmData.pas',
  cmProc in 'common\cmProc.pas',
  cmVars in 'common\cmVars.pas',
  ec_main2d in '2d\ec_main2d.pas',
  el_main2d in '2d\el_main2d.pas',
  ss_main2d in '2d\Ss_main2d.pas',
  common_main2d in '2d\common_main2d.pas',
  solve2d in 'Forms\solve2d.pas' {fmSolver2},
  control_ec in 'Forms\control_ec.pas' {fmControlCenterEC},
  Complx in 'Complx.pas',
  child in 'child.pas' {fmChild},
  axu_3 in '3d\axu_3.pas',
  ComVars in '3d\Comvars.pas',
  solve3d in 'Forms\solve3d.pas' {fmSolver3d},
  ax_add in '3d\ax_add.pas',
  app_view in 'Forms\app_view.pas' {fmSolveView},
  solve_Thread in '3d\solve_Thread.pas',
  SystemInformation in 'Forms\SystemInformation.pas' {fmSysInfo},
  tlbrs in 'tlbrs.pas' {fmToolBars},
  cmParams in 'cmParams.pas' {fmParams},
  control_ss in 'Forms\control_ss.pas' {fmControlM},
  pp_2 in 'Post\pp_2.pas' {fmPostProcessor2},
  graph_2 in 'Post\graph_2.pas' {fmGraph2},
  vi_2 in 'Post\vi_2.pas' {fmVInspector2},
  p2_data in 'Post\p2_data.pas',
  vi_3 in 'post3\vi_3.pas' {fmVInspector3},
  graph_3 in 'post3\graph_3.pas' {fmGraph3},
  pp_3 in 'post3\pp_3.pas' {fmPostProcessor3},
  p3_data in 'post3\p3_data.pas',
  gl_ob in 'post3\gl_ob.pas',
  Compute_VectorsUnit in 'post3\Compute_VectorsUnit.pas',
  ec_signal in 'Forms\ec_signal.pas' {fmSignal},
  multiedit in 'mmProc\multiedit.pas' {fmMultiEdit},
  mm_data in 'mmProc\mm_data.pas',
  multisolve in 'mmProc\multisolve.pas' {fmMultiSolve},
  mm_solve in 'mmProc\mm_solve.pas',
  mm_dlg in 'mmProc\mm_dlg.pas' {fmMDlg},
  mmPWD in 'mmProc\mmPWD.pas' {fmPWD},
  mm_dir in 'mmProc\mm_dir.pas' {fmDirs},
  mmPass in 'mmProc\mmPass.pas' {fmPass},
  solvenl in 'Forms\solvenl.pas' {fmSolveNl},
  comp_vec in 'Post\comp_vec.pas',
  ec_queue in '3d\ec_queue.pas' {fmQueue},
  opt_1 in 'opt_1.pas' {fmMFOptimization},
  opt_view in 'opt_view.pas' {fmOpView},
  solvenl3 in 'Forms\solvenl3.pas' {fmNonLine3},
  nonline2d in 'nonline2d.pas',
  f_simplex2 in 'f_simplex2.pas',
  ss_multi in 'mmProc\ss_multi.pas',
  ss_auto in 'ss_auto.pas' {fmAutoMag},
  ado3 in 'ado3.pas',
  godog in 'optimal\godog.pas',
  simp in 'optimal\simp.pas',
  op2d in 'optimal\op2d.pas' {fmOp2d},
  god2 in 'sq\god2.pas',
  simp2 in 'sq\simp2.pas',
  optim in 'sq\optim.pas' {fmOptim},
  uni_mesh in 'optimal\uni_mesh.pas',
  ec_auto in 'ec_auto.pas' {fmAutoEC};

{$R *.RES}

begin
  Application.Initialize;
  //////////////
{  fmSplash:=TfmSplash.Create(Application);
  fmSplash.Timer1.Enabled:=true;
  fmSplash.ShowModal;
  fmSplash.Free;
  fmPWD:=TfmPWD.Create(Application);
  fmPWD.ShowModal;
  fmPWD.Free; }
  pw.usr:=1;
  if pw.usr<>0 then
  begin
  //////////////
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmMFOptimization, fmMFOptimization);
  Application.CreateForm(TfmOpView, fmOpView);
  Application.Run;
  //////////////
  end;
end.
