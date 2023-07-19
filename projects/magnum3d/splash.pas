unit splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TfmSplash = class(TForm)
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    lb: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSplash: TfmSplash;

implementation

{$R *.DFM}

procedure TfmSplash.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmSplash.FormCreate(Sender: TObject);
var
  t:TSearchRec;
  ExeFileNameNull,Specific : PChar;
  Res : DWORD;
  Size : DWORD;
  Version : Pointer;
  LVersion : UINT; { LongWord }
  Buf : Pointer;
  info : VS_FIXEDFILEINFO;
  VersionMS,VersionLS : LongWord;
  VersionMS_mj,VersionMS_mn,VersionLS_mj,VersionLS_mn:LongWord;
begin
  ExeFileNameNull:=PChar(ParamStr(0));
  Specific:='\';
  Size:=GetFileVersionInfoSize(ExeFileNameNull,Res);
  GetMem(Buf,Size);
  GetFileVersionInfo(ExeFileNameNull,Res,Size,Buf);
  VerQueryValue(Buf,Specific,Version,LVersion);
  info:=VS_FIXEDFILEINFO(Version^);
  VersionMS:=info.dwFileVersionMS;
  VersionLS:=info.dwFileVersionLS;
  VersionMS_mj:=VersionMS shr 16;
  VersionMS_mn:=VersionMS and 65535;
  VersionLS_mj:=VersionLS shr 16;
  VersionLS_mn:=VersionLS and 65535;
  FreeMem(Buf,Size);
  lb.Caption:=IntToStr(VersionMS_mj)+'.'+IntToStr(VersionLS_mj);
  Label2.Caption:=IntToStr(VersionMS_mj)+'.'+
                  IntToStr(VersionMS_mn)+'.'+
                  IntToStr(VersionLS_mj)+'.'+
                  IntToStr(VersionLS_mn);
  FindFirst(Application.ExeName,$37,t);
  Label4.Caption:=DateToStr(FileDateToDateTime(t.Time));
end;

end.
