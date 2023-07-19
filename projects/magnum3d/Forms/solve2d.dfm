object fmSolver2: TfmSolver2
  Left = 268
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '2D - solver'
  ClientHeight = 312
  ClientWidth = 532
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox6: TGroupBox
    Left = 0
    Top = 136
    Width = 169
    Height = 176
    Caption = 'Iterations'
    TabOrder = 2
    object Label16: TLabel
      Left = 8
      Top = 20
      Width = 62
      Height = 13
      Caption = 'Error criterion'
    end
    object Label27: TLabel
      Left = 8
      Top = 44
      Width = 94
      Height = 13
      Caption = 'Number of iterations'
    end
    object Label28: TLabel
      Left = 8
      Top = 108
      Width = 22
      Height = 13
      Caption = 'Error'
    end
    object Label29: TLabel
      Left = 8
      Top = 84
      Width = 74
      Height = 13
      Caption = 'Current iteration'
    end
    object Bevel5: TBevel
      Left = 8
      Top = 64
      Width = 153
      Height = 9
      Shape = bsBottomLine
    end
    object eFullError: TEdit
      Left = 88
      Top = 16
      Width = 73
      Height = 21
      Color = clLime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '1E-17'
    end
    object eNumIt: TEdit
      Left = 112
      Top = 40
      Width = 49
      Height = 21
      Color = clLime
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Text = '50'
    end
    object eError: TEdit
      Left = 48
      Top = 104
      Width = 113
      Height = 21
      Color = clMenu
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object eIter: TEdit
      Left = 88
      Top = 80
      Width = 73
      Height = 21
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
    object Button11: TButton
      Left = 8
      Top = 136
      Width = 153
      Height = 25
      Caption = 'Make some iteration steps'
      Enabled = False
      TabOrder = 4
      OnClick = Button11Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 169
    Height = 137
    Caption = 'Process'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 26
      Height = 13
      Caption = 'Done'
    end
    object Gauge1: TGauge
      Left = 8
      Top = 40
      Width = 153
      Height = 25
      Progress = 0
    end
    object Label14: TLabel
      Left = 8
      Top = 76
      Width = 46
      Height = 13
      Caption = 'Task time'
    end
    object Button1: TButton
      Left = 88
      Top = 104
      Width = 73
      Height = 25
      Caption = 'Run'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object eTime: TEdit
      Left = 56
      Top = 72
      Width = 105
      Height = 21
      ReadOnly = True
      TabOrder = 1
      Text = '0:00:00'
    end
    object Button2: TButton
      Left = 8
      Top = 104
      Width = 73
      Height = 25
      Caption = 'Prepare'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Chart1: TChart
    Left = 172
    Top = 0
    Width = 360
    Height = 312
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    LeftAxis.Logarithmic = True
    Legend.Visible = False
    View3D = False
    Align = alRight
    TabOrder = 1
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
end
