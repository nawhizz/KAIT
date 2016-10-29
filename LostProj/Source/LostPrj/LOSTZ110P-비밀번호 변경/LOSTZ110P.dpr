program LOSTZ110P;

uses
  Forms,
  u_LOSTZ110P in 'u_LOSTZ110P.pas' {frm_LOSTZ110P};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ110P, frm_LOSTZ110P);
  Application.Run;
end.
