program LOSTT210Q;

uses
  Forms,
  u_LOSTT210Q in 'u_LOSTT210Q.pas' {frm_LOSTT210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTT210Q, frm_LOSTT210Q);
  Application.Run;
end.
