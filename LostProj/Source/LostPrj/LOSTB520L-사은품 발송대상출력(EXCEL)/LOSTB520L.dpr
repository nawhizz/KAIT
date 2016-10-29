program LOSTB520L;

uses
  Forms,
  u_LOSTB520L in 'u_LOSTB520L.pas' {frm_LOSTB520L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB520L, frm_LOSTB520L);
  Application.Title := '출력관리(LOSTB520L)';
  Application.Run;
end.
