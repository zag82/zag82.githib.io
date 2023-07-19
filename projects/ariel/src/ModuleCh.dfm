inherited fmModuleCh: TfmModuleCh
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1091#1083#1103' '#1087#1088#1080#1073#1086#1088#1072
  ClientHeight = 137
  ClientWidth = 400
  ExplicitWidth = 406
  ExplicitHeight = 162
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel [0]
    Left = 0
    Top = 100
    Width = 400
    Height = 4
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 35
    ExplicitWidth = 313
  end
  inherited pnlControl: TPanel
    Top = 104
    Width = 400
    BevelOuter = bvNone
    ExplicitTop = 104
    ExplicitWidth = 400
    inherited btOk: TcxButton
      Left = 242
      ExplicitLeft = 242
    end
    inherited btCancel: TcxButton
      Left = 321
      ExplicitLeft = 321
    end
  end
  object lcmain: TdxLayoutControl [2]
    Left = 0
    Top = 0
    Width = 400
    Height = 100
    Align = alClient
    TabOrder = 1
    object cxDBSpinEdit1: TcxDBSpinEdit
      Left = 148
      Top = 10
      DataBinding.DataField = 'ID'
      DataBinding.DataSource = fmMainEloAquire.dsDeviceSlots
      Properties.Alignment.Horz = taCenter
      Properties.CanEdit = False
      Properties.MaxValue = 16.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.ReadOnly = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      TabOrder = 0
      Width = 121
    end
    object cxDBLookupComboBox1: TcxDBLookupComboBox
      Left = 148
      Top = 37
      DataBinding.DataField = 'TYPE'
      DataBinding.DataSource = fmMainEloAquire.dsDeviceSlots
      Properties.Alignment.Horz = taCenter
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dm.dsSlotType
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 1
      Width = 145
    end
    object cxDBSpinEdit2: TcxDBSpinEdit
      Left = 148
      Top = 64
      DataBinding.DataField = 'MUX_COUNT'
      DataBinding.DataSource = fmMainEloAquire.dsDeviceSlots
      Properties.Alignment.Horz = taCenter
      Properties.CanEdit = False
      Properties.MaxValue = 256.000000000000000000
      Properties.MinValue = 1.000000000000000000
      Properties.ReadOnly = False
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      TabOrder = 2
      Width = 121
    end
    object lcmainGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object lcmainItem1: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1057#1083#1086#1090':'
      Parent = lcmainGroup_Root
      Control = cxDBSpinEdit1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lcmainItem2: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1058#1080#1087' '#1084#1086#1076#1091#1083#1103':'
      Parent = lcmainGroup_Root
      Control = cxDBLookupComboBox1
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object lcmainItem3: TdxLayoutItem
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = #1050#1072#1085#1072#1083#1086#1074' '#1084#1091#1083#1100#1090#1080#1087#1083#1077#1082#1089#1086#1088#1072':'
      Parent = lcmainGroup_Root
      Control = cxDBSpinEdit2
      ControlOptions.ShowBorder = False
      Index = 2
    end
  end
end
