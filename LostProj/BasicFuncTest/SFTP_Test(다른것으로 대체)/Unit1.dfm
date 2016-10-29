object Form1: TForm1
  Left = 545
  Top = 311
  Width = 476
  Height = 202
  Caption = 'SFTP Server Test (File Load/Upload)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 24
    Width = 105
    Height = 25
    Caption = 'File Download'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 25
    Width = 121
    Height = 25
    Caption = 'File Upload'
    TabOrder = 1
    OnClick = Button2Click
  end
  object ProgressBar1: TProgressBar
    Left = 40
    Top = 112
    Width = 313
    Height = 17
    TabOrder = 2
  end
  object ProgressBar2: TProgressBar
    Left = 40
    Top = 136
    Width = 313
    Height = 17
    TabOrder = 3
  end
  object Button3: TButton
    Left = 143
    Top = 25
    Width = 121
    Height = 25
    Caption = 'Button3'
    TabOrder = 4
    OnClick = Button3Click
  end
end
