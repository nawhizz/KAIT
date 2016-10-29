program LOSTZ850Q;

uses
  Forms,
  u_LOSTZ850Q in 'u_LOSTZ850Q.pas' {frm_LOSTZ850Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '도로명주소 조회(LOSTZ840Q)';
  Application.CreateForm(Tfrm_LOSTZ850Q, frm_LOSTZ850Q);
  Application.Run;
end.
