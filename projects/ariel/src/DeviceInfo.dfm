object fmDeviceInfo: TfmDeviceInfo
  Left = 0
  Top = 0
  ActiveControl = btOk
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1080#1073#1086#1088#1077
  ClientHeight = 239
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControl: TPanel
    Left = 0
    Top = 194
    Width = 370
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btOk: TcxButton
      Left = 144
      Top = 9
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      TabOrder = 0
      OnClick = btOkClick
    end
  end
  object gbInfo: TcxGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Align = alClient
    Caption = #1057#1080#1089#1090#1077#1084#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 1
    Height = 188
    Width = 364
    object lbInfo: TLabel
      Left = 16
      Top = 24
      Width = 48
      Height = 16
      Caption = 'lbInfo'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
end
