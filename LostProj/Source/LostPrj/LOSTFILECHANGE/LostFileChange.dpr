program LostFileChange;

uses
  Forms,
  u_FCHANGE in 'u_FCHANGE.pas' {FCHANGEfrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFCHANGEfrm, FCHANGEfrm);
  Application.ShowMainForm := False;	//실행히 안보이게
  Application.Run;
end.
