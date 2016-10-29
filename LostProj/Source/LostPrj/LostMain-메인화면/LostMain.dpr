program LostMain;

uses
  Forms,
  Windows,
  u_mainmenu in 'u_mainmenu.pas' {frm_MAINMENU},
  skinChange in 'skinChange.pas' {SkinChangeForm};

var
Mutex : THandle;
{$R *.res}

begin
	//어플리케이션 중복실행 방지
	Mutex := CreateMutex(nil, True, 'LOSTMAIN');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(Tfrm_MAINMENU, frm_MAINMENU);
  Application.CreateForm(TSkinChangeForm, SkinChangeForm);
  Application.Title:= '분실단말기집중관리';
  		Application.Run;
    end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
