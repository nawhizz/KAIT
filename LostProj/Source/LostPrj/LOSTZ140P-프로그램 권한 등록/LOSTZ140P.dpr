program LOSTZ140P;

uses
  Forms,
  u_LOSTZ140P in 'u_LOSTZ140P.pas' {frm_LOSTZ140P};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ140P, frm_LOSTZ140P);
  Application.Run;
end.
