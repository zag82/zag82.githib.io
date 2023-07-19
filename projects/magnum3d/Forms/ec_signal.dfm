object fmSignal: TfmSignal
  Left = 192
  Top = 114
  Caption = 'Eddy Current Signal'
  ClientHeight = 292
  ClientWidth = 641
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
  object Memo1: TMemo
    Left = 297
    Top = 0
    Width = 344
    Height = 292
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 297
    Height = 292
    Align = alLeft
    Caption = 'Parameters'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 63
      Height = 13
      Caption = 'Gage objects'
    end
    object Label2: TLabel
      Left = 168
      Top = 16
      Width = 70
      Height = 13
      Caption = 'Project objects'
    end
    object Label4: TLabel
      Left = 8
      Top = 172
      Width = 24
      Height = 13
      Caption = 'Task'
    end
    object SpeedButton1: TSpeedButton
      Left = 136
      Top = 72
      Width = 23
      Height = 22
      Caption = '>'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 136
      Top = 40
      Width = 23
      Height = 22
      Caption = '<'
      OnClick = SpeedButton2Click
    end
    object Bevel1: TBevel
      Left = 8
      Top = 152
      Width = 281
      Height = 9
      Shape = bsBottomLine
    end
    object SpeedButton3: TSpeedButton
      Left = 136
      Top = 120
      Width = 23
      Height = 22
      Caption = '0'
      OnClick = SpeedButton3Click
    end
    object Label3: TLabel
      Left = 8
      Top = 196
      Width = 36
      Height = 13
      Caption = 'Method'
    end
    object SpeedButton4: TSpeedButton
      Left = 56
      Top = 240
      Width = 23
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888880000000000000880330000008803088033000000880308803300000088
        0308803300000000030880333333333333088033000000003308803088888888
        0308803088888888030880308888888803088030888888880308803088888888
        0008803088888888080880000000000000088888888888888888}
      OnClick = SpeedButton4Click
    end
    object Label5: TLabel
      Left = 8
      Top = 224
      Width = 22
      Height = 13
      Caption = 'Turn'
    end
    object Button1: TButton
      Left = 208
      Top = 169
      Width = 75
      Height = 25
      Caption = 'Start'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 208
      Top = 200
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button2Click
    end
    object ListBox1: TListBox
      Left = 8
      Top = 32
      Width = 121
      Height = 113
      Ctl3D = True
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 2
    end
    object ListBox2: TListBox
      Left = 168
      Top = 32
      Width = 121
      Height = 113
      ItemHeight = 13
      TabOrder = 3
    end
    object ComboBox2: TComboBox
      Left = 56
      Top = 168
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = '2D solution'
      Items.Strings = (
        '2D solution'
        '3D solution')
    end
    object ComboBox1: TComboBox
      Left = 56
      Top = 192
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 5
      Text = 'Average'
      Items.Strings = (
        'Standard'
        'Average'
        'Weight')
    end
    object Edit1: TEdit
      Left = 56
      Top = 216
      Width = 121
      Height = 21
      TabOrder = 6
      Text = '125'
    end
  end
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All files|*.*'
    Left = 88
    Top = 240
  end
end
