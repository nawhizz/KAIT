{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ150P (�޴� ���)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 19
�Ϸ���	      : ####. ##. ##
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTZ150P_pop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

type
  Tfrm_LOSTZ150P_pop = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Close: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    edt_pg_id: TEdit;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var

  frm_LOSTZ150P_pop: Tfrm_LOSTZ150P_pop;

implementation
uses u_LOSTZ150P_CHILD;
{$R *.dfm}

procedure Tfrm_LOSTZ150P_pop.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 2;
    	RowHeights[0] := 21;

    	ColWidths[0] := 210;
		Cells[0,0] :='���α׷� ID';

    	ColWidths[1] := 210;
		Cells[1,0] :='���α׷��� ';

    end;
end;



{-----------------------------------------------------------------------------}


procedure Tfrm_LOSTZ150P_pop.FormCreate(Sender: TObject);
begin
{   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
}
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //���뺯�� ����--common_lib.pas ������ ��.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);


    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '��ȣ��';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  initStrGrid;	//�׸��� �ʱ�ȭ


  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  btn_Add.Enabled := False;
  btn_Link.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;

 // btn_InquiryClick(Sender);

end;


procedure Tfrm_LOSTZ150P_pop.btn_CloseClick(Sender: TObject);
begin
  close;
  frm_LOSTZ150P_child.Enabled := True;
  frm_LOSTZ150P_child.Show;
end;



procedure Tfrm_LOSTZ150P_pop.FormShow(Sender: TObject);
begin
      frm_LOSTZ150P_child.Enabled := False;
      edt_pg_id.Text := PG_ID;
      frm_LOSTZ150P_pop.btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ150P_pop.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
	  //�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //���۽ú��� �ʱ�ȭ
    totalCount :=0;
    grd_display.Cursor := crSQLWait;	//�۾���....

    //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	  TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server�� ã���� �����ϴ�.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
    TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX ������ ����Ǿ� ���� �ʽ��ϴ�.');
        goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX �޸� �Ҵ翡 ���� �Ͽ����ϴ�.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX ���ۿ� ���� �Ͽ����ϴ�.');
        goto LIQUIDATION;
	end;

//�ݺ� ��ȸ
INQUIRY:

    TMAX.InitBuffer;
    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ150P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_pg_id.Text )   < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTZ150P') then goto LIQUIDATION;

    //��ȸ�� ����
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos] := TMAX.RecvString('STR101',i); //���α׷� ID
          Cells[1,RowPos] := TMAX.RecvString('STR102',i); //���α׷� ��

          Inc(RowPos);
        end;
    end;
    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;
LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;
end;

procedure Tfrm_LOSTZ150P_pop.grd_displayDblClick(Sender: TObject);
begin

    frm_LOSTZ150P_child.edt_pg_id.Text := grd_display.Cells[0, grd_display.Row];
    frm_LOSTZ150P_child.edt_pg_nm.Text := grd_display.Cells[1, grd_display.Row];
    frm_LOSTZ150P_child.edt_mu_nm.Text := grd_display.Cells[1, grd_display.Row];
    frm_LOSTZ150P_child.edt_pg_nm.Enabled := False;


    close;

end;

procedure Tfrm_LOSTZ150P_pop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTZ150P_child.Enabled := True;
  frm_LOSTZ150P_child.Show;
end;

end.
