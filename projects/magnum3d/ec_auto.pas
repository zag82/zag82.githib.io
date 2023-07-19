unit ec_auto;

interface

uses cm_ini, Complx, 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, CheckLst, ComCtrls, ExtCtrls;

type
  TChanels=array[1..8] of TComplex;
  TSignalCollect=array of TChanels;

  TfmAutoEC = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    CheckListBox1: TCheckListBox;
    CheckListBox2: TCheckListBox;
    CheckListBox3: TCheckListBox;
    SpeedButton3: TSpeedButton;
    Label11: TLabel;
    Edit7: TEdit;
    GroupBox5: TGroupBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    ComboBox4: TComboBox;
    Label3: TLabel;
    ComboBox5: TComboBox;
    Bevel1: TBevel;
    Label13: TLabel;
    ComboBox3: TComboBox;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label12: TLabel;
    ComboBox2: TComboBox;
    oDlg1: TOpenDialog;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button3: TButton;
    CheckBox3: TCheckBox;
    Label14: TLabel;
    TabSheet3: TTabSheet;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    CheckListBox4: TCheckListBox;
    CheckListBox5: TCheckListBox;
    Label15: TLabel;
    ComboBox6: TComboBox;
    Button4: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenProject;
    procedure CloseProject;
    procedure OneSolveEC2;
    procedure OneSolveEC3D;
    procedure OneSolveMovement(p1,p2,sp:float; var sc:TSignalCollect; FSense:boolean);
    procedure OneSolveMovement3D(p1,p2,sp:float; var sc:TSignalCollect; FSense:boolean);
    function GetParameter(clb:TCheckListBox; k:int; var vl:float):boolean;
  end;

var
  fmAutoEC: TfmAutoEC;

implementation

uses mm_dir, cmVars, ComVars, cmProc, cmData, main, ax_add;

{$R *.dfm}

procedure TfmAutoEC.OpenProject;
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

procedure TfmAutoEC.CloseProject;
begin
  ////////////////////
  // close project
  prOpened:=false;
  ProjectName:='';
  ProjectPath:='';
  Caption:=capMain;
  a_UnLoadProject;
  FreeAll_3d;
  /////////////////////
end;

procedure TfmAutoEC.OneSolveEC2;
var j:int;
    w3:double;
begin
  // reassign main class variable
  mt.GenerateAllProperties(Task);
  tt.nds:=false;
  tt.SetShower(nil,nil,nil);
  // prepare to solution
  tt.PrepareData;
  tt.GenerateNodes();
  tt.GenerateTopology();
  tt.GenerateBounds(bnd2,Nbnd2);
  ///////////////
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

procedure TfmAutoEC.OneSolveMovement(p1,p2,sp:float; var sc:TSignalCollect; FSense:boolean);
const fq:array[1..4]of float=(450000,60000,130000,280000);
      sm:array[1..4]of float=(1.0,1.3,1.25,1.2);
      mm:array[1..4]of float=(1.2,1.4,1.25,1.1);
      //mz:array[1..4]of TComplex=((re:0; im:201.301),(re:0; im:26.84),(re:0; im:58.153),(re:0; im:125.254));
      mz:array[1..4]of TComplex=((re:15.645; im:101.381),(re:6.090; im:18.138),(re:8.865; im:32.751),(re:11.908; im:65.221));
var i,j:integer;
    num,iDefect,iPipe:int;
    iCoil_1,iCoil_2:int;
    s1,s2:TComplex;
    o1,o2:TComplex;
    sec1,sec2,sec3:float;
    dm:integer;

  function GetSig(iCl:int):TComplex;
  var rm:int;
      rr:float;
  begin
    with TSector(ob.Items[iCl])do
    begin
      rm:=iMaterial;
      rr:=(r1+r2)/2;
    end;
    Result:=GetSignal_Axial_2(rm,rr);
  end;

  function Preobraz(zk:TComplex; w:double):TComplex;
  var uk:TComplex;
      z1:TComplex;
      z0,zim:TComplex;
  begin
    z0:=CDConv(100,-1/(w*220e-12));
    zim:=CDConv(0,-1/(w*220e-12));
    z1:=CDiv(CMul(zk,z0),CAdd(zk,z0));
    uk:=CDiv(z1,CAdd(CConv(220),z1));
    Result:=CDiv(CMul(uk,zim),z0);
    //Result:=CDiv(zk,CAdd(CConv(220),zk));
  end;

  procedure Trans2(z1,z2,zm:TComplex; var uk1,uk2:TComplex);
  const r0:TComplex=(re:220; im:0);
        u0:TComplex=(re:3; im:0);
  var chis1,chis2:TComplex;
      znam:TComplex;
  begin
    znam:=CSub(CMul(CAdd(r0,z1),CAdd(r0,z2)),CMul(zm,zm));
    chis1:=CSub(CAdd(CMul(r0,CAdd(z1,zm)),CMul(z1,z2)),CMul(zm,zm));
    chis2:=CSub(CAdd(CMul(r0,CAdd(z2,zm)),CMul(z1,z2)),CMul(zm,zm));
    uk1:=CMul(u0,CDiv(chis1,znam));
    uk2:=CMul(u0,CDiv(chis2,znam));
  end;

  procedure Trans3(z1,z2,zm:TComplex; var uk1,uk2:TComplex; i:integer);
  const r0:TComplex=(re:220; im:0);
        u0:TComplex=(re:3; im:0);
        bt:array[1..4]of TComplex=((re:1; im:0.0218),(re:1; im:0.0136),(re:1; im:0.0029),(re:1; im:0.0063));
  var chis1,chis2:TComplex;
      znam:TComplex;
  begin
    znam:=CSub(CMul(CAdd(r0,CMul(z1,bt[i])),CAdd(r0,CMul(z2,bt[i]))),CMul(CMul(zm,bt[i]),CMul(zm,bt[i])));
    chis1:=CSub(CAdd(CMul(r0,CAdd(z1,zm)),CMul(CMul(z1,z2),bt[i])),CMul(CMul(zm,zm),bt[i]));
    chis2:=CSub(CAdd(CMul(r0,CAdd(z2,zm)),CMul(CMul(z1,z2),bt[i])),CMul(CMul(zm,zm),bt[i]));
    uk1:=CMul(u0,CDiv(chis1,znam));
    uk2:=CMul(u0,CDiv(chis2,znam));
  end;

begin
  iDefect:=ComboBox1.ItemIndex;
  iPipe:=ComboBox3.ItemIndex;
  iCoil_1:=ComboBox4.ItemIndex;
  iCoil_2:=ComboBox5.ItemIndex;
  ///
  dm:=TSector(ob.Items[iDefect]).iMaterial;
  sec1:=TSector(ob.Items[iDefect]).zz;
  sec2:=TSector(ob.Items[iCoil_1]).zz;
  sec3:=TSector(ob.Items[iCoil_2]).zz;
  ///
  Num:=Round((p2-p1)/sp)+1;
  for i:=1 to 4 do
  begin
    mt.Frequency:=fq[i];
    if FSense then
    begin
      mt.Sigma[iPipe]:=sm[i]*1e6;
      mt.MuProperty[iPipe]:=mm[i];
    end;
   if i<>0 then  //===
   begin        //===
    for j:=1 to num do
    begin
      /// Set position
      if RadioGroup1.ItemIndex=0 then
      begin
        TSector(ob.Items[iDefect]).zz:=sec1+p1+(j-1)*sp;
      end
      else
      begin
        TSector(ob.Items[iCoil_1]).zz:=sec2+p1+(j-1)*sp;
        TSector(ob.Items[iCoil_2]).zz:=sec3+p1+(j-1)*sp;
      end;
      ///
     { TSector(ob.Items[iDefect]).iMaterial:=iPipe; // without defect
      OneSolveEC2;
      o1:=GetSig(iCoil_1);
      o2:=GetSig(iCoil_2);  }
      TSector(ob.Items[iDefect]).iMaterial:=dm; // with defect
      OneSolveEC2;
      s1:=GetSig(iCoil_1);
      s2:=GetSig(iCoil_2);
      ///
      {so1:=CSub(o1,o2);
      sc[j][2*i]:=CSub(CSub(s1,s2),so1);
      s1:=CSub(s1,o1);
      s2:=CSub(s2,o2);
      sc[j][2*i-1]:=CDiv(CAdd(s1,s2),CConv(2)); }
      o1:=CMul(o1,CConv(130*130));
      o2:=CMul(o2,CConv(130*130));
      s1:=CMul(s1,CConv(130*130));
      s2:=CMul(s2,CConv(130*130));
      ///
      {o1:=CSub(o1,mz[i]);
      o2:=CSub(o2,mz[i]);
      s1:=CSub(s1,mz[i]);
      s2:=CSub(s2,mz[i]); }
      ///
      {o1:=Preobraz(o1,fq[i]);
      o2:=Preobraz(o2,fq[i]);
      s1:=Preobraz(s1,fq[i]);
      s2:=Preobraz(s2,fq[i]);}
      //Trans3(o1,o2,mz[i],o1,o2,i);
      //Trans3(s1,s2,mz[i],s1,s2,i);
      //so1:=CSub(o1,o2);
      //s1:=CSub(s1,o1);
      //s2:=CSub(s2,o2);
      sc[j][2*i-1]:=s1;
      sc[j][2*i]:=s2;
    end;
   end
   else
    for j:=1 to num do
    begin
      sc[j][2*i-1]:=CDConv(j,j);
      sc[j][2*i]:=CDConv(j,j);
    end;  //====
    TSector(ob.Items[iDefect]).zz:=sec1;
    TSector(ob.Items[iCoil_1]).zz:=sec2;
    TSector(ob.Items[iCoil_2]).zz:=sec3;
    TSector(ob.Items[iDefect]).iMaterial:=dm;
  end;
end;

procedure TfmAutoEC.OneSolveEC3D;
var vl3:TSolution3d;
begin
  // reassign main class variable
  mt.GenerateAllProperties(Task);
  // prepare to solution
  axa.nds:=false;
  axa.SetShower(nil,nil,nil);  
  axa.PrepareData;
  axa.GenerateNodes(1,1);
  axa.GenerateTopology();
  axa.GenerateBounds(bnd3,Nbnd3);
  axa.GenerateTopMat();
  axa.GenerateSources;
  // starting solution
  vl3:=TSolution3d.Create(false);
  vl3.SetShower(nil,nil,nil,nil,nil);
  vl3.CreateAllMatrixEC;
  vl3.RunSolutionEC(ps.wError3d,ps.wMIter3d);
  vl3.Free;
  a_LoadResults(Task,0);
  //////////////////////////
end;

procedure TfmAutoEC.OneSolveMovement3D(p1,p2,sp:float; var sc:TSignalCollect; FSense:boolean);
const fq:array[1..4]of float=(450000,60000,130000,280000);
      sm:array[1..4]of float=(1.0,1.3,1.25,1.2);
      mm:array[1..4]of float=(1.2,1.4,1.25,1.1);
var i,j:integer;
    num,iDefect,iPipe:int;
    iCoil_1,iCoil_2:int;
    s1,s2:TComplex;
    sec1,sec2,sec3:float;
    dm:integer;

  function GetSig3(iCl:int):TComplex;
  var rm:int;
      rr:float;
  begin
    with TSector(ob.Items[iCl])do
    begin
      rm:=iMaterial;
      rr:=(r1+r2)/2;
    end;
    Result:=GetSignal_3D_1(rm,rr);
  end;

begin
  iDefect:=ComboBox1.ItemIndex;
  iPipe:=ComboBox3.ItemIndex;
  iCoil_1:=ComboBox4.ItemIndex;
  iCoil_2:=ComboBox5.ItemIndex;
  ///
  dm:=TSector(ob.Items[iDefect]).iMaterial;
  sec1:=TSector(ob.Items[iDefect]).zz;
  sec2:=TSector(ob.Items[iCoil_1]).zz;
  sec3:=TSector(ob.Items[iCoil_2]).zz;
  ///
  Num:=Round((p2-p1)/sp)+1;
  for i:=1 to 4 do
  begin
    mt.Frequency:=fq[i];
    if FSense then
    begin
      mt.Sigma[iPipe]:=sm[i]*1e6;
      mt.MuProperty[iPipe]:=mm[i];
    end;
   if i<>0 then  //===
   begin        //===
    for j:=1 to num do
    begin
      /// Set position
      if RadioGroup1.ItemIndex=0 then
      begin
        TSector(ob.Items[iDefect]).zz:=sec1+p1+(j-1)*sp;
      end
      else
      begin
        TSector(ob.Items[iCoil_1]).zz:=sec2+p1+(j-1)*sp;
        TSector(ob.Items[iCoil_2]).zz:=sec3+p1+(j-1)*sp;
      end;
      ///
      TSector(ob.Items[iDefect]).iMaterial:=dm; // with defect
      OneSolveEC3D;
      s1:=GetSig3(iCoil_1);
      s2:=GetSig3(iCoil_2);
      ///
      s1:=CMul(s1,CConv(130*130));
      s2:=CMul(s2,CConv(130*130));
      ///
      sc[j][2*i-1]:=s1;
      sc[j][2*i]:=s2;
    end;
   end
   else
    for j:=1 to num do
    begin
      sc[j][2*i-1]:=CDConv(j,j);
      sc[j][2*i]:=CDConv(j,j);
    end;  //====
    TSector(ob.Items[iDefect]).zz:=sec1;
    TSector(ob.Items[iCoil_1]).zz:=sec2;
    TSector(ob.Items[iCoil_2]).zz:=sec3;
    TSector(ob.Items[iDefect]).iMaterial:=dm;
  end;
end;

function TfmAutoEC.GetParameter(clb:TCheckListBox; k:int; var vl:float):boolean;
var b:boolean;
begin
  b:=clb.Checked[k];
  if b then
    vl:=StrToFloat(clb.Items[k])
  else
    vl:=0.0;
  Result:=b;
end;

procedure TfmAutoEC.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmAutoEC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseProject;
  Action:=cafree;
  fmAutoEC:=nil;
end;

procedure TfmAutoEC.SpeedButton1Click(Sender: TObject);
var i:int;
begin
  if oDlg1.Execute then
  begin
    Edit1.Text:=oDlg1.FileName;
    OpenProject;
    /// Coil 1
    ComboBox4.Clear;
    for i:=0 to ob.Count-1 do
      ComboBox4.Items.Add(TMgObject(ob.Items[i]).Name);
    ComboBox4.ItemIndex:=0;
    /// Coil 2
    ComboBox5.Clear;
    for i:=0 to ob.Count-1 do
     ComboBox5.Items.Add(TMgObject(ob.Items[i]).Name);
    ComboBox5.ItemIndex:=0;
    /// Defect
    ComboBox1.Clear;
    for i:=0 to ob.Count-1 do
      ComboBox1.Items.Add(TMgObject(ob.Items[i]).Name);
    ComboBox1.ItemIndex:=0;
    /// Pipe Material
    ComboBox3.Clear;
    for i:=0 to mt.nMaterials-1 do
    begin
      ComboBox3.Items.Add(mt.mmName[i]);
      ComboBox6.Items.Add(mt.mmName[i]);
    end;
    ComboBox3.ItemIndex:=0;
    ComboBox6.ItemIndex:=0;
  end;
end;

procedure TfmAutoEC.SpeedButton3Click(Sender: TObject);
var s:string;
    k:integer;
begin
  fmDirs:=TfmDirs.Create(Application);
  fmDirs.ShowModal;
  Edit7.Text:=fmDirs.s;
  /////
    s:=Edit7.Text;
    k:=Length(s);
    if (k>0) and (s<>'') then
    begin
      if s[k]<>'\' then s:=s+'\';
    end;  
    Edit7.Text:=s;
  /////
  fmDirs.Free;
end;

procedure TfmAutoEC.Button1Click(Sender: TObject);
var
  pos1,pos2,sp:float; // positions of gage
  thick:float;
  Num:int;
  i,j,k,iDefect:int;
  v1,v2,v3:float;
  sc:TSignalCollect;
  tm:TDateTime;

  procedure ScaleIt(var sc:TSignalCollect; num:int; a:float);
  var i,j:int;
      al:float;
      avg:array[1..8]of TComplex;
  begin
    // save Average Level
    for j:=1 to 8 do
      avg[j]:=CDiv(CAdd(sc[1,j],sc[num,j]),CConv(2));
    // Scale induced signal
    al:=a;
    for i:=1 to num do
      for j:=1 to 8 do
      begin
        CSubTo(sc[i,j],avg[j]);
        sc[i,j]:=CMul(sc[i,j],CConv(al));
        CAddTo(sc[i,j],avg[j]);
      end;
  end;

  procedure SaveIt(w,d,a:float; var sc:TSignalCollect; num:int);
  var i,j:int;
      f:TextFile;
      FName:string;
      sw,sd,sa:string;
  begin
    sw:=IntToStr(Round(w*10));
    while Length(sw)<3 do sw:='0'+sw;
    sd:=IntToStr(Round(d));
    while Length(sd)<3 do sd:='0'+sd;
    sa:=IntToStr(Round(a));
    while Length(sa)<3 do sa:='0'+sa;
    FName:='base_'+sa+'_'+sw+'_'+sd+'.txt';
    AssignFile(f,FName);
    Rewrite(f);
    writeln(f,'[EC_BASE]');
    writeln(f,num);
    for i:=1 to num do
    begin
      for j:=1 to 8 do
        write(f,sc[i][j].re:15,#09,sc[i][j].im:15,#09);
      writeln(f);
    end;
    CloseFile(f);
  end;

begin
  tm:=Time();
  fmMain.HideItemClick(Self);
  ////
  iDefect:=ComboBox1.ItemIndex;
  thick:=StrToFloat(ComboBox2.Text)/1e3;
  pos1:=StrToFloat(Edit2.Text)/1000;
  pos2:=StrToFloat(Edit3.Text)/1000;
  sp:=StrToFloat(Edit4.Text)/1000;
  Num:=Round((pos2-pos1)/sp)+1;
  SetLength(sc,num+1);
  for i:=0 to CheckListBox2.Count-1 do
    if GetParameter(CheckListBox2,i,v1) then
      for j:=0 to CheckListBox1.Count-1 do
        if GetParameter(CheckListBox1,j,v2) then
        begin
          TSector(ob.Items[iDefect]).h:=v1/1e3;
          TSector(ob.Items[iDefect]).zz:=-v1/2/1e3;
          if CheckBox1.Checked then
            TSector(ob.Items[iDefect]).r2:=TSector(ob.Items[iDefect]).r1+v2/100*thick
          else
            TSector(ob.Items[iDefect]).r1:=TSector(ob.Items[iDefect]).r2-v2/100*thick;
          ///
          OneSolveMovement(pos1,pos2,sp,sc,CheckBox2.Checked);
          for k:=0 to CheckListBox3.Count-1 do
            if GetParameter(CheckListBox3,k,v3) then
            begin
              ScaleIt(sc,num,v3/360);
              SaveIt(v1,v2,v3,sc,num);
              ScaleIt(sc,num,360/v3);
            end;
        end;
  sc:=nil;
  ////
  fmMain.RestoreItemClick(Self);
  Label14.Caption:='Time = '+TimeToStr(Time()-tm);
end;

procedure TfmAutoEC.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
end;

procedure TfmAutoEC.Button3Click(Sender: TObject);
var
  pos1,pos2,sp:float; // positions of gage
  thick:float;
  Num:int;
  i,j,k,iDefect:int;
  v1,v2,v3:float;
  sc:TSignalCollect;
  tm:TDateTime;

  procedure SaveIt(w,d,a:float; var sc:TSignalCollect; num:int);
  var i,j:int;
      f:TextFile;
      FName:string;
      sw,sd,sa:string;
  begin
    sw:=IntToStr(Round(w*10));
    while Length(sw)<3 do sw:='0'+sw;
    sd:=IntToStr(Round(d));
    while Length(sd)<3 do sd:='0'+sd;
    sa:=IntToStr(Round(a));
    while Length(sa)<3 do sa:='0'+sa;
    FName:='bs3D_'+sa+'_'+sw+'_'+sd+'.txt';
    AssignFile(f,FName);
    Rewrite(f);
    writeln(f,'[EC_BASE]');
    writeln(f,num);
    for i:=1 to num do
    begin
      for j:=1 to 8 do
        write(f,sc[i][j].re:20,#09,sc[i][j].im:20,#09);
      writeln(f);
    end;
    CloseFile(f);
  end;

begin
  tm:=Time();
  fmMain.HideItemClick(Self);
  ////
  iDefect:=ComboBox1.ItemIndex;
  thick:=StrToFloat(ComboBox2.Text)/1e3;
  pos1:=StrToFloat(Edit2.Text)/1000;
  pos2:=StrToFloat(Edit3.Text)/1000;
  sp:=StrToFloat(Edit4.Text)/1000;
  Num:=Round((pos2-pos1)/sp)+1;
  SetLength(sc,num+1);
  for i:=0 to CheckListBox2.Count-1 do
    if GetParameter(CheckListBox2,i,v1) then
      for j:=0 to CheckListBox1.Count-1 do
        if GetParameter(CheckListBox1,j,v2) then
          for k:=0 to CheckListBox3.Count-1 do
            if GetParameter(CheckListBox3,k,v3) then
            begin
              TSector(ob.Items[iDefect]).h:=v1/1e3;
              TSector(ob.Items[iDefect]).zz:=-v1/2/1e3;
              TSector(ob.Items[iDefect]).bt:=v3/3;
              if CheckBox1.Checked then
                TSector(ob.Items[iDefect]).r2:=TSector(ob.Items[iDefect]).r1+v2/100*thick
              else
                TSector(ob.Items[iDefect]).r1:=TSector(ob.Items[iDefect]).r2-v2/100*thick;
              ///
              OneSolveMovement3D(pos1,pos2,sp,sc,CheckBox2.Checked);
              SaveIt(v1,v2,v3,sc,num);
            end;
  sc:=nil;
  ////
  fmMain.RestoreItemClick(Self);
  Label14.Caption:='Time = '+TimeToStr(Time()-tm);
  if CheckBox3.Checked then
  begin
    Self.Close;
  end;
end;

procedure TfmAutoEC.Button4Click(Sender: TObject);
var
  pos1,pos2,sp:float; // positions of gage
  thick:float;
  Num:int;
  i,j,k,iDefect,k1,k2,iDeposite:int;
  v1,v2,v3,v4,v5:float;
  sc:TSignalCollect;
  tm:TDateTime;

  procedure SaveIt(w,d,a,m,s:float; var sc:TSignalCollect; num:int);
  var i,j:int;
      f:TextFile;
      FName:string;
      sw,sd,sa,sm,ss:string;
  begin
    sw:=IntToStr(Round(w*10));
    while Length(sw)<3 do sw:='0'+sw;
    sd:=IntToStr(Round(d));
    while Length(sd)<3 do sd:='0'+sd;
    sa:=IntToStr(Round(a));
    while Length(sa)<3 do sa:='0'+sa;
    sm:=IntToStr(Round(m*10));
    while Length(sm)<3 do sm:='0'+sm;
    ss:=IntToStr(Round(s*10));
    while Length(ss)<3 do ss:='0'+ss;
    FName:='base_'+sa+'_'+sw+'_'+sd+'_'+sm+'_'+ss+'.txt';
    AssignFile(f,FName);
    Rewrite(f);
    writeln(f,'[EC_BASE]');
    writeln(f,num);
    for i:=1 to num do
    begin
      for j:=1 to 8 do
        write(f,sc[i][j].re:15,#09,sc[i][j].im:15,#09);
      writeln(f);
    end;
    CloseFile(f);
  end;

begin
  tm:=Time();
  fmMain.HideItemClick(Self);
  ////
  iDeposite:=ComboBox6.ItemIndex;
  iDefect:=ComboBox1.ItemIndex;
  thick:=StrToFloat(ComboBox2.Text)/1e3;
  pos1:=StrToFloat(Edit2.Text)/1000;
  pos2:=StrToFloat(Edit3.Text)/1000;
  sp:=StrToFloat(Edit4.Text)/1000;
  Num:=Round((pos2-pos1)/sp)+1;
  SetLength(sc,num+1);
  v3:=360;
  for i:=0 to CheckListBox2.Count-1 do
    if GetParameter(CheckListBox2,i,v1) then
      for j:=0 to CheckListBox1.Count-1 do
        if GetParameter(CheckListBox1,j,v2) then
          for k1:=0 to CheckListBox4.Count-1 do
            if GetParameter(CheckListBox4,k1,v4) then
              for k2:=0 to CheckListBox5.Count-1 do
                if GetParameter(CheckListBox5,k2,v5) then
                begin
                  mt.MuProperty[iDeposite]:=v4;
                  mt.Sigma[iDeposite]:=v5*1e6;
                  TSector(ob.Items[iDefect]).h:=v1/1e3;
                  TSector(ob.Items[iDefect]).zz:=-v1/2/1e3;
                  if CheckBox1.Checked then
                    TSector(ob.Items[iDefect]).r2:=TSector(ob.Items[iDefect]).r1+v2/100*thick
                  else
                    TSector(ob.Items[iDefect]).r1:=TSector(ob.Items[iDefect]).r2-v2/100*thick;
                  ///
                  OneSolveMovement(pos1,pos2,sp,sc,CheckBox2.Checked);
                  SaveIt(v1,v2,v3,v4,v5,sc,num);
                end;
  sc:=nil;
  ////
  fmMain.RestoreItemClick(Self);
  Label14.Caption:='Time = '+TimeToStr(Time()-tm);
end;

end.
