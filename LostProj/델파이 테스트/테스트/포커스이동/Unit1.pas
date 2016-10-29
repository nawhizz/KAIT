unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit2;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if key <> #13 then Exit;

  SelectNext(Sender as TWinControl,True,True);
end;

end.
