unit ModuleCh;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, detail_editor, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls,
  cxButtons, Vcl.ExtCtrls, cxControls, dxLayoutContainer, dxLayoutControl,
  cxContainer, cxEdit, dxLayoutcxEditAdapters, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMaskEdit, cxSpinEdit,
  cxDBEdit;

type
  TfmModuleCh = class(TfmDetailEditor)
    Bevel1: TBevel;
    lcmainGroup_Root: TdxLayoutGroup;
    lcmain: TdxLayoutControl;
    cxDBSpinEdit1: TcxDBSpinEdit;
    lcmainItem1: TdxLayoutItem;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    lcmainItem2: TdxLayoutItem;
    cxDBSpinEdit2: TcxDBSpinEdit;
    lcmainItem3: TdxLayoutItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmModuleCh: TfmModuleCh;

implementation

{$R *.dfm}

uses CommonSettings, MainEloAq, DataMod;

end.
