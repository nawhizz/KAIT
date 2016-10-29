object FileUploadP: TFileUploadP
  Left = 380
  Top = 188
  BorderStyle = bsSingle
  Caption = #48260#51260#44288#47532
  ClientHeight = 376
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #44404#47548#52404
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 2
    Top = 2
    Width = 105
    Height = 21
    Caption = #51068' '#51088
    TabOrder = 0
  end
  object XiDateEdit1: TDateEdit
    Left = 108
    Top = 2
    Width = 120
    Height = 21
    ImeName = 'Microsoft IME 2003'
    NumGlyphs = 2
    TabOrder = 1
    Text = '0000-00-00'
  end
  object Panel2: TPanel
    Left = 2
    Top = 26
    Width = 105
    Height = 21
    Caption = #48260#51204'NO.'
    TabOrder = 2
  end
  object XiEdit1: TEdit
    Left = 108
    Top = 26
    Width = 120
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 400
    Top = 29
    Width = 77
    Height = 17
    Caption = #52572#52488#48260#51204
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object Panel3: TPanel
    Left = 232
    Top = 2
    Width = 105
    Height = 21
    Caption = #54028#51068#49436#48260'IP'
    TabOrder = 5
  end
  object XiEdit2: TEdit
    Left = 338
    Top = 2
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 6
    Text = '192.168.1.196'
  end
  object XiButton3: TButton
    Left = 487
    Top = 2
    Width = 75
    Height = 25
    Caption = #52488#44592#54868
    TabOrder = 7
    OnClick = XiButton3Click
  end
  object XiButton1: TButton
    Left = 564
    Top = 2
    Width = 75
    Height = 25
    Caption = #48260#51204#49483#54021
    TabOrder = 8
    OnClick = XiButton1Click
  end
  object Btn_select: TButton
    Left = 564
    Top = 28
    Width = 75
    Height = 25
    Caption = #51204#49569
    TabOrder = 9
    OnClick = Btn_selectClick
  end
  object XiButton5: TButton
    Left = 564
    Top = 55
    Width = 75
    Height = 25
    Caption = #45803#44592
    TabOrder = 10
    OnClick = XiButton5Click
  end
  object XiButton2: TButton
    Left = 487
    Top = 28
    Width = 75
    Height = 25
    Caption = #54028#51068#52286#44592
    TabOrder = 11
    OnClick = XiButton2Click
  end
  object Panel4: TPanel
    Left = 2
    Top = 59
    Width = 116
    Height = 21
    TabOrder = 12
    object Label2: TLabel
      Left = 7
      Top = 3
      Width = 105
      Height = 13
      Caption = #49436#48260' '#50629#47196#46300#44221#47196
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #44404#47548#52404
      Font.Style = []
      ParentFont = False
    end
  end
  object GR_regGrid: TStringGrid
    Left = 3
    Top = 85
    Width = 636
    Height = 284
    ColCount = 4
    Ctl3D = True
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColMoving, goRowSelect]
    ParentCtl3D = False
    TabOrder = 13
    OnDrawCell = GR_regGridDrawCell
    OnSelectCell = GR_regGridSelectCell
    ColWidths = (
      137
      129
      142
      64)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object XiButton4: TButton
    Left = 487
    Top = 55
    Width = 75
    Height = 25
    Caption = #47112#53076#46300#49325#51228
    TabOrder = 14
    OnClick = XiButton4Click
  end
  object progressMain: TPanel
    Left = 30
    Top = 216
    Width = 578
    Height = 24
    TabOrder = 15
    Visible = False
    object progressBar: TProgressBar
      Left = 1
      Top = 1
      Width = 576
      Height = 22
      Align = alClient
      TabOrder = 0
    end
  end
  object Edit1: TEdit
    Left = 119
    Top = 59
    Width = 168
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 16
  end
  object Panel5: TPanel
    Left = 232
    Top = 26
    Width = 105
    Height = 21
    Caption = #51068#47144#48264#54840
    TabOrder = 17
  end
  object Edit2: TEdit
    Left = 338
    Top = 26
    Width = 40
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 18
    Text = '01'
  end
  object UpDown1: TUpDown
    Left = 377
    Top = 26
    Width = 17
    Height = 21
    Min = 1
    Max = 99
    Position = 1
    TabOrder = 19
    OnChanging = UpDown1Changing
  end
  object OpenDialog: TOpenDialog
    Left = 552
    Top = 104
  end
  object SkinData1: TSkinData
    Active = True
    DisableTag = 99
    SkinControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcEdit, xcButton, xcBitBtn, xcSpeedButton, xcSpin, xcPanel, xcGroupBox, xcStatusBar, xcTab, xcTrackBar, xcSystemMenu]
    Options = [xoPreview, xoToolbarBK, xoCaptionButtonHint]
    Skin3rd.Strings = (
      'TCategoryButtons=scrollbar'
      'TPngSpeedbutton=pngspeedbutton'
      'TPngBitBtn=pngbitbtn'
      'TVirtualStringTree=scrollbar'
      'TVirtualDrawTree=scrollbar'
      'TTBXDockablePanel=Panel'
      'TAdvPanelGroup=scrollbar'
      'TComboboxex=combobox'
      'TRxSpeedButton=speedbutton'
      'THTMLViewer=scrollbar'
      'TDBCtrlGrid=scrollbar'
      'TfrSpeedButton=speedbutton'
      'TfrTBButton=speedbutton'
      'TControlBar=Panel'
      'TTBDock=Panel'
      'TTBToolbar=Panel'
      'TImageEnMView=scrollbar'
      'TImageEnView=scrollbar'
      'TAdvMemo=scrollbar'
      'TDBAdvMemo=scrollbar'
      'TcxDBLookupComboBox=combobox'
      'TcxDBComboBox=combobox'
      'TcxDBDateEdit=combobox'
      'TcxDBImageComboBox=combobox'
      'TcxDBCalcEdit=combobox'
      'TcxDBBlobEdit=combobox'
      'TcxDBPopupEdit=combobox'
      'TcxDBFontNameComboBox=combobox'
      'TcxDBShellComboBox=combobox'
      'TRxLookupEdit=combobox'
      'TRxDBLookupCombo=combobox'
      'TRzGroup=panel'
      'TRzButton=button'
      'TRzBitbtn=bitbtn'
      'TRzMenuButton=menubtn'
      'TRzCheckGroup=CheckGroup'
      'TRzRadioGroup=Radiogroup'
      'TRzButtonEdit=Edit'
      'TRzDBRadioGroup=Radiogroup'
      'TRzDBRadioButton=Radiobutton'
      'TRzDateTimeEdit=combobox'
      'TRzColorEdit=combobox'
      'TRzDateTimePicker=combobox'
      'TRzDBDateTimeEdit=combobox'
      'TRzDbColorEdit=combobox'
      'TRzDBDateTimePicker=combobox'
      'TLMDButton=bitbtn'
      'TLMDGroupBox=Groupbox'
      'TDBCheckboxEh=Checkbox'
      'TDBCheckboxEh=Checkbox'
      'TLMDCHECKBOX=Checkbox'
      'TLMDDBCHECKBOX=Checkbox'
      'TLMDRadiobutton=Radiobutton'
      'TLMDCalculator=panel'
      'TLMDGROUPBOX=Panel'
      'TLMDSIMPLEPANEL=Panel'
      'TLMDDBCalendar=Panel'
      'TLMDButtonPanel=Panel'
      'TLMDLMDCalculator=Panel'
      'TLMDHeaderPanel=Panel'
      'TLMDTechnicalLine=Panel'
      'TLMDLMDClock=Panel'
      'TLMDTrackbar=panel'
      'TLMDListCombobox=combobox'
      'TLMDCheckListCombobox=combobox'
      'TLMDHeaderListCombobox=combobox'
      'TLMDImageCombobox=combobox'
      'TLMDColorCombobox=combobox'
      'TLMDFontCombobox=combobox'
      'TLMDFontSizeCombobox=combobox'
      'TLMDFontSizeCombobox=combobox'
      'TLMDPrinterCombobox=combobox'
      'TLMDDriveCombobox=combobox'
      'TLMDCalculatorComboBox=combobox'
      'TLMDTrackBarComboBox=combobox'
      'TLMDCalendarComboBox=combobox'
      'TLMDTreeComboBox=combobox'
      'TLMDRADIOGROUP=radiogroup'
      'TLMDCheckGroup=CheckGroup'
      'TLMDDBRADIOGROUP=radiogroup'
      'TLMDDBCheckGroup=CheckGroup'
      'TLMDCalculatorEdit=edit'
      'TLMDEDIT=Edit'
      'TLMDMASKEDIT=Edit'
      'TLMDBROWSEEDIT=Edit'
      'TLMDEXTSPINEDIT=Edit'
      'TLMDCALENDAREDIT=Edit'
      'TLMDFILEOPENEDIT=Edit'
      'TLMDFILESAVEEDIT=Edit'
      'TLMDCOLOREDIT=Edit'
      'TLMDDBEDIT=Edit'
      'TLMDDBMASKEDIT=Edit'
      'TLMDDBEXTSPINEDIT=Edit'
      'TLMDDBSPINEDIT=Edit'
      'TLMDDBEDITDBLookup=Edit'
      'TLMDEDITDBLookup=Edit'
      'TDBLookupCombobox=Combobox'
      'TWWDBCombobox=Combobox'
      'TWWDBLookupCombo=Combobox'
      'TWWDBCombobox=Combobox'
      'TWWKeyCombo=Combobox'
      'TWWTempKeyCombo=combobox'
      'TWWDBDateTimePicker=Combobox'
      'TWWRADIOGROUP=radiogroup'
      'TWWDBEDIT=Edit'
      'TcxButton=bitbtn'
      'TcxDBRadioGroup=radiogroup'
      'TcxRadioGroup=radiogroup'
      'TcxGroupbox=groupbox'
      'TOVCPICTUREFIELD=Edit'
      'TOVCDBPICTUREFIELD=Edit'
      'TOVCSLIDEREDIT=Edit'
      'TOVCDBSLIDEREDIT=Edit'
      'TOVCSIMPLEFIELD=Edit'
      'TOVCDBSIMPLEFIELD=Edit'
      'TO32DBFLEXEDIT=Edit'
      'TOVCNUMERICFIELD=Edit'
      'TOVCDBNUMERICFIELD=Edit')
    SkinFile = '../Skin/mxskin71.skn'
    SkinStore = '(none)'
    SkinFormtype = sfMainform
    Version = '5.60.06.20'
    MenuUpdate = True
    MenuMerge = False
    Left = 344
    Top = 56
    SkinStream = {00000000}
  end
end
