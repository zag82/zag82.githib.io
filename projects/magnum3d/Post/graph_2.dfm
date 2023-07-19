object fmGraph2: TfmGraph2
  Left = 480
  Top = 299
  Width = 544
  Height = 375
  Caption = 'Graph - 2D'
  Color = clBlack
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
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 536
    Height = 100
    Align = alBottom
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clAqua
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 57
      Height = 17
      Caption = 'Value'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object Panel2: TPanel
      Left = 0
      Top = 32
      Width = 377
      Height = 65
      BevelOuter = bvNone
      Color = clBlack
      TabOrder = 1
      Visible = False
      object Label1: TLabel
        Left = 8
        Top = 40
        Width = 45
        Height = 13
        Caption = 'R (mm) = '
      end
      object Label2: TLabel
        Left = 64
        Top = 40
        Width = 54
        Height = 13
        Caption = '0.225002'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 176
        Top = 40
        Width = 56
        Height = 13
        Caption = 'Bx (Tesla) ='
      end
      object Label4: TLabel
        Left = 248
        Top = 40
        Width = 47
        Height = 13
        Caption = '0.00025'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object scb: TScrollBar
        Left = 8
        Top = 8
        Width = 361
        Height = 16
        Min = 1
        PageSize = 0
        Position = 1
        TabOrder = 0
        OnChange = scbChange
      end
    end
    object BitBtn1: TBitBtn
      Left = 104
      Top = 0
      Width = 129
      Height = 25
      Caption = 'Save To File'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtn1Click
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888880000000000000880330000008803088033000000880308803300000088
        0308803300000000030880333333333333088033000000003308803088888888
        0308803088888888030880308888888803088030888888880308803088888888
        0008803088888888080880000000000000088888888888888888}
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 536
    Height = 241
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.LabelsFont.Charset = DEFAULT_CHARSET
    BottomAxis.LabelsFont.Color = clAqua
    BottomAxis.LabelsFont.Height = -11
    BottomAxis.LabelsFont.Name = 'Arial'
    BottomAxis.LabelsFont.Style = []
    BottomAxis.Title.Caption = 'R (mm)'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clYellow
    BottomAxis.Title.Font.Height = -11
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = []
    LeftAxis.LabelsFont.Charset = DEFAULT_CHARSET
    LeftAxis.LabelsFont.Color = clAqua
    LeftAxis.LabelsFont.Height = -11
    LeftAxis.LabelsFont.Name = 'Arial'
    LeftAxis.LabelsFont.Style = []
    LeftAxis.Title.Caption = 'Bx (Tesla)'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clYellow
    LeftAxis.Title.Font.Height = -11
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = []
    Legend.Visible = False
    View3D = False
    View3DWalls = False
    Align = alClient
    BevelOuter = bvNone
    BevelWidth = 0
    BorderStyle = bsSingle
    Color = clBlack
    TabOrder = 1
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
    object Series2: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clGreen
      Pointer.Brush.Color = clYellow
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clYellow
      Pointer.Style = psDiamond
      Pointer.VertSize = 3
      Pointer.Visible = True
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
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Graph|*.txt|All Files|*.*'
    Left = 64
    Top = 8
  end
end
