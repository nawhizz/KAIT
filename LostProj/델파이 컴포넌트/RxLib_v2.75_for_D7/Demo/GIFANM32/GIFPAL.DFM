object PaletteForm: TPaletteForm
  Left = 217
  Top = 137
  BorderStyle = bsToolWindow
  Caption = 'Palette'
  ClientHeight = 253
  ClientWidth = 339
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RightPanel: TPanel
    Left = 244
    Top = 0
    Width = 95
    Height = 253
    Align = alRight
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object OkBtn: TButton
      Left = 10
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object CancelBtn: TButton
      Left = 10
      Top = 40
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object GridPanel: TPanel
    Left = 0
    Top = 0
    Width = 244
    Height = 253
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object ColorGrid: TRxDrawGrid
      Left = 5
      Top = 5
      Width = 234
      Height = 243
      Align = alClient
      ColCount = 16
      Ctl3D = True
      DefaultColWidth = 15
      DefaultRowHeight = 15
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 16
      FixedRows = 0
      Options = []
      ParentColor = True
      ParentCtl3D = False
      ScrollBars = ssNone
      TabOrder = 0
      OnDrawCell = ColorGridDrawCell
    end
  end
end
