unit LALMlogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, DB, ADODB;

type
  TfLALMLogin = class(TForm)
    Image1: TImage;
    sbLogin: TSpeedButton;
    sbClose: TSpeedButton;
    rbAucType1: TRadioButton;
    rbAucType2: TRadioButton;
    rbAucType3: TRadioButton;
    Image2: TImage;
    Label3: TLabel;
    dtpAucDate: TDateTimePicker;
    procedure sbCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbLoginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }

  public
    { Public declarations }
    sState : String;
  end;

var
  fLALMLogin: TfLALMLogin;

  Function DataDecrypt(seedKey, sData : Pchar) : Pchar; stdCall; external 'SeedDec.dll';
  Function seedKeyExtract(keyValue : Pchar) : Pchar; stdCall; external 'KeyExtract.dll';

implementation

uses LALMmain, LALMCommon;


{$R *.dfm}

procedure TfLALMLogin.sbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfLALMLogin.FormCreate(Sender: TObject);
var aa : Integer;
    ss : String;
begin
//  If ParamCount <> 3 then
//  begin
//    MessageDlg('프로그램 시작 정보가 부족합니다.', mtInformation, [mbOk], 0);
//    Application.Terminate;
//  end;

  New(AucInfo);
  New(AucConfig);
  New(VoiceInfo);

  ReadConfig;
  dtpAucDate.DateTime := Now;
  
  Try
  {
    If (Trim(ParamStr(1)) = '') or (Trim(ParamStr(2)) = '') or (Trim(ParamStr(3)) = '') Then
    begin
      MessageDlg('정상적인 로그인이 아닙니다', mtInformation, [mbOk], 0);
      Application.Terminate;
    end;
  }
  gSeedKey := ParamStr(1);
  ss        := ParamStr(2);   //'dddddd' ;
  Sleep(200);
  gDBServer := StrPas(DataDecrypt(pchar(gSeedKey),  pchar(ss)));

  Delete(gDBServer, 1, Pos(';', gDBServer));
  Delete(gDBServer, 1, Pos(';', gDBServer));
//  gDBServer :=
 // gDBServer := 'Provider=SQLOLEDB.1;Password=lalm123;Persist Security Info=True;User ID=lalm;Initial Catalog=LALM;Data Source=10.220.210.163,2353;';

  gLoginId  := ParamStr(3);

  Except
    MessageDlg('정상적인 로그인이 아닙니다', mtInformation, [mbOk], 0);
    Application.Terminate;
  end;

end;

procedure TfLALMLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dispose(AucInfo);
  Dispose(AucConfig);
  Dispose(VoiceInfo)
end;

procedure TfLALMLogin.sbLoginClick(Sender: TObject);
begin
    AucInfo^.AucDate := FormatDateTime('YYYYMMDD', dtpAucDate.DateTime);
    If rbAucType1.Checked then AucInfo^.AucType := '1'
    else If rbAucType2.Checked then AucInfo^.AucType := '2'
    else If rbAucType3.Checked then AucInfo^.AucType := '3';

  Application.CreateForm(TfLALMmain, fLALMmain);
  fLALMmain.show;
end;

procedure TfLALMLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Escape then Close;
  If Key = VK_Return then sbLogin.Click;
end;

end.
