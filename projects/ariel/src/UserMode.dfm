object fmUserMode: TfmUserMode
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1078#1080#1084' '#1076#1086#1089#1090#1091#1087#1072
  ClientHeight = 88
  ClientWidth = 186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object gb: TcxGroupBox
    Left = 8
    Top = 0
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 0
    Height = 49
    Width = 171
    object cb: TcxComboBox
      Left = 15
      Top = 16
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088)
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Text = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      Width = 138
    end
  end
  object btOK: TcxButton
    Left = 8
    Top = 55
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Default = True
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    TabOrder = 1
    OnClick = btOKClick
  end
  object btCancel: TcxButton
    Left = 104
    Top = 55
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    TabOrder = 2
    OnClick = btCancelClick
  end
end
