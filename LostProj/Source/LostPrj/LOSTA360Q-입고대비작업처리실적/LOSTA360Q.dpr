program LOSTA360Q;

uses
  Forms,
  u_LOSTA360Q in 'u_LOSTA360Q.pas' {frm_LOSTA360Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�԰����۾�ó������(LOSTA360Q)';
  Application.CreateForm(Tfrm_LOSTA360Q, frm_LOSTA360Q);
  Application.Run;
end.
