object fmAutoEC: TfmAutoEC
  Left = 258
  Top = 278
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Automation Eddy Current'
  ClientHeight = 313
  ClientWidth = 457
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 457
    Height = 313
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Initial'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 193
        Height = 185
        Caption = 'Control'
        TabOrder = 0
        object SpeedButton3: TSpeedButton
          Left = 160
          Top = 88
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SpeedButton3Click
        end
        object Label11: TLabel
          Left = 8
          Top = 72
          Width = 57
          Height = 13
          Caption = 'Output Path'
        end
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 53
          Height = 13
          Caption = 'Model data'
        end
        object SpeedButton1: TSpeedButton
          Left = 160
          Top = 40
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SpeedButton1Click
        end
        object Label14: TLabel
          Left = 112
          Top = 160
          Width = 71
          Height = 13
          Caption = 'Time = 0:00:00'
        end
        object Edit7: TEdit
          Left = 8
          Top = 88
          Width = 153
          Height = 21
          TabOrder = 0
        end
        object RadioGroup1: TRadioGroup
          Left = 8
          Top = 120
          Width = 97
          Height = 57
          Caption = 'Move'
          ItemIndex = 0
          Items.Strings = (
            'Defect'
            'Gage')
          TabOrder = 1
        end
        object Edit1: TEdit
          Left = 8
          Top = 40
          Width = 153
          Height = 21
          TabOrder = 2
        end
      end
      object GroupBox5: TGroupBox
        Left = 200
        Top = 0
        Width = 249
        Height = 249
        Caption = 'Gage'
        TabOrder = 1
        object Label5: TLabel
          Left = 16
          Top = 72
          Width = 90
          Height = 13
          Caption = 'Start Gage position'
        end
        object Label6: TLabel
          Left = 16
          Top = 120
          Width = 87
          Height = 13
          Caption = 'End Gage position'
        end
        object Label7: TLabel
          Left = 16
          Top = 168
          Width = 86
          Height = 13
          Caption = 'Gage moving step'
        end
        object Label8: TLabel
          Left = 104
          Top = 96
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Label9: TLabel
          Left = 104
          Top = 144
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Label10: TLabel
          Left = 104
          Top = 192
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Label2: TLabel
          Left = 16
          Top = 24
          Width = 33
          Height = 13
          Caption = 'Coil #1'
        end
        object Label3: TLabel
          Left = 136
          Top = 24
          Width = 33
          Height = 13
          Caption = 'Coil #2'
        end
        object Bevel1: TBevel
          Left = 128
          Top = 72
          Width = 9
          Height = 137
          Shape = bsLeftLine
        end
        object Label13: TLabel
          Left = 148
          Top = 80
          Width = 61
          Height = 13
          Caption = 'Pipe Material'
        end
        object Label4: TLabel
          Left = 145
          Top = 128
          Width = 32
          Height = 13
          Caption = 'Defect'
        end
        object Label12: TLabel
          Left = 148
          Top = 176
          Width = 69
          Height = 13
          Caption = 'Pipe thickness'
        end
        object Edit2: TEdit
          Left = 16
          Top = 88
          Width = 81
          Height = 21
          TabOrder = 0
        end
        object Edit3: TEdit
          Left = 16
          Top = 136
          Width = 81
          Height = 21
          TabOrder = 1
        end
        object Edit4: TEdit
          Left = 16
          Top = 184
          Width = 81
          Height = 21
          TabOrder = 2
        end
        object ComboBox4: TComboBox
          Left = 16
          Top = 40
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 3
        end
        object ComboBox5: TComboBox
          Left = 136
          Top = 40
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 4
        end
        object ComboBox3: TComboBox
          Left = 152
          Top = 96
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 5
        end
        object ComboBox1: TComboBox
          Left = 152
          Top = 144
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 6
        end
        object ComboBox2: TComboBox
          Left = 152
          Top = 192
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 7
          Text = '1.5'
          Items.Strings = (
            '1.4'
            '1.5')
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 224
          Width = 65
          Height = 17
          Caption = 'Internal'
          TabOrder = 8
        end
      end
      object Button1: TButton
        Left = 8
        Top = 200
        Width = 75
        Height = 25
        Caption = 'Run'
        Default = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 96
        Top = 200
        Width = 97
        Height = 25
        Caption = 'Close'
        TabOrder = 3
        OnClick = Button2Click
      end
      object CheckBox2: TCheckBox
        Left = 200
        Top = 256
        Width = 193
        Height = 17
        Caption = 'Use different frequencies settings'
        TabOrder = 4
      end
      object Button3: TButton
        Left = 8
        Top = 232
        Width = 75
        Height = 25
        Caption = 'Run 3D'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = Button3Click
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 260
        Width = 145
        Height = 17
        Caption = 'Auto-close when finished'
        TabOrder = 6
      end
      object Button4: TButton
        Left = 96
        Top = 232
        Width = 97
        Height = 25
        Caption = 'Run 2D (deposit)'
        TabOrder = 7
        OnClick = Button4Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Defect'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 137
        Height = 281
        Caption = 'Depth (%)'
        TabOrder = 0
        object CheckListBox1: TCheckListBox
          Left = 8
          Top = 16
          Width = 121
          Height = 257
          ItemHeight = 13
          Items.Strings = (
            '0'
            '10'
            '20'
            '30'
            '40'
            '50'
            '60'
            '70'
            '80'
            '90'
            '100')
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 144
        Top = 0
        Width = 137
        Height = 281
        Caption = 'Width (mm)'
        TabOrder = 1
        object CheckListBox2: TCheckListBox
          Left = 8
          Top = 16
          Width = 121
          Height = 257
          ItemHeight = 13
          Items.Strings = (
            '1.0'
            '2.0'
            '3.0'
            '4.0'
            '5.0'
            '6.0'
            '8.0'
            '10.0'
            '12.0'
            '14.0'
            '16.0'
            '18.0'
            '20.0')
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 288
        Top = 0
        Width = 137
        Height = 281
        Caption = 'Angle (degrees)'
        TabOrder = 2
        object CheckListBox3: TCheckListBox
          Left = 8
          Top = 16
          Width = 121
          Height = 257
          ItemHeight = 13
          Items.Strings = (
            '2'
            '4'
            '6'
            '8'
            '10'
            '14'
            '18'
            '22'
            '26'
            '30'
            '36'
            '40'
            '50'
            '54'
            '60'
            '72'
            '90'
            '108'
            '126'
            '144'
            '162'
            '180'
            '270'
            '360')
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Deposite'
      ImageIndex = 2
      object Label15: TLabel
        Left = 352
        Top = 8
        Width = 37
        Height = 13
        Caption = 'Material'
      end
      object GroupBox6: TGroupBox
        Left = 0
        Top = 0
        Width = 169
        Height = 281
        Caption = 'Mu'
        TabOrder = 0
        object CheckListBox4: TCheckListBox
          Left = 8
          Top = 16
          Width = 153
          Height = 257
          ItemHeight = 13
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '7'
            '10'
            '15'
            '20'
            '30'
            '50')
          TabOrder = 0
        end
      end
      object GroupBox7: TGroupBox
        Left = 176
        Top = 0
        Width = 169
        Height = 281
        Caption = 'Sigma (MSm/m)'
        TabOrder = 1
        object CheckListBox5: TCheckListBox
          Left = 8
          Top = 16
          Width = 153
          Height = 257
          ItemHeight = 13
          Items.Strings = (
            '0.50'
            '1.00'
            '3.00'
            '5.00'
            '10.0'
            '15.0'
            '20.0'
            '25.0'
            '30.0'
            '40.0'
            '56.0')
          TabOrder = 0
        end
      end
      object ComboBox6: TComboBox
        Left = 352
        Top = 24
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
    end
  end
  object oDlg1: TOpenDialog
    DefaultExt = 'mg3'
    Filter = 'MagNum3D Files|*.mg3'
    Left = 116
    Top = 144
  end
end
