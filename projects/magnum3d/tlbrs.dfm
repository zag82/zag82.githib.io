object fmToolBars: TfmToolBars
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'ToolBars'
  ClientHeight = 168
  ClientWidth = 207
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 153
    Caption = 'Toolbar visibility'
    TabOrder = 1
    object CheckBox1: TCheckBox
      Left = 16
      Top = 24
      Width = 65
      Height = 17
      Caption = 'Standard'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 48
      Width = 105
      Height = 17
      Caption = 'Magnum3d Solver'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 96
      Width = 49
      Height = 17
      Caption = 'Script'
      TabOrder = 2
      OnClick = CheckBox3Click
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 120
      Width = 41
      Height = 17
      Caption = 'Help'
      TabOrder = 3
      OnClick = CheckBox4Click
    end
    object CheckBox5: TCheckBox
      Left = 16
      Top = 72
      Width = 113
      Height = 17
      Caption = 'Results && Previews'
      TabOrder = 4
      OnClick = CheckBox5Click
    end
  end
  object Button1: TButton
    Left = 112
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
end
