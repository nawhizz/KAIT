program LOSTB210Q;

uses
  Forms,
  u_LOSTB210Q in 'u_LOSTB210Q.pas' {frm_LOSTB210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '습득신고자사은품발송대상조회(LOSTB210Q)';
  Application.CreateForm(Tfrm_LOSTB210Q, frm_LOSTB210Q);
  Application.Run;
end.
