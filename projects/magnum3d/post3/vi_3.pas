unit vi_3;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Spin;

type
  TfmVInspector3 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ud1: TUpDown;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    GroupBox2: TGroupBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ud2: TUpDown;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Button3: TButton;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Button4: TButton;
    Button5: TButton;
    se1: TSpinEdit;
    se2: TSpinEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    se: TSpinEdit;
    cbx: TCheckBox;
    cbxColor: TCheckBox;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label19: TLabel;
    Label21: TLabel;
    GroupBox8: TGroupBox;
    cbPView: TCheckBox;
    Label20: TLabel;
    Label22: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ud1Click(Sender: TObject; Button: TUDBtnType);
    procedure ud2Click(Sender: TObject; Button: TUDBtnType);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure se2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure cbxClick(Sender: TObject);
    procedure seChange(Sender: TObject);
    procedure cbxColorClick(Sender: TObject);
    procedure cbPViewClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadPage1;
    procedure ReadPage2;
    procedure ReadPage3;
    procedure ReadPage4;
    procedure WritePage1;
    procedure WritePage2;
    procedure WritePage3;
    procedure WritePage4;
  end;

var
  fmVInspector3: TfmVInspector3;

implementation

{$R *.DFM}
uses p3_data, pp_3, graph_3, gl_ob, cmData, ComVars, cmVars;
var
  tmp1:int;
  tmp2:int;

procedure TfmVInspector3.ReadPage1;
begin
  bMesh:=CheckBox5.Checked;
  bObject:=CheckBox1.Checked;
  bBound:=CheckBox3.Checked;
  bAir:=CheckBox6.Checked;
  bLight:=CheckBox4.Checked;
  bSolid:=CheckBox2.Checked;
end;

procedure TfmVInspector3.ReadPage2;
begin
  v_Plane:=ComboBox1.ItemIndex;
  v_Visualisation:=ComboBox2.ItemIndex;
  v_Value:=ComboBox3.ItemIndex;
  v_Component:=ComboBox4.ItemIndex;
  v_Part:=ComboBox5.ItemIndex;
end;

procedure TfmVInspector3.ReadPage3;
begin
  ReadPage2;
  Case v_plane of
    0:v_Dir:=1; // Y
    1:v_Dir:=0; // X
    2:v_Dir:=0; // X
  end;
end;

procedure TfmVInspector3.ReadPage4;
begin
//  ReadPage2;
  vDir1:=UpDown1.Position;
  vDir2:=UpDown2.Position;
  vDir3:=UpDown3.Position;
end;

procedure TfmVInspector3.WritePage4;
var a:float;
    k:int;
begin
  k:=Num2Cube(vDir1,vDir2,vDir3);
  a:=GetValue(k);
  if axa.mesh_s=1 then
  begin
    Label26.Caption:=FloatToStrF(crX[k]*1e3,ffFixed,6,3);
    Label27.Caption:=FloatToStrF(crY[k]*1e3,ffFixed,6,3);
    Label28.Caption:=FloatToStrF(crZ[k]*1e3,ffFixed,6,3);
  end
  else
  begin
    Label26.Caption:=FloatToStrF(crR[k]*1e3,ffFixed,6,3);
    Label27.Caption:=FloatToStrF(crFi[k]*180/pi,ffFixed,6,2);
    Label28.Caption:=FloatToStrF(crZ[k]*1e3,ffFixed,6,3);
  end;
  GroupBox6.Caption:=ComboBox3.Text;
  if Task=5 then
    Label19.Caption:=ComboBox4.Text+' - ['+ComboBox5.Text+']'
  else
    Label19.Caption:=ComboBox4.Text;
  Label22.Caption:=FloatToStrF(a,ffGeneral,10,1);
end;

procedure TfmVInspector3.WritePage3;
var t:int;
begin
  se1.Value:=1;
  se2.Value:=1;
  Case v_Visualisation of
    0:begin                      // none
        GroupBox3.Enabled:=false;
        GroupBox4.Visible:=false;
      end;
    1:begin                      // map
        GroupBox3.Enabled:=false;
        GroupBox4.Visible:=false;
      end;
    2:begin                      // projection
        GroupBox3.Enabled:=true;
        GroupBox4.Visible:=false;
        if (axa.mesh_s<>1)and(v_Plane=1) then Label14.Caption:='deg' else Label14.Caption:='mm';
        if axa.mesh_s=1 then // carthesian
        Case v_Plane of
          0:begin se1.MaxValue:=v_nx; se1Change(Self); Label11.Caption:='X'; end;
          1:begin se1.MaxValue:=v_ny; se1Change(Self); Label11.Caption:='Y'; end;
          2:begin se1.MaxValue:=v_nz; se1Change(Self); Label11.Caption:='Z'; end;
        end
        else
        Case v_Plane of
          0:begin se1.MaxValue:=v_nx; se1Change(Self); Label11.Caption:='R';  end;
          1:begin se1.MaxValue:=v_ny; se1Change(Self); Label11.Caption:='Fi'; end;
          2:begin se1.MaxValue:=v_nz; se1Change(Self); Label11.Caption:='Z';  end;
        end;
      end;
    3:begin                     // profile
        GroupBox3.Enabled:=true;
        GroupBox4.Visible:=true;
        Button3Click(Self);
        if axa.mesh_s=1 then // carthesian
        Case v_Plane of
          0:begin se1.MaxValue:=v_nx; se1Change(Self); Label11.Caption:='X'; end;
          1:begin se1.MaxValue:=v_ny; se1Change(Self); Label11.Caption:='Y'; end;
          2:begin se1.MaxValue:=v_nz; se1Change(Self); Label11.Caption:='Z'; end;
        end
        else          // axial
        Case v_Plane of
          0:begin se1.MaxValue:=v_nx; se1Change(Self); Label11.Caption:='R';  end;
          1:begin se1.MaxValue:=v_ny; se1Change(Self); Label11.Caption:='Fi'; end;
          2:begin se1.MaxValue:=v_nz; se1Change(Self); Label11.Caption:='Z';  end;
        end;
        // for graph
        t:=3-v_Dir-v_Plane;
        Case t of
          0:begin se2.MaxValue:=v_nx; se2Change(Self);end;
          1:begin se2.MaxValue:=v_ny; se2Change(Self);end;
          2:begin se2.MaxValue:=v_nz; se2Change(Self);end;
        end;
        if axa.mesh_s=1 then // carthesian
        Case v_Dir of
          0:Label16.Caption:='X';
          1:Label16.Caption:='Y';
          2:Label16.Caption:='Z';
        end
        else         // axial
        Case v_Dir of
          0:Label16.Caption:='R';
          1:Label16.Caption:='Fi';
          2:Label16.Caption:='Z';
        end;
      end;
    4:begin // slices
        GroupBox3.Enabled:=true;
        GroupBox4.Visible:=false;
        if (axa.mesh_s<>1)and(v_Plane=1) then Label14.Caption:='deg' else Label14.Caption:='mm';
        if axa.mesh_s=1 then // carthesian
        Case v_Plane of
          0:begin se1.MaxValue:=v_nx; se1Change(Self); Label11.Caption:='X'; end;
          1:begin se1.MaxValue:=v_ny; se1Change(Self); Label11.Caption:='Y'; end;
          2:begin se1.MaxValue:=v_nz; se1Change(Self); Label11.Caption:='Z'; end;
        end
        else
        Case v_Plane of
          0:begin se1.MaxValue:=v_nx; se1Change(Self); Label11.Caption:='R';  end;
          1:begin se1.MaxValue:=v_ny; se1Change(Self); Label11.Caption:='Fi'; end;
          2:begin se1.MaxValue:=v_nz; se1Change(Self); Label11.Caption:='Z';  end;
        end;
      end;
  end;
end;

procedure TfmVInspector3.WritePage1;
begin
  CheckBox5.Checked:=bMesh;
  CheckBox1.Checked:=bObject;
  CheckBox3.Checked:=bBound;
  CheckBox6.Checked:=bAir;
  CheckBox4.Checked:=bLight;
  CheckBox2.Checked:=bSolid;
end;

procedure TfmVInspector3.WritePage2;
begin
  ComboBox1.ItemIndex:=v_Plane;
  ComboBox2.ItemIndex:=v_Visualisation;
  ComboBox3.ItemIndex:=v_Value;
  ComboBox4.ItemIndex:=v_Component;
  ComboBox5.ItemIndex:=v_Part;
  Case v_Visualisation of
    0:begin                           // none
        Combobox1.Enabled:=false;
        Combobox3.Enabled:=false;
        Combobox4.Enabled:=false;
        Combobox5.Enabled:=false;
        TabSheet3.TabVisible:=false;
        se.Enabled:=false;
        cbxColor.Enabled:=false;
        cbx.Enabled:=false;
        cbx.Checked:=false;
        cbxClick(Self);
        cbPView.Enabled:=false;
        cbPView.Checked:=false;
        cbPViewClick(Self);
      end;
    1:begin                        // map
        Combobox1.Enabled:=false;
        Combobox3.Enabled:=true;
        Combobox4.Enabled:=false;
        Combobox5.Enabled:=(Task=5);
        TabSheet3.TabVisible:=false;
        se.Enabled:=false;
        cbxColor.Enabled:=false;
        cbx.Enabled:=false;
        cbx.Checked:=false;
        cbxClick(Self);
        cbPView.Enabled:=false;
        cbPView.Checked:=false;
        cbPViewClick(Self);
      end;
    2:begin                       // projection
        Combobox1.Enabled:=true;
        Combobox3.Enabled:=true;
        Combobox4.Enabled:=false;
        Combobox5.Enabled:=(Task=5);
        TabSheet3.TabVisible:=true;
        se.Enabled:=false;
        cbxColor.Enabled:=false;
        cbx.Enabled:=false;
        cbx.Checked:=false;
        cbxClick(Self);
        cbPView.Enabled:=false;
        cbPView.Checked:=false;
        cbPViewClick(Self);
      end;
    3:begin                       // profile
        Combobox1.Enabled:=true;
        Combobox3.Enabled:=true;
        if (Task<2) and (v_Value=2) then Combobox4.Enabled:=false else Combobox4.Enabled:=true;
        Combobox5.Enabled:=(Task=5);
        TabSheet3.TabVisible:=true;
        se.Enabled:=false;
        cbxColor.Enabled:=false;
        cbx.Enabled:=true;
        cbPView.Enabled:=true;
        cbPViewClick(Self);
      end;
    4:begin                       // slices
        Combobox1.Enabled:=true;
        Combobox3.Enabled:=true;
        if (Task<2) and (v_Value=2) then Combobox4.Enabled:=false else Combobox4.Enabled:=true;
        Combobox5.Enabled:=(Task=5);
        TabSheet3.TabVisible:=true;
        se.Enabled:=true;
        cbxColor.Enabled:=true;
        cbx.Enabled:=false;
        cbx.Checked:=false;
        cbxClick(Self);
        cbPView.Enabled:=true;
        cbPViewClick(Self);
      end;
  end;
end;

procedure TfmVInspector3.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeRes3d;
  pCanClose:=true;
  fmPostProcessor3.Close;
  Action:=caFree;
  fmVInspector3:=nil;
end;

procedure TfmVInspector3.FormCreate(Sender: TObject);
begin
  InitData;
  GenerateRes3d;
  ComboBox1.Items.Clear;
  if axa.mesh_s=1 then
  begin
    ComboBox1.Items.Add('Y-Z');
    ComboBox1.Items.Add('X-Z');
    ComboBox1.Items.Add('X-Y');
  end
  else
  begin
    ComboBox1.Items.Add('Fi-Z');
    ComboBox1.Items.Add('R-Z');
    ComboBox1.Items.Add('R-Fi');
  end;
  ComboBox3.Items.Clear;
  with ComboBox3.Items do
  Case Task of
    0..2:begin
        Add('Flux Density');
        Add('Intensity');
        Add('Scalar potential');
      end;
    3:begin
        Add('Flux Density');
        Add('Intensity');
        Add('Vector potential');
      end;
    5:begin
        Add('Flux Density');
        Add('Intensity');
        Add('Vector potential');
        Add('Eddy current density');
        Add('Poynting vector');
        Add('Vector E');
      end;
  end;
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=0;
  ComboBox3.ItemIndex:=0;
  ComboBox4.ItemIndex:=0;
  ComboBox5.ItemIndex:=0;
  PageControl1.ActivePageIndex:=0;
  TabSheet3.TabVisible:=false;
  pCanClose:=false;
  fmPostProcessor3:=TfmPostProcessor3.Create(Application);
  fmPostProcessor3.Show;
  ////////////////////////
  angleX:=300;
  angleY:=0;
  angleZ:=30;
  LastX:=0;
  LastY:=0;
  Down:=false;
  transX:=0;
  transY:=0;
  ////////////////////////
    UpDown1.Max:=v_nx;
    UpDown2.Max:=v_ny;
    UpDown3.Max:=v_nz;
    UpDown1.Position:=1;
    UpDown2.Position:=1;
    UpDown3.Position:=1;
  ud1.Position:=0;
  ud2.Position:=0;
  ud1Click(Application,btPrev);
  ud2Click(Application,btPrev);
  ReadPage1;
  WritePage1;
  ReadPage2;
  WritePage2;
  ReadPage3;
  WritePage3;
  seChange(Self);
  cbxColorClick(Self);
end;

procedure TfmVInspector3.ud1Click(Sender: TObject; Button: TUDBtnType);
var tt:float;
begin
  tt:=exp(abs(ud1.Position)*ln(2));
  pr_zoom:=exp(ud1.Position*ln(2));
  if ud1.Position>0 then
    Label2.Caption:=FloatToStrF(tt,ffGeneral,4,1)+':1'
  else
    Label2.Caption:='1:'+FloatToStrF(tt,ffGeneral,4,1);
end;

procedure TfmVInspector3.ud2Click(Sender: TObject; Button: TUDBtnType);
var tt:float;
begin
  tt:=exp(abs(ud2.Position)*ln(2));
  pr_scale:=exp(ud2.Position*ln(2));
  if ud2.Position>0 then
    Label4.Caption:=FloatToStrF(tt,ffGeneral,4,1)+':1'
  else
    Label4.Caption:='1:'+FloatToStrF(tt,ffGeneral,4,1);
end;

procedure TfmVInspector3.CheckBox1Click(Sender: TObject);
begin
  ReadPage1;
  WritePage1;
end;

procedure TfmVInspector3.Button1Click(Sender: TObject);
begin
  transX:=0;
  transY:=0;
end;

procedure TfmVInspector3.Button2Click(Sender: TObject);
begin
  ud1.Position:=0;
  ud1Click(self,btPrev);
  angleX:=300;
  angleY:=0;
  angleZ:=30;
end;

procedure TfmVInspector3.SpeedButton1Click(Sender: TObject);
begin
  if (angleX=90)and(angleY=0)and(angleZ=270) then
  begin
    AngleX:=270;
    AngleY:=0;
    AngleZ:=270;
  end
  else
  begin
    AngleX:=90;
    AngleY:=0;
    AngleZ:=270;
  end;
end;

procedure TfmVInspector3.SpeedButton2Click(Sender: TObject);
begin
  if (angleX=90)and(angleY=0)and(angleZ=180) then
  begin
    AngleX:=270;
    AngleY:=0;
    AngleZ:=180;
  end
  else
  begin
    AngleX:=90;
    AngleY:=0;
    AngleZ:=180;
  end;
end;

procedure TfmVInspector3.SpeedButton3Click(Sender: TObject);
begin
  if (angleX=0)and(angleY=0)and(angleZ=0) then
  begin
    AngleX:=180;
    AngleY:=0;
    AngleZ:=0;
  end
  else
  begin
    AngleX:=0;
    AngleY:=0;
    AngleZ:=0;
  end;
end;

procedure TfmVInspector3.ComboBox1Change(Sender: TObject);
begin
  ReadPage2;
  WritePage2;
  ReadPage3;
  WritePage3;
end;

procedure TfmVInspector3.se1Change(Sender: TObject);
var k:int;
begin
  if se1.Value>se1.MaxValue then se1.Value:=1;
  v_ProfDist:=se1.Value;
  if axa.mesh_s=1 then
  Case v_Plane of
    0:begin k:=Num2Cube(se1.Value,1,1); Label13.Caption:=FloatToStrF(crX[k]*1e3,ffFixed,6,3); end;
    1:begin k:=Num2Cube(1,se1.Value,1); Label13.Caption:=FloatToStrF(crY[k]*1e3,ffFixed,6,3); end;
    2:begin k:=Num2Cube(1,1,se1.Value); Label13.Caption:=FloatToStrF(crZ[k]*1e3,ffFixed,6,3); end;
  end
  else
  Case v_Plane of
    0:begin k:=Num2Cube(se1.Value,1,1); Label13.Caption:=FloatToStrF(crR[k]*1e3,ffFixed,6,3); end;
    1:begin k:=Num2Cube(1,se1.Value,1); Label13.Caption:=FloatToStrF(crFi[k]/pi*180,ffFixed,6,3); end;
    2:begin k:=Num2Cube(1,1,se1.Value); Label13.Caption:=FloatToStrF(crZ[k]*1e3,ffFixed,6,3); end;
  end;
  bGraphReDraw:=true;
end;

procedure TfmVInspector3.Button3Click(Sender: TObject);
var t:int;
begin
  // x=0  y=1  z=2
  Case v_plane of
    0:if v_Dir=1 then v_Dir:=2 else v_dir:=1; // Y-Z
    1:if v_Dir=0 then v_Dir:=2 else v_Dir:=0; // X-Z
    2:if v_Dir=0 then v_Dir:=1 else v_Dir:=0; // X-Y
  end;
  t:=3-v_Dir-v_Plane;
  Case t of
    0:begin se2.MaxValue:=v_nx; se2Change(Self); end;
    1:begin se2.MaxValue:=v_ny; se2Change(Self); end;
    2:begin se2.MaxValue:=v_nz; se2Change(Self); end;
  end;
  if axa.mesh_s=1 then // carthesian
  Case v_Dir of
    0:Label16.Caption:='X';
    1:Label16.Caption:='Y';
    2:Label16.Caption:='Z'; 
  end
  else         // axial
  Case v_Dir of
    0:Label16.Caption:='R';
    1:Label16.Caption:='Fi';
    2:Label16.Caption:='Z';
  end;
  bGraphReDraw:=true;
end;

procedure TfmVInspector3.se2Change(Sender: TObject);
var k,t:int;
begin
  if se2.Value>se2.MaxValue then se2.Value:=1;
  v_GrapDist:=se2.Value;
  t:=3-v_Dir-v_Plane;
  if (axa.mesh_s<>1) and (t=1) then Label18.Caption:='deg' else Label18.Caption:='mm';
  if axa.mesh_s=1 then
  Case t of
    0:begin k:=Num2Cube(se2.Value,1,1); Label17.Caption:=FloatToStrF(crX[k]*1e3,ffFixed,6,3); end;
    1:begin k:=Num2Cube(1,se2.Value,1); Label17.Caption:=FloatToStrF(crY[k]*1e3,ffFixed,6,3); end;
    2:begin k:=Num2Cube(1,1,se2.Value); Label17.Caption:=FloatToStrF(crZ[k]*1e3,ffFixed,6,3); end;
  end
  else
  Case t of
    0:begin k:=Num2Cube(se2.Value,1,1); Label17.Caption:=FloatToStrF(crR[k]*1e3,ffFixed,6,3); end;
    1:begin k:=Num2Cube(1,se2.Value,1); Label17.Caption:=FloatToStrF(crFi[k]/pi*180,ffFixed,6,3); end;
    2:begin k:=Num2Cube(1,1,se2.Value); Label17.Caption:=FloatToStrF(crZ[k]*1e3,ffFixed,6,3); end;
  end;
  bGraphReDraw:=true;
end;

procedure TfmVInspector3.Timer1Timer(Sender: TObject);
begin
  if se1.Value<se1.MaxValue then se1.Value:=se1.Value+1 else begin se1.Value:=tmp1; timer1.Enabled:=false; end;
  se1Change(self);
end;

procedure TfmVInspector3.Button4Click(Sender: TObject);
begin
  tmp1:=se1.Value;
  se1.Value:=1;
  se1Change(self);
  Timer1.Enabled:=true;
end;

procedure TfmVInspector3.Timer2Timer(Sender: TObject);
begin
  if se2.Value<se2.MaxValue then se2.Value:=se2.Value+1 else begin se2.Value:=tmp2; timer2.Enabled:=false; end;
  se2Change(self);
end;

procedure TfmVInspector3.Button5Click(Sender: TObject);
begin
  tmp2:=se2.Value;
  se2.Value:=1;
  se2Change(self);
  Timer2.Enabled:=true;
end;

procedure TfmVInspector3.cbxClick(Sender: TObject);
begin
  if cbx.Checked then
  begin
    fmGraph3:=TfmGraph3.Create(Self);
    fmGraph3.LoadGraphic;
    fmGraph3.Show;
  end
  else
  begin
    pCanClose:=true;
    if fmGraph3<>nil then fmGraph3.Close;
    pCanClose:=false;
  end;
end;

procedure TfmVInspector3.seChange(Sender: TObject);
begin
  slNum:=se.Value;
end;

procedure TfmVInspector3.cbxColorClick(Sender: TObject);
begin
  bslColor:=cbxColor.Checked;
end;

procedure TfmVInspector3.cbPViewClick(Sender: TObject);
begin
  bValue:=cbPView.Checked;
  if bValue then
  begin
    GroupBox6.Visible:=true;
    GroupBox7.Visible:=true;
    if axa.mesh_s=1 then // cubes
    begin
      Label23.Caption:='X (mm) :';
      Label24.Caption:='Y (mm) :';
      Label25.Caption:='Z (mm) :';
    end
    else
    begin
      Label23.Caption:='R (mm) :';
      Label24.Caption:='Fi (deg) :';
      Label25.Caption:='Z (mm) :';
    end;
    UpDown1Click(Self,btPrev);
  end
  else
  begin
    GroupBox6.Visible:=false;
    GroupBox7.Visible:=false;
  end;
end;

procedure TfmVInspector3.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  ReadPage4;
  WritePage4;
end;

end.
