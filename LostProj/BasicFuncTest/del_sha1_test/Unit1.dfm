object Form1: TForm1
  Left = 411
  Top = 250
  Width = 366
  Height = 177
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 92
    Height = 13
    Caption = 'Encoded Password'
  end
  object Edit1: TEdit
    Left = 16
    Top = 32
    Width = 201
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 0
    Text = 'wodnjs12'
  end
  object Edit2: TEdit
    Left = 16
    Top = 96
    Width = 201
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 256
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Encode'
    TabOrder = 2
    OnClick = Button1Click
  end
end
