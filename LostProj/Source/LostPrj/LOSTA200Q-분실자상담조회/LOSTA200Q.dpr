program LOSTA200Q;

uses
  Forms,
  u_LOSTA200Q in 'u_LOSTA200Q.pas' {fm_LOSTA200Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н��ڻ����ȸ(LOSTA200Q)';
  Application.CreateForm(Tfm_LOSTA200Q, fm_LOSTA200Q);
  Application.Run;
end.
