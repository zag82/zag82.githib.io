unit multiedit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Spin;

type
  TfmMultiEdit = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    RichEdit1: TRichEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    SpeedButton5: TSpeedButton;
    Label5: TLabel;
    ListBox3: TListBox;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    se1: TSpinEdit;
    ListBox4: TListBox;
    ListBox5: TListBox;
    ListBox6: TListBox;
    ListBox7: TListBox;
    Button4: TButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit2: TEdit;
    ListBox8: TListBox;
    Button5: TButton;
    Button6: TButton;
    ComboBox2: TComboBox;
    Label13: TLabel;
    Bevel1: TBevel;
    Label14: TLabel;
    Label15: TLabel;
    ComboBox3: TComboBox;
    sDlg1: TSaveDialog;
    sDlg2: TSaveDialog;
    SpeedButton9: TSpeedButton;
    oDlg: TOpenDialog;
    GroupBox5: TGroupBox;
    Edit1: TEdit;
    Label2: TLabel;
    SpeedButton4: TSpeedButton;
    ListBox9: TListBox;
    Label16: TLabel;
    Button3: TButton;
    Label19: TLabel;
    CheckBox2: TCheckBox;
    Label17: TLabel;
    Label18: TLabel;
    ComboBox4: TComboBox;
    Edit3: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure TabSheet3Exit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ListBox9Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMultiEdit: TfmMultiEdit;

implementation

{$R *.dfm}
uses cm_ini, cmVars, cmData, mm_data, mm_dlg, mm_dir;

procedure TfmMultiEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  mp.Delete;
  mp.Free;
  mp:=nil;
  Action:=cafree;
  fmMultiEdit:=nil;
end;

procedure TfmMultiEdit.FormCreate(Sender: TObject);
var i:int;
begin
  PageControl1.ActivePageIndex:=0;
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  ListBox3.Items.Clear;
  ListBox4.Items.Clear;
  ListBox8.Items.Clear;
  ListBox6.Items.Clear;
  ListBox7.Items.Clear;
  for i:=0 to ob.Count-1 do ListBox2.Items.Add(TMGObject(ob.Items[i]).Name);
  for i:=0 to ob.Count-1 do ListBox7.Items.Add(TMGObject(ob.Items[i]).Name);
  for i:=0 to mt.nMaterials-1 do ListBox6.Items.Add(mt.mmName[i]);
  mp:=TMultiPack.Create;
end;

procedure TfmMultiEdit.TabSheet2Show(Sender: TObject);
begin
  se1.Value:=mp.num;
  se1Change(SElf);
end;

procedure TfmMultiEdit.se1Change(Sender: TObject);
var i:int;
begin
  mp.num:=se1.Value;
  mp.ChangeNum;
  ListBox3.Items.Clear;
  for i:=1 to mp.num do
    ListBox3.Items.Add(IntToStr(i));
end;

procedure TfmMultiEdit.ListBox3Click(Sender: TObject);
var k,i:int;
    s:string;
begin
  k:=Listbox3.ItemIndex+1;
  if k>0 then
  begin
    ListBox4.Items.Clear;
    for i:=1 to mp.nMulti[k] do
    begin
      Case mp.vMulti[k,i].sort of
        1:s:='Object - '+TMgObject(ob.Items[mp.vMulti[k,i].obj]).Name;
        2:s:='Material - '+mt.mmName[mp.vMulti[k,i].obj];
        3:s:='Frequency';
      end;
      ListBox4.Items.Add(s);
    end;
  end;
end;

procedure TfmMultiEdit.SpeedButton6Click(Sender: TObject);
var k:int;
begin
  k:=Listbox3.ItemIndex+1;
  if k>0 then
  begin
    mp.AddPack(k,3,0,0);
    ListBox3Click(self);
  end;
end;

procedure TfmMultiEdit.SpeedButton7Click(Sender: TObject);
var k,n:int;
begin
  k:=Listbox3.ItemIndex+1;
  n:=Listbox6.ItemIndex;
  if (k>0)and(n>=0) then
  begin
    mp.AddPack(k,2,n,1);
    ListBox3Click(self);
  end;
end;

procedure TfmMultiEdit.SpeedButton8Click(Sender: TObject);
var k,n:int;
begin
  k:=Listbox3.ItemIndex+1;
  n:=Listbox7.ItemIndex;
  if (k>0)and(n>=0) then
  begin
    mp.AddPack(k,1,n,1);
    ListBox3Click(self);
  end;
end;

procedure TfmMultiEdit.Button4Click(Sender: TObject);
var k:int;
begin
  k:=Listbox3.ItemIndex+1;
  if k>0 then
  begin
    mp.nMulti[k]:=0;
    mp.vMulti[k]:=nil;
    mp.ChangeNum;
    ListBox3Click(self);
  end;
end;

procedure TfmMultiEdit.ListBox4Click(Sender: TObject);
var
  k,n,i:int;
  s:string;
  ii:float;
begin
  n:=Listbox3.ItemIndex+1;
  k:=Listbox4.ItemIndex+1;
  if k>0 then
  begin
    with mp.vMulti[n,k] do
    begin
      Case Sort of
        1:begin
            if TMGObject(ob.Items[Obj]) is TBlock then
            begin
              Label13.Caption:='mm';
              ComboBox2.Items.Clear;
              ComboBox2.Items.Add('x min');
              ComboBox2.Items.Add('y min');
              ComboBox2.Items.Add('z min');
              ComboBox2.Items.Add('x max');
              ComboBox2.Items.Add('y max');
              ComboBox2.Items.Add('z max');
              ListBox8.Items.Clear;
              for i:=1 to Nvars do
              begin
                s:=FloatToStrF(vars[i]*1e3,ffFixed,8,3);
                ListBox8.Items.Add(s);
              end;
            end
            else
            begin
              if (prop=6) or (prop=7) then
              begin
                ii:=1;
                Label13.Caption:='deg';
              end
              else
              begin
                ii:=1000;
                Label13.Caption:='mm';
              end;
              ComboBox2.Items.Clear;
              ComboBox2.Items.Add('x0');
              ComboBox2.Items.Add('y0');
              ComboBox2.Items.Add('z0');
              ComboBox2.Items.Add('R min');
              ComboBox2.Items.Add('R max');
              ComboBox2.Items.Add('Alpha');
              ComboBox2.Items.Add('Betta');
              ComboBox2.Items.Add('Height');
              ComboBox2.Items.Add('Delta Z');
              ListBox8.Items.Clear;
              for i:=1 to Nvars do
              begin
                s:=FloatToStrF(vars[i]*ii,ffFixed,8,3);
                ListBox8.Items.Add(s);
              end;
            end;
            ComboBox2.ItemIndex:=prop-1;
          end;
        2:begin
            if prop=3 then
            begin
              Label13.Caption:='MSm/m';
              ii:=1e-6;
            end
            else
            begin
              Label13.Caption:='';
              ii:=1;
            end;
            ComboBox2.Items.Clear;
            ComboBox2.Items.Add('Epsilon');
            ComboBox2.Items.Add('Mu');
            ComboBox2.Items.Add('Sigma');
            ComboBox2.ItemIndex:=prop-1;
            ListBox8.Items.Clear;
            for i:=1 to Nvars do
            begin
              s:=FloatToStrF(vars[i]*ii,ffFixed,8,3);
              ListBox8.Items.Add(s);
            end;
          end;
        3:begin
            Label13.Caption:='Hz';
            ComboBox2.Items.Clear;
            ComboBox2.Items.Add('None');
            ComboBox2.ItemIndex:=0;
            ListBox8.Items.Clear;
            for i:=1 to Nvars do
            begin
              s:=FloatToStrF(vars[i],ffFixed,8,3);
              ListBox8.Items.Add(s);
            end;
          end;
      end;
      Edit2.Text:=IntToStr(nVars);
    end;
  end;
end;

procedure TfmMultiEdit.ComboBox2Change(Sender: TObject);
var k,n1,n2:int;
begin
  k:=ComboBox2.ItemIndex+1;
  n1:=ListBox3.ItemIndex+1;
  n2:=ListBox4.ItemIndex+1;
  if (k>0)and(n1>0)and(n2>0) then
  begin
    mp.vMulti[n1,n2].prop:=k;
    ListBox4Click(self);
  end;
end;

procedure TfmMultiEdit.Button6Click(Sender: TObject);
var k,n1,n2,i:int;
    iObj,iSort:int;
    vl:float;
begin
  k:=ComboBox2.ItemIndex+1;
  n1:=ListBox3.ItemIndex+1;
  n2:=ListBox4.ItemIndex+1;
  if (k>0)and(n1>0)and(n2>0) then
  begin
    iSort:=mp.vMulti[n1,n2].sort;
    iObj:=mp.vMulti[n1,n2].obj;
    vl:=mp.GetValue(iSort,iObj,k);
    for i:=1 to mp.vMulti[n1,n2].nVars do
      mp.vMulti[n1,n2].vars[i]:=vl;
    ListBox4Click(self);
  end;
end;

procedure TfmMultiEdit.Button5Click(Sender: TObject);
var n1,n2,i:int;
    nn:int;
begin
  n1:=ListBox3.ItemIndex+1;
  n2:=ListBox4.ItemIndex+1;
  if (n1>0)and(n2>0) then
  begin
    fmMDlg:=TfmMDlg.Create(Application);
    fmMDlg.ss:=Label13.Caption;
    fmMDlg.UpdateAll;
    fmMDlg.se.Value:=mp.vMulti[n1,n2].nVars;
    fmMDlg.seChange(Application);
    fmMDlg.se.Enabled:=(n2=1);
    for i:=1 to mp.vMulti[n1,n2].nVars do
      fmMDlg.sg.Cells[0,i]:=FloatToStrF(mp.vMulti[n1,n2].vars[i]*fmMDlg.ii,ffFixed,8,3);
    fmMDlg.ShowModal;
    if fmMDlg.id=1 then
    begin
      with mp.vMulti[n1,n2] do
      begin
        nVars:=fmMDlg.se.Value;
        SetLength(vars,nvars+1);
        for i:=1 to nVars do vars[i]:=StrToFloat(fmMDlg.sg.Cells[0,i])/fmMDlg.ii;
      end;
      nn:=mp.vMulti[n1,1].nVars;
      for i:=2 to mp.nMulti[n1] do
        if mp.vMulti[n1,i].nVars<>nn then
        begin
          mp.vMulti[n1,i].nVars:=nn;
          SetLength(mp.vMulti[n1,i].vars,nn+1);
        end;
      ListBox4Click(self);
    end;
  end;
end;

procedure TfmMultiEdit.Button2Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

procedure TfmMultiEdit.Button1Click(Sender: TObject);
var k:int;
begin
  k:=ListBox1.ItemIndex;
  if k>=0 then ListBox1.Items.Delete(k);
end;

procedure TfmMultiEdit.SpeedButton5Click(Sender: TObject);
var k:int;
begin
  k:=ListBox2.ItemIndex;
  if k>=0 then ListBox1.Items.Add(ListBox2.Items[k]);
end;

procedure TfmMultiEdit.TabSheet3Exit(Sender: TObject);
var i,k:int;
    s:string;
begin
  with mp do
  begin
    bTopology:=CheckBox1.Checked;
    solMet:=ComboBox1.ItemIndex+1;
    outpath:=Edit1.Text;
    outStyle:=ComboBox3.ItemIndex+1;
    numgage:=ListBox1.Items.Count;
    setLength(vGage,numGage+1);
    for i:=1 to numGage do
    begin
      s:=ListBox1.Items[i-1];
      for k:=0 to ob.Count-1 do if TMgObject(ob.Items[k]).Name=s then vGage[i]:=k;
    end;
  end;
end;

procedure TfmMultiEdit.SpeedButton1Click(Sender: TObject);
begin
  mp.Delete;
  mp.Free;
  mp:=TMultiPack.Create;
  TabSheet2Show(self);
  TabSheet3Show(self);
  RichEdit1.Lines.Clear;
end;

procedure TfmMultiEdit.TabSheet3Show(Sender: TObject);
var i:int;
begin
  with mp do
  begin
    ListBox9.Items.Clear;
    for i:=1 to mp.num-1 do ListBox9.Items.Add(IntToStr(i));
    CheckBox1.Checked:=bTopology;
    ComboBox1.ItemIndex:=solMet-1;
    Edit1.Text:=outpath;
    ComboBox3.ItemIndex:=outStyle-1;
    ////////////////////////////////
    ListBox1.Items.Clear;
    for i:=1 to numGage do ListBox1.Items.Add(TMgObject(ob.Items[vGage[i]]).Name)
  end;
end;

procedure TfmMultiEdit.SpeedButton3Click(Sender: TObject);
begin
  if sDlg2.Execute then
  begin
    TabSheet4Show(self);
    RichEdit1.Lines.SaveToFile(sDlg2.FileName);
  end;
end;

procedure TfmMultiEdit.SpeedButton2Click(Sender: TObject);
begin
  if sDlg1.Execute then MultiSave(sDlg1.FileName);
end;

procedure TfmMultiEdit.SpeedButton9Click(Sender: TObject);
begin
  if oDlg.Execute then
  begin
    MultiLoad(oDlg.FileName);
    TabSheet2Show(self);
    TabSheet3Show(self);
    RichEdit1.Lines.Clear;
  end;
end;

procedure TfmMultiEdit.SpeedButton4Click(Sender: TObject);
begin
  fmDirs:=TfmDirs.Create(Application);
  fmDirs.ShowModal;
  Edit1.Text:=fmDirs.s;
  fmDirs.Free;
end;

procedure TfmMultiEdit.ListBox9Click(Sender: TObject);
var k:int;
begin
  k:=ListBox9.ItemIndex+1;
  if k>0 then
  begin
    with mp.outName[k] do
    begin
      CheckBox2.Checked:=dr;
      Edit3.Text:=name;
      ComboBox4.ItemIndex:=val;
    end;
  end;
end;

procedure TfmMultiEdit.Button3Click(Sender: TObject);
var k:int;
begin
  k:=ListBox9.ItemIndex+1;
  if k>0 then
  begin
    with mp.outName[k] do
    begin
      dr:=CheckBox2.Checked;
      name:=Edit3.Text;
      val:=ComboBox4.ItemIndex;
    end;
  end;
end;

procedure TfmMultiEdit.TabSheet4Show(Sender: TObject);
var i,j,k:int;
    s:string;
begin
  ///////////////////////////////////
  //       Text Generator          //
  ///////////////////////////////////
  for i:=1 to mp.num do
  begin
    s:=IntToStr(i);
    
  end;
end;

end.
