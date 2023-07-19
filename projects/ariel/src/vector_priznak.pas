(*
 * ������ ������� ��������� ����������� ������� �������
 *
 * @author: ������� ��, ���(��), ������ 2005-2010
 *)
unit vector_priznak;

interface

uses SignalData, ComPlx;

type
  { ����� ��������� ��� ������� }
  TPriznakPack=record
    Am:double;      // ���������
    Ph:double;      // ����
    Re_p2p:double;  // ������ ����� �������������� ���
    Im_p2p:double;  // ������ ����� ������ ���
    Dx:double;      // ������ ����� �������
    k1:integer;     // ������ ���������
    k2:integer;     // ������ ���������
    value1_re:double; // �������� ���������� �� ������
    value1_im:double; // � ������ �����������
    value2_re:double;
    value2_im:double;
  end;

  { ����� ������� ��������� }
  TVPriznak=class
  private
    _f_Inner_Step:double;
    ///////////
    procedure FindPhaseAxis(var p1,p2:double); // ������ ������� ���
    function GetPhaseDif(var k1,k2:integer; bAutoPhase:boolean):double; // ������ ����
    function GetMax(var ph:double):double;          // ������ ���������
    function GetMax2(k1,k2:integer):double; // ������ ��������� �� ������� ������
    function GetRe:double;   // ������ ������� �� �������������� ���
    function GetIm:double;   // ������ ������� �� ������ ���
    function GetMomentRE(av:double; k:integer):double;
    function GetMomentIM(av:double; k:integer):double;
    /////////////////////////////////////////
  protected
    p1: integer;
    p2: integer;
    iChannel: integer;
    _sd: TSignalData;
    avg: TComplex;
    num: integer;
    function getF(ipos: integer): TComplex;
    function getF_ini(ipos: integer): TComplex;
  public
    bAbs: boolean;
    bAutoPhaseRes: boolean;
    procedure LoadPart(pos1,pos2:integer; iCh: integer; sd: TSignalData);
//    procedure FreeData;
    function GetVector(step:double; bAutoPhase:boolean; posK1,posK2:integer):TPriznakPack;
//    function CorrectVector(pz:TPriznakPack; aph:TAutoPhase; pos:integer):TPriznakPack;
//    function PreCorrectVector(pz:TPriznakPack; ityp:integer):TPriznakPack;
    //function GetVector(step:double):TPriznakPack;
  end;

function getPriznaksAll(p1, p2: integer; ich:integer; sd: TSignalData; isRaw: boolean):TPriznakPack;

implementation

{ ��������� ������� ��������� }
function getPriznaksAll(p1, p2: integer; ich:integer; sd: TSignalData; isRaw: boolean):TPriznakPack;
var
  vp: TVPriznak;
  pp: TPriznakPack;
begin
  vp := TVPriznak.Create();
  vp.bAbs := sd.DeviceInfo.channelsInfo[ich].bAbs;
  vp.LoadPart(p1, p2, ich, sd);
  pp := vp.GetVector(1,true,1,1);
  if not isRaw then
  begin
    pp.Am := pp.Am * CAbs(sd.ProcessingParams.eta[ich]);
    pp.Ph := pp.Ph + CPhaseD(sd.ProcessingParams.eta[ich]);
    while(pp.ph > 180)do pp.Ph := pp.Ph - 360;
    while(pp.ph < -180)do pp.Ph := pp.Ph + 360;
  end;
  Result := pp;
  vp.Free;
end;


////////////////////////////////////////////////////////////////////////////////
//                                TVPriznak                                   //
////////////////////////////////////////////////////////////////////////////////
function TVPriznak.getF(ipos: integer): TComplex;
var cx: TComplex;
begin
  cx := _sd.getData(iChannel, iPos + p1, true);
  Result.re := cx.re - avg.re;
  Result.im := cx.im - avg.im;
end;

function TVPriznak.getF_ini(ipos: integer): TComplex;
var cx: TComplex;
begin
  cx := _sd.getData(iChannel, iPos + p1, true);
  Result := cx;
end;

{ �������� ������ �� ������� �������� "ch" �� ������� �� "pos1" �� "pos2" }
procedure TVPriznak.LoadPart(pos1,pos2:integer; iCh: integer; sd: TSignalData);
var
  i:integer;
  cx: TComplex;
begin
  p1 := pos1;
  p2 := pos2;
  num := p2 - p1 + 1;
  iChannel := iCh;
  _sd := sd;
  if not bAbs then
  begin
    avg.re := 0;
    avg.im := 0;
    for i := 0 to num - 1 do
    begin
      cx := getF_ini(i);
      avg.re := avg.re + cx.re;
      avg.im := avg.im + cx.im;
    end;
    avg.re := avg.re / num;
    avg.im := avg.im / num;
  end
  else
  begin
    avg.re := (getF(0).re + getF(num-1).re) / 2;
    avg.im := (getF(0).im + getF(num-1).im) / 2;
  end;
end;

{ ������ ���� ��������� }
function TVPriznak.GetVector(step:double; bAutoPhase:boolean; posK1,posK2:integer):TPriznakPack;
var p:TPriznakPack;
    ph:double;
    k1,k2:integer;
begin
  _f_Inner_Step:=step;
  bAutoPhaseRes:=bAutoPhase;
  k1:=posK1;
  k2:=posK2;
  if (k1 < 0) or (k1 >= num) or (k2 < 0) or (k2 >= num )or (k1 >= k2) then
  begin
    // ���������� ����� �� ������� ������� - ���� ������������
    // �������������� ������ �����������
    bAutoPhaseRes := true;
    k1 := 0;
    k2 := num - 1;
  end;
  //FillAmp;
  p.Am:=GetMax(ph);
  if bAbs then
    p.Ph:=ph
  else
  begin
    p.Ph:=GetPhaseDif(k1, k2, bAutoPhaseRes);
    p.Am:=getMax2(k1, k2);
  end;
  p.Re_p2p:=GetRe;
  p.Im_p2p:=GetIm;
  p.Dx:=Abs(k2-k1)*step;
  p.k1:=k1;
  p.k2:=k2;
  // ����������
  p.value1_re := getF_ini(k1).re;
  p.value1_im := getF_ini(k1).im;
  p.value2_re := getF_ini(k2).re;
  p.value2_im := getF_ini(k2).im;
  Result:=p;
end;

{ ����������� ������������� ������� ��������� ��� �������� ������ }
(*function TVPriznak.PreCorrectVector(pz:TPriznakPack; ityp:integer):TPriznakPack;
var
  p:TPriznakPack;
  k1,k2,k:integer;
  m1,m2:double;
  i:integer;
begin
  // �������� �������� ������ � ���������
  p:=pz;
  // �������� �������������
  if iTyp=0 then
  begin  // ������������
    k1:=1;
    k2:=num;
    m1:=fd2[k1];
    m2:=fd2[k2];
    for i:=1 to num do
    begin
      if m1 > fd2[i] then begin m1:=fd2[i]; k1:=i; end;
      if m2 < fd2[i] then begin m2:=fd2[i]; k2:=i; end;
    end;
    if k1>k2 then
    begin
      k:=k1;
      k1:=k2;
      k2:=k;
    end
    else if k1=k2 then
    begin
      // ������ ������ � �� ���������� � ������� �� �� ��� ������������ ����� �����������
      k1:=1;
      k2:=num;
    end;
  end
  else if iTyp=1 then
  begin  // �������
    k1:=pz.k1;
    k2:=pz.k2;
{    k1:=1;
    k2:=num;
    m1:=fd2[k1];
    m2:=fd2[k2];
    for i:=1 to num do
    begin
      if m1 > fd2[i] then begin m1:=fd2[i]; k1:=i; end;
      if m2 < fd2[i] then begin m2:=fd2[i]; k2:=i; end;
    end;
    if k1>k2 then
    begin
      k:=k1;
      k1:=k2;
      k2:=k;
    end;      }
  end
  else
  begin
    // ��� ��������� ������ �� ������
    k1:=pz.k1;
    k2:=pz.k2;
  end;
  //////
  // ������������
  p.Ph:=GetPhaseDif(k1,k2,false);
  p.Am:=getMax2(k1,k2);
  p.Dx:=Abs(k2-k1)*_f_Inner_Step;
  p.k1:=k1;
  p.k2:=k2;
  // ����������
  p.value1_re:=fd1_ini[k1];
  p.value1_im:=fd2_ini[k1];
  p.value2_re:=fd1_ini[k2];
  p.value2_im:=fd2_ini[k2];
  Result:=p;
end;  *)

{ ������������� ������� ��������� �� ������ �������� ������ }
(*function TVPriznak.CorrectVector(pz:TPriznakPack; aph:TAutoPhase; pos:integer):TPriznakPack;
var
  p:TPriznakPack;
  ph:double;
  k1,k2:integer;
begin
  // �������� �������� ������ � ���������
  p:=pz;
  // �������� �������������
  k1:=aph.posK1-pos+1;
  k2:=aph.posK2-pos+1;
  bAutoPhaseRes:=aph.bAutoPhase;
  p.Am:=GetMax(ph);
  if bAbs then
    p.Ph:=ph
  else
  begin
    p.Ph:=GetPhaseDif(k1,k2,false);
    p.Am:=getMax2(k1,k2);
  end;
  p.Dx:=Abs(k2-k1)*_f_Inner_Step;
  p.k1:=k1;
  p.k2:=k2;
  // ����������
  p.value1_re:=fd1_ini[k1];
  p.value1_im:=fd2_ini[k1];
  p.value2_re:=fd1_ini[k2];
  p.value2_im:=fd2_ini[k2];
  Result:=p;
end; *)

{ ������ ������� ��� }
procedure TVPriznak.FindPhaseAxis(var p1,p2:double);
var
  i:integer;
  m1,m2,av1,av2:double;
  xx:double;
begin
  av1 := self.GetMomentRE(0, 1);
  av2 := self.GetMomentIM(0, 1);
  m1 := self.GetMomentRE(av1, 2);
  m2 := self.GetMomentIM(av2, 2);
  xx := 0;
  for i := 0 to num - 1 do
    xx := xx + getF(i).re * getF(i).im;
  if num<>0 then
    xx := xx / num
  else
    xx := 0;
  p1 := 0.5 * ArcTng(m1 - m2,2 * xx) * 180 / pi;
  p2 := p1 + 180;
  while p1 > 180 do p1 := p1 - 360;
  while p1 <= -180 do p1 := p1 + 360;
  ///
  while p2 > 180 do p2 := p2 - 360;
  while p2 <= -180 do p2 := p2 + 360;
  ///
end;

{ ������ ���� ������� ��� ���������������� ������� }
function TVPriznak.GetPhaseDif(var k1,k2:integer; bAutoPhase:boolean):double;
var
  p1,p2,delta1,delta2:double;
  m1,m2,am:double;
  pph,res:double;
  i,r:integer;
  cx: TComplex;
begin
  if bAutoPhase then
  begin
    // ��������� �������������� ������� ����� ��� ����������� ����
    // ����� ���������� ���������
    FindPhaseAxis(p1, p2);
    k1 := 0;
    k2 := num - 1;
    m1 := 0;
    m2 := 0;
    for i := 0 to num - 1 do
    begin
      cx := getF(i);
      am:=sqrt(sqr(cx.re)+sqr(cx.im));
      pph:=ArcTng(cx.re, cx.im) * 180 / pi;
      delta1 := abs(p1 - pph);
      while delta1 > 180 do delta1 := delta1 - 360;
      delta2 := abs(p2 - pph);
      while delta2 > 180 do delta2 := delta2 - 360;
      if abs(delta1) < abs(delta2) then
      begin
        if m1 < am then
        begin
          m1 := am;
          k1 := i;
        end;
      end
      else
      begin
        if m2 < am then
        begin
          m2 := am;
          k2 := i;
        end;
      end;
    end;
  end;
  if k1 > k2 then
  begin
    r := k1;
    k1 := k2;
    k2 := r;
  end
  else if k1 = k2 then
  begin
    k1 := 0;
    k2 := num - 1;
  end;
  res := ArcTng(getF(k1).re - getF(k2).re, getF(k1).im - getF(k2).im) * 180 / pi;
  while res > 180 do res := res - 360;
  Result := res;
end;

{ ������ ��������� ������� � ���� ��� ���������� ������� }
function TVPriznak.GetMax(var ph:double):double;
var i:integer;
    m,tm:double;
    cx: TComplex;
begin
  m := 0;
  ph := 0;
  for i := 0 to num - 1 do
  begin
    cx := getF(i);
    tm := sqrt(sqr(cx.re) + sqr(cx.im));
    if tm > m then
    begin
      m := tm;
      ph := ArcTng(cx.re, cx.im) * 180 / pi;
    end;
  end;
  while ph > 180 do ph := ph - 360;
  Result := m;
end;

{ ������ ��������� �� ������� ������ ����������� }
function TVPriznak.GetMax2(k1,k2:integer):double;
var
  res:double;
begin
  res := sqrt(sqr(getF(k1).re - getF(k2).re)+sqr(getF(k1).im - getF(k2).im))/2;
  Result := res;
end;

{ ������ ������� ������� ����� �������������� ��� }
function TVPriznak.GetRe:double;
var i:integer;
    m1,m2:double;
begin
  m1 := getF(0).re;
  m2 := getF(0).re;
  for i := 0 to num - 1 do
  begin
    if getF(i).re > m2 then m2 := getF(i).re;
    if getF(i).re < m1 then m1 := getF(i).re;
  end;
  Result := m2 - m1;
end;

{ ������ ������� ������� ����� ������ ��� }
function TVPriznak.GetIm:double;
var i:integer;
    m1,m2:double;
begin
  m1 := getF(0).im;
  m2 := getF(0).im;
  for i := 0 to num - 1 do
  begin
    if getF(i).im > m2 then m2 := getF(i).im;
    if getF(i).im < m1 then m1 := getF(i).im;
  end;
  Result := m2 - m1;
end;

{ ������ ������� �������������� ���������� ������� "�"-�� �������,
  av - ������� �������� }
function TVPriznak.GetMomentRE(av:double; k:integer):double;
var i,j:integer;
    s,p,dif:double;
begin
  s := 0;
  for i := 0 to num - 1 do
  begin
    dif := getF(i).re - av;
    p := dif;
    for j := 2 to k do
      p := p * dif;
    s := s + p;
  end;
  if num <> 0 then
    Result := s / num
  else
    Result := 0;
end;

{ ������ ������� ������ ���������� ������� "�"-�� �������,
  av - ������� �������� }
function TVPriznak.GetMomentIM(av:double; k:integer):double;
var i,j:integer;
    s,p,dif:double;
begin
  s := 0;
  for i := 0 to num - 1 do
  begin
    dif := getF(i).im - av;
    p := dif;
    for j := 2 to k do
      p := p * dif;
    s := s + p;
  end;
  if num <> 0 then
    Result := s / num
  else
    Result := 0;
end;

end.
