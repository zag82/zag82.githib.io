object fmMain2: TfmMain2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'fmMain2'
  ClientHeight = 355
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCharts: TPanel
    Left = 0
    Top = 169
    Width = 745
    Height = 186
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = pnlChartsResize
    object Chart2: TChart
      Left = 493
      Top = 0
      Width = 252
      Height = 186
      Legend.Visible = False
      Title.Text.Strings = (
        'TChart')
      Title.Visible = False
      BottomAxis.Automatic = False
      BottomAxis.AutomaticMaximum = False
      BottomAxis.AutomaticMinimum = False
      BottomAxis.Labels = False
      BottomAxis.Maximum = 16000.000000000000000000
      BottomAxis.Minimum = -16000.000000000000000000
      LeftAxis.Automatic = False
      LeftAxis.AutomaticMaximum = False
      LeftAxis.AutomaticMinimum = False
      LeftAxis.Labels = False
      LeftAxis.Maximum = 16000.000000000000000000
      LeftAxis.Minimum = -16000.000000000000000000
      View3D = False
      Align = alRight
      TabOrder = 0
      object Series3: TFastLineSeries
        Marks.Arrow.Visible = True
        Marks.Callout.Brush.Color = clBlack
        Marks.Callout.Arrow.Visible = True
        Marks.Visible = False
        LinePen.Color = clRed
        XValues.Name = 'X'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loNone
      end
    end
    object pnlGraphs: TPanel
      Left = 0
      Top = 0
      Width = 493
      Height = 186
      Align = alClient
      TabOrder = 1
      OnResize = pnlGraphsResize
      object Chart1: TChart
        Left = 1
        Top = 1
        Width = 491
        Height = 143
        Legend.Visible = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMaximum = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Maximum = 3000.000000000000000000
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 0.500000000000000000
        DepthAxis.Minimum = -0.500000000000000000
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.500000000000000000
        DepthTopAxis.Minimum = -0.500000000000000000
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 16000.000000000000000000
        LeftAxis.Minimum = -16000.000000000000000000
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        View3D = False
        Align = alClient
        TabOrder = 0
        object Series2: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          LinePen.Color = clGreen
          TreatNulls = tnDontPaint
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series1: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clRed
          LinePen.Color = clRed
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object Panel1: TPanel
        Left = 1
        Top = 144
        Width = 491
        Height = 41
        Align = alBottom
        Caption = 'Panel1'
        TabOrder = 1
        object pnl: TPaintBox
          Left = 1
          Top = 1
          Width = 489
          Height = 39
          Align = alClient
          OnPaint = pnlPaint
          ExplicitLeft = 5
          ExplicitTop = 33
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 745
    Height = 169
    Align = alTop
    TabOrder = 1
    object mm: TMemo
      Left = 186
      Top = 1
      Width = 558
      Height = 167
      Align = alClient
      Lines.Strings = (
        'mm')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object pnlControl: TPanel
      Left = 1
      Top = 1
      Width = 185
      Height = 167
      Align = alLeft
      TabOrder = 1
      object Label1: TLabel
        Left = 13
        Top = 104
        Width = 31
        Height = 13
        Caption = #1050#1072#1085#1072#1083
      end
      object Label2: TLabel
        Left = 13
        Top = 131
        Width = 61
        Height = 13
        Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1072
      end
      object bt2: TButton
        Left = 13
        Top = 8
        Width = 156
        Height = 25
        Caption = #1063#1072#1089#1090#1086#1090#1072
        TabOrder = 0
        OnClick = bt2Click
      end
      object bt3: TButton
        Left = 13
        Top = 39
        Width = 75
        Height = 26
        Caption = #1076#1072#1085#1085#1099#1077
        TabOrder = 1
        OnClick = bt3Click
      end
      object Button1: TButton
        Left = 94
        Top = 70
        Width = 75
        Height = 25
        Caption = #1088#1072#1079#1098#1077#1076'.'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 94
        Top = 39
        Width = 75
        Height = 25
        Caption = #1044#1072#1085#1085#1099#1077' '#1089#1095'.'
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 13
        Top = 70
        Width = 75
        Height = 25
        Caption = #1042#1089#1077
        TabOrder = 4
        OnClick = Button3Click
      end
      object cbxChannel: TComboBox
        Left = 80
        Top = 101
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 5
        Text = '1'
        OnClick = cbxChannelClick
        Items.Strings = (
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
      end
      object cbxPart: TComboBox
        Left = 80
        Top = 128
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = 'Re'
        Items.Strings = (
          'Re'
          'Im'
          'Amp'
          'Phase')
      end
    end
  end
  object tm: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tmTimer
    Left = 288
    Top = 88
  end
end
