//작성자 : hart
unit ucal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, mask, Grids;

type
  Tcal = class(TForm)
    Year_level: TLabel;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
    x1,y1 : Integer;
    col1, row1 : integer;
    procedure CreateParams(var Params: TCreateParams); override;
  public
     Year_, Month_ : integer;
     return_cale : TMaskEdit;
    { Public declarations }
  end;

var
  cal: Tcal;

implementation

{$R *.DFM}

procedure Tcal.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure Tcal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure Tcal.FormDeactivate(Sender: TObject);
begin
  close;
end;

procedure Tcal.FormCreate(Sender: TObject);
begin
  width := 77;
  StringGrid1.Cells[0,0] := '1';
  StringGrid1.Cells[1,0] := '2';
  StringGrid1.Cells[2,0] := '3';
  StringGrid1.Cells[0,1] := '4';
  StringGrid1.Cells[1,1] := '5';
  StringGrid1.Cells[2,1] := '6';
  StringGrid1.Cells[0,2] := '7';
  StringGrid1.Cells[1,2] := '8';
  StringGrid1.Cells[2,2] := '9';
  StringGrid1.Cells[0,3] := '10';
  StringGrid1.Cells[1,3] := '11';
  StringGrid1.Cells[2,3] := '12';

end;

procedure Tcal.SpeedButton1Click(Sender: TObject);
begin
  if Year_level.Tag > 1900 then
  begin
    Year_level.Tag     := Year_level.Tag - 1;
    Year_level.Caption := inttostr(Year_level.Tag)+'년';
  end;
end;

procedure Tcal.SpeedButton2Click(Sender: TObject);
begin
  if Year_level.Tag < 2500 then
  begin
    Year_level.Tag := Year_level.Tag + 1;
    Year_level.Caption := inttostr(Year_level.Tag)+'년';
  end;
end;

procedure Tcal.FormShow(Sender: TObject);
begin
  Year_level.Tag     := Year_;
  Year_level.Caption := inttostr(Year_level.Tag)+'년';

  StringGrid1.Col := (Month_ - 1) mod 3;
  StringGrid1.Row := (Month_ - 1) div 3;
end;

procedure Tcal.StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
  Rect: TRect; State: TGridDrawState);
var
   Left : integer;
   DataInCell : string;
   temp_color,temp_Font_color : tcolor;
begin
  DataInCell := StringGrid1.Cells[Col,Row];
  with StringGrid1.Canvas do
  begin
    temp_color := StringGrid1.Canvas.brush.Color;
    temp_Font_color := StringGrid1.Canvas.Font.Color;
    if (col1 = col) and (row1 = row) then
    begin
      StringGrid1.Canvas.brush.Color := ClBlue;
      StringGrid1.Canvas.Font.Color := clWhite;
    end;
    FillRect(Rect);
    Left := Rect.Left + ((Rect.Right-Rect.Left) - TextWidth(DataInCell)) div 2;
    TextRect(Rect, Left, Rect.Top+3, DataInCell);
    StringGrid1.Canvas.brush.Color := temp_color;
    StringGrid1.Canvas.Font.Color := temp_Font_color;
  end;
end;

procedure Tcal.StringGrid1DblClick(Sender: TObject);
var
  acol,arow : longint;
begin
  StringGrid1.MouseToCell(x1,y1,acol,arow);
  if (acol >= 0) and (acol <= 2) and (arow >= 0) and (arow <= 3) then
  begin
    Month_ := (acol + 1) + (arow * 3);
    if Month_ >= 10 then
      return_cale.text := inttostr(Year_level.Tag)+inttostr(Month_)
    else
      return_cale.text := inttostr(Year_level.Tag)+'0'+inttostr(Month_);
    close;
  end;
end;

procedure Tcal.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  x1 := x;
  y1 := y;
end;

procedure Tcal.StringGrid1SelectCell(Sender: TObject; Col, Row: Integer;
  var CanSelect: Boolean);
begin
  col1 := col;
  row1 := row;
end;

end.
