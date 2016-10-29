object FCHANGEfrm: TFCHANGEfrm
  Left = 871
  Top = 240
  Width = 296
  Height = 119
  Caption = 'FCHANGEfrm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 80
    Top = 24
    Width = 75
    Height = 25
    Caption = 'FileChange'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 208
    Top = 24
  end
end
