object fmMultiSolve: TfmMultiSolve
  Left = 232
  Top = 203
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Multi - Data solver'
  ClientHeight = 198
  ClientWidth = 403
  Color = clBtnFace
  TransparentColorValue = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 401
    Height = 161
    Caption = 'Settings'
    TabOrder = 0
    object Label1: TLabel
      Left = 104
      Top = 24
      Width = 62
      Height = 13
      Caption = 'Configuration'
    end
    object SpeedButton1: TSpeedButton
      Left = 368
      Top = 40
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Progress'
    end
    object gg: TGauge
      Left = 8
      Top = 40
      Width = 65
      Height = 65
      BorderStyle = bsNone
      Kind = gkPie
      Progress = 0
      ShowText = False
    end
    object Label3: TLabel
      Left = 104
      Top = 136
      Width = 23
      Height = 13
      Caption = 'Time'
    end
    object Label4: TLabel
      Left = 136
      Top = 136
      Width = 44
      Height = 13
      Caption = '0:00:00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 88
      Top = 16
      Width = 9
      Height = 129
      Shape = bsLeftLine
    end
    object Label5: TLabel
      Left = 224
      Top = 128
      Width = 47
      Height = 26
      Caption = 'Defected material'
      WordWrap = True
    end
    object Edit1: TEdit
      Left = 104
      Top = 40
      Width = 265
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object GroupBox2: TGroupBox
      Left = 104
      Top = 72
      Width = 289
      Height = 49
      Caption = 'ShutDown'
      TabOrder = 1
      object CheckBox1: TCheckBox
        Left = 16
        Top = 20
        Width = 177
        Height = 17
        Caption = 'ShutDown Windows when finish'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
    end
    object ComboBox1: TComboBox
      Left = 272
      Top = 128
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox1Change
    end
  end
  object Button1: TButton
    Left = 112
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Run'
    Default = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 200
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 2
    OnClick = Button2Click
  end
  object oDlg: TOpenDialog
    DefaultExt = 'mm3'
    Filter = 'Multi MagNum Files|*.mm3'
    Left = 336
    Top = 168
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 368
    Top = 168
  end
end
