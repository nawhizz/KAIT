program LostFileChange;

uses
  Forms,
  u_FCHANGE in 'u_FCHANGE.pas' {FCHANGEfrm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFCHANGEfrm, FCHANGEfrm);
  Application.ShowMainForm := False;	//������ �Ⱥ��̰�
  Application.Run;
end.
