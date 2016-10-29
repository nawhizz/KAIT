unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Grids, RXGrids;

type
  TForm1 = class(TForm)
    cbb1: TComboBox;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    RxDrawGrid1: TRxDrawGrid;
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var i : integer;
begin
  cbb1.ItemIndex := cbb1.Items.IndexOf((Sender as TButton).Name);
  RxDrawGrid1.cells[1,1] := 0;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  cbb1.Text := (Sender as TButton).Name;
end;

end.
