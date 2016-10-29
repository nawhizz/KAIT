//작성자 : hart
unit monthEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ucal;

type
  TSpeedButton1 = class(TSpeedButton)
  private
    { Private declarations }
    FForm : Tcal;
    Save_Cursor : TCursor;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property form1 : Tcal read FForm write FForm;
  published
    { Published declarations }
    procedure Click; override;
  end;

  TCalendarMonth = class(TMaskEdit)
  private
    { Private declarations }
     FButtons : TSpeedButton1;
     procedure SetEditRect;
     procedure WMSize(var Message : TWMSize); message WM_SIZE;
  protected
    { Protected declarations }
    procedure CreateParams(var Params : TCreateParams); override;
    procedure CreateWnd; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property Button : TSpeedButton1 read FButtons;
  published
    { Published declarations }
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TCalendarMonth]);
end;

function CheckDate2(Date:string):Boolean;   //날짜 체크함수
var
  year,month,day:word;
begin
  result := true;
  Try
    Year  := strtoint(copy(date,1,4));    // yyyymmdd 형태의 string에서
    month := strtoint(copy(date,5,2));    // 년,월,일을 뽑아내 입력한 날짜를
    day   := strtoint(copy(date,7,2));    // 확인함.
    EncodeDate(Year,Month,Day);
  Except
    Result := False;
  end;
end;
{$R calendar}
constructor TSpeedButton1.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
//  form.Parent  := Self;

end;

destructor TSpeedButton1.Destroy;
begin
  form1 := nil;
  inherited Destroy;
end;

procedure TSpeedButton1.Click;
var
  temp_point : TPoint;
  year_, Month_, Day_ : word;
begin
  Form1 := TCal.Create(self);
  if CheckDate2(TMaskEdit(Parent).Text+'01') then
  begin
    Year_ := strtoint(copy(TMaskEdit(Parent).Text,1,4));
    Month_ := strtoint(copy(TMaskEdit(Parent).Text,5,2));
  end
  else
    DecodeDate(Date, Year_, Month_, Day_);
  Form1.Year_ := Year_;
  Form1.Month_ := Month_;
  Form1.return_cale := TMaskEdit(Parent);
  temp_point.x := 0;
  temp_point.y := 0;
  temp_point := ClientToScreen(temp_point);
  Form1.SetBounds(temp_point.x-parent.Width+Width+5,temp_point.y+parent.Height,Form1.Width, Form1.height);
  form1.Show;
  inherited;
end;


procedure TSpeedButton1.CMMouseEnter(var Msg: TMessage);
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crArrow;
end;

procedure TSpeedButton1.CMMouseLeave(var Msg: TMessage);
begin
  Screen.Cursor := Save_Cursor;
end;

constructor TCalendarMonth.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
//  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] +
//    [csFramed, csOpaque];
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] +
    [csOpaque];
  FButtons := TSpeedButton1.Create(Self);
  FButtons.Visible := True;
  FButtons.Parent  := Self;
  FButtons.Width   := 22;
  FButtons.Height  := 27;
  FButtons.Glyph.Handle := LoadBitmap(HInstance,'calendar');
  FButtons.NumGlyphs := 1;
  FButtons.Layout := blGlyphBottom;
  FButtons.Invalidate;
  ControlStyle := ControlStyle - [csSetCaption];
  EditMask := '9999-99;0;_';
end;

destructor TCalendarMonth.Destroy;
begin
  FButtons := nil;
  inherited Destroy;
end;

procedure TCalendarMonth.CMExit(var Message: TCMExit);
var
  Year_,Month_, Day_ : word;
begin
  if not CheckDate2(Text+'01') then
  begin
    DecodeDate(Date, Year_, Month_, Day_);
    if Month_ >= 10 then
      text := inttostr(Year_)+inttostr(Month_)
    else
      text := inttostr(Year_)+'0'+inttostr(Month_);
  end
  else
  begin
    if strtoint(copy(text,5,2)) <= 9 then
      text := copy(text,1,4) + '0'+inttostr(strtoint(copy(text,5,2)));
  end;
end;

procedure TCalendarMonth.KeyDown(var Key : Word; Shift : TShiftState);
var
  Year_,Month_, Day_ : word;
begin
  if key = vk_return then
  begin
    if not CheckDate2(Text+'01') then
    begin
      DecodeDate(Date, Year_, Month_, Day_);
      if Month_ >= 10 then
        text := inttostr(Year_)+inttostr(Month_)
      else
        text := inttostr(Year_)+'0'+inttostr(Month_);
    end
    else
    begin
      if strtoint(copy(text,5,2)) <= 9 then
        text := copy(text,1,4) + '0'+inttostr(strtoint(copy(text,5,2)));
    end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TCalendarMonth.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TCalendarMonth.CreateWnd;
begin
  inherited CreateWnd;
  width := 80;
  SetEditRect;
end;

procedure TCalendarMonth.SetEditRect;
var
  Loc : TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight +1;
  Loc.Right  := ClientWidth - FButtons.Width - 2;
  Loc.Top    := 0;
  Loc.Left   := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT,   0, LongInt(@Loc));
end;

procedure TCalendarMonth.WMSize(var Message: TWMSize);
begin
  inherited;
  FButtons.SetBounds(Width-FButtons.Width-5, 0, FButtons.Width, height-5);
  SetEditRect;
end;

end.
