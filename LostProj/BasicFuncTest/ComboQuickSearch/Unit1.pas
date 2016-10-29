unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Mask, ToolEdit;

type
  TForm1 = class(TForm)
    md_grid1: TStringGrid;
    md_cb1: TComboEdit;
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure md_cb1Enter(Sender: TObject);
    procedure md_grid1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp := nil;
   md_grid1.OnClick := nil;

   if not md_Grid1.Visible then
   begin
      md_Grid1.Visible := true;
   end else
      md_Grid1.Visible := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp := md_cb1KeyUp;
   md_grid1.OnClick := md_Grid1Click;
end;

procedure TForm1.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp := nil;
   md_grid1.OnClick := nil;

   if key = 13 then
   begin
      if md_grid1.Visible then
         md_grid1.Visible := false
      else
         md_grid1.Visible := true;
      md_cb1.Text := '';
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
         md_grid1.Row := md_grid1.Row - 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
         md_grid1.Row := md_grid1.Row + 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then
         md_grid1.Visible := true;
      for i := 0 to md_grid1.RowCount-1 do
      if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
      begin
         md_grid1.Row := i;
         break;
      end;
   end;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp := md_cb1KeyUp;
   md_grid1.OnClick := md_Grid1Click;
end;

procedure TForm1.md_cb1Enter(Sender: TObject);
begin
   md_grid1.Visible := false;
end;

procedure TForm1.md_grid1Click(Sender: TObject);
begin
   md_cb1.text :=md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	md_Grid1.RowCount := 11;
    md_Grid1.ColWidths[0] := 161;
    md_Grid1.ColWidths[1] := 30;

     md_Grid1.Cells[0,0] := '(X)HTC-DIAMOND';
     md_Grid1.Cells[0,1] := '01X-3G-KT';
     md_Grid1.Cells[0,2] := '01X-3G-KTF';
     md_Grid1.Cells[0,3] := '109182110C';
     md_Grid1.Cells[0,4] := '1145K';
     md_Grid1.Cells[0,5] := '1154';
     md_Grid1.Cells[0,6] := '121-J4K-1(NOKIA)';
     md_Grid1.Cells[0,7] := '17-10505A';
     md_Grid1.Cells[0,8] := '17-1051';
     md_Grid1.Cells[0,9] := '11811';
     md_Grid1.Cells[0,10] := '1811T2';

     md_Grid1.Cells[1,0] := '10';
     md_Grid1.Cells[1,1] := '10';
     md_Grid1.Cells[1,2] := '30';
     md_Grid1.Cells[1,3] := 'B0';
     md_Grid1.Cells[1,4] := 'C0';


end;

end.
