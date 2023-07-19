unit DataMod;

interface

uses
  SysUtils, Classes, DB, dxmdaset;

type
  Tdm = class(TDataModule)
    mdFilterType: TdxMemData;
    mdFilterTypeID: TIntegerField;
    mdFilterTypeNAME: TStringField;
    dsFilterType: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isLicenced: boolean;
  end;

var
  dm: Tdm;

implementation

uses licGrd, Dialogs, Forms;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  lv := TLicenseValidator.Create();
  isLicenced := lv.isLicenseValid();
  if isLicenced then
    mdFilterType.Open
  else
  begin
    ShowMessage('Ключ защиты не обнаружен. Программа будет закрыта.');
    Application.Terminate;
  end;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  mdFilterType.Close;
end;

end.
