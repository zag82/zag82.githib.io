object fmControlM: TfmControlM
  Left = 152
  Top = 143
  Width = 544
  Height = 375
  Caption = 'Magnetic Control'
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
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 275
    Height = 31
    Caption = 'Form still not available'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 232
    Top = 72
    Width = 26
    Height = 13
    Caption = 'Liftoff'
  end
  object Label3: TLabel
    Left = 392
    Top = 72
    Width = 16
    Height = 13
    Caption = 'mm'
  end
  object Button1: TButton
    Left = 32
    Top = 64
    Width = 113
    Height = 41
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 264
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '2.5'
  end
  object CheckBox1: TCheckBox
    Left = 232
    Top = 96
    Width = 97
    Height = 17
    Caption = 'External'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 232
    Top = 112
    Width = 57
    Height = 17
    Caption = 'minus'
    TabOrder = 3
  end
end
