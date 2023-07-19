object fmMDlg: TfmMDlg
  Left = 254
  Top = 143
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Vary data'
  ClientHeight = 360
  ClientWidth = 432
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
  object Button1: TButton
    Left = 232
    Top = 320
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 336
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 345
    Caption = 'Primary'
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 37
      Height = 13
      Caption = 'Number'
    end
    object se: TSpinEdit
      Left = 64
      Top = 24
      Width = 121
      Height = 22
      MaxValue = 1000
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = seChange
    end
    object sg: TStringGrid
      Left = 16
      Top = 56
      Width = 169
      Height = 273
      ColCount = 1
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      TabOrder = 1
      ColWidths = (
        146)
    end
  end
  object GroupBox2: TGroupBox
    Left = 216
    Top = 8
    Width = 209
    Height = 201
    Caption = 'Automatization'
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 28
      Width = 19
      Height = 13
      Caption = 'Sort'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 56
      Width = 177
      Height = 17
      Shape = bsTopLine
    end
    object Label3: TLabel
      Left = 16
      Top = 84
      Width = 24
      Height = 13
      Caption = 'Initial'
    end
    object Label4: TLabel
      Left = 16
      Top = 108
      Width = 22
      Height = 13
      Caption = 'Final'
    end
    object Label5: TLabel
      Left = 16
      Top = 132
      Width = 22
      Height = 13
      Caption = 'Step'
    end
    object Label6: TLabel
      Left = 160
      Top = 84
      Width = 32
      Height = 13
      Caption = 'Label6'
    end
    object Label7: TLabel
      Left = 160
      Top = 108
      Width = 32
      Height = 13
      Caption = 'Label7'
    end
    object Label8: TLabel
      Left = 160
      Top = 132
      Width = 32
      Height = 13
      Caption = 'Label8'
    end
    object ComboBox1: TComboBox
      Left = 48
      Top = 24
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Min - Max'
      Items.Strings = (
        'Min - Max'
        'Min - Max (relative)')
    end
    object Button3: TButton
      Left = 8
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Auto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button3Click
    end
    object Edit1: TEdit
      Left = 48
      Top = 80
      Width = 105
      Height = 21
      TabOrder = 2
      Text = '0'
    end
    object Edit2: TEdit
      Left = 48
      Top = 104
      Width = 105
      Height = 21
      TabOrder = 3
      Text = '0'
    end
    object Edit3: TEdit
      Left = 48
      Top = 128
      Width = 105
      Height = 21
      TabOrder = 4
      Text = '1'
    end
  end
  object GroupBox3: TGroupBox
    Left = 216
    Top = 216
    Width = 209
    Height = 89
    Caption = 'Additions'
    TabOrder = 4
  end
end
