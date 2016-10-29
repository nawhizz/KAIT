unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolEdit, CurrEdit, StdCtrls, Mask;

type
  TForm1 = class(TForm)
    DateEdit1: TDateEdit;
    RxCalcEdit1: TRxCalcEdit;
    procedure DateEdit1Change(Sender: TObject);
    procedure RxCalcEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DateEdit1Change(Sender: TObject);
var
	str:String;
begin
	str := DateEdit1.Text;
    ShowMessage('변경된 날짜 = '+str);
end;

procedure TForm1.RxCalcEdit1Change(Sender: TObject);
var
	str:String;
begin
	str:= RxCalcEdit1.Text;
    ShowMessage('변경된 값= '+str);
end;

end.
