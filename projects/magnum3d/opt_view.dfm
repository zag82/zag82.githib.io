object fmOpView: TfmOpView
  Left = 2
  Top = 2
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Preview'
  ClientHeight = 533
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 489
    Height = 489
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Maximum = 20.000000000000000000
    BottomAxis.Minimum = -2.000000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Maximum = 20.000000000000000000
    LeftAxis.Minimum = -2.000000000000000000
    Legend.Visible = False
    View3D = False
    BevelOuter = bvNone
    TabOrder = 0
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 128
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Resume'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 208
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Pause'
    TabOrder = 2
  end
  object Button3: TButton
    Left = 288
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Terminate'
    TabOrder = 3
  end
end
