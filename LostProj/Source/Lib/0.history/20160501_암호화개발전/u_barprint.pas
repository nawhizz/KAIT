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
  aSend[ 01 ] := 'D11m'  +          // Dot ����
                 'H17'   +          // �μ� �µ�
                 'P4'    +          // �μ� �ӵ�
                 'S4'    +          // Feed �ӵ�
                 'C0000' +          // �ʱ� X ��ǥ
                 'R0000' + #13;     // �ʱ� Y ��ǥ
  aSend[ 02 ] := #27 + 'B1' + #13;  //  ��ġ�� �κе�12 �����ϰ� �μ�
  aSend[ 03 ] := '1'    + { ȸ��  1 : ����
                                  2 : 90
                                  3 : 180
                                  4 : 270 }
                 '4'    + { ����� �������� 2-9 : ����, ���� Font ��ȣ
                                            ���� : BarCode ���� }
                 '1'    + { ���ڳ� BarCode�� ����ũ�� ���� }
                 '1'    + { ���ڳ� BarCode�� ����ũ�� ���� }
                 '000'  + { BarCode�ϰ�� ���ڵ��� ����,
                            �����ϰ��� 9�ΰ�쿡�� �������� (010~ )
                                         9�� �ƴ� ��쿡�� �׻� 000 }
                 '0220' + { ��� ��ġ ���� }
                 '0200' + { ��� ��ġ ���� }
                 Copy( cData, 1, 6 ) + #13; { â�� ��ȣ }

  aSend[ 04 ] := '131100002200700' + Copy( cData,  7,  8 ) + #13; { �԰����� }
  aSend[ 05 ] := '131100001800200' + Copy( cData, 15, 14 ) + #13; { �� }
  aSend[ 06 ] := '131100001800700' + Copy( cData, 29,  7 ) + #13; { Serial }
  aSend[ 07 ] := '1'    + { ȸ�� }
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
                                �빮���� ��� : �ؼ������� ���
                                �ҹ����� ��� : �ؼ������� ��µ��� ���� }
                 '5'    + { �Ѳ��� Bar�� ����( ũ�� ) }
                 '2'    + { ���� Bar�� ���� ( ũ�� ) }
                 '080'  + { Barcode�� ���� }
                 '0090' + { �����ġ ���� }
                 '0120' + { �����ġ ���� }
                 Copy( cData, 36, 19 ) + #13;  { BarCode Data }

  aSend[ 08 ] := '121100000500350' + Copy( cData, 36, 19 ) + #13;
  aSend[ 09 ] := 'Q'    +      { �μ���� ��ɾ� }
                 '0001' + #13; { �μ� ���� }
  aSend[ 10 ] := 'E'    + #13;

  Comm1 := TComm.Create( Form1 );
  Comm1.DeviceName := 'Com1'; { ���� COM2 �̸� Comm1.DeviceName := 'Com2' ;}
  Comm1.BaudRate := br9600;   { ���� 19200�̸� Comm1.BaudRate := br19200;  }
  Comm1.Open;
  for nI := 0 to 10 do Comm1.Write( aSend[ nI ][1], Length( aSend[ nI ] ));
  Comm1.Close;
  Comm1.Destroy;
  result := 0;
end;

end.
