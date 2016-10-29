unit bsysprv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, printers, ComCtrls, common_lib;

type
  Tfrm_bsysprv = class(TForm)
    Panel2: TPanel;
    btn_ZoomIn: TSpeedButton;
    btn_ZoomOut: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_close: TSpeedButton;
    memo1: TRichEdit;
    sts_Message: TStatusBar;
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure btn_ZoomInClick(Sender: TObject);
    procedure btn_ZoomOutClick(Sender: TObject);
    procedure f_preview( filename : string;orient: string; nPage : Integer;
                              fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap: Cardinal);
    procedure FormCreate(Sender: TObject);


  private
  	fname:String;
    fHeight     : Cardinal;
    gap         : Cardinal;
    exGap       : Cardinal;
    lGap        : Cardinal;

    { Private declarations }
  public
    { Public declarations }
    procedure f_print( var status:TStatusBar; filename : string); overload;
    procedure f_print( var status:TStatusBar; filename,prt_orient : string); overload;
    procedure f_print( var status:TStatusBar; filename,prt_orient : string; nPage : Integer); overload;

  published
    procedure f_print( var status:TStatusBar; filename,prt_orient : string; nPage : Integer;
                              fHeight : Cardinal; gap: Cardinal; exGap : Cardinal;lGap : Cardinal); overload;
  end;

var
	frm_bsysprv : Tfrm_bsysprv;
  prt_orient  : String;
  newpage     : Integer;

implementation
{$R *.DFM}

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv.btn_PrintClick(Sender: TObject);
begin
	f_print(sts_Message, fname,prt_orient,newpage,fHeight,gap,exGap,lGap);
end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv.btn_closeClick(Sender: TObject);
begin
	Close;
end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv.btn_ZoomInClick(Sender: TObject);
begin
	Memo1.Font.Size := Memo1.Font.Size + 1;

	if Memo1.Font.Size > 20 then
		btn_ZoomIn.Enabled := False;

	btn_ZoomOut.Enabled := True;
end;

{------------------------------------------------------------------------------}
procedure Tfrm_bsysprv.btn_ZoomOutClick(Sender: TObject);
begin
	Memo1.Font.Size := Memo1.Font.Size - 1;

	if Memo1.Font.Size < 8 then
		btn_ZoomOut.Enabled := False;

	btn_ZoomIn.Enabled := True;
end;

//외부에서 호출
procedure  Tfrm_bsysprv.f_preview(filename : string;orient: string; nPage : Integer;
                              fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal);
var
	buf:String;
	F : TextFile;
  temp:String;
begin
	fname:=fileName;

	Assignfile(F, fname);
	Reset(F);

	Memo1.Lines.Clear;
	Memo1.Lines.LoadFromFile(fname);
{
	//라인별 특수한 문자가 포함되어 있는지 첵크할때 사용
	while  not EOF(F) do begin
        Readln(F, buf);
        buf := TrimRight(buf);
		Memo1.Lines.Add(buf);
    end;
}
    CloseFile(F);

  prt_orient    := orient;
  newpage       := nPage;
  Self.fHeight  := fHeight;
  Self.gap      := gap;
  Self.exGap    := exgap;
  Self.lGap     := lGap;

	self.ShowModal;
end;

//외부에서 호출
procedure Tfrm_bsysprv.f_print( var status:TStatusBar; filename : string);
begin
    Self.f_print(status,filename,'L');
end;

procedure Tfrm_bsysprv.f_print( var status:TStatusBar; filename,prt_orient : string);
begin
   Self.f_print(status,filename,prt_orient,0);
end;

procedure Tfrm_bsysprv.f_print( var status:TStatusBar; filename,prt_orient : string; nPage : Integer);
begin
  Self.f_print(status,filename,prt_orient,0,0,0,0,0);
end;

procedure Tfrm_bsysprv.f_print( var status:TStatusBar; filename,prt_orient : string; nPage : Integer;
                              fHeight : Cardinal; gap: Cardinal; exGap : Cardinal;lGap: Cardinal);
begin
  status.Panels[1].Text := '데이터 출력 중...잠시 기다려 주십시오.';
  Application.ProcessMessages;

  if ( Pos('LOSTA100P', filename) <> 0 ) then
    linePrint_z4mplus(prt_orient,filename,nPage,fHeight,gap,exGap,lGap)
  else if ( Pos('LOSTA700P', filename) <> 0 ) then
    linePrint_z4mplus(prt_orient,filename,nPage,fHeight,gap,exGap,lGap)
  else
    linePrint(prt_orient,filename,nPage,fHeight,gap,exGap,lGap);

  status.Panels[1].Text := '데이터 출력 완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_bsysprv.FormCreate(Sender: TObject);
begin
  changeBtn(Self);
end;

end.
