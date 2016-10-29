program CodeUpdate;

uses
  Forms,
  Windows,
  u_CodeUpdate in 'u_CodeUpdate.pas' {CodeUpdateFrm};

var
Mutex : THandle;
{$R *.res}

begin
	//어플리케이션 중복실행 방지
	Mutex := CreateMutex(nil, True, 'CODEUPDATE');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(TCodeUpdateFrm, CodeUpdateFrm);
  		Application.Title:= '코드 업데이트';
  		Application.Run;
    end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
