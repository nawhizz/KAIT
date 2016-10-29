program LostLogin;

uses
  Forms,
  Windows,
  u_lostlogo in 'u_lostlogo.pas' {frm_LOSTLOGO};

var
Mutex : THandle;
{$R *.res}

begin
	//어플리케이션 중복실행 방지
	Mutex := CreateMutex(nil, True, 'LOSTLOGIN');

	if (Mutex <> 0 ) and (GetLastError = 0) then
  begin
    Application.Initialize;
    Application.CreateForm(Tfrm_LOSTLOGO, frm_LOSTLOGO);
    Application.Title:= '로그인(LOST PROJECT))';
    Application.ShowMainForm := False;	//실행히 안보이게
    Application.Run;
  end;

  if Mutex <> 0 then
  CloseHandle(Mutex);
end.
