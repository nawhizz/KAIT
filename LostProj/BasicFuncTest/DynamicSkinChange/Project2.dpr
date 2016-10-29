program Project2;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  menu_execute in '..\..\Source\Lib\menu_execute.pas',
  skinChange in 'skinChange.pas' {SkinChangeForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSkinChangeForm, SkinChangeForm);
  Application.Title := 'Dynamic menu Test';
  Application.Run;
end.
