object fmDetailEditor: TfmDetailEditor
  Left = 345
  Top = 220
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'fmDetailEditor'
  ClientHeight = 118
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControl: TPanel
    Left = 0
    Top = 85
    Width = 313
    Height = 33
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      313
      33)
    object btOk: TcxButton
      Left = 155
      Top = 4
      Width = 75
      Height = 25
      Action = actOK
      Anchors = [akTop, akRight]
      Default = True
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      TabOrder = 0
    end
    object btCancel: TcxButton
      Left = 234
      Top = 4
      Width = 75
      Height = 25
      Action = actCancel
      Anchors = [akTop, akRight]
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      TabOrder = 1
    end
  end
  object acts: TActionList
    Left = 8
    Top = 8
    object actOK: TAction
      Caption = 'OK'
      OnExecute = actOKExecute
    end
    object actCancel: TAction
      Caption = #1054#1090#1084#1077#1085#1072
      SecondaryShortCuts.Strings = (
        'ESC')
      OnExecute = actCancelExecute
    end
  end
end
