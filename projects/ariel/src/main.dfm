object fmArielMain: TfmArielMain
  Left = 196
  Top = 106
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1043#1083#1072#1074#1085#1086#1077' '#1086#1082#1085#1086' - Ariel'
  ClientHeight = 473
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pc: TPageControl
    Left = 0
    Top = 0
    Width = 817
    Height = 281
    ActivePage = tsControl
    TabOrder = 0
    object tsControl: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 33
        Height = 13
        Caption = 'MType'
      end
      object Label3: TLabel
        Left = 8
        Top = 48
        Width = 32
        Height = 13
        Caption = 'DType'
      end
      object Label4: TLabel
        Left = 8
        Top = 72
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object Label5: TLabel
        Left = 8
        Top = 112
        Width = 32
        Height = 13
        Caption = 'Index1'
      end
      object Label6: TLabel
        Left = 8
        Top = 144
        Width = 32
        Height = 13
        Caption = 'Index2'
      end
      object Label7: TLabel
        Left = 8
        Top = 184
        Width = 23
        Height = 13
        Caption = 'Data'
      end
      object Label2: TLabel
        Left = 216
        Top = 8
        Width = 30
        Height = 13
        Caption = 'Result'
      end
      object cbxMType: TComboBox
        Left = 48
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 0
        Text = 'QUERY'
        Items.Strings = (
          'QUERY'
          'DATASET'
          'DATASTEP'
          'COMMAND')
      end
      object cbxDType: TComboBox
        Left = 48
        Top = 40
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'NONE'
        Items.Strings = (
          'NONE'
          'BYTE'
          'INT16'
          'INT32'
          'TEXT8')
      end
      object edID: TEdit
        Left = 48
        Top = 72
        Width = 145
        Height = 21
        TabOrder = 2
        Text = '2049'
      end
      object edIndex1: TEdit
        Left = 48
        Top = 104
        Width = 145
        Height = 21
        TabOrder = 3
        Text = '0'
      end
      object edIndex2: TEdit
        Left = 48
        Top = 136
        Width = 145
        Height = 21
        TabOrder = 4
        Text = '0'
      end
      object edData: TEdit
        Left = 48
        Top = 176
        Width = 145
        Height = 21
        TabOrder = 5
        Text = '0'
      end
      object btSendSettings: TButton
        Left = 8
        Top = 217
        Width = 185
        Height = 25
        Caption = 'SEND'
        TabOrder = 6
        OnClick = btSendSettingsClick
      end
      object mm: TMemo
        Left = 216
        Top = 24
        Width = 241
        Height = 217
        Lines.Strings = (
          'mm')
        ScrollBars = ssVertical
        TabOrder = 7
      end
      object mLog: TMemo
        Left = 464
        Top = 8
        Width = 337
        Height = 233
        Lines.Strings = (
          'mLog')
        ScrollBars = ssBoth
        TabOrder = 8
      end
    end
    object tsAcquire: TTabSheet
      Caption = #1057#1073#1086#1088' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 1
      object Label8: TLabel
        Left = 216
        Top = 8
        Width = 30
        Height = 13
        Caption = 'Result'
      end
      object Label9: TLabel
        Left = 8
        Top = 16
        Width = 33
        Height = 13
        Caption = 'MType'
      end
      object Label10: TLabel
        Left = 8
        Top = 48
        Width = 32
        Height = 13
        Caption = 'DType'
      end
      object Label11: TLabel
        Left = 8
        Top = 72
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object Label12: TLabel
        Left = 8
        Top = 112
        Width = 32
        Height = 13
        Caption = 'Index1'
      end
      object Label13: TLabel
        Left = 8
        Top = 144
        Width = 32
        Height = 13
        Caption = 'Index2'
      end
      object Label14: TLabel
        Left = 8
        Top = 184
        Width = 23
        Height = 13
        Caption = 'Data'
      end
      object ma: TMemo
        Left = 216
        Top = 24
        Width = 241
        Height = 177
        Lines.Strings = (
          'ma')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object mLogAq: TMemo
        Left = 464
        Top = 8
        Width = 337
        Height = 233
        Lines.Strings = (
          'mLogAq')
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object btAquire: TButton
        Left = 3
        Top = 216
        Width = 185
        Height = 25
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1090#1072#1081#1084#1077#1088#1091
        TabOrder = 2
        OnClick = btAquireClick
      end
      object cbxMType2: TComboBox
        Left = 48
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = 'QUERY'
        Items.Strings = (
          'QUERY'
          'DATASET'
          'DATASTEP'
          'COMMAND')
      end
      object cbxDType2: TComboBox
        Left = 48
        Top = 40
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'NONE'
        Items.Strings = (
          'NONE'
          'BYTE'
          'INT16'
          'INT32'
          'TEXT8')
      end
      object edID2: TEdit
        Left = 48
        Top = 72
        Width = 145
        Height = 21
        TabOrder = 5
        Text = '4609'
      end
      object edIndex1_a: TEdit
        Left = 48
        Top = 104
        Width = 145
        Height = 21
        TabOrder = 6
        Text = '0'
      end
      object edIndex2_a: TEdit
        Left = 48
        Top = 136
        Width = 145
        Height = 21
        TabOrder = 7
        Text = '0'
      end
      object edData2: TEdit
        Left = 48
        Top = 176
        Width = 145
        Height = 21
        TabOrder = 8
        Text = '0'
      end
      object btEndRead: TButton
        Left = 383
        Top = 216
        Width = 75
        Height = 25
        Caption = 'End read'
        TabOrder = 9
        OnClick = btEndReadClick
      end
      object btAcquireCounter: TButton
        Left = 194
        Top = 216
        Width = 169
        Height = 25
        Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1089#1095#1077#1090#1095#1080#1082#1091
        TabOrder = 10
        OnClick = btAcquireCounterClick
      end
    end
  end
  object pnlCharts: TPanel
    Left = 0
    Top = 281
    Width = 817
    Height = 192
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlCharts'
    TabOrder = 1
    object Chart2: TChart
      Left = 624
      Top = 0
      Width = 193
      Height = 192
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
    object Chart1: TChart
      Left = 0
      Top = 0
      Width = 624
      Height = 192
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
      TabOrder = 1
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
  end
  object mMenu: TMainMenu
    Left = 264
    object N1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N6: TMenuItem
        Caption = #1055#1086#1090#1086#1082#1080
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = #1053#1086#1074#1072#1103' '#1092#1086#1088#1084#1072
        OnClick = N7Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object N3: TMenuItem
        Caption = #1042'&'#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N2: TMenuItem
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      object N4: TMenuItem
        Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = N4Click
      end
    end
  end
end
