program LOSTC100P;

uses
  Forms,
  u_LOSTC100P in 'u_LOSTC100P.pas' {frm_LOSTC100P},
  u_LOSTC100P_ADDR in 'u_LOSTC100P_ADDR.pas' {frm_LOSTC100P_ADDR},
  u_LOSTC100P_POP in 'u_LOSTC100P_POP.pas' {frm_LOSTC100P_POP},
  u_LOSTC100P_INSU in 'u_LOSTC100P_INSU.pas' {frm_LOSTC100P_INSU};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '우체국처리 수취 확인입력(LOSTC100P)';
  Application.CreateForm(Tfrm_LOSTC100P, frm_LOSTC100P);
  Application.CreateForm(Tfrm_LOSTC100P_ADDR, frm_LOSTC100P_ADDR);
  Application.CreateForm(Tfrm_LOSTC100P_POP, frm_LOSTC100P_POP);
  Application.CreateForm(Tfrm_LOSTC100P_INSU, frm_LOSTC100P_INSU);
  Application.Run;
end.
