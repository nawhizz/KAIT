program LOSTZ820Q;

uses
  Forms,
  Windows,
  u_LOSTZ820Q in 'u_LOSTZ820Q.pas' {frm_LOSTZ820Q};

var
Mutex : THandle;
{$R *.res}

begin
  //어플리케이션 중복실행 방지
  Mutex := CreateMutex(nil, True, 'LOSTZ820Q');
  if (Mutex <> 0 ) and (GetLastError = 0) then begin
    Application.Initialize;
    Application.CreateForm(Tfrm_LOSTZ820Q, frm_LOSTZ820Q);
    Application.Title := '입력관리(LOSTZ820Q)';
    Application.Run;
  end;
  if Mutex <> 0 then
    CloseHandle(Mutex);
end.
