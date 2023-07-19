object fmMainAriel: TfmMainAriel
  Left = 0
  Top = 0
  ActiveControl = grParams
  Caption = 'Ariel'
  ClientHeight = 522
  ClientWidth = 1046
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object stBar: TdxStatusBar
    Left = 0
    Top = 502
    Width = 1046
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = #1056#1072#1084#1082#1072':'
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taCenter
        Text = '0'
        Width = 100
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Fixed = False
      end
      item
        PanelStyleClassName = 'TdxStatusBarStateIndicatorPanelStyle'
        PanelStyle.Indicators = <
          item
          end
          item
            IndicatorType = sitPurple
          end>
      end>
    PaintStyle = stpsUseLookAndFeel
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object pnlControl: TPanel
    Left = 742
    Top = 49
    Width = 304
    Height = 453
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 0
    ExplicitHeight = 502
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 304
      Height = 26
      Align = dalTop
      BarManager = bmMenu
    end
    object grParams: TcxGrid
      AlignWithMargins = True
      Left = 2
      Top = 133
      Width = 300
      Height = 318
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      TabOrder = 1
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      object tvParams: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = tvParamsCellClick
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.Data = {
          330200000F00000044617461436F6E74726F6C6C657231060000001300000054
          6378496E746567657256616C75655479706513000000546378496E7465676572
          56616C75655479706511000000546378466C6F617456616C7565547970651300
          0000546378496E746567657256616C75655479706513000000546378496E7465
          67657256616C75655479706513000000546378496E746567657256616C756554
          79706510000000445855464D5400000100000001010100000000000000000000
          445855464D5400000200000001010100000000000000000000445855464D5400
          000300000001010100010000000000000000445855464D540000040000000101
          0100000000000001000000445855464D54000005000000010101000000000000
          00000000445855464D5400000600000001010100000000000000000000445855
          464D5400000700000001010100010000000000000000445855464D5400000800
          000001010100000000000001000000445855464D540000090000000101010000
          0000000000000000445855464D5400000A000000010101000000000000000000
          00445855464D5400000B00000001010100010000000000000000445855464D54
          00000C00000001010100000000000001000000445855464D5400000D00000001
          010100000000000000000000445855464D5400000E0000000101010000000000
          0000000000445855464D5400000F000000010101000100000000000000004458
          55464D5400001000000001010100000000000001000000}
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object tvParamsColumn1: TcxGridColumn
          Caption = 'Channel'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
        end
        object tvParamsColumn2: TcxGridColumn
          Caption = 'Frequency'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
        end
        object tvParamsColumn3: TcxGridColumn
          Caption = 'Amplitude'
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
        end
        object tvParamsColumn4: TcxGridColumn
          Caption = 'Phase'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
        end
        object tvParamsColumn5: TcxGridColumn
          Caption = #1040#1073#1089
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object tvParamsColumn6: TcxGridColumn
          Caption = #1040#1082#1090'.'
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object lvParams: TcxGridLevel
        GridView = tvParams
      end
    end
    object grDefects: TcxGrid
      AlignWithMargins = True
      Left = 2
      Top = 28
      Width = 300
      Height = 103
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 2
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      object tvDefects: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = tvDefectsCellClick
        DataController.DataSource = dsDefects
        DataController.KeyFieldNames = 'ID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.HeaderEndEllipsis = True
        OptionsView.Indicator = True
        object tvDefectsPOSITION: TcxGridDBColumn
          Caption = 'Position, mm'
          DataBinding.FieldName = 'POSITION'
        end
        object tvDefectsVolume: TcxGridDBColumn
          DataBinding.FieldName = 'Volume'
        end
        object tvDefectsANGLE: TcxGridDBColumn
          Caption = 'Orientation'
          DataBinding.FieldName = 'ANGLE'
        end
        object tvDefectsQUALITY: TcxGridDBColumn
          DataBinding.FieldName = 'QUALITY'
          Visible = False
          VisibleForCustomization = False
        end
        object tvDefectsCOLOR: TcxGridDBColumn
          Caption = 'Result'
          DataBinding.FieldName = 'COLOR'
          PropertiesClassName = 'TcxColorComboBoxProperties'
          Properties.CustomColors = <>
          Properties.ShowDescriptions = False
        end
        object tvDefectsCMNT: TcxGridDBColumn
          Caption = 'Channel'
          DataBinding.FieldName = 'CMNT'
          Width = 120
        end
        object tvDefectsDTYPE: TcxGridDBColumn
          Caption = 'Surface position'
          DataBinding.FieldName = 'DTYPE'
          Width = 70
        end
      end
      object lvDefects: TcxGridLevel
        GridView = tvDefects
      end
    end
  end
  object pnlOneCh: TPanel
    Left = 0
    Top = 49
    Width = 742
    Height = 453
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    OnResize = pnlOneChResize
    object pnlOneFull: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 348
      Width = 740
      Height = 104
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      OnResize = pnlOneFullResize
      object chOneFullIm: TChart
        AlignWithMargins = True
        Left = 0
        Top = 52
        Width = 740
        Height = 52
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 0
        AllowPanning = pmNone
        Legend.Visible = False
        MarginBottom = 0
        MarginLeft = 0
        MarginRight = 0
        MarginTop = 0
        Title.Alignment = taLeftJustify
        Title.Font.Color = clLime
        Title.Text.Strings = (
          'Full signal Im(U), V')
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMaximum = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Axis.Color = clGray
        BottomAxis.Grid.Visible = False
        BottomAxis.Labels = False
        BottomAxis.Maximum = 100.000000000000000000
        BottomAxis.MinorTicks.Visible = False
        BottomAxis.PositionPercent = 50.000000000000000000
        BottomAxis.Ticks.Visible = False
        BottomAxis.TicksInner.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Axis.Color = clGray
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsAngle = 90
        LeftAxis.LabelsFont.Color = clAqua
        LeftAxis.Maximum = 10.000000000000000000
        LeftAxis.Minimum = -10.000000000000000000
        LeftAxis.MinorTicks.Visible = False
        LeftAxis.TicksInner.Visible = False
        View3D = False
        Zoom.Allow = False
        OnBeforeDrawAxes = chOneFullReBeforeDrawAxes
        Align = alClient
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 0
        OnMouseDown = chOneFullReMouseDown
        OnMouseMove = chOneFullReMouseMove
        OnMouseUp = chOneFullReMouseUp
        ColorPaletteIndex = 13
        object seriesOneFullIm: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clYellow
          LinePen.Color = clYellow
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
      object chOneFullRe: TChart
        Left = 0
        Top = 0
        Width = 740
        Height = 51
        AllowPanning = pmNone
        Legend.Visible = False
        MarginBottom = 0
        MarginLeft = 0
        MarginRight = 0
        MarginTop = 0
        Title.Alignment = taLeftJustify
        Title.Font.Color = clLime
        Title.Text.Strings = (
          'Full signal Re(U), V')
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMaximum = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Axis.Color = clGray
        BottomAxis.Grid.Visible = False
        BottomAxis.Labels = False
        BottomAxis.Maximum = 100.000000000000000000
        BottomAxis.MinorTicks.Visible = False
        BottomAxis.PositionPercent = 50.000000000000000000
        BottomAxis.Ticks.Visible = False
        BottomAxis.TicksInner.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Axis.Color = clGray
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsAngle = 90
        LeftAxis.LabelsFont.Color = clAqua
        LeftAxis.Maximum = 10.000000000000000000
        LeftAxis.Minimum = -10.000000000000000000
        LeftAxis.MinorTicks.Visible = False
        LeftAxis.TicksInner.Visible = False
        View3D = False
        Zoom.Allow = False
        OnBeforeDrawAxes = chOneFullReBeforeDrawAxes
        Align = alTop
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 1
        OnMouseDown = chOneFullReMouseDown
        OnMouseMove = chOneFullReMouseMove
        OnMouseUp = chOneFullReMouseUp
        ColorPaletteIndex = 13
        object seriesOneFullRe: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clYellow
          LinePen.Color = clYellow
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object pnlOneGraph: TPanel
      Left = 0
      Top = 0
      Width = 742
      Height = 320
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      OnResize = pnlOneGraphResize
      object pnlOneReIm: TPanel
        AlignWithMargins = True
        Left = 1
        Top = 1
        Width = 403
        Height = 318
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        OnResize = pnlOneReImResize
        object chOneIm: TChart
          AlignWithMargins = True
          Left = 0
          Top = 129
          Width = 403
          Height = 189
          Margins.Left = 0
          Margins.Top = 1
          Margins.Right = 0
          Margins.Bottom = 0
          AllowPanning = pmNone
          Legend.Visible = False
          MarginBottom = 0
          MarginLeft = 0
          MarginRight = 0
          MarginTop = 0
          Title.Alignment = taLeftJustify
          Title.Font.Color = clLime
          Title.Text.Strings = (
            'Im(U), V')
          BottomAxis.Automatic = False
          BottomAxis.AutomaticMaximum = False
          BottomAxis.AutomaticMinimum = False
          BottomAxis.Axis.Color = clGray
          BottomAxis.Grid.Visible = False
          BottomAxis.Labels = False
          BottomAxis.Maximum = 100.000000000000000000
          BottomAxis.MinorTicks.Visible = False
          BottomAxis.PositionPercent = 50.000000000000000000
          BottomAxis.Ticks.Visible = False
          BottomAxis.TicksInner.Visible = False
          LeftAxis.Automatic = False
          LeftAxis.AutomaticMaximum = False
          LeftAxis.AutomaticMinimum = False
          LeftAxis.Axis.Color = clGray
          LeftAxis.Grid.Visible = False
          LeftAxis.LabelsAngle = 90
          LeftAxis.LabelsFont.Color = clAqua
          LeftAxis.Maximum = 10.000000000000000000
          LeftAxis.Minimum = -10.000000000000000000
          LeftAxis.MinorTicks.Visible = False
          LeftAxis.TicksInner.Visible = False
          View3D = False
          Zoom.Allow = False
          OnBeforeDrawAxes = chOneReBeforeDrawAxes
          Align = alClient
          BevelOuter = bvNone
          Color = clBlack
          TabOrder = 0
          OnMouseDown = chOneReMouseDown
          OnMouseMove = chOneReMouseMove
          OnMouseUp = chOneReMouseUp
          ColorPaletteIndex = 13
          object seriesOneIm: TFastLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            SeriesColor = clYellow
            LinePen.Color = clYellow
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object seriesOnePointsIm: TPointSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            ClickableLine = False
            Pointer.Brush.Gradient.EndColor = 10708548
            Pointer.Gradient.EndColor = 10708548
            Pointer.HorizSize = 5
            Pointer.InflateMargins = True
            Pointer.Pen.Visible = False
            Pointer.Style = psCircle
            Pointer.VertSize = 5
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loNone
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
        object chOneRe: TChart
          Left = 0
          Top = 0
          Width = 403
          Height = 128
          AllowPanning = pmNone
          Legend.Visible = False
          MarginBottom = 0
          MarginLeft = 0
          MarginRight = 0
          MarginTop = 0
          Title.Alignment = taLeftJustify
          Title.Font.Color = clLime
          Title.Text.Strings = (
            'Re(U), V')
          BottomAxis.Automatic = False
          BottomAxis.AutomaticMaximum = False
          BottomAxis.AutomaticMinimum = False
          BottomAxis.Axis.Color = clGray
          BottomAxis.Grid.Visible = False
          BottomAxis.Labels = False
          BottomAxis.Maximum = 100.000000000000000000
          BottomAxis.MinorTicks.Visible = False
          BottomAxis.PositionPercent = 50.000000000000000000
          BottomAxis.Ticks.Visible = False
          BottomAxis.TicksInner.Visible = False
          BottomAxis.TickOnLabelsOnly = False
          LeftAxis.Automatic = False
          LeftAxis.AutomaticMaximum = False
          LeftAxis.AutomaticMinimum = False
          LeftAxis.Axis.Color = clGray
          LeftAxis.Grid.Visible = False
          LeftAxis.LabelsAngle = 90
          LeftAxis.LabelsFont.Color = clAqua
          LeftAxis.Maximum = 10.000000000000000000
          LeftAxis.Minimum = -10.000000000000000000
          LeftAxis.MinorTicks.Visible = False
          LeftAxis.TicksInner.Visible = False
          View3D = False
          Zoom.Allow = False
          OnBeforeDrawAxes = chOneReBeforeDrawAxes
          Align = alTop
          BevelOuter = bvNone
          Color = clBlack
          TabOrder = 1
          OnMouseDown = chOneReMouseDown
          OnMouseMove = chOneReMouseMove
          OnMouseUp = chOneReMouseUp
          ColorPaletteIndex = 13
          object seriesOneRe: TFastLineSeries
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            SeriesColor = clYellow
            LinePen.Color = clYellow
            XValues.Name = 'X'
            XValues.Order = loAscending
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
          object seriesOnePointsRe: TPointSeries
            ColorEachPoint = True
            Marks.Arrow.Visible = True
            Marks.Callout.Brush.Color = clBlack
            Marks.Callout.Arrow.Visible = True
            Marks.Visible = False
            ClickableLine = False
            Pointer.Brush.Gradient.EndColor = 11842740
            Pointer.Gradient.EndColor = 11842740
            Pointer.HorizSize = 5
            Pointer.InflateMargins = True
            Pointer.Pen.Visible = False
            Pointer.Style = psCircle
            Pointer.VertSize = 5
            Pointer.Visible = True
            XValues.Name = 'X'
            XValues.Order = loNone
            YValues.Name = 'Y'
            YValues.Order = loNone
          end
        end
      end
      object chOneGod: TChart
        AlignWithMargins = True
        Left = 406
        Top = 1
        Width = 335
        Height = 318
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        AllowPanning = pmNone
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
        BottomAxis.Axis.Color = clGray
        BottomAxis.LabelsFont.Color = clAqua
        BottomAxis.Maximum = 10.000000000000000000
        BottomAxis.Minimum = -10.000000000000000000
        BottomAxis.MinorTicks.Visible = False
        BottomAxis.TicksInner.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Axis.Color = clGray
        LeftAxis.LabelsAngle = 90
        LeftAxis.LabelsFont.Color = clAqua
        LeftAxis.Maximum = 10.000000000000000000
        LeftAxis.Minimum = -10.000000000000000000
        LeftAxis.MinorTicks.Visible = False
        LeftAxis.TicksInner.Visible = False
        View3D = False
        Zoom.Allow = False
        Align = alRight
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 1
        ColorPaletteIndex = 13
        object seriesOneGod: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          SeriesColor = clYellow
          LinePen.Color = clYellow
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
        object seriesOnePointsGod: TPointSeries
          ColorEachPoint = True
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          ClickableLine = False
          Pointer.Brush.Gradient.EndColor = 11842740
          Pointer.Gradient.EndColor = 11842740
          Pointer.HorizSize = 5
          Pointer.InflateMargins = True
          Pointer.Pen.Visible = False
          Pointer.Style = psCircle
          Pointer.VertSize = 5
          Pointer.Visible = True
          XValues.Name = 'X'
          XValues.Order = loNone
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
    object pnlGraphData: TPanel
      Left = 0
      Top = 320
      Width = 742
      Height = 27
      Align = alBottom
      BevelOuter = bvNone
      Color = clBlack
      ParentBackground = False
      TabOrder = 2
      Visible = False
    end
  end
  object bmMenu: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      'File'
      'Help'
      'Processing'
      'View')
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True)
    ImageOptions.Images = imgs
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 328
    Top = 80
    DockControlHeights = (
      0
      0
      49
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Menu'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 452
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem3'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem6'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem4'
        end>
      MultiLine = True
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Tools'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 23
      DockingStyle = dsTop
      FloatLeft = 452
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btPrev'
        end
        item
          Visible = True
          ItemName = 'lbFilePos'
        end
        item
          Visible = True
          ItemName = 'btNext'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'cbView'
        end
        item
          Visible = True
          ItemName = 'cbType'
        end
        item
          Visible = True
          ItemName = 'cbChannel'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btProcessed'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          Visible = True
          ItemName = 'lbAmp'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 1
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bmMenuBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'OneChannel'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 908
      FloatTop = 224
      FloatClientWidth = 51
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btCalibStart'
        end
        item
          Visible = True
          ItemName = 'btCalib'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btCheck'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btCalibTestDevice'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'Operations'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btCalibStart'
        end
        item
          Visible = True
          ItemName = 'btCalib'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btCheck'
        end
        item
          Visible = True
          ItemName = 'btCalibTestDevice'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = 'File'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'btSaveText'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btPrev'
        end
        item
          Visible = True
          ItemName = 'btNext'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton6'
        end>
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = 'Help'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end>
    end
    object dxBarSubItem6: TdxBarSubItem
      Caption = 'View'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btViewParams'
        end
        item
          Visible = True
          ItemName = 'btProcessed'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end>
    end
    object dxBarButton4: TdxBarButton
      Action = actOpen
      Caption = 'Open'
      Category = 1
    end
    object dxBarButton6: TdxBarButton
      Action = actExit
      Caption = 'Exit'
      Category = 1
    end
    object btSaveText: TdxBarButton
      Action = actSaveText
      Caption = 'Save as text'
      Category = 1
    end
    object btPrev: TdxBarButton
      Action = actPrevFile
      Caption = 'Previous file'
      Category = 1
    end
    object btNext: TdxBarButton
      Action = actNextFile
      Caption = 'Next file'
      Category = 1
    end
    object lbFilePos: TdxBarStatic
      Caption = '0 / 0'
      Category = 1
      Hint = #1055#1086#1083#1086#1078#1077#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1092#1072#1081#1083#1072' '#1074' '#1089#1087#1080#1089#1082#1077' '#1092#1072#1081#1083#1086#1074' '#1074' '#1090#1077#1082#1091#1097#1077#1081' '#1087#1072#1087#1082#1077
      Visible = ivAlways
      BorderStyle = sbsLowered
      Width = 70
    end
    object dxBarButton10: TdxBarButton
      Action = actAbout
      Caption = 'About'
      Category = 2
    end
    object dxBarButton1: TdxBarButton
      Action = actAmplificationDown
      Category = 3
    end
    object dxBarButton5: TdxBarButton
      Action = actAmplificationUp
      Category = 3
    end
    object btCalibTestDevice: TdxBarButton
      Action = actTestDevice
      Caption = 'Check device'
      Category = 3
    end
    object lbAmp: TdxBarStatic
      Caption = 'Amp.: 10 V'
      Category = 3
      Hint = 'Amp.: 10 V'
      Visible = ivAlways
      BorderStyle = sbsEtched
    end
    object btCalib: TdxBarButton
      Action = actCalib
      Caption = 'Calibrate'
      Category = 3
    end
    object dxBarButton8: TdxBarButton
      Action = actSaveParams
      Caption = 'Save parameters'
      Category = 3
    end
    object btCalibStart: TdxBarButton
      Action = actCalibStart
      Caption = 'Start calibration'
      Category = 3
    end
    object btCheck: TdxBarButton
      Action = actCalibCheck
      Caption = 'Check calibration'
      Category = 3
    end
    object dxBarButton2: TdxBarButton
      Action = actReport
      Caption = 'View report'
      Category = 3
    end
    object btProcessed: TdxBarButton
      Action = actProcessed
      Caption = 'Processed'
      Category = 4
      ButtonStyle = bsChecked
    end
    object btViewParams: TdxBarButton
      Action = actViewSettings
      Caption = 'Acquire settings'
      Category = 4
    end
    object cbView: TdxBarCombo
      Action = actView
      Category = 4
      ShowCaption = True
      Text = #1054#1076#1080#1085' '#1082#1072#1085#1072#1083
      ShowEditor = False
      Items.Strings = (
        #1054#1076#1080#1085' '#1082#1072#1085#1072#1083
        #1042#1089#1077' '#1082#1072#1085#1072#1083#1099)
      ItemIndex = 0
    end
    object cbChannel: TdxBarCombo
      Action = actChannel
      Category = 4
      ShowCaption = True
      Width = 50
      Text = '1'
      ShowEditor = False
      Items.Strings = (
        '1'
        '2'
        '3'
        '4')
      ItemIndex = 0
    end
    object cbType: TdxBarCombo
      Action = actType
      Category = 4
      ShowCaption = True
      Width = 150
      Text = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1099' (Re, Im)'
      ShowEditor = False
      Items.Strings = (
        #1050#1086#1084#1087#1086#1085#1077#1085#1090#1099' (Re, Im)'
        #1040#1084#1087#1083#1080#1090#1091#1076#1072' '#1080' '#1092#1072#1079#1072)
      ItemIndex = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actProcCalibration
      Category = 4
      ButtonStyle = bsChecked
    end
    object dxBarButton7: TdxBarButton
      Action = actProcProduction
      Category = 4
      ButtonStyle = bsChecked
    end
  end
  object imgs: TcxImageList
    FormatVersion = 1
    DesignInfo = 5243248
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0000000000000000000000000000000000FF000000FF000000FF000000FF00
          000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
          0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFF
          FF0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          0000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF0000000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF0000000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF00
          0000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF0000000000FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF000000
          0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFF
          FF0000000000000000000000000000000000FF000000FF000000FF000000FF00
          000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF0000000000FF000000FF000000FF000000FF00
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF000274
          AC000274AC000274AC000274AC000274AC000274AC000274AC000274AC000274
          AC000274AC000274AC000274AC000274AC00FF00FF00FF00FF000274AC001489
          BB0041B6E20065D3F8004EC2F1004EC2F1004EC2F1004EC2F1004EC2F1004EC2
          F1004EC2F1004EC2F1002399C8000274AC00FF00FF00FF00FF000274AC0035AC
          D7001F94C40077E1FA0054C7F60054C7F60054C7F60054C7F60054C7F60054C7
          F60054C7F60054C7F600279DCB0065D3F8000274AC00FF00FF000274AC0058CA
          F7000274AC0098F4FC005FD0F8005FD0F8005FD0F8005FD0F8005FD0F8005FD0
          F8005FD0F8005FD0F80029A0CE0098F4FC000274AC00FF00FF000274AC005FD0
          F8000C7FB40075DFF90077E1FA006DDAF9006DDAF9006DDAF9006DDAF9006DDA
          F9006DDAF9006DDAF9002DA4D100A2F5FC000274AC00FF00FF000274AC006DDA
          F9002DA4D1003BB1DC0098F4FC0078E5FA0078E5FA0078E5FA0078E5FA0078E5
          FA0078E5FA0004640B0031A8D400A2F5FC0048BDEA000274AC000274AC0071DD
          F9005FD0F8000C7FB400CDF3F900B4F5FC00BDF5FC00BDF5FC00BDF5FC00B4F5
          FC0004640B0021AA420004640B00CDF3F900CAF2F8000274AC000274AC007EEB
          FB007EEBFB000C7FB4000274AC000274AC000274AC000274AC000274AC000464
          0B0024AF680024AF680023AD4F0004640B000274AC000274AC000274AC0086F1
          FC0087F3FC0087F3FC0086F1FC0087F3FC0087F3FC0086F1FC0004640B0023AD
          4F0024AF680024AF680024AF680023AD4F0004640B00FF00FF000274AC00CDF3
          F9008AF3FC008AF3FC008AF3FC008AF3FC008AF3FC0004640B0004640B000464
          0B0004640B0024AF680023AD4F0004640B0004640B0004640B00FF00FF000274
          AC00CDF3F9008EF4FC008EF4FC008EF4FC000274AB002DA4D1002DA4D1002DA4
          D10004640B0022AB610020A83C0004640B00FF00FF00FF00FF00FF00FF00FF00
          FF000274AC000274AC000274AC000274AC00FF00FF00FF00FF00FF00FF00FF00
          FF0004640B0023AD4F0004640B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000464
          0B001BA233001BA2330004640B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000464
          0B001BA2330004640B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004640B0004640B000464
          0B0004640B00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0004640B0004640B0004640B0004640B00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF00008080000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF00008080000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000000000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF00008080000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF00008080000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF00008080000000
          0000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C0000000000000FFFF0000FFFF000080
          800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C0000000000000000000C0C0C0000000000000FFFF0000FF
          FF000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C0000000000000FFFF000080800000000000C0C0C0000000000000FF
          FF0000FFFF000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C0000000000000FFFF000080800000000000C0C0C000C0C0C0000000
          000000FFFF000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C0000000000000FFFF0000FFFF0000808000000000000000000000FF
          FF0000FFFF000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
          FF000080800000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
          000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000}
        MaskColor = clSilver
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF000000000000FF000000FF000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF000000000000FF000000FF000000FF000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF000000000000FF000000FF000000FF000000FF000000000000000000000000
          0000000000000000000000000000000000000000000000000000FFFFFF000000
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000FFFFFF000000
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000FFFFFF00FFFF
          FF000000000000FF000000FF000000FF000000FF000000000000000000000000
          0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF000000000000FF000000FF000000FF000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF000000000000FF000000FF000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF000000000000FF000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          000000FF000000FF000000FF000000000000FFFFFF00FFFFFF000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000000000FFFFFF000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
          000000FF000000FF000000FF000000FF000000000000FFFFFF00000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          000000FF000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          000000FF000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          000000FF000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FF
          000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        MaskColor = clWhite
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A369
          5E008F5D58008F5D58008F5D58008F5D58008F5D58008F5D58008F5D58008F5D
          58008F5D58008F5D58008F5D58007F534C00FF00FF00FF00FF00FF00FF00A369
          5E00F7E9DA00E8D7BC00E4D5B200E4D0A600E3CC9F00E2C69200E2C48D00D8BD
          8400D8BD8400D8BD8400E2C48D007F534C00FF00FF00FF00FF00FF00FF009F66
          5C00F9EDDF00EEE0CB00E8D7BC00E4D5B200D9BF8700006F0000006F0000D2AF
          7A00D8BD8400D8BD8400E2C48D007F534C00FF00FF00FF00FF00FF00FF009F66
          5C00FAF0E400F2E5D400006F0000E1C89700006F0000D9BF8700D8BD8400006F
          0000D2AF7A00D9BF8700E2C48D007F534C00FF00FF00FF00FF00FF00FF00AE75
          6800FCF7F200F7E9DA00006F0000006F0000E1C89700E4D5B200E5D1A900D8BD
          8400006F0000E2C48D00E2C48D007F534C00FF00FF00FF00FF00FF00FF00AE75
          6800FEFEFD00FAF0E400006F0000006F0000006F0000E8D7BC00E4D5B200E4D0
          A600E4CA9B00E2C69200E2C48D007F534C00FF00FF00FF00FF00FF00FF00B07A
          6B00FEFEFD00FCF7F200FAF0E400F7E9DA00F2E5D400EEE0CB00006F0000006F
          0000006F0000E3CC9F00E4CA9B007F534C00FF00FF00FF00FF00FF00FF00B07A
          6B00FEFEFD00FEFEFD00006F0000E8D7BC00F7E9DA00F2E5D400E2CEA200006F
          0000006F0000E4D0A600E7D2AB007F534C00FF00FF00FF00FF00FF00FF00D49C
          6C00FEFEFD00FEFEFD00EEE0CB00006F0000E6D6B700E4D5B200006F0000E3CC
          9F00006F0000E4D5B200E4D0A6007F534C00FF00FF00FF00FF00FF00FF00D49C
          6C00FEFEFD00FEFEFD00FEFEFD00EEE0CB00006F0000006F0000E4D5B200F2E5
          D400F7E9DA00E4D5B200A0A0A0007F534C00FF00FF00FF00FF00FF00FF00D5A0
          7400FEFEFD00FEFEFD00FEFEFD00FEFEFD00FEFEFD00FBF6F000FAF2E900EEE0
          CB009F665C009F665C009F665C009F665C00FF00FF00FF00FF00FF00FF00D5A0
          7400FEFEFD00FEFEFD00FEFEFD00FEFEFD00FEFEFD00FEFDFB00FEFDFB00E6D6
          B7009F665C00D49C6C00D49C6C00A86E6100FF00FF00FF00FF00FF00FF00D2A9
          7800FEFEFD00FEFEFD00FEFEFD00FEFEFD00FEFEFD00FEFEFD00FEFEFD00E8D7
          BC009F665C00D6B47D00B07A6B00FF00FF00FF00FF00FF00FF00FF00FF00D2A9
          7800FBF6F000FBF5EE00FAF4EC00FAF4EC00FAF4EC00FAF4EC00FAF4EC00E8D7
          BC009F665C00AF7B6D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D2A9
          7800D49C6C00D49C6C00D49C6C00D49C6C00D49C6C00D49C6C00D49C6C00D49C
          6C009F665C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000002880002089300010B9A00010B9A000208
          930000028900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000028800010B9A00011CB200011DB300011CB500011CB500011D
          B300011CB2000111A50000028800FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000038B000119AF00011CB600011DB300011DB300011DB300011DB300011D
          B300011DB300011DB3000119AF0000048C00FF00FF00FF00FF00FF00FF000002
          8800031CBB00031ECD00031DBF000115AC00011AB000011DB300011DB300011C
          B2000115AC00011BB100011DB300011AB00000028800FF00FF00FF00FF000111
          A500031FDD00031ED200031ECD003857ED001322B7000119AF000119AF00011D
          B3002D47D0001322B700011BB100011CB5000111A500FF00FF0000028800031F
          DD00031FED00031FDD003655EE00FBFCFC00A6B7F800031CBB000119AF008B9F
          F800FBFCFC002D47D0000115AC00011DB300011CB20000028900010B9A000220
          F3000320F400031FE700031EE300818DF900FBFCFC00A0B2F80092A6F600FBFC
          FC008FA4F600011DB300011BB100011DB300011DB300020893000113A9000523
          F5000523F5000320F400031FED00031EE300818DF900FBFCFC00FBFCFC0095A9
          F700011CB5000119AF00011DB300011DB300011CB500010B9A000115AC002F4E
          EF000523F5000320F4000320F400031FED008EA2F700FBFCFC00FBFCFC00A6B7
          F800041EC300011CB600011DB300011DB300011CB500010B9A00010B9A003857
          ED002F4EEF000320F4000523F5008B9FF800FBFCFC008FA4F6008291F900FBFC
          FC00A0B2F800031EC800011CB800011DB300011DB30002089300000289002F4E
          EF008291F9000523F5003454EF00FBFCFC0092A6F6000220F300031FE700818D
          F900FBFCFC003857ED00031DBF00031DBF00011CB20000028800FF00FF00031C
          BB008798F900818DF9000523F5003656EF000523F5000320F4000320F400031F
          ED003453EB00031FDD00031ED200031ECD000111A500FF00FF00FF00FF000002
          89002E4AE400A6B7F8008798F9002F4EEF000523F5000320F4000320F4000320
          F400031FED00031FE700031EE300031DBF0000028800FF00FF00FF00FF00FF00
          FF0001058F002E4AE40095A9F700AABAF800818DF9003857ED003656EF003352
          EF002F4EEF000523F500031ECD0000038B00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000028900031DBF003857ED008288F900818DF9008881F9003857
          ED000320EA00011CB50000028800FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000289000111A5000115AC000115AC00010B
          9A0000028800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00C867
          0300FDEFDD00FCEEDC00FBEDDB009C360000FBEDDB00FBEDDB00FBEDDB009C36
          0000FCEEDC00FCEEDC00FBEDDB00C8670300FF00FF00FF00FF00FF00FF00C867
          0300FDF1E000FDF0DE00FDEFDD009C360000FDEFDD00FDEFDD00FBEDDB009C36
          0000FDF1E000FDF0DE00FDEFDD00C8670300FF00FF00FF00FF00FF00FF00C867
          0300FEF4E600FEF3E400FEF2E2009C360000FDF1E000FDF0DE00FDF0DE009C36
          0000FEF4E600FEF3E400FEF1E100C8670300FF00FF00FF00FF00FF00FF00C867
          0300FEF6EC00FEF6EC00FEF5E9009C360000FEF3E400FEF2E200FEF2E2009C36
          0000FEF6EC00FEF5E900FEF4E600C8670300FF00FF00FF00FF00FF00FF00C867
          0300FEF9F200FEF8F000FEF7EE009C360000FEF5E900FEF4E600FEF4E6009C36
          0000FEF9F200FEF8F000FEF7EE00C8670300FF00FF00FF00FF00FF00FF00C867
          0300FEFBF800FEFAF500FEFAF4009C360000FEF7EE00FEF6EC00FEF6EC009C36
          0000FEFBF700FEFBF600FEFAF400C8670300FF00FF00FF00FF00FF00FF00C867
          0300FEFCFA00FEFCFA00FEFCF8009C360000FEF9F200FEF8F000FEF8F0009C36
          0000FEFCFA00FEFCFA00FEFCF800C8670300FF00FF00FF00FF00FF00FF00C867
          0300FEFCFA00FEFCFA00FEFCFA009C360000FEFAF500FEFBF600FEFAF4009C36
          0000FEFCFA00FEFCFA00FEFCFA00C8670300FF00FF00FF00FF00FF00FF00C867
          0300C8670300C8670300C86703009C360000FEFCFA00FEFCF900FEFCF8009C36
          0000C8670300C8670300C8670300C8670300FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF009C360000FEFCFA00FEFCFA00FEFCFA009C36
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF009C360000FEFCFA00FEFCFA00FEFCFA009C36
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00C8670300C8670300C8670300C8670300C867
          0300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00046104000461040004610400046104000461
          0400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0004610400C7D9A10004610400FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004610400FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00056695000566
          9500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0005669500056695000566
          950005669500056695000566950005669500FF00FF00FF00FF00056695004A9F
          C7000C6F9F00FF00FF0022282A00FF00FF0022282A00155D9B00A1D2E600A1D2
          E6000564920059A9CF00B3D9E60005669500FF00FF00FF00FF00056695007EC0
          DE003F96BF004D4C52003D474F002E434D002E434D001E7DAB00B3D9E600B3D9
          E600056492007EC0DE00B3D9E60005669500FF00FF00FF00FF0005669500A1D2
          E6000566950022282A00FF00FF0022282A00FF00FF000769980064B0D5000566
          950005649200056695007EC0DE0005669500FF00FF00FF00FF00056695000564
          9200FF00FF00FF00FF00FF00FF00FF00FF001576A6004A9FC70005669500FF00
          FF00FF00FF00FF00FF00056695004A9FC70005669500FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005669500A1D2E60005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005669500A1D2E60005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005669500B3D9E60005669500FF00FF00A46C
          6900A46C6900A46C6900FF00FF0003659500B3D9E60005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005669500B3D9E60005669500FF00FF00A46C
          6900DBA98000A46C6900FF00FF0003659500B3D9E60005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005669500A1D2E60005669500FF00FF00A46C
          6900DBA98000A46C6900FF00FF0003659500B3D9E60005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0005669500B3D9E60005669500FF00FF00AC73
          6B00B3D9E600A46C6900FF00FF0003659500B3D9E60005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000566950059A9CF0005669500FF00FF00BB80
          6F00B3D9E600A46C6900FF00FF00076998007EC0DE0005669500FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000566950005669500FF00FF00CE96
          7600B3D9E600A46C6900FF00FF0005679600086B9A00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00D59F
          7900B3D9E600A46C6900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00DCA8
          7F00B4796D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CE96
          7600FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00004B0000004B0000949A8500949A8500949A8500949A8500949A8500949A
          8500949A8500004B0000004B0000FF00FF00FF00FF00FF00FF00FF00FF00004B
          00000080000000800000D9D4D800004B0000004B0000DFDFE000DCDADC00D9D6
          D800BEBCBD00004B0000005F0000004B0000FF00FF00FF00FF00FF00FF00004B
          00000080000000800000DBD9DA00004B0000004B0000D9D8D900DFDFE000DBD9
          DA00BFBDBF00004B0000005F0000004B0000FF00FF00FF00FF00FF00FF00004B
          00000080000000800000DDDCDE00004B0000004B0000D9D4D800DFDFE000DDDC
          DE00BFBEBF00004B0000005F0000004B0000FF00FF00FF00FF00FF00FF00004B
          00000080000000800000DFDFE000DDDCDE00D9D4D800D9D4D800D9D8D900D9D8
          D900BFBEBF00004B0000005F0000004B0000FF00FF00FF00FF00FF00FF00004B
          0000008000000080000000800000008000000080000000800000008000000080
          0000008000000080000000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000A0B69C00A0B69C00A0B69C00A0B69C00A0B69C00A0B69C00A0B6
          9C00A0B69C00A0B69C0000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
          F600F6F6F600F6F6F60000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
          F600F6F6F600F6F6F60000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000F6F6F600BFBEBF00BFBEBF00BFBEBF00BFBEBF00BFBEBF00BFBE
          BF00BFBEBF00F6F6F60000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
          F600F6F6F600F6F6F60000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000F6F6F600BFBEBF00BFBEBF00BFBEBF00BFBEBF00BFBEBF00BFBE
          BF00BFBEBF00F6F6F60000800000004B0000FF00FF00FF00FF00FF00FF00004B
          000000800000F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
          F600F6F6F600F6F6F60000800000004B0000FF00FF00FF00FF00FF00FF00FF00
          FF00004B0000F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
          F600F6F6F600F6F6F600004B0000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF000374
          AB000374AB000374AB000374AB000374AB000374AB000374AB000374AB000374
          AB00046B0B000374AB000374AB000374AB00FF00FF00FF00FF000374AB001788
          BD0041B5E80065CFF4004BBFF2004BBFF2004BBFF2004BBFF2004BBFF2004BBF
          F200046B0B00046B0B002799CD000374AB00FF00FF00FF00FF000374AB0039AD
          DF002294C80064D1F70056C7F60056C7F60056C7F60056C7F60056C7F60056C7
          F600046B0B00169C2B00046B0B0060CFE8000374AB00FF00FF000374AB0059C9
          F6000374AB0064D1F70064D1F700046B0B00046B0B00046B0B00046B0B00046B
          0B00046B0B001CA83500169C2B00046B0B000374AB00FF00FF000374AB0064D1
          F7000F72A300ACACA800B0A49700046B0B0042DB7B003FDA76003AD46A0032C9
          59002ABF4C0023B441001CA83500169C2B00046B0B00FF00FF000374AB0064D1
          F7004A70870057D4C700FAE6D000046B0B0042DB7B0042DB7B003FDA76003AD4
          6A0032C959002ABF4C0023B441001CA83500169C2B00046B0B000374AB0064D1
          F700806E6E001380B300FEFCFA00046B0B0042DB7B0042DB7B0042DB7B003FDA
          76003AD46A0033CB5C002ABF4C0021B03C00046B0B000374AB000374AB0064D1
          F7009D6C6000127CAD000374AB00046B0B00046B0B00046B0B00046B0B00046B
          0B00046B0B003AD46A0032C95900046B0B000374AB000374AB000374AB0064D1
          F700AA736000FCE9D600FDEEDD00FAE6D000F9E2CC00F6DDC500F6DDC500E7D1
          BE00046B0B003FDA7600046B0B00FF00FF00FF00FF00FF00FF000374AB00FEFC
          FA00B47D6500FDF1E500FDF5ED00FDEEDD00FDEAD700FAE6D000F9E2CC00F3DA
          C300046B0B00046B0B000473AA00FF00FF00FF00FF00FF00FF00FF00FF000374
          AB00BD876900FDF5ED00FEFBF800FDF5ED00FDF1E500FDF1E500FDEFE100F9E2
          CC00046B0B000374AB00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C9926C00FDF6EF00FEFCFA00FEFBF800FEFBF800DFCCBD00D0C3B700AEA5
          9A00806E6E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00CF9E7100FDF7F100FEFCFA00FEFCFA00FEFCFA00A06C5E00A06C5E00A06C
          5E00A06C5E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C99F7900FDF5ED00FDFBFA00FDFBFA00FEFCFA00A06C5E00D49A6700D49A
          6700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00C99F7900CB936C00CB936C00CB936C00CB936C00A06C5E00D49A6700FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BD4C
          0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C
          0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000FF00FF00BD4C
          0000FEFEFE00FEFEFE00FBF9F700EFECEA00FEDBB500FEDAB500FED0A000FDCD
          9900FDCD9900FDCD9900FDCD9900FDCD9900FDCD9900BD4C0000FF00FF00BD4C
          0000FEFEFE00FEFEFE00FEFEFE00FBF9F700EFECEA00FEDBB500FEDAB500FED0
          A000FDCD9900FDCD9900FDCD9900FDCD9900FDCD9900BD4C0000FF00FF00BD4C
          0000FEFEFE002E5AEE002E5AEE002E5AEE00FBF9F70087360400873604008736
          0400FED0A0000A79CA000A79CA000A79CA00FDCD9900BD4C0000FF00FF00BD4C
          0000FEFEFE002E5AEE002E5AEE002E5AEE00FEFEFE0087360400873604008736
          0400FEDAB5000A79CA000A79CA000A79CA00FDCD9900BD4C0000FF00FF00BD4C
          0000FEFEFE002E5AEE002E5AEE002E5AEE00FEFEFE0087360400873604008736
          0400FEDBB5000A79CA000A79CA000A79CA00FDCD9900BD4C0000FF00FF00BD4C
          0000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FBF9
          F700EFECEA00FEDBB500FEDAB500FED0A000FDCD9900BD4C0000FF00FF00BD4C
          0000FEFEFE00BA818000BA818000BA818000FEFEFE00CE5D0500CE5D0500CE5D
          0500FBF9F700147B0000147B0000147B0000FED0A000BD4C0000FF00FF00BD4C
          0000FEFEFE00BA818000BA818000BA818000FEFEFE00CE5D0500CE5D0500CE5D
          0500FEFEFE00147B0000147B0000147B0000FEDAB500BD4C0000FF00FF00BD4C
          0000FEFEFE00BA818000BA818000BA818000FEFEFE00CE5D0500CE5D0500CE5D
          0500FEFEFE00147B0000147B0000147B0000FEDBB500BD4C0000FF00FF00BD4C
          0000FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFE
          FE00FEFEFE00FEFEFE00FEFEFE00FBF9F700EFECEA00BD4C0000FF00FF00BD4C
          0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C
          0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000FF00FF00FF00
          FF00BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C
          0000BD4C0000BD4C0000BD4C0000BD4C0000BD4C0000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BC4B0000BC4B
          0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
          0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000FEF3
          E400FEF1E000FEEFDD00FEEED900821F0000FEE9CE0000007F00FEE5C500821F
          0000FEE3C100FEE3C100FEE3C100FEE3C100FEE3C100BC4B0000BC4B0000FEF6
          EB00FEF3E400FEEFDD00FEEED900821F0000FEEAD20000007F00FEE7C900821F
          0000FEE3C100FEE3C100FEE3C100FEE3C100FEE3C100BC4B0000BC4B0000FEF6
          EB00FEF5E800FEF3E400FEEFDD00821F0000FEECD50000007F00FEE9CE00821F
          0000FEE3C200FEE3C100FEE3C100FEE3C100FEE3C100BC4B0000BC4B0000FEF7
          EE00FEF6EB00004A0000FEF3E400821F0000FEEED90000007F00FEE9CE00821F
          0000FEE7C900004A0000FEE3C100FEE3C100FEE3C100BC4B0000BC4B0000FEFA
          F300004A0000004A0000FEF3E400821F0000FEEFDD0000007F00FEEAD200821F
          0000FEE7C900004A0000004A0000FEE3C100FEE3C100BC4B0000BC4B0000004A
          000026711A00004A0000004A0000004A0000FEF1E00000007F00FEEED900004A
          0000004A0000004A000026711A00004A0000FEE3C100BC4B0000BC4B0000FEFA
          F300004A0000004A0000FEF7EE00821F0000FEF3E40000007F00FEEED900821F
          0000FEEAD200004A0000004A0000FEE5C500FEE3C100BC4B0000BC4B0000FEFA
          F300FEFAF300004A0000FEFAF300821F0000FEF5E80000007F00FEEFDD00821F
          0000FEECD500004A0000FEE7C900FEE7C900FEE5C500BC4B0000BC4B0000FEFA
          F300FEFAF300FEFAF300FEFAF300821F0000FEF6EB0000007F00FEF3E400821F
          0000FEEED900FEEAD200FEE9CE00FEE7C900FEE5C500BC4B0000BC4B0000FEFA
          F300FEFAF300FEFAF300FEFAF300821F0000FEF7EE0000007F00FEF3E400821F
          0000FEEFDD00FEEED900FEEAD200FEE9CE00FEE7C900BC4B0000BC4B0000FEFA
          F300FEFAF300FEFAF300FEFAF300821F0000FEF9F20000007F00FEF6EB00821F
          0000FEF1E000FEEED900FEEED900FEEAD200FEE9CE00BC4B0000BC4B0000BC4B
          0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
          0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00056695000566
          9500FF00FF00056695000566950005669500FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00056695000566950005669500FF00FF00FF00FF00056695002685
          B3000D6F9E00237FAB0095C3E30005669500FF00FF0010252F00FF00FF001025
          2F00FF00FF000566950095C3E30005669500FF00FF00FF00FF000566950099BD
          E4002685B3002685B300C8E1E7000566950040647500485A6300114D6A001147
          61001147610005669500F0F2EC0005669500FF00FF00FF00FF0005669500BEDD
          E7001779A8000F71A00099BDE4000566950010252F00FF00FF0010252F00FF00
          FF0010252F000566950096C8E30005669500FF00FF00FF00FF00056695000667
          9600096A99002685B3002685B30005669500FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00066796002685B3002685B30005669500FF00FF00FF00FF000566
          950095C3E3002685B300FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00076491002685B30095C3E30005669500FF00FF000566
          9500D3E5E70005669500FF00FF00A3676700A3676700A3676700A3676700A367
          6700A3676700A3676700FF00FF0005669500D3E5E70005669500FF00FF000566
          9500B5DAE60005669500FF00FF00A3676700F9E7CA00F3D9B100F1D19F00ECC6
          9000F0CE9900A3676700FF00FF0005669500C8E1E70005669500FF00FF000566
          9500A9D5E50005669500FF00FF00A3676700F9E7CA00F3D9B100F1D19F00ECC6
          9000F0CE9900A3676700FF00FF0005669500AED7E50005669500FF00FF000566
          9500A9D5E50005669500FF00FF00A9736A00FCEFDC00F5DDB900F3D7AC00EFCB
          9600F0CE9900A3676700FF00FF0005669500AED7E50005669500FF00FF000769
          980099BDE40005669500FF00FF00BC7F6900FCF5EC00FBECD400F5DDB900F3D7
          AC00F2D4A500A3676700FF00FF000566950096C8E30005669500FF00FF00FF00
          FF000566950005669500FF00FF00BD806A00FCF5EC00FCF5EC00FBECD400F7E2
          C200F3D9B100A3676700FF00FF000566950005669500FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00E5BA8900FCF5EC00FCF5EC00FCF5EC00A469
          6500A4696500A4696500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00E5BA8900FCF5EC00FCF5EC00FCF5EC00A469
          6500B6796900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00E5BA8900BD806A00BD806A00BD806A00A469
          6500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000002810000028100000281000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF001D1D2000FF00FF00FF00FF00000281002039E6002431C0000002
          8100FF00FF00FF00FF001D1D2000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00000281002039E6002431C0000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00000281002039E6002431C0000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00000281002039E6002431C0000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF001E1E1F001E1E1F00FF00FF00FF00FF00000281002039E6002431C0000002
          8100FF00FF00FF00FF001E1E1F001E1E1F00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000028100081E9A001222AC000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000028100091B610010194B000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00002185000021850000218500002185000021
          850000218500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001E1E
          1F001E1E1F001E1E1F00FF00FF0003DFF8000CBBF1000CBBF1000CBBF1000CBB
          F10000218500FF00FF001E1E1F001E1E1F001E1E1F00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0003DFF80003DFF80003DFF80003DFF80003DF
          F8001F79E800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00000281002546E8002431C0000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00000281002851E7002431C0000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF001E1E1F001E1E
          1F001E1E1F001D1D2000FF00FF00FF00FF00000281002465E9002431C0000002
          8100FF00FF00FF00FF001D1D20001E1E1F001E1E1F001E1E1F00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00000281001F79E8002634C6000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000002810000028100000281000002
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
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
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF0080808000808080008080800080808000808080008080
          8000808080008080800080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF000080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF000080FF
          00000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF000080FF
          00000000FF0080FF0000808080000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF000080FF
          00000000FF0080FF0000808080000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF00000000
          FF000000FF0080FF0000808080000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF00000000
          FF0080FF000080FF0000808080000000FF000000FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF000080FF000080FF000080FF00000000
          FF0080FF000080FF000080808000FF00FF00FF00FF00FF00FF00000000000000
          00000000000000000000000000000000000000000000000000000000FF000000
          FF00000000000000000000000000000000000000000000000000FF00FF000000
          FF000000FF000000FF008080800080FF000080FF000080FF00000000FF0080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF008080800080FF000080FF00000000FF000000FF0080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF000000FF0080FF000080FF00000000FF0080FF000080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF0080FF000080FF00000000FF0080FF000080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF0080FF000080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF008080800080FF00000000FF0080FF000080FF000080FF
          000080FF000080FF000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0080808000808080008080800080808000808080008080
          8000808080008080800080808000FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF000000
          000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF000000
          000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000000000FF00FF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000FF00FF000000
          000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000000000FF00FF00FF00FF000000
          000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000FFFF0000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000FFFF0000FFFF00000000000000000000FF
          FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000FF000000000000FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000FF000000000000FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000FF000000FF000000000000FF00FF00FF00FF000000000000FF
          000000FF000000FF000000FF000000000000FF00FF00FF00FF000000000000FF
          000000FF000000FF000000FF000000FF000000000000FF00FF000000000000FF
          000000FF000000FF000000FF000000FF000000000000FF00FF000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000000000FF00FF000000000000FF
          000000FF000000FF000000FF000000FF000000000000FF00FF000000000000FF
          000000FF000000FF000000FF000000000000FF00FF00FF00FF000000000000FF
          000000FF000000FF000000FF000000000000FF00FF00FF00FF000000000000FF
          000000FF000000FF000000000000FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000FF000000000000FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF000000000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF000000000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF000000000000FF000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF000000000000FF000000FF000000FF000000000000FF00FF00FF00
          FF000000000000FF000000FF000000FF000000FF000000000000FF00FF00FF00
          FF000000000000FF000000FF000000FF000000FF000000000000FF00FF000000
          000000FF000000FF000000FF000000FF000000FF000000000000FF00FF000000
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF0000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000FF00FF000000
          000000FF000000FF000000FF000000FF000000FF000000000000FF00FF000000
          000000FF000000FF000000FF000000FF000000FF000000000000FF00FF00FF00
          FF000000000000FF000000FF000000FF000000FF000000000000FF00FF00FF00
          FF000000000000FF000000FF000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF000000000000FF000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF000000000000FF000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF000000000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF000000000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00000000000000
          0000FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF000000
          000000000000FF00FF00FF00FF00FF00FF000000000000000000000000000000
          0000FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF000000
          000000000000FF00FF00FF00FF00FF00FF000000000000000000FF00FF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF008080800000000000FF00FF000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF008080800000000000808080000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF008080800000000000808080000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF008080800000000000808080000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000FF00FF000000000000000000FF00FF008080800000000000808080000000
          0000000000000000000000000000000000000000000000000000FF00FF00FF00
          FF0000000000FF00FF0000000000FF00FF00808080000000000000000000FF00
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0000000000808080008080800000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0000000000808080008080800000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF008080800000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008080800000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008080800000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF000000
          800000008000FF00FF00FF00FF00000080000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00
          FF00FF00FF000000800000008000FF00FF00FF00FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00
          FF00FF00FF000000800000008000FF00FF00FF00FF00FF00FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF000000
          800000008000FF00FF00FF00FF00FF00FF000000800000008000FF00FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00
          FF00FF00FF000000800000008000FF00FF00FF00FF00FF00FF0000008000FF00
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF000000
          800000008000FF00FF00FF00FF00FF00FF000000800000008000FF00FF00FF00
          FF00FF00FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF000000FF00FF00FF00FF00
          FF000000000000FF000000FF000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000
          00000000000000FF000000FF00000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000FF000000FF00000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000000000FF000000FF000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000000000000000000000000000000000000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF000000FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000C0C0C000C0C0C00000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          0000C0C0C000C0C0C00000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000C0C0C000C0C0C00000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000000000FF000000FF000000000000FF00FF00FF00FF00FF00FF000000
          0000C0C0C000C0C0C00000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000FF000000FF00000000000000000000FF00FF00000000000000
          0000C0C0C000C0C0C000000000000000000000000000FF00FF000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000000000000000FF
          000000FF000000FF000000FF000000FF000000FF000000000000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF00FF000000
          00000000000000FF000000FF00000000000000000000C0C0C000C0C0C000C0C0
          C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF00FF00FF00
          FF000000000000FF000000FF000000000000FF00FF0000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clRed
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF0000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          0000008080000080800000000000000000000000000000000000000000000000
          0000FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          0000008080000080800000000000000000000000000000000000000000000000
          00000000000000000000000000000080800000000000FF00FF00FF00FF000000
          0000008080000080800000808000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FF00FF00FF00FF000000
          0000008080000080800000000000000000000000000000000000000000000000
          00000000000000000000008080000080800000000000FF00FF00FF00FF000000
          00000080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          00000080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          00000080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          00000080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000080800000000000FF00FF00FF00FF000000
          00000080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF000000
          00000080800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF0000000000FF00FF0000000000FF00FF00FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FF00FF00FF00FF00FF00FF000000000000FF
          FF00000000000080800000808000008080000080800000808000008080000080
          8000008080000080800000000000FF00FF00FF00FF00FF00FF000000000000FF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FF00FF00FF00FF000000000000FF
          FF0000FFFF000000000000808000008080000080800000808000008080000080
          800000808000008080000080800000000000FF00FF00FF00FF000000000000FF
          FF0080808000FFFF000000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FF00FF000000000000FF
          FF0080808000FFFF000000000000008080000080800000808000008080000080
          80000080800000808000008080000080800000000000FF00FF000000000000FF
          FF0080808000FFFF0000FFFF0000000000000000000000000000000000000000
          000000000000000000000000000000000000FF00FF00FF00FF000000000000FF
          FF0080808000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF0000FFFF008080800080808000808080008080800080808000808080008080
          800000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF000000
          00000000000000000000000000000000000000000000000000000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000FF000000
          FF000000FF000000FF000000FF000000FF000000FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          00000000000000000000000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF000000FF00FF00FF0000000000000000000000
          00000000000000000000FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF000000FF000000FF000000000000000000FF00FF000000
          000000000000FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF000000000000000000FF00FF000000
          0000000000000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000000000000000FF00FF000000
          0000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000FF000000
          0000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF000000
          0000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF000000FF000000FF000000FF00FF00FF00000000000000
          0000000000000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF000000FF00FF00FF0000000000000000000000
          000000000000FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF000000FF000000FF000000000000000000FF00FF00FF00
          FF00FF00FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00
          FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000FF000000FF000000FF00FF00FF0000000000000000000000
          0000FF00FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          FF000000FF000000FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          FF000000FF000000FF000000FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF000000FF000000FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF000080000000800000FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000080
          000000800000008000000080000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000080
          0000008000000080000000800000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000080000000800000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FDFDFD00CA9C7B00D0987100CBAF9A00C49A7A00CCA78B00D7BDAC00FDFD
          FD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00D2AF9700CF7B3E00DE813C00C3713400CE753100EE863800DD783200DD8B
          4C00E3B89700FDFDFD00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00D5A98900E0823C00F0883900E7843700FC954400F9954A00F59C5700FEA8
          6400F5904900F1A46D00DACBC200FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00DBB79D00EF873A00FD903D00FE9E5300FEA86400F3A97500FEAE6E00FEAB
          6900F9A26300FEA35A00DB743300DCBAA100FF00FF00FF00FF00FF00FF00FF00
          FF00DDD1C900F8954800FEAF7100FEAC6B00FCB67F00F7A96E00FEB37600FEB5
          7A00FEAF7000FEAD6E00EE853A00E0AC8500FF00FF00FF00FF00FF00FF00FF00
          FF00FBFCFC00EE985200FEA96600FEB87E00FCB37900FDB07400F2AE8300FABB
          8600FCBE8D00FBA56300F48D3F00D1996800FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00EAE6E300E4AA7500FEBC8400FEB98000F9C6A100FAC7A600F7BD
          9400FCBE8A00EFA56900F3914600E19D6700FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00CEB9A400FDAE6E00FECFA600F9BB9900F3A3
          7300EFB68400EDA16500EF9F5E00EEEEEA00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00E9E9E600ECB18500E9A57900E99C
          6400DA9E6400DDDDD200FDFDFC00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00F7F8F800C19B7A00F4B48300F8B27500F7A7
          5C00EA974B00FEFEFE00FF00FF00FEFEFE00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00C0AB9300F2954D00FEC18F00FEC08700FEB4
          6A00FE9D4600EEEFEC00FEFEFE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00EFF1F000FEA96700FED6B300FED9B300FEC8
          9000FEAF6B00EFEEEA00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FEFEFE00E3DBD100FEC69900FED7AD00FEE7CD00FED7
          B100FEBC8500D9D2C500FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00E0CBBA00FEBB8400FECC9400FEE4C400FEE4
          C900FEC89800E3DED400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00F7BD8E00FECB9E00FEDDBC00FCD4
          AE00E0C19D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00E7DED700EFE9E400FF00
          FF00FEFEFE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
          4D004D4D4D004D4D4D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004D4D
          4D004DA6A6004DA6A6004D4D4D004D4D4D004D4D4D004D4D4D00D3D3D3004D4D
          4D004DA6A6004D4D4D00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF004D4D
          4D004DA6A6004DA6A6004D4D4D004D4D4D004D4D4D004D4D4D00D3D3D3004D4D
          4D004DA6A6004D4D4D004D4D4D004D4D4D00FF00FF00FF00FF00FF00FF004D4D
          4D004DA6A6004DA6A6004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
          4D004DA6A6004D4D4D004DA6A6004D4D4D00FF00FF00FF00FF00FF00FF004D4D
          4D004DA6A6004DA6A6004DA6A6004DA6A6004DA6A6004DA6A6004DA6A6004DA6
          A6004DA6A6004D4D4D004DA6A6004D4D4D004D4D4D004D4D4D00FF00FF004D4D
          4D004DA6A6004DA6A6004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004DA6
          A6004DA6A6004D4D4D004DA6A6004D4D4D004DA6A6004D4D4D00FF00FF004D4D
          4D004DA6A6004D4D4D00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
          4D004DA6A6004D4D4D004DA6A6004D4D4D004DA6A6004D4D4D00FF00FF004D4D
          4D004DA6A6004D4D4D00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
          4D004DA6A6004D4D4D004DA6A6004D4D4D004DA6A6004D4D4D00FF00FF004D4D
          4D004DA6A6004D4D4D00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
          4D004D4D4D004D4D4D004DA6A6004D4D4D004DA6A6004D4D4D00FF00FF004D4D
          4D004DA6A6004D4D4D00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3004D4D
          4D00D3D3D3004D4D4D004DA6A6004D4D4D004DA6A6004D4D4D00FF00FF004D4D
          4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
          4D004D4D4D004D4D4D004D4D4D004D4D4D004DA6A6004D4D4D00FF00FF00FF00
          FF00FF00FF004D4D4D004DA6A6004D4D4D00D3D3D300D3D3D300D3D3D300D3D3
          D300D3D3D3004D4D4D00D3D3D3004D4D4D004DA6A6004D4D4D00FF00FF00FF00
          FF00FF00FF004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
          4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF004D4D4D004DA6A6004D4D4D00D3D3D300D3D3
          D300D3D3D300D3D3D300D3D3D3004D4D4D00D3D3D3004D4D4D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF004D4D4D004D4D4D004D4D4D004D4D4D004D4D
          4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00A4686800A4686800A4686800A4686800A4686800A4686800A4686800A468
          6800A4686800A4686800A4686800A4686800A4686800FF00FF00FF00FF00FF00
          FF004F565F00F6E3CA00F3D8B400F1D2A900F0CFA200EEC99600EDC58B00ECC2
          8800ECC28800ECC28800ECC28800EDC58B00A4686800FF00FF00FF00FF003E7B
          B600387EC300646F8700F4DBBB00F2D6B000F1D2A900EFCC9C00EDC79100EDC3
          8900ECBC8A00ECBC8A00ECBC8A00EDC38900A4686800FF00FF00FF00FF00FF00
          FF00387EC300387EC3006D6E7E00F4DBBB00F2D6B000F1D2A900EFCC9C00EEC9
          9600ECC28800ECBC8A00ECBC8A00EDC38900A4686800FF00FF00FF00FF00FF00
          FF00A0685D00387EC300387EC30050668100F4DBBB00F2D6B000F0CFA200EFCC
          9C00EDC79100ECC28800ECC08800EDC38900A4686800FF00FF00FF00FF00FF00
          FF00A7726F00FCF8F100387EC300447AAD009F675F00AC817A009F675F00AA7A
          7500CF997500EDC79100ECC28800EDC58B00A4686800FF00FF00FF00FF00FF00
          FF00A7726F00FDFCFA00FAF0E400B18D8700B18D8700D6BAA900F3D8B400D6BA
          A900AF8A7400CF997500EDC79100EDC58B00A4686800FF00FF00FF00FF00FF00
          FF00BF816600FDFCFA00FCF8F100AD857E00D7C0B300F6E3CA00F5DFC000FDFA
          F500D3B1AE00AA7A7500EFCC9C00EFCC9C00A4686800FF00FF00FF00FF00FF00
          FF00BF816600FDFCFA00FDFCFA009F675F00F8EBDA00F8EBDA00F6E3CA00FCF8
          F100F3D8B4009F675F00F0CFA200F0CFA200A4686800FF00FF00FF00FF00FF00
          FF00CF936E00FDFCFA00FDFCFA00AF898200D6C0B500FAF0E400F8EBDA00F8EB
          DA00D6BAA900AC817A00F3D8B400F0CFA200A4686800FF00FF00FF00FF00FF00
          FF00CF936E00FDFCFA00FDFCFA00D6C0B500B79A9400D6C0B500F8EBDA00D7C0
          B300B18D8700AF8A7400D7C0B300B79A9400A4686800FF00FF00FF00FF00FF00
          FF00D79D7500FDFCFA00FDFCFA00FDFCFA00D6C0B500AF8982009F675F00AD85
          7E00C0A59F00A56B5D00A56B5D00A56B5D00A4686800FF00FF00FF00FF00FF00
          FF00D79D7500FDFCFA00FDFCFA00FDFCFA00FDFCFA00FDFCFA00FDFCFA00FDFC
          F900D6C0B500A56B5D00D89E7400CE916D00AF715D00FF00FF00FF00FF00FF00
          FF00D99F7500FDFCFA00FDFCFA00FDFCFA00FDFCFA00FDFCFA00FDFCFA00FDFC
          FA00D6C0B500A56B5D00ECBC8A00B7796100FF00FF00FF00FF00FF00FF00FF00
          FF00D99F7500FCF8F100FAF3EB00FAF3EB00FAF3EB00FAF3EB00FAF3EB00FAF3
          EB00D6C0B500A56B5D00C4866900FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00D99F7500CF936E00CF936E00CF936E00CF936E00CF936E00CF936E00CF93
          6E00CF936E00A56B5D00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          0000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00
          FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF000000FF000000FF000000FF000000FF000000FF00
          0000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00FF00FF00
          0000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF00FF00FF00
          0000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00FF00FF000000FF00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00108ABD001994C6000B69
          9700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00148DBE00148DBE000B6B9A000D82B4001B96C8001F9AC9000B71
          A0000A6D9C00259DC9001791C300FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00158EC000259DC9001B96C800108ABD001BBBED0032CBF6001791
          C30037ABD30037ABD300158EC000FF00FF00FF00FF00FF00FF00FF00FF000C71
          A1000E7EAF002DA2CA0068D2EC0037ABD30023B6E60011C7FC0024C8F80045CE
          F40037ABD3009ED6E3007AD3E9000C71A100FF00FF00FF00FF00FF00FF0033A7
          CE002DA2CA0037ABD3007AD3E90072D3EA003DCDF50016C8FB0011C7FC003DCD
          F5005BD5F30060D4F10020B8E9001F9AC900158EC000FF00FF00FF00FF000C7B
          AD001791C30025B3E30064D3EF007AD3E90054D1F30033A7CE002DA2CA0023B6
          E60011C6FB0011C6FB0011C6FB0018BFF2001F9AC900FF00FF00FF00FF000A74
          A5001B96C80028B0DF0051D0F3007AD3E900807F7F00807F7F00807F7F00807F
          7F002DA2CA0011C6FB0011C6FB0011C6FB000F88BA00FF00FF00FF00FF000B77
          A9001B96C8001F9AC9003DCDF500807F7F00DED9D8009E899900938C8C00D0A0
          B500807F7F003DCDF50080D3E6009ED6E3000E7EAF00FF00FF00FF00FF000A73
          A4000F88BA001B96C80023B6E600807F7F00DED9D8009A8E9600938C8C00D0A0
          B500807F7F0060D4F10093D5E50072D3EA00158EC000FF00FF00FF00FF00FF00
          FF000D689400118BBE0025B3E300807F7F00DED9D8009A8E9600938C8C00D0A0
          B500807F7F004BCEF3004BCEF3000F669100FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000B70A0000B77A900807F7F00DED9D8009A8E9600938C8C00CCA8
          B300807F7F000D82B4000B77A900FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00807F7F00DDD9D8009A8E9600918A8A00CCA8
          B300807F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00807F7F009E8999008F898900817F7F008F89
          8900807F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00807F7F00DBD7D600B7B7B700938C8C00988F
          9200807F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00807F7F00DDD9D800DED9D800B6B6B6008B86
          8600807F7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00807F7F00807F7F00807F7F00807F
          7F00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000CC000000CC000000FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000CC000000CC000000FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00FF00FF00CC000000FF00FF00FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00
          FF00CC000000CC000000CC000000FF00FF00CC000000CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000CC00
          0000CC000000FF00FF00CC000000CC000000CC000000CC000000CC000000CC00
          0000CC000000CC000000CC000000CC000000FF00FF00CC000000CC000000CC00
          0000FF00FF00FF00FF00FF00FF00CC000000CC000000CC000000CC000000CC00
          0000CC000000CC000000CC000000CC000000FF00FF00CC000000CC000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00CC000000CC000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF000080000000800000008000000080000000800000008000000080
          000000800000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00008000000080000000800000008000000080
          000000800000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF000080000000800000008000000080000000800000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF000080000000800000008000000080000000800000008000000080
          000000800000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF000080000000800000008000000080000000800000008000000080
          000000800000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00008000000080000000800000008000000080
          000000800000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF000000
          0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00195E8100195E8100195E8100195E
          8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00195E8100195E8100195E8100195E8100195E8100195E
          8100195E8100195E8100FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00195E8100176F930016698E0016668B0016668B0016668B001961
          8400195E8100195E8100195E8100FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00195E8100198CAD003BC0DC00187196001269900012699000126990001961
          8400216B8C00248BAE00195E8100195E8100FF00FF00FF00FF00FF00FF00FF00
          FF00176F930027C2DF003FD8EE001C8FB1000F6B93000F6B93000F6B93001669
          8E0044B6D0004DD8F2001C8FB100195E8100FF00FF00FF00FF00FF00FF00195E
          81001BA0C10020D1EB0015C9E6000AB3D5000D77A40010739C0010739C001197
          BD0031C3E40049CFE80033BBDD0016698E00195E8100FF00FF00FF00FF001961
          84002DBCD60016D4EB0000CFE80000D4ED00079EC10010739C000896BB0000B8
          DF000AB3DC0031C3E40031C3E4001A84AB00195E8100FF00FF00FF00FF001666
          8B0043CDE1001ADBEE0000BCD90005A8CA000896BB000C7BA600098CB600098C
          B600098CB60015A1C80026BBDF001893BB00195E8100FF00FF00FF00FF001269
          900026A6C6001197BD000586B400097FAE00097FAE00069FC3000D77A4000D77
          A400117097001170970015749A0015749A00195E8100FF00FF00FF00FF001269
          90000586B4000586B4000586B4000586B40005A8CA0001DEEF00098CB6000D77
          A4000D77A400117097001269900016668B00195E8100FF00FF00FF00FF00FF00
          FF000C7BA600058EBD00058EBD00008FC00000D6E90000F0F90004B4D2000D77
          A4000D77A40010739C001170970016668B00FF00FF00FF00FF00FF00FF00FF00
          FF0010739C000490C0000490C0001BB6D90008F7FB0000E7F30000D6E9000586
          B4000D77A40010739C001170970019618400FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000D7AA4000092C4005EDDEE0070F9FC0070F9FC0060F7FD0040C0
          D80005729E0010739C0016668B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000D77A4000896BB0012BCD8003CCCE10027CBE2000BA8
          C9000D77A40019618400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF001170970011709700117097001669
          8E00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00006592000065920000659200006592000065920000628C00005E
          8800005E880000557F0000557F0000557F0000557F00FF00FF00FF00FF00FF00
          FF00006A9500006A9500006A9500006A9500006592000065920000628C00005E
          8800005A8400005A8400005A840001577F0001577F00FF00FF00FF00FF00FF00
          FF00006E9C004AC5DF0053D4ED003CC8E6003AC2E10032B4D50032B4D50041C3
          DF0053D4ED0059D9EE004ACEE80001577F0001577F00FF00FF00FF00FF00FF00
          FF00006E9C007CEEF6002CB0D30028A4C7003AB5D30049C8E30052CFE6005CD4
          E8005FD2E40052C2D90052CFE60000557F0000557F00FF00FF00FF00FF000074
          A500006EA10081ECF7003EC7E50032B4D50024A2C7001995BD001995BD002EA6
          C7004AC0DB006DE4F20032B4D50000557F00FF00FF00FF00FF00FF00FF000079
          A7000079A70082E6F40022A7CD0049C8E3004ACEE8004ACEE80053D4ED006DE6
          F50074EAF60054D3E800229ABE00005A8400FF00FF00FF00FF00FF00FF000080
          AF00007BAC00A5F7FC0041C3DF000E86B300067BAA000079A7000079A7000982
          AF00229ABE004ACEE8001B8AAF00005A8400FF00FF00FF00FF00FF00FF000080
          AF000080AF00A6F0F90054D3E80062DEF0005CD4E80049C8E30049C8E30060D9
          EC0074EAF60059D9EE001F91B900005E8800FF00FF00FF00FF00FF00FF000084
          B4000084B400D4FDFE003BB5D100006EA100006EA1000074A500007BAC00007B
          AC000982AF004AC5DF0032B4D500005E8800FF00FF00FF00FF00FF00FF000084
          B4000084B400E2FFFF0093F7FC005ED0E10043B9D50039AFCC002FA8CA003AB5
          D30052C6DB0062DEF0003EC7E500005E8800FF00FF00FF00FF00FF00FF00FF00
          FF00008DBF00E3FFFE00CCEFF4000470A300137DAC001A91B800118BB500118B
          B5003AB5D300056A9600056A9600005E8800FF00FF00FF00FF00FF00FF00FF00
          FF00008DBF0094EEF700FFFFFF005EB6D000269DC1001995BD001995BD0032B4
          D5003DBFDC00006592000065920000628C00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF000095C80010A1CE0071D1E50094E6EF00AFF6FB00AFF6FB008DEA
          F6004AC0DB00006A9500006A9500FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF000095C800058EBF000993C1001399C3001092BD000A89
          B6000079A700006E9C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          FF000000FF000000FF000000FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          FF000000FF000000FF000000FF00FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF000000FF000000FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF000000000000FF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF000000000000FF
          000000FF000000000000FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF000080000000800000FF00FF0000000000FF00FF00FF00FF000000000000FF
          000000FF000000FF000000000000FF00FF00FF00FF00FF00FF00000000000080
          000000800000008000000080000000000000FF00FF00FF00FF000000000000FF
          000000FF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000080
          0000008000000080000000800000FF00FF00FF00FF00FF00FF000000000000FF
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000080000000800000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008080
          80008080800080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00FF008080800000FF
          000000FF000000FF000080808000FF00FF00FF00FF00FF00FF00FF00FF000000
          FF000000FF000000FF000000FF0000000000FF00FF008080800000FF000000FF
          000000FF000000FF000000FF000080808000FF00FF00FF00FF00000000000000
          FF000000FF000000FF000000FF00FF00FF000000000000FF000000FF000000FF
          00008080800000FF000000FF000000FF000080808000FF00FF0000000000FF00
          FF000000FF000000FF00FF00FF008080800000FF000000FF000000FF00008080
          80008080800000FF000000FF000000FF000080808000FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF008080800000FF000000FF000080808000FF00
          FF00FF00FF008080800000FF000000FF000000FF000080808000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00808080008080800000000000FF00FF00FF00
          FF00FF00FF008080800000FF000000FF000000FF000080808000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00
          FF00FF00FF00FF00FF008080800000FF000000FF000080808000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000FF00
          FF00FF00FF00FF00FF00FF00FF00000000008080800080808000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF000080000000800000FF00FF0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000080
          000000800000008000000080000000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000080
          0000008000000080000000800000FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF000080000000800000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
  object acts: TActionList
    Images = imgs
    Left = 408
    Top = 80
    object actOpen: TAction
      Category = 'File'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      ImageIndex = 2
      ShortCut = 114
      OnExecute = actOpenExecute
    end
    object actExit: TAction
      Category = 'File'
      Caption = #1042#1099#1093#1086#1076
      ImageIndex = 7
      ShortCut = 16465
      OnExecute = actExitExecute
    end
    object actAbout: TAction
      Category = 'ViewInfo'
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 3
      OnExecute = actAboutExecute
    end
    object actAmplificationUp: TAction
      Category = 'Operations'
      Caption = 'actAmplificationUp'
      ImageIndex = 0
      OnExecute = actAmplificationUpExecute
      OnUpdate = projectOpenedUpdate
    end
    object actAmplificationDown: TAction
      Category = 'Operations'
      Caption = 'actAmplificationDown'
      ImageIndex = 1
      OnExecute = actAmplificationDownExecute
      OnUpdate = projectOpenedUpdate
    end
    object actNextFile: TAction
      Category = 'File'
      Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1081' '#1092#1072#1081#1083
      ImageIndex = 5
      OnExecute = actNextFileExecute
      OnUpdate = projectOpenedUpdate
    end
    object actPrevFile: TAction
      Category = 'File'
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1080#1081' '#1092#1072#1081#1083
      ImageIndex = 4
      OnExecute = actPrevFileExecute
      OnUpdate = projectOpenedUpdate
    end
    object actProcessed: TAction
      Category = 'ViewInfo'
      Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1089#1093#1086#1076#1085#1099#1081' '#1089#1080#1075#1085#1072#1083' '#1080#1083#1080' '#1086#1073#1088#1072#1073#1086#1090#1072#1085#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 38
      OnExecute = actProcessedExecute
      OnUpdate = projectNotWorkUpdate
    end
    object actSaveText: TAction
      Category = 'File'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1090#1077#1082#1089#1090
      Hint = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093' '#1074' '#1090#1077#1082#1089#1090#1086#1074#1086#1084' '#1092#1086#1088#1084#1072#1090#1077
      ImageIndex = 10
      OnExecute = actSaveTextExecute
      OnUpdate = projectOpenedUpdate
    end
    object actViewSettings: TAction
      Category = 'ViewInfo'
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1073#1086#1088#1072' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 12
      OnExecute = actViewSettingsExecute
      OnUpdate = projectOpenedUpdate
    end
    object actSaveParams: TAction
      Category = 'Operations'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
      Hint = 
        #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1077' '#1072#1084#1087#1083#1080#1090#1091#1076#1099' '#1080' '#1092#1072#1079#1099' '#1074' '#1073#1091#1092#1077#1088' '#1076#1083#1103' '#1074#1089#1090#1072#1074#1082#1080' '#1074' Excel '#1080#1083#1080' '#1090 +
        #1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083
      ImageIndex = 32
      ShortCut = 113
      OnExecute = actSaveParamsExecute
      OnUpdate = projectOpenedUpdate
    end
    object actCalibStart: TAction
      Category = 'Operations'
      Caption = #1053#1072#1095#1072#1083#1086' '#1075#1088#1072#1076#1091#1080#1088#1086#1074#1082#1080
      Hint = #1053#1072#1095#1072#1090#1100' '#1094#1080#1082#1083' '#1082#1072#1083#1080#1073#1088#1086#1074#1086#1082
      ImageIndex = 40
      OnExecute = actCalibStartExecute
      OnUpdate = projectNotWorkUpdate
    end
    object actCalib: TAction
      Category = 'Operations'
      Caption = #1043#1088#1072#1076#1091#1080#1088#1086#1074#1082#1072
      Hint = #1050#1072#1083#1080#1073#1088#1086#1074#1082#1072' '#1087#1086' '#1090#1077#1082#1091#1097#1077#1084#1091' '#1092#1072#1081#1083#1091
      ImageIndex = 30
      OnExecute = actCalibExecute
      OnUpdate = projectNotWorkUpdate
    end
    object actCalibCheck: TAction
      Category = 'Operations'
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1075#1088#1072#1076#1091#1080#1088#1086#1074#1082#1080
      Hint = #1055#1088#1086#1074#1077#1088#1082#1072' '#1082#1072#1083#1080#1073#1088#1086#1074#1082#1080
      ImageIndex = 41
      OnExecute = actCalibCheckExecute
      OnUpdate = projectNotWorkUpdate
    end
    object actTestDevice: TAction
      Category = 'Operations'
      Caption = #1055#1086#1074#1077#1088#1082#1072' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
      Hint = #1055#1086#1074#1077#1088#1082#1072' '#1074#1089#1077#1081' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
      ImageIndex = 37
      OnExecute = actTestDeviceExecute
      OnUpdate = projectNotWorkUpdate
    end
    object actView: TAction
      Category = 'ViewInfo'
      Caption = #1042#1080#1076':'
      Visible = False
      OnUpdate = projectOpenedUpdate
    end
    object actType: TAction
      Category = 'ViewInfo'
      Caption = #1058#1080#1087':'
      Visible = False
      OnUpdate = projectOpenedUpdate
    end
    object actChannel: TAction
      Category = 'ViewInfo'
      Caption = #1050#1072#1085#1072#1083':'
      Visible = False
      OnUpdate = projectOpenedUpdate
    end
    object actReport: TAction
      Category = 'Operations'
      Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1077#1090#1072
      OnExecute = actReportExecute
      OnUpdate = projectNotWorkUpdate
    end
    object actProcCalibration: TAction
      Category = 'ViewInfo'
      Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1057#1054#1055
      GroupIndex = 5
      Hint = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1082#1072#1083#1080#1073#1088#1086#1074#1086#1095#1085#1086#1081
      Visible = False
      OnExecute = actProcCalibrationExecute
      OnUpdate = projectOpenedUpdate
    end
    object actProcProduction: TAction
      Category = 'ViewInfo'
      Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1080#1079#1076#1077#1083#1080#1103
      Checked = True
      GroupIndex = 5
      Hint = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1080#1079#1076#1077#1083#1080#1103
      Visible = False
      OnExecute = actProcProductionExecute
      OnUpdate = projectOpenedUpdate
    end
  end
  object mdFilterType: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D4500010000000001070000004C6F77506173730101000000010800
      000042616E6450617373}
    SortOptions = []
    Left = 96
    Top = 216
    object mdFilterTypeID: TIntegerField
      FieldName = 'ID'
    end
    object mdFilterTypeNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
  object dsFilterType: TDataSource
    DataSet = mdFilterType
    Left = 96
    Top = 256
  end
  object oDlg: TOpenDialog
    DefaultExt = 'dar'
    Filter = #1060#1072#1081#1083#1099' '#1072#1085#1085#1099#1093' Ariel (*.dar)|*.dar|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 104
    Top = 104
  end
  object sDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 144
    Top = 104
  end
  object mdDefects: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterScroll = mdDefectsAfterScroll
    Left = 600
    Top = 112
    object mdDefectsID: TIntegerField
      Alignment = taCenter
      FieldName = 'ID'
    end
    object mdDefectsPOSITION: TIntegerField
      Alignment = taCenter
      FieldName = 'POSITION'
    end
    object mdDefectsVolume: TStringField
      Alignment = taCenter
      FieldName = 'Volume'
      Size = 8
    end
    object mdDefectsANGLE: TIntegerField
      Alignment = taCenter
      FieldName = 'ANGLE'
    end
    object mdDefectsQUALITY: TIntegerField
      Alignment = taCenter
      FieldName = 'QUALITY'
    end
    object mdDefectsCOLOR: TIntegerField
      Alignment = taCenter
      FieldName = 'COLOR'
    end
    object mdDefectsCMNT: TStringField
      FieldName = 'CMNT'
      Size = 64
    end
    object mdDefectsDTYPE: TStringField
      Alignment = taCenter
      FieldName = 'DTYPE'
      Size = 16
    end
  end
  object dsDefects: TDataSource
    DataSet = mdDefects
    Left = 632
    Top = 112
  end
  object tm: TTimer
    Interval = 150
    OnTimer = tmTimer
    Left = 328
    Top = 120
  end
  object tmLic: TTimer
    Enabled = False
    Interval = 100000
    OnTimer = tmLicTimer
    Left = 328
    Top = 160
  end
end
