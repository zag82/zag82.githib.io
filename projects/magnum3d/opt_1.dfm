object fmMFOptimization: TfmMFOptimization
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Multi Frequence Optimization'
  ClientHeight = 376
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 249
    Caption = 'Settings'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 24
      Height = 13
      Caption = 'Task'
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 27
      Height = 13
      Caption = 'Script'
    end
    object SpeedButton1: TSpeedButton
      Left = 232
      Top = 24
      Width = 23
      Height = 22
      Caption = '...'
    end
    object SpeedButton2: TSpeedButton
      Left = 232
      Top = 56
      Width = 23
      Height = 22
      Caption = '...'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 88
      Width = 241
      Height = 17
      Shape = bsTopLine
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 38
      Height = 13
      Caption = 'Sigma 0'
    end
    object Label4: TLabel
      Left = 16
      Top = 144
      Width = 24
      Height = 13
      Caption = 'Mu 0'
    end
    object Label5: TLabel
      Left = 32
      Top = 176
      Width = 22
      Height = 13
      Caption = 'Step'
    end
    object Bevel2: TBevel
      Left = 8
      Top = 200
      Width = 249
      Height = 17
      Shape = bsTopLine
    end
    object Label6: TLabel
      Left = 16
      Top = 224
      Width = 37
      Height = 13
      Caption = 'Material'
    end
    object Edit1: TEdit
      Left = 56
      Top = 24
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 56
      Top = 56
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 64
      Top = 168
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 2
      Text = '0.5'
      Items.Strings = (
        '0.1'
        '0.25'
        '0.5'
        '0.75'
        '1'
        '2'
        '3')
    end
    object Edit3: TEdit
      Left = 64
      Top = 104
      Width = 89
      Height = 21
      TabOrder = 3
      Text = '1'
    end
    object Edit4: TEdit
      Left = 64
      Top = 136
      Width = 89
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object SpinEdit1: TSpinEdit
      Left = 64
      Top = 216
      Width = 97
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 288
    Top = 288
    Width = 369
    Height = 81
    Caption = 'Control'
    TabOrder = 1
    object Button1: TButton
      Left = 24
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Load data'
      TabOrder = 0
    end
    object Button2: TButton
      Left = 120
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Run'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object Button3: TButton
      Left = 272
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 288
    Top = 8
    Width = 369
    Height = 273
    Caption = 'Godographs'
    TabOrder = 2
    object Label7: TLabel
      Left = 24
      Top = 224
      Width = 50
      Height = 13
      Caption = 'Frequency'
    end
    object Label8: TLabel
      Left = 24
      Top = 248
      Width = 44
      Height = 13
      Caption = 'FileName'
    end
    object SpeedButton3: TSpeedButton
      Left = 248
      Top = 240
      Width = 23
      Height = 22
      Caption = '...'
    end
    object lb1: TListBox
      Left = 8
      Top = 24
      Width = 137
      Height = 185
      ItemHeight = 13
      TabOrder = 0
    end
    object lb2: TListBox
      Left = 152
      Top = 24
      Width = 121
      Height = 185
      Enabled = False
      ItemHeight = 13
      TabOrder = 1
    end
    object Edit5: TEdit
      Left = 80
      Top = 216
      Width = 193
      Height = 21
      TabOrder = 2
    end
    object Edit6: TEdit
      Left = 80
      Top = 240
      Width = 169
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object Button4: TButton
      Left = 280
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 4
    end
    object Button5: TButton
      Left = 280
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 5
    end
    object Button6: TButton
      Left = 280
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 6
    end
    object Button7: TButton
      Left = 280
      Top = 144
      Width = 75
      Height = 25
      Caption = 'Up'
      TabOrder = 7
    end
    object Button8: TButton
      Left = 280
      Top = 176
      Width = 75
      Height = 25
      Caption = 'Down'
      TabOrder = 8
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 264
    Width = 273
    Height = 105
    Caption = 'Results'
    TabOrder = 3
  end
end
