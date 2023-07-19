object fmPWD: TfmPWD
  Left = 192
  Top = 107
  ActiveControl = ComboBox1
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Authorization'
  ClientHeight = 124
  ClientWidth = 195
  Color = clBtnFace
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
    Width = 193
    Height = 89
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 20
      Width = 22
      Height = 13
      Caption = 'Role'
    end
    object Label2: TLabel
      Left = 8
      Top = 52
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object ComboBox1: TComboBox
      Left = 64
      Top = 16
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 0
      Text = 'USER'
      Items.Strings = (
        'Administrator'
        'Advanced User'
        'USER'
        'Guest')
    end
    object Edit1: TEdit
      Left = 64
      Top = 48
      Width = 113
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 24
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
