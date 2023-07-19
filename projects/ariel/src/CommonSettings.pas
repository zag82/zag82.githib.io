unit CommonSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, detail_editor, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Menus, ActnList, StdCtrls, cxButtons, ExtCtrls, cxControls, cxContainer,
  cxEdit, dxLayoutContainer, dxLayoutcxEditAdapters, cxDropDownEdit, cxDBEdit, dxLayoutControl,
  cxTextEdit, cxMaskEdit, DB, dxmdaset, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxCalc, cxCheckBox;

type
  TfmCommonSettings = class(TfmDetailEditor)
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    cxDBMaskEdit1: TcxDBMaskEdit;
    dxLayoutControl1Item1: TdxLayoutItem;
    cxDBMaskEdit2: TcxDBMaskEdit;
    dxLayoutControl1Item2: TdxLayoutItem;
    cxDBMaskEdit3: TcxDBMaskEdit;
    dxLayoutControl1Item3: TdxLayoutItem;
    cxDBMaskEdit4: TcxDBMaskEdit;
    dxLayoutControl1Item4: TdxLayoutItem;
    cxDBTextEdit1: TcxDBTextEdit;
    dxLayoutControl1Item5: TdxLayoutItem;
    cxDBComboBox1: TcxDBComboBox;
    dxLayoutControl1Item6: TdxLayoutItem;
    cxDBTextEdit2: TcxDBTextEdit;
    dxLayoutControl1Item7: TdxLayoutItem;
    cxDBTextEdit3: TcxDBTextEdit;
    dxLayoutControl1Item8: TdxLayoutItem;
    dxLayoutControl1Group1: TdxLayoutGroup;
    dxLayoutControl1Group2: TdxLayoutGroup;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    dxLayoutControl1Item9: TdxLayoutItem;
    mdPriority: TdxMemData;
    dsPriority: TDataSource;
    mdPriorityID: TIntegerField;
    mdPriorityNAME: TStringField;
    mdCondition: TdxMemData;
    dsCondition: TDataSource;
    cxDBCheckBox1: TcxDBCheckBox;
    dxLayoutControl1Item10: TdxLayoutItem;
    cxDBCheckBox2: TcxDBCheckBox;
    dxLayoutControl1Item11: TdxLayoutItem;
    cxDBLookupComboBox2: TcxDBLookupComboBox;
    dxLayoutControl1Item12: TdxLayoutItem;
    cxDBCalcEdit1: TcxDBCalcEdit;
    dxLayoutControl1Item13: TdxLayoutItem;
    dxLayoutControl1Group4: TdxLayoutGroup;
    cxDBCheckBox3: TcxDBCheckBox;
    dxLayoutControl1Item14: TdxLayoutItem;
    cxDBLookupComboBox3: TcxDBLookupComboBox;
    dxLayoutControl1Item15: TdxLayoutItem;
    cxDBCalcEdit2: TcxDBCalcEdit;
    dxLayoutControl1Item16: TdxLayoutItem;
    dxLayoutControl1Group5: TdxLayoutGroup;
    dxLayoutControl1Group6: TdxLayoutGroup;
    cxDBComboBox2: TcxDBComboBox;
    dxLayoutControl1Item17: TdxLayoutItem;
    dxLayoutControl1Group7: TdxLayoutGroup;
    mdConditionID: TIntegerField;
    mdConditionNAME: TStringField;
    mdPart: TdxMemData;
    dsPart: TDataSource;
    cxDBLookupComboBox4: TcxDBLookupComboBox;
    dxLayoutControl1Item18: TdxLayoutItem;
    mdPartID: TIntegerField;
    mdPartNAME: TStringField;
    mdTriggerType: TdxMemData;
    cxDBLookupComboBox5: TcxDBLookupComboBox;
    dxLayoutControl1Item19: TdxLayoutItem;
    dsTriggerType: TDataSource;
    mdTriggerTypeID: TIntegerField;
    mdTriggerTypeNAME: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCommonSettings: TfmCommonSettings;

implementation

uses MainArielAq;

{$R *.dfm}

procedure TfmCommonSettings.FormCreate(Sender: TObject);
begin
  inherited;
  mdPriority.Open;
  mdCondition.Open;
  mdPart.Open;
  mdTriggerType.Open;
end;

end.
