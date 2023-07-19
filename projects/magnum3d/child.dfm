object fmChild: TfmChild
  Left = 195
  Top = 116
  Width = 575
  Height = 511
  Caption = 'Viewer text form'
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
  object RichEdit1: TRichEdit
    Left = 185
    Top = 0
    Width = 382
    Height = 477
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 477
    Align = alLeft
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object FileListBox1: TFileListBox
      Left = 8
      Top = 240
      Width = 169
      Height = 229
      FileEdit = Edit1
      ItemHeight = 16
      Mask = '*.txt'
      TabOrder = 0
      OnClick = FileListBox1Click
    end
    object DirectoryListBox1: TDirectoryListBox
      Left = 8
      Top = 32
      Width = 169
      Height = 137
      FileList = FileListBox1
      ItemHeight = 16
      TabOrder = 1
    end
    object DriveComboBox1: TDriveComboBox
      Left = 8
      Top = 8
      Width = 169
      Height = 22
      DirList = DirectoryListBox1
      TabOrder = 2
    end
    object FilterComboBox1: TFilterComboBox
      Left = 8
      Top = 176
      Width = 169
      Height = 24
      FileList = FileListBox1
      Filter = 'Text Files|*.txt|All Files|*.*'
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 8
      Top = 208
      Width = 169
      Height = 24
      TabOrder = 4
      Text = '*.txt'
    end
  end
end
