program FileUpload_prj;

uses
  Forms,
  FileUploaP in 'FileUploaP.pas' {FileUploadP},
  common_lib in '..\..\Source\Lib\common_lib.pas',
  SimpleSFTP in '..\..\Source\Lib\SimpleSFTP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFileUploadP, FileUploadP);
  Application.Title := '버젼관리';
  Application.Run;
end.
