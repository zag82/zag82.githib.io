unit movements;

interface

uses Classes, Controls, Chart;

type
  TMovement = class
  private
    signalPos1: integer;
    signalPos2: integer;
    oldGPos1: integer;
    oldGPos2: integer;
  public
    // элементы выделения и обработки
    iPos1:integer; // положения границ окна вывода
    iPos2:integer; // в отсчетах на сигнале
    gPos1:integer;
    gPos2:integer;
    bLeftBorder:boolean;
    bRightBorder:boolean;
    bScroller:boolean;
    capt:boolean;
    oldX:integer;
    sh:TShiftState;
    bt:TMouseButton;
    procedure InitData(szLeft, szRight: integer);
    procedure onMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure onMouseUp();
    procedure moveChart(ch: TChart; X, p1, p2: integer);
    // движение рамок
    procedure setNewPosition();
    function isNewPositions(p1, p2: integer):boolean;
    procedure correctFramePos();
    procedure moveBigLeft(ps,cMin:integer);
    procedure moveBigRight(ps,cMin:integer);
    procedure moveBigBoth(ps,cMin:integer);
    procedure moveBigBothSym(ps,cMin:integer);
    procedure moveLeftBorder(ps,cMin:integer);
    procedure moveRightBorder(ps,cMin:integer);
    procedure moveBothBorders(ps,cMin:integer);
    procedure moveBothSym(ps,cMin:integer);
  end;



implementation

{$REGION 'Основные'}
procedure TMovement.InitData(szLeft, szRight: integer);
begin
  capt := false;
  oldX := 0;
  sh := [];
  bt := mbLeft;
  signalPos1 := szLeft;
  signalPos2 := szRight;
  iPos1 := signalPos1;
  iPos2 := signalPos2;
  gPos1 := iPos1;
  gPos2 := iPos2;
  oldGPos1 := -1;
  oldGPos2 := -1;
  bLeftBorder := false;
  bRightBorder := false;
  bScroller := false;
end;

procedure TMovement.onMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  oldX := X;
  bt := Button;
  sh := Shift;
  capt := true;
end;

procedure TMovement.onMouseUp();
begin
  oldX:=0;
  capt := false;
  sh := [];
  bt := mbLeft;
end;

procedure TMovement.moveChart(ch: TChart; X, p1, p2: integer);
var
  x1,x2:integer;
begin
  x1:=ch.BottomAxis.CalcPosValue(p1);
  x2:=ch.BottomAxis.CalcPosValue(p2);
  if ((x1 - 2) <= x) and (x <= (x1 + 2)) then
  begin // курсор на левой границе
    ch.OriginalCursor := crSizeWE;
    bLeftBorder := true;
    bRightBorder := false;
    bScroller := false;
  end
  else if ((x2 - 2) <= x) and (x <= (x2 + 2)) then
  begin // курсор на правой границе
    ch.OriginalCursor := crSizeWE;
    bLeftBorder := false;
    bRightBorder := true;
    bScroller := false;
  end
  else
  begin // курсор на свободном поле
    ch.OriginalCursor := crDefault;
    bLeftBorder := false;
    bRightBorder := false;
    bScroller := false;
  end;
end;
{$ENDREGION}

{$REGION 'Движение рамок'}
procedure TMovement.setNewPosition();
begin
  oldGPos1 := -1;
  oldGPos2 := -1;
end;

function TMovement.isNewPositions(p1, p2: integer):boolean;
begin
  Result := (oldGPos1 <> p1) or (oldGPos2 <> p2);
  oldGPos1 := p1;
  oldGPos2 := p2;
end;

procedure TMovement.correctFramePos();
begin
  iPos1 := gPos1 - ((gPos2 - gPos1) div 2);
  iPos2 := gPos2 + ((gPos2 - gPos1) div 2);
  if iPos1 < signalPos1 then iPos1 := signalPos1;
  if iPos2 > signalPos2 then iPos2 := signalPos2;
end;

procedure TMovement.moveBigLeft(ps,cMin:integer);
begin
  // движение левой рамки на всем сигнале
  if ps < signalPos1 then ps := signalPos1;
  if (ps + cMin) > ipos2 then
  begin
    if (ps + cMin) > signalPos2 then
    begin
      ipos2 := signalPos2;
      ps := ipos2 - cMin;
    end
    else
    begin
      ipos2 := ps + cMin;
    end;
  end;
  ipos1 := ps;
  if not((gpos1 > ipos1) and (gpos2<ipos2)) then
  begin
    gPos1:=iPos1;
    gPos2:=iPos2;
  end;
end;

procedure TMovement.moveBigRight(ps,cMin:integer);
begin
  // движение правой рамки на всем сигнале
  if ps > signalPos2 then ps := signalPos2;
  if (ps - cMin) < ipos1 then
  begin
    if (ps - cMin) < signalPos1 then
    begin
      ipos1 := signalPos1;
      ps := ipos1 + cMin;
    end
    else
    begin
      ipos1 := ps - cMin;
    end;
  end;
  ipos2 := ps;
  if not((gpos1 > ipos1) and (gpos2 < ipos2)) then
  begin
    gPos1 := iPos1;
    gPos2 := iPos2;
  end;
end;

procedure TMovement.moveBigBoth(ps,cMin:integer);
var
  dp:integer;
begin
  // одновременное движение обеих рамок на всем сигнале
  dp := ipos2 - ipos1 {+ 1};
  if (signalPos1 + dp / 2) > ps then
  begin // врезались в левый край
    ipos2 := signalPos1 + dp;
    ipos1 := signalPos1;
  end
  else if ps > (signalPos2 - dp / 2) then
  begin // врезались в правый край
    ipos1 := signalPos2 - dp;
    ipos2 := signalPos2;
  end
  else
  begin // движемся по середине
    iPos1 := ps - (dp div 2);
    iPos2 := ps + (dp div 2);
  end;
  if not((gpos1 > ipos1) and (gpos2 < ipos2)) then
  begin
    gPos1 := iPos1;
    gPos2 := iPos2;
  end;
end;

procedure TMovement.moveBigBothSym(ps,cMin:integer);
const
  speed: double = 1;
var
  dp: integer;
  p0: integer;
begin
  dp := (ipos2 - ipos1 + 1) div 2;
  p0 := (ipos2 + ipos1) div 2;
  if ps < 0 then
  begin // едем влево, то есть уменьшаем рамку
    dp := dp + Round(ps * speed);
    if dp < (cMin div 2) then dp:=cMin div 2;
    ipos1 := p0 - dp;
    ipos2 := p0 + dp;
  end
  else if ps > 0 then
  begin // едем вправо, то есть увеличиваем рамку
    dp := dp + Round(ps * speed);
    if p0 - dp < signalPos1 then
      ipos1 := signalPos1
    else
      ipos1 := p0 - dp;
    if p0 + dp > signalPos2 then
      ipos2 := signalPos2
    else
      ipos2 := p0 + dp;
  end;
  if not((gpos1 > ipos1) and (gpos2 < ipos2)) then
  begin
    gPos1 := iPos1;
    gPos2 := iPos2;
  end;
end;

procedure TMovement.moveLeftBorder(ps,cMin:integer);
var
  p1,p2:integer;
begin
  p1 := iPos1;
  p2 := iPos2;
  if ps < p1 then ps := p1;
  if (ps + cMin) > gpos2 then
  begin
    if (ps + cMin) > p2 then
    begin
      gpos2 := p2;
      ps := gpos2 - cMin;
    end
    else
    begin
      gpos2 := ps + cMin;
    end;
  end;
  gpos1 := ps;
end;

procedure TMovement.moveRightBorder(ps,cMin:integer);
var
  p1,p2:integer;
begin
  p1 := iPos1;
  p2 := iPos2;
  if ps > p2 then ps := p2;
  if (ps-cMin) < gpos1 then
  begin
    if (ps - cMin) < p1 then
    begin
      gpos1 := p1;
      ps := gpos1 + cMin;
    end
    else
    begin
      gpos1 := ps - cMin;
    end;
  end;
  gpos2 := ps;
end;

procedure TMovement.moveBothBorders(ps,cMin:integer);
var
  p1,p2:integer;
  dp:integer;
begin
  // устанавливаем границы перемещения
  p1 := ipos1;
  p2 := ipos2;
  // начинаем движение
  dp := gpos2 - gpos1 + 1;
  if (p1 + dp/2) > ps then
  begin // врезались в левый край
    // просто упираемся в границу
    gpos2:=p1+dp-1;
    gpos1:=p1;
  end
  else if ps > (p2 - dp/2) then
  begin // врезались в правый край
    gpos1:=p2-dp+1;
    gpos2:=p2;
  end
  else
  begin // движемся по середине
    gPos1:=ps - (dp div 2);
    gPos2:=ps + (dp div 2);
  end;
end;

procedure TMovement.moveBothSym(ps,cMin:integer);
const
  speed: double = 1.0;
var
  dp: integer;
  p0: integer;
begin
  dp := (gpos2 - gpos1 + 1) div 2;
  p0 := (gpos2 + gpos1) div 2;
  if ps < 0 then
  begin // едем влево, то есть уменьшаем рамку
    dp := dp + Round(ps * speed);
    if dp < (cMin div 2) then dp := cMin div 2;
    gpos1 := p0 - dp;
    gpos2 := p0 + dp;
  end
  else if ps > 0 then
  begin // едем вправо, то есть увеличиваем рамку
    dp := dp + Round(ps * speed);
    if p0 - dp < ipos1 then
      gpos1 := ipos1
    else
      gpos1 := p0 - dp;
    if p0 + dp > ipos2 then
      gpos2 := ipos2
    else
      gpos2 := p0 + dp;
  end;
end;
{$ENDREGION}

end.
