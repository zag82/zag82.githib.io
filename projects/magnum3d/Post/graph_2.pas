unit graph_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Series, TeEngine, TeeProcs, Chart, ExtCtrls;

type
  TfmGraph2 = class(TForm)
    Panel1: TPanel;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TPointSeries;
    CheckBox1: TCheckBox;
    Panel2: TPanel;
    scb: TScrollBar;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sDlg: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure scbChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadGraphic(d:byte);
  end;

var
  fmGraph2: TfmGraph2;

implementation

{$R *.dfm}
uses p2_data,cm_ini, cmVars, comPlx;

procedure TfmGraph2.LoadGraphic(d:byte);
var i,n,k:int;
    xx,fx:float;
begin
  // Axis names
  if d=0 then
  begin
    n:=v_nr;
    Chart1.BottomAxis.Title.Caption:='R (mm)';
  end
  else
  begin
    n:=v_nz;
    Chart1.BottomAxis.Title.Caption:='Z (mm)';
  end;
  Case p_value of
    0:case task of
        0..1:Case p_Component of
               0:Chart1.LeftAxis.Title.Caption:='D (Kl/m^2)';
               1:Chart1.LeftAxis.Title.Caption:='Dr (Kl/m^2)';
               2:Chart1.LeftAxis.Title.Caption:='Dz (Kl/m^2)';
             end;
        2,3,5:Case p_Component of
              0:Chart1.LeftAxis.Title.Caption:='B (Tesla)';
              1:Chart1.LeftAxis.Title.Caption:='Br (Tesla)';
              2:Chart1.LeftAxis.Title.Caption:='Bz (Tesla)';
            end;
      end;
    1:case task of
        0..1:Case p_Component of
               0:Chart1.LeftAxis.Title.Caption:='E (V/m)';
               1:Chart1.LeftAxis.Title.Caption:='Er (V/m)';
               2:Chart1.LeftAxis.Title.Caption:='Ez (V/m)';
             end;
        2,3,5:Case p_Component of
              0:Chart1.LeftAxis.Title.Caption:='H (A/m)';
              1:Chart1.LeftAxis.Title.Caption:='Hr (A/m)';
              2:Chart1.LeftAxis.Title.Caption:='Hz (A/m)';
            end;
      end;
    2:case task of
        0,1:Chart1.LeftAxis.Title.Caption:='fi (V)';
        2:  Chart1.LeftAxis.Title.Caption:='fi (A)';
        3,5:Chart1.LeftAxis.Title.Caption:='A (Weber/m)';
      end;
    3:Chart1.LeftAxis.Title.Caption:='Mu (Relative)';
  end;
  // values
  Series1.Clear;
  if d=0 then
  begin
    for i:=1 to n do
    begin
      k:=v_nr*(iZ-1)+i;
      fx:=GetValue(k);
      xx:=CrR[k];
      Series1.AddXY(xx*1e3,fx);
    end;
  end
  else
  begin
    for i:=1 to n do
    begin
      k:=v_nr*(i-1)+iR;
      fx:=GetValue(k);
      xx:=CrZ[k];
      Series1.AddXY(xx*1e3,fx);
    end;
  end;
  Chart1.Refresh;
  CheckBox1Click(self);   
end;

procedure TfmGraph2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if pCanClose then Action:=caFree else Action:=caMinimize;
end;

procedure TfmGraph2.CheckBox1Click(Sender: TObject);
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

procedure TfmGraph2.scbChange(Sender: TObject);
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

procedure TfmGraph2.BitBtn1Click(Sender: TObject);
var i:int;
    f:TextFile;
begin
  if sDlg.Execute then
  begin
    AssignFile(f,sDlg.FileName);
    Rewrite(f);
    writeln(f,'Graph 2d');
    writeln(f);
    writeln(f,Chart1.BottomAxis.Title.Caption,#09,Chart1.LeftAxis.Title.Caption);
    writeln(f);
    for i:=0 to Series1.Count-1 do
      writeln(f,Series1.XValue[i],#09,Series1.YValue[i]);
    CloseFile(f);
  end;
end;

end.
