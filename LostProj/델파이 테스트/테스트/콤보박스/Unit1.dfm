object Form1: TForm1
  Left = 507
  Top = 267
  Width = 486
  Height = 404
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
  object cbb1: TComboBox
    Left = 128
    Top = 32
    Width = 233
    Height = 21
    Style = csDropDownList
    ImeName = 'Microsoft Office IME 2007'
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'btn1'
      'btn2'
      'btn3')
  end
  object btn1: TButton
    Left = 159
    Top = 74
    Width = 162
    Height = 39
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 159
    Top = 170
    Width = 162
    Height = 39
    Caption = 'btn3'
    TabOrder = 3
  end
  object btn3: TButton
    Left = 159
    Top = 122
    Width = 162
    Height = 39
    Caption = 'btn2'
    TabOrder = 2
    OnClick = btn3Click
  end
  object RxDrawGrid1: TRxDrawGrid
    Left = 80
    Top = 224
    Width = 345
    Height = 129
    TabOrder = 4
  end
end
