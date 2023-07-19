object fmPostProcessor2: TfmPostProcessor2
  Left = 197
  Top = 118
  Width = 544
  Height = 375
  Caption = 'PostProcessor - 2D'
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
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 24
    Top = 24
  end
  object ActionList1: TActionList
    Left = 56
    Top = 24
    object actSave: TAction
      Caption = 'actSave'
      ShortCut = 49235
      OnExecute = actSaveExecute
    end
    object actSaveGrid: TAction
      Caption = 'actSaveGrid'
      ShortCut = 49223
      OnExecute = actSaveGridExecute
    end
  end
  object sDlgPic: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap Files (*.bmp)|*.bmp|All Files (*.*)|*.*'
    Left = 88
    Top = 24
  end
  object sDlgGrid: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files (*.txt)|*.txt|All Files (*.*)|*.*'
    Left = 128
    Top = 24
  end
end
