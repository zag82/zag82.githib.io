object fmMultiEdit: TfmMultiEdit
  Left = 193
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Multi Dimensional Data changes'
  ClientHeight = 408
  ClientWidth = 724
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
  object Panel1: TPanel
    Left = 684
    Top = 0
    Width = 40
    Height = 408
    Align = alRight
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Clear'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888888888888800000000000888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F0
        8888880FFFFFF008888888000000008888888888888888888888}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 8
      Top = 56
      Width = 23
      Height = 22
      Hint = 'Save Data'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888880000000000000880330000008803088033000000880308803300000088
        0308803300000000030880333333333333088033000000003308803088888888
        0308803088888888030880308888888803088030888888880308803088888888
        0008803088888888080880000000000000088888888888888888}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 8
      Top = 88
      Width = 23
      Height = 22
      Hint = 'Save Text'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888844444444488888884FFFFFFF488888884F0000
        0F480000004FFFFFFF480FFFFF4F00000F480F00004FFFFFFF480FFFFF4F00F4
        44480F00004FFFF4F4880FFFFF4FFFF448880F00F044444488880FFFF0F08888
        88880FFFF0088888888800000088888888888888888888888888}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton3Click
    end
    object SpeedButton9: TSpeedButton
      Left = 8
      Top = 144
      Width = 23
      Height = 22
      Hint = 'Load'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        88888888888888888888000000000008888800333333333088880B0333333333
        08880FB03333333330880BFB0333333333080FBFB000000000000BFBFBFBFB08
        88880FBFBFBFBF0888880BFB0000000888888000888888880008888888888888
        8008888888880888080888888888800088888888888888888888}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton9Click
    end
    object Bevel2: TBevel
      Left = 8
      Top = 40
      Width = 25
      Height = 17
      Shape = bsTopLine
    end
    object Bevel3: TBevel
      Left = 8
      Top = 128
      Width = 26
      Height = 17
      Shape = bsTopLine
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 684
    Height = 408
    ActivePage = TabSheet3
    Align = alClient
    TabIndex = 2
    TabOrder = 1
    object TabSheet1: TTabSheet
      object Label14: TLabel
        Left = 112
        Top = 152
        Width = 484
        Height = 54
        Caption = 'Multi Dimensional Data'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -48
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Data'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object Label5: TLabel
        Left = 8
        Top = 16
        Width = 80
        Height = 13
        Caption = 'Changes number'
      end
      object Label6: TLabel
        Left = 8
        Top = 40
        Width = 42
        Height = 13
        Caption = 'Changes'
      end
      object ListBox3: TListBox
        Left = 8
        Top = 56
        Width = 65
        Height = 321
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox3Click
      end
      object GroupBox3: TGroupBox
        Left = 80
        Top = 40
        Width = 305
        Height = 337
        Caption = 'Objects/Materials/Frequency'
        TabOrder = 1
        object SpeedButton6: TSpeedButton
          Left = 144
          Top = 24
          Width = 23
          Height = 22
          Caption = '<<'
          OnClick = SpeedButton6Click
        end
        object SpeedButton7: TSpeedButton
          Left = 144
          Top = 112
          Width = 23
          Height = 22
          Caption = '<<'
          OnClick = SpeedButton7Click
        end
        object SpeedButton8: TSpeedButton
          Left = 144
          Top = 232
          Width = 23
          Height = 22
          Caption = '<<'
          OnClick = SpeedButton8Click
        end
        object Label7: TLabel
          Left = 176
          Top = 56
          Width = 42
          Height = 13
          Caption = 'Materials'
        end
        object Label8: TLabel
          Left = 176
          Top = 176
          Width = 36
          Height = 13
          Caption = 'Objects'
        end
        object ListBox4: TListBox
          Left = 8
          Top = 24
          Width = 129
          Height = 265
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox4Click
        end
        object ListBox5: TListBox
          Left = 176
          Top = 24
          Width = 121
          Height = 25
          ItemHeight = 13
          Items.Strings = (
            'Frequency')
          TabOrder = 1
        end
        object ListBox6: TListBox
          Left = 176
          Top = 72
          Width = 121
          Height = 97
          ItemHeight = 13
          TabOrder = 2
        end
        object ListBox7: TListBox
          Left = 176
          Top = 192
          Width = 121
          Height = 97
          ItemHeight = 13
          TabOrder = 3
        end
        object Button4: TButton
          Left = 8
          Top = 296
          Width = 129
          Height = 25
          Caption = 'Clear'
          TabOrder = 4
          OnClick = Button4Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 392
        Top = 40
        Width = 281
        Height = 337
        Caption = 'Values'
        TabOrder = 2
        object Label9: TLabel
          Left = 16
          Top = 24
          Width = 48
          Height = 13
          Caption = 'Parameter'
        end
        object Label10: TLabel
          Left = 8
          Top = 72
          Width = 46
          Height = 13
          Caption = 'Variations'
        end
        object Label11: TLabel
          Left = 8
          Top = 96
          Width = 37
          Height = 13
          Caption = 'Number'
        end
        object Label12: TLabel
          Left = 8
          Top = 120
          Width = 32
          Height = 13
          Caption = 'Values'
        end
        object Label13: TLabel
          Left = 8
          Top = 144
          Width = 19
          Height = 13
          Caption = 'mm'
          Color = clLime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 8
          Top = 56
          Width = 241
          Height = 17
          Shape = bsTopLine
        end
        object Edit2: TEdit
          Left = 56
          Top = 96
          Width = 113
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Text = '1'
        end
        object ListBox8: TListBox
          Left = 56
          Top = 120
          Width = 113
          Height = 209
          ItemHeight = 13
          TabOrder = 1
        end
        object Button5: TButton
          Left = 176
          Top = 120
          Width = 75
          Height = 25
          Caption = 'Edit'
          TabOrder = 2
          OnClick = Button5Click
        end
        object Button6: TButton
          Left = 176
          Top = 160
          Width = 75
          Height = 25
          Caption = 'Default'
          TabOrder = 3
          OnClick = Button6Click
        end
        object ComboBox2: TComboBox
          Left = 72
          Top = 24
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          OnChange = ComboBox2Change
        end
      end
      object se1: TSpinEdit
        Left = 96
        Top = 8
        Width = 89
        Height = 22
        MaxValue = 100
        MinValue = 1
        TabOrder = 3
        Value = 1
        OnChange = se1Change
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Parameters'
      ImageIndex = 2
      OnExit = TabSheet3Exit
      OnShow = TabSheet3Show
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 265
        Height = 377
        Caption = 'Solution parameters'
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 48
          Width = 70
          Height = 13
          Caption = 'Sort of solution'
        end
        object Label15: TLabel
          Left = 16
          Top = 88
          Width = 90
          Height = 13
          Caption = 'Style of final results'
        end
        object CheckBox1: TCheckBox
          Left = 16
          Top = 24
          Width = 65
          Height = 17
          Caption = 'Topology'
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          Left = 16
          Top = 64
          Width = 233
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = '2D standard solution'
          Items.Strings = (
            '2D standard solution'
            '3D standard solution'
            'Two step algorithm (2D-3D)'
            'Two Step algorithm (3D-3D)')
        end
        object ComboBox3: TComboBox
          Left = 16
          Top = 104
          Width = 233
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 2
          Text = 'All signals separately'
          Items.Strings = (
            'All signals separately'
            'Summ of signals'
            'Difference of signals')
        end
        object GroupBox5: TGroupBox
          Left = 8
          Top = 128
          Width = 249
          Height = 241
          Caption = 'Output'
          TabOrder = 3
          object Label2: TLabel
            Left = 8
            Top = 20
            Width = 75
            Height = 13
            Caption = 'Output directory'
          end
          object SpeedButton4: TSpeedButton
            Left = 218
            Top = 35
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = SpeedButton4Click
          end
          object Label16: TLabel
            Left = 8
            Top = 64
            Width = 37
            Height = 13
            Caption = 'Change'
          end
          object Label19: TLabel
            Left = 72
            Top = 112
            Width = 64
            Height = 13
            Caption = 'Parameters'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label17: TLabel
            Left = 72
            Top = 152
            Width = 21
            Height = 13
            Caption = 'Text'
          end
          object Label18: TLabel
            Left = 72
            Top = 176
            Width = 60
            Height = 13
            Caption = 'Value output'
          end
          object Edit1: TEdit
            Left = 8
            Top = 36
            Width = 209
            Height = 21
            ReadOnly = True
            TabOrder = 0
          end
          object ListBox9: TListBox
            Left = 8
            Top = 80
            Width = 57
            Height = 153
            ItemHeight = 13
            TabOrder = 1
            OnClick = ListBox9Click
          end
          object Button3: TButton
            Left = 72
            Top = 80
            Width = 75
            Height = 25
            Caption = 'Apply'
            TabOrder = 2
            OnClick = Button3Click
          end
          object CheckBox2: TCheckBox
            Left = 72
            Top = 128
            Width = 121
            Height = 17
            Caption = 'Directory (false = File)'
            TabOrder = 3
          end
          object ComboBox4: TComboBox
            Left = 72
            Top = 192
            Width = 169
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 4
            Text = 'Value normalized'
            Items.Strings = (
              'Value normalized'
              'Block length (x)'
              'Block length (y)'
              'Block length (z)'
              'Sector width'
              'Sector angle width'
              'None')
          end
          object Edit3: TEdit
            Left = 104
            Top = 148
            Width = 137
            Height = 21
            TabOrder = 5
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 272
        Top = 0
        Width = 401
        Height = 281
        Caption = 'Gage'
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 24
          Width = 63
          Height = 13
          Caption = 'Gage objects'
        end
        object Label4: TLabel
          Left = 224
          Top = 24
          Width = 48
          Height = 13
          Caption = 'All objects'
        end
        object SpeedButton5: TSpeedButton
          Left = 192
          Top = 136
          Width = 23
          Height = 22
          Caption = '<<'
          OnClick = SpeedButton5Click
        end
        object ListBox1: TListBox
          Left = 16
          Top = 40
          Width = 169
          Height = 201
          ItemHeight = 13
          TabOrder = 0
        end
        object ListBox2: TListBox
          Left = 224
          Top = 40
          Width = 169
          Height = 201
          ItemHeight = 13
          TabOrder = 1
        end
        object Button1: TButton
          Left = 16
          Top = 248
          Width = 75
          Height = 25
          Caption = 'Del'
          TabOrder = 2
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 112
          Top = 248
          Width = 75
          Height = 25
          Caption = 'Clear'
          TabOrder = 3
          OnClick = Button2Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Text'
      ImageIndex = 3
      OnShow = TabSheet4Show
      object RichEdit1: TRichEdit
        Left = 0
        Top = 0
        Width = 676
        Height = 380
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object sDlg1: TSaveDialog
    DefaultExt = 'mm3'
    Filter = 'Multi MagNum Files|*.mm3'
    Left = 436
    Top = 96
  end
  object sDlg2: TSaveDialog
    DefaultExt = 'rtf'
    Filter = 'Rich Text Format|*.rtf'
    Left = 436
    Top = 128
  end
  object oDlg: TOpenDialog
    DefaultExt = 'mm3'
    Filter = 'Multi MagNum Files|*.mm3'
    Left = 476
    Top = 96
  end
end
