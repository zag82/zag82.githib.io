object fmDirs: TfmDirs
  Left = 192
  Top = 107
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Choose Directory'
  ClientHeight = 310
  ClientWidth = 426
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
    Left = 128
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 425
    Height = 273
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 248
      Width = 81
      Height = 13
      Caption = 'D:\Magnum3d'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DriveComboBox1: TDriveComboBox
      Left = 8
      Top = 24
      Width = 193
      Height = 19
      DirList = DirectoryListBox1
      TabOrder = 0
    end
    object DirectoryListBox1: TDirectoryListBox
      Left = 8
      Top = 48
      Width = 193
      Height = 193
      DirLabel = Label1
      FileList = FileListBox1
      ItemHeight = 16
      TabOrder = 1
    end
    object FileListBox1: TFileListBox
      Left = 208
      Top = 24
      Width = 209
      Height = 217
      ItemHeight = 13
      TabOrder = 2
    end
  end
end
