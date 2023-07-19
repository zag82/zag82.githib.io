object fmSysInfo: TfmSysInfo
  Left = 194
  Top = 106
  Width = 544
  Height = 375
  Caption = 'System Information & memory management'
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 233
    Top = 0
    Width = 303
    Height = 348
    AllowPanning = pmNone
    AllowZoom = False
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    BackWall.Pen.Visible = False
    Gradient.EndColor = clSilver
    Gradient.StartColor = 4227072
    Gradient.Visible = True
    Title.AdjustFrame = False
    Title.Text.Strings = (
      'Memory allocation')
    AxisVisible = False
    ClipPoints = False
    Frame.Visible = False
    Legend.ResizeChart = False
    Legend.Visible = False
    View3DOptions.Elevation = 315
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 0
    View3DOptions.Rotation = 360
    View3DWalls = False
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 0
      Top = 0
      Width = 129
      Height = 17
      Caption = 'Free Physical Memory'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 0
      Top = 16
      Width = 57
      Height = 17
      Caption = 'Rotate'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object CheckBox3: TCheckBox
      Left = 0
      Top = 32
      Width = 81
      Height = 17
      Caption = 'Auto Update'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object Series1: TPieSeries
      Marks.ArrowLength = 8
      Marks.Visible = True
      SeriesColor = clRed
      Circled = True
      OtherSlice.Text = 'Other'
      PieValues.DateTime = False
      PieValues.Name = 'Pie'
      PieValues.Multiplier = 1
      PieValues.Order = loNone
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 348
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 153
      Width = 233
      Height = 9
      Cursor = crVSplit
      Align = alTop
    end
    object sg1: TStringGrid
      Left = 0
      Top = 0
      Width = 233
      Height = 153
      Align = alTop
      ColCount = 2
      DefaultColWidth = 104
      FixedCols = 0
      RowCount = 6
      TabOrder = 0
    end
    object sg2: TStringGrid
      Left = 0
      Top = 162
      Width = 233
      Height = 186
      Align = alClient
      ColCount = 2
      DefaultColWidth = 104
      FixedCols = 0
      RowCount = 16
      TabOrder = 1
      OnDrawCell = sg2DrawCell
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 505
  end
  object Timer2: TTimer
    Interval = 100
    OnTimer = Timer2Timer
    Left = 473
  end
end
