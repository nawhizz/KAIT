unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Buttons,Unit2;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure initGrid;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FormCreate(Sender: TObject);
begin
  initGrid;
end;

procedure TForm1.initGrid;
begin
  with StringGrid1 do
    begin
      //Row�� ���� ����
      RowHeights[0] := 21;

      // Ÿ��Ʋ ����
      cells[0, 0] := '�ϳ�';
      cells[1, 0] := '��';
      cells[2, 0] := '��';
      cells[3, 0] := '��';
      cells[4, 0] := '�ټ�';
      cells[5, 0] := '����';
      cells[6, 0] := '�ϰ�';
      cells[7, 0] := '����';
      cells[8, 0] := '��ȩ';
      cells[9, 0] := '��';
      cells[10,0] := '���ϳ�';
      cells[11,0] := '����';

      cells[0, 1] := '1';
      cells[1, 1] := '1';
      cells[2, 1] := '1';
      cells[3, 1] := '1';
      cells[4, 1] := '1';
      cells[5, 1] := '1';
      cells[6, 1] := '1';
      cells[7, 1] := '1';
      cells[8, 1] := '1';
      cells[9, 1] := '1';
      cells[10,1] := '1';
      cells[11,1] := '1';
    end;

end;

{==============================================================================
      StringGrid �� �� ���� ���� ��Ű�� �Լ�
 ------------------------------------------------------------------------------
       i_align = 0 : ��������   i_align = 1 : �������  i_align = 2 : ����������
 ------------------------------------------------------------------------------
   ��뿹 )    �ش� StringGrid �� OnDrawCell �̺�Ʈ���� ����� ��.
        procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
                                             Rect: TRect; State: TGridDrawState);
        var  i_align : integer;
        begin
            case acol of
                2, 7, 8, 9 :  i_align := 0;
                0, 1       :  i_align := 1;
                else          i_align := 2;
            end;
            StringGrid_DrawCell(Sender, ACol, ARow, Rect, i_align);
        end;
 ------------------------------------------------------------------------------}
procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
                                     Rect: TRect; State: TGridDrawState);
var  i_align : integer;
begin
    case acol of
        2, 7, 8, 9 :  i_align := 0;
        0, 1       :  i_align := 1;
        else          i_align := 2;
    end;
    StringGrid_DrawCell(Sender, ACol, ARow, Rect, i_align);
end;

procedure TForm1.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
var
  LeftPos: Integer;
  TopPos : integer;
  CellStr: string;
begin
  with TStringGrid(Sender).Canvas do begin
    CellStr := TStringGrid(Sender).Cells[ACol, ARow];
    TopPos  := ((Rect.Top - Rect.Bottom -TStringGrid(Sender).Canvas.TextHeight(CellStr)) div 2) + Rect.Bottom;
    case i_align of
      1 :  LeftPos := ((Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) div 2) + Rect.Left;
      2 :  LeftPos :=  (Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) +
                        Rect.Left - 5;  
      else LeftPos := Rect.Left + 5;
    end;
    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  self.close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
    comm : TCOMM;
begin
   comm := TCOMM.Create(StringGrid1);
   comm.showTitle;
   comm.run(0);
end;

end.
