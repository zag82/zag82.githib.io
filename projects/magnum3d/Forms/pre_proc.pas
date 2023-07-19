unit pre_proc;

interface

uses cm_ini, cmData, cmVars,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Grids, Spin, opengl, TeEngine,
  Series, TeeProcs, Chart;

type
  TfmPreprocessor = class(TForm)
    clDlg: TColorDialog;
    RadioGroup1: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    sg2: TStringGrid;
    GroupBox1: TGroupBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    Edit1: TEdit;
    Edit2: TEdit;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    StaticText67: TStaticText;
    StaticText47: TStaticText;
    StaticText48: TStaticText;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    StaticText51: TStaticText;
    StaticText52: TStaticText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label21: TLabel;
    Edit5: TEdit;
    Label22: TLabel;
    se2: TSpinEdit;
    ListBox2: TListBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label23: TLabel;
    GroupBox2: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Shape5: TShape;
    Label34: TLabel;
    ComboBox4: TComboBox;
    PageControl2: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    ListBox3: TListBox;
    Label35: TLabel;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText20: TStaticText;
    StaticText21: TStaticText;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit30: TEdit;
    ComboBox5: TComboBox;
    PageControl3: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    StaticText22: TStaticText;
    StaticText23: TStaticText;
    StaticText24: TStaticText;
    StaticText25: TStaticText;
    StaticText26: TStaticText;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    PageControl4: TPageControl;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    TabSheet17: TTabSheet;
    StaticText27: TStaticText;
    StaticText28: TStaticText;
    Edit35: TEdit;
    Edit36: TEdit;
    StaticText29: TStaticText;
    StaticText30: TStaticText;
    StaticText31: TStaticText;
    StaticText32: TStaticText;
    StaticText33: TStaticText;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    StaticText34: TStaticText;
    StaticText35: TStaticText;
    StaticText36: TStaticText;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    StaticText37: TStaticText;
    StaticText38: TStaticText;
    StaticText39: TStaticText;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    GroupBox3: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Edit47: TEdit;
    Edit48: TEdit;
    Edit49: TEdit;
    Edit50: TEdit;
    TabSheet18: TTabSheet;
    Label38: TLabel;
    seMat: TComboBox;
    sg1: TStringGrid;
    ListBox4: TListBox;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Edit51: TEdit;
    Edit52: TEdit;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    ComboBox6: TComboBox;
    StaticText40: TStaticText;
    StaticText41: TStaticText;
    StaticText42: TStaticText;
    StaticText43: TStaticText;
    StaticText44: TStaticText;
    StaticText45: TStaticText;
    StaticText46: TStaticText;
    Edit53: TEdit;
    Edit54: TEdit;
    Edit55: TEdit;
    Edit56: TEdit;
    Edit57: TEdit;
    Edit58: TEdit;
    GroupBox4: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Edit59: TEdit;
    Edit60: TEdit;
    Edit61: TEdit;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    SpinEdit1: TSpinEdit;
    Button14: TButton;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label69: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ud1: TUpDown;
    Button13: TButton;
    Button15: TButton;
    Timer1: TTimer;
    Button16: TButton;
    seDefect: TComboBox;
    seDD: TComboBox;
    Button17: TButton;
    Button18: TButton;
    Label70: TLabel;
    GroupBox7: TGroupBox;
    Chart1: TChart;
    Series1: TLineSeries;
    ComboBox9: TComboBox;
    Label71: TLabel;
    Label72: TLabel;
    Edit62: TEdit;
    SpeedButton4: TSpeedButton;
    Label73: TLabel;
    PageControl5: TPageControl;
    TabSheet19: TTabSheet;
    TabSheet20: TTabSheet;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Edit63: TEdit;
    Edit64: TEdit;
    Edit65: TEdit;
    Edit66: TEdit;
    Edit67: TEdit;
    Edit68: TEdit;
    Edit69: TEdit;
    Edit70: TEdit;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    ComboBox12: TComboBox;
    ComboBox13: TComboBox;
    Label77: TLabel;
    oDlg1: TOpenDialog;
    SpeedButton5: TSpeedButton;
    oDlg2: TOpenDialog;
    SpeedButton6: TSpeedButton;
    TabSheet23: TTabSheet;
    TabSheet24: TTabSheet;
    Edit71: TEdit;
    Edit72: TEdit;
    Edit73: TEdit;
    Edit74: TEdit;
    Edit75: TEdit;
    Edit76: TEdit;
    Edit77: TEdit;
    Edit78: TEdit;
    Label81: TLabel;
    Label85: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Edit79: TEdit;
    Edit80: TEdit;
    Edit81: TEdit;
    Edit82: TEdit;
    Edit83: TEdit;
    Edit84: TEdit;
    Edit85: TEdit;
    Edit86: TEdit;
    SpeedButton7: TSpeedButton;
    Label103: TLabel;
    Bevel4: TBevel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    CheckBox5: TCheckBox;
    SpeedButton8: TSpeedButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Shape5ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet2Exit(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure sg2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure TabSheet6Exit(Sender: TObject);
    procedure sg2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabSheet6Show(Sender: TObject);
    procedure Edit24KeyPress(Sender: TObject; var Key: Char);
    procedure Button9Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabSheet7Show(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure Edit53KeyPress(Sender: TObject; var Key: Char);
    procedure Button12Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ListBox4Click(Sender: TObject);
    procedure TabSheet5Show(Sender: TObject);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure TabSheet4Show(Sender: TObject);
    procedure TabSheet4Exit(Sender: TObject);
    procedure sg1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button14Click(Sender: TObject);
    procedure TabSheet18Show(Sender: TObject);
    procedure TabSheet18Exit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ud1Click(Sender: TObject; Button: TUDBtnType);
    procedure Button15Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button13Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TabSheet3Exit(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nm:string;
    nam:string;
    DC : HDC;
    hrc : HGLRC;
    procedure SetDCPixelFormat;
    procedure ReadPage;
    procedure WritePage;
  end;

var
  fmPreprocessor: TfmPreprocessor;

implementation

{$R *.DFM}
uses comvars, main, common_main2d, el_main2d, ss_main2d, ec_main2d,GL_OB,
  axu_3, ado3, uni_mesh;

var fontOffset : GLuint;

    angleX:GLfloat;
    angleY:GLfloat;
    angleZ:GLfloat;
    transX:GLfloat;
    transY:GLfloat;
    LastX:integer;
    LastY:integer;
    Down:boolean;
    bBound2:boolean;
    bBound3:boolean;
    bAxis:boolean;
    bObjects:boolean;
    pr_zoom:float=0;

    btn:TMouseButton;

 rasters : Array [0..94, 0..12] of GLUByte = (
($00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
($00, $00, $18, $18, $00, $00, $18, $18, $18, $18, $18, $18, $18),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $36, $36, $36, $36),
($00, $00, $00, $66, $66, $ff, $66, $66, $ff, $66, $66, $00, $00),
($00, $00, $18, $7e, $ff, $1b, $1f, $7e, $f8, $d8, $ff, $7e, $18),
($00, $00, $0e, $1b, $db, $6e, $30, $18, $0c, $76, $db, $d8, $70),
($00, $00, $7f, $c6, $cf, $d8, $70, $70, $d8, $cc, $cc, $6c, $38),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $1c, $0c, $0e),
($00, $00, $0c, $18, $30, $30, $30, $30, $30, $30, $30, $18, $0c),
($00, $00, $30, $18, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $18, $30),
($00, $00, $00, $00, $99, $5a, $3c, $ff, $3c, $5a, $99, $00, $00),
($00, $00, $00, $18, $18, $18, $ff, $ff, $18, $18, $18, $00, $00),
($00, $00, $30, $18, $1c, $1c, $00, $00, $00, $00, $00, $00, $00),
($00, $00, $00, $00, $00, $00, $ff, $ff, $00, $00, $00, $00, $00),
($00, $00, $00, $38, $38, $00, $00, $00, $00, $00, $00, $00, $00),
($00, $60, $60, $30, $30, $18, $18, $0c, $0c, $06, $06, $03, $03),
($00, $00, $3c, $66, $c3, $e3, $f3, $db, $cf, $c7, $c3, $66, $3c),
($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $78, $38, $18),
($00, $00, $ff, $c0, $c0, $60, $30, $18, $0c, $06, $03, $e7, $7e),
($00, $00, $7e, $e7, $03, $03, $07, $7e, $07, $03, $03, $e7, $7e),
($00, $00, $0c, $0c, $0c, $0c, $0c, $ff, $cc, $6c, $3c, $1c, $0c),
($00, $00, $7e, $e7, $03, $03, $07, $fe, $c0, $c0, $c0, $c0, $ff),
($00, $00, $7e, $e7, $c3, $c3, $c7, $fe, $c0, $c0, $c0, $e7, $7e),
($00, $00, $30, $30, $30, $30, $18, $0c, $06, $03, $03, $03, $ff),
($00, $00, $7e, $e7, $c3, $c3, $e7, $7e, $e7, $c3, $c3, $e7, $7e),
($00, $00, $7e, $e7, $03, $03, $03, $7f, $e7, $c3, $c3, $e7, $7e),
($00, $00, $00, $38, $38, $00, $00, $38, $38, $00, $00, $00, $00),
($00, $00, $30, $18, $1c, $1c, $00, $00, $1c, $1c, $00, $00, $00),
($00, $00, $06, $0c, $18, $30, $60, $c0, $60, $30, $18, $0c, $06),
($00, $00, $00, $00, $ff, $ff, $00, $ff, $ff, $00, $00, $00, $00),
($00, $00, $60, $30, $18, $0c, $06, $03, $06, $0c, $18, $30, $60),
($00, $00, $18, $00, $00, $18, $18, $0c, $06, $03, $c3, $c3, $7e),
($00, $00, $3f, $60, $cf, $db, $d3, $dd, $c3, $7e, $00, $00, $00),
($00, $00, $c3, $c3, $c3, $c3, $ff, $c3, $c3, $c3, $66, $3c, $18),
($00, $00, $fe, $c7, $c3, $c3, $c7, $fe, $c7, $c3, $c3, $c7, $fe),
($00, $00, $7e, $e7, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $e7, $7e),
($00, $00, $fc, $ce, $c7, $c3, $c3, $c3, $c3, $c3, $c7, $ce, $fc),
($00, $00, $ff, $c0, $c0, $c0, $c0, $fc, $c0, $c0, $c0, $c0, $ff),
($00, $00, $c0, $c0, $c0, $c0, $c0, $c0, $fc, $c0, $c0, $c0, $ff),
($00, $00, $7e, $e7, $c3, $c3, $cf, $c0, $c0, $c0, $c0, $e7, $7e),
($00, $00, $c3, $c3, $c3, $c3, $c3, $ff, $c3, $c3, $c3, $c3, $c3),
($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18, $7e),
($00, $00, $7c, $ee, $c6, $06, $06, $06, $06, $06, $06, $06, $06),
($00, $00, $c3, $c6, $cc, $d8, $f0, $e0, $f0, $d8, $cc, $c6, $c3),
($00, $00, $ff, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0),
($00, $00, $c3, $c3, $c3, $c3, $c3, $c3, $db, $ff, $ff, $e7, $c3),
($00, $00, $c7, $c7, $cf, $cf, $df, $db, $fb, $f3, $f3, $e3, $e3),
($00, $00, $7e, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $e7, $7e),
($00, $00, $c0, $c0, $c0, $c0, $c0, $fe, $c7, $c3, $c3, $c7, $fe),
($00, $00, $3f, $6e, $df, $db, $c3, $c3, $c3, $c3, $c3, $66, $3c),
($00, $00, $c3, $c6, $cc, $d8, $f0, $fe, $c7, $c3, $c3, $c7, $fe),
($00, $00, $7e, $e7, $03, $03, $07, $7e, $e0, $c0, $c0, $e7, $7e),
($00, $00, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $ff),
($00, $00, $7e, $e7, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3),
($00, $00, $18, $3c, $3c, $66, $66, $c3, $c3, $c3, $c3, $c3, $c3),
($00, $00, $c3, $e7, $ff, $ff, $db, $db, $c3, $c3, $c3, $c3, $c3),
($00, $00, $c3, $66, $66, $3c, $3c, $18, $3c, $3c, $66, $66, $c3),
($00, $00, $18, $18, $18, $18, $18, $18, $3c, $3c, $66, $66, $c3),
($00, $00, $ff, $c0, $c0, $60, $30, $7e, $0c, $06, $03, $03, $ff),
($00, $00, $3c, $30, $30, $30, $30, $30, $30, $30, $30, $30, $3c),
($00, $03, $03, $06, $06, $0c, $0c, $18, $18, $30, $30, $60, $60),
($00, $00, $3c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $3c),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $c3, $66, $3c, $18),
($ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00),
($00, $00, $00, $00, $00, $00, $00, $00, $00, $18, $38, $30, $70),
($00, $00, $7f, $c3, $c3, $7f, $03, $c3, $7e, $00, $00, $00, $00),
($00, $00, $fe, $c3, $c3, $c3, $c3, $fe, $c0, $c0, $c0, $c0, $c0),
($00, $00, $7e, $c3, $c0, $c0, $c0, $c3, $7e, $00, $00, $00, $00),
($00, $00, $7f, $c3, $c3, $c3, $c3, $7f, $03, $03, $03, $03, $03),
($00, $00, $7f, $c0, $c0, $fe, $c3, $c3, $7e, $00, $00, $00, $00),
($00, $00, $30, $30, $30, $30, $30, $fc, $30, $30, $30, $33, $1e),
($7e, $c3, $03, $03, $7f, $c3, $c3, $c3, $7e, $00, $00, $00, $00),
($00, $00, $c3, $c3, $c3, $c3, $c3, $c3, $fe, $c0, $c0, $c0, $c0),
($00, $00, $18, $18, $18, $18, $18, $18, $18, $00, $00, $18, $00),
($38, $6c, $0c, $0c, $0c, $0c, $0c, $0c, $0c, $00, $00, $0c, $00),
($00, $00, $c6, $cc, $f8, $f0, $d8, $cc, $c6, $c0, $c0, $c0, $c0),
($00, $00, $7e, $18, $18, $18, $18, $18, $18, $18, $18, $18, $78),
($00, $00, $db, $db, $db, $db, $db, $db, $fe, $00, $00, $00, $00),
($00, $00, $c6, $c6, $c6, $c6, $c6, $c6, $fc, $00, $00, $00, $00),
($00, $00, $7c, $c6, $c6, $c6, $c6, $c6, $7c, $00, $00, $00, $00),
($c0, $c0, $c0, $fe, $c3, $c3, $c3, $c3, $fe, $00, $00, $00, $00),
($03, $03, $03, $7f, $c3, $c3, $c3, $c3, $7f, $00, $00, $00, $00),
($00, $00, $c0, $c0, $c0, $c0, $c0, $e0, $fe, $00, $00, $00, $00),
($00, $00, $fe, $03, $03, $7e, $c0, $c0, $7f, $00, $00, $00, $00),
($00, $00, $1c, $36, $30, $30, $30, $30, $fc, $30, $30, $30, $00),
($00, $00, $7e, $c6, $c6, $c6, $c6, $c6, $c6, $00, $00, $00, $00),
($00, $00, $18, $3c, $3c, $66, $66, $c3, $c3, $00, $00, $00, $00),
($00, $00, $c3, $e7, $ff, $db, $c3, $c3, $c3, $00, $00, $00, $00),
($00, $00, $c3, $66, $3c, $18, $3c, $66, $c3, $00, $00, $00, $00),
($c0, $60, $60, $30, $18, $3c, $66, $66, $c3, $00, $00, $00, $00),
($00, $00, $ff, $60, $30, $18, $0c, $06, $ff, $00, $00, $00, $00),
($00, $00, $0f, $18, $18, $18, $38, $f0, $38, $18, $18, $18, $0f),
($18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18),
($00, $00, $f0, $18, $18, $18, $1c, $0f, $1c, $18, $18, $18, $f0),
($00, $00, $00, $00, $00, $00, $06, $8f, $f1, $60, $00, $00, $00)
);

procedure makeRasterFont;
var
  i : GLuint;
begin
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
  fontOffset := glGenLists (128);
  For i := 32 to 126 do begin
    glNewList(i + fontOffset, GL_COMPILE);
      glBitmap(8, 13, transX,-TransY , 10.0, 0.0, @rasters[i-32]);
    glEndList;
  end;
end;

procedure printString(s : String);
begin
  glPushAttrib (GL_LIST_BIT);
  glListBase(fontOffset);
  glCallLists(length(s), GL_UNSIGNED_BYTE, PChar(s));
  glPopAttrib;
end;

procedure TfmPreprocessor.ReadPage;
begin
  bBound2:=CheckBox1.Checked;
  bBound3:=CheckBox2.Checked;
  bAxis:=CheckBox3.Checked;
  bObjects:=CheckBox4.Checked;
  pr_zoom:=exp(ud1.Position*ln(2));
end;

procedure TfmPreprocessor.WritePage;
var tt:float;
begin
  CheckBox1.Checked:=bBound2;
  CheckBox2.Checked:=bBound3;
  CheckBox3.Checked:=bAxis;
  CheckBox4.Checked:=bObjects;
  tt:=exp(abs(ud1.Position)*ln(2));
  if ud1.Position>0 then
    Label3.Caption:=FloatToStrF(tt,ffGeneral,4,1)+':1'
  else
    Label3.Caption:='1:'+FloatToStrF(tt,ffGeneral,4,1);
end;

procedure TfmPreprocessor.SetDCPixelFormat;
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat(dc,@pfd);
 SetPixelFormat (dc, nPixelFormat, @pfd);
end;

procedure TfmPreprocessor.FormCreate(Sender: TObject);
var k:int;
begin
  if Task<0 then PageControl1.Enabled:=false else PageControl1.Enabled:=true;
  PageControl1.ActivePageIndex:=0;
  PageControl2.ActivePageIndex:=1;
  PageControl3.ActivePage:=TabSheet13;
  PageControl4.ActivePage:=TabSheet17;
  PageControl5.ActivePageIndex:=0;
  RadioGroup1.Controls[4].Enabled:=false;
  RadioGroup1.ItemIndex:=Task;
  nm:='Simple Bound';
  nam:='Simple Bound';
  // bound 2d
  // bound 3d
  // materials
  // objects
  // discretization 2d
  with sg2 do
  begin
    Cells[1,0]:='X : num';
    Cells[2,0]:='X : step';
    Cells[3,0]:='Z : num';
    Cells[4,0]:='Z : step';
    ColWidths[1]:=64;
    ColWidths[2]:=64;
    ColWidths[3]:=64;
    ColWidths[4]:=64;
    Cells[0,0]:='A';
    for k:=1 to 200 do
      Cells[0,k]:=IntToStr(k)+'.';
  end;
  // discretization 3d
  with sg1 do
  begin
    Cells[1,0]:='R : num';
    Cells[2,0]:='R : step';
    Cells[3,0]:='Fi : num';
    Cells[4,0]:='Fi : step';
    Cells[5,0]:='Z : num';
    Cells[6,0]:='Z : step';
    ColWidths[1]:=64;
    ColWidths[2]:=64;
    ColWidths[3]:=64;
    ColWidths[4]:=64;
    ColWidths[5]:=64;
    ColWidths[6]:=64;
    Cells[0,0]:='#';
    for k:=1 to 200 do
      Cells[0,k]:=IntToStr(k)+'.';
  end;
  //////////////////////////
  angleX:=300;
  angleY:=0;
  angleZ:=30;
  LastX:=0;
  LastY:=0;
  Down:=false;
  transX:=0;
  transY:=0;
  ReadPage;
  WritePage;
  //////////////////////////
  tt.PrepareData;
  axa.PrepareData;
  mt.ChangeNum;
  mt.GenerateAllProperties(Task);
  //////////////////////////
  DC := GetDC(Panel1.Handle);
  SetDCPixelFormat;
  hrc := wglCreateContext(DC);
  wglMakeCurrent(DC, hrc);
  glClearColor (0.5, 0.5, 0.5, 1.0);
  glEnable(GL_DEPTH_TEST);
{  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);}
  glEnable(GL_COLOR_MATERIAL);
  makeRasterFont;
end;

procedure TfmPreprocessor.BitBtn1Click(Sender: TObject);
begin
  Shape1.Visible:=true;
  Shape2.Visible:=false;
  Shape3.Visible:=false;
  Shape4.Visible:=false;
  nm:='R min';
  Edit24.Text:='1';
  Edit25.Text:='1';
  Edit28.Text:='1';
  Edit29.Text:='-1';
end;

procedure TfmPreprocessor.BitBtn2Click(Sender: TObject);
begin
  Shape1.Visible:=false;
  Shape2.Visible:=true;
  Shape3.Visible:=false;
  Shape4.Visible:=false;
  nm:='Z min';
  Edit24.Text:='1';
  Edit25.Text:='-1';
  Edit28.Text:='1';
  Edit29.Text:='1';
end;

procedure TfmPreprocessor.BitBtn3Click(Sender: TObject);
begin
  Shape1.Visible:=false;
  Shape2.Visible:=false;
  Shape3.Visible:=true;
  Shape4.Visible:=false;
  nm:='R max';
  Edit24.Text:='-1';
  Edit25.Text:='-1';
  Edit28.Text:='1';
  Edit29.Text:='-1';
end;

procedure TfmPreprocessor.BitBtn4Click(Sender: TObject);
begin
  Shape1.Visible:=false;
  Shape2.Visible:=false;
  Shape3.Visible:=false;
  Shape4.Visible:=true;
  nm:='Z max';
  Edit24.Text:='1';
  Edit25.Text:='-1';
  Edit28.Text:='-1';
  Edit29.Text:='-1';
end;

procedure TfmPreprocessor.Button3Click(Sender: TObject);
begin
  bnd2:=nil;
  Nbnd2:=0;
  ListBox1.Items.Clear;
end;

procedure TfmPreprocessor.Button1Click(Sender: TObject);
var bb:TBound2;
begin
  if nm='' then
    nm:='SimpleBound';
  bb.nm:=nm;
  bb.x1:=StrToInt(Edit24.Text);
  bb.x2:=StrToInt(Edit25.Text);
  bb.z1:=StrToInt(Edit28.Text);
  bb.z2:=StrToInt(Edit29.Text);
  bb.val:=StrToFloat(Edit3.Text);
  bb.vl_im:=StrToFloat(Edit4.Text);
  ListBox1.Items.Add(nm+' - '+Edit3.Text);
  nBnd2:=ListBox1.Items.Count;
  SetLength(bnd2,Nbnd2);
  bnd2[Nbnd2-1]:=bb;
end;

procedure TfmPreprocessor.Button2Click(Sender: TObject);
var i,k:int;
begin
  if ListBox1.ItemIndex>=0 then
  begin
    k:=ListBox1.ItemIndex;
    ListBox1.Items.Delete(k);
    for i:=k+1 to ListBox1.Items.Count-1 do
      bnd2[i-1]:=bnd2[i];
    nBnd2:=ListBox1.Items.Count;
    SetLength(bnd2,Nbnd2);
  end;
end;

procedure TfmPreprocessor.ListBox1Click(Sender: TObject);
var k:int;
begin
  k:=ListBox1.ItemIndex;
  Edit24.Text:=IntToStr(bnd2[k].x1);
  Edit25.Text:=IntToStr(bnd2[k].x2);
  Edit28.Text:=IntToStr(bnd2[k].z1);
  Edit29.Text:=IntToStr(bnd2[k].z2);
  Edit3.Text:=FloatToStrF(bnd2[k].val,ffGeneral,5,1);
  Edit4.Text:=FloatToStrF(bnd2[k].vl_im,ffGeneral,5,1);
end;

procedure TfmPreprocessor.Shape5ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if clDlg.Execute then
    Shape5.Brush.Color:=clDlg.Color;
end;

procedure TfmPreprocessor.Button4Click(Sender: TObject);
var k:int;
begin
  k:=mt.nMaterials;
  ListBox2.Items.Add(Edit6.Text);
  inc(mt.nMaterials);
  mt.ChangeNum;
  Label25.Caption:=IntToStr(mt.nMaterials);
  se2.MaxValue:=mt.nMaterials-1;
  with mt do
  begin
    mmName[k]:=Edit6.Text;
    mmColor[k]:=Shape5.Brush.Color;
    muProperty[k]:=StrToFloat(Edit7.Text);
    Epsilon[k]:=StrToFloat(Edit8.Text);
    Sigma[k]:=StrToFloat(Edit9.Text)*1e6;
    Anisotropy_X[k]:=StrToFloat(Edit10.Text);
    Anisotropy_Y[k]:=StrToFloat(Edit11.Text);
    Anisotropy_Z[k]:=StrToFloat(Edit12.Text);
    nlProperty[k]:=ComboBox9.ItemIndex;
    nlFile[k]:=Edit62.Text;
  end;
  ActiveControl:=Edit6;
  Edit6.Text:='';
  Edit7.Text:='1';
  Edit8.Text:='1';
  Edit9.Text:='1E-20';
  Edit10.Text:='1';
  Edit11.Text:='1';
  Edit12.Text:='1';
  Shape5.Brush.Color:=clWhite;
end;

procedure TfmPreprocessor.Button5Click(Sender: TObject);
var i,k:int;
begin
  if ListBox2.ItemIndex>=0 then
  begin
    k:=ListBox2.ItemIndex;
    ListBox2.Items.Delete(k);
    for i:=k+1 to ListBox2.Items.Count-1 do
    begin
      mt.mmName[i-1]:=mt.mmName[i];
      mt.mmColor[i-1]:=mt.mmColor[i];
      mt.Epsilon[i-1]:=mt.Epsilon[i];
      mt.Sigma[i-1]:=mt.Sigma[i];
      mt.muProperty[i-1]:=mt.muProperty[i];
      mt.Anisotropy_X[i-1]:=mt.Anisotropy_X[i];
      mt.Anisotropy_Y[i-1]:=mt.Anisotropy_Y[i];
      mt.Anisotropy_Z[i-1]:=mt.Anisotropy_Z[i];
      mt.nlProperty[i-1]:=mt.nlProperty[i];
      mt.nlFile[i-1]:=mt.nlFile[i];
    end;
    dec(mt.nMaterials);
    mt.ChangeNum;
    Label25.Caption:=IntToStr(mt.nMaterials);
    se2.MaxValue:=mt.nMaterials-1;
  end;
end;

procedure TfmPreprocessor.ListBox2Click(Sender: TObject);
var k:int;
begin
  if ListBox2.ItemIndex>=0 then
  begin
    k:=ListBox2.ItemIndex;
    ActiveControl:=Edit6;
    Edit6.Text:=mt.mmName[k];
    Edit7.Text:=FloatToStrF(mt.muProperty[k],ffGeneral,6,3);
    Edit8.Text:=FloatToStrF(mt.Epsilon[k],ffGeneral,6,3);
    Edit9.Text:=FloatToStrF(mt.Sigma[k]/1e6,ffGeneral,6,3);
    Edit10.Text:=FloatToStrF(mt.Anisotropy_X[k],ffGeneral,6,3);
    Edit11.Text:=FloatToStrF(mt.Anisotropy_Y[k],ffGeneral,6,3);
    Edit12.Text:=FloatToStrF(mt.Anisotropy_Z[k],ffGeneral,6,3);
    Shape5.Brush.Color:=mt.mmColor[k];
    ComboBox9.ItemIndex:=mt.nlProperty[k];
    Edit62.Text:=mt.nlFile[k];
  end;
end;

procedure TfmPreprocessor.Button6Click(Sender: TObject);
var k:int;
begin
  k:=ListBox2.ItemIndex;
  if k<0 then exit;
  with mt do
  begin
    mmName[k]:=Edit6.Text;
    mmColor[k]:=Shape5.Brush.Color;
    muProperty[k]:=StrToFloat(Edit7.Text);
    Epsilon[k]:=StrToFloat(Edit8.Text);
    Sigma[k]:=StrToFloat(Edit9.Text)*1e6;
    Anisotropy_X[k]:=StrToFloat(Edit10.Text);
    Anisotropy_Y[k]:=StrToFloat(Edit11.Text);
    Anisotropy_Z[k]:=StrToFloat(Edit12.Text);
    nlProperty[k]:=ComboBox9.ItemIndex;
    nlFile[k]:=Edit62.Text;
  end;
  ListBox2.Items[k]:=mt.mmName[k];
  Combobox9.ItemIndex:=0;
  Edit62.Text:='';
  ActiveControl:=Edit6;
  Edit6.Text:='';
  Edit7.Text:='1';
  Edit8.Text:='1';
  Edit9.Text:='1E-20';
  Edit10.Text:='1';
  Edit11.Text:='1';
  Edit12.Text:='1';
  Shape5.Brush.Color:=clWhite;
end;

procedure TfmPreprocessor.TabSheet2Show(Sender: TObject);
var i:int;
begin
  Label25.Caption:=IntToStr(mt.nMaterials);
  se2.MaxValue:=mt.nMaterials-1;
  se2.Value:=mt.DefaultMaterial;
  Edit5.Text:=FloatToStrF(mt.Frequency,ffGeneral,6,3);
  ////////////////////
  ListBox2.Items.Clear;
  for i:=0 to mt.nMaterials-1 do
    ListBox2.Items.Add(mt.mmName[i]);
  ////////////////////
  Combobox9.ItemIndex:=0;
  Edit62.Text:='';
  ActiveControl:=Edit6;
  Edit6.Text:='';
  Edit7.Text:='1';
  Edit8.Text:='1';
  Edit9.Text:='1E-20';
  Edit10.Text:='1';
  Edit11.Text:='1';
  Edit12.Text:='1';
  Shape5.Brush.Color:=clWhite;
end;

procedure TfmPreprocessor.TabSheet2Exit(Sender: TObject);
begin
  mt.DefaultMaterial:=se2.Value;
  mt.Frequency:=StrToFloat(Edit5.Text);
  mt.GenerateAllProperties(Task);
end;

procedure TfmPreprocessor.RadioGroup1Click(Sender: TObject);
var k,i:int;
begin
  k:=RadioGroup1.ItemIndex;
  if k<0 then exit;
  if Task<>k then
    if Task>=0 then
    if (MessageDlg('Do you want to change project number'#10#13'from '+IntTostr(Task)+' to '+IntTostr(k)+' ?',
      mtConfirmation,[mbYes,mbNo],-1)=mrNo) then
    begin
      RadioGroup1.ItemIndex:=Task;
      exit;
    end;
  Task:=k;
  fmMain.Caption:='<'+IntToStr(Task)+'> ( '+ProjectName+' ) - '+capMain;
  PageControl1.Enabled:=true;
  // 2d bound
  if Task=5 then
  begin
    Edit4.Visible:=true;
    Label20.Visible:=true;
    Label19.Caption:='Re';
    //
    Edit52.visible:=true;
    Label41.Visible:=true;
    Label40.Caption:='Re';
  end
  else
  begin
    Edit4.Visible:=false;
    Label20.Visible:=false;
    Label19.Caption:='Val';
    //
    Edit52.visible:=false;
    Label41.Visible:=false;
    Label40.Caption:='Val';
  end;
  // objects
  for i:=0 to PageControl4.PageCount-1 do PageControl4.Pages[i].TabVisible:=False;
  for i:=0 to PageControl3.PageCount-1 do PageControl3.Pages[i].TabVisible:=False;
  TabSheet17.TabVisible:=True;
  TabSheet13.TabVisible:=True;
  case Task of
    0:begin
        TabSheet12.TabVisible:=True;
        TabSheet16.TabVisible:=True;
      end;
    2:begin
        TabSheet15.TabVisible:=True;
        TabSheet11.TabVisible:=True;
      end;
    3,5:begin
        TabSheet10.TabVisible:=True;
        TabSheet14.TabVisible:=True;
        TabSheet15.TabVisible:=True;
        TabSheet11.TabVisible:=True;
      end;
  end;
  // redeclare 2d object
  TabSheet6Show(self);
  tt.ReleaseVars();
  tt.Free;
  Case Task of
    0..2:tt:=TFlatELTask.Create;
    3:tt:=TFlatSSTask.Create;
    5:tt:=TFlatECTask.Create;
  end;
  TabSheet6Exit(self);
end;

procedure TfmPreprocessor.sg2SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow=(sg2.RowCount-1) then sg2.RowCount:=sg2.RowCount+1;
end;

procedure TfmPreprocessor.ComboBox1Change(Sender: TObject);
begin
  Case ComboBox1.ItemIndex of
    0:begin
        StaticText1.Caption:='X0';
        StaticText2.Caption:='Z0';
        StaticText3.Caption:='X1 =';
        StaticText5.Caption:='Z1 =';
        sg2.Cells[1,0]:='X : num';
        sg2.Cells[2,0]:='X : val';
        sg2.Cells[3,0]:='Z : num';
        sg2.Cells[4,0]:='Z : val';
      end;
    1:begin
        StaticText1.Caption:='R0';
        StaticText2.Caption:='Fi0';
        StaticText3.Caption:='R1 =';
        StaticText5.Caption:='Fi1 =';
        sg2.Cells[1,0]:='R : num';
        sg2.Cells[2,0]:='R : val';
        sg2.Cells[3,0]:='Fi : num';
        sg2.Cells[4,0]:='Fi : val';
      end;
  end;
end;

procedure TfmPreprocessor.TabSheet6Exit(Sender: TObject);
var i:int;
    k:int;
    nn,k1,k2:int;
    mem:double;
begin
  tt.defMat:=seDefect.ItemIndex-1;
  tt.angle:=ComboBox4.ItemIndex+1;
  tt.sort_d:=ComboBox1.ItemIndex+1;
  tt.sort_t:=ComboBox2.ItemIndex+1;
  tt.sort_ex:=ComboBox3.ItemIndex+1;
  tt.ax:=StrToFloat(Edit1.Text)/1000;
  if tt.sort_d=1 then k:=1000 else k:=1;
  tt.az:=StrToFloat(Edit2.Text)/k;
  nn:=sg2.RowCount-1;
  k1:=0;k2:=0;
  for i:=1 to nn do if (sg2.Cells[1,i]='')or(sg2.Cells[2,i]='') then begin k1:=i-1; break end;
  for i:=1 to nn do if (sg2.Cells[3,i]='')or(sg2.Cells[4,i]='') then begin k2:=i-1; break end;
  tt.nd1:=k1;
  tt.nd2:=k2;
  tt.disc_1:=nil;
  tt.disc_2:=nil;
  SetLength(tt.disc_1,k1+1);
  SetLength(tt.disc_2,k2+1);
  for i:=1 to k1 do
  begin
    tt.disc_1[i].num:=StrToInt(sg2.Cells[1,i]);
    tt.disc_1[i].val:=StrToFloat(sg2.Cells[2,i])/1000;
  end;
  if tt.sort_d=1 then k:=1000 else k:=1;
  for i:=1 to k2 do
  begin
    tt.disc_2[i].num:=StrToInt(sg2.Cells[3,i]);
    tt.disc_2[i].val:=StrToFloat(sg2.Cells[4,i])/k;
  end;
  tt.PrepareData();
  /////////////////
  StaticText4.Caption:=FloatToStrF(tt.bx*1e3,ffGeneral,6,3);
  if tt.sort_d=1 then k:=1000 else k:=1;
  StaticText6.Caption:=FloatToStrF(tt.bz*k,ffGeneral,6,3);
  Label10.Caption:=IntToStr(tt.nnx);
  Label11.Caption:=IntToStr(tt.nnz);
  with tt do
  begin
    Label12.Caption:=IntToStr(tt.NNodes);
    Label13.Caption:=IntToStr(tt.NTriangles);
  end;
  if Task=5 then nn:=2 else nn:=1;
  mem:=1.1*(tt.NTriangles*(4+3)*SizeOf(int)+tt.NNodes*20*(nn+1)*SizeOf(float))/sqr(1024);
  Label65.Caption:=FloatToStrF(mem,ffFixed,6,2);
end;

procedure TfmPreprocessor.sg2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then TabSheet6Exit(Self);
end;

procedure TfmPreprocessor.TabSheet6Show(Sender: TObject);
var i:int;
    k:int;
    mem:double;
begin
  seDefect.Items.Clear;
  seDefect.Items.Add('-1 - None');
  for i:=1 to mt.nMaterials do
    seDefect.Items.Add(IntToStr(i-1)+' - '+mt.mmName[i-1]);
  seDefect.ItemIndex:=tt.defMat+1;
  ComboBox4.ItemIndex:=tt.angle-1;
  ComboBox1.ItemIndex:=tt.sort_d-1;
  ComboBox2.ItemIndex:=tt.sort_t-1;
  ComboBox3.ItemIndex:=tt.sort_ex-1;
  ComboBox1Change(self);
  Edit1.Text:=FloatToStrF(tt.ax*1e3,ffGeneral,6,3);
  if tt.sort_d=1 then k:=1000 else k:=1;
  Edit2.Text:=FloatToStrF(tt.az*k,ffGeneral,6,3);
  sg2.RowCount:=2+max(tt.nd1,tt.nd2);
  for i:=1 to tt.nd1 do
  begin
    sg2.Cells[1,i]:=IntToStr(tt.disc_1[i].num);
    sg2.Cells[2,i]:=FloatToStrF(tt.disc_1[i].val*1e3,ffGeneral,6,3);
  end;
  if tt.sort_d=1 then k:=1000 else k:=1;
  for i:=1 to tt.nd2 do
  begin
    sg2.Cells[3,i]:=IntToStr(tt.disc_2[i].num);
    sg2.Cells[4,i]:=FloatToStrF(tt.disc_2[i].val*k,ffGeneral,6,3);
  end;
  /////////////////
  StaticText4.Caption:=FloatToStrF(tt.bx*1e3,ffGeneral,6,3);
  if tt.sort_d=1 then k:=1000 else k:=1;
  StaticText6.Caption:=FloatToStrF(tt.bz*k,ffGeneral,6,3);
  Label10.Caption:=IntToStr(tt.nnx);
  Label11.Caption:=IntToStr(tt.nnz);
  with tt do
  begin
    Label12.Caption:=IntToStr(tt.NNodes);
    Label13.Caption:=IntToStr(tt.NTriangles);
  end;
  if Task=5 then k:=2 else k:=1;
  mem:=1.1*(tt.NTriangles*(4+3)*SizeOf(int)+tt.NNodes*20*(k+1)*SizeOf(float))/sqr(1024);
  Label65.Caption:=FloatToStrF(mem,ffFixed,6,2);
end;

procedure TfmPreprocessor.Edit24KeyPress(Sender: TObject; var Key: Char);
begin
  Shape1.Visible:=false;
  Shape2.Visible:=false;
  Shape3.Visible:=false;
  Shape4.Visible:=false;
  nm:='';
end;

procedure TfmPreprocessor.Button9Click(Sender: TObject);
begin
  ListBox3.Items.Clear;
  ob.Clear;
  ActiveControl:=Edit47;
end;

procedure TfmPreprocessor.Button7Click(Sender: TObject);
var k:int;
    x1,x2,y1,y2,z1,z2,x3,z3:float;
    x,y,z,r1,r2,al,bt,h:float;
    ss:st1;
begin
  k:=ob.Count;
  ListBox3.Items.Add(IntToStr(k+1)+' - '+Edit47.Text);
  Case PageControl2.ActivePageIndex of
    0:begin // Block
        x1:=StrToFloat(Edit13.Text)/1000;
        y1:=StrToFloat(Edit14.Text)/1000;
        z1:=StrToFloat(Edit15.Text)/1000;
        x2:=StrToFloat(Edit16.Text)/1000;
        y2:=StrToFloat(Edit17.Text)/1000;
        z2:=StrToFloat(Edit18.Text)/1000;
        Case PageControl3.ActivePageIndex of
        0:begin // current
            ob.Add(TBlock.Create(seMat.ItemIndex,Edit47.Text));
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(StrToFloat(Edit31.Text)*1e6,
                                         StrToFloat(Edit32.Text)*1e6,
                                         StrToFloat(Edit33.Text)*1e6,
                                         StrToFloat(Edit34.Text),3);
          end;
        1:begin // magnet
            ob.Add(TBlock.Create(seMat.ItemIndex,Edit47.Text));
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(StrToFloat(Edit48.Text),
                                         StrToFloat(Edit49.Text),
                                         StrToFloat(Edit50.Text),
                                         0.0,2);
          end;
        2:begin // charge
            ob.Add(TBlock.Create(seMat.ItemIndex,Edit47.Text));
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(StrToFloat(Edit35.Text),
                                         0.0, 0.0, 0.0,1);
          end;
        else begin // none
            ob.Add(TBlock.Create(seMat.ItemIndex,Edit47.Text));
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(0, 0, 0, 0,0);
          end;
        end;
      end;
    1:begin // sector
        x:=StrToFloat(Edit19.Text)/1000;
        y:=StrToFloat(Edit20.Text)/1000;
        z:=StrToFloat(Edit21.Text)/1000;
        r1:=StrToFloat(Edit22.Text)/1000;
        r2:=StrToFloat(Edit23.Text)/1000;
        h:=StrToFloat(Edit26.Text)/1000;
        al:=StrToFloat(Edit27.Text);
        bt:=StrToFloat(Edit30.Text);
        ss:=ComboBox5.Text;
        Case PageControl4.ActivePageIndex of
        0:begin // current
            ob.Add(TSector.Create(seMat.ItemIndex,Edit47.Text));
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(StrToFloat(Edit37.Text)*1e6,
                                          StrToFloat(Edit38.Text)*1e6,
                                          StrToFloat(Edit39.Text)*1e6,
                                          StrToFloat(Edit40.Text),3);
          end;
        1:begin // magnet
            ob.Add(TSector.Create(seMat.ItemIndex,Edit47.Text));
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(StrToFloat(Edit44.Text),
                                          StrToFloat(Edit45.Text),
                                          StrToFloat(Edit46.Text),
                                          0.0,2);
          end;
        2:begin // charge
            ob.Add(TSector.Create(seMat.ItemIndex,Edit47.Text));
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(StrToFloat(Edit36.Text),
                                          0,0,0,1);
          end;
        else begin // none
            ob.Add(TSector.Create(seMat.ItemIndex,Edit47.Text));
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(0,0,0,0,0);
          end;
        end;
      end;
    2:begin // Triangle block
        x1:=StrToFloat(Edit71.Text)/1000;
        x2:=StrToFloat(Edit72.Text)/1000;
        x3:=StrToFloat(Edit73.Text)/1000;
        z1:=StrToFloat(Edit74.Text)/1000;
        z2:=StrToFloat(Edit75.Text)/1000;
        z3:=StrToFloat(Edit76.Text)/1000;
        y1:=StrToFloat(Edit77.Text)/1000;
        y2:=StrToFloat(Edit78.Text)/1000;
        ss:=ComboBox5.Text;
        ob.Add(TTriBlock.Create(seMat.ItemIndex,Edit47.Text));
        TTriBlock(ob.Items[k]).SetData(x1,z1,x2,z2,x3,z3,y1,y2);
        TTriBlock(ob.Items[k]).DataLoad(0,0,0,0,0);
      end;
    3:begin // Triangle sector
        x1:=StrToFloat(Edit79.Text)/1000;
        x2:=StrToFloat(Edit80.Text)/1000;
        x3:=StrToFloat(Edit81.Text)/1000;
        z1:=StrToFloat(Edit82.Text)/1000;
        z2:=StrToFloat(Edit83.Text)/1000;
        z3:=StrToFloat(Edit84.Text)/1000;
        al:=StrToFloat(Edit85.Text);
        bt:=StrToFloat(Edit86.Text);
        ss:=ComboBox5.Text;
        ob.Add(TTriSec.Create(seMat.ItemIndex,Edit47.Text));
        TTriSec(ob.Items[k]).SetData(x1,z1,x2,z2,x3,z3,al,bt);
        TTriSec(ob.Items[k]).DataLoad(0,0,0,0,0);
      end;
  end;
end;

procedure TfmPreprocessor.Button8Click(Sender: TObject);
var k:int;
begin
  k:=ListBox3.ItemIndex;
  if k<0 then exit;
  ListBox3.Items.Delete(k);
  ob.Delete(k);
  Edit47.Text:='';
  ActiveControl:=Edit47;
end;

procedure TfmPreprocessor.ListBox3Click(Sender: TObject);
var k:int;
    Sec:TSector;
    Blc:TBlock;
    ttb:TTriBlock;
    tts:TTriSec;
begin
  k:=ListBox3.ItemIndex;
  if k<0 then exit;
  Edit47.Text:=TMgObject(ob.Items[k]).Name;
  seMat.ItemIndex:=TMgObject(ob.Items[k]).GetMaterial();
  if TMgObject(ob.Items[k]) is TSector then // Sector
  begin
    PageControl2.ActivePageIndex:=1;
    Sec:=TSector(ob.Items[k]);
    Edit19.Text:=FloatToStrF(Sec.xx*1e3,ffGeneral,6,3);
    Edit20.Text:=FloatToStrF(Sec.yy*1e3,ffGeneral,6,3);
    Edit21.Text:=FloatToStrF(Sec.zz*1e3,ffGeneral,6,3);
    Edit22.Text:=FloatToStrF(Sec.r1*1e3,ffGeneral,6,3);
    Edit23.Text:=FloatToStrF(Sec.r2*1e3,ffGeneral,6,3);
    Edit26.Text:=FloatToStrF(Sec.h*1e3,ffGeneral,6,3);
    Edit27.Text:=FloatToStrF(Sec.al,ffGeneral,6,3);
    Edit30.Text:=FloatToStrF(Sec.bt,ffGeneral,6,3);
    ComboBox5.ItemIndex:=sec.ax_dir-1;
    Case sec.sr_kind of
      0:PageControl4.ActivePageIndex:=3; // none
      1:begin                            // charge
          PageControl4.ActivePageIndex:=2;
          Edit36.Text:=FloatToStrF(Sec.sr_1,ffGeneral,6,3);
        end;
      2:begin                            // magnet
          PageControl4.ActivePageIndex:=1;
          Edit44.Text:=FloatToStrF(Sec.sr_1,ffGeneral,6,3);
          Edit45.Text:=FloatToStrF(Sec.sr_2,ffGeneral,6,3);
          Edit46.Text:=FloatToStrF(Sec.sr_3,ffGeneral,6,3);
        end;
      else begin   // current
        PageControl4.ActivePageIndex:=0;
        Edit37.Text:=FloatToStrF(Sec.sr_1/1e6,ffGeneral,6,3);
        Edit38.Text:=FloatToStrF(Sec.sr_2/1e6,ffGeneral,6,3);
        Edit39.Text:=FloatToStrF(Sec.sr_3/1e6,ffGeneral,6,3);
        Edit40.Text:=FloatToStrF(Sec.sr_4,ffGeneral,6,3);
      end;
    end;
  end
  else if TMgObject(ob.Items[k]) is TBlock then// Block
  begin
    PageControl2.ActivePageIndex:=0;
    Blc:=TBlock(ob.Items[k]);
    Edit13.Text:=FloatToStrF(Blc.x_1*1e3,ffGeneral,6,3);
    Edit14.Text:=FloatToStrF(Blc.y_1*1e3,ffGeneral,6,3);
    Edit15.Text:=FloatToStrF(Blc.z_1*1e3,ffGeneral,6,3);
    Edit16.Text:=FloatToStrF(Blc.x_2*1e3,ffGeneral,6,3);
    Edit17.Text:=FloatToStrF(Blc.y_2*1e3,ffGeneral,6,3);
    Edit18.Text:=FloatToStrF(Blc.z_2*1e3,ffGeneral,6,3);
    Case Blc.sr_kind of
      0:PageControl3.ActivePageIndex:=3; // none
      1:begin                            // charge
          PageControl3.ActivePageIndex:=2;
          Edit35.Text:=FloatToStrF(Blc.sr_1,ffGeneral,6,3);
        end;
      2:begin                            // magnet
          PageControl3.ActivePageIndex:=1;
          Edit48.Text:=FloatToStrF(Blc.sr_1,ffGeneral,6,3);
          Edit49.Text:=FloatToStrF(Blc.sr_2,ffGeneral,6,3);
          Edit50.Text:=FloatToStrF(Blc.sr_3,ffGeneral,6,3);
        end;
      else begin   // current
        PageControl3.ActivePageIndex:=0;
        Edit31.Text:=FloatToStrF(Blc.sr_1/1e6,ffGeneral,6,3);
        Edit32.Text:=FloatToStrF(Blc.sr_2/1e6,ffGeneral,6,3);
        Edit33.Text:=FloatToStrF(Blc.sr_3/1e6,ffGeneral,6,3);
        Edit34.Text:=FloatToStrF(Blc.sr_4,ffGeneral,6,3);
      end;
    end;
  end
  else if TMgObject(ob.Items[k]) is TTriBlock then
  begin
    PageControl2.ActivePageIndex:=2;
    ttb:=TTriBlock(ob.Items[k]);
    Edit71.Text:=FloatToStrF(ttb.x1*1e3,ffGeneral,6,3);
    Edit72.Text:=FloatToStrF(ttb.x2*1e3,ffGeneral,6,3);
    Edit73.Text:=FloatToStrF(ttb.x3*1e3,ffGeneral,6,3);
    Edit74.Text:=FloatToStrF(ttb.z1*1e3,ffGeneral,6,3);
    Edit75.Text:=FloatToStrF(ttb.z2*1e3,ffGeneral,6,3);
    Edit76.Text:=FloatToStrF(ttb.z3*1e3,ffGeneral,6,3);
    Edit77.Text:=FloatToStrF(ttb.y_min*1e3,ffGeneral,6,3);
    Edit78.Text:=FloatToStrF(ttb.y_max*1e3,ffGeneral,6,3);
  end
  else if TMgObject(ob.Items[k]) is TTriSec then
  begin
    PageControl2.ActivePageIndex:=3;
    tts:=TTriSec(ob.Items[k]);
    Edit79.Text:=FloatToStrF(tts.x1*1e3,ffGeneral,6,3);
    Edit80.Text:=FloatToStrF(tts.x2*1e3,ffGeneral,6,3);
    Edit81.Text:=FloatToStrF(tts.x3*1e3,ffGeneral,6,3);
    Edit82.Text:=FloatToStrF(tts.z1*1e3,ffGeneral,6,3);
    Edit83.Text:=FloatToStrF(tts.z2*1e3,ffGeneral,6,3);
    Edit84.Text:=FloatToStrF(tts.z3*1e3,ffGeneral,6,3);
    Edit85.Text:=FloatToStrF(tts.al,ffGeneral,6,3);
    Edit86.Text:=FloatToStrF(tts.bt,ffGeneral,6,3);
  end;
  ActiveControl:=Edit47;
end;

procedure TfmPreprocessor.TabSheet3Show(Sender: TObject);
var i:int;
begin
  seMat.Items.Clear;
  for i:=0 to mt.nMaterials-1 do
    seMat.Items.Add(IntToStr(i)+' - '+mt.mmName[i]);
  seMat.ItemIndex:=0;
  ListBox3.Items.Clear;
  for i:=0 to ob.Count-1 do
    ListBox3.Items.Add(IntToStr(i+1)+' - '+TMgObject(ob.Items[i]).Name);
  ListBox3.ItemIndex:=-1;
  ///////////////////////
  // Parameters
  Edit63.Text:=FloatToStrF(ps.wError2d,ffGeneral,6,3);
  Edit64.Text:=IntToStr(ps.wMIter2d);
  ComboBox10.ItemIndex:=ps.wSMeth2d;
  //
  Edit65.Text:=FloatToStrF(ps.wError3d,ffGeneral,6,3);
  Edit66.Text:=IntToStr(ps.wMIter3d);
  ComboBox11.ItemIndex:=ps.wSMeth3d;
  //
  Edit67.Text:=FloatToStrF(ps.wError_d,ffGeneral,6,3);
  Edit68.Text:=IntToStr(ps.wMIter_d);
  ComboBox12.ItemIndex:=ps.wSMeth_d;
  //
  Edit69.Text:=FloatToStrF(ps.wError_n,ffGeneral,6,3);
  Edit70.Text:=IntToStr(ps.wMIter_n);
  ComboBox13.ItemIndex:=ps.wSMeth_n;
  ///////////////////////
end;

procedure TfmPreprocessor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if prAllowClose then
  begin
    a_UnLoadProject;
    FreeAll_3d;
    fmPreProcessor:=nil;
    Action:=caFree;
    prAllowClose:=false;
  end
  else
    Action:=caNone;
end;

procedure TfmPreprocessor.TabSheet7Show(Sender: TObject);
var k:int;
begin
  ListBox1.Items.Clear;
  for k:=0 to Nbnd2-1 do
    ListBox1.Items.Add(bnd2[k].nm+' - '+FloatToStrF(bnd2[k].val,ffGeneral,6,3));
end;

procedure TfmPreprocessor.BitBtn5Click(Sender: TObject);
begin
  nam:='X min';
  Edit53.Text:='1';
  Edit54.Text:='1';
  Edit55.Text:='1';
  Edit56.Text:='-1';
  Edit57.Text:='1';
  Edit58.Text:='-1';
end;

procedure TfmPreprocessor.BitBtn6Click(Sender: TObject);
begin
  nam:='X max';
  Edit53.Text:='-1';
  Edit54.Text:='-1';
  Edit55.Text:='1';
  Edit56.Text:='-1';
  Edit57.Text:='1';
  Edit58.Text:='-1';
end;

procedure TfmPreprocessor.BitBtn7Click(Sender: TObject);
begin
  nam:='Y min';
  Edit53.Text:='1';
  Edit54.Text:='-1';
  Edit55.Text:='1';
  Edit56.Text:='1';
  Edit57.Text:='1';
  Edit58.Text:='-1';
end;

procedure TfmPreprocessor.BitBtn8Click(Sender: TObject);
begin
  nam:='Y max';
  Edit53.Text:='1';
  Edit54.Text:='-1';
  Edit55.Text:='-1';
  Edit56.Text:='-1';
  Edit57.Text:='1';
  Edit58.Text:='-1';
end;

procedure TfmPreprocessor.BitBtn9Click(Sender: TObject);
begin
  nam:='Z min';
  Edit53.Text:='1';
  Edit54.Text:='-1';
  Edit55.Text:='1';
  Edit56.Text:='-1';
  Edit57.Text:='1';
  Edit58.Text:='1';
end;

procedure TfmPreprocessor.BitBtn10Click(Sender: TObject);
begin
  nam:='Z max';
  Edit53.Text:='1';
  Edit54.Text:='-1';
  Edit55.Text:='1';
  Edit56.Text:='-1';
  Edit57.Text:='-1';
  Edit58.Text:='-1';
end;

procedure TfmPreprocessor.Edit53KeyPress(Sender: TObject; var Key: Char);
begin
  nam:='';
end;

procedure TfmPreprocessor.Button12Click(Sender: TObject);
begin
  bnd3:=nil;
  Nbnd3:=0;
  ListBox4.Items.Clear;
end;

procedure TfmPreprocessor.Button10Click(Sender: TObject);
var bb:TBound3;
begin
  if nam='' then
    nam:='SimpleBound';
  bb.nm:=nam+'('+ComboBox6.Text+') - '+Edit51.Text;
  bb.dir:=ComboBox6.ItemIndex;
  bb.x1:=StrToInt(Edit53.Text);
  bb.x2:=StrToInt(Edit54.Text);
  bb.y1:=StrToInt(Edit55.Text);
  bb.y2:=StrToInt(Edit56.Text);
  bb.z1:=StrToInt(Edit57.Text);
  bb.z2:=StrToInt(Edit58.Text);
  bb.val:=StrToFloat(Edit51.Text);
  bb.vl_im:=StrToFloat(Edit52.Text);
  ListBox4.Items.Add(bb.nm);
  nBnd3:=ListBox4.Items.Count;
  SetLength(bnd3,Nbnd3);
  bnd3[Nbnd3-1]:=bb;
end;

procedure TfmPreprocessor.Button11Click(Sender: TObject);
var i,k:int;
begin
  if ListBox4.ItemIndex>=0 then
  begin
    k:=ListBox4.ItemIndex;
    ListBox4.Items.Delete(k);
    for i:=k+1 to ListBox4.Items.Count-1 do
      bnd3[i-1]:=bnd3[i];
    nBnd3:=ListBox4.Items.Count;
    SetLength(bnd3,Nbnd3);
  end;
end;

procedure TfmPreprocessor.ListBox4Click(Sender: TObject);
var k:int;
begin
  k:=ListBox4.ItemIndex;
  if k<0 then exit;
  nam:=bnd3[k].nm;
  Edit53.Text:=IntToStr(bnd3[k].x1);
  Edit54.Text:=IntToStr(bnd3[k].x2);
  Edit55.Text:=IntToStr(bnd3[k].y1);
  Edit56.Text:=IntToStr(bnd3[k].y2);
  Edit57.Text:=IntToStr(bnd3[k].z1);
  Edit58.Text:=IntToStr(bnd3[k].z2);
  ComboBox6.ItemIndex:=bnd3[k].dir;
  Edit51.Text:=FloatToStrF(bnd3[k].val,ffGeneral,5,1);
  Edit52.Text:=FloatToStrF(bnd3[k].vl_im,ffGeneral,5,1);
end;

procedure TfmPreprocessor.TabSheet5Show(Sender: TObject);
var k:int;
begin
  ListBox4.Items.Clear;
  for k:=0 to Nbnd3-1 do
    ListBox4.Items.Add(bnd3[k].nm);
end;

procedure TfmPreprocessor.sg1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow=(sg1.RowCount-1) then sg1.RowCount:=sg1.RowCount+1;
end;

procedure TfmPreprocessor.TabSheet4Show(Sender: TObject);
var i,k:int;
    mem:double;
    nn:int;
begin
  if axa.mesh_s=0 then k:=1 else k:=1000;
  seDD.Items.Clear;
  seDD.Items.Add('-1 - None');
  for i:=1 to mt.nMaterials do
    seDD.Items.Add(IntToStr(i-1)+' - '+mt.mmName[i-1]);
  seDD.ItemIndex:=axa.defMat+1;
  ComboBox7.ItemIndex:=axa.mesh_s;
  ComboBox7Change(Self);
  ComboBox8.ItemIndex:=axa.angle-1;
  SpinEdit1.Value:=axa.adpt;
  Edit59.Text:=FloatToStrF(axa.ax*1e3,ffGeneral,6,3);
  Edit60.Text:=FloatToStrF(axa.ay*k,ffGeneral,6,3);
  Edit61.Text:=FloatToStrF(axa.az*1e3,ffGeneral,6,3);
  sg1.RowCount:=2+max(max(axa.nd1,axa.nd2),axa.nd3);
  for i:=1 to axa.nd1 do
  begin
    sg1.Cells[1,i]:=IntToStr(axa.disc_1[i].num);
    sg1.Cells[2,i]:=FloatToStrF(axa.disc_1[i].val*1e3,ffGeneral,6,3);
  end;
  for i:=1 to axa.nd2 do
  begin
    sg1.Cells[3,i]:=IntToStr(axa.disc_2[i].num);
    sg1.Cells[4,i]:=FloatToStrF(axa.disc_2[i].val*k,ffGeneral,6,3);
  end;
  for i:=1 to axa.nd3 do
  begin
    sg1.Cells[5,i]:=IntToStr(axa.disc_3[i].num);
    sg1.Cells[6,i]:=FloatToStrF(axa.disc_3[i].val*1e3,ffGeneral,6,3);
  end;
  /////////////////
  Label48.Caption:=FloatToStrF(axa.bx*1e3,ffGeneral,6,3);
  Label49.Caption:=FloatToStrF(axa.by*k,ffGeneral,6,3);
  Label50.Caption:=FloatToStrF(axa.bz*1e3,ffGeneral,6,3);
  Label54.Caption:=IntToStr(axa.nnx);
  Label55.Caption:=IntToStr(axa.nny);
  Label56.Caption:=IntToStr(axa.nnz);
  with axa do
  begin
    Label60.Caption:=IntToStr(NPoints);
    Label59.Caption:=IntToStr(NElements);
  end;
  nn:=0;
  Case Task of
    0..2:nn:=1;
    3:nn:=3;
    5:nn:=6;
  end;
  mem:=1.1*(NElements*(5+4)*SizeOf(int)+NPoints*60*(nn+1)*SizeOf(float))/sqr(1024);
  Label67.Caption:=FloatToStrF(mem,ffFixed,6,2);
end;

procedure TfmPreprocessor.TabSheet4Exit(Sender: TObject);
var i,k:int;
    nn,k1,k2,k3:int;
    mem:double;
begin
  axa.mesh_s:=ComboBox7.ItemIndex;
  if axa.mesh_s=0 then k:=1 else k:=1000;
  axa.defmat:=seDD.ItemIndex-1;
  axa.angle:=ComboBox8.ItemIndex+1;
  axa.adpt:=SpinEdit1.Value;
  axa.ax:=StrToFloat(Edit59.Text)/1000;
  axa.ay:=StrToFloat(Edit60.Text)/k;
  axa.az:=StrToFloat(Edit61.Text)/1000;
  nn:=sg1.RowCount-1;
  k1:=0;k2:=0;k3:=0;
  for i:=1 to nn do if (sg1.Cells[1,i]='')or(sg1.Cells[2,i]='') then begin k1:=i-1; break end;
  for i:=1 to nn do if (sg1.Cells[3,i]='')or(sg1.Cells[4,i]='') then begin k2:=i-1; break end;
  for i:=1 to nn do if (sg1.Cells[5,i]='')or(sg1.Cells[6,i]='') then begin k3:=i-1; break end;
  axa.nd1:=k1;
  axa.nd2:=k2;
  axa.nd3:=k3;
  axa.disc_1:=nil;
  axa.disc_2:=nil;
  axa.disc_3:=nil;
  SetLength(axa.disc_1,k1+1);
  SetLength(axa.disc_2,k2+1);
  SetLength(axa.disc_3,k3+1);
  for i:=1 to k1 do
  begin
    axa.disc_1[i].num:=StrToInt(sg1.Cells[1,i]);
    axa.disc_1[i].val:=StrToFloat(sg1.Cells[2,i])/1000;
  end;
  for i:=1 to k2 do
  begin
    axa.disc_2[i].num:=StrToInt(sg1.Cells[3,i]);
    axa.disc_2[i].val:=StrToFloat(sg1.Cells[4,i])/k;
  end;
  for i:=1 to k3 do
  begin
    axa.disc_3[i].num:=StrToInt(sg1.Cells[5,i]);
    axa.disc_3[i].val:=StrToFloat(sg1.Cells[6,i])/1000;
  end;
  axa.PrepareData();
  /////////////////
  Label48.Caption:=FloatToStrF(axa.bx*1e3,ffGeneral,6,3);
  Label49.Caption:=FloatToStrF(axa.by*k,ffGeneral,6,3);
  Label50.Caption:=FloatToStrF(axa.bz*1e3,ffGeneral,6,3);
  Label54.Caption:=IntToStr(axa.nnx);
  Label55.Caption:=IntToStr(axa.nny);
  Label56.Caption:=IntToStr(axa.nnz);
  with axa do
  begin
    Label60.Caption:=IntToStr(NPoints);
    Label59.Caption:=IntToStr(NElements);
  end;
  nn:=0;
  Case Task of
    0..2:nn:=1;
    3:nn:=3;
    5:nn:=6;
  end;
  mem:=1.1*(NElements*(5+4)*SizeOf(int)+NPoints*60*(nn+1)*SizeOf(float))/sqr(1024);
  Label67.Caption:=FloatToStrF(mem,ffFixed,6,2);
end;

procedure TfmPreprocessor.sg1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then TabSheet4Exit(Self);
end;

procedure TfmPreprocessor.Button14Click(Sender: TObject);
begin
  Edit51.Text:='0';
  Edit52.Text:='0';
  Combobox6.ItemIndex:=1;
  BitBtn5Click(Self); Button10Click(Self);
  BitBtn6Click(Self); Button10Click(Self);
  BitBtn7Click(Self); Button10Click(Self);
  BitBtn9Click(Self); Button10Click(Self);
  BitBtn10Click(Self); Button10Click(Self);
  Combobox6.ItemIndex:=2;
  BitBtn5Click(Self); Button10Click(Self);
  BitBtn6Click(Self); Button10Click(Self);
  BitBtn8Click(Self); Button10Click(Self);
  BitBtn9Click(Self); Button10Click(Self);
  BitBtn10Click(Self); Button10Click(Self);
  Combobox6.ItemIndex:=3;
  BitBtn5Click(Self); Button10Click(Self);
  BitBtn6Click(Self); Button10Click(Self);
  BitBtn7Click(Self); Button10Click(Self);
  BitBtn8Click(Self); Button10Click(Self);
  BitBtn9Click(Self); Button10Click(Self);
  BitBtn10Click(Self); Button10Click(Self);
end;

procedure TfmPreprocessor.TabSheet18Show(Sender: TObject);
begin
  Timer1.enabled:=true;
end;

procedure TfmPreprocessor.TabSheet18Exit(Sender: TObject);
begin
  Timer1.enabled:=false;
end;

procedure TfmPreprocessor.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Panel1.Handle, DC);
  DeleteDC(DC);
end;

procedure cl2gl(cl:TColor; var r,g,b:float);
var a1,a2,a3:int;
    cc:LongInt;
begin
  cc:=cl;
  a3:=(cc and $00FF0000)shr 16;
  a2:=(cc and $0000FF00)shr 8;
  a1:=(cc and $000000FF);
  r:=a1/256;
  g:=a2/256;
  b:=a3/256;
end;

procedure TfmPreprocessor.Timer1Timer(Sender: TObject);
begin
  InvalidateRect(Handle,nil,false);
end;

procedure TfmPreprocessor.CheckBox1Click(Sender: TObject);
begin
  ReadPage;
end;

procedure TfmPreprocessor.ud1Click(Sender: TObject; Button: TUDBtnType);
begin
  ReadPage;
  WritePage;
end;

procedure TfmPreprocessor.Button15Click(Sender: TObject);
begin
  ud1.Position:=0;
  ud1Click(self,btPrev);
  angleX:=300;
  angleY:=0;
  angleZ:=30;
  InvalidateRect(Handle,nil,false);
end;

procedure TfmPreprocessor.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down:=true;
  LastX:=X;
  LastY:=Y;
  btn:=Button;
end;

procedure TfmPreprocessor.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if down then
  begin
    if btn=mbLeft then
    begin
      if angleX<360 then angleX:=angleX+360*(Y-LastY)/Panel1.ClientHeight else angleX:=0;
      if angleZ<360 then angleZ:=angleZ+360*(X-LastX)/Panel1.ClientWidth else angleZ:=0;
      LastX:=X;
      LastY:=Y;
    end
    else
    begin
      transX:=transX+4*(X-LastX)/Panel1.ClientWidth;
      transY:=transY+4*(Y-LastY)/Panel1.ClientHeight;
      LastX:=X;
      LastY:=Y;
    end;
    InvalidateRect(Handle,nil,false);
  end;
end;

procedure TfmPreprocessor.Panel1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Down:=false;
end;

procedure TfmPreprocessor.Button13Click(Sender: TObject);
begin
  transX:=0;
  transY:=0;
end;

procedure TfmPreprocessor.SpeedButton1Click(Sender: TObject);
begin
  if (angleX=90)and(angleY=0)and(angleZ=270) then
  begin
    AngleX:=270;
    AngleY:=0;
    AngleZ:=270;
  end
  else
  begin
    AngleX:=90;
    AngleY:=0;
    AngleZ:=270;
  end;
end;

procedure TfmPreprocessor.SpeedButton2Click(Sender: TObject);
begin
  if (angleX=90)and(angleY=0)and(angleZ=180) then
  begin
    AngleX:=270;
    AngleY:=0;
    AngleZ:=180;
  end
  else
  begin
    AngleX:=90;
    AngleY:=0;
    AngleZ:=180;
  end;
end;

procedure TfmPreprocessor.SpeedButton3Click(Sender: TObject);
begin
  if (angleX=0)and(angleY=0)and(angleZ=0) then
  begin
    AngleX:=180;
    AngleY:=0;
    AngleZ:=0;
  end
  else
  begin
    AngleX:=0;
    AngleY:=0;
    AngleZ:=0;
  end;
end;

procedure TfmPreprocessor.Button16Click(Sender: TObject);
var k:int;
    x1,x2,y1,y2,z1,z2,x3,z3:float;
    x,y,z,r1,r2,al,bt,h:float;
    ss:st1;
begin
  k:=ListBox3.ItemIndex;
  if k<0 then exit;
  Case PageControl2.ActivePageIndex of
    0:begin // Block
        x1:=StrToFloat(Edit13.Text)/1000;
        y1:=StrToFloat(Edit14.Text)/1000;
        z1:=StrToFloat(Edit15.Text)/1000;
        x2:=StrToFloat(Edit16.Text)/1000;
        y2:=StrToFloat(Edit17.Text)/1000;
        z2:=StrToFloat(Edit18.Text)/1000;
        Case PageControl3.ActivePageIndex of
        0:begin // current
            TBlock(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TBlock(ob.Items[k]).Name:=Edit47.Text;
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(StrToFloat(Edit31.Text)*1e6,
                                         StrToFloat(Edit32.Text)*1e6,
                                         StrToFloat(Edit33.Text)*1e6,
                                         StrToFloat(Edit34.Text),3);
          end;
        1:begin // magnet
            TBlock(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TBlock(ob.Items[k]).Name:=Edit47.Text;
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(StrToFloat(Edit48.Text),
                                         StrToFloat(Edit49.Text),
                                         StrToFloat(Edit50.Text),
                                         0.0,2);
          end;
        2:begin // charge
            TBlock(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TBlock(ob.Items[k]).Name:=Edit47.Text;
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(StrToFloat(Edit35.Text),
                                         0.0, 0.0, 0.0,1);
          end;
        else begin // none
            TBlock(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TBlock(ob.Items[k]).Name:=Edit47.Text;
            TBlock(ob.Items[k]).SetData(x1,y1,z1,x2,y2,z2);
            TBlock(ob.Items[k]).DataLoad(0, 0, 0, 0,0);
          end;
        end;
      end;
    1:begin // sector
        x:=StrToFloat(Edit19.Text)/1000;
        y:=StrToFloat(Edit20.Text)/1000;
        z:=StrToFloat(Edit21.Text)/1000;
        r1:=StrToFloat(Edit22.Text)/1000;
        r2:=StrToFloat(Edit23.Text)/1000;
        h:=StrToFloat(Edit26.Text)/1000;
        al:=StrToFloat(Edit27.Text);
        bt:=StrToFloat(Edit30.Text);
        ss:=ComboBox5.Text;
        Case PageControl4.ActivePageIndex of
        0:begin // current
            TSector(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TSector(ob.Items[k]).Name:=Edit47.Text;
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(StrToFloat(Edit37.Text)*1e6,
                                          StrToFloat(Edit38.Text)*1e6,
                                          StrToFloat(Edit39.Text)*1e6,
                                          StrToFloat(Edit40.Text),3);
          end;
        1:begin // magnet
            TSector(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TSector(ob.Items[k]).Name:=Edit47.Text;
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(StrToFloat(Edit44.Text),
                                          StrToFloat(Edit45.Text),
                                          StrToFloat(Edit46.Text),
                                          0.0,2);
          end;
        2:begin // charge
            TSector(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TSector(ob.Items[k]).Name:=Edit47.Text;
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(StrToFloat(Edit36.Text),
                                          0,0,0,1);
          end;
        else begin // none
            TSector(ob.Items[k]).iMaterial:=seMat.ItemIndex;
            TSector(ob.Items[k]).Name:=Edit47.Text;
            TSector(ob.Items[k]).SetData(x,y,z,r1,r2,al,bt,h,ss);
            TSector(ob.Items[k]).DataLoad(0,0,0,0,0);
          end;
        end;
      end;
    2:begin // Triangle block
        x1:=StrToFloat(Edit71.Text)/1000;
        x2:=StrToFloat(Edit72.Text)/1000;
        x3:=StrToFloat(Edit73.Text)/1000;
        z1:=StrToFloat(Edit74.Text)/1000;
        z2:=StrToFloat(Edit75.Text)/1000;
        z3:=StrToFloat(Edit76.Text)/1000;
        y1:=StrToFloat(Edit77.Text)/1000;
        y2:=StrToFloat(Edit78.Text)/1000;
        ss:=ComboBox5.Text;
        //ob.Add(TTriBlock.Create(seMat.ItemIndex,Edit47.Text));
        TTriBlock(ob.Items[k]).iMaterial:=seMat.ItemIndex;
        TTriBlock(ob.Items[k]).Name:=Edit47.Text;
        TTriBlock(ob.Items[k]).SetData(x1,z1,x2,z2,x3,z3,y1,y2);
        TTriBlock(ob.Items[k]).DataLoad(0,0,0,0,0);
      end;
    3:begin // Triangle sector
        x1:=StrToFloat(Edit79.Text)/1000;
        x2:=StrToFloat(Edit80.Text)/1000;
        x3:=StrToFloat(Edit81.Text)/1000;
        z1:=StrToFloat(Edit82.Text)/1000;
        z2:=StrToFloat(Edit83.Text)/1000;
        z3:=StrToFloat(Edit84.Text)/1000;
        al:=StrToFloat(Edit85.Text);
        bt:=StrToFloat(Edit86.Text);
        ss:=ComboBox5.Text;
        //ob.Add(TTriSec.Create(seMat.ItemIndex,Edit47.Text));
        TTriSec(ob.Items[k]).iMaterial:=seMat.ItemIndex;
        TTriSec(ob.Items[k]).Name:=Edit47.Text;
        TTriSec(ob.Items[k]).SetData(x1,z1,x2,z2,x3,z3,al,bt);
        TTriSec(ob.Items[k]).DataLoad(0,0,0,0,0);
      end;
  end;
end;

procedure TfmPreprocessor.ComboBox7Change(Sender: TObject);
begin
  if ComboBox7.ItemIndex=0 then
  begin
    label42.Caption:='R0';
    label45.Caption:='R1=';
    label43.Caption:='Fi0';
    label46.Caption:='Fi1=';
    with sg1 do
    begin
      Cells[1,0]:='R : num';
      Cells[2,0]:='R : val';
      Cells[3,0]:='Fi : num';
      Cells[4,0]:='Fi : val';
      Cells[5,0]:='Z : num';
      Cells[6,0]:='Z : val';
    end;
  end
  else
  begin
    label42.Caption:='X0';
    label45.Caption:='X1=';
    label43.Caption:='Y0';
    label46.Caption:='Y1=';
    with sg1 do
    begin
      Cells[1,0]:='X : num';
      Cells[2,0]:='X : val';
      Cells[3,0]:='Y : num';
      Cells[4,0]:='Y : val';
      Cells[5,0]:='Z : num';
      Cells[6,0]:='Z : val';
    end;
  end;
end;

procedure TfmPreprocessor.FormPaint(Sender: TObject);
var i:int;
    mgo:TMGObject;
    blc:TBlock;
    sec:TSector;
    tts:TTriSec;
    ttb:TTriBlock;
    im:int;
    cl:TColor;
    r,g,b:float;
begin
  wglMakeCurrent(fmPreprocessor.DC, fmPreprocessor.hrc);
  glViewport(0, 0, Panel1.ClientWidth, Panel1.ClientHeight);
  glMatrixMode (GL_PROJECTION);
  glLoadIdentity;
  glMatrixMode (GL_MODELVIEW);
  glLoadIdentity;
  glOrtho(-2, 2, -2, 2, -2, 50);
  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
  glTranslatef(0.0, 0.0, -10.0);
  glTranslatef(transX,-transY,0);
  glRotatef(angleX,1,0,0);
  glRotatef(angleY,0,1,0);
  glRotatef(angleZ,0,0,1);
  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glScalef(pr_zoom,pr_zoom,pr_zoom);
  /////////////
  // axis
  if bAxis then
  begin
    glColor3f(0,0,0);
    glBegin(GL_lines);
      glVertex3f(0.0,0.0,0.0);
      glVertex3f(1.1,0.0,0.0);
      glVertex3f(0.0,0.0,0.0);
      glVertex3f(0.0,1.1,0.0);
      glVertex3f(0.0,0.0,0.0);
      glVertex3f(0.0,0.0,1.1);
    glEnd;
    // axis names
    glRasterPos3f(1.1,0,0);
    printString('X');
    glRasterPos3f(0,1.1,0);
    printString('Y');
    glRasterPos3f(0,0,1.1);
    printString('Z');
  end;
  // objects
  if bObjects then
  begin
    for i:=0 to ob.Count-1 do
    begin
      mgo:=TMGObject(ob.Items[i]);
      im:=mgo.GetMaterial;
      cl:=mt.mmColor[im];
      cl2gl(cl,r,g,b);
      glColor3f(r,g,b);
      if mgo is TBlock then
      begin
        blc:=TBlock(mgo);
        oglWireBlock(blc);
      end
      else if mgo is TSector then
      begin
        sec:=TSector(mgo);
        oglWireSector(sec);
      end
      else if mgo is TTriBlock then
      begin
        ttb:=TTriBlock(mgo);
        oglWireTriBlock(ttb);
      end
      else if mgo is TTriSec then
      begin
        tts:=TTriSec(mgo);
        oglWireTriSec(tts);
      end;
    end;
  end;
  // Bound 3d
  if bBound3 then
  begin
    glColor3f(0,0,0.7);
    oglBound3D;
  end;
  // Bound 2d
  if bBound2 then
  begin
    glColor3f(0,0.7,0);
    glLineStipple(1,$FFF0);
    glEnable(GL_LINE_STIPPLE);
    glBegin(GL_LINE_LOOP);
      glVertex3f(glX(tt.ax),0.0,glX(tt.az));
      glVertex3f(glX(tt.bx),0.0,glX(tt.az));
      glVertex3f(glX(tt.bx),0.0,glX(tt.bz));
      glVertex3f(glX(tt.ax),0.0,glX(tt.bz));
    glEnd;
    glDisable(GL_LINE_STIPPLE);
  end;
  // restore previous settings
  glScalef(1/pr_zoom,1/pr_zoom,1/pr_zoom);
  glRotatef(angleX,-1,0,0);
  glRotatef(angleY,0,-1,0);
  glRotatef(angleZ,0,0,-1);
  glTranslatef(-transX,transY,0);
  glTranslatef(0.0, 0.0, 10.0);
  SwapBuffers(DC);
end;

procedure TfmPreprocessor.TabSheet3Exit(Sender: TObject);
begin
  ///////////////////////
  // Parameters
  ps.wError2d:=StrToFloat(Edit63.Text);
  ps.wMIter2d:=StrToInt(Edit64.Text);
  ps.wSMeth2d:=ComboBox10.ItemIndex;
  //
  ps.wError3d:=StrToFloat(Edit65.Text);
  ps.wMIter3d:=StrToInt(Edit66.Text);
  ps.wSMeth3d:=ComboBox11.ItemIndex;
  //
  ps.wError_d:=StrToFloat(Edit67.Text);
  ps.wMIter_d:=StrToInt(Edit68.Text);
  ps.wSMeth_d:=ComboBox12.ItemIndex;
  //
  ps.wError_n:=StrToFloat(Edit69.Text);
  ps.wMIter_n:=StrToInt(Edit70.Text);
  ps.wSMeth_n:=ComboBox13.ItemIndex;
  ///////////////////////
end;

procedure TfmPreprocessor.SpeedButton4Click(Sender: TObject);
begin
  if odlg1.Execute then
  begin
    Edit62.Text:=odlg1.FileName;
  end;
end;

procedure TfmPreprocessor.SpeedButton5Click(Sender: TObject);
begin
  if oDlg2.Execute then
  begin
    axa.ad_type:=1;
    adoptedM3:=TAdoptMesh3d.Create();
    adoptedM3.LoadFromFile(oDlg2.FileName);
    adoptedM3.GenerateTop3();
  end;
end;

procedure TfmPreprocessor.SpeedButton6Click(Sender: TObject);
begin
  if oDlg2.Execute then
  begin
    adoptedM2:=TAdoptMesh2d.Create();
    adoptedM2.LoadFromFile(oDlg2.FileName);
    adoptedM2.GenerateTop2();
  end;
end;

procedure TfmPreprocessor.SpeedButton7Click(Sender: TObject);
begin
  if oDlg2.Execute then
  begin
    axa.ad_type:=2;
    adm3:=TAdoMesh3d.Create();
    adm3.LoadFromFile(oDlg2.FileName);
    adm3.GenerateTop3();
  end;
end;

procedure TfmPreprocessor.CheckBox5Click(Sender: TObject);
begin
  umEnable:=CheckBox5.Checked;
end;

procedure TfmPreprocessor.SpeedButton8Click(Sender: TObject);
begin
  if oDlg2.Execute then
  begin
    um:=TUniMesh.Create;
    um.LoadData(oDlg2.FileName);
    um.GenerateUniMesh;
    Label12.Caption:=IntTostr(um.nPts);
    Label13.Caption:=IntTostr(um.nEls);
  end;
end;

procedure TfmPreprocessor.Button17Click(Sender: TObject);
begin
  Edit51.Text:='0';
  Edit52.Text:='0';
  Combobox6.ItemIndex:=1;
  BitBtn5Click(Self); Button10Click(Self);
  BitBtn6Click(Self); Button10Click(Self);
  BitBtn7Click(Self); Button10Click(Self);
  BitBtn8Click(Self); Button10Click(Self);
  BitBtn9Click(Self); Button10Click(Self);
  BitBtn10Click(Self); Button10Click(Self);
  Combobox6.ItemIndex:=2;
  BitBtn5Click(Self); Button10Click(Self);
  BitBtn6Click(Self); Button10Click(Self);
  BitBtn7Click(Self); Button10Click(Self);
  BitBtn8Click(Self); Button10Click(Self);
  BitBtn9Click(Self); Button10Click(Self);
  BitBtn10Click(Self); Button10Click(Self);
  Combobox6.ItemIndex:=3;
  BitBtn5Click(Self); Button10Click(Self);
  BitBtn6Click(Self); Button10Click(Self);
  BitBtn7Click(Self); Button10Click(Self);
  BitBtn8Click(Self); Button10Click(Self);
  BitBtn9Click(Self); Button10Click(Self);
  BitBtn10Click(Self); Button10Click(Self);
end;

end.

