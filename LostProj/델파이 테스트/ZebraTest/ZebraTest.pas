unit ZebraTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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

procedure TForm1.Button1Click(Sender: TObject);

var
  Canvas  : TCanvas;
  F       : TextFile;
  buff    : string;
  OutFile : TextFile;

  sheight :Cardinal;	  //���ڿ� ����
  ygap    :Cardinal;		//���� ������ ��, 1mm
  yposi   :Cardinal;

  _cnt    : Integer;

  sPrn     : String;
  YY      : integer;

begin
  _cnt := 0;

  buff  :=  '';

  sPrn := '^XA' + #13#10;
  sPrn := sPrn + '^BY2,2.0^FS'               + #13#10;
  sPrn := sPrn + '^SEE:UHANGUL.DAT^FS'       + #13#10;
  sPrn := sPrn + '^CW1,E:KFONT3.FNT^CI26^FS' + #13#10;

  sPrn  :=  sPrn + '^FO50,0^A1N,40,40^FD' + 'â���ȣ : 600295   �԰����� : 20150127' +  '^FS'   + #13#10;
  sPrn  :=  sPrn + '^FO50,50^A1N,40,40^FD' + ''  +  '^FS'   + #13#10;
  sPrn  :=  sPrn + '^FO50,100^A1N,40,40^FD' + '�� �� �� : LG-F320S                      ' +  '^FS'   + #13#10;
  sPrn  :=  sPrn + '^FO50,150^A1N,40,40^FD' + '�Ϸù�ȣ : 595004           ����� :     ' +  '^FS'   + #13#10;
  sPrn  :=  sPrn + '^FO50,200^A1N,40,40^FD' + 'DI05595004          20150127  *****      ' +  '^FS'   + #13#10;

  sPrn := sPrn + '^PQ2,1,1,Y^FS';
  sPrn := sPrn + '^XZ';

  showMessage(sPrn);
  try
    AssignFile(OutFile, 'LPT1');
    Rewrite(OutFile);
    Writeln(OutFile, sPrn);
    CloseFile(OutFile);
  except

    CloseFile(OutFile);
  end;

end;

end.
