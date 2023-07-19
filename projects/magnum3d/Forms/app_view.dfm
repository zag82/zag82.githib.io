object fmSolveView: TfmSolveView
  Left = 192
  Top = 107
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'View solutions'
  ClientHeight = 81
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 0
    Width = 201
    Height = 81
    Caption = 'Sort of view'
    ItemIndex = 0
    Items.Strings = (
      'Full solution'
      'Axial solution'
      'Defect solution')
    TabOrder = 2
  end
  object Button1: TButton
    Left = 120
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Load'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button2Click
  end
end
