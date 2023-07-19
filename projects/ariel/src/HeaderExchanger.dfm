object fmHeaderExchanger: TfmHeaderExchanger
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1084#1077#1085#1080#1090#1077#1083#1100' '#1079#1072#1075#1086#1083#1086#1074#1082#1086#1074
  ClientHeight = 288
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object edIniFile: TcxButtonEdit
    Left = 80
    Top = 8
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = edIniFilePropertiesButtonClick
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 0
    Text = 'edIniFile'
    Width = 340
  end
  object lbFiles: TcxListBox
    Left = 8
    Top = 63
    Width = 412
    Height = 186
    ItemHeight = 13
    Style.LookAndFeel.Kind = lfStandard
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfStandard
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfStandard
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfStandard
    StyleHot.LookAndFeel.NativeStyle = True
    TabOrder = 1
  end
  object lbIniFile: TcxLabel
    Left = 8
    Top = 8
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081
    Style.LookAndFeel.Kind = lfOffice11
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfOffice11
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfOffice11
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfOffice11
    StyleHot.LookAndFeel.NativeStyle = True
  end
  object lbFile: TcxLabel
    Left = 8
    Top = 40
    Caption = #1060#1072#1081#1083#1099
    Style.LookAndFeel.Kind = lfOffice11
    Style.LookAndFeel.NativeStyle = True
    StyleDisabled.LookAndFeel.Kind = lfOffice11
    StyleDisabled.LookAndFeel.NativeStyle = True
    StyleFocused.LookAndFeel.Kind = lfOffice11
    StyleFocused.LookAndFeel.NativeStyle = True
    StyleHot.LookAndFeel.Kind = lfOffice11
    StyleHot.LookAndFeel.NativeStyle = True
  end
  object btRun: TcxButton
    Left = 345
    Top = 255
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    TabOrder = 4
    OnClick = btRunClick
  end
  object btAdd: TcxButton
    Left = 80
    Top = 35
    Width = 63
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    TabOrder = 5
    OnClick = btAddClick
  end
  object btClear: TcxButton
    Left = 149
    Top = 35
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    TabOrder = 6
    OnClick = btClearClick
  end
  object oDlg: TOpenDialog
    DefaultExt = '*.dar'
    Filter = 'Ariel Data Files (*.dar)|*.dar'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 264
    Top = 40
  end
end
