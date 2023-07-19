object fmCalibTestDevice: TfmCalibTestDevice
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1074#1077#1088#1082#1072' '#1091#1089#1090#1072#1085#1086#1074#1082#1080
  ClientHeight = 272
  ClientWidth = 638
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
  object pnl: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 231
    Width = 632
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 384
    object btOK: TcxButton
      Left = 280
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1050
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = True
      TabOrder = 0
      OnClick = btOKClick
    end
  end
  object gr: TcxGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 632
    Height = 222
    Align = alClient
    TabOrder = 1
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = True
    ExplicitHeight = 356
    object tv: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      OnCellDblClick = tvCellDblClick
      DataController.DataSource = ds
      DataController.KeyFieldNames = 'RecId'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
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
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object tvVOLUME: TcxGridDBColumn
        Caption = #1054#1073#1098#1077#1084' ('#1087#1086' '#1087#1072#1089#1087#1086#1088#1090#1091')'
        DataBinding.FieldName = 'VOLUME'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object tvDIST: TcxGridDBColumn
        Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072' ('#1084#1084')'
        DataBinding.FieldName = 'DIST'
        HeaderAlignmentHorz = taCenter
        Width = 120
      end
      object tvEXT: TcxGridDBColumn
        Caption = #1042#1085#1077#1096#1085#1080#1081
        DataBinding.FieldName = 'EXT'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvAXIAL: TcxGridDBColumn
        Caption = #1057#1080#1084#1084#1077#1090#1088#1080#1095#1085#1099#1081
        DataBinding.FieldName = 'AXIAL'
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
      object tvWASTE: TcxGridDBColumn
        Caption = #1041#1088#1072#1082
        DataBinding.FieldName = 'WASTE'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object tvpos1: TcxGridDBColumn
        DataBinding.FieldName = 'pos1'
        Visible = False
      end
      object tvpos2: TcxGridDBColumn
        DataBinding.FieldName = 'pos2'
        Visible = False
      end
      object tvvol: TcxGridDBColumn
        Caption = #1054#1073#1098#1105#1084' ('#1074#1099#1103#1074#1083#1077#1085#1085#1099#1081')'
        DataBinding.FieldName = 'vol'
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object tvchannel: TcxGridDBColumn
        DataBinding.FieldName = 'channel'
        Visible = False
      end
      object tvqr: TcxGridDBColumn
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
        DataBinding.FieldName = 'qr'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.Alignment.Horz = taCenter
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'ID'
        Properties.ListColumns = <
          item
            FieldName = 'NAME'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsResult
        Properties.PopupAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 100
      end
    end
    object lv: TcxGridLevel
      GridView = tv
    end
  end
  object md: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 512
    Top = 160
    object mdVOLUME: TStringField
      Alignment = taCenter
      FieldName = 'VOLUME'
      Size = 16
    end
    object mdDIST: TIntegerField
      Alignment = taCenter
      FieldName = 'DIST'
    end
    object mdEXT: TBooleanField
      FieldName = 'EXT'
    end
    object mdAXIAL: TBooleanField
      FieldName = 'AXIAL'
    end
    object mdWASTE: TBooleanField
      FieldName = 'WASTE'
    end
    object mdpos1: TIntegerField
      FieldName = 'pos1'
    end
    object mdpos2: TIntegerField
      FieldName = 'pos2'
    end
    object mdvol: TStringField
      Alignment = taCenter
      FieldName = 'vol'
      Size = 16
    end
    object mdchannel: TIntegerField
      FieldName = 'channel'
    end
    object mdqr: TIntegerField
      Alignment = taCenter
      FieldName = 'qr'
    end
  end
  object ds: TDataSource
    DataSet = md
    Left = 544
    Top = 160
  end
  object dsResult: TDataSource
    DataSet = mdResult
    Left = 392
    Top = 112
  end
  object mdResult: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D450001010000000105000000C3EEE4E5ED0102000000010C000000
      CFE5F0E5EAEEEDF2F0EEEBFC01030000000104000000C1F0E0EA}
    SortOptions = []
    Left = 360
    Top = 112
    object mdResultID: TIntegerField
      FieldName = 'ID'
    end
    object mdResultNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
end
