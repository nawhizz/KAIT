program LostLogin;

uses
  Forms,
  Windows,
  u_lostlogo in 'u_lostlogo.pas' {frm_LOSTLOGO};

var
Mutex : THandle;
{$R *.res}

begin
	//���ø����̼� �ߺ����� ����
	Mutex := CreateMutex(nil, True, 'LOSTLOGIN');

	if (Mutex <> 0 ) and (GetLastError = 0) then
  begin
    Application.Initialize;
    Application.CreateForm(Tfrm_LOSTLOGO, frm_LOSTLOGO);
    Application.Title:= '�α���(LOST PROJECT))';
    Application.ShowMainForm := False;	//������ �Ⱥ��̰�
    Application.Run;
  end;

  if Mutex <> 0 then
  CloseHandle(Mutex);
end.
