program LOSTZ830Q;

uses
  Forms,
  Windows,
  u_LOSTZ830Q in 'u_LOSTZ830Q.pas' {frm_LOSTZ830Q};

var
Mutex : THandle;
{$R *.res}

begin
  //���ø����̼� �ߺ����� ����
  Mutex := CreateMutex(nil, True, 'LOSTZ820Q');
  if (Mutex <> 0 ) and (GetLastError = 0) then begin
    Application.Initialize;
    Application.CreateForm(Tfrm_LOSTZ830Q, frm_LOSTZ830Q);
  Application.Title := '�Է°���(LOSTZ820Q)';
    Application.Run;
  end;
  if Mutex <> 0 then
    CloseHandle(Mutex);
end.
