unit test;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, TeEngine, Series, TeeProcs, Chart, StdCtrls,
  cxButtons, cxTextEdit, cxLabel, cxMaskEdit, cxDropDownEdit, ExtCtrls,
  SignalData;

type
  TfmTest = class(TForm)
    Panel1: TPanel;
    cxComboBox1: TcxComboBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxTextEdit1: TcxTextEdit;
    cxTextEdit2: TcxTextEdit;
    cxButton1: TcxButton;
    Panel2: TPanel;
    Chart1: TChart;
    Chart2: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Series6: TFastLineSeries;
    procedure cxButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sa: TSignalData;
  end;

var
  fmTest: TfmTest;

implementation

{$R *.dfm}
uses MainAriel, complx;

procedure TfmTest.cxButton1Click(Sender: TObject);
var
  i, j, p1, p2: integer;
  bSignal: boolean;
  avg: TComplex;
  x, y: array of double;
  pd: TDefectParams;

  ich: integer;
  th: double;
  msk: double;
begin
(*  iCh := cxComboBox1.ItemIndex;
  msk := StrToFloat(cxTextEdit1.Text);
  th := StrToFloat(cxTextEdit2.Text);
  ///
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  Series6.Clear;
  // обрабатываем
    // выделяем память под 2 массива
    SetLength(x, sa.Count);
    SetLength(y, sa.Count);
    // производим выделение дефектов на активных дифференциальных каналах
    sa.ProcessingDefects.Clear;
    sa.ProcessingDefects.AddRange(sa.RunDefectExtractorGauss(th, msk, ich, x, y));
    // сортируем индикации и объединяем пересекающиеся
    for i := 0 to sa.ProcessingDefects.Count - 1 do
    begin
      pd := sa.ProcessingDefects.Items[i];
      pd.posx := (sa.ProcessingDefects.Items[i].pos1 + sa.ProcessingDefects.Items[i].pos2) div 2;
      pd.nProbesIndication := 0;
      sa.ProcessingDefects.Items[i] := pd;
    end;
    sa.QSort(sa.ProcessingDefects, 0, sa.ProcessingDefects.Count - 1);
    // сбор всех рамок в один массив
    i := 0;
    while i < sa.ProcessingDefects.Count do
    begin
      if sa.ProcessingDefects.Items[i].nProbesIndication = 0 then
      begin
        for j := i + 1 to sa.ProcessingDefects.Count - 1 do
          if ((sa.ProcessingDefects.Items[j].pos1 <= sa.ProcessingDefects.Items[i].pos1) and (sa.ProcessingDefects.Items[i].pos1 <= sa.ProcessingDefects.Items[j].pos2)) or
             ((sa.ProcessingDefects.Items[j].pos1 <= sa.ProcessingDefects.Items[i].pos2) and (sa.ProcessingDefects.Items[i].pos2 <= sa.ProcessingDefects.Items[j].pos2)) then
          begin
            pd := sa.ProcessingDefects.Items[j];
            pd.nProbesIndication := -1;
            sa.ProcessingDefects.Items[j] := pd;
            pd := sa.ProcessingDefects.Items[i];
            pd.pos1 := min(sa.ProcessingDefects.Items[i].pos1, sa.ProcessingDefects.Items[j].pos1);
            pd.pos2 := max(sa.ProcessingDefects.Items[i].pos2, sa.ProcessingDefects.Items[j].pos2);
            sa.ProcessingDefects.Items[i] := pd;
          end;
      end;
      i := i + 1;
    end;
    // удаляем лишнее
    i := 0;
    while i < sa.ProcessingDefects.Count do
    begin
      if sa.ProcessingDefects.Items[i].nProbesIndication < 0 then
        sa.ProcessingDefects.Delete(i)
      else
        i := i + 1;
    end;
  // рисуем
  for i := sa.ProcessingParams.position1 to sa.ProcessingParams.position2 do
  begin
    Series1.AddXY(i, sa.getData(iCh,i, false).re);
    Series2.AddXY(i, x[i]);
    Series4.AddXY(i, sa.getData(iCh,i, false).im);
    Series5.AddXY(i, y[i]);
  end;
  Series3.AddXY(sa.ProcessingParams.position1, 0);
  Series6.AddXY(sa.ProcessingParams.position1, 0);
  for i := 0 to sa.ProcessingDefects.Count - 1 do
  begin
    Series3.AddXY(sa.ProcessingDefects.Items[i].pos1, 0);
    Series3.AddXY(sa.ProcessingDefects.Items[i].pos1, th);
    Series3.AddXY(sa.ProcessingDefects.Items[i].pos2, th);
    Series3.AddXY(sa.ProcessingDefects.Items[i].pos2, 0);

    Series6.AddXY(sa.ProcessingDefects.Items[i].pos1, 0);
    Series6.AddXY(sa.ProcessingDefects.Items[i].pos1, th);
    Series6.AddXY(sa.ProcessingDefects.Items[i].pos2, th);
    Series6.AddXY(sa.ProcessingDefects.Items[i].pos2, 0);
  end;

  Series3.AddXY(sa.ProcessingParams.position2, 0);
  Series6.AddXY(sa.ProcessingParams.position2, 0);
  // очищаем
  x := nil;
  y := nil;    *)
end;

procedure TfmTest.FormCreate(Sender: TObject);
begin
  sa := fmMainAriel.signalAnalyse;
end;

procedure TfmTest.Panel2Resize(Sender: TObject);
begin
  Chart1.Height := panel2.Height div 2;
end;

end.
