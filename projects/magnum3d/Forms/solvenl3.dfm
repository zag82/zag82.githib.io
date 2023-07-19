object fmNonLine3: TfmNonLine3
  Left = 192
  Top = 114
  ActiveControl = Button1
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Non-linear 3D solver'
  ClientHeight = 357
  ClientWidth = 676
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
  object Label3: TLabel
    Left = 24
    Top = 248
    Width = 6
    Height = 13
    Caption = 'a'
  end
  object Label4: TLabel
    Left = 25
    Top = 272
    Width = 6
    Height = 13
    Caption = 'b'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 185
    Height = 217
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
      Top = 96
      Width = 161
      Height = 25
      Caption = 'Run Scalar'
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
      Left = 56
      Top = 184
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
      Width = 113
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
      Top = 136
      Width = 161
      Height = 25
      Caption = 'Run Vector'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object PageControl1: TPageControl
    Left = 200
    Top = 0
    Width = 473
    Height = 353
    ActivePage = TabSheet2
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Error'
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 465
        Height = 325
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.AdjustFrame = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        LeftAxis.Logarithmic = True
        Legend.Visible = False
        View3D = False
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
      Caption = 'B-H curve'
      ImageIndex = 1
      object Chart2: TChart
        Left = 0
        Top = 0
        Width = 465
        Height = 325
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.AdjustFrame = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        Legend.Visible = False
        View3D = False
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
  end
  object Edit3: TEdit
    Left = 48
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0.1'
  end
  object Edit4: TEdit
    Left = 48
    Top = 272
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '10000'
  end
  object Button4: TButton
    Left = 40
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 4
    OnClick = Button4Click
  end
end
