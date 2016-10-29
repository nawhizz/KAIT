unit barprint;

interface

uses
//  Windows, Messages,   Graphics, Forms, Dialogs, StdCtrls, sControls,
  SysUtils, Classes; //, CommInt;

{ 1999.03.25 cSender �߰� }
function BarCodePrinting( cData : String; cTel : string ; cSender : TComponent ) : integer;

implementation

function BarCodePrinting( cData : String; cTel : string; cSender : TComponent ) : integer;
var // Comm1 : TComm;
    nI : Integer;
    aSend : Array[ 0..15 ] of String;
    outFile : TextFile;
begin

  for nI := 0 to 10 do aSend[ nI ] := '';
  aSend[ 00 ] := #02 + 'L' + #13;   // Start of Command
  aSend[ 01 ] := 'D11m'  +          // Dot ����
                 'H17'   +          // �μ� �µ�
                 'P4'    +          // �μ� �ӵ�
                 'S4'    +          // Feed �ӵ�
                 'C0000' +          // �ʱ� X ��ǥ
                 'R0000' + #13;     // �ʱ� Y ��ǥ
  aSend[ 02 ] := #27 + 'B1' + #13;  //  ��ġ�� �κе� �����ϰ� �μ�
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
                 '0230' + { ��� ��ġ ���� }
                 Copy( cData, 1, 6 ) + #13; { â�� ��ȣ }
  aSend[ 04 ] := '131100002250760' + Copy( cData,  7,  8 ) + #13; { �԰����� }
  aSend[ 05 ] := '121100001800230' + Copy( cData, 15, 24 ) + #13; { Mode }
  aSend[ 06 ] := '121100001800760' + Trim( Copy( cData, 39,  7 )) +  #13; { Serial }
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
                 '090'  + { Barcode�� ���� }
                 '0070' + { �����ġ ���� }
                 '0130' + { �����ġ ���� }
                  Copy( cData, 36, 19 ) + #13;  { BarCode Data }
  aSend[ 08 ] := '131100000300320' + Copy( cData, 46, 19 ) + #13;
  aSend[ 09 ] := '121100000000880' + Trim( Copy( cData, 65,  8 )) +  #13; { Serial }
  aSend[ 10 ] := '121100000000060' + Trim( cTel ) + #13; { telephone number }
  aSend[ 11 ] := 'Q' +             { �μ���� ��ɾ� }
                 '0001' + #13;     {  �μ���� : �ݵ�� 4�ڸ��� ä���� �Ѵ�.
                                                  '0001', '0002' }
  aSend[ 12 ] := 'E'     + #13;    { End of Command }

//  Comm1 := TComm.Create( CSender );  { ��� ������ ���� }
//  Comm1.DeviceName := 'Com1';      { ���� COM2 �̸� Comm1.DeviceName := 'Com2' ;}
//  Comm1.BaudRate := br9600;        { ���� 19200�̸� Comm1.BaudRate := br19200;  }
//  Comm1.Open;                      { Port Open }

  AssignFile( outFile, 'LPT1' );
  reWrite( outFile );
  for nI := 0 to 12 do WriteLn( outFile, aSend[ nI ] );
  CloseFile( outFile );

// Comm1.Write( aSend[ nI ][1], Length( aSend[ nI ] )); { Data ���� }
//  Comm1.Close;                     { Port Close }
//  Comm1.Destroy;                   { ������ ���� }
  result := 0;

end;

end.
