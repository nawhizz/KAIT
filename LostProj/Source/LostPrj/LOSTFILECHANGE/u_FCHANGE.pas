unit u_FCHANGE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFCHANGEfrm = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCHANGEfrm: TFCHANGEfrm;

implementation

{$R *.dfm}

procedure TFCHANGEfrm.Button1Click(Sender: TObject);
begin

	If FileExists(ExtractFilePath(Application.ExeName) + '\LostLogin_.exe') Then begin
    	CopyFile(PChar(ExtractFilePath(Application.ExeName) + '\LostLogin_.exe'), PChar(ExtractFilePath(Application.ExeName) + '\LostLogin.exe'), false);
    	DeleteFile(ExtractFilePath(Application.ExeName) + '\LostLogin_.exe');
    end;


	If FileExists(ExtractFilePath(Application.ExeName) + '\FileDownload_1.exe') Then begin
    	CopyFile(PChar(ExtractFilePath(Application.ExeName) + '\FileDownload_.exe'), PChar(ExtractFilePath(Application.ExeName) + '\FileDownload.exe'), false);
    	DeleteFile(ExtractFilePath(Application.ExeName) + '\FileDownload_.exe');
    end;

  if WinExec(PChar(ExtractFilePath(Application.ExeName) + '\LostLogin.exe '+ IntToStr(self.Handle)), SW_Show) > 31 then
    PostMessage(self.Handle, WM_QUIT, 0,0)
end;

procedure TFCHANGEfrm.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled := false;

	Button1Click(SELF);
end;

procedure TFCHANGEfrm.FormCreate(Sender: TObject);
begin

	if ParamCount <> 1 then
    	PostMessage(self.Handle, WM_QUIT, 0,0)
  else
    	Timer1.Enabled:= True;

end;

end.
