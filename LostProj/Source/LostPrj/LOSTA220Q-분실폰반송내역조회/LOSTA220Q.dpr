program LOSTA220Q;

uses
  Forms,
  u_LOSTA220Q in 'u_LOSTA220Q.pas' {frm_LOSTA220Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н����ݼ۳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA220Q, frm_LOSTA220Q);
  Application.Run;
end.
