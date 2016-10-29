unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure StringGridDrawCell2(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGridClick2(Sender: TObject);

  end;

type
TstCellObj = packed record
  case Integer of
  0 : ( Num      : Integer);
  1 : ( Sender   : TObject);
end;

type
  TCellObj = class
  public
    bChecked: boolean;
    str: String;
  end;
  
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure DrawCheck(DC:HDC;BBRect:TRect;bCheck:Boolean);
begin
  if bCheck then
    DrawFrameControl(DC, BBRect, DFC_BUTTON, DFCS_BUTTONCHECK + DFCS_CHECKED)
  else
    DrawFrameControl(DC, BBRect, DFC_BUTTON, DFCS_BUTTONCHECK);
end;


procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  arect: TRect;
  CelObj: TstCellObj;
begin
  with TStringGrid(Sender).Canvas do begin
    if ARow > 0 then begin
      if ACol = 3 then begin
        // 3. CheckBox �׸���
        with (Sender As TStringGrid) do begin
          //ȭ���� ����ϴ�.
          Canvas.FillRect(Rect);
          // arect�� ũ���Դϴ�. Boxũ�⸦ ���� �����ϼ���.
          arect := Rect;
          arect.Top := Rect.Top + 5;
          arect.Bottom := Rect.Bottom - 5;
          CelObj.Sender:=Objects[ACol,ARow];
          DrawCheck(Canvas.Handle, arect, CelObj.Num = 1);
        end;
      end;
  end;
end;   // with end

end;

procedure TForm1.StringGrid1Click(Sender: TObject);
var
  CelObj: TstCellObj;
  pt: TPoint;
  ACol,ARow: Integer;
begin

  pt:=Mouse.CursorPos;
  pt:=StringGrid1.ScreenToClient(pt);
  StringGrid1.MouseToCell(pt.x,pt.y,ACol,ARow);
  if (ARow>0) and (ACol=3) then
  begin
     CelObj.Sender:=StringGrid1.Objects[ACol,ARow];
     if CelObj.Num=1 then CelObj.Num:=0
     else CelObj.Num:=1;
     StringGrid1.Objects[ACol,ARow]:=CelObj.Sender;
     StringGrid1.Invalidate;
     Exit;
  end;
end;

procedure TForm1.StringGridDrawCell2(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  arect: TRect;
  CellObj: TCellObj;
begin
  with TStringGrid(Sender).Canvas do begin
    if ARow > 0 then begin
      if ACol = 3 then begin
        // 3. CheckBox �׸���
        with (Sender As TStringGrid) do begin
          //ȭ���� ����ϴ�.
          Canvas.FillRect(Rect);
          // arect�� ũ���Դϴ�. Boxũ�⸦ ���� �����ϼ���.
          arect := Rect;
          arect.Top := Rect.Top + 5;
          arect.Bottom := Rect.Bottom - 5;
          if Objects[ACol,ARow]=nil then
            Objects[ACol,ARow]:= TCellObj.Create;

          DrawCheck(Canvas.Handle, arect,TCellObj(Objects[ACol,ARow]).bChecked);
        end;
      end;
  end;
end;   // with end

end;

procedure TForm1.StringGridClick2(Sender: TObject);
var
  pt: TPoint;
  ACol,ARow: Integer;
begin

  pt:=Mouse.CursorPos;
  pt:=StringGrid1.ScreenToClient(pt);
  StringGrid1.MouseToCell(pt.x,pt.y,ACol,ARow);
  if (ARow>0) and (ACol=3) then
  begin
    if StringGrid1.Objects[ACol,ARow]=nil then
      StringGrid1.Objects[ACol,ARow]:= TCellObj.Create;

    TCellObj(StringGrid1.Objects[ACol,ARow]).bChecked:= not TCellObj(StringGrid1.Objects[ACol,ARow]).bChecked;
    StringGrid1.Invalidate;
  end;
end;


procedure TForm1.RadioButton1Click(Sender: TObject);
var
  idx: Integer;
  stCell: TstCellObj;
begin
  if RadioButton1.Checked then
  begin
    StringGrid1.OnDrawCell:=StringGrid1DrawCell;
    StringGrid1.OnClick:=StringGrid1Click;

    for idx:=1 to StringGrid1.RowCount-1 do
    begin
      if StringGrid1.Objects[3,idx] <> nil then
      begin
        if TCellObj(StringGrid1.Objects[3,idx]).bChecked then
          stCell.Num:=1
        else
          stCell.Num:=0;
        TCellObj(StringGrid1.Objects[3,idx]).Free;
        StringGrid1.Objects[3,idx]:=stCell.Sender;
      end
      else
      begin
        stCell.Num:=0;
        StringGrid1.Objects[3,idx]:=stCell.Sender;
      end;
    end;
  end
  else
  begin
    StringGrid1.OnDrawCell:=StringGridDrawCell2;
    StringGrid1.OnClick:=StringGridClick2;

    for idx:=1 to StringGrid1.RowCount-1 do
    begin
      if StringGrid1.Objects[3,idx] <> nil then
      begin
        stCell.Sender:=StringGrid1.Objects[3,idx];
        StringGrid1.Objects[3,idx]:= TCellObj.Create;
        if stCell.Num=1 then
          TCellObj(StringGrid1.Objects[3,idx]).bChecked:=true
        else
          TCellObj(StringGrid1.Objects[3,idx]).bChecked:=false;
      end
      else
      begin
        StringGrid1.Objects[3,idx]:= TCellObj.Create;
        TCellObj(StringGrid1.Objects[3,idx]).bChecked:=false;
      end;
    end;
  end;
end;

end.
