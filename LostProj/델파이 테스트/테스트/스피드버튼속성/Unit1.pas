unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    btn1: TSpeedButton;
    btn2: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn2Click(Sender: TObject);
var
  bit : TBitmap;
begin
  if FileExists('.\�ݱ�.bmp') then
    bit.LoadFromFile('.\�ݱ�.bmp')
  else ShowMessage('���Ͼ���');

  btn1.Glyph := bit;
end;

end.
