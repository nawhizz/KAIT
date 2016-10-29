object Form2: TForm2
  Left = 569
  Top = 216
  Width = 365
  Height = 321
  Caption = 'Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 42
    Top = 27
    Width = 31
    Height = 13
    Caption = 'NAME'
  end
  object Label2: TLabel
    Left = 40
    Top = 64
    Width = 33
    Height = 13
    Caption = 'PHone'
  end
  object Edit1: TEdit
    Left = 80
    Top = 24
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 80
    Top = 56
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 88
    Top = 104
    Width = 121
    Height = 25
    Caption = 'Open Share Memory'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 142
    Width = 121
    Height = 25
    Caption = 'Get data'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 88
    Top = 192
    Width = 121
    Height = 25
    Caption = 'Close this window'
    TabOrder = 4
    OnClick = Button3Click
  end
end
