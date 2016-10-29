unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, monthEdit, ToolEdit,DateUtils;

type
  TForm1 = class(TForm)
    Mon_basic1: TCalendarMonth;
    btn1: TButton;
    edt_1: TEdit;
    edt1: TDateEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin

  Mon_basic1.Text := Copy(StringReplace(DateToStr(date),'-','',[rfReplaceAll]),0,6);

  edt1.Date := IncMonth(StrToDate(Mon_basic1.EditText+ '-07'),-1);
end;

end.
