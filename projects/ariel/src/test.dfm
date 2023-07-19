object fmTest: TfmTest
  Left = 0
  Top = 0
  Caption = 'fmTest'
  ClientHeight = 296
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 408
    Top = 0
    Width = 200
    Height = 296
    Align = alRight
    TabOrder = 0
    object cxComboBox1: TcxComboBox
      Left = 68
      Top = 7
      Properties.Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15'
        '16')
      TabOrder = 0
      Text = '1'
      Width = 121
    end
    object cxLabel1: TcxLabel
      Left = 16
      Top = 8
      Caption = #1050#1072#1085#1072#1083
    end
    object cxLabel2: TcxLabel
      Left = 16
      Top = 48
      Caption = #1052#1072#1089#1082#1072
    end
    object cxLabel3: TcxLabel
      Left = 16
      Top = 80
      Caption = #1055#1086#1088#1086#1075
    end
    object cxTextEdit1: TcxTextEdit
      Left = 64
      Top = 47
      TabOrder = 4
      Text = '5.0'
      Width = 121
    end
    object cxTextEdit2: TcxTextEdit
      Left = 68
      Top = 80
      TabOrder = 5
      Text = '0.5'
      Width = 121
    end
    object cxButton1: TcxButton
      Left = 72
      Top = 129
      Width = 75
      Height = 25
      Caption = #1047#1072#1087#1091#1089#1082
      TabOrder = 6
      OnClick = cxButton1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 408
    Height = 296
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    OnResize = Panel2Resize
    ExplicitLeft = 64
    ExplicitTop = 8
    ExplicitWidth = 185
    ExplicitHeight = 208
    object Chart1: TChart
      Left = 1
      Top = 1
      Width = 406
      Height = 144
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      View3D = False
      Align = alTop
      TabOrder = 0
      object Series1: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series2: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clGreen
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series3: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = clBlack
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object Chart2: TChart
      Left = 1
      Top = 145
      Width = 406
      Height = 150
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      View3D = False
      Align = alClient
      TabOrder = 1
      ExplicitLeft = -4
      ExplicitTop = 151
      object Series4: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series5: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clGreen
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
      object Series6: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        SeriesColor = clBlack
        XValues.Name = 'X'
        XValues.Order = loAscending
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
  end
end
