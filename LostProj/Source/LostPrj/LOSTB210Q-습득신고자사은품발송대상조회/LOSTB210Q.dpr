program LOSTB210Q;

uses
  Forms,
  u_LOSTB210Q in 'u_LOSTB210Q.pas' {frm_LOSTB210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����Ű��ڻ���ǰ�߼۴����ȸ(LOSTB210Q)';
  Application.CreateForm(Tfrm_LOSTB210Q, frm_LOSTB210Q);
  Application.Run;
end.
