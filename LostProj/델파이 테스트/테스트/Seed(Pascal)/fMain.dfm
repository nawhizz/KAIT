object Form1: TForm1
  Left = 813
  Top = 217
  Width = 488
  Height = 484
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
    Left = 8
    Top = 12
    Width = 32
    Height = 13
    Caption = 'Data : '
  end
  object btnEncrypt: TButton
    Left = 364
    Top = 8
    Width = 74
    Height = 25
    Caption = 'btnEncrypt'
    TabOrder = 0
    OnClick = btnEncryptClick
  end
  object edtData: TEdit
    Left = 48
    Top = 8
    Width = 309
    Height = 21
    Hint = 'Only 16byte data'
    ImeName = #54620#44397#50612' '#51077#47141' '#49884#49828#53596' (IME 2000)'
    MaxLength = 16
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object EncData: TGroupBox
    Left = 4
    Top = 32
    Width = 237
    Height = 393
    Caption = 'EncData'
    TabOrder = 2
    object memEnc: TMemo
      Left = 4
      Top = 16
      Width = 229
      Height = 369
      ImeName = #54620#44397#50612' '#51077#47141' '#49884#49828#53596' (IME 2000)'
      TabOrder = 0
    end
  end
  object DecData: TGroupBox
    Left = 244
    Top = 32
    Width = 233
    Height = 393
    Caption = 'DecData'
    TabOrder = 3
    object memDec: TMemo
      Left = 4
      Top = 16
      Width = 225
      Height = 369
      ImeName = #54620#44397#50612' '#51077#47141' '#49884#49828#53596' (IME 2000)'
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 448
    Top = 8
    Width = 29
    Height = 25
    Caption = 'EX'
    TabOrder = 4
    OnClick = Button1Click
  end
end
