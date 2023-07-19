unit graph_3;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Buttons;

type
  TfmGraph3 = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    scb: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Series2: TPointSeries;
    sDlg: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure scbChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadGraphic;
  end;

var
  fmGraph3: TfmGraph3;

implementation

{$R *.DFM}
uses p3_data, cmVars;

procedure TfmGraph3.LoadGraphic;
var i:int;
    vv,v1:float;
    s:string;
begin
  s:='';
  Case Task of
    0,1:Case V_Value of
        0:Case v_Component of
            0:s:='D (Kl/m^2)';
            1:s:='Dx (Kl/m^2)';
            2:s:='Dy (Kl/m^2)';
            3:s:='Dz (Kl/m^2)';
            4:s:='Dr (Kl/m^2)';
            5:s:='Dfi (Kl/m^2)';
            6:s:='Dz (Kl/m^2)';
          end;
        1:Case v_Component of
            0:s:='E (V/m)';
            1:s:='Ex (V/m)';
            2:s:='Ey (V/m)';
            3:s:='Ez (V/m)';
            4:s:='Er (V/m)';
            5:s:='Efi (V/m)';
            6:s:='Ez (V/m)';
          end;
        2:s:='fi (V)';
      end;
    2:Case V_Value of
        0:Case v_Component of
            0:s:='B (Tesla)';
            1:s:='Bx (Tesla)';
            2:s:='By (Tesla)';
            3:s:='Bz (Tesla)';
            4:s:='Br (Tesla)';
            5:s:='Bfi (Tesla)';
            6:s:='Bz (Tesla)';
          end;
        1:Case v_Component of
            0:s:='H (A/m)';
            1:s:='Hx (A/m)';
            2:s:='Hy (A/m)';
            3:s:='Hz (A/m)';
            4:s:='Hr (A/m)';
            5:s:='Hfi (A/m)';
            6:s:='Hz (A/m)';
          end;
        2:s:='fi (A)';
      end;
    3:Case V_Value of
        0:Case v_Component of
            0:s:='B (Tesla)';
            1:s:='Bx (Tesla)';
            2:s:='By (Tesla)';
            3:s:='Bz (Tesla)';
            4:s:='Br (Tesla)';
            5:s:='Bfi (Tesla)';
            6:s:='Bz (Tesla)';
          end;
        1:Case v_Component of
            0:s:='H (A/m)';
            1:s:='Hx (A/m)';
            2:s:='Hy (A/m)';
            3:s:='Hz (A/m)';
            4:s:='Hr (A/m)';
            5:s:='Hfi (A/m)';
            6:s:='Hz (A/m)';
          end;
        2:Case v_Component of
            0:s:='A (Weber/m)';
            1:s:='Ax (Weber/m)';
            2:s:='Ay (Weber/m)';
            3:s:='Az (Weber/m)';
            4:s:='Ar (Weber/m)';
            5:s:='Afi (Weber/m)';
            6:s:='Az (Weber/m)';
          end;
      end;
    5:Case V_Value of
        0:Case v_Component of
            0:s:='B (Tesla)';
            1:s:='Bx (Tesla)';
            2:s:='By (Tesla)';
            3:s:='Bz (Tesla)';
            4:s:='Br (Tesla)';
            5:s:='Bfi (Tesla)';
            6:s:='Bz (Tesla)';
          end;
        1:Case v_Component of
            0:s:='H (A/m)';
            1:s:='Hx (A/m)';
            2:s:='Hy (A/m)';
            3:s:='Hz (A/m)';
            4:s:='Hr (A/m)';
            5:s:='Hfi (A/m)';
            6:s:='Hz (A/m)';
          end;
        2:Case v_Component of
            0:s:='A (Weber/m)';
            1:s:='Ax (Weber/m)';
            2:s:='Ay (Weber/m)';
            3:s:='Az (Weber/m)';
            4:s:='Ar (Weber/m)';
            5:s:='Afi (Weber/m)';
            6:s:='Az (Weber/m)';
          end;
      end;
  end;
  Chart1.LeftAxis.Title.Caption:=s;
  if axa.mesh_s=1 then
  Case v_Dir of
    0:Chart1.BottomAxis.Title.Caption:='X (mm)';
    1:Chart1.BottomAxis.Title.Caption:='Y (mm)';
    2:Chart1.BottomAxis.Title.Caption:='Z (mm)';
  end
  else
  Case v_Dir of
    0:Chart1.BottomAxis.Title.Caption:='R (mm)';
    1:Chart1.BottomAxis.Title.Caption:='Fi (deg)';
    2:Chart1.BottomAxis.Title.Caption:='Z (mm)';
  end;
  // values
  Series1.Clear;
  for i:=1 to gr_Num do
  begin
    if (axa.mesh_s=0)and(v_Dir=2) then v1:=grVal_X[i]/pi*180 else v1:=grVal_X[i]*1e3;
    vv:=grVal_Y[i];
    Series1.AddXY(v1,vv);
  end;
  Chart1.Refresh;
  CheckBox1Click(self);
end;

procedure TfmGraph3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if pCanClose then Action:=caFree else Action:=caMinimize;
end;

procedure TfmGraph3.CheckBox1Click(Sender: TObject);
var k:boolean;
begin
  k:=CheckBox1.Checked;
  Panel2.Visible:=k;
  if k then
  begin
    Series2.Clear;
    Series2.AddXY(0,0);
    scb.Max:=Series1.XValues.Count;
    scb.Position:=1;
    scbChange(Application);
  end
  else
  begin
    Series2.Clear;
  end;
end;

procedure TfmGraph3.scbChange(Sender: TObject);
var k:int;
begin
  label1.Caption:=Chart1.BottomAxis.Title.Caption+' = ';
  label3.Caption:=Chart1.LeftAxis.Title.Caption+' = ';
  With Series2 do
  begin
    k:=scb.Position;
    XValue[0]:=Series1.XValue[k-1];
    YValue[0]:=Series1.YValue[k-1];
    Label2.Caption:=FloatToStrF(XValue[0],ffGeneral,6,2);
    Label4.Caption:=FloatToStrF(YValue[0],ffGeneral,10,2);
  end;
end;

procedure TfmGraph3.BitBtn1Click(Sender: TObject);
var i:int;
    f:TextFile;
begin
  if sDlg.Execute then
  begin
    AssignFile(f,sDlg.FileName);
    Rewrite(f);
    writeln(f,'Graph 3d');
    writeln(f);
    writeln(f,Chart1.BottomAxis.Title.Caption,#09,Chart1.LeftAxis.Title.Caption);
    writeln(f);
    for i:=0 to Series1.Count-1 do
      writeln(f,Series1.XValue[i],#09,Series1.YValue[i]);
    CloseFile(f);
  end;
end;

end.
