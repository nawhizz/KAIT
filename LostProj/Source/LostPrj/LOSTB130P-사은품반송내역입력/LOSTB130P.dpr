program LOSTB130P;

uses
  Forms,
  Windows,
  u_LOSTB130P in 'u_LOSTB130P.pas' {frm_LOSTB130P};

var
Mutex : THandle;
{$R *.res}

begin
	//어플리케이션 중복실행 방지
	Mutex := CreateMutex(nil, True, 'LOSTB130P');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(Tfrm_LOSTB130P, frm_LOSTB130P);
  Application.Title:= '사은품 반송내역 입력(LOSTB130P)';
  		Application.Run;
    end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
