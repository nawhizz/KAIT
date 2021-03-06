unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    function LastIndexOf( const strSrc,delim: String): Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   strEdit : String;
   StrArry1 : TStringList;
   intArray1 : array[0..10] of Integer;
   cnt : integer;
   _idx : integer;

begin
   strEdit := Edit1.Text;
   cnt := 0;
   _idx := 0;
   StrArry1 := TstringList.Create;

   while pos('\',strEdit) > 0 do
     begin
      intArray1[cnt] := pos('\',strEdit);
      StrArry1.add(Copy(strEdit,_idx,intArray1[cnt]-1));
      strEdit := Copy(strEdit,intArray1[cnt] + 1,Length(strEdit));
      cnt := cnt + 1;
     end;

   StrArry1.add(Copy(strEdit,_idx,intArray1[cnt]-1));

   ShowMessage(IntToStr(LastIndexOf(Edit1.Text,'\')));
   ListBox1.Items := StrArry1;

end;

function TForm1.LastIndexOf(const strSrc,delim: String) : Integer;
  var
    temp : String;
    _idx,_idx_tmp : Integer;

  begin
    temp := strSrc;
    _idx := 0;
    _idx_tmp :=0;
    while Pos(delim,temp) > 0 do
      begin
        _idx := _idx + Pos(delim,temp);
        _idx_tmp := Pos(delim,temp);
        temp := Copy(temp,_idx_tmp + 1,Length(temp));
      end;

    Result := _idx;
  end;

  end.
