program LOSTA700P;

uses
  Forms,
  u_LOSTA700P in 'u_LOSTA700P.pas' {frm_LOSTA700P},
  u_LOSTA700P_IMEI in '..\LOSTA700P-����������ܸ����԰����Է�\u_LOSTA700P_IMEI.pas' {frm_LOSTA700P_IMEI};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�԰��� �Է�(LOSTA100P)';
  Application.CreateForm(Tfrm_LOSTA700P, frm_LOSTA700P);
  Application.CreateForm(Tfrm_LOSTA700P_IMEI, frm_LOSTA700P_IMEI);
  Application.Run;
end.
