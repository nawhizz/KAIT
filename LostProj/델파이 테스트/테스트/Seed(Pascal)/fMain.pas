unit fMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btnEncrypt: TButton;
    edtData: TEdit;
    EncData: TGroupBox;
    DecData: TGroupBox;
    Label1: TLabel;
    memEnc: TMemo;
    memDec: TMemo;
    Button1: TButton;
    procedure btnEncryptClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

uses
  Seed;

{$R *.dfm}

procedure TForm1.btnEncryptClick(Sender: TObject);
var
    pdwRoundKey     : Array[0..31] of LongWord;
    pbUserKey       : Array[0..15] of BYTE;
    pbData          : Array[0..15] of BYTE;
    wStr            : String;
    aStr            : AnsiString;
    Len, i          : Integer;
begin
    //FillChar(pbData, 16, #0);
    //FillChar(pbUserKey, 16, #0);

    // ��ȣȭŰ ����
    FillChar(pbUserKey, SizeOf(pbUserKey), 0);
    Move( 'K2I5I4S3L3C0H1U1', pbUserKey, SizeOf(pbUserKey) );

    //for i := 0 to 31 do
    //begin
    //    pdwRoundKey[i]  := 0;
    //end;

    // RoundKey ����
    FillChar(pdwRoundKey, SizeOf(pdwRoundKey), 0);
    SeedEncRoundKey(pdwRoundKey, pbUserKey);

    // ��ȣȭ�� �ؽ�Ʈ
    //FillChar(pbData, SizeOf(pbData), 0);

    //wStr    := Self.edtData.Text;
    //for i := 0 to 15 do
    //begin
    //    pbData[i]       := Byte(wStr[i + 1]);
    //end;

    //ShowMessage(pbUserKey);

    // ��ȣȭ�� �ؽ�Ʈ�� pbData�迭�� ����
    FillChar(pbData, SizeOf(pbData), 0);

    if (Length(Self.edtData.Text) > SizeOf(pbData)) then
        Len := SizeOf(pbData)
    else
        Len := Length(Self.edtData.Text);

    wStr    := Self.edtData.Text;
    Move( wStr, pbData, Len );

    SeedEncrypt(pbData, pdwRoundKey);

    wStr    := '';
    for i := 0 to 15 do
    begin
        //wStr    := wStr + IntToHex(pbData[i], 2);
        wStr    := wStr + Char(pbData[i]);
    end;

    //SetString(aStr, PAnsiChar(@pbData[0]), SizeOf(pbData));
    //wStr := string(aStr);

    Self.memEnc.Lines.Add(wStr);

    SeedDecrypt(pbData, pdwRoundKey);

    wStr    := '';
    for i := 0 to 15 do
    begin
        wStr    := wStr + IntToHex(pbData[i], 2);
    end;
    Self.memDec.Lines.Add(wStr);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
    s    : string;
    AStr : ^string;
begin
    // �޸� �Ҵ�
    New(AStr);

    AStr^ := 'SAMPLE';
    ShowMessage(AStr^);

    // �޸� ����
    Dispose(AStr);

    s := '������';

    ShowMessage(IntToStr(length(s)));
end;

end.
