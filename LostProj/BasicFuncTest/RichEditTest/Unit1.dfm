object Form1: TForm1
  Left = 373
  Top = 117
  Width = 870
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 1
    Top = 1
    Width = 856
    Height = 360
    Font.Charset = HANGEUL_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #44404#47548#52404
    Font.Style = []
    ImeName = 'Microsoft IME 2003'
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Button1: TButton
    Left = 16
    Top = 384
    Width = 75
    Height = 25
    Caption = 'RichEditest'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Print'
    TabOrder = 2
    OnClick = Button2Click
  end
end
