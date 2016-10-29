program FileDownload;

uses
  Forms,
  Windows,
  u_FileDownload in 'u_FileDownload.pas' {FileDownloadFrm},
  common_lib in '..\..\Lib\common_lib.pas';

var
Mutex : THandle;
{$R *.res}

begin
	//���ø����̼� �ߺ����� ����
	Mutex := CreateMutex(nil, True, 'FILEDOWNLOAD');
	if (Mutex <> 0 ) and (GetLastError = 0) then begin
  		Application.Initialize;
  		Application.CreateForm(TFileDownloadFrm, FileDownloadFrm);
  Application.Title :='File Download';
  		Application.Run;
  	end;
    if Mutex <> 0 then
    	CloseHandle(Mutex);
end.
