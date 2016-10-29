object Form1: TForm1
  Left = 573
  Top = 382
  Width = 564
  Height = 430
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
  object strngrd1: TStringGrid
    Left = 32
    Top = 24
    Width = 409
    Height = 129
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
  end
  object btn1: TBitBtn
    Left = 96
    Top = 200
    Width = 81
    Height = 25
    Caption = #52628#44032
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TBitBtn
    Left = 208
    Top = 200
    Width = 89
    Height = 25
    Caption = #49325#51228
    TabOrder = 2
  end
  object btn3: TBitBtn
    Left = 312
    Top = 200
    Width = 97
    Height = 25
    Caption = #52488#44592#54868
    TabOrder = 3
    OnClick = btn3Click
  end
end
