program CodeUpdate;

uses
  Forms,
  Windows,
  u_CodeUpdate in 'u_CodeUpdate.pas' {CodeUpdateFrm};

var
Mutex : THandle;
{$R *.res}

begin
	//���ø����̼� �ߺ����� ����
	Mutex := CreateMutex(nil, True, 'CODEUPDATE');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(TCodeUpdateFrm, CodeUpdateFrm);
  		Application.Title:= '�ڵ� ������Ʈ';
  		Application.Run;
    end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
