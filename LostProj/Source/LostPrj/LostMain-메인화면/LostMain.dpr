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
	//���ø����̼� �ߺ����� ����
	Mutex := CreateMutex(nil, True, 'LOSTMAIN');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(Tfrm_MAINMENU, frm_MAINMENU);
  Application.CreateForm(TSkinChangeForm, SkinChangeForm);
  Application.Title:= '�нǴܸ������߰���';
  		Application.Run;
    end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
