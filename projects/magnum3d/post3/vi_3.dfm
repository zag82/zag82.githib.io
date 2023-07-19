object fmVInspector3: TfmVInspector3
  Left = 295
  Top = 568
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Visual Inspector  - 3D'
  ClientHeight = 77
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label21: TLabel
    Left = 104
    Top = 16
    Width = 38
    Height = 13
    Caption = 'Label21'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 512
    Height = 77
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Model'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 81
        Height = 49
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 30
          Height = 13
          Caption = 'Zoom:'
        end
        object Label2: TLabel
          Left = 40
          Top = 8
          Width = 15
          Height = 13
          Caption = '1:1'
        end
        object ud1: TUpDown
          Left = 8
          Top = 24
          Width = 63
          Height = 21
          Min = -5
          Max = 10
          Orientation = udHorizontal
          TabOrder = 0
          OnClick = ud1Click
        end
      end
      object CheckBox1: TCheckBox
        Left = 88
        Top = 0
        Width = 73
        Height = 17
        Caption = 'Wire Model'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 88
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Solid Model'
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Left = 88
        Top = 32
        Width = 57
        Height = 17
        Caption = 'Bound'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object CheckBox4: TCheckBox
        Left = 168
        Top = 0
        Width = 81
        Height = 17
        Caption = 'Light Source'
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox5: TCheckBox
        Left = 168
        Top = 16
        Width = 89
        Height = 17
        Caption = 'Surface Mesh'
        TabOrder = 5
        OnClick = CheckBox1Click
      end
      object CheckBox6: TCheckBox
        Left = 168
        Top = 32
        Width = 33
        Height = 17
        Caption = 'Air'
        TabOrder = 6
        OnClick = CheckBox1Click
      end
      object Button1: TButton
        Left = 448
        Top = 6
        Width = 49
        Height = 17
        Caption = 'Center'
        TabOrder = 7
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 448
        Top = 30
        Width = 49
        Height = 17
        Caption = 'Normal'
        TabOrder = 8
        OnClick = Button2Click
      end
      object GroupBox1: TGroupBox
        Left = 256
        Top = 0
        Width = 89
        Height = 49
        Caption = 'Orientation'
        TabOrder = 9
        object SpeedButton1: TSpeedButton
          Left = 8
          Top = 16
          Width = 23
          Height = 22
          Caption = 'X'
          Flat = True
          OnClick = SpeedButton1Click
        end
        object SpeedButton2: TSpeedButton
          Left = 32
          Top = 16
          Width = 23
          Height = 22
          Caption = 'Y'
          Flat = True
          OnClick = SpeedButton2Click
        end
        object SpeedButton3: TSpeedButton
          Left = 56
          Top = 16
          Width = 23
          Height = 22
          Caption = 'Z'
          Flat = True
          OnClick = SpeedButton3Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 344
        Top = 0
        Width = 97
        Height = 49
        Caption = 'Symmetry'
        TabOrder = 10
        object CheckBox10: TCheckBox
          Left = 8
          Top = 20
          Width = 29
          Height = 17
          Caption = 'X'
          Enabled = False
          TabOrder = 0
        end
        object CheckBox11: TCheckBox
          Left = 36
          Top = 20
          Width = 29
          Height = 17
          Caption = 'Y'
          Enabled = False
          TabOrder = 1
        end
        object CheckBox12: TCheckBox
          Left = 64
          Top = 20
          Width = 29
          Height = 17
          Caption = 'Z'
          Enabled = False
          TabOrder = 2
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Field'
      ImageIndex = 1
      object Label5: TLabel
        Left = 88
        Top = 8
        Width = 27
        Height = 13
        Caption = 'Plane'
      end
      object Label6: TLabel
        Left = 136
        Top = 8
        Width = 58
        Height = 13
        Caption = 'Visualisation'
      end
      object Label7: TLabel
        Left = 216
        Top = 8
        Width = 27
        Height = 13
        Caption = 'Value'
      end
      object Label8: TLabel
        Left = 352
        Top = 8
        Width = 54
        Height = 13
        Caption = 'Component'
      end
      object Label9: TLabel
        Left = 424
        Top = 8
        Width = 19
        Height = 13
        Caption = 'Part'
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 81
        Height = 49
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 8
          Width = 30
          Height = 13
          Caption = 'Scale:'
        end
        object Label4: TLabel
          Left = 40
          Top = 8
          Width = 15
          Height = 13
          Caption = '1:1'
        end
        object ud2: TUpDown
          Left = 8
          Top = 24
          Width = 63
          Height = 21
          Min = -5
          Max = 12
          Orientation = udHorizontal
          TabOrder = 0
          OnClick = ud2Click
        end
      end
      object ComboBox1: TComboBox
        Left = 88
        Top = 24
        Width = 45
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'Y-Z'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Y-Z'
          'X-Z'
          'X-Y')
      end
      object ComboBox2: TComboBox
        Left = 136
        Top = 24
        Width = 75
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'None'
        OnChange = ComboBox1Change
        Items.Strings = (
          'None'
          'Map'
          'Projection'
          'Profile'
          'Slices')
      end
      object ComboBox3: TComboBox
        Left = 216
        Top = 24
        Width = 130
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'Flux Density'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Flux Density'
          'Intensity'
          'Scalar Potential'
          'Source Density'
          'Magnets'
          'Charge Density'
          'Boundary Conditions'
          'Eddy Current Density'
          'Vector Potential'
          'Poynting Vector'
          'Energy Density'
          'Permeability')
      end
      object ComboBox4: TComboBox
        Left = 352
        Top = 24
        Width = 60
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Module'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Module'
          'X'
          'Y'
          'Z'
          'Radial'
          'Fi'
          'Axial')
      end
      object ComboBox5: TComboBox
        Left = 416
        Top = 24
        Width = 70
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = 'Amplitude'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Amplitude'
          'Real'
          'Imaginary')
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Control'
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 177
        Height = 49
        Caption = 'Profile'
        TabOrder = 0
        object Label10: TLabel
          Left = 8
          Top = 20
          Width = 13
          Height = 13
          Caption = 'Dir'
        end
        object Label11: TLabel
          Left = 32
          Top = 20
          Width = 7
          Height = 13
          Caption = 'X'
        end
        object Label12: TLabel
          Left = 56
          Top = 8
          Width = 42
          Height = 13
          Caption = 'Distance'
        end
        object Label13: TLabel
          Left = 52
          Top = 26
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label14: TLabel
          Left = 96
          Top = 26
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Button4: TButton
          Left = 128
          Top = 30
          Width = 41
          Height = 17
          Caption = 'Scan'
          TabOrder = 0
          OnClick = Button4Click
        end
        object se1: TSpinEdit
          Left = 128
          Top = 8
          Width = 45
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = se1Change
        end
      end
      object GroupBox4: TGroupBox
        Left = 176
        Top = 0
        Width = 177
        Height = 49
        Caption = 'Graph'
        TabOrder = 1
        object Label15: TLabel
          Left = 62
          Top = 8
          Width = 42
          Height = 13
          Caption = 'Distance'
        end
        object Label16: TLabel
          Left = 40
          Top = 20
          Width = 7
          Height = 13
          Caption = 'X'
        end
        object Label17: TLabel
          Left = 58
          Top = 26
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label18: TLabel
          Left = 102
          Top = 26
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Button3: TButton
          Left = 8
          Top = 16
          Width = 25
          Height = 21
          Caption = 'Dir'
          TabOrder = 0
          OnClick = Button3Click
        end
        object Button5: TButton
          Left = 128
          Top = 30
          Width = 41
          Height = 17
          Caption = 'Scan'
          TabOrder = 1
          OnClick = Button5Click
        end
        object se2: TSpinEdit
          Left = 128
          Top = 8
          Width = 45
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 2
          Value = 1
          OnChange = se2Change
        end
      end
      object GroupBox5: TGroupBox
        Left = 352
        Top = 0
        Width = 145
        Height = 49
        Caption = 'Slices'
        TabOrder = 2
        object cbxColor: TCheckBox
          Left = 64
          Top = 8
          Width = 49
          Height = 17
          Caption = 'Color'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = cbxColorClick
        end
        object se: TSpinEdit
          Left = 8
          Top = 16
          Width = 49
          Height = 22
          Enabled = False
          MaxValue = 10000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = seChange
        end
        object cbx: TCheckBox
          Left = 64
          Top = 28
          Width = 49
          Height = 17
          Caption = 'Graph'
          Enabled = False
          TabOrder = 1
          OnClick = cbxClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Value'
      ImageIndex = 3
      object GroupBox6: TGroupBox
        Left = 0
        Top = 0
        Width = 137
        Height = 49
        Caption = 'Value of the point'
        TabOrder = 0
        object Label19: TLabel
          Left = 8
          Top = 16
          Width = 95
          Height = 13
          Caption = '<Value Description>'
        end
        object Label20: TLabel
          Left = 8
          Top = 32
          Width = 39
          Height = 13
          Caption = 'Value = '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label22: TLabel
          Left = 48
          Top = 32
          Width = 57
          Height = 13
          Caption = '0.00122458'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
      object GroupBox7: TGroupBox
        Left = 140
        Top = 0
        Width = 289
        Height = 49
        Caption = 'Navigate'
        TabOrder = 1
        object Label23: TLabel
          Left = 8
          Top = 16
          Width = 38
          Height = 13
          Caption = 'X (mm) :'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label24: TLabel
          Left = 104
          Top = 16
          Width = 38
          Height = 13
          Caption = 'Y (mm) :'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label25: TLabel
          Left = 200
          Top = 16
          Width = 38
          Height = 13
          Caption = 'Z (mm) :'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label26: TLabel
          Left = 8
          Top = 30
          Width = 18
          Height = 13
          Caption = '100'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 104
          Top = 30
          Width = 18
          Height = 13
          Caption = '100'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 200
          Top = 30
          Width = 18
          Height = 13
          Caption = '100'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object UpDown1: TUpDown
          Left = 72
          Top = 16
          Width = 17
          Height = 25
          Min = 1
          Position = 1
          TabOrder = 0
          OnClick = UpDown1Click
        end
        object UpDown2: TUpDown
          Left = 168
          Top = 16
          Width = 17
          Height = 25
          Min = 1
          Position = 1
          TabOrder = 1
          OnClick = UpDown1Click
        end
        object UpDown3: TUpDown
          Left = 264
          Top = 16
          Width = 17
          Height = 25
          Min = 1
          Position = 1
          TabOrder = 2
          OnClick = UpDown1Click
        end
      end
      object GroupBox8: TGroupBox
        Left = 432
        Top = 0
        Width = 73
        Height = 49
        Caption = 'Control'
        TabOrder = 2
        object cbPView: TCheckBox
          Left = 8
          Top = 20
          Width = 57
          Height = 17
          Caption = 'Preview'
          TabOrder = 0
          OnClick = cbPViewClick
        end
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 264
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer2Timer
    Left = 296
  end
end
