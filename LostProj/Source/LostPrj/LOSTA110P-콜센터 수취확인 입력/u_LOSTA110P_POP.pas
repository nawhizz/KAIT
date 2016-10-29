unit u_LOSTA110P_POP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj;

type
  Tfrm_LOSTA110P_POP = class(TForm)
    lbl33: TLabel;
    lbl34: TLabel;
    lbl35: TLabel;
    btn_yes: TButton;
    btn_no: TButton;
    procedure btn_yesClick(Sender: TObject);
    procedure btn_noClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTA110P_POP: Tfrm_LOSTA110P_POP;

implementation
uses u_LOSTA110P;

{$R *.dfm}

procedure Tfrm_LOSTA110P_POP.btn_yesClick(Sender: TObject);
begin
  Self.Hide;
  frm_LOSTA110P.Enabled := True;
end;

procedure Tfrm_LOSTA110P_POP.btn_noClick(Sender: TObject);
begin
  Self.Hide;
  frm_LOSTA110P.Enabled := True;

  with frm_LOSTA110P do
  begin
    InitComponents;
  end;
end;

procedure Tfrm_LOSTA110P_POP.FormShow(Sender: TObject);
begin
  Self.Show;
  frm_LOSTA110P.rdo_Sh_No.Checked := True;
  self.Visible := True;
end;

end.
