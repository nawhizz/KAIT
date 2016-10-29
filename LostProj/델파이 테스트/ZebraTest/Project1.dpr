program Project1;

uses
  Forms,
  ZebraTest in 'ZebraTest.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
