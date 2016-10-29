unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  function CFillStr (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : shortstring ;

  function CfillStr2 (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : string ;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.CFillStr (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : shortstring ;
var
   dest : shortstring ;
   idx : integer ;
begin

     FillChar (dest, size, ' ') ;

     if length (src) > size then
   	    dest := copy (src, 1, size)
     else
     begin
        if bFront then
            begin
                 Insert (src, dest, 1) ;
                 for idx := length (src) + 1 to size do
                 begin
                    dest[idx] := fChar ;
                    ShowMessage(IntToStr(idx));
                    ShowMessage(IntToStr(length( dest)));
                 end;
            end
            else
            begin
                 Insert (src, dest, size - length (src) + 1) ;
                 for idx := 1 to size - length (src) do
                    dest[idx] := fChar ;
            end ;
     end ;

     ShowMessage(IntToStr(length( dest)));

     result := copy (dest, 1, size) ;
end ;

function TForm1.CFillStr2 (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : string ;
var
   dest : string ;
   idx : integer ;

begin
  for idx := Length(Trim(src)) to Size - 1 do
   dest := dest + fchar;

  result := src + dest;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
   edt2.Text := CFillStr2(edt1.Text,' ',100,True);
   ShowMessage(IntToStr(Length(edt2.Text)));
end;

end.
