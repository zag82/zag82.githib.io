unit vi_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Spin;

type
  TfmVInspector2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ud1: TUpDown;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    ud2: TUpDown;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    GroupBox6: TGroupBox;
    ComboBox5: TComboBox;
    CheckBox6: TCheckBox;
    Panel1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    uud_1: TUpDown;
    uud_2: TUpDown;
    Bevel1: TBevel;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    CheckBox7: TCheckBox;
    ComboBox6: TComboBox;
    Label15: TLabel;
    TabSheet4: TTabSheet;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    se: TSpinEdit;
    Label16: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ud1Click(Sender: TObject; Button: TUDBtnType);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ud2Click(Sender: TObject; Button: TUDBtnType);
    procedure CheckBox6Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure uud_1Click(Sender: TObject; Button: TUDBtnType);
    procedure ComboBox6Change(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadPage1;
    procedure ReadPage2;
    procedure WritePage1;
    procedure WritePage2;
    procedure ReadPage4;
    procedure WritePage4;
  end;

var
  fmVInspector2: TfmVInspector2;

implementation

{$R *.dfm}
uses p2_data, graph_2, pp_2, cm_ini, cmVars, cmData;

var aa:float;

procedure TfmVInspector2.ReadPage1;
begin
  bMesh:=CheckBox1.Checked;
  bObject:=CheckBox2.Checked;
  p_Objects:=ComboBox1.ItemIndex+1;
  bBound:=CheckBox3.Checked;
  bAxis:=CheckBox4.Checked;
  bAir:=CheckBox5.Checked;
  dd_fit:=CheckBox7.Checked;
end;

procedure TfmVInspector2.WritePage1;
begin
  CheckBox1.Checked:=bMesh;
  CheckBox2.Checked:=bObject;
  ComboBox1.ItemIndex:=p_Objects-1;
  CheckBox3.Checked:=bBound;
  CheckBox4.Checked:=bAxis;
  CheckBox5.Checked:=bAir;
  CheckBox5.Checked:=dd_fit;
end;

procedure TfmVInspector2.ReadPage2;
begin
  p_Visualization:=ComboBox2.ItemIndex;
  p_Value:=ComboBox3.ItemIndex;
  p_Component:=ComboBox4.ItemIndex;
  p_Part:=ComboBox5.ItemIndex;
end;

procedure TfmVInspector2.WritePage2;
var s1,s2:string;
    i:int;
    n:int;
begin
  Case p_Visualization of
    0:begin
        ComboBox3.Enabled:=false;
        ComboBox4.Enabled:=false;
        ComboBox5.Enabled:=false;
        bRuler:=false;
        TabSheet3.TabVisible:=false;
        TabSheet4.TabVisible:=false;
      end;
    1:begin
        ComboBox3.Enabled:=true;
        ComboBox4.Enabled:=false;
        if (Task=5) then ComboBox5.Enabled:=true else ComboBox5.Enabled:=false;
        bRuler:=false;
        TabSheet3.TabVisible:=false;
        TabSheet4.TabVisible:=false;
      end;
    2:begin
        bRuler:=CheckBox6.Checked;
        TabSheet3.TabVisible:=true;
        fmGraph2.LoadGraphic(ComboBox6.ItemIndex);
        GroupBox7.Caption:=ComboBox3.Text;
        s1:='';
        s2:='full';
        if p_Value>0 then s1:=ComboBox4.Text;
        if Task=5 then s2:=ComboBox5.Text;
        Label12.Caption:='['+s1+']'+' - '+s2;
        case ComboBox6.ItemIndex of
          0:i:=iR;
          1:i:=iZ;
        end;
        n:=iR+(iz-1)*v_nr;
        aa:=GetValue(n);
        Label14.Caption:=FloatToStrF(aa,ffGeneral,10,2);
        //
        ComboBox3.Enabled:=true;
        if p_Value<2 then ComboBox4.Enabled:=true else ComboBox4.Enabled:=false;
        if Task=5 then ComboBox5.Enabled:=true else ComboBox5.Enabled:=false;
        TabSheet4.TabVisible:=false;
      end;
    3:begin
        ComboBox3.Enabled:=true;
        if p_Value<2 then ComboBox4.Enabled:=true else ComboBox4.Enabled:=false;
        if Task=5 then ComboBox5.Enabled:=true else ComboBox5.Enabled:=false;
        bRuler:=false;
        TabSheet3.TabVisible:=false;
        TabSheet4.TabVisible:=true;
      end;
    4:begin
        ComboBox3.Enabled:=true;
        if p_Value<2 then ComboBox4.Enabled:=true else ComboBox4.Enabled:=false;
        if Task=5 then ComboBox5.Enabled:=true else ComboBox5.Enabled:=false;
        bRuler:=false;
        TabSheet3.TabVisible:=false;
        TabSheet4.TabVisible:=false;
      end;
  end;
end;

procedure TfmVInspector2.ReadPage4;
begin
  b_Gray:=CheckBox8.checked;
  b_Black:=CheckBox9.Checked;
  v_Slices:=se.Value;
end;

procedure TfmVInspector2.WritePage4;
begin
  CheckBox8.Checked:=b_Gray;
  CheckBox9.Checked:=b_Black;
  se.Value:=v_slices;
end;

procedure TfmVInspector2.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex:=0;
  TabSheet3.TabVisible:=false;
  TabSheet4.TabVisible:=false;
  pCanClose:=false;
  fmGraph2:=TfmGraph2.Create(Application);
  fmgraph2.Show;
  fmPostProcessor2:=TfmPostProcessor2.Create(Application);
  fmPostProcessor2.Show;
  ud1Click(Application,btPrev);
  ud2Click(Application,btPrev);
  ComboBox3.Items.Clear;
  with ComboBox3.Items do
  Case Task of
    0..2:begin
        Add('Flux Density');
        Add('Intensity');
        Add('Scalar potential');
        Add('MU - property');
      end;
    3:begin
        Add('Flux Density');
        Add('Intensity');
        Add('Vector potential');
        Add('MU - property');
      end;
    5:begin
        Add('Flux Density');
        Add('Intensity');
        Add('Vector potential');
      end;
  end;
  ComboBox3.ItemIndex:=0;
  ReadPage1;
  ReadPage2;
  WritePage2;
  InitData2D;
  GenerateRes2d;
  uud_1.Max:=v_nr;
  uud_2.Max:=v_nz;
  uud_1Click(Application,btPrev);
end;

procedure TfmVInspector2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeRes2d;
  pCanClose:=true;
  fmGraph2.Close;
  fmPostProcessor2.Close;
  Action:=caFree;
  fmVInspector2:=nil;
end;

procedure TfmVInspector2.ud1Click(Sender: TObject; Button: TUDBtnType);
var tt:float;
begin
  tt:=exp(abs(ud1.Position)*ln(2));
  pp_zoom:=exp(ud1.Position*ln(2));
  if ud1.Position>0 then
    Label2.Caption:=FloatToStrF(tt,ffGeneral,4,1)+':1'
  else
    Label2.Caption:='1:'+FloatToStrF(tt,ffGeneral,4,1);
end;

procedure TfmVInspector2.CheckBox1Click(Sender: TObject);
begin
  ReadPage1;
end;

procedure TfmVInspector2.Button1Click(Sender: TObject);
begin
  pp_transX:=0;
  pp_transY:=0;
end;

procedure TfmVInspector2.Button2Click(Sender: TObject);
begin
  pp_transX:=0;
  pp_transY:=0;
  ud1.Position:=0;
  ud1Click(self,btPrev);
end;

procedure TfmVInspector2.ud2Click(Sender: TObject; Button: TUDBtnType);
var tt:float;
begin
  tt:=exp(abs(ud2.Position)*ln(2));
  pp_scale:=exp(ud2.Position*ln(2))/10;
  if ud2.Position>0 then
    Label4.Caption:=FloatToStrF(tt,ffGeneral,4,1)+':1'
  else
    Label4.Caption:='1:'+FloatToStrF(tt,ffGeneral,4,1);
end;

procedure TfmVInspector2.CheckBox6Click(Sender: TObject);
begin
  bRuler:=CheckBox6.Checked;
  Panel1.Visible:=CheckBox6.Checked;
  GroupBox7.Visible:=CheckBox6.Checked;
  Label15.Visible:=bRuler;
  ComboBox6.Visible:=bRuler;
end;

procedure TfmVInspector2.ComboBox2Change(Sender: TObject);
begin
  ReadPage2;
  WritePage2;
end;

procedure TfmVInspector2.uud_1Click(Sender: TObject; Button: TUDBtnType);
var n:int;
begin
  iR:=uud_1.Position;
  iZ:=uud_2.Position;
  n:=iR+(iz-1)*v_nr;
  Label7.Caption:=FloatToStrF(crR[n]*1e3,ffFixed,8,4);
  Label10.Caption:=FloatToStrF(crZ[n]*1e3,ffFixed,8,4);
  fmGraph2.LoadGraphic(ComboBox6.ItemIndex);
  aa:=GetValue(n);
  writePage2;
end;

procedure TfmVInspector2.ComboBox6Change(Sender: TObject);
begin
  fmGraph2.LoadGraphic(ComboBox6.ItemIndex);
end;

procedure TfmVInspector2.TabSheet4Show(Sender: TObject);
begin
  WritePage4;
end;

procedure TfmVInspector2.CheckBox8Click(Sender: TObject);
begin
  ReadPage4;
end;

end.
