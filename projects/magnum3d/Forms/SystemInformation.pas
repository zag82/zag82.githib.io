unit SystemInformation;

interface

uses cm_ini,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, TeeProcs, TeEngine, Chart, Series, StdCtrls;

type
  TfmSysInfo = class(TForm)
    Chart1: TChart;
    Panel1: TPanel;
    sg1: TStringGrid;
    sg2: TStringGrid;
    Splitter1: TSplitter;
    Series1: TPieSeries;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sg2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    m_Free:boolean;
    m_Auto:boolean;
    m_Rest:boolean;
    mm:array [1..3,1..5]of int;
    procedure FreeMemM;
    procedure FillMemM;
    ///////////////////
    procedure OutValues;
    procedure ReadPage;
    procedure WritePage;
  end;

var
  fmSysInfo: TfmSysInfo;

implementation

{$R *.dfm}
uses cmData, cmVars, ComVars, common_main2d, el_main2d, ss_main2d, ec_main2d;

procedure TfmSysInfo.ReadPage;
begin
  m_Free:=CheckBox1.Checked;
  m_Auto:=CheckBox3.Checked;
  m_Rest:=CheckBox2.Checked;
end;

procedure TfmSysInfo.WritePage;
begin
  CheckBox1.Checked:=m_Free;
  CheckBox3.Checked:=m_Auto;
  CheckBox2.Checked:=m_Rest;
  Timer1.Enabled:=m_auto;
  FillMemM;
  OutValues;
end;

procedure TfmSysInfo.FreeMemM;
var i,j:int;
begin
  for i:=1 to 3 do
    for j:=1 to 5 do
      mm[i,j]:=0;
end;

procedure TfmSysInfo.FillMemM;
var
  lpBuffer : _MEMORYSTATUS;
  HeapStatus : THeapStatus;
  i,j:int;
  sum:int;
begin
  GlobalMemoryStatus(lpBuffer);
  HeapStatus:=GetHeapStatus;
  //////////////////////////
  mm[1,1]:=lpBuffer.dwTotalPhys;
  mm[1,2]:=lpBuffer.dwAvailPhys;
  mm[1,3]:=lpBuffer.dwTotalVirtual;
  mm[1,5]:=HeapStatus.TotalAllocated;
  //////////////////////////
  if tt<>nil then mm[2,1]:=1024+(tt.nd1+tt.nd2)*SizeOf(TStep) else mm[2,1]:=0;
  if axa<>nil then mm[3,1]:=1024+(axa.nd1+axa.nd2+axa.nd3)*SizeOf(TStep) else mm[3,1]:=0;
  mm[2,2]:=0;
  if tt<>nil then if tt.Topology<>nil then mm[2,2]:=tt.NTriangles*4*sizeOf(int);
  if ATopology<>nil then mm[3,2]:=NElements*5*sizeOf(int) else mm[3,2]:=0;
  /// matrix
  sum:=0;
  if (tt<>nil) then
  if (TFlatELTask(tt).NumberConnect<>nil) then
  for i:=1 to tt.NNodes do
    Case Task of
      0..2:sum:=sum+TFlatELTask(tt).NumberConnect[i,1]*sizeOf(float);
      3:sum:=sum+TFlatSSTask(tt).NumberConnect[i,1]*sizeOf(float);
      5:sum:=sum+TFlatECTask(tt).NumberConnect[i,1]*sizeOf(float)*2;
    end;
  mm[2,3]:=sum;
  sum:=0;
  if NumberConnect<>nil then
  for i:=1 to NPoints do
    Case Task of
      0..2:sum:=sum+NumberConnect[i,1]*sizeOf(float);
      3:sum:=sum+NumberConnect[i,1]*sizeOf(float)*3;
      5:sum:=sum+NumberConnect[i,1]*sizeOf(float)*6;
    end;
  mm[3,3]:=sum;
  /// Results
  mm[2,4]:=0;
  if task<5 then sum:=1 else sum:=2;
  if (tt<>nil) then
  if (TFlatELTask(tt).NumberConnect<>nil) then
    mm[2,4]:=tt.NNodes*SizeOf(float)*sum;
  Case Task of
    0..2:sum:=1;
    3:sum:=3;
    5:sum:=6;
  end;
  if (ResultSc=nil)and(Result_X=nil)and(Result_Xc=nil) then mm[3,4]:=0 else mm[3,4]:=NPoints*SizeOf(float)*sum;
  /// fields
end;

procedure TfmSysInfo.OutValues;
var k:int;
begin
  Chart1.Series[0].Clear;
  // common
  sg1.Cells[1,1]:=IntToStr(mm[1,1] div 1024)+' Kb';
  sg1.Cells[1,2]:=IntToStr(mm[1,2] div 1024)+' Kb';
  sg1.Cells[1,3]:=IntToStr(mm[1,3] div 1048576)+' Mb';
  sg1.Cells[1,5]:=IntToStr(mm[1,5] div 1024)+' Kb';
  // 2d
  sg2.Cells[1,2]:=IntToStr(mm[2,1] div 1024)+' Kb';
  sg2.Cells[1,3]:=IntToStr(mm[2,2] div 1048576)+' Mb';
  sg2.Cells[1,4]:=IntToStr(mm[2,3] div 1048576)+' Mb';
  sg2.Cells[1,5]:=IntToStr(mm[2,4] div 1024)+' Kb';
  sg2.Cells[1,6]:=IntToStr(mm[2,5] div 1024)+' Kb';
  // 3d
  sg2.Cells[1, 9]:=IntToStr(mm[3,1] div 1024)+' Kb';
  sg2.Cells[1,10]:=IntToStr(mm[3,2] div 1048576)+' Mb';
  sg2.Cells[1,11]:=IntToStr(mm[3,3] div 1048576)+' Mb';
  sg2.Cells[1,12]:=IntToStr(mm[3,4] div 1024)+' Kb';
  sg2.Cells[1,13]:=IntToStr(mm[3,5] div 1024)+' Kb';
  // Chart
  k:=0;
  if mm[2,1]<>0 then begin Chart1.Series[0].AddXY(k,mm[2,1],'2d - Initial'); inc(k); end;
  if mm[2,2]<>0 then begin Chart1.Series[0].AddXY(k,mm[2,2],'2d - Topology'); inc(k); end;
  if mm[2,3]<>0 then begin Chart1.Series[0].AddXY(k,mm[2,3],'2d - Matrix'); inc(k); end;
  if mm[2,4]<>0 then begin Chart1.Series[0].AddXY(k,mm[2,4],'2d - Result'); inc(k); end;
  if mm[2,5]<>0 then begin Chart1.Series[0].AddXY(k,mm[2,5],'2d - Fields'); inc(k); end;
  //
  if mm[3,1]<>0 then begin Chart1.Series[0].AddXY(k,mm[3,1],'3d - Initial'); inc(k); end;
  if mm[3,2]<>0 then begin Chart1.Series[0].AddXY(k,mm[3,2],'3d - Topology'); inc(k); end;
  if mm[3,3]<>0 then begin Chart1.Series[0].AddXY(k,mm[3,3],'3d - Matrix'); inc(k); end;
  if mm[3,4]<>0 then begin Chart1.Series[0].AddXY(k,mm[3,4],'3d - Result'); inc(k); end;
  if mm[3,5]<>0 then begin Chart1.Series[0].AddXY(k,mm[3,5],'3d - Fields'); inc(k); end;
  if m_Free then begin Chart1.Series[0].AddXY(k,mm[1,2],'Free memory'); inc(k); end;
end;

procedure TfmSysInfo.FormCreate(Sender: TObject);
begin
  /////////////////////////
  // names of fields
  /////////////////////////
  sg1.Cells[0,0]:='Memory';
  sg1.Cells[1,0]:='Size';
  sg2.Cells[0,0]:='Variable';
  sg2.Cells[1,0]:='Allocation';
  //////////////////////////
  sg1.Cells[0,1]:='Total Physical';
  sg1.Cells[0,2]:='Free Physical';
  sg1.Cells[0,3]:='Total Virtual';
  sg1.Cells[0,5]:='Application Allocated';
  //////////////////////////////
  // 2d
  sg2.Cells[0,2]:='Initial';
  sg2.Cells[0,3]:='Topology';
  sg2.Cells[0,4]:='Matrix';
  sg2.Cells[0,5]:='Results';
  sg2.Cells[0,6]:='Fields';
  // 3d
  sg2.Cells[0,9]:='Initial';
  sg2.Cells[0,10]:='Topology';
  sg2.Cells[0,11]:='Matrix';
  sg2.Cells[0,12]:='Results';
  sg2.Cells[0,13]:='Fields';
  ///////////////////////////
  // values for fields
  ///////////////////////////
  FreeMemM;
  ReadPage;
  WritePage;
end;

procedure TfmSysInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
  fmSysInfo:=nil;
end;

procedure TfmSysInfo.sg2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var ss:string;
    x,y:int;
    r:TRect;
    cl:TColor;
begin
  cl:=$88FFFF;
  if ACol=1 then
    ss:='************'
  else
    if ARow=1 then
      ss:='   2D data'
    else
      ss:='   3D data';
  if (ACol=0)and(aRow=15)then begin ss:='Total :'; cl:=$88FF88; end;
  if (ACol=1)and(aRow=15)then begin ss:=''; cl:=$88FF88; end;
  with SG2 do
    if (ARow=1) or (ARow=8) or (aRow=15) then
    begin
      Canvas.Brush.Color:=cl;
      Canvas.FillRect(CellRect(ACol,ARow));
      Canvas.Font.Color:=clBlack;
      Canvas.Font.Style:=[fsBold];
      r:=CellRect(ACol,ARow);
      x:=r.Left+5;
      y:=r.Top+8;
      Canvas.TextOut(x,y,ss);
    end
end;

procedure TfmSysInfo.Timer1Timer(Sender: TObject);
begin
  FreeMemM;
  ReadPage;
  WritePage;
end;

procedure TfmSysInfo.CheckBox1Click(Sender: TObject);
begin
  FreeMemM;
  ReadPage;
  WritePage;
end;

procedure TfmSysInfo.Timer2Timer(Sender: TObject);
begin
  if m_Rest then Series1.Rotate(2);
end;

end.
