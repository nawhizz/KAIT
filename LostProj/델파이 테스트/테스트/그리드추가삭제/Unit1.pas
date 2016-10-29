unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TForm1 = class(TForm)
    strngrd1: TStringGrid;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  THackStringGrid = class(TStringGrid);
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure DeleteRow(strgrd: TStringGrid; ARow: Integer);
begin
  with THackStringGrid(strgrd) do
    DeleteRow(ARow);
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  DeleteRow(strngrd1,strngrd1.Row);
end;

procedure TForm1.btn3Click(Sender: TObject);
var i : integer;
begin
  for i := strngrd1.FixedRows to strngrd1.RowCount -1 do
    strngrd1.Cells[0,i] := IntToStr(i);
end;

end.
