program LOSTC110P;

uses
  Forms,
  u_LOSTC110P in 'u_LOSTC110P.pas' {frm_LOSTC110P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '우체국처리 출고 입력(LOSTC110P)';
  Application.CreateForm(Tfrm_LOSTC110P, frm_LOSTC110P);
  Application.Run;
end.
