program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  menu_execute in '..\..\Source\Lib\menu_execute.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Title := 'Dynamic menu Test';
  Application.Run;
end.
