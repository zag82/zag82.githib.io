unit azFileVersion;

interface

function GetVersionValue(): string;

implementation

uses Windows, SysUtils;

// получаем версию файла
function GetVersionValue(): string;
var
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
  // Вывод результатов
  Result := IntToStr(VersionMS_mj)+'.'+IntToStr(VersionMS_mn)+'.'+IntToStr(VersionLS_mj)+'.'+IntToStr(VersionLS_mn);
end;

end.

