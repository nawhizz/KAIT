unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GIFImage, ExtCtrls, StdCtrls, IniFiles, WinSkinData;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    SkinData1: TSkinData;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

(* 스킨 테스트를 위한 임시 프로시저 *)
procedure TForm1.FormCreate(Sender: TObject);
var
      iniLost : TiniFile;
begin
    if FileExists('.\..\..\INI\LostProj.ini') then
      begin
        iniLost := TiniFile.Create('.\..\..\INI\LostProj.ini');

        SkinData1.SkinFile := '..\..\Skin\' + iniLost.ReadString('Skin','SKIN','');

        iniLost.Free;
      end
    else
      SkinData1.SkinFile := '..\Skin\iTunes.skn';
      

    SkinData1.Active:= True;
end;

end.
