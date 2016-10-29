program LOSTZ840Q;

uses
  Forms,
  u_LOSTZ840Q in 'u_LOSTZ840Q.pas' {frm_LOSTZ840Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '도로명주소 조회(LOSTZ840Q)';
  Application.CreateForm(Tfrm_LOSTZ840Q, frm_LOSTZ840Q);
  Application.Run;
end.
