unit opt_view;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TfmOpView = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmOpView: TfmOpView;

implementation

{$R *.dfm}

end.
