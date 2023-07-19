object fmGraph3: TfmGraph3
  Left = 193
  Top = 107
  Width = 635
  Height = 426
  Caption = 'Graph - 3D'
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
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 627
    Height = 295
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
    BottomAxis.Title.Caption = 'X (mm)'
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
    BorderStyle = bsSingle
    Color = clBlack
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
    object Series2: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clGreen
      Pointer.Brush.Color = clYellow
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clYellow
      Pointer.Style = psDiamond
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
  object Panel1: TPanel
    Left = 0
    Top = 295
    Width = 627
    Height = 97
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
    TabOrder = 1
    object CheckBox1: TCheckBox
      Left = 0
      Top = 0
      Width = 57
      Height = 17
      Caption = 'Value'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object BitBtn1: TBitBtn
      Left = 56
      Top = 0
      Width = 121
      Height = 25
      Caption = 'Save To File'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn1Click
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00000000000000000000000000000000000000000000
        000000001F7C1F7C0000004200420000000000000000000000001F7C1F7C0000
        004200001F7C1F7C0000004200420000000000000000000000001F7C1F7C0000
        004200001F7C1F7C0000004200420000000000000000000000001F7C1F7C0000
        004200001F7C1F7C000000420042000000000000000000000000000000000000
        004200001F7C1F7C000000420042004200420042004200420042004200420042
        004200001F7C1F7C000000420042000000000000000000000000000000000042
        004200001F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        004200001F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        004200001F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        004200001F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        004200001F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        000000001F7C1F7C0000004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
        1F7C00001F7C1F7C000000000000000000000000000000000000000000000000
        000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
    end
    object Panel2: TPanel
      Left = 0
      Top = 32
      Width = 577
      Height = 57
      BevelOuter = bvNone
      Color = clBlack
      TabOrder = 2
      Visible = False
      object Label1: TLabel
        Left = 8
        Top = 40
        Width = 42
        Height = 13
        Caption = 'R (mm) ='
      end
      object Label2: TLabel
        Left = 64
        Top = 40
        Width = 68
        Height = 13
        Caption = '0.22500589'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 208
        Top = 40
        Width = 50
        Height = 13
        Caption = 'Bx (Tsla) ='
      end
      object Label4: TLabel
        Left = 280
        Top = 40
        Width = 54
        Height = 13
        Caption = '0.000259'
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
        Width = 409
        Height = 17
        Min = 1
        PageSize = 0
        Position = 1
        TabOrder = 0
        OnChange = scbChange
      end
    end
  end
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Graph|*.txt|All Files|*.*'
    Left = 112
    Top = 24
  end
end
