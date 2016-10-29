unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, printers;

type
  TForm1 = class(TForm)
    RichEdit1: TRichEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  RichEdit1.Lines.Clear;
  RichEdit1.Lines.LoadFromFile('.\lostp13l.txt');
end;

procedure TForm1.Button2Click(Sender: TObject);
var F : TextFile;
    S : string;
    i : integer;
begin
	with printer do begin
      Assignfile(F, '.\lostp13l.txt');
      Reset(F);
      readln(F, S);
      i := 0;
      Orientation := poLandscape;
      Canvas.Font.Name := '±¼¸²Ã¼';
      Canvas.Font.Size := 10;
      BeginDoc;
      while ( not EOF(F) ) do
      begin

         if i >= 40 then
         begin
            NewPage;
            i := 0;
         end;
         Canvas.TextOut(600,300+i*100, S);
         i := i +1;
         Readln(F, S)
      end;
         if i >= 40 then
         begin
            NewPage;
            i := 0;
         end;
         Canvas.TextOut(600,300+i*100, S);
      EndDoc;
      CloseFile(F);
    end;
end;

end.
