unit BufferedStreamLight;

interface

uses
  Classes,
  Variants,
  SysUtils;

const
  C_PREFFERED_BUFFER_SIZE: integer = 16384;

type
  EBufferedStream = class(Exception);

  // буферизованный и только на чтение
  TBufferedStreamRead = class(THandleStream)
  private
    FFile: File;
    FFileName: string;
    FBufferSize: LongInt;
    FBuffer : array of byte;
    FBufferPosition: integer;
    FFileLength: LongInt;
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;

    constructor Create(const AFileName: string);
    destructor Destroy; override;

    property FileName: string read FFileName;
  end;

  // буферизованный и только на запись
  TBufferedStreamWrite = class(THandleStream)
  private
    FFile: File;
    FCount: integer;
    FFileName: string;
    FBufferSize: LongInt;
    FBuffer : array of byte;
    FBufferPosition: integer;
  public
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    procedure FlushBuffer();

    constructor Create(const AFileName: string);
    destructor Destroy; override;

    property FileName: string read FFileName;
  end;

resourcestring
  resBufferedStreamForbiddenRead  = '„тение в этом классе не допустимо';
  resBufferedStreamForbiddenWrite = '«апись в этом классе не допустима';
  resBufferedStreamForbiddenSeek  = 'ѕоиск в этом классе не допустим';

implementation

{$REGION 'TBufferedStreamRead'}

constructor TBufferedStreamRead.Create(const AFileName: string);
var
  f: file of Byte;
begin
  FFileName   := AFileName;
  FBufferSize := C_PREFFERED_BUFFER_SIZE;
  SetLength(FBuffer, FBufferSize + FBufferSize);

  FBufferPosition := -1;

  // длина файла
  System.AssignFile(f, FFileName);
  System.Reset(f);
  try
    FFileLength := FileSize(f);
  finally
    System.CloseFile(f);
  end;

  // открываем файл
  System.AssignFile(FFile, FFileName);
  System.Reset(FFile, FBufferSize);
end;

destructor TBufferedStreamRead.Destroy;
begin
  FBuffer := nil;
  System.CloseFile(FFile);
  inherited Destroy;
end;

function TBufferedStreamRead.Read(var Buffer; Count: Longint): Longint;
var
  cnt, ps: integer;
begin
  // если только начало, то читаем блок
  cnt := 1;
  if FBufferPosition < 0 then
  begin
    System.BlockRead(FFile, PByte(FBuffer)^, 1, cnt);
    FBufferPosition := 0;
  end;

  if FBufferPosition + Count <= FBufferSize then
  begin
    // места дл€ чтени€ хватает
    System.Move((PByte(FBuffer) + FBufferPosition)^, Buffer, Count);
    Inc(FBufferPosition, Count);
    Result := Count;
    // если в притык, и еще ситываетс€, то читаем еще
    if (FBufferPosition = FBufferSize) and (cnt = 1) then
    begin
      System.BlockRead(FFile, PByte(FBuffer)^, 1, cnt);
      FBufferPosition := 0;
    end;
  end
  else
  begin
    // места дл€ чтени€ не хватает
    // наращиваем пам€ть если надо
    if Count + FBufferPosition > Length(FBuffer) then
      SetLength(FBuffer, Count + FBufferPosition + FBufferSize);

    // читаем блоками до тех пор пока не дойдем до конца файла или не выйдем на достаточный дл€ чтени€ размер
    ps := FBufferSize;
    while (FBufferPosition + Count > ps) and (cnt = 1) do
    begin
      System.BlockRead(FFile, (PByte(FBuffer) + ps)^, 1, cnt);
      ps := ps + FBufferSize;
    end;

    // „итаем в результат
    System.Move((PByte(FBuffer) + FBufferPosition)^, Buffer, Count);
    Inc(FBufferPosition, Count);
    Result := Count;

    // после прочтени€ двигаем данные в буфере
    while FBufferPosition >= FBufferSize do
    begin
      System.Move((PByte(FBuffer) + FBufferSize)^, PByte(FBuffer)^, ps - FBufferSize);
      // уменьшаем
      ps := ps - FBufferSize;
      FBufferPosition := FBufferPosition - FBufferSize;
    end;
  end;
end;

function TBufferedStreamRead.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  raise EBufferedStream.Create(resBufferedStreamForbiddenSeek);
end;

function TBufferedStreamRead.Write(const Buffer; Count: Longint): Longint;
begin
  raise EBufferedStream.Create(resBufferedStreamForbiddenWrite);
end;

{$ENDREGION 'TBufferedStreamRead'}

{$REGION 'TBufferedStreamWrite'}
constructor TBufferedStreamWrite.Create(const AFileName: string);
begin
  FCount := 0;
  FFileName   := AFileName;
  FBufferSize := C_PREFFERED_BUFFER_SIZE;
  SetLength(FBuffer, FBufferSize + FBufferSize);

  FBufferPosition := 0;
  System.AssignFile(FFile, FFileName);
  System.Rewrite(FFile, FBufferSize);
end;

destructor TBufferedStreamWrite.Destroy;
begin
  FBuffer := nil;
  System.CloseFile(FFile);
  inherited Destroy;
end;

procedure TBufferedStreamWrite.FlushBuffer;
var
  cnt, i : integer;
begin
  if FBufferPosition > 0 then
  begin
    // чистим мусор в буфере
    for i := FBufferPosition to High(FBuffer) do
      FBuffer[i] := 0;

    // пишем в файл
    System.BlockWrite(FFile, PByte(FBuffer)^, 1, cnt);
    FBufferPosition := 0;
    for i := Low(FBuffer) to High(FBuffer) do
      FBuffer[i] := 0;
  end;
end;

function TBufferedStreamWrite.Read(var Buffer; Count: Integer): Longint;
begin
  raise Exception.Create(resBufferedStreamForbiddenRead);
end;

function TBufferedStreamWrite.Seek(const Offset: Int64; Origin: TSeekOrigin): Int64;
begin
  raise Exception.Create(resBufferedStreamForbiddenSeek);
end;

function TBufferedStreamWrite.Write(const Buffer; Count: Integer): Longint;
var
  cnt: integer;
begin
  FCount := FCount + Count;
  // пишем в буфер по чуть-чуть
  if Count + FBufferPosition <= FBufferSize then
  begin
    // пока еще в буфер влезает
    System.Move(Buffer, (PByte(FBuffer) + FBufferPosition)^, Count);
    Inc(FBufferPosition, Count);
    Result := Count;
    // если в притык, то сливаем на диск
    if FBufferPosition = FBufferSize then
      FlushBuffer;
  end
  else
  begin
    // не влезает в буфер, тогда немного расшир€ем буфер, чтоб оно влезло
    if Count + FBufferPosition > Length(FBuffer) then
      SetLength(FBuffer, Count + FBufferPosition + FBufferSize);
    // записываем все в буфер
    System.Move(Buffer, (PByte(FBuffer) + FBufferPosition)^, Count);
    Inc(FBufferPosition, Count);
    Result := Count;
    // сливаем по чуть-чуть на диск
    while FBufferPosition >= FBufferSize do
    begin
      // записываем на диск блоками
      System.BlockWrite(FFile, PByte(FBuffer)^, 1, cnt);
      // двигаем
      System.Move((PByte(FBuffer) + FBufferSize)^, PByte(FBuffer)^, FBufferPosition - FBufferSize);
      // уменьшаем
      FBufferPosition := FBufferPosition - FBufferSize;
    end;
  end;
end;

{$ENDREGION 'TBufferedStreamWrite'}

end.
