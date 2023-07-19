object fmControlCenterEC: TfmControlCenterEC
  Left = 194
  Top = 124
  Width = 695
  Height = 495
  Caption = 'Eddy Current Inspection'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 297
    Height = 461
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 297
      Height = 289
      Align = alTop
      Caption = 'Parameters'
      TabOrder = 0
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 72
        Height = 13
        Caption = 'Moving objects'
      end
      object Label2: TLabel
        Left = 168
        Top = 16
        Width = 70
        Height = 13
        Caption = 'Project objects'
      end
      object Label3: TLabel
        Left = 8
        Top = 152
        Width = 115
        Height = 13
        Caption = 'Pipe with defect material'
      end
      object Label4: TLabel
        Left = 168
        Top = 152
        Width = 24
        Height = 13
        Caption = 'Task'
      end
      object Label5: TLabel
        Left = 8
        Top = 212
        Width = 61
        Height = 13
        Caption = 'Start position'
      end
      object Label6: TLabel
        Left = 8
        Top = 236
        Width = 58
        Height = 13
        Caption = 'End position'
      end
      object Label7: TLabel
        Left = 8
        Top = 260
        Width = 86
        Height = 13
        Caption = 'Gage moving step'
      end
      object Label8: TLabel
        Left = 168
        Top = 212
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object Label9: TLabel
        Left = 168
        Top = 236
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object Label10: TLabel
        Left = 168
        Top = 260
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object SpeedButton1: TSpeedButton
        Left = 136
        Top = 56
        Width = 23
        Height = 22
        Caption = '>'
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 136
        Top = 32
        Width = 23
        Height = 22
        Caption = '<'
        OnClick = SpeedButton2Click
      end
      object Bevel1: TBevel
        Left = 8
        Top = 192
        Width = 281
        Height = 9
        Shape = bsBottomLine
      end
      object SpeedButton3: TSpeedButton
        Left = 136
        Top = 96
        Width = 23
        Height = 22
        Caption = '0'
        OnClick = SpeedButton3Click
      end
      object Label17: TLabel
        Left = 8
        Top = 120
        Width = 77
        Height = 13
        Caption = 'Basic coil object'
      end
      object Edit1: TEdit
        Left = 80
        Top = 208
        Width = 81
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit2: TEdit
        Left = 80
        Top = 232
        Width = 81
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object Edit3: TEdit
        Left = 104
        Top = 256
        Width = 57
        Height = 21
        TabOrder = 2
        Text = '1'
      end
      object Button1: TButton
        Left = 208
        Top = 208
        Width = 75
        Height = 25
        Caption = 'Start'
        Default = True
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 208
        Top = 240
        Width = 75
        Height = 25
        Caption = 'Close'
        TabOrder = 4
        OnClick = Button2Click
      end
      object ListBox1: TListBox
        Left = 8
        Top = 32
        Width = 121
        Height = 81
        Ctl3D = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 5
      end
      object ListBox2: TListBox
        Left = 168
        Top = 32
        Width = 121
        Height = 113
        ItemHeight = 13
        TabOrder = 6
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 168
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 7
      end
      object ComboBox2: TComboBox
        Left = 168
        Top = 168
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = '2D solution'
        Items.Strings = (
          '2D solution'
          '2D + 3D-Defect'
          '3D Full solution'
          '3d-3d defect')
      end
      object ComboBox4: TComboBox
        Left = 8
        Top = 132
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 9
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 289
      Width = 297
      Height = 172
      ActivePage = TabSheet1
      Align = alClient
      Enabled = False
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Solution'
        object Label15: TLabel
          Left = 8
          Top = 120
          Width = 86
          Height = 13
          Caption = 'Time of solution = '
        end
        object Label16: TLabel
          Left = 96
          Top = 120
          Width = 36
          Height = 13
          Caption = '0:00:00'
        end
        object GroupBox3: TGroupBox
          Left = 0
          Top = 0
          Width = 289
          Height = 105
          Align = alTop
          Caption = 'Solution progress'
          TabOrder = 0
          object Label12: TLabel
            Left = 8
            Top = 24
            Width = 26
            Height = 13
            Caption = 'Done'
          end
          object Gauge1: TGauge
            Left = 8
            Top = 40
            Width = 273
            Height = 33
            Progress = 0
          end
          object Label13: TLabel
            Left = 8
            Top = 80
            Width = 101
            Height = 13
            Caption = 'Gage current position'
          end
          object Label14: TLabel
            Left = 120
            Top = 80
            Width = 6
            Height = 13
            Caption = '0'
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Viewer'
        ImageIndex = 1
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 289
          Height = 144
          Align = alClient
          Caption = 'Results'
          TabOrder = 0
          object Label11: TLabel
            Left = 8
            Top = 24
            Width = 54
            Height = 13
            Caption = 'Component'
          end
          object CheckListBox1: TCheckListBox
            Left = 8
            Top = 48
            Width = 153
            Height = 73
            OnClickCheck = CheckListBox1ClickCheck
            ItemHeight = 13
            Items.Strings = (
              '    Solution'
              'Axisymmetrical 2D signal'
              'Defect 3D signal'
              'Axial +Defect signal'
              'Full 3D signal')
            TabOrder = 0
            OnClick = CheckListBox1ClickCheck
          end
          object ComboBox3: TComboBox
            Left = 72
            Top = 20
            Width = 89
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 1
            Text = 'Real'
            OnChange = CheckListBox1ClickCheck
            Items.Strings = (
              'Real'
              'Imaginary'
              'Module')
          end
          object Button3: TButton
            Left = 176
            Top = 16
            Width = 105
            Height = 25
            Caption = 'Save'
            TabOrder = 2
            OnClick = Button3Click
          end
        end
      end
    end
  end
  object Chart1: TChart
    Left = 297
    Top = 0
    Width = 390
    Height = 461
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    Legend.Visible = False
    View3D = False
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
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
    object Series2: TLineSeries
      Active = False
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
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
    object Series3: TLineSeries
      Active = False
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
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
    object Series4: TLineSeries
      Active = False
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
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
    object Series5: TLineSeries
      Active = False
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clWhite
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
