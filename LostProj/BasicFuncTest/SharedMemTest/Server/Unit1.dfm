object Form1: TForm1
  Left = 588
  Top = 253
  Width = 299
  Height = 282
  Caption = 'Server'
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
    Text = 'Delphi'
  end
  object Edit2: TEdit
    Left = 80
    Top = 56
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 1
    Text = '010-715-0000'
  end
  object Button1: TButton
    Left = 80
    Top = 88
    Width = 121
    Height = 25
    Caption = 'Create Share Memory'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 80
    Top = 123
    Width = 121
    Height = 25
    Caption = 'Data insert'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 81
    Top = 154
    Width = 120
    Height = 25
    Caption = 'Close Shared Mem.'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 80
    Top = 200
    Width = 121
    Height = 25
    Caption = 'Execute Win Program'
    TabOrder = 5
    OnClick = Button4Click
  end
end
