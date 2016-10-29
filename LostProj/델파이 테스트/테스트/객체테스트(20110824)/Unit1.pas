unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    btn1: TButton;
    medt1: TMaskEdit;
    lbl1: TLabel;
    bvl1: TBevel;

    procedure btn1Click(Sender: TObject);

    function fChkBox(obj      : TObject;
                    len       : Integer;
                    cond      : Integer;
                    strTitle  : string): Boolean; // Cond 0: Equal 1:Min 2:Max);
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
begin
  fChkBox(edt1,edt1.MaxLength,0,'타이틀1');
  fChkBox(medt1,medt1.MaxLength,0,'타이틀2');
end;

function TForm1.fChkBox(obj   : TObject;
                    len       : Integer;
                    cond      : Integer;
                    strTitle  : string): Boolean; // Cond 0: Equal 1:Min 2:Max);
var
  strValue : string;

begin
    strValue := '';
    Result := False;

    if      ( obj is TEdit     ) then strValue := (obj as TEdit    ).Text
    else if ( obj is TMaskEdit ) then strValue := (obj as TMaskEdit).Text
    else if ( obj is TLabel    ) then strValue := (obj as TLabel   ).Caption;

    case cond of
      0 : if(Length(strValue) = len)  then Result := True;

      1 : if(Length(strValue) >= len) then Result := True;

      2 : if(Length(strValue) <= len) then Result := True;

      else begin
        ShowMessage('잘못된 사용방법입니다.');
        result := False;
      end;
    end;


    if (result) then
    begin
      ShowMessage(strTitle + '이(가) 정확하지 않습니다.');
      if      ( obj is TEdit     ) then (obj as TEdit    ).SetFocus
      else if ( obj is TMaskEdit ) then (obj as TMaskEdit).SetFocus
    end;
end;

end.

