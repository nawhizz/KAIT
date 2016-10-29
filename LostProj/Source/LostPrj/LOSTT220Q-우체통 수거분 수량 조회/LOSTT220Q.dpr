program LOSTT220Q;

uses
  Forms,
  u_LOSTT220Q in 'u_LOSTT220Q.pas' {frm_LOSTT220Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '우체통 수거분 수량 조회(LOSTT220Q)';
  Application.CreateForm(Tfrm_LOSTT220Q, frm_LOSTT220Q);
  Application.Run;
end.
