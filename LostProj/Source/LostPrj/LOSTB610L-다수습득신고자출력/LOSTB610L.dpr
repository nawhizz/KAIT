program LOSTB610L;

uses
  Forms,
  u_LOSTB610L in 'u_LOSTB610L.pas' {frm_LOSTB610L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '다수습득신고자 출력(LOSTB610L)';
  Application.CreateForm(Tfrm_LOSTB610L, frm_LOSTB610L);
  Application.Run;
end.
