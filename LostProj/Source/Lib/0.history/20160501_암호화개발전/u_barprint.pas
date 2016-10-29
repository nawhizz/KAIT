unit u_barprint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CommInt;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function BarCodePrinting( cData : String ) : integer;
implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin

  BarCodePrinting( edit1.text );
end;


function BarCodePrinting( cData : String ) : integer;
var Comm1 : TComm;
    nI : Integer;
    aSend : Array[ 0..10 ] of String;
begin

  for nI := 0 to 10 do aSend[ nI ] := '';
  aSend[ 00 ] := #02 + 'L' + #13;   // Start of Command
  aSend[ 01 ] := 'D11m'  +          // Dot 비율
                 'H17'   +          // 인쇄 온도
                 'P4'    +          // 인쇄 속도
                 'S4'    +          // Feed 속도
                 'C0000' +          // 초기 X 좌표
                 'R0000' + #13;     // 초기 Y 좌표
  aSend[ 02 ] := #27 + 'B1' + #13;  //  겹치는 부분도12 선명하게 인쇄
  aSend[ 03 ] := '1'    + { 회전  1 : 정상
                                  2 : 90
                                  3 : 180
                                  4 : 270 }
                 '4'    + { 출력할 문자종류 2-9 : 영문, 숫자 Font 번호
                                            영문 : BarCode 종류 }
                 '1'    + { 문자나 BarCode의 가로크기 비율 }
                 '1'    + { 문자나 BarCode의 세로크기 비율 }
                 '000'  + { BarCode일경우 바코드의 높이,
                            문자일경우는 9인경우에는 문자종류 (010~ )
                                         9가 아닌 경우에는 항상 000 }
                 '0220' + { 출력 위치 세로 }
                 '0200' + { 출력 위치 가로 }
                 Copy( cData, 1, 6 ) + #13; { 창고 번호 }

  aSend[ 04 ] := '131100002200700' + Copy( cData,  7,  8 ) + #13; { 입고일자 }
  aSend[ 05 ] := '131100001800200' + Copy( cData, 15, 14 ) + #13; { 모델 }
  aSend[ 06 ] := '131100001800700' + Copy( cData, 29,  7 ) + #13; { Serial }
  aSend[ 07 ] := '1'    + { 회전 }
                 'a'    + { Barcode
                            A : 3 of 9
                            D : I 2 of 5
                            H : HIBC
                            I : CODABAR
                            J : I 2 of 5 W/Bars
                            K : PLESSEY
                            L : CASECODE
                            B : UPC-A
                            C : UPC-E
                            E : CODE 128
                            F : EAN-13
                            G : EAN-8
                            M : UPC 2 DIG ADD
                            N : UPC 5 DIG ADD
                            O : Code 93
                            p : ZIP
                            Q : UCC / EAN 128
                            R : UCC / EAN 128 ( for KMART )
                            S : UCC / EAN 128 Random Weight
                                대문자일 경우 : 해석라인의 출력
                                소문자일 경우 : 해석라인이 출력되지 않음 }
                 '5'    + { 뚜꺼운 Bar의 비율( 크기 ) }
                 '2'    + { 가는 Bar의 비율 ( 크기 ) }
                 '080'  + { Barcode의 높이 }
                 '0090' + { 출력위치 세로 }
                 '0120' + { 출력위치 가로 }
                 Copy( cData, 36, 19 ) + #13;  { BarCode Data }

  aSend[ 08 ] := '121100000500350' + Copy( cData, 36, 19 ) + #13;
  aSend[ 09 ] := 'Q'    +      { 인쇄수량 명령어 }
                 '0001' + #13; { 인쇄 수량 }
  aSend[ 10 ] := 'E'    + #13;

  Comm1 := TComm.Create( Form1 );
  Comm1.DeviceName := 'Com1'; { 만약 COM2 이면 Comm1.DeviceName := 'Com2' ;}
  Comm1.BaudRate := br9600;   { 만약 19200이면 Comm1.BaudRate := br19200;  }
  Comm1.Open;
  for nI := 0 to 10 do Comm1.Write( aSend[ nI ][1], Length( aSend[ nI ] ));
  Comm1.Close;
  Comm1.Destroy;
  result := 0;
end;

end.
