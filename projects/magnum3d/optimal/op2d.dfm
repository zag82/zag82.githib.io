object fmOp2d: TfmOp2d
  Left = 192
  Top = 128
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'ECT flaw profile reconstruction'
  ClientHeight = 392
  ClientWidth = 808
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbb: TGroupBox
    Left = 176
    Top = 280
    Width = 169
    Height = 105
    Caption = 'Control'
    TabOrder = 3
    object Button1: TButton
      Left = 24
      Top = 24
      Width = 121
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
    object Button2: TButton
      Left = 24
      Top = 64
      Width = 121
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 161
    Height = 377
    Caption = 'Initial Profile'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 30
      Height = 13
      Caption = 'Z step'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 30
      Height = 13
      Caption = 'R max'
    end
    object Label3: TLabel
      Left = 16
      Top = 80
      Width = 29
      Height = 13
      Caption = 'Profile'
    end
    object Label9: TLabel
      Left = 136
      Top = 32
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Label10: TLabel
      Left = 136
      Top = 56
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Edit1: TEdit
      Left = 56
      Top = 24
      Width = 73
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object Edit2: TEdit
      Left = 56
      Top = 48
      Width = 73
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object sg: TStringGrid
      Left = 16
      Top = 96
      Width = 129
      Height = 273
      ColCount = 1
      DefaultColWidth = 96
      FixedCols = 0
      RowCount = 10
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 176
    Top = 8
    Width = 169
    Height = 121
    Caption = 'Parameters'
    TabOrder = 1
    object Label4: TLabel
      Left = 16
      Top = 32
      Width = 50
      Height = 13
      Caption = 'Max depth'
    end
    object Label5: TLabel
      Left = 16
      Top = 56
      Width = 22
      Height = 13
      Caption = 'Step'
    end
    object Label6: TLabel
      Left = 16
      Top = 96
      Width = 22
      Height = 13
      Caption = 'Error'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 80
      Width = 145
      Height = 9
      Shape = bsTopLine
    end
    object Label11: TLabel
      Left = 144
      Top = 32
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Label12: TLabel
      Left = 144
      Top = 56
      Width = 16
      Height = 13
      Caption = 'mm'
    end
    object Edit3: TEdit
      Left = 72
      Top = 24
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '1.5'
    end
    object Edit4: TEdit
      Left = 72
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '0.15'
    end
    object Edit5: TEdit
      Left = 56
      Top = 88
      Width = 89
      Height = 21
      TabOrder = 2
      Text = '0.001'
    end
  end
  object GroupBox3: TGroupBox
    Left = 176
    Top = 136
    Width = 169
    Height = 145
    Caption = 'Godographs'
    TabOrder = 2
    object Label7: TLabel
      Left = 16
      Top = 24
      Width = 78
      Height = 13
      Caption = 'Initial godograph'
    end
    object Label8: TLabel
      Left = 16
      Top = 72
      Width = 64
      Height = 13
      Caption = 'Current signal'
    end
    object SpeedButton1: TSpeedButton
      Left = 136
      Top = 40
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 136
      Top = 88
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton2Click
    end
    object Edit6: TEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object Edit7: TEdit
      Left = 16
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object se: TSpinEdit
      Left = 96
      Top = 112
      Width = 65
      Height = 22
      EditorEnabled = False
      Increment = 50
      MaxValue = 500
      MinValue = 50
      TabOrder = 2
      Value = 100
    end
  end
  object PageControl1: TPageControl
    Left = 352
    Top = 8
    Width = 449
    Height = 377
    ActivePage = TabSheet1
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'Profile'
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 441
        Height = 349
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.ExactDateTime = False
        LeftAxis.Increment = 0.200000000000000000
        LeftAxis.Maximum = 2.500000000000000000
        Legend.Visible = False
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Series2: TAreaSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = 33023
          AreaLinesPen.Visible = False
          DrawArea = True
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
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = 16384
          LinePen.Width = 2
          Pointer.Brush.Color = 16384
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
          Pointer.Style = psDiamond
          Pointer.VertSize = 3
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
    object TabSheet2: TTabSheet
      Caption = 'Results'
      ImageIndex = 1
      object Label21: TLabel
        Left = 224
        Top = 8
        Width = 59
        Height = 13
        Caption = 'Flaw Profiles'
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 8
        Width = 201
        Height = 137
        Caption = 'Errors'
        TabOrder = 0
        object Label13: TLabel
          Left = 112
          Top = 24
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label14: TLabel
          Left = 136
          Top = 64
          Width = 15
          Height = 13
          Caption = '0.0'
        end
        object Label15: TLabel
          Left = 104
          Top = 88
          Width = 15
          Height = 13
          Caption = '0.0'
        end
        object Label16: TLabel
          Left = 16
          Top = 24
          Width = 84
          Height = 13
          Caption = 'Iteration Number :'
        end
        object Label17: TLabel
          Left = 16
          Top = 64
          Width = 109
          Height = 13
          Caption = 'Godograph difference :'
        end
        object Label18: TLabel
          Left = 16
          Top = 88
          Width = 84
          Height = 13
          Caption = 'Simplex Error (%) :'
        end
        object Label19: TLabel
          Left = 16
          Top = 112
          Width = 79
          Height = 13
          Caption = 'Shape Error (%) :'
        end
        object Label20: TLabel
          Left = 104
          Top = 112
          Width = 15
          Height = 13
          Caption = '0.0'
        end
        object Bevel2: TBevel
          Left = 16
          Top = 48
          Width = 169
          Height = 9
          Shape = bsTopLine
        end
      end
      object sgg: TStringGrid
        Left = 216
        Top = 24
        Width = 225
        Height = 281
        ColCount = 3
        RowCount = 10
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 1
      end
      object Button3: TButton
        Left = 128
        Top = 160
        Width = 75
        Height = 25
        Caption = 'Update'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 128
        Top = 232
        Width = 75
        Height = 25
        Caption = 'Save Chart'
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 128
        Top = 200
        Width = 75
        Height = 25
        Caption = 'Load profile'
        TabOrder = 4
        OnClick = Button5Click
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 160
        Width = 57
        Height = 17
        Caption = 'Stairs'
        TabOrder = 5
        OnClick = CheckBox1Click
      end
      object Button6: TButton
        Left = 48
        Top = 288
        Width = 75
        Height = 25
        Caption = 'Load result'
        TabOrder = 6
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 128
        Top = 288
        Width = 75
        Height = 25
        Caption = 'Save result'
        TabOrder = 7
        OnClick = Button7Click
      end
    end
  end
  object ComboBox1: TComboBox
    Left = 192
    Top = 248
    Width = 65
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Linear'
    Items.Strings = (
      'Linear'
      'Stairs')
  end
  object oDlg: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 508
    Top = 8
  end
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 540
    Top = 8
  end
  object oDlg2: TOpenDialog
    DefaultExt = 'dat'
    Filter = 'Profiles|*.dat|All Files|*.*'
    Left = 516
    Top = 48
  end
  object sDlg2: TSavePictureDialog
    DefaultExt = 'bmp'
    Left = 548
    Top = 48
  end
  object oDlg3: TOpenDialog
    DefaultExt = 'dat'
    Filter = 'Profiles|*.dat|All Files|*.*'
    Left = 516
    Top = 88
  end
  object sDlg3: TSaveDialog
    DefaultExt = 'dat'
    Filter = 'Profiles|*.dat|All Files|*.*'
    Left = 548
    Top = 88
  end
end
