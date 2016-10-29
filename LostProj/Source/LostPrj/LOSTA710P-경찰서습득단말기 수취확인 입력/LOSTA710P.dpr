program LOSTA710P;

uses
  Forms,
  u_LOSTA710P in 'u_LOSTA710P.pas' {frm_LOSTA710P},
  u_LOSTA710P_ADDR in 'u_LOSTA710P_ADDR.pas' {frm_LOSTA710P_ADDR},
  u_LOSTA710P_CHILD in 'u_LOSTA710P_CHILD.pas' {fm_LOSTA710P_CHILD},
  u_LOSTA710P_POP in 'u_LOSTA710P_POP.pas' {frm_LOSTA710P_POP};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '본실자 수취 확인입력(LOSTA110P)';
  Application.CreateForm(Tfrm_LOSTA710P, frm_LOSTA710P);
  Application.CreateForm(Tfrm_LOSTA710P_ADDR, frm_LOSTA710P_ADDR);
  Application.CreateForm(Tfm_LOSTA710P_CHILD, fm_LOSTA710P_CHILD);
  Application.CreateForm(Tfrm_LOSTA710P_POP, frm_LOSTA710P_POP);
  Application.Run;
end.
