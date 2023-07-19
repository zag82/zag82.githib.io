object fmParams: TfmParams
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Common system parameters'
  ClientHeight = 342
  ClientWidth = 268
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
  object GroupBox3: TGroupBox
    Left = 0
    Top = 208
    Width = 145
    Height = 129
    Caption = 'Solution automatisation'
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 24
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Auto - Start'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 24
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Auto - Close'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 24
      Top = 64
      Width = 97
      Height = 17
      Caption = 'Save Topology'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 24
      Top = 104
      Width = 97
      Height = 17
      Caption = 'Hide on control'
      TabOrder = 3
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 152
    Top = 80
    Width = 113
    Height = 185
    Caption = 'Threads priorities'
    ItemIndex = 3
    Items.Strings = (
      'Idle'
      'Lowest'
      'Lower'
      'Normal'
      'Higher'
      'Highest'
      'TimeCritical')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 176
    Top = 272
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 80
    Width = 145
    Height = 121
    Caption = 'Common parameters'
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 65
      Height = 33
      AutoSize = False
      Caption = 'Tetrahedrons in cube'
      WordWrap = True
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 85
      Height = 13
      Caption = 'Decimal separator'
    end
    object se1: TSpinEdit
      Left = 88
      Top = 35
      Width = 41
      Height = 22
      MaxValue = 6
      MinValue = 5
      TabOrder = 0
      Value = 6
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 88
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Dot'
      Items.Strings = (
        'Dot'
        'Comma')
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 265
    Height = 73
    Caption = 'Colors'
    TabOrder = 5
    object Label3: TLabel
      Left = 8
      Top = 24
      Width = 48
      Height = 13
      Caption = 'Parameter'
    end
    object Label4: TLabel
      Left = 216
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Color'
    end
    object Shape1: TShape
      Left = 208
      Top = 32
      Width = 41
      Height = 33
    end
    object ComboBox2: TComboBox
      Left = 8
      Top = 40
      Width = 193
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
end
