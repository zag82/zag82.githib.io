object fmOptim: TfmOptim
  Left = 192
  Top = 114
  BorderStyle = bsSingle
  Caption = 'Optimization on Depth and Height'
  ClientHeight = 232
  ClientWidth = 561
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
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 368
    Top = 8
    Width = 169
    Height = 81
    Caption = 'Results'
    TabOrder = 2
    object Label13: TLabel
      Left = 16
      Top = 28
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object Label14: TLabel
      Left = 16
      Top = 52
      Width = 29
      Height = 13
      Caption = 'Depth'
    end
    object Label15: TLabel
      Left = 136
      Top = 28
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Label16: TLabel
      Left = 136
      Top = 52
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Edit8: TEdit
      Left = 56
      Top = 24
      Width = 73
      Height = 21
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object Edit9: TEdit
      Left = 56
      Top = 48
      Width = 73
      Height = 21
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 185
    Caption = 'Initial Data'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 28
      Height = 13
      Caption = 'Width'
    end
    object Label2: TLabel
      Left = 16
      Top = 52
      Width = 29
      Height = 13
      Caption = 'Depth'
    end
    object Label3: TLabel
      Left = 16
      Top = 92
      Width = 61
      Height = 13
      Caption = 'Step in width'
    end
    object Label4: TLabel
      Left = 16
      Top = 116
      Width = 63
      Height = 13
      Caption = 'Step in depth'
    end
    object Label5: TLabel
      Left = 16
      Top = 156
      Width = 80
      Height = 13
      Caption = 'Outer pipe radius'
    end
    object Label6: TLabel
      Left = 120
      Top = 28
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Label7: TLabel
      Left = 120
      Top = 52
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Label8: TLabel
      Left = 136
      Top = 92
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Label9: TLabel
      Left = 136
      Top = 116
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Label10: TLabel
      Left = 152
      Top = 156
      Width = 16
      Height = 13
      Caption = 'mm'
      Color = clLime
      ParentColor = False
    end
    object Bevel1: TBevel
      Left = 16
      Top = 80
      Width = 161
      Height = 9
      Shape = bsTopLine
    end
    object Bevel2: TBevel
      Left = 16
      Top = 144
      Width = 161
      Height = 9
      Shape = bsTopLine
    end
    object Edit1: TEdit
      Left = 64
      Top = 24
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object Edit2: TEdit
      Left = 64
      Top = 48
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '0.5'
    end
    object Edit3: TEdit
      Left = 88
      Top = 88
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '0.5'
    end
    object Edit4: TEdit
      Left = 88
      Top = 112
      Width = 49
      Height = 21
      TabOrder = 3
      Text = '0.1'
    end
    object Edit5: TEdit
      Left = 104
      Top = 152
      Width = 49
      Height = 21
      TabOrder = 4
      Text = '8.5'
    end
  end
  object GroupBox2: TGroupBox
    Left = 208
    Top = 8
    Width = 153
    Height = 81
    Caption = 'Simplex parameters'
    TabOrder = 1
    object Label11: TLabel
      Left = 16
      Top = 28
      Width = 22
      Height = 13
      Caption = 'Error'
    end
    object Label12: TLabel
      Left = 16
      Top = 48
      Width = 47
      Height = 26
      Caption = 'Maximum Iterations'
      WordWrap = True
    end
    object Edit6: TEdit
      Left = 48
      Top = 24
      Width = 89
      Height = 21
      TabOrder = 0
      Text = '1E-4'
    end
    object se: TSpinEdit
      Left = 72
      Top = 52
      Width = 65
      Height = 22
      Increment = 50
      MaxValue = 500
      MinValue = 50
      TabOrder = 1
      Value = 100
    end
  end
  object Button1: TButton
    Left = 208
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Run'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 336
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 4
    OnClick = Button2Click
  end
  object GroupBox4: TGroupBox
    Left = 208
    Top = 96
    Width = 329
    Height = 97
    Caption = 'Godograph'
    TabOrder = 5
    object Label17: TLabel
      Left = 16
      Top = 32
      Width = 56
      Height = 13
      Caption = 'Initial Signal'
    end
    object Label18: TLabel
      Left = 16
      Top = 64
      Width = 66
      Height = 13
      Caption = 'Current Signal'
    end
    object SpeedButton1: TSpeedButton
      Left = 296
      Top = 24
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 296
      Top = 56
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton2Click
    end
    object Edit7: TEdit
      Left = 88
      Top = 24
      Width = 209
      Height = 21
      TabOrder = 0
    end
    object Edit10: TEdit
      Left = 88
      Top = 56
      Width = 209
      Height = 21
      TabOrder = 1
    end
  end
  object oDlg: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 160
    Top = 16
  end
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 160
    Top = 48
  end
end
