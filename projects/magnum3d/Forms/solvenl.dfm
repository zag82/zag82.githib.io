object fmSolveNl: TfmSolveNl
  Left = 194
  Top = 120
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NonLinear Solution'
  ClientHeight = 374
  ClientWidth = 640
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 193
    Height = 177
    Caption = 'NonLinear Parameters'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Iteration'
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 22
      Height = 13
      Caption = 'Error'
    end
    object Button1: TButton
      Left = 8
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Run'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Edit1: TEdit
      Left = 56
      Top = 24
      Width = 57
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object Edit2: TEdit
      Left = 56
      Top = 56
      Width = 121
      Height = 21
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
    object Button3: TButton
      Left = 8
      Top = 128
      Width = 161
      Height = 33
      Caption = 'Newton'
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object PageControl1: TPageControl
    Left = 208
    Top = 0
    Width = 425
    Height = 369
    ActivePage = TabSheet2
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Error'
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 417
        Height = 341
        AllowPanning = pmNone
        AllowZoom = False
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Title.Caption = 'Iteration Number'
        LeftAxis.Logarithmic = True
        LeftAxis.Title.Caption = 'Error'
        Legend.Visible = False
        View3D = False
        View3DWalls = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
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
    end
    object TabSheet2: TTabSheet
      Caption = 'B-H'
      ImageIndex = 1
      object Chart2: TChart
        Left = 0
        Top = 0
        Width = 417
        Height = 341
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        Legend.Visible = False
        View3D = False
        View3DWalls = False
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Series2: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
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
        object Series3: TPointSeries
          Marks.ArrowLength = 0
          Marks.Visible = False
          SeriesColor = clGreen
          Pointer.HorizSize = 3
          Pointer.InflateMargins = True
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
        object Series4: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clBlue
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
    end
    object TabSheet3: TTabSheet
      Caption = 'Points'
      ImageIndex = 2
      object sg: TStringGrid
        Left = 0
        Top = 0
        Width = 337
        Height = 129
        TabOrder = 0
      end
    end
  end
end
