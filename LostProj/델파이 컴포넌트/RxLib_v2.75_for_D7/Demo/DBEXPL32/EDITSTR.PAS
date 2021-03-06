{*******************************************************}
{                                                       }
{     Delphi VCL Extensions (RX) demo program           }
{                                                       }
{     Copyright (c) 1996 AO ROSNO                       }
{                                                       }
{*******************************************************}

unit EditStr;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Placemnt, DBCtrls, DB, DBRichEd;

type
  TStrEditDlg = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    DataSource: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    LoadBtn: TBitBtn;
    SaveBtn: TBitBtn;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Panel3: TPanel;
    LineCount: TLabel;
    Panel4: TPanel;
    DBNavigator: TDBNavigator;
    Panel5: TPanel;
    Memo: TRxDBRichEdit;
    FormPlacement: TFormStorage;
    PlainTextCheck: TCheckBox;
    procedure FileOpen(Sender: TObject);
    procedure UpdateStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SaveBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure PlainTextCheckClick(Sender: TObject);
    procedure MemoChange(Sender: TObject);
  private
    SingleLine: string[15];
    MultipleLines: string[15];
  end;

function StrListEdit(DataSet: TDataSet; const FieldName: string): Boolean;

implementation

{$R *.DFM}

uses Messages, SysUtils;

function StrListEdit(DataSet: TDataSet; const FieldName: string): Boolean;
begin
  with TStrEditDlg.Create(Application) do
  try
    DataSource.DataSet := DataSet;
    Memo.DataField := FieldName;
    UpdateStatus(nil);
    ActiveControl := Memo;
    Caption := Format('Field: %s', [FieldName]);
    Result := (ShowModal = mrOk);
  finally
    Free;
  end;
end;

{ TStrEditDlg }

procedure TStrEditDlg.FileOpen(Sender: TObject);
begin
  with OpenDialog do
    if Execute then Memo.Lines.LoadFromFile(FileName);
end;

procedure TStrEditDlg.UpdateStatus(Sender: TObject);
var
  Count: Integer;
  LineText: string;
begin
  if (Memo <> nil) then Count := Memo.Lines.Count
  else Count := 0;
  if Count = 1 then LineText := SingleLine
  else LineText := MultipleLines;
  if LineCount <> nil then
    LineCount.Caption := Format('%d %s', [Count, LineText]);
end;

procedure TStrEditDlg.FormCreate(Sender: TObject);
begin
  SingleLine := 'Line';
  MultipleLines := 'Lines';
  Memo.DefAttributes.Assign(Memo.Font);
end;

procedure TStrEditDlg.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then begin
    CancelBtn.Click;
  end;
end;

procedure TStrEditDlg.SaveBtnClick(Sender: TObject);
begin
  with SaveDialog do
    if Execute then Memo.Lines.SaveToFile(FileName);
end;

procedure TStrEditDlg.OkBtnClick(Sender: TObject);
begin
  Memo.UpdateMemo;
  ModalResult := mrOk;
end;

procedure TStrEditDlg.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  UpdateStatus(nil);
  PlainTextCheck.Checked := Memo.PlainText;
end;

procedure TStrEditDlg.PlainTextCheckClick(Sender: TObject);
begin
  Memo.PlainText := PlainTextCheck.Checked;
end;

procedure TStrEditDlg.MemoChange(Sender: TObject);
begin
  UpdateStatus(nil);
end;

end.
