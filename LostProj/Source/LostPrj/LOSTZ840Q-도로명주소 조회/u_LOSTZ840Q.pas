{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ840Q (�����ȣ ���)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2013. 10.30
�Ϸ���	      : ####. ##. ##
���α׷� ���� : ���θ��ּ� �ڷḦ ��ȸ�Ѵ�.

-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ840Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud;

type
  Tfrm_LOSTZ840Q = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel16         : TBevel;
    edt_adr_bldnm1: TEdit;
    lbl_Inq_Str     : TLabel;
    Label15         : TLabel;
    lbl_Program_Name: TLabel;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    grd_display     : TStringGrid;
    TMAX            : TTMAX;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;
    msk_zip: TMaskEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel3: TBevel;
    Label2: TLabel;
    edt_adr_rodnm: TEdit;
    edt_ttvnm: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure edt_adr_bldnm1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure grd_displayKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    isData:Boolean;
  public
    { Public declarations }
     procedure initStrGrid;
  end;

var
  frm_LOSTZ840Q: Tfrm_LOSTZ840Q;


implementation
{$R *.DFM}

procedure Tfrm_LOSTZ840Q.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount := 3;
    RowHeights[0] := 21;

    ColWidths[0]  := 70;
    Cells[0,0]    :='�����ȣ';

    ColWidths[1]  := 400;
    Cells[1,0]    :='���θ��ּ�';

    ColWidths[2]  := 300;
    Cells[2,0]    :='�����ּ�';

  end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ840Q.FormCreate(Sender: TObject);

begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.

//	if ParamCount < 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
//    	ShowMessage('���޵� �Ķ���� ��������!');
//        PostMessage(self.Handle, WM_QUIT, 0,0);
//        exit;
//    end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//    common_userid     := '0294'; //ParamStr(2);
//    common_username   := '��ȣ��';
//    ParamStr(3);
//    common_usergroup  := 'KAIT'; //ParamStr(4);

    initSkinForm(SkinData1);
    initStrGrid;	//�׸��� �ʱ�ȭ

    isData:= False;  //��Ʈ���׸��忡 �����Ͱ� ����.

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ840Q.btn_CloseClick(Sender: TObject);
begin
    close;
end;


procedure Tfrm_LOSTZ840Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 0, 0);

end;

procedure Tfrm_LOSTZ840Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1,  totalCount:Integer;
    RowPos:Integer;
    STR001,STR002,STR003,STR004:String;

    Label LIQUIDATION;
    Label INQUIRY;
begin

  //�׸��� ���÷���

  RowPos:= 1;	//�׸��� ���ڵ� ������
  grd_display.RowCount := 2;
  grd_display.FixedRows:=1;

  grd_display.Cursor := crSQLWait;	//�۾���....
  //disableComponents;	//�۾��� �ٸ� ��� ��� ����.

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

//������ȸ
INQUIRY:


	TMAX.InitBuffer;

	STR001:=' ';
	STR002:=' ';
	STR003:=' ';
	STR004:=' ';

  totalCount := 0;

  //�����Է� �κ�
  if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF003','LOSTZ840Q'      ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', edt_adr_rodnm.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_adr_bldnm1.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', msk_zip.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', edt_ttvnm.Text) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTZ840Q') then goto LIQUIDATION;

  count1 := TMAX.RecvInteger('INT100',0);

  if count1 > 0 then isData := True;	//��Ʈ���׸��忡 �����Ͱ� �ִ�.

  if count1 > 0 then
    totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);	// �����ȣ
      Cells[1,RowPos] := TMAX.RecvString('STR102',i);	// ���θ��ּ�
      Cells[2,RowPos] := TMAX.RecvString('STR115',i);	// �����ּ�

      Inc(RowPos);
    end;

  end;
  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';

  Application.ProcessMessages;

   // count2 := TMAX.RecvInteger('INT100',0);
   // if count1 = count2 then
   // 	goto INQUIRY;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  if isData then grd_display.RowCount := grd_display.RowCount -1;

  if isData then
    grd_display.SetFocus	//��Ʈ�� �׸���� ��Ŀ�� �̵�
  else
    edt_adr_rodnm.SetFocus;


end;


procedure Tfrm_LOSTZ840Q.btn_LinkClick(Sender: TObject);
var
	smem:TPSharedMem;

begin
	if not isData then begin 			//��Ʈ�� �׸��忡 �����Ͱ� ������
    	edt_adr_rodnm.SetFocus;	//'�˻�����' �޺��ڽ��� �̵�
      exit;
  end;

  //�����޸𸮸� ��´�.
	smem:= OpenMap;

	if smem <> nil then
    begin
        Lock;  //���� ���ӹ���

        smem^.po_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row])); //�����ȣ
        smem^.ju_so   := Trim(grd_display.Cells[1,grd_display.Row]); // ���θ��ּ�
        smem^.ddd_no  := Trim(grd_display.Cells[2,grd_display.Row]); // �����ּ�

        UnLock;
    end;

    PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 1, 0);

   CloseMap;

   PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure Tfrm_LOSTZ840Q.edt_adr_bldnm1KeyPress(Sender: TObject;
  var Key: Char);
begin
	if Key <> #13 then 	//����Ű�� �ƴϸ�
    	exit;

  btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ840Q.FormShow(Sender: TObject);
begin

  changeBtn(Self);

  btn_reset.Enabled := False;
  btn_excel.Enabled := False;

  // �θ�â���� �����͸� �Ѱܹ����� �ٷ� ��ȸ
  if(ParamStr(8) <> '') then
  begin
    msk_zip.Text      := StringReplace(Trim(ParamStr(8)),'|','',[rfReplaceAll]);
    Self.btn_InquiryClick(Sender);
  end else
  begin
    edt_adr_rodnm.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ840Q.grd_displayKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_LinkClick(Sender);
end;

end.
