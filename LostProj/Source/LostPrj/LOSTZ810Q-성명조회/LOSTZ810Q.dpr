program LOSTZ810Q;

uses
  Forms,
  Windows,
  u_LOSTZ810Q in 'u_LOSTZ810Q.pas' {frm_LOSTZ810Q};

var
Mutex : THandle;
{$R *.res}

begin
	//어플리케이션 중복실행 방지
	Mutex := CreateMutex(nil, True, 'LOSTZ810Q');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(Tfrm_LOSTZ810Q, frm_LOSTZ810Q);
  Application.Title:='입력관리(LOSTZ810Q)';
  		Application.Run;
  end;
  
  if Mutex <> 0 then
    CloseHandle(Mutex);
end.
