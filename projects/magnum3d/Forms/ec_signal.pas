unit ec_signal;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TOldObject=record
    nm:string;
    num:int;
    k:byte; // sort of object ( block or sector )
    z1,z2:float;
  end;

  TfmSignal = class(TForm)
    Memo1: TMemo;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Bevel1: TBevel;
    SpeedButton3: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ComboBox2: TComboBox;
    Label3: TLabel;
    ComboBox1: TComboBox;
    SpeedButton4: TSpeedButton;
    sDlg: TSaveDialog;
    Edit1: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GageCount:int;
    Gage:array of TOldObject;
  end;

var
  fmSignal: TfmSignal;

implementation

{$R *.dfm}
uses complx, cmData,cmVars,cmProc, ec_main2d, comvars;

procedure TfmSignal.FormCreate(Sender: TObject);
var i:int;
begin
  Memo1.Lines.Clear;
  with memo1.Lines do
  begin
    Add(' === Calculating signals induced on gage === ');
    Add('');
  end;
  for i:=0 to ob.Count-1 do ListBox2.Items.Add(TMgObject(ob.Items[i]).Name);
  ActiveControl:=ListBox1;
end;

procedure TfmSignal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmSignal:=nil;
end;

procedure TfmSignal.Button1Click(Sender: TObject);
var
  mm,k:int;  // material and task
  i,j,e:int;
  rr:float;
  rm:int;
  res:TComplex;
  secs:array of int;
begin
  Gage:=nil;
  mm:=ComboBox1.ItemIndex+1;
  k:=ComboBox2.ItemIndex+1;
  // gage paramters
  GageCount:=ListBox1.Items.Count;
  SetLength(Gage,GageCount);
  // filling
  for i:=0 to GageCount-1 do
  begin
    e:=0;
    for j:=0 to ob.Count-1 do
      if TMgObject(ob.Items[j]).Name=ListBox1.Items[i] then
        e:=j;
    gage[i].nm:=ListBox1.Items[i];
    gage[i].num:=e;
    if TMgObject(ob.Items[e])is TBlock then
    begin
      gage[i].k:=1;
      gage[i].z1:=TBlock(ob.Items[e]).z_1;
      gage[i].z2:=TBlock(ob.Items[e]).z_2;
    end
    else
    begin
      gage[i].k:=2;
      gage[i].z1:=TSector(ob.Items[e]).zz;
      gage[i].z2:=0.0;
    end;
  end;
  // main calculations
  with TSector(ob.Items[gage[0].num])do
  begin
    rm:=imaterial;
    rr:=(r1+r2)/2;
  end;
  SetLength(secs,GageCount+1);
  for j:=1 to GageCount do secs[j]:=gage[j-1].num;
  case k of
    1:Memo1.Lines.Add('2d calculations');
    2:Memo1.Lines.Add('3d calculations');
  end;
  case mm of
    1:Memo1.Lines.Add('+-- Standard');
    2:Memo1.Lines.Add('+-- Average');
    3:Memo1.Lines.Add('+-- Weight');
  end;
  Case k of
    1:Case mm of // 2d
        1:if TFlatECTask(tt).Vmatr<>nil then res:=GetSignal_Axial_1(rm);
        2:if TFlatECTask(tt).Vmatr<>nil then res:=GetSignal_Axial_2(rm,rr);
        3:if TFlatECTask(tt).Vmatr<>nil then res:=GetSignal_Axial(rm,rr);
      end;
    2:case mm of // 3d
        1:if Result_xc<>nil then res:=GetSignal_3d_2(rm,secs,GageCount);
        2:if Result_xc<>nil then res:=GetSignal_3d_1(rm,rr);
        3:if Result_xc<>nil then res:=GetSignal_3D(rm,rr);
      end;
  end;
  res:=CMul(res,CConv(StrToFloat(Edit1.Text)));
  with Memo1.Lines do
  begin
    Add('    +-- Re : '+FloatToStrF(res.re*1e3,ffGeneral,8,1)+' (mV)');
    Add('    +-- Im : '+FloatToStrF(res.im*1e3,ffGeneral,8,1)+' (mV)');
    Add('    +--------------------');
    Add('    +-- Amplitude : '+FloatToStrF(CAbs(res)*1e3,ffGeneral,8,1)+' (mV)');
    Add('    +--     Phase : '+FloatToStrF(CPhaseD(res),ffFixed,8,3)+' (degrees)');
    Add('    +--------------------');
    Add('');
  end;
  // releasing gage
  for i:=0 to GageCount-1 do
    if gage[i].k=1 then //block
    begin
      TBlock(ob.Items[gage[i].num]).z_1:=gage[i].z1;
      TBlock(ob.Items[gage[i].num]).z_2:=gage[i].z2;
    end
    else  // sector
    begin
      TSector(ob.Items[gage[i].num]).zz:=gage[i].z1;
    end;
  gage:=nil;
  secs:=nil;
end;

procedure TfmSignal.SpeedButton4Click(Sender: TObject);
begin
  if sDlg.Execute then Memo1.Lines.SaveToFile(sDlg.FileName);
end;

procedure TfmSignal.Button2Click(Sender: TObject);
begin
  // releasing variables
  Gage:=nil;
  // close form method
  Close;
end;

procedure TfmSignal.SpeedButton2Click(Sender: TObject);
var k:int;
begin
  k:=ListBox2.ItemIndex;
  if k>=0 then
    ListBox1.Items.Add(ListBox2.Items[k]);
end;

procedure TfmSignal.SpeedButton1Click(Sender: TObject);
var k:int;
begin
  k:=ListBox1.ItemIndex;
  if k>=0 then
    ListBox1.Items.Delete(k);
end;

procedure TfmSignal.SpeedButton3Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

end.
