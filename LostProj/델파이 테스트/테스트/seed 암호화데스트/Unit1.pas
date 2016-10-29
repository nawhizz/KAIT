unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ComObj;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    function InsHyphen( const strSrc : String) : String; overload;
    function InsComma( const strSrc : String) : String;
    function convertWithCommer(src:String):String;

  published
    function InsHyphen( Const strSrc , strType : String) : String; overload;
  end;
var
  Form1: TForm1;

  Function DataEncrypt(seedKey, sData : Pchar) : Pchar; stdCall; external 'SeedEnc.dll';
  Function DataDecrypt(seedKey, sData : Pchar) : Pchar; stdCall; external 'SeedDec.dll';

implementation

//function Encrypt(sPlainText : String; sKey : String) : String; cdecl; external 'ECPlazaSeed.dll';
//function Decrypt(sCipherText : String; sKey : String) : String; cdecl; external 'ECPlazaSeed.dll';

//function Encrypt(sPlainText : PChar; sKey : PChar) : String; cdecl; external 'ECPlazaSeed.dll';
//function Decrypt(sCipherText : PChar; sKey : PChar) : String; cdecl; external 'ECPlazaSeed.dll';

//function MyBop(st : PChar) : Integer; cdecl; external 'TestDLL.DLL';
//function MyBanchan(a : Integer) : Integer; cdecl; external 'TestDLL.DLL';

{$R *.dfm}

function TForm1.InsHyphen( const strSrc : String) : String;
var
  strTar : String;
begin
  strTar := '';

  case Length(strSrc) of
     6 : strTar := '3-3';

     8 : strTar := '4-2-2';

    13 : strTar := '6-7';
  else
    strTar := '';
  end;

  Result := InsHyphen(strSrc,strTar);
end;

function TForm1.InsHyphen( Const strSrc , strType : String) : String;
var
  _cnt,i,_idx : Integer;
  arrInt : array of Integer;
  arrStr : array of String;
  strTmp : String;

begin
  _cnt := 0;
  strTmp := strType;

  SetLength(arrInt,0);

  //배열 크기를 구하기 위해 '-'의 개수를 구함
  for i:= 0 to Length(strType) -1 do
    begin
    if(copy(strType,i,1) = '-') then _cnt := _cnt + 1;
    end;

  setLength(arrInt,_cnt + 1);

  // 배열에 문자열의 길이를 담음
  i := 0;

  if  (Length(strTmp) <> 0) then
    begin
      repeat
          arrInt[i] := StrToInt(copy(strTmp,0,pos('-',strTmp)-1));
          strTmp := copy(strTmp,pos('-',strType) + 1,Length(strTmp));
          i := i + 1;
      until pos('-',strTmp) = 0;

      arrInt[i] := StrToInt(strTmp);
    end;

  // 배열에 문자열을 추가
  setLength(arrStr,_cnt + 1);

  _idx := 0;

  for i := 0 to Length(arrInt) -1 do
    begin
       arrStr[i] := copy(strSrc,_idx ,arrInt[i]);
       _idx := _idx + arrInt[i];
    end;

  // 배열에 담긴 문자열에 '-'를 추가함
  strTmp := '';

  for i := 0 to Length(arrStr) - 1 do
    begin
      if (i = Length(arrStr) -1 ) then strTmp := strTmp + arrStr[i]
      else strTmp := strTmp + arrStr[i] + '-';
    end;

  result := strTmp;
end;


function TForm1.InsComma( const strSrc : String) : String;
var
 _idx,i : Integer;
 strTar : String;

begin
  _idx := (Length(strSrc) mod 3) + 1;
  strTar := '';

  strTar := strTar + copy(strSrc, 1,Length(strSrc) mod 3);

  for i:= 0 to Length(strSrc) div 3 - 1 do
    begin
      strTar := strTar + ',' + copy(strSrc,_idx,3);
      _idx := _idx + 3;
    end;

  if (Length(strSrc) mod 3) = 0 then
    strTar := copy(strTar, 2,Length(strTar));

  Result := strTar;
end;

function TForm1.convertWithCommer(src:String):String;
var
	len:Integer;
begin
	result:= src;
    len:= Length(src);

    if len <= 3 then
    	exit;

    result:= convertWithCommer(Copy(src, 1, len-3)) + ',' + Copy(src, len-2, 3);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ECPlazaSeed: OLEVariant;
  gSeedKey: String;
  data: String;
  encdata, decdata: String;
begin
  gSeedKey := 'K2I5I4S3L3C0H1U1';

  data := Edit1.Text;

  //ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  //encdata := ECPlazaSeed.Encrypt(data, gSeedKey);

  encdata := StrPas(DataEncrypt(pchar(gSeedKey),  pchar(data)));

  Edit2.Text := encdata;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ECPlazaSeed: OLEVariant;
  data: String;
  gSeedKey : String;
  encdata, decdata: String;
begin
  gSeedKey := 'K2I5I4S3L3C0H1U1';

  data := Edit2.Text;

  //ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  //decdata := ECPlazaSeed.Decrypt(data, gSeedKey);

  decdata := StrPas(DataDecrypt(pchar(gSeedKey),  pchar(data)));

  Edit3.Text := decdata;
end;

end.
