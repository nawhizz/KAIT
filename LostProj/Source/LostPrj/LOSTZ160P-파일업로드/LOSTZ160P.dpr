program LOSTZ160P;

uses
  Forms,
  Windows,
  u_LOSTZ160P in 'u_LOSTZ160P.pas' {LOSTZ160P_frm};

var
Mutex : THandle;
{$R *.res}

begin
	//어플리케이션 중복실행 방지
	Mutex := CreateMutex(nil, True, 'LOSTZ810Q');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin

  		Application.Initialize;
  		Application.CreateForm(TLOSTZ160P_frm, LOSTZ160P_frm);
  Application.Title:='버젼관리(LOSTZ160P)';
  		Application.Run;
  	end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
