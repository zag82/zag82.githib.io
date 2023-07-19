object fmVInspector2: TfmVInspector2
  Left = 239
  Top = 455
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Visual Inspector - 2D'
  ClientHeight = 74
  ClientWidth = 497
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 497
    Height = 74
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Model'
      object GroupBox1: TGroupBox
        Left = 0
        Top = -2
        Width = 97
        Height = 48
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 33
          Height = 13
          Caption = 'Zoom :'
        end
        object Label2: TLabel
          Left = 48
          Top = 8
          Width = 26
          Height = 13
          Caption = '100%'
        end
        object ud1: TUpDown
          Left = 8
          Top = 24
          Width = 65
          Height = 17
          Min = -4
          Max = 10
          Orientation = udHorizontal
          TabOrder = 0
          OnClick = ud1Click
        end
      end
      object CheckBox1: TCheckBox
        Left = 256
        Top = 16
        Width = 57
        Height = 17
        Caption = 'Mesh'
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 104
        Top = 0
        Width = 65
        Height = 17
        Caption = 'Objects'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Left = 192
        Top = 0
        Width = 57
        Height = 17
        Caption = 'Bound'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object CheckBox4: TCheckBox
        Left = 192
        Top = 16
        Width = 57
        Height = 17
        Caption = 'Axises'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox5: TCheckBox
        Left = 256
        Top = 0
        Width = 33
        Height = 17
        Caption = 'Air'
        TabOrder = 5
        OnClick = CheckBox1Click
      end
      object Button1: TButton
        Left = 408
        Top = 0
        Width = 75
        Height = 20
        Caption = 'Center'
        TabOrder = 6
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 408
        Top = 24
        Width = 75
        Height = 20
        Caption = 'Normal'
        TabOrder = 7
        OnClick = Button2Click
      end
      object ComboBox1: TComboBox
        Left = 104
        Top = 16
        Width = 81
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = 'Wire'
        OnChange = CheckBox1Click
        Items.Strings = (
          'Wire'
          'Solid')
      end
      object CheckBox7: TCheckBox
        Left = 320
        Top = 0
        Width = 81
        Height = 17
        Caption = 'Equal scales'
        TabOrder = 9
        OnClick = CheckBox1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Field'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = -2
        Width = 96
        Height = 48
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 8
          Width = 33
          Height = 13
          Caption = 'Scale :'
        end
        object Label4: TLabel
          Left = 48
          Top = 8
          Width = 26
          Height = 13
          Caption = '100%'
        end
        object ud2: TUpDown
          Left = 8
          Top = 24
          Width = 65
          Height = 17
          Min = -4
          Max = 10
          Orientation = udHorizontal
          TabOrder = 0
          OnClick = ud2Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 192
        Top = -2
        Width = 104
        Height = 48
        Caption = 'Value'
        TabOrder = 2
        object ComboBox3: TComboBox
          Left = 8
          Top = 16
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Flux Density'
          OnChange = ComboBox2Change
          Items.Strings = (
            'Flux Density'
            'Intensity'
            'Potential'
            'Mu')
        end
      end
      object GroupBox5: TGroupBox
        Left = 296
        Top = -2
        Width = 88
        Height = 48
        Caption = 'Component'
        TabOrder = 3
        object ComboBox4: TComboBox
          Left = 8
          Top = 16
          Width = 73
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Module'
          OnChange = ComboBox2Change
          Items.Strings = (
            'Module'
            'R'
            'Z')
        end
      end
      object GroupBox6: TGroupBox
        Left = 384
        Top = -2
        Width = 105
        Height = 48
        Caption = 'Part'
        TabOrder = 4
        object ComboBox5: TComboBox
          Left = 8
          Top = 16
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Amplitude'
          OnChange = ComboBox2Change
          Items.Strings = (
            'Amplitude'
            'Real'
            'Imaginary')
        end
      end
      object GroupBox3: TGroupBox
        Left = 96
        Top = -2
        Width = 96
        Height = 48
        Caption = 'Visualuzation'
        TabOrder = 1
        object ComboBox2: TComboBox
          Left = 8
          Top = 16
          Width = 81
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          OnChange = ComboBox2Change
          Items.Strings = (
            'None'
            'Projection'
            'P-Slices'
            'G-Slices'
            'Smooth')
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Control'
      ImageIndex = 2
      object Label15: TLabel
        Left = 0
        Top = 28
        Width = 13
        Height = 13
        Caption = 'Dir'
        Visible = False
      end
      object CheckBox6: TCheckBox
        Left = 0
        Top = 0
        Width = 57
        Height = 17
        Caption = 'Rulers'
        TabOrder = 0
        OnClick = CheckBox6Click
      end
      object Panel1: TPanel
        Left = 56
        Top = 0
        Width = 265
        Height = 45
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 1
        Visible = False
        object Label5: TLabel
          Left = 0
          Top = 0
          Width = 56
          Height = 13
          Caption = 'Coordinates'
        end
        object Label6: TLabel
          Left = 0
          Top = 16
          Width = 20
          Height = 13
          Caption = 'R = '
        end
        object Label7: TLabel
          Left = 32
          Top = 16
          Width = 33
          Height = 13
          Caption = '15.125'
        end
        object Label8: TLabel
          Left = 80
          Top = 16
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Label9: TLabel
          Left = 136
          Top = 16
          Width = 19
          Height = 13
          Caption = 'Z = '
        end
        object Label10: TLabel
          Left = 168
          Top = 16
          Width = 36
          Height = 13
          Caption = '-45.125'
        end
        object Label11: TLabel
          Left = 216
          Top = 16
          Width = 16
          Height = 13
          Caption = 'mm'
          Color = clLime
          ParentColor = False
        end
        object Bevel1: TBevel
          Left = 121
          Top = 8
          Width = 7
          Height = 25
          Shape = bsRightLine
        end
        object uud_1: TUpDown
          Left = 104
          Top = 8
          Width = 16
          Height = 24
          Min = 1
          Position = 1
          TabOrder = 0
          OnClick = uud_1Click
        end
        object uud_2: TUpDown
          Left = 240
          Top = 8
          Width = 16
          Height = 24
          Min = 1
          Position = 1
          TabOrder = 1
          OnClick = uud_1Click
        end
      end
      object GroupBox7: TGroupBox
        Left = 328
        Top = -2
        Width = 161
        Height = 48
        Caption = 'Value'
        TabOrder = 2
        Visible = False
        object Label12: TLabel
          Left = 8
          Top = 16
          Width = 99
          Height = 13
          Caption = '< Value description >'
        end
        object Label13: TLabel
          Left = 8
          Top = 32
          Width = 39
          Height = 13
          Caption = 'Value = '
        end
        object Label14: TLabel
          Left = 56
          Top = 32
          Width = 33
          Height = 13
          Caption = '0.0125'
        end
      end
      object ComboBox6: TComboBox
        Left = 16
        Top = 24
        Width = 33
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'R'
        Visible = False
        OnChange = ComboBox6Change
        Items.Strings = (
          'R'
          'Z')
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Slices'
      ImageIndex = 3
      OnShow = TabSheet4Show
      object Label16: TLabel
        Left = 88
        Top = 0
        Width = 78
        Height = 13
        Caption = 'Number of slices'
      end
      object CheckBox8: TCheckBox
        Left = 0
        Top = 0
        Width = 73
        Height = 17
        Caption = 'Gray Scale'
        TabOrder = 0
        OnClick = CheckBox8Click
      end
      object CheckBox9: TCheckBox
        Left = 0
        Top = 16
        Width = 57
        Height = 17
        Caption = 'Black'
        TabOrder = 1
        OnClick = CheckBox8Click
      end
      object se: TSpinEdit
        Left = 88
        Top = 16
        Width = 81
        Height = 22
        MaxValue = 10000
        MinValue = 1
        TabOrder = 2
        Value = 10
        OnChange = CheckBox8Click
      end
    end
  end
end
