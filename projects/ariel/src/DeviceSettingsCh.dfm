inherited fmDeviceSettingsCh: TfmDeviceSettingsCh
  ActiveControl = cxDBTextEdit1
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1082#1072#1085#1072#1083#1072' '#1087#1088#1080#1073#1086#1088#1072' PL-500'
  ClientHeight = 346
  ClientWidth = 411
  ExplicitWidth = 417
  ExplicitHeight = 374
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlControl: TPanel
    Top = 313
    Width = 411
    BevelOuter = bvNone
    ExplicitTop = 313
    ExplicitWidth = 411
    inherited btOk: TcxButton
      Left = 253
      ExplicitLeft = 253
    end
    inherited btCancel: TcxButton
      Left = 332
      ExplicitLeft = 332
    end
  end
  object dxLayoutControl1: TdxLayoutControl [1]
    Left = 0
    Top = 0
    Width = 411
    Height = 313
    Align = alClient
    TabOrder = 1
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 156
      Top = 10
      DataBinding.DataField = 'FREQ'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 0
      Width = 121
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 156
      Top = 37
      DataBinding.DataField = 'DRV'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 1
      Width = 121
    end
    object cxDBTextEdit3: TcxDBTextEdit
      Left = 156
      Top = 64
      DataBinding.DataField = 'AMP'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 2
      Width = 121
    end
    object cxDBTextEdit5: TcxDBTextEdit
      Left = 156
      Top = 145
      DataBinding.DataField = 'LOW_PASS'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 5
      Width = 121
    end
    object cxDBTextEdit6: TcxDBTextEdit
      Left = 156
      Top = 118
      DataBinding.DataField = 'HIGH_PASS'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.Kind = lfStandard
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.Kind = lfStandard
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfStandard
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfStandard
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 4
      Width = 121
    end
    object cxDBLookupComboBox1: TcxDBLookupComboBox
      Left = 156
      Top = 91
      DataBinding.DataField = 'FILTER_TYPE'
      DataBinding.DataSource = ds
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dm.dsFilterType
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 3
      Width = 145
    end
    object cxDBTextEdit4: TcxDBTextEdit
      Left = 156
      Top = 172
      DataBinding.DataField = 'PHASE'
      DataBinding.DataSource = ds
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
    object cxDBTextEdit7: TcxDBTextEdit
      Left = 156
      Top = 199
      DataBinding.DataField = 'SPREADX'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 7
      Width = 121
    end
    object cxDBTextEdit8: TcxDBTextEdit
      Left = 156
      Top = 226
      DataBinding.DataField = 'SPREADY'
      DataBinding.DataSource = ds
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
    object cxDBTextEdit9: TcxDBTextEdit
      Left = 156
      Top = 253
      DataBinding.DataField = 'DOTX'
      DataBinding.DataSource = ds
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 9
      Width = 121
    end
    object cxDBTextEdit10: TcxDBTextEdit
      Left = 156
      Top = 280
      DataBinding.DataField = 'DOTY'
      DataBinding.DataSource = ds
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
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutControl1Item1: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1063#1072#1089#1090#1086#1090#1072' ('#1043#1094'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item2: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1042#1086#1079#1073#1091#1078#1076#1077#1085#1080#1077' (%):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit2
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item3: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1059#1089#1080#1083#1077#1085#1080#1077' ('#1076#1041'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit3
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Item4: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1058#1080#1087' '#1092#1080#1083#1100#1090#1088#1072':'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBLookupComboBox1
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutControl1Item6: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1053#1080#1078#1085#1103#1103' '#1095#1072#1089#1090#1086#1090#1072' '#1089#1088#1077#1079#1072' ('#1043#1094'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit6
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutControl1Item5: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1042#1077#1088#1093#1085#1103#1103' '#1095#1072#1089#1090#1086#1090#1072' '#1089#1088#1077#1079#1072' ('#1043#1094'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit5
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutControl1Item7: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1060#1072#1079#1072' ('#1075#1088#1072#1076#1091#1089#1099'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit4
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object dxLayoutControl1Item8: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1059#1089#1080#1083#1077#1085#1080#1077' X ('#1076#1041'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit7
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutControl1Item9: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1059#1089#1080#1083#1077#1085#1080#1077' Y ('#1076#1041'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit8
      ControlOptions.ShowBorder = False
      Index = 8
    end
    object dxLayoutControl1Item10: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1057#1084#1077#1097#1077#1085#1080#1077' '#1085#1091#1083#1103' '#1087#1086' X ('#1084#1042'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit9
      ControlOptions.ShowBorder = False
      Index = 9
    end
    object dxLayoutControl1Item11: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1057#1084#1077#1097#1077#1085#1080#1077' '#1085#1091#1083#1103' '#1087#1086' Y ('#1084#1042'):'
      Parent = dxLayoutControl1Group_Root
      Control = cxDBTextEdit10
      ControlOptions.ShowBorder = False
      Index = 10
    end
  end
  object ds: TDataSource
    DataSet = fmDeviceSettings.mdDeviceData
    Left = 8
    Top = 40
  end
end
