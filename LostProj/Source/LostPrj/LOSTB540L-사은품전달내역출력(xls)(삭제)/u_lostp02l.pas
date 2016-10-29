{*---------------------------------------------------------------------------
���α׷�ID    : lostp02l (����ǰ ���� ���� ���)
���α׷� ���� : Online
�ۼ���	      : ������
�ۼ���	      : 1999. 03. 17
�Ϸ���	      : ####. ##. ##
���α׷� ���� :
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_lostp02l;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, ComObj;

type
  Tfrm_LOSTP02L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_Jn_Dt_From: TDateEdit;
    dte_Jn_Dt_To: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    btn_Help: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_Print: TSpeedButton;
    Bevel4: TBevel;
    Label4: TLabel;
    cmb_sp_cd: TComboBox;
    SkinData1: TSkinData;
    procedure PrtFormShow;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dte_Jn_Dt_FromExit(Sender: TObject);
    procedure dte_Jn_Dt_ToExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTP02L: Tfrm_LOSTP02L;

implementation
uses cpaklibm, u_landprt;
{$R *.DFM}

Const
     MAXRECCNT = 1 ;
type
    Tsendbody = record
	  jn_dt_from : array [0..7] of char;
	  jn_dt_to : array [0..7] of char;
          sp_cd    : array[0..5] of char;
    end ;

    Trecvbody = record
	  filler : char;
    end ;

    Trecvhead = record
	  filler : char;
    end ;

    Tsendrec = record
	  func : char ;
	  bd : Tsendbody ;
    end ;

    Trecvrec = record
	  ContFlag : char;
	  ErrFlag : char;
	  MsgStr : array [0..59] of char;
	  RecCnt : array [0..3] of char;
	  hd : Trecvhead;
	  bd : array [0..(MAXRECCNT - 1)] of Trecvbody ;
    end ;

    Tsavkey = record
	func : char ;
	jn_dt_from, jn_dt_to : shortstring;
    end ;
var
  send : Tsendrec;
  recv : Trecvrec;
  savkey : Tsavkey;
{--------------- user define function and procedure declaration -------------}
procedure btninit_rtn; forward;
procedure scrinit_rtn; forward;
procedure comm_rtn( func : char ); forward;
procedure scr2buff_rtn; forward;
procedure buff2scr_rtn; forward;
function errchk_rtn : integer ; forward ;
{--------------- user define function and procedure code --------------------}
procedure btninit_rtn;
begin

  with frm_LOSTP02L do
  begin
    btn_Print.Enabled	  := true;
  end;

end;
{----------------------------------------------------------------------------}
procedure scrinit_rtn;
begin
  with frm_LOSTP02L do
  begin
     dte_Jn_Dt_From.Date := date;
     dte_Jn_Dt_To.Date := date;
  end;
end;

procedure comm_rtn (func : char) ;
var
    sbuffer : array [0..100] of char;
  rcvfile : shortstring;
begin

  with frm_LOSTP02L do
  begin

     { send buffer �ʱ�ȭ }
     FillChar (send, sizeof (send), ' ') ;
     send.func := func ;

     if errchk_rtn = -1 then
     begin
	sts_Message.Panels[1].text := '';
	exit ;
     end;

     sts_Message.Panels[1].text := '������Դϴ�.';
     scr2buff_rtn ;
     repeat
     begin
        if recv.contFlag = 'Y' then
        begin
           if CsendData( '', @send, sizeof( send ) ) = -1 then
           begin
              Zendtx;
              exit;
           end;
        end
        else
        begin
           if CSendData( 'lostp02l', @send, sizeof(send) ) = -1 then
           begin
              Zendtx;
              exit;
           end;
        end;

        if CrecvData( @recv, False ) = -1 then
        begin
           Zendtx;
           exit;
        end;

        if recv.ErrFlag = 'E' then
        begin
           Zendtx;
           sts_Message.Panels[1].text := recv.MsgStr;
           showmessage(recv.MsgStr);
           exit ;
        end ;

        if recv.ContFlag = 'E' then
        begin
           sts_Message.Panels[1].text := 'ȭ�ϼ��� �� �Դϴ�.';
           rcvfile := CGetTca(TCA_ASAPPL) + '\lostp02l.txt';
           CStrToArr ( rcvfile, sbuffer, true ) ;
           if Zrecvfile( sbuffer, 'Y' ) = -1 then
           begin
              Zendtx;
              exit;
           end;
        end;

        buff2scr_rtn;
        sts_Message.Panels[1].text := recv.MsgStr;
        update;
     end;
     until recv.ContFlag = 'E' ;

     Zendtx;
     sts_Message.Panels[1].text := recv.MsgStr;
     buff2scr_rtn;

     { Ű ���� �����Ѵ� }
     savkey.jn_dt_from := dte_Jn_Dt_From.Text;
     savkey.jn_dt_to   := dte_Jn_Dt_To.Text;
     update;

     PrtFormShow;

  end;
end ;

function errchk_rtn : integer ;
{ OK : 0, Error : -1 }
begin
    { �Է� �ڷ� �� error�� üũ�Ѵ�.}
  with frm_LOSTP02L do
  begin
   result := 0 ;

     try
     dte_Jn_Dt_From.Date := strtodate(dte_Jn_Dt_From.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('���� �Է� ����' + #13 + E.Message);
	   dte_Jn_Dt_From.setfocus;
	   result := -1 ;
	   exit ;
	end;
     end;

     try
     dte_Jn_Dt_To.Date := strtodate(dte_Jn_Dt_To.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('���� �Է� ����' + #13 + E.Message);
	   dte_Jn_Dt_To.setfocus;
	   result := -1 ;
	   exit ;
	end;
     end;

     if dte_Jn_Dt_From.date > dte_Jn_Dt_To.date then
     begin
        ShowMessage('�������ڰ� �������ں��� Ů�ϴ�.');
        dte_Jn_Dt_From.setfocus;
        result := -1 ;
        exit ;
     end;
  end;
end ;

procedure scr2buff_rtn ;
var tempdt1 : string;
begin
   { ȭ���� ������ send���� �ű�� }
   with frm_LOSTP02L do
   begin
      datetimetostring(tempdt1, 'yyyymmdd', dte_Jn_Dt_From.date);
      CStrToArr (tempdt1, send.bd.jn_dt_from, False) ;
      datetimetostring(tempdt1, 'yyyymmdd', dte_Jn_Dt_To.date);
      CStrToArr (tempdt1, send.bd.jn_dt_to, False) ;
      CStrToArr ( copy(cmb_sp_cd.Text,41,6), send.bd.sp_cd, False) ;
   end;
end;

procedure buff2scr_rtn ;
begin
    { recv�� ������ ȭ������ �ű�� }
    with frm_LOSTP02L do
    begin
       //
    end;
end;

procedure Tfrm_LOSTP02L.PrtFormShow;
begin
     // ��� ���̷α� �ڽ�
     frm_LANDPRT := Tfrm_LANDPRT.Create(self);
     frm_LANDPRT.FormSet('lostp02l.txt', lbl_Program_Name.Caption);
     try
        frm_LANDPRT.ShowModal;
     finally
        frm_LANDPRT.Free;
     end;
     send.func := 'W';
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTP02L.FormCreate(Sender: TObject);
begin
     { ���α׷� �ʱ�ȭ�� �ʿ��� �ڵ带 �ۼ��Ѵ�}
     Capiinit ;

     btninit_rtn;
     scrinit_rtn;

     cmb_sp_cd.Items.LoadFromFile('Z035.dat');
     cmb_sp_cd.ItemS.Insert(0, '��ü                                    ******');
     cmb_sp_cd.ItemIndex := 0;
     sts_Message.Panels[2].text := CGetTca(TCA_USID);
end;

procedure Tfrm_LOSTP02L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTP02L.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Capiend;
end;

procedure Tfrm_LOSTP02L.dte_Jn_Dt_FromExit(Sender: TObject);
begin
     try
     dte_Jn_Dt_From.Date := strtodate(dte_Jn_Dt_From.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('���� �Է� ����'+#13+
		       '�������ڷ� ����˴ϴ�');
	   dte_Jn_Dt_From.date := date;
	   dte_Jn_Dt_From.setfocus;
	end;
     end;
end;

procedure Tfrm_LOSTP02L.dte_Jn_Dt_ToExit(Sender: TObject);
begin
     try
     dte_Jn_Dt_To.Date := strtodate(dte_Jn_Dt_To.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('���� �Է� ����'+#13+
		       '�������ڷ� ����˴ϴ�');
	   dte_Jn_Dt_To.date := date;
	   dte_Jn_Dt_To.setfocus;
	end;
     end;
end;

procedure Tfrm_LOSTP02L.btn_PrintClick(Sender: TObject);
begin
   screen.Cursor := crAppStart;
   comm_rtn('P');
   screen.Cursor := crdefault;
end;

end.
