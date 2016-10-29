{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ800Q (�����ȣ ���)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 08.16
�Ϸ���	      : ####. ##. ##
���α׷� ���� : �����ȣ �ڷḦ ��ȸ�Ѵ�.

-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ800Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud, ComObj;

type
  Tfrm_LOSTZ800Q = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel16         : TBevel;
    cmb_Inq_Gu      : TComboBox;
    edt_Inq_Str     : TEdit;
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

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
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
  frm_LOSTZ800Q: Tfrm_LOSTZ800Q;


implementation
{$R *.DFM}

procedure Tfrm_LOSTZ800Q.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount := 4;
    RowHeights[0] := 21;

    ColWidths[0]  := 165;
    Cells[0,0]    :='�����ȣ';

    ColWidths[1]  := 450;
    Cells[1,0]    :='�ּ�';

    ColWidths[2]  := 140;
    Cells[2,0]    :='DDD��ȣ';

    ColWidths[3]  := -1;
    Cells[3,0]    :='';

  end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ800Q.FormCreate(Sender: TObject);

begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.

//	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
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
    common_seedkey    := ParamStr(6);

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

procedure Tfrm_LOSTZ800Q.btn_CloseClick(Sender: TObject);
begin
    close;
end;


procedure Tfrm_LOSTZ800Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 0, 0);

end;

procedure Tfrm_LOSTZ800Q.cmb_Inq_GuChange(Sender: TObject);
begin
   //edt_inq_str.Text := '';

   if cmb_inq_gu.ItemIndex = 0 then
   begin
      lbl_inq_str.Caption := '���� ��ȣ';
      edt_inq_str.ImeMode := imSAlpha;
      edt_inq_str.MaxLength := 6;
   end
   else
   begin
      lbl_inq_str.Caption := '��     ��';
      edt_inq_str.ImeMode := imSHanguel;
      edt_inq_str.MaxLength := 18;
   end;

  edt_Inq_Str.SetFocus;   

end;

procedure Tfrm_LOSTZ800Q.btn_InquiryClick(Sender: TObject);
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
  if (TMAX.SendString('INF003','LOSTZ800Q'      ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', IntToStr((cmb_Inq_Gu.ItemIndex))) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_Inq_Str.Text) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTZ800Q') then goto LIQUIDATION;

  count1 := TMAX.RecvInteger('INT100',0);

  if count1 > 0 then isData := True;	//��Ʈ���׸��忡 �����Ͱ� �ִ�.

  if count1 > 0 then
    totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);	//����(��ü��)
      Cells[1,RowPos] := TMAX.RecvString('STR102',i);	// �ּ�
      Cells[2,RowPos] := TMAX.RecvString('STR103',i);	// DDD��ȣ
      Cells[3,RowPos] := TMAX.RecvString('STR104',i);	// �ּ�2

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
    edt_Inq_Str.SetFocus;


end;


  procedure Tfrm_LOSTZ800Q.btn_LinkClick(Sender: TObject);
var
	smem:TPSharedMem;

begin
	if not isData then begin 			//��Ʈ�� �׸��忡 �����Ͱ� ������
    	cmb_Inq_Gu.SetFocus;	//'�˻�����' �޺��ڽ��� �̵�
      exit;
    end;

  //�����޸𸮸� ��´�.
	smem:= OpenMap;

	if smem <> nil then
    begin
        Lock;  //���� ���ӹ���

        smem^.po_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row])); //�����ȣ
        smem^.ju_so   := Trim(grd_display.Cells[3,grd_display.Row]); // �ּ� 2
        smem^.ddd_no  := Trim(grd_display.Cells[2,grd_display.Row]); // DDD��ȣ

        UnLock;
    end;

    PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 1, 0);

   CloseMap;

   PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure Tfrm_LOSTZ800Q.edt_Inq_StrKeyPress(Sender: TObject;
  var Key: Char);
begin
	if Key <> #13 then 	//����Ű�� �ƴϸ�
    	exit;

  btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ800Q.FormShow(Sender: TObject);
begin
  cmb_Inq_Gu.ItemIndex := 1;

  cmb_Inq_GuChange(Sender);

  changeBtn(Self);

  btn_reset.Enabled := False;
  btn_excel.Enabled := False;

  // �θ�â���� �����͸� �Ѱܹ����� �ٷ� ��ȸ
  if(ParamStr(8) <> '') then
  begin
    cmb_Inq_Gu.ItemIndex  := 0;
    edt_Inq_Str.Text      := StringReplace(Trim(ParamStr(8)),'|','',[rfReplaceAll]);
    Self.btn_InquiryClick(Sender);
    cmb_Inq_GuChange(sender);
  end else
  begin
    cmb_Inq_Gu.ItemIndex := 1;
    edt_Inq_Str.SetFocus;    
  end;
end;

procedure Tfrm_LOSTZ800Q.grd_displayKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_LinkClick(Sender);
end;

end.
