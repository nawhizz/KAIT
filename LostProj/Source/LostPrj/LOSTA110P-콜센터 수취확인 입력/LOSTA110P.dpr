program LOSTA110P;

uses
  Forms,
  u_LOSTA110P in 'u_LOSTA110P.pas' {frm_LOSTA110P},
  u_LOSTA110P_ADDR in 'u_LOSTA110P_ADDR.pas' {frm_LOSTA110P_ADDR},
  u_LOSTA110P_CHILD in 'u_LOSTA110P_CHILD.pas' {fm_LOSTA110P_CHILD},
  u_LOSTA110P_POP in 'u_LOSTA110P_POP.pas' {frm_LOSTA110P_POP};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '본실자 수취 확인입력(LOSTA110P)';
  Application.CreateForm(Tfrm_LOSTA110P, frm_LOSTA110P);
  Application.CreateForm(Tfrm_LOSTA110P_ADDR, frm_LOSTA110P_ADDR);
  Application.CreateForm(Tfm_LOSTA110P_CHILD, fm_LOSTA110P_CHILD);
  Application.CreateForm(Tfrm_LOSTA110P_POP, frm_LOSTA110P_POP);
  Application.Run;
end.
