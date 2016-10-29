program Project2;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  localCloud in '..\localCloud.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Title:= 'Client';
  Application.Run;
end.
