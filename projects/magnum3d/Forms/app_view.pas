unit app_view;

interface

uses cmVars,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmSolveView = class(TForm)
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadCoordinates;
  end;

var
  fmSolveView: TfmSolveView;

implementation

{$R *.DFM}
uses vi_3, comVars, p3_data, Compute_VectorsUnit, cm_ini, cmData;

procedure TfmSolveView.Button2Click(Sender: TObject);
begin
  Close
end;

procedure TfmSolveView.LoadCoordinates;
begin
  axa.nds:=false;
  axa.SetShower(nil,nil,nil);
  axa.PrepareData;
  axa.GenerateNodes(1,1);
  axa.GenerateTopology;
  axa.GenerateTopMat;
end;

procedure TfmSolveView.Button1Click(Sender: TObject);
var i:int;
begin
  LoadCoordinates;
  a_LoadResults(Task,RadioGroup1.ItemIndex);
  SetLength(Hm,NElements+1);
  for i:=1 to NElements do
  begin
    Compute_Vectors(i);
    Hm[i]:=sqrt(sqr(HIntensity_X)+sqr(HIntensity_Y)+sqr(HIntensity_Z));
  end;
  if fmVInspector3<>nil then
  begin
    InitData;
    GenerateRes3d;
  end;
end;

procedure TfmSolveView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
  fmSolveView:=nil;
end;

end.
