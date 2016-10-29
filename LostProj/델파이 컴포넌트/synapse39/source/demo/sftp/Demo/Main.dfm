object TestSFTPForm: TTestSFTPForm
  Left = 354
  Top = 128
  Width = 696
  Height = 488
  Caption = 'Test SFTP'
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
    Left = 8
    Top = 8
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 284
    Top = 8
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object Label3: TLabel
    Left = 8
    Top = 32
    Width = 26
    Height = 13
    Caption = 'Login'
  end
  object Label4: TLabel
    Left = 192
    Top = 32
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 8
    Top = 64
    Width = 48
    Height = 13
    Caption = 'Current dir'
  end
  object Label6: TLabel
    Left = 501
    Top = 19
    Width = 63
    Height = 13
    Caption = 'TotalFileSize:'
  end
  object FileNameLabel: TLabel
    Left = 442
    Top = 64
    Width = 70
    Height = 13
    Caption = 'FileNameLabel'
  end
  object HostEdit: TEdit
    Left = 48
    Top = 4
    Width = 209
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 0
    Text = '192.168.1.196'
  end
  object PortEdit: TEdit
    Left = 316
    Top = 4
    Width = 49
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 1
    Text = '22'
  end
  object LoginEdit: TEdit
    Left = 48
    Top = 28
    Width = 113
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 2
    Text = 'lomofos'
  end
  object PasswordEdit: TEdit
    Left = 252
    Top = 28
    Width = 113
    Height = 21
    ImeName = 'Microsoft IME 2003'
    PasswordChar = '*'
    TabOrder = 3
    Text = '1111'
  end
  object CurrentDirEdit: TEdit
    Left = 64
    Top = 60
    Width = 301
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 5
  end
  object ConnectButton: TButton
    Left = 380
    Top = 4
    Width = 93
    Height = 25
    Caption = 'Connect'
    TabOrder = 4
    OnClick = ConnectButtonClick
  end
  object FileListBox: TListBox
    Left = 7
    Top = 128
    Width = 673
    Height = 317
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ImeName = 'Microsoft IME 2003'
    ItemHeight = 14
    MultiSelect = True
    ParentFont = False
    TabOrder = 12
    OnDblClick = FileListBoxDblClick
  end
  object SendFileButton: TButton
    Left = 476
    Top = 101
    Width = 67
    Height = 21
    Caption = 'Send file...'
    TabOrder = 7
    OnClick = SendFileButtonClick
  end
  object GetFileButton: TButton
    Left = 544
    Top = 101
    Width = 67
    Height = 21
    Caption = 'Get file'
    TabOrder = 8
    OnClick = GetFileButtonClick
  end
  object DeleteButton: TButton
    Left = 612
    Top = 101
    Width = 67
    Height = 21
    Caption = 'Delete'
    TabOrder = 9
    OnClick = DeleteButtonClick
  end
  object ReloadButton: TButton
    Left = 368
    Top = 60
    Width = 57
    Height = 21
    Caption = 'Reload'
    TabOrder = 6
    OnClick = ReloadButtonClick
  end
  object ProgressBar: TProgressBar
    Left = 441
    Top = 78
    Width = 189
    Height = 15
    TabOrder = 10
  end
  object AbortButton: TButton
    Left = 632
    Top = 77
    Width = 45
    Height = 17
    Caption = 'Abort'
    TabOrder = 11
    OnClick = AbortButtonClick
  end
  object Edit1: TEdit
    Left = 566
    Top = 16
    Width = 112
    Height = 21
    ImeName = 'Microsoft IME 2003'
    ReadOnly = True
    TabOrder = 13
    Text = '0'
  end
  object ProgressBar1: TProgressBar
    Left = 441
    Top = 43
    Width = 188
    Height = 17
    TabOrder = 14
  end
  object OpenDialog: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 157
    Top = 80
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 228
    Top = 82
  end
end
