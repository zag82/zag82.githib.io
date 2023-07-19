unit cmVars;

interface

uses
  cm_ini, cmData, ComPlx, Classes, common_main2d, axu_3;

const
  CapMain='MagNum3D';

Var
  // Common Data variables
  tt:TFlatTask;
  axa:TAxialTask3;
  Task:int;

  FluxDensity2:array of array[1..4]of float;

//////////////////////////////////////////////////////////////
//                   Common parameters                      //
//////////////////////////////////////////////////////////////
  wTPR:TThreadPriority=tpNormal; // приоритет потоков

  wAuto_StartS:boolean=false; // авто-запуск на решение
  wAuto_CloseS:boolean=false; // авто закрывание формы решения
  wSaveTop:boolean=false;
  wHide:boolean=true;
  wSeparator:int=0;

  _v1,_v2,_v3,_v4,_v5:boolean;
  tic:int=6;
//////////////////////////////////////////////////////////////

  // project parameters
  RootDir:string;
  prError:boolean=false;
  prOpened:boolean;
  ProjectName:string;
  ProjectPath:string;
  prAllowClose:boolean;

function min(a,b:float):float;overload;
function max(a,b:float):float;overload;
function min(a,b:int):int;overload;
function max(a,b:int):int;overload;

// binari file operations
function a_LoadDataFile(FileName:String; var Dest; Size : int):Boolean;
procedure a_SaveDataFile(FileName : String; var Source; Size : int);
// project properties
procedure a_LoadProject_2(s:string);
procedure a_SaveProject_2(s:string);
procedure a_LoadProject(s:string);
procedure a_UnLoadProject;
procedure a_SaveProject(s:string);
procedure a_LoadEmptyProject;
// main program parameters
procedure a_LoadMainData;
procedure a_SaveMainData;
// 2D task parameters
procedure a_SaveNodes2;
procedure a_SaveTopology2;
procedure a_SaveSources2;
procedure a_SaveBounds2_re;
procedure a_SaveBounds2_cx;
procedure a_SaveRSide_re;
procedure a_SaveRSide_cx;
procedure a_SaveMatrix2_re;
procedure a_SaveMatrix2_cx;
procedure a_SaveResult2_sc;
procedure a_SaveResult2_re;
procedure a_SaveResult2_cx;
// 3D task parameters
procedure a_SavePoints3;
procedure a_SaveTopology3;
procedure a_SaveSources3;
procedure a_SaveBounds3;
procedure a_SaveRSide3;
procedure a_SaveMatrix3;
procedure a_SaveMatrix3_re;
procedure a_SaveMatrix3_cx;
{procedure a_SaveMatrix2_cx;
procedure a_SaveResult2_sc;}
procedure a_SaveResult3;
///////////////////////////
procedure a_LoadResults(iTask:byte;flKind:byte);
procedure a_SaveResults(iTask:byte;flKind:byte);

implementation

uses SysUtils, el_main2d, ss_main2d, ec_main2d, Graphics, Dialogs, comVars;

function min(a,b:float):float;overload;
begin
  if a<b then Result:=a else Result:=b
end;

function max(a,b:float):float;overload;
begin
  if a>b then Result:=a else Result:=b
end;

function min(a,b:int):int;overload;
begin
  if a<b then Result:=a else Result:=b
end;

function max(a,b:int):int;overload;
begin
  if a>b then Result:=a else Result:=b
end;

{==============================================================================}
{==============================  Save/Load data  ==============================}
{==============================================================================}
function a_LoadDataFile(FileName:String; var Dest; Size : int):Boolean;
var
  FData : File;
begin
  Result:=False;
  if FileExists(FileName) then begin
    AssignFile(FData,FileName);
    Reset(FData,4);
    if FileSize(FData)=(Size div 4) then
    begin
      try
        BlockRead(FData,Dest,Size div 4)
      except
        on EInOutError do
      end;
      Result:=True
    end;
    CloseFile(FData)
  end
end;

procedure a_SaveDataFile(FileName : String; var Source; Size : int);
var
  FData : File;
begin
  AssignFile(FData,FileName);
  ReWrite(FData,4);
  BlockWrite(FData,Source,Size div 4);
  CloseFile(FData)
end;

procedure a_LoadProject(s:string);
var f:TextFile;
    i:int;
    s1:st80;
    k,g:byte;
    ff:float;
    ii,j:int;
    ss:string;
    cl:TColor;
    f1:int;
    f2:float;
begin
{$I-}
  prError:=false;
  if axa<>nil then begin axa.Delete; axa.Free; axa:=nil; end;
  if tt<>nil then begin tt.ReleaseVars; tt.Free; tt:=nil; end;
  if mt<>nil then begin mt.Free; mt:=nil end;
  if ob<>nil then begin ob.Clear; ob.Free; ob:=nil end;
  mt:=TMaterials.Create();
  tt:=TFlatTask.Create();
  axa:=TAxialTask3.Create();
  ob:=TList.Create();
  ob.Capacity:=10;
  Task:=-1;
  // bound 2d
  bnd2:=nil;
  Nbnd2:=0;
  // loading information
  AssignFile(f,s);
  Reset(f);
  Readln(f,k);
  if k<>VerID then
  begin
    ShowMessage('Illegal file version number !!!');
    prError:=true;
    exit;
  end;
  Readln(f);
  Readln(f,ii);  Task:=ii;
  // axial parameters  (2d mesh)
  Readln(f,ss);
  Readln(f,k);  tt.angle:=k;
  Readln(f,k);  tt.sort_d:=k;
  Readln(f,k);  tt.sort_t:=k;
  Readln(f,k);  tt.sort_ex:=k;
  Readln(f,ff);  tt.ax:=ff;
  Readln(f,ff);  tt.az:=ff;
  Readln(f,ii);  tt.nd1:=ii;
  Readln(f,ii);  tt.nd2:=ii;
  SetLength(tt.disc_1,tt.nd1+1);
  SetLength(tt.disc_2,tt.nd2+1);
  for i:=1 to tt.nd1 do begin Readln(f,f1,f2); tt.disc_1[i].num:=f1; tt.disc_1[i].val:=f2; end;
  for i:=1 to tt.nd2 do begin Readln(f,f1,f2); tt.disc_2[i].num:=f1; tt.disc_2[i].val:=f2; end;
  Readln(f,ii); tt.defMat:=ii;
  // material parameters
  Readln(f,ss);
  Readln(f,ii);  mt.nMaterials:=ii;
  mt.ChangeNum;
  Readln(f,ii);  mt.DefaultMaterial:=ii;
  Readln(f,ff);  mt.Frequency:=ff;
  for i:=0 to mt.nMaterials-1 do
  begin
    Readln(f,ff); mt.Anisotropy_X[i]:=ff;
    Readln(f,ff); mt.Anisotropy_Y[i]:=ff;
    Readln(f,ff); mt.Anisotropy_Z[i]:=ff;
    Readln(f,ff); mt.Epsilon[i]:=ff;
    Readln(f,ff); mt.MuProperty[i]:=ff;
    Readln(f,ff); mt.Sigma[i]:=ff;
    Readln(f,s1);mt.mmName[i]:=s1;
    Readln(f,cl); mt.mmColor[i]:=cl;
  end;
  // object parameters
  Readln(f,ss);
  Readln(f,ii);
  for i:=0 to ii-1 do
  begin
    Readln(f,s1);
    Readln(f,j);
    Readln(f,k);
    if k=1 then // block;
    begin
      ob.Add(TBlock.Create(j,s1));
      with TBlock(ob.Items[i]) do
      begin
        Readln(f,ff);  x_1:=ff;
        Readln(f,ff);  x_2:=ff;
        Readln(f,ff);  y_1:=ff;
        Readln(f,ff);  y_2:=ff;
        Readln(f,ff);  z_1:=ff;
        Readln(f,ff);  z_2:=ff;
      end;
    end
    else        // sector
    begin
      ob.Add(TSector.Create(j,s1));
      with TSector(ob.Items[i]) do
      begin
        Readln(f,ff);  xx:=ff;
        Readln(f,ff);  yy:=ff;
        Readln(f,ff);  zz:=ff;
        Readln(f,ff);  r1:=ff;
        Readln(f,ff);  r2:=ff;
        Readln(f,ff);  h:=ff;
        Readln(f,ff);  al:=ff;
        Readln(f,ff);  bt:=ff;
        Readln(f,g);    ax_dir:=g;
      end;
    end;
    with TMgObject(ob.Items[i]) do
    begin
      Readln(f,ff);  sr_1:=ff;
      Readln(f,ff);  sr_2:=ff;
      Readln(f,ff);  sr_3:=ff;
      Readln(f,ff);  sr_4:=ff;
      Readln(f,k);    sr_kind:=k;
    end;
  end;
  // bounds 2d
  Readln(f,ss);
  Readln(f,Nbnd2);
  SetLength(bnd2,Nbnd2);
  for i:=0 to Nbnd2-1 do
  begin                    //,SizeOf(TBound2)
    Readln(f,ii);  bnd2[i].x1:=ii;
    Readln(f,ii);  bnd2[i].x2:=ii;
    Readln(f,ii);  bnd2[i].z1:=ii;
    Readln(f,ii);  bnd2[i].z2:=ii;
    Readln(f,ff);  bnd2[i].val:=ff;
    Readln(f,ff);  bnd2[i].vl_im:=ff;
    Readln(f,ss);  bnd2[i].nm:=ss;
  end;
  // bounds 3d
  Readln(f,ss);
  Readln(f,Nbnd3);
  SetLength(bnd3,Nbnd3);
  for i:=0 to Nbnd3-1 do
  begin
    Readln(f,ii);  bnd3[i].x1:=ii;
    Readln(f,ii);  bnd3[i].x2:=ii;
    Readln(f,ii);  bnd3[i].y1:=ii;
    Readln(f,ii);  bnd3[i].y2:=ii;
    Readln(f,ii);  bnd3[i].z1:=ii;
    Readln(f,ii);  bnd3[i].z2:=ii;
    Readln(f,ii);  bnd3[i].dir:=ii;
    Readln(f,ff);  bnd3[i].val:=ff;
    Readln(f,ff);  bnd3[i].vl_im:=ff;
    Readln(f,ss);  bnd3[i].nm:=ss;
  end;
  // 3d discretization
  Readln(f,ss);
  Readln(f,ii); axa.angle:=ii;
  Readln(f,ii); axa.adpt:=ii;
  Readln(f,ff); axa.ax:=ff;
  Readln(f,ff); axa.ay:=ff;
  Readln(f,ff); axa.az:=ff;
  Readln(f,ii); axa.nd1:=ii;
  Readln(f,ii); axa.nd2:=ii;
  Readln(f,ii); axa.nd3:=ii;
  SetLength(axa.disc_1,axa.nd1+1);
  SetLength(axa.disc_2,axa.nd2+1);
  SetLength(axa.disc_3,axa.nd3+1);
  for i:=1 to axa.nd1 do begin Readln(f,f1,f2); axa.disc_1[i].num:=f1; axa.disc_1[i].val:=f2; end;
  for i:=1 to axa.nd2 do begin Readln(f,f1,f2); axa.disc_2[i].num:=f1; axa.disc_2[i].val:=f2; end;
  for i:=1 to axa.nd3 do begin Readln(f,f1,f2); axa.disc_3[i].num:=f1; axa.disc_3[i].val:=f2; end;
  CloseFile(f);
{$I+}
  if IOResult<>0 then
  begin
    prError:=true;
    ShowMessage('There were errors during calculations');
  end;
end;

procedure a_UnLoadProject;
begin
  bnd2:=nil;
  bnd3:=nil;
  Nbnd2:=0;
  Nbnd3:=0;
  if axa<>nil then begin axa.Delete; axa.Free; axa:=nil; end;
  if tt<>nil then begin tt.ReleaseVars; tt.Free; tt:=nil; end;
  if mt<>nil then begin mt.Free; mt:=nil end;
  if ob<>nil then begin ob.Clear; ob.Free; ob:=nil end;
  Task:=-1;
end;

procedure a_SaveProject(s:string);
var f:TextFile;
    i:int;
    k:byte;
    mg:TMgObject;
    sec:TSector;
    blc:tBlock;
begin
  // saving information
  AssignFile(f,s);
  Rewrite(f);
  WriteLn(f,verID);
  WriteLn(f,'Magnum3d');
  WriteLn(f,Task);
  // axial parameters  (2d mesh)
  WriteLn(f,'Axial_2d');
  WriteLn(f,tt.angle);
  WriteLn(f,tt.sort_d);
  WriteLn(f,tt.sort_t);
  WriteLn(f,tt.sort_ex);
  WriteLn(f,tt.ax);
  WriteLn(f,tt.az);
  WriteLn(f,tt.nd1);
  WriteLn(f,tt.nd2);
  for i:=1 to tt.nd1 do WriteLn(f,tt.disc_1[i].num,' ',tt.disc_1[i].val);
  for i:=1 to tt.nd2 do WriteLn(f,tt.disc_2[i].num,' ',tt.disc_2[i].val);
  WriteLn(f,tt.defMat);
  // material parameters
  WriteLn(f,'Material');
  WriteLn(f,mt.nMaterials);
  WriteLn(f,mt.DefaultMaterial);
  WriteLn(f,mt.Frequency);
  for i:=0 to mt.nMaterials-1 do
  begin
    WriteLn(f,mt.Anisotropy_X[i]);
    WriteLn(f,mt.Anisotropy_Y[i]);
    WriteLn(f,mt.Anisotropy_Z[i]);
    WriteLn(f,mt.Epsilon[i]);
    WriteLn(f,mt.MuProperty[i]);
    WriteLn(f,mt.Sigma[i]);
    WriteLn(f,mt.mmName[i]);
    WriteLn(f,mt.mmColor[i]);
  end;
  // object parameters
  WriteLn(f,'_Objects');
  WriteLn(f,ob.Count);
  for i:=0 to ob.Count-1 do
  begin
    mg:=TMgObject(ob.Items[i]);
    WriteLn(f,mg.Name);
    WriteLn(f,mg.iMaterial);
    if mg is TBlock then
    begin
      blc:=TBlock(ob.Items[i]);
      k:=1;
      WriteLn(f,k);
      WriteLn(f,blc.x_1);
      WriteLn(f,blc.x_2);
      WriteLn(f,blc.y_1);
      WriteLn(f,blc.y_2);
      WriteLn(f,blc.z_1);
      WriteLn(f,blc.z_2);
    end
    else
    begin
      sec:=TSector(ob.Items[i]);
      k:=2;
      WriteLn(f,k);
      WriteLn(f,sec.xx);
      WriteLn(f,sec.yy);
      WriteLn(f,sec.zz);
      WriteLn(f,sec.r1);
      WriteLn(f,sec.r2);
      WriteLn(f,sec.h);
      WriteLn(f,sec.al);
      WriteLn(f,sec.bt);
      WriteLn(f,sec.ax_dir);
    end;
    WriteLn(f,mg.sr_1);
    WriteLn(f,mg.sr_2);
    WriteLn(f,mg.sr_3);
    WriteLn(f,mg.sr_4);
    WriteLn(f,mg.sr_kind);
  end;
  // bounds 2d
  WriteLn(f,'Bound_2d');
  WriteLn(f,Nbnd2);
  for i:=0 to Nbnd2-1 do
  begin
    WriteLn(f,bnd2[i].x1);
    WriteLn(f,bnd2[i].x2);
    WriteLn(f,bnd2[i].z1);
    WriteLn(f,bnd2[i].z2);
    WriteLn(f,bnd2[i].val);
    WriteLn(f,bnd2[i].vl_im);
    WriteLn(f,bnd2[i].nm);
  end;
  // bounds 3d
  WriteLn(f,'Bound_3d');
  WriteLn(f,Nbnd3);
  for i:=0 to Nbnd3-1 do
  begin
    WriteLn(f,bnd3[i].x1);
    WriteLn(f,bnd3[i].x2);
    WriteLn(f,bnd3[i].y1);
    WriteLn(f,bnd3[i].y2);
    WriteLn(f,bnd3[i].z1);
    WriteLn(f,bnd3[i].z2);
    WriteLn(f,bnd3[i].dir);
    WriteLn(f,bnd3[i].val);
    WriteLn(f,bnd3[i].vl_im);
    WriteLn(f,bnd3[i].nm);
  end;
  // 3d discretization
  WriteLn(f,'3d-discretization');
  WriteLn(f,axa.angle);
  WriteLn(f,axa.adpt);
  WriteLn(f,axa.ax);
  WriteLn(f,axa.ay);
  WriteLn(f,axa.az);
  WriteLn(f,axa.nd1);
  WriteLn(f,axa.nd2);
  WriteLn(f,axa.nd3);
  for i:=1 to axa.nd1 do WriteLn(f,axa.disc_1[i].num,' ',axa.disc_1[i].val);
  for i:=1 to axa.nd2 do WriteLn(f,axa.disc_2[i].num,' ',axa.disc_2[i].val);
  for i:=1 to axa.nd3 do WriteLn(f,axa.disc_3[i].num,' ',axa.disc_3[i].val);
  ///////////////////////////
  WriteLn(f,'Copyright (c) Zhdanov Andrew. Andrew Inc. 2002.',47);
  CloseFile(f);
end;

procedure a_LoadEmptyProject;
var i:int;
begin
  ClearParams;
  if axa<>nil then begin axa.Delete; axa.Free; axa:=nil; end;
  if tt<>nil then begin tt.ReleaseVars; tt.Free; tt:=nil; end;
  if mt<>nil then begin mt.Free; mt:=nil end;
  if ob<>nil then begin ob.Clear; ob.Free; ob:=nil end;
  mt:=TMaterials.Create();
  tt:=TFlatTask.Create();
  axa:=TAxialTask3.Create();
  ob:=TList.Create();
  ob.Capacity:=10;
  Task:=-1;
  // bound 2d
  bnd2:=nil;
  Nbnd2:=0;
  // bound 3d
  bnd3:=nil;
  Nbnd3:=0;
  // materials
  mt.nMaterials:=2;
  mt.DefaultMaterial:=0;
  mt.Frequency:=0.0;
  mt.ChangeNum;
  for i:=0 to mt.nMaterials-1 do
  begin
    mt.mmName[i]:='Material - '+IntToStr(i);
    mt.mmColor[i]:=clWhite;
    mt.Anisotropy_X[i]:=1;
    mt.Anisotropy_Y[i]:=1;
    mt.Anisotropy_Z[i]:=1;
    mt.Epsilon[i]:=1;
    mt.MuProperty[i]:=1;
    mt.Sigma[i]:=1e-20;
    mt.nlProperty[i]:=0;
    mt.nlFile[i]:='';
  end;
  // parameters
  SetDefaultParams;
  // end
end;

procedure a_LoadMainData;
var f:TextFile;
    k:byte;
    i:int;
begin
  _v1:=true;
  _v2:=true;
  _v3:=false;
  _v4:=false;
  _v5:=true;
  tic:=6;
  if not FileExists(RootDir+'magnum_a.dat') then exit;
  AssignFile(f,RootDir+'magnum_a.dat');
  Reset(f);
  readln(f);
  readln(f);
  readln(f,k); wTPR:=TThreadPriority(k);
  readln(f);
  readln(f,k);wAuto_StartS:=Boolean(k);
  readln(f,k);wAuto_CloseS:=Boolean(k);
  readln(f,k);wSaveTop:=Boolean(k);
  readln(f,k);wHide:=Boolean(k);
  readln(f,k);wSeparator:=k;
  readln(f);
  readln(f,i); _v1:=boolean(i);
  readln(f,i); _v2:=boolean(i);
  readln(f,i); _v3:=boolean(i);
  readln(f,i); _v4:=boolean(i);
  readln(f,i); _v5:=boolean(i);
  readln(f);
  readln(f,tic);
  CloseFile(f);
end;

procedure a_SaveMainData;
var f:TextFile;
begin
  AssignFile(f,RootDir+'magnum_a.dat');
  ReWrite(f);
  writeln(f,'Magnum system data file');
  writeln(f);
  writeln(f,ord(wTPR));
  writeln(f);
  writeln(f,ord(wAuto_StartS));
  writeln(f,ord(wAuto_CloseS));
  writeln(f,ord(wSaveTop));
  writeln(f,ord(wHide));
  writeln(f,wSeparator);
  writeln(f);
  writeln(f,ord(_v1));
  writeln(f,ord(_v2));
  writeln(f,ord(_v3));
  writeln(f,ord(_v4));
  writeln(f,ord(_v5));
  writeln(f);
  writeln(f,tic);
  writeln(f);
  CloseFile(f);
end;


////////////////////////////////////////////////////////////////////////////////
/////////////////////////////  2d parameters  //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
procedure a_SaveNodes2;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'nodes2.txt');
  Rewrite(f);
  with tt do
  for i:=1 to NNodes do
  begin
    write(f,i:4,'). ');
    write(f,' x = ');
    if Nodes[i][1]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Nodes[i][1]):10:6);
    write(f,'        z = ');
    if Nodes[i][2]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Nodes[i][2]):10:6);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveTopology2;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'topology2.txt');
  Rewrite(f);
  with tt do
  for i:=1 to NTriangles do
  begin
    write(f,i:4,'). ');
    writeln(f,'Material-',Topology[i][0]);
    writeln(f,' ':10,'(1):',Topology[i][1]:4);
    writeln(f,' ':10,'(2):',Topology[i][2]:4);
    writeln(f,' ':10,'(3):',Topology[i][3]:4);
  end;
  CloseFile(f);
end;

procedure a_SaveSources2;
var
  fj,fbx,fbz,fr:TextFile;
  i:int;
begin
  AssignFile(fj,'sources2_J.txt');
  AssignFile(fbx,'sources2_Bx.txt');
  AssignFile(fbz,'sources2_Bz.txt');
  AssignFile(fr,'sources2_Ro.txt');
  Rewrite(fj);
  Rewrite(fbx);
  Rewrite(fbz);
  Rewrite(fr);
  with tt do
  for i:=1 to NSources do
  begin
    write(fj,' number = ');
    write(fj,Sources[i].num:5);
    write(fj,'        value = ');
    if Sources[i].val_J>0 then write(fj,' ') else write(fj,'-');
    write(fj,Abs(Sources[i].val_J):10:6);
    writeln(fj);
    ///
    write(fbx,' number = ');
    write(fbx,Sources[i].num:5);
    write(fbx,'        value = ');
    if Sources[i].val_Bx>0 then write(fbx,' ') else write(fbx,'-');
    write(fbx,Abs(Sources[i].val_Bx):10:6);
    writeln(fbx);
    ///
    write(fbz,' number = ');
    write(fbz,Sources[i].num:5);
    write(fbz,'        value = ');
    if Sources[i].val_Bz>0 then write(fbz,' ') else write(fbz,'-');
    write(fbz,Abs(Sources[i].val_Bz):10:6);
    writeln(fbz);
    ///
    write(fr,' number = ');
    write(fr,Sources[i].num:5);
    write(fr,'        value = ');
    if Sources[i].val_Ro>0 then write(fr,' ') else write(fr,'-');
    write(fr,Abs(Sources[i].val_Ro):10:6);
    writeln(fr);
  end;
  CloseFile(fj);
  CloseFile(fbx);
  CloseFile(fbz);
  CloseFile(fr);
end;

procedure a_SaveBounds2_re;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'bounds2.txt');
  Rewrite(f);
  with TFlatSSTask(tt) do
  for i:=1 to NBounds do
  begin
    write(f,i:4,'). ');
    write(f,' number = ');
    write(f,Bounds[i].num:5);
    write(f,'        value = ');
    if Bounds[i].val>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Bounds[i].val):10:6);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveBounds2_cx;
var
  f:TextFile;
  i:integer;
begin
  AssignFile(f,'bounds2.txt');
  Rewrite(f);
  with TFlatECTask(tt) do
  for i:=1 to NBounds do
  begin
    write(f,i:4,'). ');
    write(f,' number = ');
    write(f,Bounds[i].num:5);
    write(f,'        value = ');
    write(f,i:4,'). ');
    if Bounds[i].val.Re>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(Bounds[i].val.Re):15);
    if Bounds[i].val.Im>0 then
      write(f,'+ j')
    else
      write(f,'- j');
    write(f,Abs(Bounds[i].val.Im):15);
    write(f,'    ',CAbs(Bounds[i].val):15);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveRSide_re;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'rSide2.txt');
  Rewrite(f);
  with TFlatSSTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,'). ');
    if RightSide[i]>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(RightSide[i]):15);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveRSide_cx;
var
  f:TextFile;
  i:integer;
begin
  AssignFile(f,'rSide2.txt');
  Rewrite(f);
  with TFlatECTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,'). ');
    if RightSide[i].Re>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(RightSide[i].Re):15);
    if RightSide[i].Im>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(RightSide[i].Im):15);
    write(f,'     ',CAbs(RightSide[i]):15);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveMatrix2_re;
var
  f:TextFile;
  i,j:int;
  p:double;
begin
  AssignFile(f,'Matrix2.txt');
  Rewrite(f);
  with TFlatSSTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,').');
    write(f,' ':4,'"',NumberConnect[i,1]:2,'"   ');
    if Matrix[i,1]>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(Matrix[i,1]):15);
    writeln(f);
    ///////////
    p:=0.0;
    for j:=2 to NumberConnect[i,1] do
      p:=p+Matrix[i,j];
    write(f,' ':14,'!  ');
    if p>0 then write(f,' ') else write(f,'-');
    write(f,Abs(p):15);
    writeln(f);
    ///////////
    writeln(f);
    for j:=2 to NumberConnect[i,1] do
    begin
      write(f,' ':10,'<',NumberConnect[i,j]:2,'>   ');
      if Matrix[i,j]>0 then
        write(f,' ')
      else
        write(f,'-');
      write(f,Abs(Matrix[i,j]):15);
      writeln(f);
    end;
    writeln(f);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveMatrix2_cx;
var
  f:TextFile;
  i,j:integer;
  p:TComplex;
begin
  AssignFile(f,'Matrix2.txt');
  Rewrite(f);
  with TFlatECTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,').');
    write(f,' ':4,'"',NumberConnect[i,1]:2,'"   ');
    if Matrix[i,1].Re>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(Matrix[i,1].Re):15);
    if Matrix[i,1].Im>0 then
      write(f,'+j')
    else
      write(f,'-j');
    write(f,Abs(Matrix[i,1].Im):15);
    write(f,' ':10,CAbs(Matrix[i,1]):15);
    writeln(f);
    ///////////
    p:=CNull;
    for j:=2 to NumberConnect[i,1] do
      p:=CAdd(p,Matrix[i,j]);
    write(f,' ':14,'!  ');
    if p.Re>0 then write(f,' ') else write(f,'-');
    write(f,Abs(p.Re):15);
    if p.Im>0 then write(f,'+j') else write(f,'-j');
    write(f,Abs(p.Im):15);
    write(f,' ':10,CAbs(p):15);
    writeln(f);
    ///////////
    writeln(f);
    for j:=2 to NumberConnect[i,1] do
    begin
      write(f,' ':10,'<',NumberConnect[i,j]:2,'>   ');
      if Matrix[i,j].Re>0 then
        write(f,' ')
      else
        write(f,'-');
      write(f,Abs(Matrix[i,j].Re):15);
      if Matrix[i,j].Im>0 then
        write(f,'+j')
      else
        write(f,'-j');
      write(f,Abs(Matrix[i,j].Im):15);
      write(f,' ':10,CAbs(Matrix[i,j]):15);
      writeln(f);
    end;
    writeln(f);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveResult2_sc;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'result2.txt');
  Rewrite(f);
  with TFlatELTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,'). ');
    if Vmatr[i]>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(Vmatr[i]):15);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveResult2_re;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'result2.txt');
  Rewrite(f);
  with TFlatSSTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,'). ');
    if Vmatr[i]>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(Vmatr[i]):15);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveResult2_cx;
var
  f:TextFile;
  i:integer;
begin
  AssignFile(f,'result2.txt');
  Rewrite(f);
  with TFlatECTask(tt) do
  for i:=1 to NNodes do
  begin
    write(f,i:4,'). ');
    if Vmatr[i].Re>0 then
      write(f,' ')
    else
      write(f,'-');
    write(f,Abs(Vmatr[i].Re):15);
    if Vmatr[i].Im>0 then
      write(f,'+j')
    else
      write(f,'-j');
    write(f,Abs(Vmatr[i].Im):15);
    write(f,'     ',CAbs(Vmatr[i]):15);
    writeln(f);
  end;
  CloseFile(f);
end;


////////////////////////////////////////////////////////////////////////////////
/////////////////////////////  3d parameters  //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
procedure a_SavePoints3;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'points3.txt');
  Rewrite(f);
  for i:=1 to NPoints do
  begin
    write(f,i:4,'). ');
    write(f,' x = ');
    if Crd_X[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Crd_X[i]):10:6);
    write(f,'     y = ');
    if Crd_Y[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Crd_Y[i]):10:6);
    write(f,'     z = ');
    if Crd_Z[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Crd_Z[i]):10:6);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveTopology3;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'topology3.txt');
  Rewrite(f);
  for i:=1 to NElements do
  begin
    write(f,i:4,'). ');
    writeln(f,'Material-',ATopology[i][0]);
    writeln(f,' ':20,'(1):',ATopology[i][1]:4);
    writeln(f,' ':20,'(2):',ATopology[i][2]:4);
    writeln(f,' ':20,'(3):',ATopology[i][3]:4);
    writeln(f,' ':20,'(4):',ATopology[i][4]:4);
  end;
  CloseFile(f);
end;

procedure a_SaveSources3;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'source3.txt');
  Rewrite(f);
  for i:=1 to NSources do
  begin
    write(f,i:4,'). ');
    write(f,' number = ');
    write(f,NumberSource[i]:5);
    write(f,'        value = ');
    if Source_X[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Source_X[i]):10:6,#09);
    if Source_Y[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Source_Y[i]):10:6,#09);
    if Source_Z[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(Source_Z[i]):10:6);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveBounds3;
var
  f:TextFile;
  i:int;
begin
  AssignFile(f,'bounds3.txt');
  Rewrite(f);
  for i:=1 to NBounds do
  begin
    write(f,i:4,'). ');
    write(f,' number = ');
    write(f,NumberBound[i]:5);
    write(f,'        value = ');
    if PotentialBound[i]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(PotentialBound[i]):10:6);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveRSide3;
var
  f:TextFile;
  i:int;
begin
  if RightSide<>nil then
  begin
    AssignFile(f,'rSide3_sc.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide[i]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
  if RightSide_X<>nil then
  begin
    AssignFile(f,'rSide3_x.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide_X[i]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide_X[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
  if RightSide_y<>nil then
  begin
    AssignFile(f,'rSide3_y.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide_y[i]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide_y[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
  if RightSide_z<>nil then
  begin
    AssignFile(f,'rSide3_z.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide_z[i]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide_Z[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
  if RightSide_Xc<>nil then
  begin
    AssignFile(f,'rSide3_xc.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide_Xc[i].Re>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide_Xc[i].Re):15,' ':5);
      if RightSide_Xc[i].Im>0 then write(f,' j') else write(f,'-j');
      write(f,Abs(RightSide_Xc[i].Im):15,' ':5);
      write(f,CAbs(RightSide_Xc[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
  if RightSide_yc<>nil then
  begin
    AssignFile(f,'rSide3_yc.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide_Yc[i].Re>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide_Yc[i].Re):15,' ':5);
      if RightSide_Yc[i].Im>0 then write(f,' j') else write(f,'-j');
      write(f,Abs(RightSide_Yc[i].Im):15,' ':5);
      write(f,CAbs(RightSide_Yc[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
  if RightSide_zc<>nil then
  begin
    AssignFile(f,'rSide3_zc.txt');
    Rewrite(f);
    for i:=1 to NPoints do
    begin
      write(f,i:4,'). ');
      if RightSide_Zc[i].Re>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RightSide_Zc[i].Re):15,' ':5);
      if RightSide_Zc[i].Im>0 then write(f,' j') else write(f,'-j');
      write(f,Abs(RightSide_Zc[i].Im):15,' ':5);
      write(f,CAbs(RightSide_Zc[i]):15);
      writeln(f);
    end;
    CloseFile(f);
  end;
end;

procedure a_SaveMatrix3;
var
  f:TextFile;
  i,j:int;
  p:double;
begin
  if ScalarMatrix=nil then exit;
  AssignFile(f,'Matrix3.txt');
  Rewrite(f);
  for i:=1 to NPoints do
  begin
    write(f,i:4,').');
    write(f,' ':4,'"',NumberConnect[i,1]:2,'"   ');
    if ScalarMatrix[i,1]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(ScalarMatrix[i,1]):15);
    writeln(f);
    ///////////
    p:=0.0;
    for j:=2 to NumberConnect[i,1] do
      p:=p+ScalarMatrix[i,j];
    write(f,' ':14,'!  ');
    if p>0 then write(f,' ') else write(f,'-');
    write(f,Abs(p):15);
    writeln(f);
    ///////////
    writeln(f);
    for j:=2 to NumberConnect[i,1] do
    begin
      write(f,' ':10,'<',NumberConnect[i,j]:2,'>   ');
      if ScalarMatrix[i,j]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(ScalarMatrix[i,j]):15);
      writeln(f);
    end;
    writeln(f);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveMatrix3_re;
var
  f:TextFile;
  i,j:int;
  p:double;
begin
  if RealMatrix_X=nil then exit;
  if RealMatrix_Y=nil then exit;
  if RealMatrix_Z=nil then exit;
  AssignFile(f,'Matrix3_x.txt');
  Rewrite(f);
  for i:=1 to NPoints do
  begin
    write(f,i:4,').');
    write(f,' ':4,'"',NumberConnect[i,1]:2,'"   ');
    if RealMatrix_x[i,1]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(RealMatrix_x[i,1]):15);
    writeln(f);
    ///////////
    p:=0.0;
    for j:=2 to NumberConnect[i,1] do
      p:=p+RealMatrix_x[i,j];
    write(f,' ':14,'!  ');
    if p>0 then write(f,' ') else write(f,'-');
    write(f,Abs(p):15);
    writeln(f);
    ///////////
    writeln(f);
    for j:=2 to NumberConnect[i,1] do
    begin
      write(f,' ':10,'<',NumberConnect[i,j]:2,'>   ');
      if RealMatrix_x[i,j]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RealMatrix_x[i,j]):15);
      writeln(f);
    end;
    writeln(f);
    writeln(f);
  end;
  CloseFile(f);
  AssignFile(f,'Matrix3_y.txt');
  Rewrite(f);
  for i:=1 to NPoints do
  begin
    write(f,i:4,').');
    write(f,' ':4,'"',NumberConnect[i,1]:2,'"   ');
    if RealMatrix_y[i,1]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(RealMatrix_y[i,1]):15);
    writeln(f);
    ///////////
    p:=0.0;
    for j:=2 to NumberConnect[i,1] do
      p:=p+RealMatrix_y[i,j];
    write(f,' ':14,'!  ');
    if p>0 then write(f,' ') else write(f,'-');
    write(f,Abs(p):15);
    writeln(f);
    ///////////
    writeln(f);
    for j:=2 to NumberConnect[i,1] do
    begin
      write(f,' ':10,'<',NumberConnect[i,j]:2,'>   ');
      if RealMatrix_y[i,j]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RealMatrix_y[i,j]):15);
      writeln(f);
    end;
    writeln(f);
    writeln(f);
  end;
  CloseFile(f);
  AssignFile(f,'Matrix3_z.txt');
  Rewrite(f);
  for i:=1 to NPoints do
  begin
    write(f,i:4,').');
    write(f,' ':4,'"',NumberConnect[i,1]:2,'"   ');
    if RealMatrix_z[i,1]>0 then write(f,' ') else write(f,'-');
    write(f,Abs(RealMatrix_z[i,1]):15);
    writeln(f);
    ///////////
    p:=0.0;
    for j:=2 to NumberConnect[i,1] do
      p:=p+RealMatrix_z[i,j];
    write(f,' ':14,'!  ');
    if p>0 then write(f,' ') else write(f,'-');
    write(f,Abs(p):15);
    writeln(f);
    ///////////
    writeln(f);
    for j:=2 to NumberConnect[i,1] do
    begin
      write(f,' ':10,'<',NumberConnect[i,j]:2,'>   ');
      if RealMatrix_z[i,j]>0 then write(f,' ') else write(f,'-');
      write(f,Abs(RealMatrix_z[i,j]):15);
      writeln(f);
    end;
    writeln(f);
    writeln(f);
  end;
  CloseFile(f);
end;

procedure a_SaveMatrix3_cx;
begin
end;

procedure a_SaveResult3;
begin
end;


{==============================================================================}
{==============================================================================}
procedure a_LoadResults(iTask:byte;flKind:byte);
begin
  ResultSc:=nil;
  Result_x:=nil;
  Result_y:=nil;
  Result_z:=nil;
  Result_Xc:=nil;
  Result_Yc:=nil;
  Result_Zc:=nil;
  Case iTask of
    0..2:begin
        SetLength(ResultSc,NPoints+1);
        Case flKind of
          0:a_LoadDataFile('sresult.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));     // full
          1:a_LoadDataFile('sresult_ax.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));  // axial
          2:a_LoadDataFile('sresult_def.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0])); // defect
        end;
      end;
    3:begin
        SetLength(Result_X,NPoints+1);
        SetLength(Result_Y,NPoints+1);
        SetLength(Result_Z,NPoints+1);
        Case flKind of
          0:begin
            a_LoadDataFile('resultx.dat',Result_X[0],(NPoints+1)*SizeOf(Result_X[0]));
            a_LoadDataFile('resulty.dat',Result_Y[0],(NPoints+1)*SizeOf(Result_Y[0]));
            a_LoadDataFile('resultz.dat',Result_Z[0],(NPoints+1)*SizeOf(Result_Z[0]));
            end;
          1:begin
            a_LoadDataFile('resultx_ax.dat',Result_X[0],(NPoints+1)*SizeOf(Result_X[0]));
            a_LoadDataFile('resulty_ax.dat',Result_Y[0],(NPoints+1)*SizeOf(Result_Y[0]));
            a_LoadDataFile('resultz_ax.dat',Result_Z[0],(NPoints+1)*SizeOf(Result_Z[0]));
            end;
          2:begin
            a_LoadDataFile('resultx_def.dat',Result_X[0],(NPoints+1)*SizeOf(Result_X[0]));
            a_LoadDataFile('resulty_def.dat',Result_Y[0],(NPoints+1)*SizeOf(Result_Y[0]));
            a_LoadDataFile('resultz_def.dat',Result_Z[0],(NPoints+1)*SizeOf(Result_Z[0]));
            end;
        end;
      end;
    5:begin
        SetLength(Result_Xc,NPoints+1);
        SetLength(Result_Yc,NPoints+1);
        SetLength(Result_Zc,NPoints+1);
        Case flKind of
          0:begin
            a_LoadDataFile('cresultx.dat',Result_Xc[0],(NPoints+1)*SizeOf(Result_Xc[0]));
            a_LoadDataFile('cresulty.dat',Result_Yc[0],(NPoints+1)*SizeOf(Result_Yc[0]));
            a_LoadDataFile('cresultz.dat',Result_Zc[0],(NPoints+1)*SizeOf(Result_Zc[0]));
            end;
          1:begin
            a_LoadDataFile('cresultx_ax.dat',Result_Xc[0],(NPoints+1)*SizeOf(Result_Xc[0]));
            a_LoadDataFile('cresulty_ax.dat',Result_Yc[0],(NPoints+1)*SizeOf(Result_Yc[0]));
            a_LoadDataFile('cresultz_ax.dat',Result_Zc[0],(NPoints+1)*SizeOf(Result_Zc[0]));
            end;
          2:begin
            a_LoadDataFile('cresultx_def.dat',Result_Xc[0],(NPoints+1)*SizeOf(Result_Xc[0]));
            a_LoadDataFile('cresulty_def.dat',Result_Yc[0],(NPoints+1)*SizeOf(Result_Yc[0]));
            a_LoadDataFile('cresultz_def.dat',Result_Zc[0],(NPoints+1)*SizeOf(Result_Zc[0]));
            end;
        end;
      end;
  end;
end;

procedure a_SaveResults(iTask:byte;flKind:byte);
begin
  Case iTask of
    0..2:Case flKind of
        0:a_SaveDataFile('sresult.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));
        1:a_SaveDataFile('sresult_ax.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));
        2:a_SaveDataFile('sresult_def.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));
      end;
    3:Case flKind of
        0:begin
           a_SaveDataFile('resultx.dat',Result_X[0],(NPoints+1)*SizeOf(Result_X[0]));
            a_SaveDataFile('resulty.dat',Result_Y[0],(NPoints+1)*SizeOf(Result_Y[0]));
            a_SaveDataFile('resultz.dat',Result_Z[0],(NPoints+1)*SizeOf(Result_Z[0]));
          end;
        1:begin
            a_SaveDataFile('resultx_ax.dat',Result_X[0],(NPoints+1)*SizeOf(Result_X[0]));
            a_SaveDataFile('resulty_ax.dat',Result_Y[0],(NPoints+1)*SizeOf(Result_Y[0]));
            a_SaveDataFile('resultz_ax.dat',Result_Z[0],(NPoints+1)*SizeOf(Result_Z[0]));
          end;
        2:begin
            a_SaveDataFile('resultx_def.dat',Result_X[0],(NPoints+1)*SizeOf(Result_X[0]));
            a_SaveDataFile('resulty_def.dat',Result_Y[0],(NPoints+1)*SizeOf(Result_Y[0]));
            a_SaveDataFile('resultz_def.dat',Result_Z[0],(NPoints+1)*SizeOf(Result_Z[0]));
          end;
      end;
    5:Case flKind of
        0:begin
            a_SaveDataFile('cresultx.dat',Result_Xc[0],(NPoints+1)*SizeOf(Result_Xc[0]));
            a_SaveDataFile('cresulty.dat',Result_Yc[0],(NPoints+1)*SizeOf(Result_Yc[0]));
            a_SaveDataFile('cresultz.dat',Result_Zc[0],(NPoints+1)*SizeOf(Result_Zc[0]));
          end;
        1:begin
            a_SaveDataFile('cresultx_ax.dat',Result_Xc[0],(NPoints+1)*SizeOf(Result_Xc[0]));
            a_SaveDataFile('cresulty_ax.dat',Result_Yc[0],(NPoints+1)*SizeOf(Result_Yc[0]));
            a_SaveDataFile('cresultz_ax.dat',Result_Zc[0],(NPoints+1)*SizeOf(Result_Zc[0]));
          end;
        2:begin
            a_SaveDataFile('cresultx_def.dat',Result_Xc[0],(NPoints+1)*SizeOf(Result_Xc[0]));
            a_SaveDataFile('cresulty_def.dat',Result_Yc[0],(NPoints+1)*SizeOf(Result_Yc[0]));
            a_SaveDataFile('cresultz_def.dat',Result_Zc[0],(NPoints+1)*SizeOf(Result_Zc[0]));
          end;
      end;
  end;
end;

{==============================================================================}
{===============================  END OF FILES  ===============================}
{==============================================================================}
procedure a_LoadProject_2(s:string);
var f:File;
    i:int;
    //s1:st8;
    s1: array[1..8]of byte;
    s80:st80;
    k,g:byte;
    ff:float;
    ii,j:int;
    cl:TColor;
    step:TStep;
    sz,si:int;
begin
{$I-}
  sz:=SizeOf(float);
  si:=SizeOf(int);
  prError:=false;
  if axa<>nil then begin axa.Delete; axa.Free; axa:=nil; end;
  if tt<>nil then begin tt.ReleaseVars; tt.Free; tt:=nil; end;
  if mt<>nil then begin mt.Free; mt:=nil end;
  if ob<>nil then begin ob.Clear; ob.Free; ob:=nil end;
  Task:=-1;
  // bound 2d
  bnd2:=nil;
  Nbnd2:=0;
  // loading information
  AssignFile(f,s);
  Reset(f,1);
  BlockRead(f,k,1);
  if k<>VerID then
  begin
    ShowMessage('Illegal file version number !!!');
    prError:=true;
    exit;
  end;
  BlockRead(f,s1,9);
  BlockRead(f,ii,4);  Task:=ii;
  ///////////////////////
  mt:=TMaterials.Create();
  Case Task of
    0..2:tt:=TFlatELTask.Create();
    3:tt:=TFlatSSTask.Create();
    5:tt:=TFlatECTask.Create();
  end;
  axa:=TAxialTask3.Create();
  ob:=TList.Create();
  ob.Capacity:=10;
  // axial parameters  (2d mesh)
  BlockRead(f,s1,9);
  BlockRead(f,k,1);  tt.angle:=k;
  BlockRead(f,k,1);  tt.sort_d:=k;
  BlockRead(f,k,1);  tt.sort_t:=k;
  BlockRead(f,k,1);  tt.sort_ex:=k;
  BlockRead(f,ff,sz);  tt.ax:=ff;
  BlockRead(f,ff,sz);  tt.az:=ff;
  BlockRead(f,ii,si);  tt.nd1:=ii;
  BlockRead(f,ii,si);  tt.nd2:=ii;
  SetLength(tt.disc_1,tt.nd1+1);
  SetLength(tt.disc_2,tt.nd2+1);
  for i:=1 to tt.nd1 do begin BlockRead(f,step,SizeOf(TStep)); tt.disc_1[i]:=step; end;
  for i:=1 to tt.nd2 do begin BlockRead(f,step,SizeOf(TStep)); tt.disc_2[i]:=step; end;
  BlockRead(f,ii,si); tt.defMat:=ii;
  // material parameters
  BlockRead(f,s1,9);
  BlockRead(f,ii,si);  mt.nMaterials:=ii;
  mt.ChangeNum;
  BlockRead(f,ii,si);  mt.DefaultMaterial:=ii;
  BlockRead(f,ff,sz);  mt.Frequency:=ff;
  for i:=0 to mt.nMaterials-1 do
  begin
    BlockRead(f,ff,sz); mt.Anisotropy_X[i]:=ff;
    BlockRead(f,ff,sz); mt.Anisotropy_Y[i]:=ff;
    BlockRead(f,ff,sz); mt.Anisotropy_Z[i]:=ff;
    BlockRead(f,ff,sz); mt.Epsilon[i]:=ff;
    BlockRead(f,ff,sz); mt.MuProperty[i]:=ff;
    BlockRead(f,ff,sz); mt.Sigma[i]:=ff;
    BlockRead(f,s80,80);mt.mmName[i]:=s80;
    BlockRead(f,cl,SizeOf(TColor)); mt.mmColor[i]:=cl;
    BlockRead(f,ii,si); mt.nlProperty[i]:=ii;
    BlockRead(f,s80,80);mt.nlFile[i]:=s80;
  end;
  // object parameters
  BlockRead(f,s1,9);
  BlockRead(f,ii,si);
  for i:=0 to ii-1 do
  begin
    BlockRead(f,s80,80);
    BlockRead(f,j,si);
    BlockRead(f,k,1);
    if k=1 then // block;
    begin
      ob.Add(TBlock.Create(j,s80));
      with TBlock(ob.Items[i]) do
      begin
        BlockRead(f,ff,sz);  x_1:=ff;
        BlockRead(f,ff,sz);  x_2:=ff;
        BlockRead(f,ff,sz);  y_1:=ff;
        BlockRead(f,ff,sz);  y_2:=ff;
        BlockRead(f,ff,sz);  z_1:=ff;
        BlockRead(f,ff,sz);  z_2:=ff;
      end;
    end
    else if k=2 then       // sector
    begin
      ob.Add(TSector.Create(j,s80));
      with TSector(ob.Items[i]) do
      begin
        BlockRead(f,ff,sz);  xx:=ff;
        BlockRead(f,ff,sz);  yy:=ff;
        BlockRead(f,ff,sz);  zz:=ff;
        BlockRead(f,ff,sz);  r1:=ff;
        BlockRead(f,ff,sz);  r2:=ff;
        BlockRead(f,ff,sz);  h:=ff;
        BlockRead(f,ff,sz);  al:=ff;
        BlockRead(f,ff,sz);  bt:=ff;
        BlockRead(f,g,1);    ax_dir:=g;
      end;
    end
    else if k=3 then
    begin
      ob.Add(TTriBlock.Create(j,s80));
      with TTriBlock(ob.Items[i]) do
      begin
        BlockRead(f,ff,sz);  x1:=ff;
        BlockRead(f,ff,sz);  x2:=ff;
        BlockRead(f,ff,sz);  x3:=ff;
        BlockRead(f,ff,sz);  z1:=ff;
        BlockRead(f,ff,sz);  z2:=ff;
        BlockRead(f,ff,sz);  z3:=ff;
        BlockRead(f,ff,sz);  y_min:=ff;
        BlockRead(f,ff,sz);  y_max:=ff;
      end;
    end
    else if k=4 then
    begin
      ob.Add(TTriSec.Create(j,s80));
      with TTriSec(ob.Items[i]) do
      begin
        BlockRead(f,ff,sz);  x1:=ff;
        BlockRead(f,ff,sz);  x2:=ff;
        BlockRead(f,ff,sz);  x3:=ff;
        BlockRead(f,ff,sz);  z1:=ff;
        BlockRead(f,ff,sz);  z2:=ff;
        BlockRead(f,ff,sz);  z3:=ff;
        BlockRead(f,ff,sz);  al:=ff;
        BlockRead(f,ff,sz);  bt:=ff;
      end;
    end;
    with TMgObject(ob.Items[i]) do
    begin
      BlockRead(f,ff,sz);  sr_1:=ff;
      BlockRead(f,ff,sz);  sr_2:=ff;
      BlockRead(f,ff,sz);  sr_3:=ff;
      BlockRead(f,ff,sz);  sr_4:=ff;
      BlockRead(f,k,1);    sr_kind:=k;
    end;
  end;
  // bounds 2d
  BlockRead(f,s1,9);
  BlockRead(f,Nbnd2,si);
  SetLength(bnd2,Nbnd2);
  for i:=0 to Nbnd2-1 do
  begin                    //,SizeOf(TBound2)
    BlockRead(f,ii,si);  bnd2[i].x1:=ii;
    BlockRead(f,ii,si);  bnd2[i].x2:=ii;
    BlockRead(f,ii,si);  bnd2[i].z1:=ii;
    BlockRead(f,ii,si);  bnd2[i].z2:=ii;
    BlockRead(f,ff,sz);  bnd2[i].val:=ff;
    BlockRead(f,ff,sz);  bnd2[i].vl_im:=ff;
    BlockRead(f,s80,80);  bnd2[i].nm:=s80;
  end;
  // bounds 3d
  BlockRead(f,s1,9);
  BlockRead(f,Nbnd3,si);
  SetLength(bnd3,Nbnd3);
  for i:=0 to Nbnd3-1 do
  begin
    BlockRead(f,ii,si);  bnd3[i].x1:=ii;
    BlockRead(f,ii,si);  bnd3[i].x2:=ii;
    BlockRead(f,ii,si);  bnd3[i].y1:=ii;
    BlockRead(f,ii,si);  bnd3[i].y2:=ii;
    BlockRead(f,ii,si);  bnd3[i].z1:=ii;
    BlockRead(f,ii,si);  bnd3[i].z2:=ii;
    BlockRead(f,k,1);  bnd3[i].dir:=k;
    BlockRead(f,ff,sz);  bnd3[i].val:=ff;
    BlockRead(f,ff,sz);  bnd3[i].vl_im:=ff;
    BlockRead(f,s80,80);  bnd3[i].nm:=s80;
  end;
  // 3d discretization
  BlockRead(f,s1,9);
  BlockRead(f,k,1); axa.angle:=k;
  BlockRead(f,k,1); axa.adpt:=k;
  BlockRead(f,ii,si); axa.defMat:=ii;
  BlockRead(f,ff,sz); axa.ax:=ff;
  BlockRead(f,ff,sz); axa.ay:=ff;
  BlockRead(f,ff,sz); axa.az:=ff;
  BlockRead(f,ii,si); axa.nd1:=ii;
  BlockRead(f,ii,si); axa.nd2:=ii;
  BlockRead(f,ii,si); axa.nd3:=ii;
  SetLength(axa.disc_1,axa.nd1+1);
  SetLength(axa.disc_2,axa.nd2+1);
  SetLength(axa.disc_3,axa.nd3+1);
  for i:=1 to axa.nd1 do begin BlockRead(f,step,SizeOf(TStep)); axa.disc_1[i]:=step; end;
  for i:=1 to axa.nd2 do begin BlockRead(f,step,SizeOf(TStep)); axa.disc_2[i]:=step; end;
  for i:=1 to axa.nd3 do begin BlockRead(f,step,SizeOf(TStep)); axa.disc_3[i]:=step; end;
  BlockRead(f,ii,si); axa.mesh_s:=ii;
  ///////////////////////////
  // Parameters
  BlockRead(f,s1,9);
  BlockRead(f,ff,sz); ps.wError2d:=ff;
  BlockRead(f,ii,si); ps.wMIter2d:=ii;
  BlockRead(f,ii,si); ps.wSMeth2d:=ii;
  //
  BlockRead(f,ff,sz); ps.wError3d:=ff;
  BlockRead(f,ii,si); ps.wMIter3d:=ii;
  BlockRead(f,ii,si); ps.wSMeth3d:=ii;
  //
  BlockRead(f,ff,sz); ps.wError_d:=ff;
  BlockRead(f,ii,si); ps.wMIter_d:=ii;
  BlockRead(f,ii,si); ps.wSMeth_d:=ii;
  //
  BlockRead(f,ff,sz); ps.wError_n:=ff;
  BlockRead(f,ii,si); ps.wMIter_n:=ii;
  BlockRead(f,ii,si); ps.wSMeth_n:=ii;
  ////////////////////////////////////
  CloseFile(f);
{$I+}
  if IOResult<>0 then
  begin
    prError:=true;
    ShowMessage('There were errors during calculations');
  end;
end;

procedure a_SaveProject_2(s:string);
var f:File;
    i:int;
    s1:st8;
    k:byte;
    mg:TMgObject;
    sec:TSector;
    blc:tBlock;
    sz,si:int;
    ttb:TTriBlock;
    tts:TTriSec;
begin
  sz:=SizeOf(float);
  si:=SizeOf(int);
  // saving information
  AssignFile(f,s);
  Rewrite(f,1);
  BlockWrite(f,verID,1);
  s1:='Magnum3d';
  BlockWrite(f,s1,9);
  BlockWrite(f,Task,4);
  // axial parameters  (2d mesh)
  s1:='Axial_2d';
  BlockWrite(f,s1,9);
  BlockWrite(f,tt.angle,1);
  BlockWrite(f,tt.sort_d,1);
  BlockWrite(f,tt.sort_t,1);
  BlockWrite(f,tt.sort_ex,1);
  BlockWrite(f,tt.ax,sz);
  BlockWrite(f,tt.az,sz);
  BlockWrite(f,tt.nd1,si);
  BlockWrite(f,tt.nd2,si);
  for i:=1 to tt.nd1 do BlockWrite(f,tt.disc_1[i],SizeOf(TStep));
  for i:=1 to tt.nd2 do BlockWrite(f,tt.disc_2[i],SizeOf(TStep));
  BlockWrite(f,tt.defMat,si);
  // material parameters
  s1:='Material';
  BlockWrite(f,s1,9);
  BlockWrite(f,mt.nMaterials,si);
  BlockWrite(f,mt.DefaultMaterial,si);
  BlockWrite(f,mt.Frequency,sz);
  for i:=0 to mt.nMaterials-1 do
  begin
    BlockWrite(f,mt.Anisotropy_X[i],sz);
    BlockWrite(f,mt.Anisotropy_Y[i],sz);
    BlockWrite(f,mt.Anisotropy_Z[i],sz);
    BlockWrite(f,mt.Epsilon[i],sz);
    BlockWrite(f,mt.MuProperty[i],sz);
    BlockWrite(f,mt.Sigma[i],sz);
    BlockWrite(f,mt.mmName[i],80);
    BlockWrite(f,mt.mmColor[i],SizeOf(TColor));
    BlockWrite(f,mt.nlProperty[i],si);
    BlockWrite(f,mt.nlFile[i],80);
  end;
  // object parameters
  s1:='_Objects';
  BlockWrite(f,s1,9);
  BlockWrite(f,ob.Count,si);
  for i:=0 to ob.Count-1 do
  begin
    mg:=TMgObject(ob.Items[i]);
    BlockWrite(f,mg.Name,80);
    BlockWrite(f,mg.iMaterial,si);
    if mg is TBlock then
    begin
      blc:=TBlock(ob.Items[i]);
      k:=1;
      BlockWrite(f,k,1);
      BlockWrite(f,blc.x_1,sz);
      BlockWrite(f,blc.x_2,sz);
      BlockWrite(f,blc.y_1,sz);
      BlockWrite(f,blc.y_2,sz);
      BlockWrite(f,blc.z_1,sz);
      BlockWrite(f,blc.z_2,sz);
    end
    else if mg is TSector then
    begin
      sec:=TSector(ob.Items[i]);
      k:=2;
      BlockWrite(f,k,1);
      BlockWrite(f,sec.xx,sz);
      BlockWrite(f,sec.yy,sz);
      BlockWrite(f,sec.zz,sz);
      BlockWrite(f,sec.r1,sz);
      BlockWrite(f,sec.r2,sz);
      BlockWrite(f,sec.h,sz);
      BlockWrite(f,sec.al,sz);
      BlockWrite(f,sec.bt,sz);
      BlockWrite(f,sec.ax_dir,1);
    end
    else if mg is TTriBlock then
    begin
      ttb:=TTriBlock(ob.Items[i]);
      k:=3;
      BlockWrite(f,k,1);
      BlockWrite(f,ttb.x1,sz);
      BlockWrite(f,ttb.x2,sz);
      BlockWrite(f,ttb.x3,sz);
      BlockWrite(f,ttb.z1,sz);
      BlockWrite(f,ttb.z2,sz);
      BlockWrite(f,ttb.z3,sz);
      BlockWrite(f,ttb.y_min,sz);
      BlockWrite(f,ttb.y_max,sz);
    end
    else if mg is TTriSec then
    begin
      tts:=TTriSec(ob.Items[i]);
      k:=4;
      BlockWrite(f,k,1);
      BlockWrite(f,tts.x1,sz);
      BlockWrite(f,tts.x2,sz);
      BlockWrite(f,tts.x3,sz);
      BlockWrite(f,tts.z1,sz);
      BlockWrite(f,tts.z2,sz);
      BlockWrite(f,tts.z3,sz);
      BlockWrite(f,tts.al,sz);
      BlockWrite(f,tts.bt,sz);
    end;
    BlockWrite(f,mg.sr_1,sz);
    BlockWrite(f,mg.sr_2,sz);
    BlockWrite(f,mg.sr_3,sz);
    BlockWrite(f,mg.sr_4,sz);
    BlockWrite(f,mg.sr_kind,1);
  end;
  // bounds 2d
  s1:='Bound_2d';
  BlockWrite(f,s1,9);
  BlockWrite(f,Nbnd2,si);
  for i:=0 to Nbnd2-1 do
  begin
    BlockWrite(f,bnd2[i].x1,si);
    BlockWrite(f,bnd2[i].x2,si);
    BlockWrite(f,bnd2[i].z1,si);
    BlockWrite(f,bnd2[i].z2,si);
    BlockWrite(f,bnd2[i].val,sz);
    BlockWrite(f,bnd2[i].vl_im,sz);
    BlockWrite(f,bnd2[i].nm,80);
  end;
  // bounds 3d
  s1:='Bound_3d';
  BlockWrite(f,s1,9);
  BlockWrite(f,Nbnd3,si);
  for i:=0 to Nbnd3-1 do
  begin
    BlockWrite(f,bnd3[i].x1,si);
    BlockWrite(f,bnd3[i].x2,si);
    BlockWrite(f,bnd3[i].y1,si);
    BlockWrite(f,bnd3[i].y2,si);
    BlockWrite(f,bnd3[i].z1,si);
    BlockWrite(f,bnd3[i].z2,si);
    BlockWrite(f,bnd3[i].dir,1);
    BlockWrite(f,bnd3[i].val,sz);
    BlockWrite(f,bnd3[i].vl_im,sz);
    BlockWrite(f,bnd3[i].nm,80);
  end;
  // 3d discretization
  s1:='3d-discr';
  BlockWrite(f,s1,9);
  BlockWrite(f,axa.angle,1);
  BlockWrite(f,axa.adpt,1);
  BlockWrite(f,axa.defMat,si);
  BlockWrite(f,axa.ax,sz);
  BlockWrite(f,axa.ay,sz);
  BlockWrite(f,axa.az,sz);
  BlockWrite(f,axa.nd1,si);
  BlockWrite(f,axa.nd2,si);
  BlockWrite(f,axa.nd3,si);
  for i:=1 to axa.nd1 do BlockWrite(f,axa.disc_1[i],SizeOf(TStep));
  for i:=1 to axa.nd2 do BlockWrite(f,axa.disc_2[i],SizeOf(TStep));
  for i:=1 to axa.nd3 do BlockWrite(f,axa.disc_3[i],SizeOf(TStep));
  BlockWrite(f,axa.mesh_s,si);
  ///////////////////////////
  // Parameters
  s1:='Parametr';
  BlockWrite(f,s1,9);
  BlockWrite(f,ps.wError2d,sz);
  BlockWrite(f,ps.wMIter2d,si);
  BlockWrite(f,ps.wSMeth2d,si);
  //
  BlockWrite(f,ps.wError3d,sz);
  BlockWrite(f,ps.wMIter3d,si);
  BlockWrite(f,ps.wSMeth3d,si);
  //
  BlockWrite(f,ps.wError_d,sz);
  BlockWrite(f,ps.wMIter_d,si);
  BlockWrite(f,ps.wSMeth_d,si);
  //
  BlockWrite(f,ps.wError_n,sz);
  BlockWrite(f,ps.wMIter_n,si);
  BlockWrite(f,ps.wSMeth_n,si);
  ///////////////////////////
  BlockWrite(f,'Copyright (c) Zhdanov Andrew. Andrew Inc. 2002.',47);
  CloseFile(f);
end;

end.

