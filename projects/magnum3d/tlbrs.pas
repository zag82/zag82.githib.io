unit tlbrs;

interface

uses main,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmToolBars = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmToolBars: TfmToolBars;

implementation

{$R *.dfm}

procedure TfmToolBars.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmToolBars.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmToolBars.FormCreate(Sender: TObject);
begin
  CheckBox1.Checked:=fmMain.ToolBar2.Visible;
  CheckBox2.Checked:=fmMain.ToolBar1.Visible;
  CheckBox3.Checked:=fmMain.ToolBar4.Visible;
  CheckBox4.Checked:=fmMain.ToolBar3.Visible;
  CheckBox5.Checked:=fmMain.ToolBar5.Visible;
end;

procedure TfmToolBars.CheckBox1Click(Sender: TObject);
begin
  fmMain.ToolBar2.Visible:=CheckBox1.Checked;
end;

procedure TfmToolBars.CheckBox2Click(Sender: TObject);
begin
  fmMain.ToolBar1.Visible:=CheckBox2.Checked;
end;

procedure TfmToolBars.CheckBox3Click(Sender: TObject);
begin
  fmMain.ToolBar4.Visible:=CheckBox3.Checked;
end;

procedure TfmToolBars.CheckBox4Click(Sender: TObject);
begin
  fmMain.ToolBar3.Visible:=CheckBox4.Checked;
end;

procedure TfmToolBars.CheckBox5Click(Sender: TObject);
begin
  fmMain.ToolBar5.Visible:=CheckBox5.Checked;
end;

end.
