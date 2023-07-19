unit ec_queue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Spin, ComCtrls, ExtCtrls;

type
  TfmQueue = class(TForm)
    GroupBox1: TGroupBox;
    lb1: TListBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    oDlg: TOpenDialog;
    sDlg: TSaveDialog;
    GroupBox2: TGroupBox;
    lb2: TListBox;
    Button1: TButton;
    se: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    pbb: TProgressBar;
    RadioGroup1: TRadioGroup;
    GroupBox3: TGroupBox;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    SpeedButton5: TSpeedButton;
    Edit1: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrepData;
    procedure FreeData;
    procedure RunSolver;
  end;

var
  fmQueue: TfmQueue;

implementation

{$R *.dfm}
uses cm_ini, main, cmVars, ComVars, cmData, ec_main2d, common_main2d,
  cmProc, solve_Thread, axu_3, ax_add;

var
  nNames:int;
  fNames:array of string;
  nGages:int;
  gageNums:array of int;
  oFileName:string;
  sMethod:int; // 0=2D  1=3D  2=2_step_algorythm
  ///////////////
  sgg:array of TComplex;
  mm:int;

procedure TfmQueue.PrepData;
var i:int;
begin
  nNames:=lb1.Count;
  SetLength(fNames,nNames+1);
  for i:=1 to nNames do fNames[i]:=lb1.Items[i-1];
  ngages:=lb2.Count;
  SetLength(gageNums, nGages+1);
  for i:=1 to nGages do gageNums[i]:=StrToInt(lb2.Items[i-1]);
  oFileName:=Edit1.Text;
  sMethod:=RadioGroup1.ItemIndex;
  SetLength(sgg,ngages+1);
  pbb.Max:=nNames;
  mm:=Combobox1.ItemIndex;
end;

procedure TfmQueue.FreeData;
begin
  pbb.Position:=0;
  fnames:=nil;
  gageNums:=nil;
  oFileName:='';
  sgg:=nil;
end;

procedure TfmQueue.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmQueue:=nil;
end;

procedure TfmQueue.SpeedButton1Click(Sender: TObject);
begin
  if oDlg.Execute then
  begin
    lb1.Items.AddStrings(oDlg.Files);
  end;
end;

procedure TfmQueue.SpeedButton2Click(Sender: TObject);
var k:int;
begin
  k:=lb1.ItemIndex;
  if k>=0 then
  begin
    lb1.Items.Delete(k);
  end;
end;

procedure TfmQueue.SpeedButton3Click(Sender: TObject);
var k:int;
begin
  k:=lb1.ItemIndex;
  if k>0 then
  begin
    lb1.Items.Exchange(k,k-1);
  end;
end;

procedure TfmQueue.SpeedButton4Click(Sender: TObject);
var k:int;
begin
  k:=lb1.ItemIndex;
  if (k>=0)and(k<(lb1.Count-1)) then
  begin
    lb1.Items.Exchange(k,k+1);
  end;
end;

procedure TfmQueue.SpeedButton5Click(Sender: TObject);
begin
  if sDlg.Execute then Edit1.Text:=sDlg.FileName;
end;

procedure TfmQueue.Button1Click(Sender: TObject);
begin
  lb2.Items.Add(IntToStr(se.Value));
end;

procedure TfmQueue.Button3Click(Sender: TObject);
var k:int;
begin
  k:=lb2.ItemIndex;
  if k>=0 then lb2.Items.Delete(k);
end;

procedure TfmQueue.Button2Click(Sender: TObject);
begin
  PrepData;
  RunSolver;
  FreeData;
end;

procedure TfmQueue.RunSolver;
var i,j:int;
    w3:float;
    f:TextFile;
    rr:float;
    rm:int;
    vl3:TSolution3d;
    df:TApproximateSolution;
begin
  AssignFile(f,oFileName);
  Rewrite(f);
  writeln(f,'Data_file');
  writeln(f);
  CloseFile(f);
  for i:=1 to nNames do
  begin
    pbb.Position:=i;
    pbb.Refresh;
    ////////////////////
    // open project
    a_LoadProject_2(fNames[i]);
    if prError then exit;
    prOpened:=true;
    ProjectName:=ExtractFileName(fNames[i]);
    ProjectPath:=ExtractFilePath(fNames[i]);
    ChDir(ProjectPath);
    ////////////////////
    // solution
    Case sMethod of
      0:begin  // 2d solution
          // reassign main class variable
          mt.GenerateAllProperties(Task);
          tt.PrepareData();
          tt.nds:=false;
          tt.SetShower(nil,nil,nil);
          // prepare to solution
          tt.GenerateNodes();
          tt.GenerateTopology();
          tt.GenerateBounds(bnd2,Nbnd2);
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
          for j:=1 to nGages do
          begin
            with TSector(ob.Items[gageNums[j]])do
            begin
              rm:=iMaterial;
              rr:=(r1+r2)/2;
            end;
            sgg[j]:=GetSignal_Axial_2(rm,rr);
          end;
         ////////////////////
         // signal writing
         Append(f);
         Write(f,i:4,'.  ');
         for j:=1 to nGages do write(f,1e6*sgg[j].re:15,' ',1e6*sgg[j].im:15,'  ');
         writeln(f);
         CloseFile(f);
        end;
      1:begin
          // reassign main class variable
          mt.GenerateAllProperties(Task);
          axa.nds:=false;
          axa.SetShower(nil,nil,nil);
          // prepare to solution
          axa.PrepareData;
          axa.GenerateNodes(1,1);
          axa.GenerateTopology();
          axa.GenerateBounds(bnd3,Nbnd3);
          axa.GenerateTopMat();
          axa.GenerateSources;
          // starting solution
          vl3:=TSolution3d.Create(false);
          vl3.nds:=false;
          vl3.SetShower(nil,nil,nil,nil,nil);
          vl3.CreateAllMatrixEC;
          vl3.RunSolutionEC(ps.wError3d,ps.wMIter3d);
          vl3.Free;
          a_LoadResults(Task,0);  // full
          ///////////////////////////////////////
          for j:=1 to nGages do
          begin
            with TSector(ob.Items[gageNums[j]])do
            begin
              rm:=iMaterial;
              rr:=(r1+r2)/2;
            end;
            sgg[j]:=GetSignal_3D_1(rm,rr);
          end;
          ////////////////////
          // signal writing
          Append(f);
          Write(f,i:4,'.  ');
          for j:=1 to nGages do write(f,1e6*sgg[j].re:15,' ',1e6*sgg[j].im:15,'  ');
          writeln(f);
          CloseFile(f);
        end;
      2:begin
          // reassign main class variable
          mt.GenerateAllProperties(Task);
          tt.nds:=false;
          tt.SetShower(nil,nil,nil);
          tt.PrepareData;
          axa.nds:=false;
          axa.SetShower(nil,nil,nil);
          // prepare to solution
          tt.GenerateNodes();
          tt.GenerateTopology();
          tt.GenerateBounds(bnd2,Nbnd2);
          ///////////////
          axa.PrepareData;
          axa.GenerateNodes(1,1);
          axa.GenerateTopology();
          axa.GenerateBounds(bnd3,Nbnd3);
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
          df.nds:=false;
          df.SetShower(nil,nil,nil,nil,nil);
          df.PrepareDataEC(mm);
          df.CreateAllMatrixEC(mm);
          df.RunSolutionEC(ps.wError_d,ps.wMIter_d);
          df.Free;
          ///////////////////////////////////////
          // signal writing
          Append(f);
          Write(f,i:4,'.  ');
          a_LoadResults(Task,0);// full
          for j:=1 to nGages do
          begin
            with TSector(ob.Items[gageNums[j]])do
            begin
              rm:=iMaterial;
              rr:=(r1+r2)/2;
            end;
            sgg[j]:=GetSignal_3D_1(rm,rr);
          end;
          for j:=1 to nGages do write(f,1e6*sgg[j].re:15,' ',1e6*sgg[j].im:15,'  ');
          a_LoadResults(Task,2); // defect
          for j:=1 to nGages do
          begin
            with TSector(ob.Items[gageNums[j]])do
            begin
              rm:=iMaterial;
              rr:=(r1+r2)/2;
            end;
            sgg[j]:=GetSignal_3D_1(rm,rr);
          end;
          write(f,'* ');
          for j:=1 to nGages do write(f,1e6*sgg[j].re:15,' ',1e6*sgg[j].im:15,'  ');
          ////////////////////
          writeln(f);
          CloseFile(f);
        end;
    end;
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
end;

end.
