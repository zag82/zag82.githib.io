object fmPreprocessor: TfmPreprocessor
  Left = 210
  Top = 170
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'PreProcessor'
  ClientHeight = 350
  ClientWidth = 667
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
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 538
    Top = 0
    Width = 129
    Height = 350
    Align = alRight
    Caption = 'Task'
    Items.Strings = (
      '0 - ElectroStatic'
      '1 - Current Flow'
      '2 - MagnetoStatic'
      '3 - Steady State'
      '4 - Time Dependent'
      '5 - Eddy Current')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 538
    Height = 350
    ActivePage = TabSheet4
    Align = alClient
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrack = True
    ParentFont = False
    TabHeight = 24
    TabOrder = 1
    object TabSheet1: TTabSheet
      object Label1: TLabel
        Left = 8
        Top = 0
        Width = 519
        Height = 108
        Caption = 'MagNum 3D'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clGreen
        Font.Height = -96
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 0
        Top = 304
        Width = 151
        Height = 14
        Caption = 'Moscow 2002 , MPEI , ETI Dept'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Times New Roman'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 0
        Top = 120
        Width = 182
        Height = 24
        Caption = 'Axial && 3D solutions'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -21
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Materials'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      OnExit = TabSheet2Exit
      OnShow = TabSheet2Show
      object Label21: TLabel
        Left = 368
        Top = 12
        Width = 50
        Height = 13
        Caption = 'Frequency'
      end
      object Label22: TLabel
        Left = 0
        Top = 8
        Width = 74
        Height = 13
        Caption = 'Default Material'
      end
      object Label23: TLabel
        Left = 0
        Top = 32
        Width = 48
        Height = 13
        Caption = 'Materials :'
      end
      object Label24: TLabel
        Left = 176
        Top = 8
        Width = 59
        Height = 13
        Caption = 'NMaterials ='
      end
      object Label25: TLabel
        Left = 240
        Top = 8
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label77: TLabel
        Left = 504
        Top = 12
        Width = 13
        Height = 13
        Caption = 'Hz'
        Color = clLime
        ParentColor = False
      end
      object Edit5: TEdit
        Left = 424
        Top = 8
        Width = 73
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object se2: TSpinEdit
        Left = 80
        Top = 4
        Width = 41
        Height = 22
        MaxValue = 1
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object ListBox2: TListBox
        Left = 0
        Top = 48
        Width = 161
        Height = 153
        ItemHeight = 13
        Items.Strings = (
          'Material - 0'
          'Material - 1')
        TabOrder = 2
        OnClick = ListBox2Click
      end
      object Button4: TButton
        Left = 168
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Add'
        Default = True
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 168
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 4
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 168
        Top = 112
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 5
        OnClick = Button6Click
      end
      object GroupBox2: TGroupBox
        Left = 248
        Top = 48
        Width = 281
        Height = 153
        Caption = 'Material properties'
        TabOrder = 6
        object Label26: TLabel
          Left = 16
          Top = 28
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object Label27: TLabel
          Left = 16
          Top = 52
          Width = 15
          Height = 13
          Caption = 'Mu'
        end
        object Label28: TLabel
          Left = 16
          Top = 76
          Width = 18
          Height = 13
          Caption = 'Eps'
        end
        object Label29: TLabel
          Left = 16
          Top = 100
          Width = 29
          Height = 13
          Caption = 'Sigma'
        end
        object Label30: TLabel
          Left = 168
          Top = 52
          Width = 59
          Height = 13
          Caption = 'Anisotropy X'
        end
        object Label31: TLabel
          Left = 168
          Top = 76
          Width = 59
          Height = 13
          Caption = 'Anisotropy Y'
        end
        object Label32: TLabel
          Left = 168
          Top = 100
          Width = 59
          Height = 13
          Caption = 'Anisotropy Z'
        end
        object Label33: TLabel
          Left = 120
          Top = 128
          Width = 24
          Height = 13
          Caption = 'Color'
        end
        object Shape5: TShape
          Left = 8
          Top = 120
          Width = 105
          Height = 25
          OnContextPopup = Shape5ContextPopup
        end
        object Label103: TLabel
          Left = 104
          Top = 100
          Width = 37
          Height = 13
          Caption = 'MSm/m'
          Color = clLime
          ParentColor = False
        end
        object Bevel4: TBevel
          Left = 152
          Top = 48
          Width = 9
          Height = 73
          Shape = bsLeftLine
        end
        object Edit6: TEdit
          Left = 56
          Top = 24
          Width = 217
          Height = 21
          TabOrder = 0
        end
        object Edit7: TEdit
          Left = 56
          Top = 48
          Width = 57
          Height = 21
          TabOrder = 1
          Text = '1'
        end
        object Edit8: TEdit
          Left = 56
          Top = 72
          Width = 57
          Height = 21
          TabOrder = 2
          Text = '1'
        end
        object Edit9: TEdit
          Left = 56
          Top = 96
          Width = 41
          Height = 21
          ParentShowHint = False
          ShowHint = False
          TabOrder = 3
          Text = '1E-20'
        end
        object Edit10: TEdit
          Left = 232
          Top = 48
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '1'
        end
        object Edit11: TEdit
          Left = 232
          Top = 72
          Width = 41
          Height = 21
          TabOrder = 5
          Text = '1'
        end
        object Edit12: TEdit
          Left = 232
          Top = 96
          Width = 41
          Height = 21
          TabOrder = 6
          Text = '1'
        end
      end
      object GroupBox7: TGroupBox
        Left = 0
        Top = 208
        Width = 185
        Height = 105
        Caption = 'Non linear parameters'
        TabOrder = 7
        object Label71: TLabel
          Left = 8
          Top = 20
          Width = 57
          Height = 33
          Alignment = taCenter
          AutoSize = False
          Caption = 'NonLinear property'
          WordWrap = True
        end
        object Label72: TLabel
          Left = 8
          Top = 56
          Width = 64
          Height = 13
          Caption = 'Characteristic'
        end
        object SpeedButton4: TSpeedButton
          Left = 152
          Top = 72
          Width = 23
          Height = 22
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            88888888888888888888000000000008888800333333333088880B0333333333
            08880FB03333333330880BFB0333333333080FBFB000000000000BFBFBFBFB08
            88880FBFBFBFBF0888880BFB0000000888888000888888880008888888888888
            8008888888880888080888888888800088888888888888888888}
          OnClick = SpeedButton4Click
        end
        object ComboBox9: TComboBox
          Left = 72
          Top = 24
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'None'
          Items.Strings = (
            'None'
            'Mu')
        end
        object Edit62: TEdit
          Left = 8
          Top = 72
          Width = 145
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
      end
      object Chart1: TChart
        Left = 192
        Top = 208
        Width = 336
        Height = 105
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Title.Text.Strings = (
          'Magnetization [B-H] curve')
        BottomAxis.Title.Caption = 'H (A/m)'
        LeftAxis.AxisValuesFormat = '#,##0.####'
        LeftAxis.Title.Caption = 'B (Tesla)'
        Legend.Visible = False
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        TabOrder = 8
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = clRed
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Objects'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      OnExit = TabSheet3Exit
      OnShow = TabSheet3Show
      object Label35: TLabel
        Left = 200
        Top = 0
        Width = 50
        Height = 13
        Caption = 'Object List'
      end
      object Label73: TLabel
        Left = 360
        Top = 0
        Width = 113
        Height = 13
        Caption = 'Solution parameters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label142: TLabel
        Left = 24
        Top = 224
        Width = 44
        Height = 13
        Caption = 'Label142'
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 216
        Width = 530
        Height = 100
        ActivePage = TabSheet8
        Align = alBottom
        TabOrder = 0
        object TabSheet8: TTabSheet
          Caption = 'Block'
          object Label128: TLabel
            Left = 168
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label129: TLabel
            Left = 168
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label130: TLabel
            Left = 168
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label131: TLabel
            Left = 72
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label132: TLabel
            Left = 72
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label133: TLabel
            Left = 72
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label143: TLabel
            Left = 240
            Top = 8
            Width = 44
            Height = 13
            Caption = 'Label143'
          end
          object StaticText7: TStaticText
            Left = 0
            Top = 4
            Width = 27
            Height = 17
            Caption = 'x1 = '
            TabOrder = 0
          end
          object StaticText8: TStaticText
            Left = 0
            Top = 28
            Width = 27
            Height = 17
            Caption = 'y1 = '
            TabOrder = 1
          end
          object StaticText9: TStaticText
            Left = 0
            Top = 52
            Width = 27
            Height = 17
            Caption = 'z1 = '
            TabOrder = 2
          end
          object StaticText10: TStaticText
            Left = 96
            Top = 4
            Width = 27
            Height = 17
            Caption = 'x2 = '
            TabOrder = 3
          end
          object StaticText11: TStaticText
            Left = 96
            Top = 28
            Width = 27
            Height = 17
            Caption = 'y2 = '
            TabOrder = 4
          end
          object StaticText12: TStaticText
            Left = 96
            Top = 52
            Width = 27
            Height = 17
            Caption = 'z2 = '
            TabOrder = 5
          end
          object Edit13: TEdit
            Left = 24
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 6
            Text = '0'
          end
          object Edit14: TEdit
            Left = 24
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 7
            Text = '0'
          end
          object Edit15: TEdit
            Left = 24
            Top = 48
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 8
            Text = '0'
          end
          object Edit16: TEdit
            Left = 120
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 9
            Text = '0'
          end
          object Edit17: TEdit
            Left = 120
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 10
            Text = '0'
          end
          object Edit18: TEdit
            Left = 120
            Top = 48
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 11
            Text = '0'
          end
          object Edit41: TEdit
            Left = 248
            Top = 32
            Width = 41
            Height = 21
            TabOrder = 13
            Text = '0'
          end
          object Edit42: TEdit
            Left = 312
            Top = 32
            Width = 41
            Height = 21
            TabOrder = 14
            Text = '0'
          end
          object Edit43: TEdit
            Left = 376
            Top = 32
            Width = 41
            Height = 21
            TabOrder = 15
            Text = '0'
          end
          object PageControl3: TPageControl
            Left = 216
            Top = 0
            Width = 305
            Height = 73
            ActivePage = TabSheet10
            TabOrder = 12
            object TabSheet10: TTabSheet
              Caption = 'Current'
              object Label124: TLabel
                Left = 24
                Top = 28
                Width = 40
                Height = 13
                Caption = 'A/mm^2'
                Color = clLime
                ParentColor = False
              end
              object Label125: TLabel
                Left = 104
                Top = 28
                Width = 40
                Height = 13
                Caption = 'A/mm^2'
                Color = clLime
                ParentColor = False
              end
              object Label126: TLabel
                Left = 168
                Top = 28
                Width = 40
                Height = 13
                Caption = 'A/mm^2'
                Color = clLime
                ParentColor = False
              end
              object Label127: TLabel
                Left = 240
                Top = 28
                Width = 38
                Height = 13
                Caption = 'degrees'
                Color = clLime
                ParentColor = False
              end
              object StaticText23: TStaticText
                Left = 8
                Top = 12
                Width = 20
                Height = 17
                Caption = 'Jx='
                TabOrder = 0
              end
              object StaticText24: TStaticText
                Left = 80
                Top = 12
                Width = 20
                Height = 17
                Caption = 'Jy='
                TabOrder = 1
              end
              object StaticText25: TStaticText
                Left = 152
                Top = 12
                Width = 20
                Height = 17
                Caption = 'Jz='
                TabOrder = 2
              end
              object StaticText26: TStaticText
                Left = 216
                Top = 12
                Width = 25
                Height = 17
                Caption = 'Phi='
                TabOrder = 3
              end
              object Edit31: TEdit
                Left = 24
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 4
                Text = '0'
              end
              object Edit32: TEdit
                Left = 104
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 5
                Text = '0'
              end
              object Edit33: TEdit
                Left = 168
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 6
                Text = '0'
              end
              object Edit34: TEdit
                Left = 240
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 7
                Text = '0'
              end
            end
            object TabSheet11: TTabSheet
              Caption = 'Magnet'
              ImageIndex = 1
              object Label121: TLabel
                Left = 152
                Top = 12
                Width = 26
                Height = 13
                Caption = 'Tesla'
                Color = clLime
                ParentColor = False
              end
              object Label122: TLabel
                Left = 64
                Top = 12
                Width = 26
                Height = 13
                Caption = 'Tesla'
                Color = clLime
                ParentColor = False
              end
              object Label123: TLabel
                Left = 240
                Top = 12
                Width = 26
                Height = 13
                Caption = 'Tesla'
                Color = clLime
                ParentColor = False
              end
              object StaticText34: TStaticText
                Left = 8
                Top = 12
                Width = 22
                Height = 17
                Caption = 'Bx='
                TabOrder = 0
              end
              object StaticText35: TStaticText
                Left = 96
                Top = 12
                Width = 22
                Height = 17
                Caption = 'By='
                TabOrder = 1
              end
              object StaticText36: TStaticText
                Left = 184
                Top = 12
                Width = 22
                Height = 17
                Caption = 'Bz='
                TabOrder = 2
              end
              object Edit48: TEdit
                Left = 24
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 3
                Text = '0'
              end
              object Edit49: TEdit
                Left = 112
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 4
                Text = '0'
              end
              object Edit50: TEdit
                Left = 200
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 5
                Text = '0'
              end
            end
            object TabSheet12: TTabSheet
              Caption = 'Charge'
              ImageIndex = 2
              object Label120: TLabel
                Left = 80
                Top = 12
                Width = 34
                Height = 13
                Caption = 'Kl/m^3'
                Color = clLime
                ParentColor = False
              end
              object StaticText28: TStaticText
                Left = 0
                Top = 12
                Width = 27
                Height = 17
                Caption = 'Ro ='
                TabOrder = 0
              end
              object Edit35: TEdit
                Left = 32
                Top = 8
                Width = 49
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 1
                Text = '0'
              end
            end
            object TabSheet13: TTabSheet
              Caption = 'None'
              ImageIndex = 3
              object StaticText22: TStaticText
                Left = 80
                Top = 16
                Width = 127
                Height = 17
                Caption = 'Object without any source'
                TabOrder = 0
              end
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = 'Sector'
          ImageIndex = 1
          object Label144: TLabel
            Left = 48
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label145: TLabel
            Left = 48
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label146: TLabel
            Left = 48
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label147: TLabel
            Left = 120
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label148: TLabel
            Left = 120
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label149: TLabel
            Left = 120
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label150: TLabel
            Left = 192
            Top = 4
            Width = 18
            Height = 13
            Caption = 'deg'
            Color = clLime
            ParentColor = False
          end
          object Label151: TLabel
            Left = 192
            Top = 28
            Width = 18
            Height = 13
            Caption = 'deg'
            Color = clLime
            ParentColor = False
          end
          object StaticText13: TStaticText
            Left = 0
            Top = 4
            Width = 18
            Height = 17
            Caption = 'x ='
            TabOrder = 0
          end
          object StaticText14: TStaticText
            Left = 0
            Top = 28
            Width = 18
            Height = 17
            Caption = 'y ='
            TabOrder = 1
          end
          object StaticText15: TStaticText
            Left = 0
            Top = 52
            Width = 18
            Height = 17
            Caption = 'z ='
            TabOrder = 2
          end
          object StaticText16: TStaticText
            Left = 72
            Top = 4
            Width = 16
            Height = 17
            Caption = 'r ='
            TabOrder = 3
          end
          object StaticText17: TStaticText
            Left = 72
            Top = 28
            Width = 21
            Height = 17
            Caption = 'R ='
            TabOrder = 4
          end
          object StaticText18: TStaticText
            Left = 72
            Top = 52
            Width = 21
            Height = 17
            Caption = 'H ='
            TabOrder = 5
          end
          object StaticText19: TStaticText
            Left = 144
            Top = 4
            Width = 19
            Height = 17
            Caption = 'Al='
            TabOrder = 6
          end
          object StaticText20: TStaticText
            Left = 144
            Top = 28
            Width = 20
            Height = 17
            Caption = 'Bt='
            TabOrder = 7
          end
          object StaticText21: TStaticText
            Left = 144
            Top = 52
            Width = 17
            Height = 17
            Caption = 'Dir'
            TabOrder = 8
          end
          object Edit19: TEdit
            Left = 16
            Top = 0
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 9
            Text = '0'
          end
          object Edit20: TEdit
            Left = 16
            Top = 24
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 10
            Text = '0'
          end
          object Edit21: TEdit
            Left = 16
            Top = 48
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 11
            Text = '0'
          end
          object Edit22: TEdit
            Left = 88
            Top = 0
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 12
            Text = '0'
          end
          object Edit23: TEdit
            Left = 88
            Top = 24
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 13
            Text = '0'
          end
          object Edit26: TEdit
            Left = 88
            Top = 48
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 14
            Text = '0'
          end
          object Edit27: TEdit
            Left = 160
            Top = 0
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 15
            Text = '0'
          end
          object Edit30: TEdit
            Left = 160
            Top = 24
            Width = 33
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 16
            Text = '0'
          end
          object ComboBox5: TComboBox
            Left = 160
            Top = 48
            Width = 49
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 17
            Text = 'X'
            Items.Strings = (
              'X'
              'Y'
              'Z')
          end
          object PageControl4: TPageControl
            Left = 216
            Top = 0
            Width = 305
            Height = 73
            ActivePage = TabSheet14
            TabOrder = 18
            object TabSheet14: TTabSheet
              Caption = 'Current'
              object Label138: TLabel
                Left = 32
                Top = 28
                Width = 40
                Height = 13
                Caption = 'A/mm^2'
                Color = clLime
                ParentColor = False
              end
              object Label139: TLabel
                Left = 96
                Top = 28
                Width = 40
                Height = 13
                Caption = 'A/mm^2'
                Color = clLime
                ParentColor = False
              end
              object Label140: TLabel
                Left = 168
                Top = 28
                Width = 40
                Height = 13
                Caption = 'A/mm^2'
                Color = clLime
                ParentColor = False
              end
              object Label141: TLabel
                Left = 240
                Top = 28
                Width = 38
                Height = 13
                Caption = 'degrees'
                Color = clLime
                ParentColor = False
              end
              object StaticText30: TStaticText
                Left = 8
                Top = 12
                Width = 18
                Height = 17
                Caption = 'Jr='
                TabOrder = 0
              end
              object StaticText31: TStaticText
                Left = 80
                Top = 12
                Width = 20
                Height = 17
                Caption = 'Jfi='
                TabOrder = 1
              end
              object StaticText32: TStaticText
                Left = 144
                Top = 12
                Width = 26
                Height = 17
                Caption = 'Jax='
                TabOrder = 2
              end
              object StaticText33: TStaticText
                Left = 216
                Top = 12
                Width = 25
                Height = 17
                Caption = 'Phi='
                TabOrder = 3
              end
              object Edit37: TEdit
                Left = 32
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 4
                Text = '0'
              end
              object Edit38: TEdit
                Left = 96
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 5
                Text = '0'
              end
              object Edit39: TEdit
                Left = 168
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 6
                Text = '0'
              end
              object Edit40: TEdit
                Left = 240
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 7
                Text = '0'
              end
            end
            object TabSheet15: TTabSheet
              Caption = 'Magnet'
              ImageIndex = 1
              object Label135: TLabel
                Left = 64
                Top = 12
                Width = 26
                Height = 13
                Caption = 'Tesla'
                Color = clLime
                ParentColor = False
              end
              object Label136: TLabel
                Left = 152
                Top = 12
                Width = 26
                Height = 13
                Caption = 'Tesla'
                Color = clLime
                ParentColor = False
              end
              object Label137: TLabel
                Left = 248
                Top = 12
                Width = 26
                Height = 13
                Caption = 'Tesla'
                Color = clLime
                ParentColor = False
              end
              object StaticText37: TStaticText
                Left = 8
                Top = 12
                Width = 20
                Height = 17
                Caption = 'Br='
                TabOrder = 0
              end
              object StaticText38: TStaticText
                Left = 96
                Top = 12
                Width = 22
                Height = 17
                Caption = 'Bfi='
                TabOrder = 1
              end
              object StaticText39: TStaticText
                Left = 184
                Top = 12
                Width = 28
                Height = 17
                Caption = 'Bax='
                TabOrder = 2
              end
              object Edit44: TEdit
                Left = 24
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 3
                Text = '0'
              end
              object Edit45: TEdit
                Left = 112
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 4
                Text = '0'
              end
              object Edit46: TEdit
                Left = 208
                Top = 8
                Width = 41
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 5
                Text = '0'
              end
            end
            object TabSheet16: TTabSheet
              Caption = 'Charge'
              ImageIndex = 2
              object Label134: TLabel
                Left = 80
                Top = 12
                Width = 34
                Height = 13
                Caption = 'Kl/m^3'
                Color = clLime
                ParentColor = False
              end
              object Edit36: TEdit
                Left = 32
                Top = 8
                Width = 49
                Height = 21
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Text = '0'
              end
              object StaticText29: TStaticText
                Left = 0
                Top = 12
                Width = 27
                Height = 17
                Caption = 'Ro ='
                TabOrder = 1
              end
            end
            object TabSheet17: TTabSheet
              Caption = 'None'
              ImageIndex = 3
              object StaticText27: TStaticText
                Left = 80
                Top = 16
                Width = 127
                Height = 17
                Caption = 'Object without any source'
                TabOrder = 0
              end
            end
          end
        end
        object TabSheet23: TTabSheet
          Caption = '3 block'
          ImageIndex = 2
          object Label81: TLabel
            Left = 0
            Top = 4
            Width = 13
            Height = 13
            Caption = 'X1'
          end
          object Label85: TLabel
            Left = 0
            Top = 28
            Width = 13
            Height = 13
            Caption = 'X2'
          end
          object Label89: TLabel
            Left = 0
            Top = 52
            Width = 13
            Height = 13
            Caption = 'X3'
          end
          object Label90: TLabel
            Left = 88
            Top = 4
            Width = 13
            Height = 13
            Caption = 'Z1'
          end
          object Label91: TLabel
            Left = 88
            Top = 28
            Width = 13
            Height = 13
            Caption = 'Z2'
          end
          object Label92: TLabel
            Left = 88
            Top = 52
            Width = 13
            Height = 13
            Caption = 'Z3'
          end
          object Label93: TLabel
            Left = 184
            Top = 4
            Width = 23
            Height = 13
            Caption = 'Ymin'
          end
          object Label94: TLabel
            Left = 184
            Top = 28
            Width = 26
            Height = 13
            Caption = 'Ymax'
          end
          object Label112: TLabel
            Left = 64
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label113: TLabel
            Left = 64
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label114: TLabel
            Left = 64
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label115: TLabel
            Left = 152
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label116: TLabel
            Left = 152
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label117: TLabel
            Left = 152
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label118: TLabel
            Left = 264
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label119: TLabel
            Left = 264
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Edit71: TEdit
            Left = 16
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            Text = '0'
          end
          object Edit72: TEdit
            Left = 16
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            Text = '0'
          end
          object Edit73: TEdit
            Left = 16
            Top = 48
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            Text = '0'
          end
          object Edit74: TEdit
            Left = 104
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 3
            Text = '0'
          end
          object Edit75: TEdit
            Left = 104
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 4
            Text = '0'
          end
          object Edit76: TEdit
            Left = 104
            Top = 48
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 5
            Text = '0'
          end
          object Edit77: TEdit
            Left = 216
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 6
            Text = '0'
          end
          object Edit78: TEdit
            Left = 216
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 7
            Text = '0'
          end
        end
        object TabSheet24: TTabSheet
          Caption = '3 sector'
          ImageIndex = 3
          object Label95: TLabel
            Left = 0
            Top = 4
            Width = 13
            Height = 13
            Caption = 'X1'
          end
          object Label96: TLabel
            Left = 0
            Top = 28
            Width = 13
            Height = 13
            Caption = 'X2'
          end
          object Label97: TLabel
            Left = 0
            Top = 52
            Width = 13
            Height = 13
            Caption = 'X3'
          end
          object Label98: TLabel
            Left = 88
            Top = 4
            Width = 13
            Height = 13
            Caption = 'Z1'
          end
          object Label99: TLabel
            Left = 88
            Top = 28
            Width = 13
            Height = 13
            Caption = 'Z2'
          end
          object Label100: TLabel
            Left = 88
            Top = 52
            Width = 13
            Height = 13
            Caption = 'Z3'
          end
          object Label101: TLabel
            Left = 184
            Top = 4
            Width = 27
            Height = 13
            Caption = 'Alpha'
          end
          object Label102: TLabel
            Left = 184
            Top = 28
            Width = 25
            Height = 13
            Caption = 'Betta'
          end
          object Label104: TLabel
            Left = 64
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label105: TLabel
            Left = 64
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label106: TLabel
            Left = 64
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label107: TLabel
            Left = 152
            Top = 4
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label108: TLabel
            Left = 152
            Top = 28
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label109: TLabel
            Left = 152
            Top = 52
            Width = 16
            Height = 13
            Caption = 'mm'
            Color = clLime
            ParentColor = False
          end
          object Label110: TLabel
            Left = 264
            Top = 4
            Width = 18
            Height = 13
            Caption = 'deg'
            Color = clLime
            ParentColor = False
          end
          object Label111: TLabel
            Left = 264
            Top = 28
            Width = 18
            Height = 13
            Caption = 'deg'
            Color = clLime
            ParentColor = False
          end
          object Edit79: TEdit
            Left = 16
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            Text = '0'
          end
          object Edit80: TEdit
            Left = 16
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            Text = '0'
          end
          object Edit81: TEdit
            Left = 16
            Top = 48
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            Text = '0'
          end
          object Edit82: TEdit
            Left = 104
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 3
            Text = '0'
          end
          object Edit83: TEdit
            Left = 104
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 4
            Text = '0'
          end
          object Edit84: TEdit
            Left = 104
            Top = 48
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 5
            Text = '0'
          end
          object Edit85: TEdit
            Left = 216
            Top = 0
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 6
            Text = '0'
          end
          object Edit86: TEdit
            Left = 216
            Top = 24
            Width = 49
            Height = 21
            ParentShowHint = False
            ShowHint = False
            TabOrder = 7
            Text = '0'
          end
        end
      end
      object ListBox3: TListBox
        Left = 0
        Top = 0
        Width = 193
        Height = 137
        ItemHeight = 13
        TabOrder = 1
        OnClick = ListBox3Click
      end
      object Button7: TButton
        Left = 200
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Add'
        TabOrder = 2
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 200
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 3
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 200
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 4
        OnClick = Button9Click
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 144
        Width = 193
        Height = 71
        Caption = 'Object Identification'
        TabOrder = 5
        object Label36: TLabel
          Left = 16
          Top = 20
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object Label37: TLabel
          Left = 16
          Top = 44
          Width = 37
          Height = 13
          Caption = 'Material'
        end
        object Edit47: TEdit
          Left = 48
          Top = 16
          Width = 137
          Height = 21
          TabOrder = 0
        end
        object seMat: TComboBox
          Left = 64
          Top = 40
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
        end
      end
      object Button16: TButton
        Left = 200
        Top = 112
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 6
        OnClick = Button16Click
      end
      object PageControl5: TPageControl
        Left = 352
        Top = 16
        Width = 177
        Height = 153
        ActivePage = TabSheet19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HotTrack = True
        MultiLine = True
        ParentFont = False
        TabOrder = 7
        object TabSheet19: TTabSheet
          Caption = '2D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          object Label74: TLabel
            Left = 8
            Top = 12
            Width = 22
            Height = 13
            Caption = 'Error'
          end
          object Label75: TLabel
            Left = 8
            Top = 36
            Width = 69
            Height = 13
            Caption = 'Max. Iterations'
          end
          object Label76: TLabel
            Left = 8
            Top = 64
            Width = 76
            Height = 13
            Caption = 'Solution method'
          end
          object Edit63: TEdit
            Left = 40
            Top = 8
            Width = 121
            Height = 21
            TabOrder = 0
            Text = '1e-5'
          end
          object Edit64: TEdit
            Left = 88
            Top = 32
            Width = 73
            Height = 21
            TabOrder = 1
            Text = '100'
          end
          object ComboBox10: TComboBox
            Left = 8
            Top = 80
            Width = 153
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 2
            Text = 'Conjugate Gradient Metod'
            Items.Strings = (
              'Conjugate Gradient Metod'
              'Diagonal Conjugate Gradient Metod'
              'Incomplete Cholesky Conjugate Gradient Metod')
          end
        end
        object TabSheet20: TTabSheet
          Caption = '3D'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImageIndex = 1
          ParentFont = False
          object Label78: TLabel
            Left = 8
            Top = 12
            Width = 22
            Height = 13
            Caption = 'Error'
          end
          object Label79: TLabel
            Left = 8
            Top = 36
            Width = 69
            Height = 13
            Caption = 'Max. Iterations'
          end
          object Label80: TLabel
            Left = 8
            Top = 64
            Width = 76
            Height = 13
            Caption = 'Solution method'
          end
          object Edit65: TEdit
            Left = 40
            Top = 8
            Width = 121
            Height = 21
            TabOrder = 0
            Text = '1e-5'
          end
          object Edit66: TEdit
            Left = 88
            Top = 32
            Width = 73
            Height = 21
            TabOrder = 1
            Text = '100'
          end
          object ComboBox11: TComboBox
            Left = 8
            Top = 80
            Width = 153
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 2
            Text = 'Conjugate Gradient Metod'
            Items.Strings = (
              'Conjugate Gradient Metod'
              'Diagonal Conjugate Gradient Metod'
              'Incomplete Cholesky Conjugate Gradient Metod')
          end
        end
        object TabSheet21: TTabSheet
          Caption = '3D defect'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImageIndex = 2
          ParentFont = False
          object Label82: TLabel
            Left = 8
            Top = 12
            Width = 22
            Height = 13
            Caption = 'Error'
          end
          object Label83: TLabel
            Left = 8
            Top = 36
            Width = 69
            Height = 13
            Caption = 'Max. Iterations'
          end
          object Label84: TLabel
            Left = 8
            Top = 64
            Width = 76
            Height = 13
            Caption = 'Solution method'
          end
          object Edit67: TEdit
            Left = 40
            Top = 8
            Width = 121
            Height = 21
            TabOrder = 0
            Text = '1e-5'
          end
          object Edit68: TEdit
            Left = 88
            Top = 32
            Width = 73
            Height = 21
            TabOrder = 1
            Text = '100'
          end
          object ComboBox12: TComboBox
            Left = 8
            Top = 80
            Width = 153
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 2
            Text = 'Conjugate Gradient Metod'
            Items.Strings = (
              'Conjugate Gradient Metod'
              'Diagonal Conjugate Gradient Metod'
              'Incomplete Cholesky Conjugate Gradient Metod')
          end
        end
        object TabSheet22: TTabSheet
          Caption = 'Non Linear'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImageIndex = 3
          ParentFont = False
          object Label86: TLabel
            Left = 8
            Top = 12
            Width = 22
            Height = 13
            Caption = 'Error'
          end
          object Label87: TLabel
            Left = 8
            Top = 36
            Width = 69
            Height = 13
            Caption = 'Max. Iterations'
          end
          object Label88: TLabel
            Left = 8
            Top = 64
            Width = 76
            Height = 13
            Caption = 'Solution method'
          end
          object Edit69: TEdit
            Left = 40
            Top = 8
            Width = 121
            Height = 21
            TabOrder = 0
            Text = '1e-5'
          end
          object Edit70: TEdit
            Left = 88
            Top = 32
            Width = 73
            Height = 21
            TabOrder = 1
            Text = '100'
          end
          object ComboBox13: TComboBox
            Left = 8
            Top = 80
            Width = 153
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 2
            Text = 'Simple Iteration Method'
            Items.Strings = (
              'Simple Iteration Method'
              'Newton-Raphson Method'
              'Complex Newton-Raphson Method')
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = '3D mesh'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      OnExit = TabSheet4Exit
      OnShow = TabSheet4Show
      object Label61: TLabel
        Left = 0
        Top = 92
        Width = 26
        Height = 13
        Caption = 'Mesh'
      end
      object Label62: TLabel
        Left = 152
        Top = 92
        Width = 27
        Height = 13
        Caption = 'Angle'
      end
      object Label63: TLabel
        Left = 256
        Top = 92
        Width = 85
        Height = 13
        Caption = 'Adaptation Layers'
      end
      object Label68: TLabel
        Left = 408
        Top = 92
        Width = 32
        Height = 13
        Caption = 'Defect'
      end
      object sg1: TStringGrid
        Left = 0
        Top = 112
        Width = 530
        Height = 204
        Align = alBottom
        ColCount = 7
        DefaultColWidth = 24
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnExit = TabSheet4Exit
        OnKeyDown = sg1KeyDown
        OnSelectCell = sg1SelectCell
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 530
        Height = 81
        Align = alTop
        Caption = 'Solution Domain (mm)'
        TabOrder = 1
        object Label42: TLabel
          Left = 16
          Top = 20
          Width = 14
          Height = 13
          Caption = 'R0'
        end
        object Label43: TLabel
          Left = 80
          Top = 20
          Width = 14
          Height = 13
          Caption = 'Fi0'
        end
        object Label44: TLabel
          Left = 144
          Top = 20
          Width = 13
          Height = 13
          Caption = 'Z0'
        end
        object Label45: TLabel
          Left = 16
          Top = 48
          Width = 20
          Height = 13
          Caption = 'R1='
        end
        object Label46: TLabel
          Left = 80
          Top = 48
          Width = 23
          Height = 13
          Caption = 'Fi1= '
        end
        object Label47: TLabel
          Left = 144
          Top = 48
          Width = 19
          Height = 13
          Caption = 'Z1='
        end
        object Label48: TLabel
          Left = 40
          Top = 48
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label49: TLabel
          Left = 104
          Top = 48
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label50: TLabel
          Left = 168
          Top = 48
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label51: TLabel
          Left = 216
          Top = 16
          Width = 27
          Height = 13
          Caption = 'NX = '
        end
        object Label52: TLabel
          Left = 216
          Top = 40
          Width = 27
          Height = 13
          Caption = 'NY = '
        end
        object Label53: TLabel
          Left = 216
          Top = 64
          Width = 27
          Height = 13
          Caption = 'NZ = '
        end
        object Label54: TLabel
          Left = 248
          Top = 16
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label55: TLabel
          Left = 248
          Top = 40
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label56: TLabel
          Left = 248
          Top = 64
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label57: TLabel
          Left = 296
          Top = 40
          Width = 63
          Height = 13
          Caption = 'NElements = '
        end
        object Label58: TLabel
          Left = 296
          Top = 16
          Width = 49
          Height = 13
          Caption = 'NPoints = '
        end
        object Label59: TLabel
          Left = 368
          Top = 40
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label60: TLabel
          Left = 352
          Top = 16
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Bevel2: TBevel
          Left = 208
          Top = 16
          Width = 9
          Height = 57
          Shape = bsLeftLine
        end
        object Bevel3: TBevel
          Left = 272
          Top = 16
          Width = 17
          Height = 57
          Shape = bsRightLine
        end
        object Label66: TLabel
          Left = 296
          Top = 64
          Width = 121
          Height = 13
          Caption = 'Expected memory (MB) = '
        end
        object Label67: TLabel
          Left = 424
          Top = 64
          Width = 6
          Height = 13
          Caption = '0'
        end
        object SpeedButton5: TSpeedButton
          Left = 472
          Top = 16
          Width = 23
          Height = 22
          Hint = 'Load plane 3D adoptation mesh'
          Caption = 'Pl'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton5Click
        end
        object SpeedButton7: TSpeedButton
          Left = 496
          Top = 16
          Width = 23
          Height = 22
          Hint = 'Load 3D adoptation mesh'
          Caption = '3D'
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton7Click
        end
        object Edit59: TEdit
          Left = 32
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '0'
          OnExit = TabSheet4Exit
          OnKeyDown = sg1KeyDown
        end
        object Edit60: TEdit
          Left = 96
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '0'
          OnExit = TabSheet4Exit
          OnKeyDown = sg1KeyDown
        end
        object Edit61: TEdit
          Left = 160
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 2
          Text = '0'
          OnExit = TabSheet4Exit
          OnKeyDown = sg1KeyDown
        end
      end
      object ComboBox7: TComboBox
        Left = 32
        Top = 88
        Width = 105
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Axisymmetrical'
        OnChange = ComboBox7Change
        Items.Strings = (
          'Axisymmetrical'
          'Cartesian')
      end
      object ComboBox8: TComboBox
        Left = 184
        Top = 88
        Width = 57
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = '90'
        Items.Strings = (
          '90'
          '180'
          '360')
      end
      object SpinEdit1: TSpinEdit
        Left = 352
        Top = 88
        Width = 49
        Height = 22
        MaxValue = 5
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
      object seDD: TComboBox
        Left = 448
        Top = 88
        Width = 81
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
      end
    end
    object TabSheet5: TTabSheet
      Caption = '3D bounds'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 4
      ParentFont = False
      OnShow = TabSheet5Show
      object Label39: TLabel
        Left = 0
        Top = 120
        Width = 71
        Height = 13
        Caption = 'Potential Value'
      end
      object Label40: TLabel
        Left = 8
        Top = 140
        Width = 15
        Height = 13
        Caption = 'Val'
      end
      object Label41: TLabel
        Left = 88
        Top = 140
        Width = 11
        Height = 13
        Caption = 'Im'
      end
      object Label70: TLabel
        Left = 240
        Top = 152
        Width = 133
        Height = 13
        Caption = 'Special boundary conditions'
      end
      object ListBox4: TListBox
        Left = 0
        Top = 8
        Width = 209
        Height = 105
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox4Click
      end
      object Button10: TButton
        Left = 216
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Add'
        Default = True
        TabOrder = 1
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 216
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = Button11Click
      end
      object Button12: TButton
        Left = 216
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 3
        OnClick = Button12Click
      end
      object Edit51: TEdit
        Left = 32
        Top = 136
        Width = 49
        Height = 21
        TabOrder = 4
        Text = '0'
      end
      object Edit52: TEdit
        Left = 112
        Top = 136
        Width = 49
        Height = 21
        TabOrder = 5
        Text = '0'
      end
      object BitBtn5: TBitBtn
        Left = 304
        Top = 80
        Width = 65
        Height = 25
        Caption = 'X/R min'
        TabOrder = 6
        OnClick = BitBtn5Click
      end
      object BitBtn6: TBitBtn
        Left = 304
        Top = 112
        Width = 65
        Height = 25
        Caption = 'X/R max'
        TabOrder = 7
        OnClick = BitBtn6Click
      end
      object BitBtn7: TBitBtn
        Left = 376
        Top = 80
        Width = 65
        Height = 25
        Caption = 'Y/Fi min'
        TabOrder = 8
        OnClick = BitBtn7Click
      end
      object BitBtn8: TBitBtn
        Left = 376
        Top = 112
        Width = 65
        Height = 25
        Caption = 'Y/Fi max'
        TabOrder = 9
        OnClick = BitBtn8Click
      end
      object BitBtn9: TBitBtn
        Left = 448
        Top = 80
        Width = 65
        Height = 25
        Caption = 'Z min'
        TabOrder = 10
        OnClick = BitBtn9Click
      end
      object BitBtn10: TBitBtn
        Left = 448
        Top = 112
        Width = 65
        Height = 25
        Caption = 'Z max'
        TabOrder = 11
        OnClick = BitBtn10Click
      end
      object ComboBox6: TComboBox
        Left = 216
        Top = 112
        Width = 65
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 12
        Text = 'Scalar'
        Items.Strings = (
          'Scalar'
          'X'
          'Y'
          'Z')
      end
      object StaticText40: TStaticText
        Left = 376
        Top = 8
        Width = 76
        Height = 17
        Caption = 'Point Numbers:'
        TabOrder = 13
      end
      object StaticText41: TStaticText
        Left = 296
        Top = 28
        Width = 23
        Height = 17
        Caption = 'X1='
        TabOrder = 14
      end
      object StaticText42: TStaticText
        Left = 296
        Top = 52
        Width = 23
        Height = 17
        Caption = 'X2='
        TabOrder = 15
      end
      object StaticText43: TStaticText
        Left = 368
        Top = 28
        Width = 23
        Height = 17
        Caption = 'Y1='
        TabOrder = 16
      end
      object StaticText44: TStaticText
        Left = 368
        Top = 52
        Width = 23
        Height = 17
        Caption = 'Y2='
        TabOrder = 17
      end
      object StaticText45: TStaticText
        Left = 440
        Top = 28
        Width = 23
        Height = 17
        Caption = 'Z1='
        TabOrder = 18
      end
      object StaticText46: TStaticText
        Left = 440
        Top = 52
        Width = 23
        Height = 17
        Caption = 'Z2='
        TabOrder = 19
      end
      object Edit53: TEdit
        Left = 320
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 20
        Text = '0'
        OnKeyPress = Edit53KeyPress
      end
      object Edit54: TEdit
        Left = 320
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 21
        Text = '0'
        OnKeyPress = Edit53KeyPress
      end
      object Edit55: TEdit
        Left = 392
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 22
        Text = '0'
        OnKeyPress = Edit53KeyPress
      end
      object Edit56: TEdit
        Left = 392
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 23
        Text = '0'
        OnKeyPress = Edit53KeyPress
      end
      object Edit57: TEdit
        Left = 464
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 24
        Text = '0'
        OnKeyPress = Edit53KeyPress
      end
      object Edit58: TEdit
        Left = 464
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 25
        Text = '0'
        OnKeyPress = Edit53KeyPress
      end
      object Button14: TButton
        Left = 240
        Top = 168
        Width = 137
        Height = 25
        Caption = 'Axial'
        TabOrder = 26
        OnClick = Button14Click
      end
      object Button17: TButton
        Left = 384
        Top = 168
        Width = 137
        Height = 25
        Caption = 'Zero'
        TabOrder = 27
        OnClick = Button17Click
      end
      object Button18: TButton
        Left = 240
        Top = 200
        Width = 137
        Height = 25
        Caption = 'Parallel'
        TabOrder = 28
      end
      object Memo2: TMemo
        Left = 32
        Top = 160
        Width = 153
        Height = 41
        BevelInner = bvNone
        BorderStyle = bsNone
        Color = clBtnFace
        Lines.Strings = (
          'in Volts - for Tasks 0, 1'
          'in Ampere - for Task 2'
          'in Weber/m - for Tasks 3, 4, 5')
        ReadOnly = True
        TabOrder = 29
      end
    end
    object TabSheet6: TTabSheet
      Caption = '2D mesh'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 5
      ParentFont = False
      OnExit = TabSheet6Exit
      OnShow = TabSheet6Show
      object Label14: TLabel
        Left = 8
        Top = 8
        Width = 71
        Height = 13
        Caption = 'Mesh definition'
      end
      object Label15: TLabel
        Left = 336
        Top = 184
        Width = 26
        Height = 13
        Caption = 'Mesh'
      end
      object Label16: TLabel
        Left = 320
        Top = 208
        Width = 42
        Height = 13
        Caption = 'Direction'
      end
      object Label17: TLabel
        Left = 313
        Top = 232
        Width = 49
        Height = 13
        Caption = 'Expansion'
      end
      object Label34: TLabel
        Left = 336
        Top = 256
        Width = 27
        Height = 13
        Caption = 'Angle'
      end
      object Label38: TLabel
        Left = 328
        Top = 276
        Width = 89
        Height = 13
        Caption = 'Material to exclude'
      end
      object Label64: TLabel
        Left = 320
        Top = 296
        Width = 121
        Height = 13
        Caption = 'Expected memory (MB) = '
      end
      object Label65: TLabel
        Left = 448
        Top = 296
        Width = 6
        Height = 13
        Caption = '0'
      end
      object SpeedButton6: TSpeedButton
        Left = 320
        Top = 24
        Width = 23
        Height = 22
        Hint = 'Load adoptation 2D mesh'
        Caption = 'Ad'
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton6Click
      end
      object SpeedButton8: TSpeedButton
        Left = 320
        Top = 56
        Width = 23
        Height = 22
        Caption = 'UM'
        OnClick = SpeedButton8Click
      end
      object sg2: TStringGrid
        Left = 0
        Top = 24
        Width = 313
        Height = 289
        DefaultColWidth = 24
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ParentFont = False
        TabOrder = 0
        OnExit = TabSheet6Exit
        OnKeyDown = sg2KeyDown
        OnSelectCell = sg2SelectCell
        RowHeights = (
          24
          24)
      end
      object GroupBox1: TGroupBox
        Left = 368
        Top = 0
        Width = 161
        Height = 169
        Caption = 'Plane sizes (mm)'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        object Bevel1: TBevel
          Left = 8
          Top = 72
          Width = 145
          Height = 9
          Shape = bsTopLine
        end
        object Label6: TLabel
          Left = 8
          Top = 88
          Width = 27
          Height = 13
          Caption = 'NX = '
        end
        object Label7: TLabel
          Left = 8
          Top = 104
          Width = 27
          Height = 13
          Caption = 'NZ = '
        end
        object Label8: TLabel
          Left = 8
          Top = 128
          Width = 51
          Height = 13
          Caption = 'NNodes = '
        end
        object Label9: TLabel
          Left = 8
          Top = 144
          Width = 63
          Height = 13
          Caption = 'NElements = '
        end
        object Label10: TLabel
          Left = 40
          Top = 88
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label11: TLabel
          Left = 40
          Top = 104
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label12: TLabel
          Left = 64
          Top = 128
          Width = 6
          Height = 13
          Caption = '0'
        end
        object Label13: TLabel
          Left = 72
          Top = 144
          Width = 6
          Height = 13
          Caption = '0'
        end
        object StaticText1: TStaticText
          Left = 8
          Top = 24
          Width = 17
          Height = 17
          Caption = 'X0'
          TabOrder = 0
        end
        object StaticText2: TStaticText
          Left = 80
          Top = 24
          Width = 17
          Height = 17
          Caption = 'Z0'
          TabOrder = 1
        end
        object StaticText3: TStaticText
          Left = 8
          Top = 48
          Width = 29
          Height = 17
          Caption = 'X1 = '
          TabOrder = 2
        end
        object StaticText4: TStaticText
          Left = 32
          Top = 48
          Width = 19
          Height = 17
          Caption = '0.0'
          TabOrder = 3
        end
        object StaticText5: TStaticText
          Left = 80
          Top = 48
          Width = 29
          Height = 17
          Caption = 'Z1 = '
          TabOrder = 4
        end
        object StaticText6: TStaticText
          Left = 104
          Top = 48
          Width = 19
          Height = 17
          Caption = '0.0'
          TabOrder = 5
        end
        object Edit1: TEdit
          Left = 24
          Top = 20
          Width = 41
          Height = 21
          TabOrder = 6
          Text = '0'
          OnExit = TabSheet6Exit
          OnKeyDown = sg2KeyDown
        end
        object Edit2: TEdit
          Left = 104
          Top = 20
          Width = 41
          Height = 21
          TabOrder = 7
          Text = '0'
          OnExit = TabSheet6Exit
          OnKeyDown = sg2KeyDown
        end
      end
      object ComboBox1: TComboBox
        Left = 368
        Top = 176
        Width = 161
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Crossed'
        OnChange = ComboBox1Change
        Items.Strings = (
          'Crossed'
          'Axial')
      end
      object ComboBox2: TComboBox
        Left = 368
        Top = 200
        Width = 161
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'LEFT Topology [\]'
        Items.Strings = (
          'LEFT Topology [\]'
          'RIGHT Topology [/]'
          'Combined Topology [\][/]'
          'Crossed Topology [X]')
      end
      object ComboBox3: TComboBox
        Left = 368
        Top = 224
        Width = 161
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Axisymmetry'
        Items.Strings = (
          'Axisymmetry'
          'Parallel')
      end
      object ComboBox4: TComboBox
        Left = 368
        Top = 248
        Width = 161
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = '90'
        Items.Strings = (
          '90'
          '180'
          '360')
      end
      object seDefect: TComboBox
        Left = 424
        Top = 272
        Width = 105
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
      end
      object CheckBox5: TCheckBox
        Left = 328
        Top = 88
        Width = 25
        Height = 17
        TabOrder = 7
        OnClick = CheckBox5Click
      end
    end
    object TabSheet7: TTabSheet
      Caption = '2D bounds'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 6
      ParentFont = False
      OnShow = TabSheet7Show
      object Shape1: TShape
        Left = 296
        Top = 72
        Width = 73
        Height = 33
        Brush.Color = clLime
        Visible = False
      end
      object Shape2: TShape
        Left = 368
        Top = 72
        Width = 73
        Height = 33
        Brush.Color = clLime
        Visible = False
      end
      object Shape3: TShape
        Left = 296
        Top = 104
        Width = 73
        Height = 33
        Brush.Color = clLime
        Visible = False
      end
      object Shape4: TShape
        Left = 368
        Top = 104
        Width = 73
        Height = 33
        Brush.Color = clLime
        Visible = False
      end
      object Label18: TLabel
        Left = 0
        Top = 120
        Width = 71
        Height = 13
        Caption = 'Potential Value'
      end
      object Label19: TLabel
        Left = 8
        Top = 140
        Width = 15
        Height = 13
        Caption = 'Val'
      end
      object Label20: TLabel
        Left = 88
        Top = 140
        Width = 11
        Height = 13
        Caption = 'Im'
      end
      object ListBox1: TListBox
        Left = 0
        Top = 8
        Width = 209
        Height = 105
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox1Click
      end
      object Button1: TButton
        Left = 216
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Add'
        Default = True
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 216
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 216
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 3
        OnClick = Button3Click
      end
      object StaticText67: TStaticText
        Left = 332
        Top = 4
        Width = 76
        Height = 17
        Caption = 'Point Numbers:'
        TabOrder = 4
      end
      object StaticText47: TStaticText
        Left = 296
        Top = 28
        Width = 24
        Height = 17
        Caption = 'R1='
        TabOrder = 5
      end
      object StaticText48: TStaticText
        Left = 296
        Top = 48
        Width = 24
        Height = 17
        Caption = 'R2='
        TabOrder = 6
      end
      object Edit24: TEdit
        Left = 320
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 7
        Text = '0'
        OnKeyPress = Edit24KeyPress
      end
      object Edit25: TEdit
        Left = 320
        Top = 44
        Width = 41
        Height = 21
        TabOrder = 8
        Text = '0'
      end
      object Edit28: TEdit
        Left = 392
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 9
        Text = '0'
      end
      object Edit29: TEdit
        Left = 392
        Top = 44
        Width = 41
        Height = 21
        TabOrder = 10
        Text = '0'
      end
      object StaticText51: TStaticText
        Left = 368
        Top = 28
        Width = 21
        Height = 17
        Caption = 'z1='
        TabOrder = 11
      end
      object StaticText52: TStaticText
        Left = 368
        Top = 48
        Width = 21
        Height = 17
        Caption = 'z2='
        TabOrder = 12
      end
      object BitBtn1: TBitBtn
        Left = 300
        Top = 76
        Width = 65
        Height = 25
        Caption = 'X/R min'
        TabOrder = 13
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 372
        Top = 76
        Width = 65
        Height = 25
        Caption = 'Z min'
        TabOrder = 14
        OnClick = BitBtn2Click
      end
      object BitBtn3: TBitBtn
        Left = 300
        Top = 108
        Width = 65
        Height = 25
        Caption = 'X/R max'
        TabOrder = 15
        OnClick = BitBtn3Click
      end
      object BitBtn4: TBitBtn
        Left = 372
        Top = 108
        Width = 65
        Height = 25
        Caption = 'Z max'
        TabOrder = 16
        OnClick = BitBtn4Click
      end
      object Edit3: TEdit
        Left = 32
        Top = 136
        Width = 49
        Height = 21
        TabOrder = 17
        Text = '0'
      end
      object Edit4: TEdit
        Left = 112
        Top = 136
        Width = 49
        Height = 21
        TabOrder = 18
        Text = '0'
      end
      object Memo1: TMemo
        Left = 32
        Top = 160
        Width = 153
        Height = 41
        BevelInner = bvNone
        BorderStyle = bsNone
        Color = clBtnFace
        Lines.Strings = (
          'in Volts - for Tasks 0, 1'
          'in Ampere - for Task 2'
          'in Weber/m - for Tasks 3, 4, 5')
        ReadOnly = True
        TabOrder = 19
      end
    end
    object TabSheet18: TTabSheet
      Caption = 'Preview'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 7
      ParentFont = False
      OnExit = TabSheet18Exit
      OnShow = TabSheet18Show
      object Panel2: TPanel
        Left = 438
        Top = 0
        Width = 92
        Height = 316
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 1
        object GroupBox6: TGroupBox
          Left = 0
          Top = 96
          Width = 89
          Height = 217
          Caption = 'Position'
          TabOrder = 1
          object Label2: TLabel
            Left = 8
            Top = 16
            Width = 33
            Height = 13
            Caption = 'Zoom :'
          end
          object Label3: TLabel
            Left = 48
            Top = 16
            Width = 15
            Height = 13
            Caption = '1:1'
          end
          object Label69: TLabel
            Left = 8
            Top = 64
            Width = 51
            Height = 13
            Caption = 'Orientation'
          end
          object SpeedButton1: TSpeedButton
            Left = 8
            Top = 80
            Width = 23
            Height = 22
            Caption = 'X'
            Flat = True
            OnClick = SpeedButton1Click
          end
          object SpeedButton2: TSpeedButton
            Left = 32
            Top = 80
            Width = 23
            Height = 22
            Caption = 'Y'
            Flat = True
            OnClick = SpeedButton2Click
          end
          object SpeedButton3: TSpeedButton
            Left = 56
            Top = 80
            Width = 23
            Height = 22
            Caption = 'Z'
            Flat = True
            OnClick = SpeedButton3Click
          end
          object ud1: TUpDown
            Left = 8
            Top = 32
            Width = 65
            Height = 25
            Min = -4
            Max = 6
            Orientation = udHorizontal
            TabOrder = 0
            OnClick = ud1Click
          end
          object Button13: TButton
            Left = 8
            Top = 112
            Width = 75
            Height = 25
            Caption = 'Center'
            TabOrder = 1
            OnClick = Button13Click
          end
          object Button15: TButton
            Left = 8
            Top = 144
            Width = 75
            Height = 25
            Caption = 'Normal'
            TabOrder = 2
            OnClick = Button15Click
          end
        end
        object GroupBox5: TGroupBox
          Left = 0
          Top = 0
          Width = 89
          Height = 97
          Caption = 'Model'
          TabOrder = 0
          object CheckBox1: TCheckBox
            Left = 8
            Top = 16
            Width = 73
            Height = 17
            Caption = 'Bound 2D'
            TabOrder = 0
            OnClick = CheckBox1Click
          end
          object CheckBox2: TCheckBox
            Left = 8
            Top = 32
            Width = 73
            Height = 17
            Caption = 'Bound 3D'
            TabOrder = 1
            OnClick = CheckBox1Click
          end
          object CheckBox3: TCheckBox
            Left = 8
            Top = 48
            Width = 41
            Height = 17
            Caption = 'Axis'
            TabOrder = 2
            OnClick = CheckBox1Click
          end
          object CheckBox4: TCheckBox
            Left = 8
            Top = 72
            Width = 57
            Height = 17
            Caption = 'Objects'
            TabOrder = 3
            OnClick = CheckBox1Click
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 438
        Height = 316
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 0
        OnMouseDown = Panel1MouseDown
        OnMouseMove = Panel1MouseMove
        OnMouseUp = Panel1MouseUp
      end
    end
  end
  object clDlg: TColorDialog
    Left = 636
    Top = 6
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 608
    Top = 8
  end
  object oDlg1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Curve Files|*.txt|All Files|*.*'
    Left = 608
    Top = 48
  end
  object oDlg2: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text files|*.txt|All Files|*.*'
    Left = 608
    Top = 88
  end
end
