unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Unit2;

type
  TForm1 = class(TForm)
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn4: TBitBtn;
    procedure btn4Click(Sender: TObject);
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

procedure TForm1.btn4Click(Sender: TObject);

begin

  changeBtn(Form1);
  btn_Add.Enabled := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
var icon : TIcon;
begin
  icon.LoadFromFile('D:\KAIT\LostPrj\Image\lostproj.icon');
  Application.Icon := icon;
end;

end.
