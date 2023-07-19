object fmAutoMag: TfmAutoMag
  Left = 199
  Top = 134
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MFL'
  ClientHeight = 273
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
    Height = 273
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Common'
      object Label10: TLabel
        Left = 16
        Top = 160
        Width = 69
        Height = 13
        Caption = 'Type of defect'
      end
      object Label11: TLabel
        Left = 16
        Top = 200
        Width = 57
        Height = 13
        Caption = 'Output Path'
      end
      object SpeedButton3: TSpeedButton
        Left = 168
        Top = 216
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton3Click
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 0
        Width = 193
        Height = 153
        Caption = 'DataBase Files'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 80
          Height = 13
          Caption = 'Project database'
        end
        object SpeedButton1: TSpeedButton
          Left = 160
          Top = 40
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SpeedButton1Click
        end
        object Label2: TLabel
          Left = 8
          Top = 72
          Width = 79
          Height = 13
          Caption = 'Mesh adoptation'
        end
        object SpeedButton2: TSpeedButton
          Left = 160
          Top = 88
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = SpeedButton2Click
        end
        object Label12: TLabel
          Left = 8
          Top = 124
          Width = 74
          Height = 13
          Caption = 'Adoptation type'
        end
        object Edit1: TEdit
          Left = 8
          Top = 40
          Width = 153
          Height = 21
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 8
          Top = 88
          Width = 153
          Height = 21
          TabOrder = 1
        end
        object cbx2: TComboBox
          Left = 88
          Top = 120
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = 'Plane'
          Items.Strings = (
            'Plane'
            'Volume')
        end
      end
      object GroupBox2: TGroupBox
        Left = 208
        Top = 0
        Width = 233
        Height = 201
        Caption = 'Gage Matrix'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 24
          Width = 35
          Height = 13
          Caption = 'N_axial'
        end
        object Label4: TLabel
          Left = 16
          Top = 64
          Width = 31
          Height = 13
          Caption = 'N_circ'
        end
        object Label5: TLabel
          Left = 16
          Top = 112
          Width = 46
          Height = 13
          Caption = 'Step axial'
        end
        object Label6: TLabel
          Left = 16
          Top = 152
          Width = 42
          Height = 13
          Caption = 'Step circ'
        end
        object Label7: TLabel
          Left = 88
          Top = 136
          Width = 16
          Height = 13
          Caption = 'mm'
        end
        object Label8: TLabel
          Left = 88
          Top = 176
          Width = 16
          Height = 13
          Caption = 'mm'
        end
        object Label9: TLabel
          Left = 136
          Top = 56
          Width = 53
          Height = 13
          Caption = 'LiftOff (mm)'
        end
        object Bevel1: TBevel
          Left = 112
          Top = 24
          Width = 9
          Height = 161
          Shape = bsRightLine
        end
        object Edit3: TEdit
          Left = 16
          Top = 40
          Width = 65
          Height = 21
          TabOrder = 0
          Text = '31'
        end
        object Edit4: TEdit
          Left = 16
          Top = 80
          Width = 65
          Height = 21
          TabOrder = 1
          Text = '13'
        end
        object Edit5: TEdit
          Left = 16
          Top = 128
          Width = 65
          Height = 21
          TabOrder = 2
          Text = '3.3'
        end
        object Edit6: TEdit
          Left = 16
          Top = 168
          Width = 65
          Height = 21
          TabOrder = 3
          Text = '8.2'
        end
        object CheckBox1: TCheckBox
          Left = 136
          Top = 32
          Width = 65
          Height = 17
          Caption = 'External'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object CheckListBox1: TCheckListBox
          Left = 136
          Top = 72
          Width = 73
          Height = 113
          ItemHeight = 13
          Items.Strings = (
            '0.5'
            '1.0'
            '1.5'
            '2.0'
            '2.5'
            '3.0'
            '3.5'
            '4.0'
            '4.5'
            '5.0'
            '5.5'
            '6.0'
            '6.5'
            '7.0'
            '7.5'
            '8.0'
            '8.5'
            '9.0'
            '9.5')
          TabOrder = 5
        end
        object CheckBox2: TCheckBox
          Left = 136
          Top = 16
          Width = 65
          Height = 17
          Caption = 'Internal'
          TabOrder = 6
        end
      end
      object ComboBox1: TComboBox
        Left = 16
        Top = 176
        Width = 177
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Crack_90'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Crack_90'
          'Crack_60'
          'Crack_45'
          'Crack_30'
          'Corrosion_90'
          'Corrosion_60'
          'Corrosion_45'
          'Corrosion_30'
          'Rectangle_90'
          'Rectangle_60'
          'Rectangle_45'
          'Rectangle_30'
          'Welding_1'
          'Welding_2'
          'Welding_3'
          'Welding_4'
          'Welding_Edge'
          'Welding_Root'
          'Welding_Down'
          'Welding_Root2')
      end
      object Button1: TButton
        Left = 224
        Top = 208
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
        TabOrder = 3
        OnClick = Button1Click
      end
      object Edit7: TEdit
        Left = 16
        Top = 216
        Width = 153
        Height = 21
        TabOrder = 4
      end
      object Button2: TButton
        Left = 344
        Top = 208
        Width = 75
        Height = 25
        Caption = 'Close'
        TabOrder = 5
        OnClick = Button2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Crack'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Depth (mm)'
        TabOrder = 0
        object CheckListBox2: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '0.4'
            '0.8'
            '1.2'
            '1.6'
            '2.0'
            '2.4'
            '2.8'
            '3.2'
            '3.6'
            '4.0'
            '4.4'
            '4.8'
            '5.2'
            '5.6'
            '6.0'
            '6.4'
            '6.8'
            '7.2'
            '7.6'
            '8.0')
          TabOrder = 0
        end
      end
      object GroupBox4: TGroupBox
        Left = 160
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Width (mm)'
        TabOrder = 1
        object CheckListBox3: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '0.5'
            '1.0'
            '1.5'
            '2.0'
            '2.5'
            '3.0'
            '3.5'
            '4.0')
          TabOrder = 0
        end
      end
      object GroupBox5: TGroupBox
        Left = 312
        Top = 8
        Width = 137
        Height = 233
        Caption = 'Length (mm)'
        TabOrder = 2
        object CheckListBox4: TCheckListBox
          Left = 8
          Top = 24
          Width = 121
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '20.0'
            '30.0'
            '40.0'
            '50.0'
            '60.0'
            '70.0'
            '80.0'
            '90.0'
            '100.0'
            '110.0'
            '120.0'
            '130.0'
            '140.0'
            '150.0')
          TabOrder = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Corrosion'
      ImageIndex = 2
      object GroupBox6: TGroupBox
        Left = 8
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Depth (mm)'
        TabOrder = 0
        object CheckListBox5: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '0.4'
            '0.8'
            '1.2'
            '1.6'
            '2.0'
            '2.4'
            '2.8'
            '3.2'
            '3.6'
            '4.0'
            '4.4'
            '4.8'
            '5.2'
            '5.6'
            '6.0'
            '6.4'
            '6.8'
            '7.2'
            '7.6'
            '8.0')
          TabOrder = 0
        end
      end
      object GroupBox7: TGroupBox
        Left = 160
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Diameter (mm)'
        TabOrder = 1
        object CheckListBox6: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '6.0'
            '8.0'
            '10.0'
            '12.0'
            '16.0'
            '20.0'
            '24.0'
            '28.0'
            '32.0'
            '36.0'
            '40.0'
            '44.0'
            '48.0'
            '52.0'
            '56.0'
            '60.0'
            '64.0')
          TabOrder = 0
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Rectangle'
      ImageIndex = 3
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Depth (mm)'
        TabOrder = 0
        object CheckListBox7: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '0.4'
            '0.8'
            '1.2'
            '1.6'
            '2.0'
            '2.4'
            '2.8'
            '3.2'
            '3.6'
            '4.0'
            '4.4'
            '4.8'
            '5.2'
            '5.6'
            '6.0'
            '6.4'
            '6.8'
            '7.2'
            '7.6'
            '8.0')
          TabOrder = 0
        end
      end
      object GroupBox9: TGroupBox
        Left = 160
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Length x Width (mm)'
        TabOrder = 1
        object CheckListBox8: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '6.0'
            '8.0'
            '10.0'
            '12.0'
            '16.0'
            '20.0'
            '24.0'
            '28.0'
            '32.0'
            '36.0'
            '40.0'
            '44.0'
            '48.0'
            '52.0'
            '56.0'
            '60.0'
            '64.0')
          TabOrder = 0
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Welding'
      ImageIndex = 4
      object GroupBox10: TGroupBox
        Left = 8
        Top = 8
        Width = 145
        Height = 233
        Caption = 'Length (mm)'
        TabOrder = 0
        object CheckListBox9: TCheckListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 201
          ItemHeight = 13
          Items.Strings = (
            '20'
            '30'
            '40'
            '50'
            '60'
            '70'
            '80'
            '90'
            '100'
            '110'
            '120'
            '130'
            '140'
            '150')
          TabOrder = 0
        end
      end
    end
  end
  object oDlg1: TOpenDialog
    DefaultExt = 'mg3'
    Filter = 'MagNum3D Files|*.mg3'
    Left = 120
    Top = 32
  end
  object oDlg2: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Mesh Files|*.txt'
    Left = 88
    Top = 32
  end
end
