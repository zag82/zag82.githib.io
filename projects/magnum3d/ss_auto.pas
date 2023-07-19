unit ss_auto;

interface

uses cm_ini, main,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ComCtrls, ExtCtrls;

type
  TfmAutoMag = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    SpeedButton2: TSpeedButton;
    oDlg1: TOpenDialog;
    oDlg2: TOpenDialog;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CheckBox1: TCheckBox;
    CheckListBox1: TCheckListBox;
    Label9: TLabel;
    Bevel1: TBevel;
    TabSheet5: TTabSheet;
    Label10: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Edit7: TEdit;
    Label11: TLabel;
    SpeedButton3: TSpeedButton;
    Button2: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    CheckListBox4: TCheckListBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    CheckListBox5: TCheckListBox;
    CheckListBox6: TCheckListBox;
    CheckListBox7: TCheckListBox;
    CheckListBox8: TCheckListBox;
    CheckBox2: TCheckBox;
    cbx2: TComboBox;
    Label12: TLabel;
    GroupBox10: TGroupBox;
    CheckListBox9: TCheckListBox;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateTabView;
    procedure OpenProject;
    procedure CloseProject;
    procedure OneSolveNL;
    procedure LoadMesh;
    function GetParameter(clb:TCheckListBox; k:int; var vl:float):boolean;
  end;

var
  fmAutoMag: TfmAutoMag;

implementation

uses mm_dir, cmVars, cmData, ComVars, nonline2d, ax_add,
  Compute_VectorsUnit, axu_3, control_ss, ss_multi, ado3;

{$R *.dfm}

procedure TfmAutoMag.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmAutoMag.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=cafree;
  fmAutoMag:=nil;
end;

procedure TfmAutoMag.SpeedButton1Click(Sender: TObject);
begin
  if oDlg1.Execute then
    Edit1.Text:=oDlg1.FileName;
end;

procedure TfmAutoMag.SpeedButton2Click(Sender: TObject);
begin
  if oDlg2.Execute then
    Edit2.Text:=oDlg2.FileName;
end;

procedure TfmAutoMag.SpeedButton3Click(Sender: TObject);
var s:string;
begin
  fmDirs:=TfmDirs.Create(Application);
  fmDirs.ShowModal;
  Edit7.Text:=fmDirs.s;
  /////
    s:=Edit7.Text;
    if s[Length(s)]<>'\' then s:=s+'\';
    Edit7.Text:=s;
  /////
  fmDirs.Free;
end;

procedure TfmAutoMag.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  UpdateTabView;
end;

procedure TfmAutoMag.UpdateTabView;
var k:int;
begin
  k:=ComboBox1.ItemIndex+1;
  Case k of
    1..4:begin
           TabSheet2.TabVisible:=true;
           TabSheet3.TabVisible:=false;
           TabSheet4.TabVisible:=false;
           TabSheet5.TabVisible:=false;
         end;
    5..8:begin
           TabSheet2.TabVisible:=false;
           TabSheet3.TabVisible:=true;
           TabSheet4.TabVisible:=false;
           TabSheet5.TabVisible:=false;
         end;
    9..12:begin
           TabSheet2.TabVisible:=false;
           TabSheet3.TabVisible:=false;
           TabSheet4.TabVisible:=true;
           TabSheet5.TabVisible:=false;
         end;
  else
    TabSheet2.TabVisible:=false;
    TabSheet3.TabVisible:=false;
    TabSheet4.TabVisible:=false;
    TabSheet5.TabVisible:=true;
  end;
end;

procedure TfmAutoMag.ComboBox1Change(Sender: TObject);
begin
  UpdateTabView;
end;

procedure TfmAutoMag.OpenProject;
var fName:string;
begin
  fName:=Edit1.Text;
  ////////////////////
  // open project
  a_LoadProject_2(fName);
  if prError then exit;
  prOpened:=true;
  ProjectName:=ExtractFileName(fName);
  ProjectPath:=ExtractFilePath(fName);
  ChDir(ProjectPath);
end;

procedure TfmAutoMag.CloseProject;
begin
  ////////////////////
  // close project
  prOpened:=false;
  ProjectName:='';
  ProjectPath:='';
  Caption:=capMain;
  a_UnLoadProject;
  FreeAll_3d;
  if adoptedM3<>nil then
  begin
    adoptedM3.Free;
    adoptedM3:=nil;
  end;  
  /////////////////////
end;

procedure TfmAutoMag.OneSolveNL;
var i,k:int;
    h1:array of float;
    e0,err,w3:float;
    v3:TSolution3d;
begin
  // reassign main class variable
  mt.GenerateAllProperties(Task);
  axa.nds:=false;
  axa.SetShower(nil,nil,nil);
  axa.PrepareData;
  axa.GenerateNodes(1,1);
  axa.GenerateTopology;
  ///////////////////////////
  Hm:=nil;
  H1:=nil;
  SetLength(H1,NElements+1);
  SetLength(Hm,NElements+1);
  SetLength(vm,NElements+1);
  k:=0;
  e0:=1;
  repeat
    // remember previous step
    for i:=1 to NElements do h1[i]:=Hm[i];
    // starting solution
    axa.GenerateNodes(1,1);
    axa.GenerateTopology;
    axa.GenerateBounds(bnd3,NBnd3);
    axa.GenerateTopMat;
    axa.GenerateSources;
    v3:=TSolution3d.Create(false);
    v3.CreateMatrix;
    w3:=v3.RunSolution(ps.wError3d,ps.wMIter3d);
    a_LoadResults(Task,0);
    // define H distribution
    for i:=1 to NElements do
    begin
      Compute_Vectors(i);
      Hm[i]:=sqrt(sqr(HIntensity_X)+sqr(HIntensity_Y)+sqr(HIntensity_Z));
    end;
    // calculate error
    err:=0;
    for i:=1 to NElements do err:=err+Abs(h1[i]-hm[i]);
    // next step
    inc(k);
    if k=1 then e0:=err;
    err:=err/e0;
  until (err<ps.wError_n)or(k>=ps.wMIter_n);
  v3.Free;
  a_SaveDataFile('sresult.dat',ResultSc[0],(NPoints+1)*SizeOf(ResultSc[0]));
  H1:=nil;
  vm:=nil;
end;

procedure TfmAutoMag.LoadMesh;
var k:int;
begin
  k:=cbx2.ItemIndex;
  if Edit2.Text<>'' then
  begin
    if k=0 then
    begin
      axa.ad_type:=1;
      adoptedM3:=TAdoptMesh3d.Create();
      adoptedM3.LoadFromFile(Edit2.Text);
      adoptedM3.GenerateTop3();
    end
    else
    begin
      axa.ad_type:=2;
      adm3:=TAdoMesh3d.Create();
      adm3.LoadFromFile(Edit2.Text);
      adm3.GenerateTop3();
    end;
  end;
end;

procedure TfmAutoMag.Button1Click(Sender: TObject);
var i,j,k,m:int;
    nn:int;
    v1,v2,v3,v4:float;
    blc:TBlock;
    sec:TSector;
    tts:TTriSec;
    ttb1,ttb2:TTriBlock;
    s,s0:string;
    st_z,st_fi:float;
    n_z,n_fi:int;
    zz:float;
    sm:TMagnetSignal;

    procedure SignalGen(f:boolean);
    begin
      sm.SetData(st_z,st_fi,n_z,n_fi,zz);
      sm.minus:=f;
      sm.GenerateFullMatrix;
      sm.SaveResToFile(s+s0+'bz.txt',1);
      sm.SaveResToFile(s+s0+'bfi.txt',2);
      sm.SaveResToFile(s+s0+'br.txt',3);
    end;

    procedure SignalOut(f:boolean);
    begin
      if CheckBox1.Checked then
      begin
        s0:='ext_';
        zz:=0.004+v4;
        SignalGen(f);
      end;
      if CheckBox2.Checked then
      begin
        s0:='int_';
        zz:=-0.004-v4;
        SignalGen(f);
      end;
    end;

begin
  fmMain.HideItemClick(Self);
  n_z:=StrToInt(Edit3.Text);
  n_fi:=StrToInt(Edit4.Text);
  st_z:=StrToFloat(Edit5.Text)/1000;
  st_fi:=StrToFloat(Edit6.Text)/1000;
  //////////////////////////
  OpenProject;
  axa.PrepareData();
  LoadMesh;
  nn:=ComboBox1.ItemIndex+1;
  Case nn of
    1:begin  // Crack 90
        sm:=TMagnetSignal.Create;
        s:='';
        blc:=TBlock(ob.Items[1]);
        for i:=0 to CheckListBox2.Count-1 do
          if GetParameter(CheckListBox2,i,v1) then
            for j:=0 to CheckListBox3.Count-1 do
              if GetParameter(CheckListBox3,j,v2) then
                for k:=0 to CheckListBox4.Count-1 do
                  if GetParameter(CheckListBox4,k,v3) then
                  begin
                    blc.z_2:=blc.z_1+v1;
                    blc.x_2:=blc.x_1+(v2/2);
                    blc.y_2:=blc.y_1+(v3/2);
                    OneSolveNL;
                    a_LoadResults(Task,0);
                    for m:=0 to CheckListBox1.Count-1 do
                      if GetParameter(CheckListBox1,m,v4) then
                      begin
                        s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                         IntToStr(Round(1e4*v2))+'_'+
                                                         IntToStr(Round(1e4*v3))+'_'+
                                                         IntToStr(Round(1e4*st_z))+'_'+
                                                         IntToStr(Round(1e4*st_fi))+'_'+
                                                         IntToStr(Round(1e4*v4))+'_';
                        SignalOut(false);
                      end;
                  end;
        sm.FreeData;
        sm.Free;
      end;
    2:begin  // Crack 60
        sm:=TMagnetSignal.Create;
        s:='';
        ttb1:=TTriBlock(ob.Items[1]);
        ttb2:=TTriBlock(ob.Items[2]);
        for i:=0 to CheckListBox2.Count-1 do
          if GetParameter(CheckListBox2,i,v1) then
            for j:=0 to CheckListBox3.Count-1 do
              if GetParameter(CheckListBox3,j,v2) then
                for k:=0 to CheckListBox4.Count-1 do
                  if GetParameter(CheckListBox4,k,v3) then
                  begin
                    ttb1.y_max:=ttb1.y_min+(v3/2);
                    ttb2.y_max:=ttb2.y_min+(v3/2);
                    ///////////
                    ttb1.x2:=v2;
                    ttb1.x3:=ttb1.x1+v1*0.577;
                    ttb1.z3:=ttb1.z1+v1;
                    ///////////
                    ttb2.x1:=ttb1.x2;
                    ttb2.x2:=ttb1.x3+v2;
                    ttb2.z2:=ttb1.z3;
                    ttb2.x3:=ttb1.x3;
                    ttb2.z3:=ttb1.z3;
                    OneSolveNL;
                    a_LoadResults(Task,0);
                    for m:=0 to CheckListBox1.Count-1 do
                      if GetParameter(CheckListBox1,m,v4) then
                      begin
                        s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                         IntToStr(Round(1e4*v2))+'_'+
                                                         IntToStr(Round(1e4*v3))+'_'+
                                                         IntToStr(Round(1e4*st_z))+'_'+
                                                         IntToStr(Round(1e4*st_fi))+'_'+
                                                         IntToStr(Round(1e4*v4))+'_';
                        SignalOut(true);
                      end;
                  end;
        sm.FreeData;
        sm.Free;
      end;
    3:begin // Crack 45
        sm:=TMagnetSignal.Create;
        s:='';
        ttb1:=TTriBlock(ob.Items[1]);
        ttb2:=TTriBlock(ob.Items[2]);
        for i:=0 to CheckListBox2.Count-1 do
          if GetParameter(CheckListBox2,i,v1) then
            for j:=0 to CheckListBox3.Count-1 do
              if GetParameter(CheckListBox3,j,v2) then
                for k:=0 to CheckListBox4.Count-1 do
                  if GetParameter(CheckListBox4,k,v3) then
                  begin
                    ttb1.y_max:=ttb1.y_min+(v3/2);
                    ttb2.y_max:=ttb2.y_min+(v3/2);
                    ///////////
                    ttb1.x2:=v2;
                    ttb1.x3:=ttb1.x1+v1;
                    ttb1.z3:=ttb1.z1+v1;
                    ///////////
                    ttb2.x1:=ttb1.x2;
                    ttb2.x2:=ttb1.x3+v2;
                    ttb2.z2:=ttb1.z3;
                    ttb2.x3:=ttb1.x3;
                    ttb2.z3:=ttb1.z3;
                    OneSolveNL;
                    a_LoadResults(Task,0);
                    for m:=0 to CheckListBox1.Count-1 do
                      if GetParameter(CheckListBox1,m,v4) then
                      begin
                        s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                         IntToStr(Round(1e4*v2))+'_'+
                                                         IntToStr(Round(1e4*v3))+'_'+
                                                         IntToStr(Round(1e4*st_z))+'_'+
                                                         IntToStr(Round(1e4*st_fi))+'_'+
                                                         IntToStr(Round(1e4*v4))+'_';
                        SignalOut(true);
                      end;
                  end;
        sm.FreeData;
        sm.Free;
      end;
    4:begin // Crack 30
        sm:=TMagnetSignal.Create;
        s:='';
        ttb1:=TTriBlock(ob.Items[1]);
        ttb2:=TTriBlock(ob.Items[2]);
        for i:=0 to CheckListBox2.Count-1 do
          if GetParameter(CheckListBox2,i,v1) then
            for j:=0 to CheckListBox3.Count-1 do
              if GetParameter(CheckListBox3,j,v2) then
                for k:=0 to CheckListBox4.Count-1 do
                  if GetParameter(CheckListBox4,k,v3) then
                  begin
                    ttb1.y_max:=ttb1.y_min+(v3/2);
                    ttb2.y_max:=ttb2.y_min+(v3/2);
                    ///////////
                    ttb1.x2:=v2;
                    ttb1.x3:=ttb1.x1+v1*1.732;
                    ttb1.z3:=ttb1.z1+v1;
                    ///////////
                    ttb2.x1:=ttb1.x2;
                    ttb2.x2:=ttb1.x3+v2;
                    ttb2.z2:=ttb1.z3;
                    ttb2.x3:=ttb1.x3;
                    ttb2.z3:=ttb1.z3;
                    OneSolveNL;
                    a_LoadResults(Task,0);
                    for m:=0 to CheckListBox1.Count-1 do
                      if GetParameter(CheckListBox1,m,v4) then
                      begin
                        s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                         IntToStr(Round(1e4*v2))+'_'+
                                                         IntToStr(Round(1e4*v3))+'_'+
                                                         IntToStr(Round(1e4*st_z))+'_'+
                                                         IntToStr(Round(1e4*st_fi))+'_'+
                                                         IntToStr(Round(1e4*v4))+'_';
                        SignalOut(true);
                      end;
                  end;
        sm.FreeData;
        sm.Free;
      end;
    5:begin // Corrosion 90
        sm:=TMagnetSignal.Create;
        s:='';
        sec:=TSector(ob.Items[1]);
        for i:=0 to CheckListBox5.Count-1 do
          if GetParameter(CheckListBox5,i,v1) then
            for j:=0 to CheckListBox6.Count-1 do
              if GetParameter(CheckListBox6,j,v2) then
              begin
                sec.r2:=v2/2;
                sec.h:=v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;
      end;
    6:begin // Corrosion 60
        sm:=TMagnetSignal.Create;
        s:='';
        sec:=TSector(ob.Items[1]);
        tts:=TTriSec(ob.Items[2]);
        for i:=0 to CheckListBox5.Count-1 do
          if GetParameter(CheckListBox5,i,v1) then
            for j:=0 to CheckListBox6.Count-1 do
              if GetParameter(CheckListBox6,j,v2) then
              begin
                sec.r2:=v2/2-v1*0.577;
                sec.h:=v1;
                //
                tts.x1:=sec.r2;
                tts.x3:=sec.r2;
                tts.x2:=v2/2;
                tts.z3:=v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;
      end;
    7:begin // Corrosion 45
        sm:=TMagnetSignal.Create;
        s:='';
        sec:=TSector(ob.Items[1]);
        tts:=TTriSec(ob.Items[2]);
        for i:=0 to CheckListBox5.Count-1 do
          if GetParameter(CheckListBox5,i,v1) then
            for j:=0 to CheckListBox6.Count-1 do
              if GetParameter(CheckListBox6,j,v2) then
              begin
                sec.r2:=v2/2-v1;
                sec.h:=v1;
                //
                tts.x1:=sec.r2;
                tts.x3:=sec.r2;
                tts.x2:=v2/2;
                tts.z3:=v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;
      end;
    8:begin // Corrosion 30
{        sm:=TMagnetSignal.Create;
        s:='';
        sec:=TSector(ob.Items[1]);
        tts:=TTriSec(ob.Items[2]);
        for i:=0 to CheckListBox5.Count-1 do
          if GetParameter(CheckListBox5,i,v1) then
            for j:=0 to CheckListBox6.Count-1 do
              if GetParameter(CheckListBox6,j,v2) then
              begin
                sec.r2:=v2/2-v1*1.732;
                sec.h:=v1;
                //
                tts.x1:=sec.r2;
                tts.x3:=sec.r2;
                tts.x2:=v2/2;
                tts.z3:=v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;   }
        ShowMessage('Not avilable');
      end;
    9:begin  // Rectangle 90
        sm:=TMagnetSignal.Create;
        s:='';
        blc:=TBlock(ob.Items[1]);
        for i:=0 to CheckListBox7.Count-1 do
          if GetParameter(CheckListBox7,i,v1) then
            for j:=0 to CheckListBox8.Count-1 do
              if GetParameter(CheckListBox8,j,v2) then
              begin
                blc.x_2:=blc.x_1+(v2/2);
                blc.y_2:=blc.y_1+(v2/2);
                blc.z_2:=blc.z_1+v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;
      end;
    10:begin  // Rectangle 60
        sm:=TMagnetSignal.Create;
        s:='';
        blc:=TBlock(ob.Items[1]);
        ttb1:=TTriBlock(ob.Items[2]);
        for i:=0 to CheckListBox7.Count-1 do
          if GetParameter(CheckListBox7,i,v1) then
            for j:=0 to CheckListBox8.Count-1 do
              if GetParameter(CheckListBox8,j,v2) then
              begin
                blc.y_2:=blc.y_1+(v2/2);
                blc.z_2:=blc.z_1+v1;
                blc.x_2:=blc.x_1+(v2/2)-v1*0.577;
                ttb1.y_max:=ttb1.y_min+(v2/2);
                ttb1.x1:=blc.x_2;
                ttb1.x3:=blc.x_2;
                ttb1.x2:=(v2/2);
                ttb1.z3:=ttb1.z1+v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;
      end;
    11:begin  // Rectangle 45
        sm:=TMagnetSignal.Create;
        s:='';
        blc:=TBlock(ob.Items[1]);
        ttb1:=TTriBlock(ob.Items[2]);
        for i:=0 to CheckListBox7.Count-1 do
          if GetParameter(CheckListBox7,i,v1) then
            for j:=0 to CheckListBox8.Count-1 do
              if GetParameter(CheckListBox8,j,v2) then
              begin
                blc.y_2:=blc.y_1+(v2/2);
                blc.z_2:=blc.z_1+v1;
                blc.x_2:=blc.x_1+(v2/2)-v1;
                ttb1.y_max:=ttb1.y_min+(v2/2);
                ttb1.x1:=blc.x_2;
                ttb1.x3:=blc.x_2;
                ttb1.x2:=(v2/2);
                ttb1.z3:=ttb1.z1+v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;
      end;
    12:begin  // Rectangle 30
{        sm:=TMagnetSignal.Create;
        s:='';
        blc:=TBlock(ob.Items[1]);
        ttb1:=TTriBlock(ob.Items[2]);
        for i:=0 to CheckListBox7.Count-1 do
          if GetParameter(CheckListBox7,i,v1) then
            for j:=0 to CheckListBox8.Count-1 do
              if GetParameter(CheckListBox8,j,v2) then
              begin
                blc.y_2:=blc.y_1+(v2/2);
                blc.z_2:=blc.z_1+v1;
                blc.x_2:=blc.x_1+(v2/2)-v1*1.732;
                ttb1.y_max:=ttb1.y_min+(v2/2);
                ttb1.x1:=blc.x_2;
                ttb1.x3:=blc.x_2;
                ttb1.x2:=(v2/2);
                ttb1.z3:=ttb1.z1+v1;
                OneSolveNL;
                a_LoadResults(Task,0);
                for m:=0 to CheckListBox1.Count-1 do
                  if GetParameter(CheckListBox1,m,v4) then
                  begin
                    s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                     IntToStr(Round(1e4*v2))+'_'+
                                                     IntToStr(Round(1e4*st_z))+'_'+
                                                     IntToStr(Round(1e4*st_fi))+'_'+
                                                     IntToStr(Round(1e4*v4))+'_';
                    SignalOut(false);
                  end;
              end;
        sm.FreeData;
        sm.Free;              }
        ShowMessage('Not avilable');
      end;
    else begin  // Welding
        sm:=TMagnetSignal.Create;
        s:='';
        ttb1:=TTriBlock(ob.Items[10]);
        ttb2:=TTriBlock(ob.Items[11]);
        for i:=0 to CheckListBox9.Count-1 do
          if GetParameter(CheckListBox9,i,v1) then
          begin
            ttb1.y_max:=ttb1.y_min+(v1/2);
            ttb2.y_max:=ttb2.y_min+(v1/2);
            OneSolveNL;
            a_LoadResults(Task,0);
            for m:=0 to CheckListBox1.Count-1 do
              if GetParameter(CheckListBox1,m,v4) then
              begin
                s:=Edit7.Text+ComboBox1.Text+'_'+IntToStr(Round(1e4*v1))+'_'+
                                                 IntToStr(Round(1e4*st_z))+'_'+
                                                 IntToStr(Round(1e4*st_fi))+'_'+
                                                 IntToStr(Round(1e4*v4))+'_';
                SignalOut(true);
              end;
          end;
        sm.FreeData;
        sm.Free;
      end;
  end;
  CloseProject;
  fmMain.RestoreItemClick(Self);
end;

function TfmAutoMag.GetParameter(clb:TCheckListBox; k:int; var vl:float):boolean;
var b:boolean;
begin
  b:=clb.Checked[k];
  if b then
    vl:=StrToFloat(clb.Items[k])/1000
  else
    vl:=0.0;
  Result:=b;    
end;

end.
