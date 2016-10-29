unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

function  Get_EncStr(strPara: String):String;forward;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function  Get_EncStr(strPara: String):String;
type
   TFunc = function (type_str:PChar;input_str:PChar;output_str:PChar):Integer; stdcall;
var
   ret: integer;
   out_str: PChar;
   H: THandle;
   hash: TFunc;
   sErrMsg    : String ;
begin
   try
      Result := strPara;
      H := LoadLibrary( PChar( 'INIcrypto01h.dll') );
      GETMEM(out_str, 100);
      @hash := GetProcAddress(H, 'Hash' );
      ret := hash(Pchar('SHA1'),Pchar(strPara),out_str);
      if ret < 0 then begin
        sErrMsg := '암호를 Hash암호화 하는데 실패했습니다.'+ #13#10 +
                   '전산본부로 연락하십시오' ;
        case MessageDlg( sErrMsg , mtError	 , [mbOK] , 0 ) of
          mrOK : begin
                 end;
        end;
        Exit;
      end;
      Result := TRIM(out_str);
   finally
      FreeLibrary( H );
      FreeMem(out_str);
   end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
	Edit2.Text := Get_EncStr(Edit1.Text);
end;

end.
