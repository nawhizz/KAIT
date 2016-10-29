unit bsysprv3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, printers;

type
  Tfrm_bsysprv3 = class(TForm)
    Panel2: TPanel;
    btn_ZoomIn: TSpeedButton;
    btn_ZoomOut: TSpeedButton;
    Panel1: TPanel;
    Memo1: TMemo;
    btn_Print: TSpeedButton;
    btn_cancel: TSpeedButton;
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ZoomInClick(Sender: TObject);
    procedure btn_ZoomOutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure f_preview( filename : string);
    procedure f_print( filename : string);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_bsysprv3 : Tfrm_bsysprv3;
  CloseOpt    : Boolean;
  filename_s  : string;

implementation

uses cpaklibm, u_portprt2;
{$R *.DFM}

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv3.btn_PrintClick(Sender: TObject);
var
  rcvfile : shortstring;
begin
   rcvfile := CGetTca(TCA_ASAPPL) + '\'+ frm_PORTPRT2.edt_Filename.Text;
   f_print(trim(rcvfile));
end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv3.btn_CancelClick(Sender: TObject);
begin
  frm_bsysprv3.Visible := false;
end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv3.btn_ZoomInClick(Sender: TObject);
begin

  Memo1.Font.Size := Memo1.Font.Size + 1;

  if Memo1.Font.Size > 20 then
    btn_ZoomIn.Enabled := False;

  btn_ZoomOut.Enabled := True;

end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv3.btn_ZoomOutClick(Sender: TObject);
begin

  Memo1.Font.Size := Memo1.Font.Size - 1;

  if Memo1.Font.Size < 8 then
    btn_ZoomOut.Enabled := False;

  btn_ZoomIn.Enabled := True;

end;

{------------------------------------------------------------------------------}
procedure  Tfrm_bsysprv3.f_preview(filename : string);
begin
  Memo1.Lines.Clear;
  Memo1.Lines.LoadFromFile(filename);
  frm_bsysprv3.Visible := true;
  filename_s := filename;
end;

procedure Tfrm_bsysprv3.f_print(filename : string);
var F : TextFile;
    S : string;
    i : integer;
begin

   with printer do
   begin
      Assignfile(F, filename);
      Reset(F);
      readln(F, S);
      i := 0;
      Orientation := poPortrait;
      Canvas.Font.Name := '±¼¸²Ã¼';
      Canvas.Font.Size := 8;
      BeginDoc;
      while ( not EOF(F) ) do
      begin

         if i >= 63 then
         begin
            NewPage;
            i := 0;
         end;
         Canvas.TextOut(200,350+i*99, S);
         i := i +1;
         Readln(F, S)
      end;
         if i >= 63 then
         begin
            NewPage;
            i := 0;
         end;
         Canvas.TextOut(200,350+i*99, S);
      EndDoc;
      CloseFile(F);
   end;
end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv3.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

end;

{------------------------------------------------------------------------------}
end.
