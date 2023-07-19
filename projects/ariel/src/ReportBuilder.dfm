object fmReportBuilder: TfmReportBuilder
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 517
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlControl: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 270
    Height = 511
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object gbFiles: TcxGroupBox
      Left = 0
      Top = 73
      Align = alClient
      Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1092#1072#1081#1083#1099
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Height = 138
      Width = 270
      object dockFilesControl: TdxBarDockControl
        AlignWithMargins = True
        Left = 5
        Top = 21
        Width = 260
        Height = 22
        Align = dalTop
        BarManager = bm
      end
      object grFiles: TcxGrid
        AlignWithMargins = True
        Left = 5
        Top = 49
        Width = 260
        Height = 84
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfStandard
        LookAndFeel.NativeStyle = True
        object tvFiles: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsFiles
          DataController.KeyFieldNames = 'RecId'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsSelection.InvertSelect = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
          OptionsView.CellAutoHeight = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderEndEllipsis = True
          object tvFilesFILE_PATH: TcxGridDBColumn
            Caption = #1055#1091#1090#1100
            DataBinding.FieldName = 'FILE_PATH'
            Visible = False
            GroupIndex = 0
          end
          object tvFilesFILE_NAME: TcxGridDBColumn
            Caption = #1060#1072#1081#1083
            DataBinding.FieldName = 'FILE_NAME'
          end
        end
        object lvFiles: TcxGridLevel
          GridView = tvFiles
        end
      end
    end
    object grParams: TcxGroupBox
      Left = 0
      Top = 0
      Align = alTop
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 1
      Height = 73
      Width = 270
      object cbType: TcxComboBox
        Left = 7
        Top = 40
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #1050#1086#1085#1090#1088#1086#1083#1100
          #1055#1086#1074#1077#1088#1082#1072)
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Text = #1050#1086#1085#1090#1088#1086#1083#1100
        Width = 257
      end
      object lbType: TcxLabel
        Left = 7
        Top = 17
        Caption = #1058#1080#1087' '#1086#1090#1095#1077#1090#1072':'
      end
    end
    object gbGraph: TcxGroupBox
      Left = 0
      Top = 211
      Align = alBottom
      Caption = #1054#1073#1088#1072#1079
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 2
      DesignSize = (
        270
        300)
      Height = 300
      Width = 270
      object ch: TChart
        Left = 5
        Top = 14
        Width = 259
        Height = 259
        Legend.Visible = False
        MarginBottom = 0
        MarginLeft = 0
        MarginRight = 0
        MarginTop = 0
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMaximum = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Axis.Color = clSilver
        BottomAxis.Grid.Visible = False
        BottomAxis.Labels = False
        BottomAxis.LabelsFont.Shadow.Visible = False
        BottomAxis.LabelsOnAxis = False
        BottomAxis.Maximum = 5.000000000000000000
        BottomAxis.Minimum = -5.000000000000000000
        BottomAxis.MinorTicks.Visible = False
        BottomAxis.PositionPercent = 50.000000000000000000
        BottomAxis.RoundFirstLabel = False
        BottomAxis.Ticks.Visible = False
        BottomAxis.TicksInner.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Axis.Color = clSilver
        LeftAxis.Grid.Visible = False
        LeftAxis.Labels = False
        LeftAxis.LabelsOnAxis = False
        LeftAxis.Maximum = 5.000000000000000000
        LeftAxis.Minimum = -5.000000000000000000
        LeftAxis.MinorTicks.Visible = False
        LeftAxis.PositionPercent = 50.000000000000000000
        LeftAxis.RoundFirstLabel = False
        LeftAxis.Ticks.Visible = False
        LeftAxis.TicksInner.Visible = False
        View3D = False
        Zoom.Allow = False
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        object Series1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clYellow
          Pointer.InflateMargins = True
          Pointer.Pen.Visible = False
          Pointer.Style = psCircle
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object Series2: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Pen.Visible = False
          Pointer.Style = psDiamond
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object cb1: TcxCheckBox
        Left = 3
        Top = 279
        Anchors = [akLeft, akBottom]
        Caption = #1050#1072#1085#1072#1083'1'
        State = cbsChecked
        TabOrder = 1
        OnClick = cb1Click
        Width = 62
      end
      object cb2: TcxCheckBox
        Left = 138
        Top = 279
        Anchors = [akLeft, akBottom]
        Caption = #1050#1072#1085#1072#1083'2'
        State = cbsChecked
        TabOrder = 2
        OnClick = cb2Click
        Width = 65
      end
    end
  end
  object pnlMain: TPanel
    AlignWithMargins = True
    Left = 279
    Top = 3
    Width = 502
    Height = 511
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object dockReportControl: TdxBarDockControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 496
      Height = 22
      Align = dalTop
      BarManager = bm
    end
    object grReport: TcxGrid
      AlignWithMargins = True
      Left = 3
      Top = 31
      Width = 496
      Height = 477
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      object tvReport: TcxGridDBBandedTableView
        NavigatorButtons.ConfirmDelete = False
        FilterBox.Visible = fvAlways
        DataController.DataSource = dsReport
        DataController.KeyFieldNames = 'RecId'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsCustomize.BandMoving = False
        OptionsCustomize.BandsQuickCustomization = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1076#1072#1085#1085#1099#1093' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103'>'
        OptionsView.Footer = True
        OptionsView.GroupFooters = gfAlwaysVisible
        OptionsView.HeaderEndEllipsis = True
        OptionsView.Indicator = True
        Bands = <
          item
            Caption = #1060#1072#1081#1083
          end
          item
            Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1077#1092#1077#1082#1090#1072
          end
          item
            Caption = #1050#1072#1085#1072#1083' 1'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 2'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 3'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 4'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 5'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 6'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 7'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 8'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 9'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 10'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 11'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 12'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 13'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 14'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 15'
          end
          item
            Caption = #1050#1072#1085#1072#1083' 16'
          end>
        object tvReportFILE_PATH: TcxGridDBBandedColumn
          Caption = #1055#1091#1090#1100
          DataBinding.FieldName = 'FILE_PATH'
          Width = 300
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportFILE_NAME: TcxGridDBBandedColumn
          Caption = #1060#1072#1081#1083
          DataBinding.FieldName = 'FILE_NAME'
          Width = 200
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportQRES: TcxGridDBBandedColumn
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1087#1086' '#1090#1088#1091#1073#1082#1077
          DataBinding.FieldName = 'QRES'
          PropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.CustomColors = <>
          Properties.ShowDescriptions = False
          Width = 75
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object tvReportDEFECT_NUMBER: TcxGridDBBandedColumn
          Caption = #8470
          DataBinding.FieldName = 'DEFECT_NUMBER'
          Width = 45
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPOSITION: TcxGridDBBandedColumn
          Caption = #1055#1086#1083#1086#1078#1077#1085#1080#1077', '#1084#1084
          DataBinding.FieldName = 'POSITION'
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportVOLUME: TcxGridDBBandedColumn
          Caption = #1054#1073#1098#1077#1084
          DataBinding.FieldName = 'VOLUME'
          Width = 60
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object tvReportANGLE: TcxGridDBBandedColumn
          Caption = #1054#1088#1080#1077#1085#1090#1072#1094#1080#1103
          DataBinding.FieldName = 'ANGLE'
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object tvReportCOLOR: TcxGridDBBandedColumn
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
          DataBinding.FieldName = 'COLOR'
          PropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.CustomColors = <>
          Properties.ShowDescriptions = False
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object tvReportCMNT: TcxGridDBBandedColumn
          Caption = #1044#1072#1090#1095#1080#1082#1080' ('#1082#1072#1085#1072#1083' '#1073#1088#1072#1082#1086#1074#1082#1080')'
          DataBinding.FieldName = 'CMNT'
          Width = 100
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object tvReportDTYPE: TcxGridDBBandedColumn
          Caption = #1058#1080#1087' '#1076#1077#1092#1077#1082#1090#1072
          DataBinding.FieldName = 'DTYPE'
          Width = 75
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object tvReportAM_1: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_1'
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_1: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_1'
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_2: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_2'
          Position.BandIndex = 3
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_2: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_2'
          Position.BandIndex = 3
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_3: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_3'
          Position.BandIndex = 4
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_3: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_3'
          Position.BandIndex = 4
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_4: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_4'
          Position.BandIndex = 5
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_4: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_4'
          Position.BandIndex = 5
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_5: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_5'
          Position.BandIndex = 6
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_5: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_5'
          Position.BandIndex = 6
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_6: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_6'
          Position.BandIndex = 7
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_6: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_6'
          Position.BandIndex = 7
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_7: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_7'
          Position.BandIndex = 8
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_7: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_7'
          Position.BandIndex = 8
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_8: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_8'
          Position.BandIndex = 9
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_8: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_8'
          Position.BandIndex = 9
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_9: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_9'
          Position.BandIndex = 10
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_9: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_9'
          Position.BandIndex = 10
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_10: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_10'
          Position.BandIndex = 11
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_10: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_10'
          Position.BandIndex = 11
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_11: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_11'
          Position.BandIndex = 12
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_11: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_11'
          Position.BandIndex = 12
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_12: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_12'
          Position.BandIndex = 13
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_12: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_12'
          Position.BandIndex = 13
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_13: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_13'
          Position.BandIndex = 14
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_13: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_13'
          Position.BandIndex = 14
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_14: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_14'
          Position.BandIndex = 15
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_14: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_14'
          Position.BandIndex = 15
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_15: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_15'
          Position.BandIndex = 16
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_15: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_15'
          Position.BandIndex = 16
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object tvReportAM_16: TcxGridDBBandedColumn
          Caption = #1040#1084#1087'.'
          DataBinding.FieldName = 'AM_16'
          Position.BandIndex = 17
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object tvReportPH_16: TcxGridDBBandedColumn
          Caption = #1060#1072#1079#1072
          DataBinding.FieldName = 'PH_16'
          Position.BandIndex = 17
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
      end
      object lvReport: TcxGridLevel
        GridView = tvReport
      end
    end
  end
  object mdReport: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mdReportAfterScroll
    Left = 336
    Top = 88
    object mdReportFILE_PATH: TStringField
      FieldName = 'FILE_PATH'
      Size = 250
    end
    object mdReportFILE_NAME: TStringField
      FieldName = 'FILE_NAME'
      Size = 64
    end
    object mdReportQRES: TIntegerField
      FieldName = 'QRES'
    end
    object mdReportDEFECT_NUMBER: TIntegerField
      Alignment = taCenter
      FieldName = 'DEFECT_NUMBER'
    end
    object mdReportPOSITION: TIntegerField
      Alignment = taCenter
      FieldName = 'POSITION'
    end
    object mdReportVOLUME: TFloatField
      Alignment = taCenter
      FieldName = 'VOLUME'
    end
    object mdReportANGLE: TIntegerField
      Alignment = taCenter
      FieldName = 'ANGLE'
    end
    object mdReportQUALITY: TIntegerField
      FieldName = 'QUALITY'
    end
    object mdReportCOLOR: TIntegerField
      FieldName = 'COLOR'
    end
    object mdReportCMNT: TStringField
      FieldName = 'CMNT'
      Size = 64
    end
    object mdReportDTYPE: TStringField
      Alignment = taCenter
      FieldName = 'DTYPE'
      Size = 16
    end
    object mdReportAM_1: TFloatField
      Alignment = taCenter
      FieldName = 'AM_1'
    end
    object mdReportAM_2: TFloatField
      Alignment = taCenter
      FieldName = 'AM_2'
    end
    object mdReportAM_3: TFloatField
      Alignment = taCenter
      FieldName = 'AM_3'
    end
    object mdReportAM_4: TFloatField
      Alignment = taCenter
      FieldName = 'AM_4'
    end
    object mdReportAM_5: TFloatField
      Alignment = taCenter
      FieldName = 'AM_5'
    end
    object mdReportAM_6: TFloatField
      Alignment = taCenter
      FieldName = 'AM_6'
    end
    object mdReportAM_7: TFloatField
      Alignment = taCenter
      FieldName = 'AM_7'
    end
    object mdReportAM_8: TFloatField
      Alignment = taCenter
      FieldName = 'AM_8'
    end
    object mdReportAM_9: TFloatField
      Alignment = taCenter
      FieldName = 'AM_9'
    end
    object mdReportAM_10: TFloatField
      Alignment = taCenter
      FieldName = 'AM_10'
    end
    object mdReportAM_11: TFloatField
      Alignment = taCenter
      FieldName = 'AM_11'
    end
    object mdReportAM_12: TFloatField
      Alignment = taCenter
      FieldName = 'AM_12'
    end
    object mdReportAM_13: TFloatField
      Alignment = taCenter
      FieldName = 'AM_13'
    end
    object mdReportAM_14: TFloatField
      Alignment = taCenter
      FieldName = 'AM_14'
    end
    object mdReportAM_15: TFloatField
      Alignment = taCenter
      FieldName = 'AM_15'
    end
    object mdReportAM_16: TFloatField
      Alignment = taCenter
      FieldName = 'AM_16'
    end
    object mdReportPH_1: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_1'
    end
    object mdReportPH_2: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_2'
    end
    object mdReportPH_3: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_3'
    end
    object mdReportPH_4: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_4'
    end
    object mdReportPH_5: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_5'
    end
    object mdReportPH_6: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_6'
    end
    object mdReportPH_7: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_7'
    end
    object mdReportPH_8: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_8'
    end
    object mdReportPH_9: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_9'
    end
    object mdReportPH_10: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_10'
    end
    object mdReportPH_11: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_11'
    end
    object mdReportPH_12: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_12'
    end
    object mdReportPH_13: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_13'
    end
    object mdReportPH_14: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_14'
    end
    object mdReportPH_15: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_15'
    end
    object mdReportPH_16: TIntegerField
      Alignment = taCenter
      FieldName = 'PH_16'
    end
  end
  object bm: TdxBarManager
    AllowCallFromAnotherForm = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = imgRep
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 304
    Top = 88
    DockControlHeights = (
      0
      0
      0
      0)
    object bmBarFiles: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'files'
      CaptionButtons = <>
      DockControl = dockFilesControl
      DockedDockControl = dockFilesControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 810
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btAddFiles'
        end
        item
          Visible = True
          ItemName = 'btDelFiles'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btClearFiles'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bmBarReports: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'reports'
      CaptionButtons = <>
      DockControl = dockReportControl
      DockedDockControl = dockReportControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 810
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btConstructReport'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btExportXLS'
        end
        item
          Visible = True
          ItemName = 'pbx'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object btAddFiles: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1072#1081#1083#1099
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1072#1081#1083#1099
      Visible = ivAlways
      ImageIndex = 0
      ShortCut = 45
      OnClick = btAddFilesClick
    end
    object btDelFiles: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083#1099
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083#1099
      Visible = ivAlways
      ImageIndex = 1
      ShortCut = 46
      OnClick = btDelFilesClick
    end
    object btClearFiles: TdxBarButton
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      Category = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      Visible = ivAlways
      ImageIndex = 2
      ShortCut = 16430
      OnClick = btClearFilesClick
    end
    object btConstructReport: TdxBarButton
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090
      Category = 0
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1077#1090' '#1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1092#1072#1081#1083#1072#1084
      Visible = ivAlways
      ImageIndex = 3
      OnClick = btConstructReportClick
    end
    object btExportXLS: TdxBarButton
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1069#1082#1089#1077#1083#1100
      Category = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1069#1082#1089#1077#1083#1100
      Visible = ivAlways
      OnClick = btExportXLSClick
    end
    object pbx: TcxBarEditItem
      Align = iaRight
      Category = 0
      Visible = ivNever
      Width = 100
      PropertiesClassName = 'TcxProgressBarProperties'
      Properties.Max = 100.000000000000000000
    end
  end
  object dsReport: TDataSource
    DataSet = mdReport
    Left = 368
    Top = 88
  end
  object imgRep: TcxImageList
    FormatVersion = 1
    DesignInfo = 7864624
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FFFFFF00FFFFFF000000000000FF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FFFFFF00FFFFFF000000000000FF
          FF0080808000FFFF000000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FFFFFF000000000000FF
          FF0080808000FFFF000000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FFFFFF000000000000FF
          FF0080808000FFFF0000FFFF0000000000000000000000000000000000000000
          000000000000000000000000000000000000FFFFFF00FFFFFF000000000000FF
          FF0080808000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
          00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF0000FFFF008080800080808000808080008080800080808000808080000000
          000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
          000000FF000000FF00000000000000000000FFFFFF00FFFFFF00FFFFFF000000
          000000000000000000000000000000000000000000000000000000FF000000FF
          000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF000000FF
          000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
          000000FF000000FF00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FFFFFF00FFFFFF000000000000FF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FFFFFF00FFFFFF000000000000FF
          FF0080808000FFFF000000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FFFFFF000000000000FF
          FF0080808000FFFF000000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FFFFFF000000000000FF
          FF0080808000FFFF0000FFFF0000000000000000000000000000000000000000
          000000000000000000000000000000000000FFFFFF00FFFFFF000000000000FF
          FF0080808000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF0000FFFF008080800080808000808080008080800080808000808080008080
          800000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
          00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
          00000000000000000000000000000000000000000000000000000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
          00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
          C000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0
          C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
          000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000000000000000
          000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000000000000000000C0C0C000C0C0
          C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C00000000000000000000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C00000000000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C0000000000000000000C0C0C000C0C0C000C0C0C000C0C0
          C000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C00000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
        MaskColor = clSilver
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00853719007E32
          18007A3115007A3115007A3115007A3115007A3115007A3115007A3115007A31
          15007A3115007A3115007A3115007A3115007E3317008A3A19006E2C1100FEF4
          E800FCEFE1006E6C6A00FEE8D000FEE3C8006E6C6A00FDDDBB00FDDDBB006E6C
          6A00FDD4AF00FDD0AF006E6C6A00FDD0AF00FDD0AF00773014006E2C1100FCED
          DD006E6C6A006E6C6A006E6C6A006E6C6A006E6C6A006E6C6A006E6C6A006E6C
          6A006E6C6A006E6C6A006E6C6A006E6C6A006E6C6A00762F13006E2C11006E6C
          6A006E6C6A00FEF2E6003459D0001938A000FDE9D4000B660B000B4C0B00FEE2
          C500AB7741007C3E3100FDDCB8004175C90029418E00762F13006E2C1100FEF4
          E8006E6C6A00FEF4E8003459D0001938A000FDE9D4000B660B000B4C0B00FEE2
          C500AB7741007C3E3100FDDCB8004175C90029418E00762F13006E2C11006E6C
          6A006E6C6A00FEF4E8003459D0001938A000FDE9D4000C670C000B4C0B00FEE2
          C500FCD8B300FCD8B300FDDCB8004175C90029418E00762F13006E2C1100FEF4
          E8006E6C6A00FEF4E8003459D0001938A000FDE9D4000D670D000B4C0B00FEE2
          C500FCD8B300FCD8B300FDDCB8004175C90029418E00762F13006E2C11006E6C
          6A006E6C6A00FEF4E8003459D0001938A000FDE9D4000D670D000B4C0B00FEE3
          C800FEE0C100FDDDBB00FDDCB800FDD6B000FDD6B000762F13006E2C1100FEF4
          E8006E6C6A00FEF4E800FEF4E800FEF2E600FDE9D4000D670D000B4C0B00FEE8
          D000FEE2C500FEE0C100FDDCB800FDD6B000FDD6B000752E12006F2C12006E6C
          6A006E6C6A00FEF4E800FEF4E800FEF2E600FDE9D400FDE9D400FDE9D400FDE9
          D400FEE6CC00FEE2C500FDDDBB00FDDAB500FDD6B0007E331700A14A1900CB89
          4600C6874700C6874700C6874700C6874700C6874700C6874700C6874700C989
          4800CC8C4B00CB8C4A00CC8C4B00CB8C4A00CB8C4A00A14A190096421900CA67
          1B00CA671B00CA671B00CA671B00CA671B00CA671B00CA671B00CA671B00CA67
          1B00CC8C4B00CA671B00CC8C4B009F763E003055CB00A74D1800FF00FF009240
          1900924019009240190092401900924019009240190092401900924019009642
          19009C461900924019009C4619008A3A1900873C2300FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
  object pm: TcxGridPopupMenu
    Grid = grReport
    PopupMenus = <>
    Left = 336
    Top = 120
  end
  object oDlg: TOpenDialog
    DefaultExt = '*.dar'
    Filter = #1060#1072#1081#1083#1099' '#1076#1072#1085#1085#1099#1093' Ariel (*.dar)|*.dar'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = #1060#1072#1081#1083#1099' '#1076#1072#1085#1085#1099#1093
    Left = 304
    Top = 152
  end
  object sDlg: TSaveDialog
    DefaultExt = '*.xls'
    Filter = #1060#1072#1081#1083#1099' Excel (*.xls)|*.xls'
    Title = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1069#1082#1089#1077#1083#1100
    Left = 336
    Top = 152
  end
  object mdFiles: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 32
    Top = 168
    object mdFilesFILE_PATH: TStringField
      FieldName = 'FILE_PATH'
      Size = 250
    end
    object mdFilesFILE_NAME: TStringField
      FieldName = 'FILE_NAME'
      Size = 64
    end
  end
  object dsFiles: TDataSource
    DataSet = mdFiles
    Left = 64
    Top = 168
  end
end
