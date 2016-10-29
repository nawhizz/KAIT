{*---------------------------------------------------------------------------
프로그램ID    : landprt
프로그램 종류 : Online
작성자	      : 구무영
작성일	      : 1999. 03. 12
완료일	      : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_portprt2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, ComCtrls;

type
  Tfrm_portPRT2 = class(TForm)
    pnl_Command: TPanel;
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    PrintDialog1: TPrintDialog;
    edt_Filename: TEdit;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_Preview: TSpeedButton;
    btn_Prn_Set: TSpeedButton;
    procedure FormSet(CFileNm, CPgmNm: shortstring);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_PreviewClick(Sender: TObject);
    procedure btn_Prn_SetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_portPRT2: Tfrm_portPRT2;

implementation

uses cpaklibm, bsysprv3;
{$R *.DFM}

procedure Tfrm_portPRT2.FormSet(CFileNm, CPgmNm: shortstring);
begin
   lbl_Program_Name.Caption := CPgmNm;
   edt_Filename.Text := CFileNm;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_portPRT2.FormCreate(Sender: TObject);
begin
   edt_Filename.text := '';
end;

procedure Tfrm_portPRT2.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_portPRT2.btn_PrintClick(Sender: TObject);
var
  rcvfile : shortstring;
begin
    rcvfile := CGetTca(TCA_ASAPPL) + '\'+ edt_Filename.Text;
    if FileExists(Trim(rcvfile)) = false then
    begin
        showmessage('출력할 파일이 없습니다.');
        exit;
    end;

    frm_bsysprv3.f_print(rcvfile);

    sts_Message.Panels[1].text := '출력이 완료되었습니다';
end;

procedure Tfrm_portPRT2.btn_PreviewClick(Sender: TObject);
var
    file_info : TSearchRec;
    rcvfile : shortstring;
begin
   rcvfile := CGetTca(TCA_ASAPPL) + '\'+ edt_Filename.Text;
   if length(Trim(rcvfile)) < 1 then
   begin
      MessageBeep(0) ;
      sts_Message.Panels[1].text := '출력화일명을 확인하십시요!!';
   end
   else
   begin
      if FileExists(Trim(rcvfile)) = false then
      begin
        showmessage('출력할 파일이 없습니다.');
        exit;
      end;
      if FindFirst( trim(rcvfile), faanyfile, file_info ) = 0 then
      begin
         if file_info.Size >= 40000 then
         begin
            showmessage('파일이 커서 미리보기가 되지 않습니다. '+ trim(rcvfile)+'로 저장되어있습니다.');
            exit;
         end;
      end
      else
      begin
        showmessage('출력할 파일이 없습니다.');
        exit;
      end;
         frm_bsysprv3.f_Preview(rcvfile);
   end;

end;

procedure Tfrm_portPRT2.btn_Prn_SetClick(Sender: TObject);
begin
   PrintDialog1.Execute;
end;

end.
