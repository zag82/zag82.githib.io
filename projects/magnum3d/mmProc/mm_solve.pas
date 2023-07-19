unit mm_solve;

interface

uses cm_ini, forms, mm_data,
  cmVars, cmData, pre_proc, common_main2d, ec_main2d, cmProc, ComPlx, ax_add,
  solve_Thread, comVars, ss_main2d;

procedure Solution_Prepare;

procedure mm_Solve_2d;
procedure mm_Solve_3d;
procedure mm_Solve_23(mm:int);
procedure mm_Solve_33;

function GetSignal(iSln,iObj:int):TComplex;
function GetFileName(chan:array of Cardinal):string;

implementation

uses sysutils;

procedure Solution_Prepare;
begin
  // reassign main class variable
  mt.GenerateAllProperties(Task);
  fmPreprocessor.TabSheet6Show(Application);
{  tt.ReleaseVars();
  tt.Free;
  tt:=TFlatECTask.Create;}
  fmPreprocessor.TabSheet6Exit(application);
  tt.nds:=false;
  tt.SetShower(nil,nil,nil);
  axa.nds:=false;
  axa.SetShower(nil,nil,nil);
  // prepare to solution
  tt.PrepareData;
  tt.GenerateNodes();
  tt.GenerateTopology();
  tt.GenerateBounds(bnd2,Nbnd2);
  ///////////////
  axa.PrepareData;
  axa.GenerateNodes(1,1);
  axa.GenerateTopology();
  axa.GenerateBounds(bnd3,Nbnd3);
end;

procedure mm_Solve_2d;
var j:int;
    w3:double;
begin
  // define solution arrays
  tt.GenerateTopMat();
  tt.GenerateSources();
  // starting solution
  tt.PrepareMatrix;
  tt.PrepareSolution;
  j:=0;
  repeat
    w3:=tt.MakeSolutionStep;
    j:=j+1;
  until (j>=ps.wMIter2d)or(w3<ps.wError2d);
  ///////////////////////////////////////
end;

procedure mm_Solve_3d;
var vl3:TSolution3d;
begin
  axa.GenerateTopMat();
  axa.GenerateSources;
  // starting solution
  vl3:=TSolution3d.Create(false);
  vl3.SetShower(nil,nil,nil,nil,nil);
  vl3.CreateAllMatrixEC;
  vl3.RunSolutionEC(ps.wError3d,ps.wMIter3d);
  vl3.Free;
  a_LoadResults(Task,0);
end;

procedure mm_Solve_23(mm:int);
var j:int;
    w3:float;
    df:TApproximateSolution;
    expa:TExpansionClass;
begin
  tt.GenerateTopMat();
  tt.GenerateSources();
  axa.GenerateTopMat();
  axa.GenerateSources;
  // starting solution
  tt.PrepareMatrix;
  tt.PrepareSolution;
  j:=0;
  repeat
    w3:=tt.MakeSolutionStep;
    j:=j+1;
  until (j>=ps.wMIter2d)or(w3<ps.wError2d);
  expa:=nil;
  expa:=TExpansionClass.Create();
  expa.nds:=false;
  expa.SetShower(nil,nil,nil);
  expa.ExpandSolutionEC;
  expa.Free;
  df:=TApproximateSolution.Create(false);
  df.SetShower(nil,nil,nil,nil,nil);
  df.PrepareDataEC(mm);
  df.CreateAllMatrixEC(mm);
  df.RunSolutionEC(ps.wError_d,ps.wMIter_d);
  df.Free;
  a_LoadResults(Task,2);
end;

procedure mm_Solve_33;
begin

end;

function GetSignal(iSln,iObj:int):TComplex;
var sg:TComplex;
    rm:int;
    rr:float;
    f:boolean;
begin
  sg:=CNull;
  if TMgObject(ob.Items[iObj]) is TSector then
  with TSector(ob.Items[iObj])do
  begin
    rm:=iMaterial;
    rr:=(r1+r2)/2;
    f:=true;
  end
  else
    f:=false;
  ///////////////////////////////////
  ////////////  iSln  ///////////////
  // =1 - 2D solution              //
  // =2 - 3D solution              //
  ///////////////////////////////////
  Case iSln of
    1:if f then sg:=GetSignal_Axial_2(rm,rr);
    2:if f then sg:=GetSignal_3D_1(rm,rr);
  end;
  Result:=sg;
end;

function GetFileName(chan:array of Cardinal):string;
var s_dir,s_file,ss:string;
    i:int;
    s_tmp:string;
begin
  s_file:='EC';
  s_dir:=mp.outPath;
  if not DirectoryExists(s_dir) then CreateDir(s_dir);
  for i:=1 to mp.num-1 do
  begin
    ss:=mp.outName[i].name;
    s_tmp:=mp.GetValS(i,1,chan[i],mp.outName[i].val);
    ss:=ss+s_tmp;
    if mp.outName[i].dr then
    begin
      s_dir:=s_dir+'\'+ss;
      if not DirectoryExists(s_dir) then CreateDir(s_dir);
    end
    else
      s_file:=s_file+'_'+ss;
  end;
  s_file:=s_file+'.txt';
  Result:=s_dir+'\'+s_file;
end;

end.
