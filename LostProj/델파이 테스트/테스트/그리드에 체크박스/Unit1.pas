unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, QStdCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }


  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
Rect: TRect;
ACol, ARow, i: Integer;
begin
  StringGrid1.Objects[1, 1] := TCheckBox.Create(StringGrid1);

  with TCheckBox(StringGrid1.Objects[1, 1]) do
  begin
    Parent := StringGrid1;
    BoundsRect := StringGrid1.CellRect(1, 1);
    Width := StringGrid1.ColWidths[1];
    Height := StringGrid1.RowHeights[1];
    Caption := '�̰��� üũ�ڽ�';
    Checked := false;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
Rect: TRect;
ACol, ARow, i: Integer;
begin
  for i:=1 to StringGrid1.RowCount do begin
    Rect := StringGrid1.CellRect(4,i);
    ACol := 5;
    ARow := i;
    StringGrid1.Objects[ACol, ARow] := TCheckBox.Create(StringGrid1);

    with TCheckBox(StringGrid1.Objects[ACol, ARow]) do begin
      if checked then
        showmessage('checked');
    end;

  end;
end;

procedure TForm1.StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if( Sender is TCheckBox) then
begin
  with TCheckBox(Sender) do
  Checked := not Checked;
end;

end;

procedure TForm1.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = VK_SPACE then
with TCheckBox(Sender) do
Checked := not Checked;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if ACol = 1 then
    begin
    StringGrid1.Objects[2, 1] := TCheckBox.Create(StringGrid1);

    with TCheckBox(StringGrid1.Objects[2, 1]) do
    begin
      OnKeyUp     := StringGrid1KeyUp;
      OnMouseUp   := StringGrid1MouseUp;
      Parent      := StringGrid1;
      BoundsRect  := StringGrid1.CellRect(2, 1);
      Width       := StringGrid1.ColWidths[1];
      Height      := StringGrid1.RowHeights[1];
      //Caption     := '�̰��� üũ�ڽ�';
      Checked     := false;
    end;
    end;

end;

end.
