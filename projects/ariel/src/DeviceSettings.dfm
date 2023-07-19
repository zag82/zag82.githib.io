object fmDeviceSettings: TfmDeviceSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Device settings'
  ClientHeight = 483
  ClientWidth = 800
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object grParams: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 92
    Width = 794
    Height = 352
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    ExplicitLeft = -2
    object tvParams: TcxGridDBTableView
      OnKeyDown = tvParamsKeyDown
      OnCellDblClick = tvParamsCellDblClick
      DataController.DataSource = dsDeviceData
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
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
      OptionsView.HeaderEndEllipsis = True
      object tvParamsID: TcxGridDBColumn
        Caption = 'Channel'
        DataBinding.FieldName = 'ID'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvParamsFREQ: TcxGridDBColumn
        Caption = 'Frequency (Hz)'
        DataBinding.FieldName = 'FREQ'
        HeaderAlignmentHorz = taCenter
      end
      object tvParamsDRV: TcxGridDBColumn
        Caption = 'Driver level (%)'
        DataBinding.FieldName = 'DRV'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvParamsAMP: TcxGridDBColumn
        Caption = 'Amplification (dB)'
        DataBinding.FieldName = 'AMP'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvParamsFILTER_TYPE: TcxGridDBColumn
        Caption = 'Filter type'
        DataBinding.FieldName = 'FILTER_TYPE'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListSource = dm.dsFilterType
        HeaderAlignmentHorz = taCenter
      end
      object tvParamsHIGH_PASS: TcxGridDBColumn
        Caption = 'LF (Hz)'
        DataBinding.FieldName = 'HIGH_PASS'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvParamsCHANGED: TcxGridDBColumn
        DataBinding.FieldName = 'CHANGED'
        Visible = False
        VisibleForCustomization = False
      end
      object tvParamsLOW_PASS: TcxGridDBColumn
        Caption = 'HF (Hz)'
        DataBinding.FieldName = 'LOW_PASS'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvParamsPHASE: TcxGridDBColumn
        Caption = 'Phase'
        DataBinding.FieldName = 'PHASE'
        Width = 50
      end
      object tvParamsSPREADX: TcxGridDBColumn
        Caption = 'Amp.X (dB)'
        DataBinding.FieldName = 'SPREADX'
        Width = 50
      end
      object tvParamsSPREADY: TcxGridDBColumn
        Caption = 'Amp.Y (dB)'
        DataBinding.FieldName = 'SPREADY'
        Width = 50
      end
      object tvParamsDOTX: TcxGridDBColumn
        Caption = 'Center X (mV)'
        DataBinding.FieldName = 'DOTX'
        Width = 60
      end
      object tvParamsDOTY: TcxGridDBColumn
        Caption = 'Center Y (mV)'
        DataBinding.FieldName = 'DOTY'
        Width = 60
      end
      object tvParamsMUXTIME: TcxGridDBColumn
        Caption = 'Time MUX (mks)'
        DataBinding.FieldName = 'MUXTIME'
        Width = 80
      end
    end
    object lvParams: TcxGridLevel
      GridView = tvParams
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 447
    Width = 800
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btSave: TcxButton
      Left = 624
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Save'
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      TabOrder = 0
      OnClick = btSaveClick
    end
    object btExit: TcxButton
      Left = 712
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Cancel'
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      TabOrder = 1
      OnClick = btExitClick
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object gbCommon: TcxGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Align = alClient
      Caption = 'Common parameters'
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Height = 83
      Width = 794
      object edPreAmp: TcxTextEdit
        Left = 127
        Top = 17
        Properties.OnChange = edPreAmpPropertiesChange
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 0
        Text = 'edPreAmp'
        Width = 78
      end
      object lbPreAmp: TcxLabel
        Left = 16
        Top = 18
        Caption = 'Preamp (dB):'
      end
      object lbBWLimit: TcxLabel
        Left = 16
        Top = 52
        Caption = 'Analog filter:'
      end
      object lbMUXStart: TcxLabel
        Left = 224
        Top = 18
        Caption = 'Start multiplexing channel:'
      end
      object lbMuxEnd: TcxLabel
        Left = 224
        Top = 52
        Caption = 'End multiplexing channel:'
      end
      object lbDecimation: TcxLabel
        Left = 536
        Top = 18
        Caption = 'Decimation:'
      end
      object lbTriggerType: TcxLabel
        Left = 536
        Top = 52
        Caption = 'Acquisition type:'
      end
      object edMUXStart: TcxTextEdit
        Left = 361
        Top = 17
        Properties.ReadOnly = True
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 7
        Text = 'edMUXStart'
        Width = 154
      end
      object edMuxEnd: TcxTextEdit
        Left = 361
        Top = 51
        Properties.ReadOnly = True
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 8
        Text = 'edMuxEnd'
        Width = 154
      end
      object edDecimation: TcxTextEdit
        Left = 606
        Top = 17
        Properties.ReadOnly = True
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        Style.Shadow = True
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 9
        Text = 'edDecimation'
        Width = 163
      end
      object edTriggerType: TcxLookupComboBox
        Left = 639
        Top = 51
        Enabled = False
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsTriggerType
        Properties.ReadOnly = True
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.BorderColor = clWindowFrame
        StyleDisabled.Color = clWindow
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleDisabled.TextColor = clWindowText
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 10
        Width = 130
      end
      object edBWLimit: TcxLookupComboBox
        Left = 127
        Top = 51
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsBWLimit
        Properties.OnChange = edBWLimitPropertiesChange
        Style.LookAndFeel.Kind = lfStandard
        Style.LookAndFeel.NativeStyle = True
        StyleDisabled.BorderColor = clWindowFrame
        StyleDisabled.Color = clWindow
        StyleDisabled.LookAndFeel.Kind = lfStandard
        StyleDisabled.LookAndFeel.NativeStyle = True
        StyleDisabled.TextColor = clWindowText
        StyleFocused.LookAndFeel.Kind = lfStandard
        StyleFocused.LookAndFeel.NativeStyle = True
        StyleHot.LookAndFeel.Kind = lfStandard
        StyleHot.LookAndFeel.NativeStyle = True
        TabOrder = 11
        Width = 78
      end
    end
  end
  object mdDeviceData: TdxMemData
    Indexes = <
      item
        FieldName = 'ID'
        SortOptions = []
      end>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F080000000400000003000300494400040000000300
      050046524551000400000003000400445256000400000003000400414D500004
      00000003000C0046494C5445525F545950450004000000030009004C4F575F50
      415353000400000003000A00484947485F504153530002000000050008004348
      414E47454400}
    SortOptions = []
    SortedField = 'ID'
    Left = 40
    Top = 208
    object mdDeviceDataID: TIntegerField
      Alignment = taCenter
      FieldName = 'ID'
    end
    object mdDeviceDataFREQ: TIntegerField
      Alignment = taCenter
      FieldName = 'FREQ'
    end
    object mdDeviceDataDRV: TIntegerField
      Alignment = taCenter
      FieldName = 'DRV'
    end
    object mdDeviceDataAMP: TIntegerField
      Alignment = taCenter
      FieldName = 'AMP'
    end
    object mdDeviceDataFILTER_TYPE: TIntegerField
      Alignment = taCenter
      FieldName = 'FILTER_TYPE'
    end
    object mdDeviceDataLOW_PASS: TIntegerField
      Alignment = taCenter
      FieldName = 'LOW_PASS'
    end
    object mdDeviceDataHIGH_PASS: TIntegerField
      Alignment = taCenter
      FieldName = 'HIGH_PASS'
    end
    object mdDeviceDataCHANGED: TBooleanField
      FieldName = 'CHANGED'
    end
    object mdDeviceDataPHASE: TIntegerField
      FieldName = 'PHASE'
    end
    object mdDeviceDataSPREADX: TIntegerField
      FieldName = 'SPREADX'
    end
    object mdDeviceDataSPREADY: TIntegerField
      FieldName = 'SPREADY'
    end
    object mdDeviceDataDOTX: TIntegerField
      FieldName = 'DOTX'
    end
    object mdDeviceDataDOTY: TIntegerField
      FieldName = 'DOTY'
    end
    object mdDeviceDataMUXTIME: TIntegerField
      FieldName = 'MUXTIME'
    end
  end
  object dsDeviceData: TDataSource
    DataSet = mdDeviceData
    Left = 72
    Top = 208
  end
  object mdTriggerType: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D45000101000000010400000054696D650103000000010700000045
      6E636F646572}
    SortOptions = []
    Left = 592
    Top = 176
    object mdTriggerTypeID: TIntegerField
      FieldName = 'ID'
    end
    object mdTriggerTypeNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
  object dsTriggerType: TDataSource
    DataSet = mdTriggerType
    Left = 624
    Top = 176
  end
  object dsBWLimit: TDataSource
    DataSet = mdBWLimit
    Left = 624
    Top = 248
  end
  object mdBWLimit: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D4500010000000001020000004846010100000001020000004D4601
      0200000001020000004C46010300000001030000004F46460104000000010400
      00004155544F}
    SortOptions = []
    Left = 592
    Top = 248
    object mdBWLimitID: TIntegerField
      FieldName = 'ID'
    end
    object mdBWLimitNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
end
