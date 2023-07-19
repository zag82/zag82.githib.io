inherited fmCommonSettings: TfmCommonSettings
  ActiveControl = cxDBMaskEdit1
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 373
  ClientWidth = 544
  ExplicitWidth = 550
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlControl: TPanel
    Top = 340
    Width = 544
    ExplicitTop = 340
    ExplicitWidth = 544
    inherited btOk: TcxButton
      Left = 386
      ExplicitLeft = 386
    end
    inherited btCancel: TcxButton
      Left = 465
      ExplicitLeft = 465
    end
  end
  object dxLayoutControl1: TdxLayoutControl [1]
    Left = 0
    Top = 0
    Width = 544
    Height = 340
    Align = alClient
    TabOrder = 1
    object cxDBMaskEdit1: TcxDBMaskEdit
      Left = 132
      Top = 10
      DataBinding.DataField = 'IP'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Width = 121
    end
    object cxDBMaskEdit2: TcxDBMaskEdit
      Left = 132
      Top = 91
      DataBinding.DataField = 'FNAME1'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d\d\d'
      Properties.MaxLength = 0
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 4
      Width = 121
    end
    object cxDBMaskEdit3: TcxDBMaskEdit
      Left = 271
      Top = 91
      DataBinding.DataField = 'FNAME2'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d\d\d'
      Properties.MaxLength = 0
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 5
      Width = 121
    end
    object cxDBMaskEdit4: TcxDBMaskEdit
      Left = 410
      Top = 91
      DataBinding.DataField = 'FNAME3'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d\d\d'
      Properties.MaxLength = 0
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 6
      Width = 121
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 132
      Top = 145
      DataBinding.DataField = 'DATA_FILE_PATH'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 8
      Width = 121
    end
    object cxDBComboBox1: TcxDBComboBox
      Left = 132
      Top = 118
      DataBinding.DataField = 'PART_INC'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.Items.Strings = (
        '1'
        '2'
        '3')
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 7
      Width = 121
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 132
      Top = 64
      DataBinding.DataField = 'DECIMATION'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 2
      Width = 121
    end
    object cxDBTextEdit3: TcxDBTextEdit
      Left = 413
      Top = 64
      DataBinding.DataField = 'SERIES_MAX'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 3
      Width = 121
    end
    object cxDBLookupComboBox1: TcxDBLookupComboBox
      Left = 132
      Top = 172
      DataBinding.DataField = 'PRIORITY'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsPriority
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 9
      Width = 145
    end
    object cxDBCheckBox1: TcxDBCheckBox
      Left = 10
      Top = 199
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1080#1072#1083#1086#1075' '#1087#1088#1080' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1080' '#1092#1072#1081#1083#1086#1074
      DataBinding.DataField = 'SHOW_DLG'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.NullStyle = nssUnchecked
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 10
      Width = 121
    end
    object cxDBCheckBox2: TcxDBCheckBox
      Left = 10
      Top = 226
      Caption = #1040#1074#1090#1086'-'#1089#1090#1072#1088#1090
      DataBinding.DataField = 'AUTO_START'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.NullStyle = nssUnchecked
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 11
      Width = 121
    end
    object cxDBLookupComboBox2: TcxDBLookupComboBox
      Left = 189
      Top = 226
      DataBinding.DataField = 'START_CONDITION'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsCondition
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 12
      Width = 145
    end
    object cxDBCalcEdit1: TcxDBCalcEdit
      Left = 395
      Top = 226
      DataBinding.DataField = 'START_VALUE'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 13
      Width = 121
    end
    object cxDBCheckBox3: TcxDBCheckBox
      Left = 10
      Top = 253
      Caption = #1040#1074#1090#1086'-'#1089#1090#1086#1087
      DataBinding.DataField = 'AUTO_STOP'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.NullStyle = nssUnchecked
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 14
      Width = 121
    end
    object cxDBLookupComboBox3: TcxDBLookupComboBox
      Left = 189
      Top = 253
      DataBinding.DataField = 'STOP_CONDITION'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsCondition
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 15
      Width = 145
    end
    object cxDBCalcEdit2: TcxDBCalcEdit
      Left = 395
      Top = 253
      DataBinding.DataField = 'STOP_VALUE'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 16
      Width = 121
    end
    object cxDBComboBox2: TcxDBComboBox
      Left = 132
      Top = 280
      DataBinding.DataField = 'AUTO_CHANNEL'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
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
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 17
      Width = 121
    end
    object cxDBLookupComboBox4: TcxDBLookupComboBox
      Left = 132
      Top = 307
      DataBinding.DataField = 'AUTO_PART'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsPart
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 18
      Width = 145
    end
    object cxDBLookupComboBox5: TcxDBLookupComboBox
      Left = 132
      Top = 37
      DataBinding.DataField = 'TRIGGER_TYPE'
      DataBinding.DataSource = fmMainArielAquire.dsCommonSettings
      Enabled = False
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsTriggerType
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 1
      Width = 145
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutControl1Item1: TdxLayoutItem
      AlignHorz = ahClient
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'IP '#1072#1076#1088#1077#1089' '#1087#1088#1080#1073#1086#1088#1072':'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBMaskEdit1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item19: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1058#1080#1087' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093':'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBLookupComboBox5
      ControlOptions.ShowBorder = False
      Enabled = False
      Index = 1
    end
    object dxLayoutControl1Group7: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      Parent = dxLayoutControl1Group_Root
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Group2: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      Parent = dxLayoutControl1Group7
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item7: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1044#1077#1094#1080#1084#1072#1094#1080#1103':'
      Parent = dxLayoutControl1Group2
      SizeOptions.Width = 200
      Control = cxDBTextEdit2
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item8: TdxLayoutItem
      AlignHorz = ahClient
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1072#1103' '#1088#1072#1079#1074#1077#1088#1090#1082#1072' ('#1086#1090#1089#1095#1077#1090#1099'):'
      Parent = dxLayoutControl1Group2
      SizeOptions.Width = 200
      Control = cxDBTextEdit3
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Group1: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      Parent = dxLayoutControl1Group7
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item2: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1048#1084#1103' '#1092#1072#1081#1083#1072': DAP'
      Parent = dxLayoutControl1Group1
      Control = cxDBMaskEdit2
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item3: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'P'
      Parent = dxLayoutControl1Group1
      Control = cxDBMaskEdit3
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item4: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'P'
      Parent = dxLayoutControl1Group1
      Control = cxDBMaskEdit4
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Item6: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1040#1074#1090#1086#1080#1085#1082#1088#1077#1084#1077#1085#1090':'
      Parent = dxLayoutControl1Group7
      Control = cxDBComboBox1
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Item5: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1055#1091#1090#1100' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103':'
      Parent = dxLayoutControl1Group7
      Control = cxDBTextEdit1
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutControl1Item9: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1055#1088#1080#1086#1088#1080#1090#1077#1090':'
      Parent = dxLayoutControl1Group7
      Control = cxDBLookupComboBox1
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutControl1Item10: TdxLayoutItem
      CaptionOptions.Text = 'cxDBCheckBox1'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group7
      Control = cxDBCheckBox1
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutControl1Group4: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      Parent = dxLayoutControl1Group7
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 6
    end
    object dxLayoutControl1Item11: TdxLayoutItem
      CaptionOptions.Text = 'cxDBCheckBox2'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group4
      Control = cxDBCheckBox2
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item12: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1059#1089#1083#1086#1074#1080#1077':'
      Parent = dxLayoutControl1Group4
      Control = cxDBLookupComboBox2
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item13: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1079#1085#1072#1095#1077#1085#1080#1077':'
      Parent = dxLayoutControl1Group4
      Control = cxDBCalcEdit1
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Group6: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      Parent = dxLayoutControl1Group7
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 7
    end
    object dxLayoutControl1Group5: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      Parent = dxLayoutControl1Group6
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item14: TdxLayoutItem
      CaptionOptions.Text = 'cxDBCheckBox3'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group5
      Control = cxDBCheckBox3
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item15: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1059#1089#1083#1086#1074#1080#1077':'
      Parent = dxLayoutControl1Group5
      Control = cxDBLookupComboBox3
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item16: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1079#1085#1072#1095#1077#1085#1080#1077':'
      Parent = dxLayoutControl1Group6
      Control = cxDBCalcEdit2
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item17: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1050#1072#1085#1072#1083' '#1072#1074#1090#1086'-'#1079#1072#1087#1091#1089#1082#1072':'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBComboBox2
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutControl1Item18: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1050#1086#1084#1087#1086#1085#1077#1085#1090#1072':'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBLookupComboBox4
      ControlOptions.ShowBorder = False
      Index = 4
    end
  end
  object mdPriority: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D450001000000000104000000CDEEEBFC0101000000010C000000D1
      E0ECFBE920EDE8E7EAE8E90102000000010A000000CFEEEDE8E6E5EDEDFBE901
      03000000010A000000CDEEF0ECE0EBFCEDFBE90104000000010A000000CFEEE2
      FBF8E5EDEDFBE9}
    SortOptions = []
    Left = 416
    Top = 112
    object mdPriorityID: TIntegerField
      FieldName = 'ID'
    end
    object mdPriorityNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
  object dsPriority: TDataSource
    DataSet = mdPriority
    Left = 448
    Top = 112
  end
  object mdCondition: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D45000101000000010A000000C1EEEBFCF8E520283E290102000000
      010A000000CCE5EDFCF8E520283C29}
    SortOptions = []
    Left = 416
    Top = 152
    object mdConditionID: TIntegerField
      FieldName = 'ID'
    end
    object mdConditionNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
  object dsCondition: TDataSource
    DataSet = mdCondition
    Left = 448
    Top = 152
  end
  object mdPart: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D45000101000000011D000000C4E5E9F1F2E2E8F2E5EBFCEDE0FF20
      EAEEECEFEEEDE5EDF2E02028582901020000000115000000CCEDE8ECE0FF20EA
      EEECEFEEEDE5EDF2E020285929}
    SortOptions = []
    Left = 416
    Top = 184
    object mdPartID: TIntegerField
      FieldName = 'ID'
    end
    object mdPartNAME: TStringField
      FieldName = 'NAME'
      Size = 32
    end
  end
  object dsPart: TDataSource
    DataSet = mdPart
    Left = 456
    Top = 184
  end
  object mdTriggerType: TdxMemData
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F020000000400000003000300494400200000000100
      05004E414D45000101000000010A000000CFEE20E2F0E5ECE5EDE80103000000
      0116000000CFEE20F1F7E5F2F7E8EAF32028EEE4EEECE5F2F0F329}
    SortOptions = []
    Left = 416
    Top = 72
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
    Left = 456
    Top = 72
  end
end
