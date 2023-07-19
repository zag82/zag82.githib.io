object fmQueue: TfmQueue
  Left = 193
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Queues operations'
  ClientHeight = 255
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 217
    Caption = 'File List'
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 272
      Top = 40
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F00000000000
        FFFF0B03333333330FFF0B03333333330FFF0BB03333333330FF0BB033333333
        30FF0B8E03333333330F0B8E03333333330F0B8EE000000000FF0B8EEEEEEE00
        FFFF0BB8888880AA0FFF0BBBBBBB00AA00FFF0000000AAAAAA0FFFFFFFF0AAAA
        AA0FFFFFFFFF00AA00FFFFFFFFFFF0AA0FFFFFFFFFFFFF00FFFF}
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 272
      Top = 72
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F00000000000
        FFFF0B03333333330FFF0B03333333330FFF0BB03333333330FF0BB033333333
        30FF0B8E03333333330F0B8E03333333330F0B8EE000000000FF0B8EEEEEEE0F
        FFFF0BB88888880FFFFF0BBBBBBB0000000FF000000099999990FFFFFFF09999
        9990FFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 272
      Top = 120
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFF000000F
        FFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0F
        FFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFF0000CCCC00
        00FFF0CCCCCCCCCCCC0FFF0CCCCCCCCCC0FFFFF0CCCCCCCC0FFFFFFF0CCCCCC0
        FFFFFFFFF0CCCC0FFFFFFFFFFF0CC0FFFFFFFFFFFFF00FFFFFFF}
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 272
      Top = 152
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFF00FFF
        FFFFFFFFFF0CC0FFFFFFFFFFF0CCCC0FFFFFFFFF0CCCCCC0FFFFFFF0CCCCCCCC
        0FFFFF0CCCCCCCCCC0FFF0CCCCCCCCCCCC0FFF0000CCCC0000FFFFFFF0CCCC0F
        FFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0F
        FFFFFFFFF0CCCC0FFFFFFFFFF0CCCC0FFFFFFFFFF000000FFFFF}
      OnClick = SpeedButton4Click
    end
    object lb1: TListBox
      Left = 16
      Top = 24
      Width = 241
      Height = 177
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 320
    Top = 8
    Width = 281
    Height = 217
    Caption = 'Parameters'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 130
      Height = 13
      Caption = 'List of gage object numbers'
    end
    object Label2: TLabel
      Left = 184
      Top = 24
      Width = 69
      Height = 13
      Caption = 'Object number'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 136
      Width = 249
      Height = 9
      Shape = bsBottomLine
    end
    object SpeedButton5: TSpeedButton
      Left = 240
      Top = 176
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton5Click
    end
    object Label3: TLabel
      Left = 16
      Top = 160
      Width = 77
      Height = 13
      Caption = 'Output file name'
    end
    object lb2: TListBox
      Left = 16
      Top = 40
      Width = 153
      Height = 89
      ItemHeight = 13
      TabOrder = 0
    end
    object Button1: TButton
      Left = 184
      Top = 72
      Width = 81
      Height = 25
      Caption = 'Add'
      TabOrder = 1
      OnClick = Button1Click
    end
    object se: TSpinEdit
      Left = 184
      Top = 40
      Width = 81
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 2
      Value = 0
    end
    object Button3: TButton
      Left = 184
      Top = 104
      Width = 81
      Height = 25
      Caption = 'Delete'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 176
      Width = 225
      Height = 21
      TabOrder = 4
    end
  end
  object pbb: TProgressBar
    Left = 8
    Top = 232
    Width = 737
    Height = 17
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 608
    Top = 8
    Width = 137
    Height = 113
    Caption = 'Solution method'
    ItemIndex = 0
    Items.Strings = (
      'Standard 2D'
      'Standard 3D'
      'Two step algorythm')
    TabOrder = 3
  end
  object GroupBox3: TGroupBox
    Left = 608
    Top = 128
    Width = 137
    Height = 97
    Caption = 'Operations'
    TabOrder = 4
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 47
      Height = 26
      Caption = 'Defected material'
      WordWrap = True
    end
    object Button2: TButton
      Left = 16
      Top = 56
      Width = 105
      Height = 25
      Caption = 'Run'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button2Click
    end
    object ComboBox1: TComboBox
      Left = 64
      Top = 24
      Width = 57
      Height = 26
      Style = csDropDownList
      DropDownCount = 12
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 18
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = ' 0 '
      Items.Strings = (
        ' 0 '
        ' 1'
        ' 2'
        ' 3'
        ' 4'
        ' 5'
        ' 6'
        ' 7'
        ' 8'
        ' 9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16'
        '17'
        '18'
        '19'
        '20'
        '21'
        '22'
        '23'
        '24'
        '25'
        '26'
        '27'
        '28'
        '29'
        '30')
    end
  end
  object oDlg: TOpenDialog
    DefaultExt = 'mg3'
    Filter = 'Magnum Project Files|*.mg3'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 224
    Top = 72
  end
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Report Text Files|*.txt'
    Left = 224
    Top = 40
  end
end
