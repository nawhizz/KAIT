{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ810Q (���� ��ȸ)
���α׷� ���� : Online
�ۼ���	      : KOO NAE YOUNG
�ۼ���	      : 2011. 09. ##
�Ϸ���	      : ####. ##. ##
���α׷� ���� : ����(��ü��)�� ��ȸ�Ѵ�.

-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ810Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud, ComObj;

const
  TITLE   = '���� ��ȸ';
  PGM_ID  = 'LOSTZ810Q';

type
  Tfrm_LOSTZ810Q = class(TForm)
    GroupBox1  : TGroupBox;
    Label12    : TLabel;
    Panel3     : TPanel;
    pnl_Command: TPanel;
    Panel1     : TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SkinData1  : TSkinData;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    TMAX       : TTMAX;
    Panel2: TPanel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    Bevel1: TBevel;
    jo_gu_label: TLabel;
    edt_Inq_Str: TEdit;
    search_condition_cb: TComboBox;
    cmb_model_cb: TComboBox;
    serial_edit: TEdit;
    serial_no_pnl: TPanel;
    edt_phone_no: TMaskEdit;
    edt_birth_date: TEdit;
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
    procedure btn_InquiryClick(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayKeyPress(Sender: TObject; var Key: Char);
    procedure search_condition_cbChange(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure cmb_model_cbKeyPress(Sender: TObject; var Key: Char);
    procedure search_condition_cbKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure onKeyPress(Sender : TObject; var key : Char);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);

  private
    { Private declarations }
    cmb_model_cb_d:TZ0xxArray;
    searchCondition:Integer; 	//�˻�����, 1=����, 2=��¥, 3= ����, 4=�𵨸�+�ø����ȣ
    STR005:String;	//�ܺη� �޴� �˻�����
    isData:Boolean;	//��Ʈ�� �׸��忡 �����Ͱ� �ִ�.
    grdFocousEnable:Boolean;	//��Ʈ���׸��忡 ��Ŀ���� �����Ѱ�?

  public
    { Public declarations }
    procedure initComponents;
    procedure unvisiableComponents;
    procedure initStrGrid;
  end;

var
  frm_LOSTZ810Q: Tfrm_LOSTZ810Q;
  qrystr : STring;

implementation
{$R *.DFM}

//�׸����� ù��° ����(�޸�)�� �̻ڰ� Ʃ���Ѵ�.
procedure Tfrm_LOSTZ810Q.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];

  if (ARow =0) then
    begin
    grid.Canvas.Brush.Color := clBtnFace;
    grid.Canvas.Font.Color := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
    end else
    // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
  begin
    case ACol of
      1,3,5,7,9,10 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,2,4,6,8,11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;
  end;
{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;

procedure Tfrm_LOSTZ810Q.initStrGrid;
begin
	with grd_display do begin
    RowCount      :=2;
    ColCount      := 12;
    RowHeights[0] := 21;

    ColWidths[0] := 42;
		Cells[0,0] :='SEQ';

    ColWidths[1] := 80;
		Cells[1,0] :='����(��ü��)';

    ColWidths[2] := 110;
		Cells[2,0] :='�ֹλ���ڹ�ȣ';

    //ColWidths[3] := 100;
		//Cells[3,0] :='ó�������ڵ�';

    ColWidths[3] := 80;
		Cells[3,0] :='ó�����и�';

    ColWidths[4] := 120;
		Cells[4,0] :='����ݻ���';

    ColWidths[5] := 82;
		Cells[5,0] :='�𵨸�';

    ColWidths[6] := 95;
		Cells[6,0] :='�ܸ����Ϸù�ȣ';

    ColWidths[7] := 95;
		Cells[7,0] :='�н��ڵ�����ȣ';

    ColWidths[8] := 80;
		Cells[8,0] :='�԰�����';

    ColWidths[9] := 100;
		Cells[9,0] :='��ȭ��ȣ';

    ColWidths[10] := 350;
		Cells[10,0] :='�ּ�';

    ColWidths[11] := 60;
		Cells[11,0] :='�����ȣ';
  end;

end;

//��� ������Ʈ �����
procedure Tfrm_LOSTZ810Q.unvisiableComponents;
begin
	//����
	edt_Inq_Str.Visible     := false;
	jo_gu_label.Visible     := false;
	Bevel1.Visible          := false;
	GroupBox1.Visible       := false;

	//�������(1):
	edt_birth_date.Visible  := false;

	//�н��ڵ�����ȣ(2):
	edt_phone_no.Visible    := false;

	//�𵨸�+�Ϸù�ȣ(3):
	cmb_model_cb.Visible    := false;
	serial_edit.Visible     := false;
  serial_no_pnl.Visible   := false;
end;

//������Ʈ �ڸ� �� ��ġ
procedure Tfrm_LOSTZ810Q.initComponents;
var
  i : Integer;
	compTop:Integer;
begin
  changeBtn(Self);

  qrystr := '';

 if common_usergroup = 'SYSM' then btn_query.Enabled;

  //��Ʈ���׸��忡 �����Ͱ� ����.
  isData:= False;

  edt_phone_no.Text := '';



  btn_Print.Enabled := false;
  btn_excel.Enabled := false;

  edt_Inq_Str.Text        := '';
  edt_phone_no.Text       := '';
  cmb_model_cb.ItemIndex  := 0;
  edt_birth_date.Text     := '';
  serial_edit.Text        := '';

  compTop             := edt_Inq_Str.Top;
  edt_birth_date.Top  := compTop;		        //�������
  edt_phone_no.Top    := compTop;	          //�н��ڵ�����ȣ
  cmb_model_cb.Top    := compTop; 	        //�𵨸�+�ø����ȣ
  serial_edit.Top     := compTop;		        //
  serial_no_pnl.Top   := compTop-1;

  for i := grd_display.FixedRows to grd_display.RowCount - 1 do
    grd_display.Rows[i].Clear;

  initStrGrid;
end;

procedure Tfrm_LOSTZ810Q.FormCreate(Sender: TObject);
begin
	  initSkinForm(SkinData1); //common_lib.pas�� �ִ�.

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);
    STR005            := ParamStr(6);	//ȣ���ϴ� ���α׷��� ���� ���� �޶�����.

  {----------------------- ���� ���ø����̼� ���� ---------------------------}

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ĸ�� ����
  Label12.Caption := TITLE;

  // ���α׷� ��� ������ ����
  fSetIcon(Application);

  // �޼��� �� ���� ����
  pSetStsWidth(sts_Message);

  // �ؽ�Ʈ ���ý� ��ü ���� ���
  pSetTxtSelAll(Self);

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  //�޺��ڽ� 'cmb_model_cb'�� �������� ä���.
  initComboBoxWithZ0xx('Z008.dat', cmb_model_cb_d, '','',  cmb_model_cb);

  serial_edit.OnKeyPress    := Self.onKeyPress;
  edt_phone_no.OnKeyPress   := Self.onKeyPress;
  edt_birth_date.OnKeyPress := Self.onKeyPress;

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ810Q.btn_CloseClick(Sender: TObject);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 0, 0);
  PostMessage(self.Handle, WM_QUIT, 0,0);
end;

//'��ȸ' ��ư Ŭ��
procedure Tfrm_LOSTZ810Q.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_idnm, seed_idno, seed_tlno, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;
    seq,RowPos:Integer;
    STR001,STR002,STR003,STR004:String;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_idnm := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

	//�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    totalCount := 0;
    grd_display.RowCount := 2;
    grd_display.FixedRows:=1;
    isData := False; //��Ʈ�� �׸��忡 �����Ͱ� ����.

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

//SEED KEY ��ȸ
SEEDKEY:

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //���� ȣ��
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED��ȣȭŰ

//������ȸ
INQUIRY:

{
STR005;
<��ȸ��������>
�ܺο��� �� ���α׷��� ȣ��� ������ �����Ѵ�.

01: �ڵ��� �н���(��ü)
02: �ڵ��� �н���(����Ȯ��)
11: �ڵ��� ������(��ü)

12: �ڵ��� ������(����ǰ �̹߼�)
13: �ڵ��� ������(����ǰ �߼۴��)

}

	TMAX.InitBuffer;

	STR001:= intToStr(searchCondition);
	STR002:=' ';
	STR003:='1';
	STR004:='1';

    case searchCondition of
    	1:	begin	//����
        		STR002 := Trim(edt_Inq_Str.Text);

            if RadioButton1.Checked then
              STR004:= '1'
            else
              STR004:= '2';
        	end;

        2:	begin
        		STR002 :=  delHyphen(Trim(edt_birth_date.Text));  //1973-08-16 ==> 19630816
        	end;

        3,5:  begin
        		STR002 := delHyphenPhone(edt_phone_no.Text);
        	end;

        4:  begin
        		STR002 := findCodeFromName(cmb_model_cb.Text, cmb_model_cb_d, cmb_model_cb.Items.Count);
                STR003 := Trim(serial_edit.Text);
                STR004:= '2';
        	end;
    end;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ810Q'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTZ810Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

	count1 := TMAX.RecvInteger('INT100',0);
    if count1 >0 then
    	isData:= True;	//��Ʈ���׸��忡 �����Ͱ� �ִ�.

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        Cells[ 0,RowPos] := intToStr(seq);	                    // ����
        seed_idnm        := TMAX.RecvString('STR101',i);	      // ����(��ü��)
        Cells[ 1,RowPos] := ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
        seed_idno        := TMAX.RecvString('STR102',i);	      // �ֹλ���ڹ�ȣ
        Cells[ 2,RowPos] := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
        //Cells[3,RowPos] := TMAX.RecvString('STR103',i);	      // ó�������ڵ�
        Cells[ 3,RowPos] := TMAX.RecvString('STR104',i);		    // ó�����и�
        Cells[ 4,RowPos] := TMAX.RecvString('STR113',i);	      // ����ݻ���
        Cells[ 5,RowPos] := TMAX.RecvString('STR106',i);		    // �𵨸�
        Cells[ 6,RowPos] := TMAX.RecvString('STR107',i);		    // �ܸ����Ϸù�ȣ
        seed_mtno        := TMAX.RecvString('STR112',i);	      // �н��ڵ�����ȣ
        Cells[ 7,RowPos] := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
        Cells[ 8,RowPos] := TMAX.RecvString('STR108',i);		    // �԰�����
        seed_tlno        := TMAX.RecvString('STR109',i);		    // ��ȭ��ȣ
        Cells[ 9,RowPos] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
        Cells[10,RowPos] := Trim(TMAX.RecvString('STR110',i));	// �ּ�
        Cells[11,RowPos] := Trim(TMAX.RecvString('STR111',i));	// �����ȣ

        Inc(seq);
        Inc(RowPos);
      end;
    end;

    // ������ ��´�.
    qryStr:= TMAX.RecvString('INF014',0);

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
  grd_display.Cursor    := crDefault;	//�۾��Ϸ�
  grd_display.RowCount  := grd_display.RowCount -1;

  if grdFocousEnable then
    grd_display.SetFocus;	//��Ʈ�� �׸���� ��Ŀ�� �̵�
//    enableComponents;
end;

//On-KeyPress => edt_inq_str, �������� ��ȸ
procedure Tfrm_LOSTZ810Q.edt_Inq_StrKeyPress(Sender: TObject;  var Key: Char);
begin
	edt_inq_str.OnKeyPress := nil;

	if key = #13 then begin
		btn_InquiryClick(self);	//'��ȸ' ��ư Ŭ��
    end;

	edt_inq_str.OnKeyPress := edt_inq_strKeyPress;
end;

//On-KeyPress => ��Ʈ�� �׸���
procedure Tfrm_LOSTZ810Q.grd_displayKeyPress(Sender: TObject; var Key: Char);
begin
	if key = #13 then
		btn_LinkClick(self)	//'����' ��ư Ŭ��
end;

//'��ȸ����' ���� ����� ���
procedure Tfrm_LOSTZ810Q.search_condition_cbChange(Sender: TObject);
begin
	//��� ������Ʈ�� �����.
    unvisiableComponents  ;
    searchCondition:= search_condition_cb.ItemIndex + 1;

    Case  search_condition_cb.ItemIndex of
        0:  							//����
        begin
        	edt_Inq_Str.Visible   := True;
           edt_Inq_Str.SetFocus;
          jo_gu_label.Visible   := True;
          Bevel1.Visible        := True;
          GroupBox1.Visible     := True;
        end;
        1:
        begin
        	edt_birth_date.Visible     := True;  	//�������
            edt_birth_date.SetFocus;
        end;

        2,4:
        begin
        	edt_phone_no.Visible  := True;	//�н��ڵ�����ȣ
          edt_phone_no.SetFocus;
          edt_phone_no.Text := '';

          if search_condition_cb.ItemIndex = 2 then
            edt_phone_no.EditMask := 'aaa-aaaa-aaaa;0;'
          else
            edt_phone_no.EditMask := 'aaaa-aaaa-aaaa;0;';
        end;
        3: 								//�𵨸�+�Ϸù�ȣ
        begin
        	cmb_model_cb.Visible  := True;
          cmb_model_cb.SetFocus;
          serial_edit.Visible   := True;
          serial_no_pnl.Visible := True;
        end;
    end;
end;

procedure Tfrm_LOSTZ810Q.FormShow(Sender: TObject);
var
	str1, str2:String;
begin
  //������Ʈ �ڸ� �� ��ġ
  initComponents;

  if (ParamStr(8) <> '') then
  begin

    searchCondition                 := StrToInt(ParamStr(7));
    search_condition_cb.ItemIndex   := searchCondition-1;		//�˻������� ����

    str1:= fRNVL(ParamStr(8));
    str2:= fRNVL(ParamStr(9));
    if str1 = 'dummy' then str1:='';
    if str2 = 'dummy' then str2:='';

    search_condition_cbChange(search_condition_cb);			    //�����ִ� ������Ʈ�� ��ȯ

    case searchCondition of
      1: edt_Inq_Str.Text         := str1;			//�������� �˻�
      2: edt_birth_date.Text      := str1;			//��¥�� �˻�
      3,5: edt_phone_no.Text      := StringReplace(str1,'_',' ',[rfReplaceAll]);
      4: begin cmb_model_cb.Text  := str1;      //�𵨸�+�ø����ȣ�� �˻�
               serial_edit.Text   := str2;
         end;
    end;

    grdFocousEnable:= False;

    if (str1 <> '') then
      btn_InquiryClick(self); 	//'��ȸ' ��ư Ŭ��
  end else
  begin
    grdFocousEnable     := True;
    searchCondition     := 1;
    edt_birth_date.Text := '';
    search_condition_cbChange(search_condition_cb);			    //�����ִ� ������Ʈ�� ��ȯ
  end;
  
  if ParamStr(8) <> '' then
  begin
    grd_display.SetFocus;
    grdFocousEnable := True;
  end else
    search_condition_cb.SetFocus;

end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTZ810Q.btn_LinkClick(Sender: TObject);
var
  smem:TPSharedMem;
  str_tmp:String;

  currentYear:Integer;
  year1, year2:Integer;

begin
  if not isData then begin 			//��Ʈ�� �׸��忡 �����Ͱ� ������
    search_condition_cb.SetFocus;	//'�˻�����' �޺��ڽ��� �̵�
    exit;
  end;

//  currentYear := strToInt(firstString(DateToStr(Date),'-')) - 5;
//  str_tmp     := Trim(firstString(grd_display.Cells[2,grd_display.Row],'-'));	//������� ����
//  year1       := StrToInt('20'+ Copy(str_tmp,1,2));
//
//  if year1 > currentYear then
//    year1:= StrToInt('19'+ Copy(str_tmp,1,2));

	//�����޸𸮸� ��´�.
	smem:= OpenMap;

	if smem <> nil then begin
    Lock;  //���� ���ӹ���

    smem^.name        := grd_display.Cells[1,grd_display.Row];				      //����(��ü��)
    str_tmp           := Trim(grd_display.Cells[5,grd_display.Row]);        //�𵨸�
    smem^.model_name  := str_tmp;
    smem^.model_code  := findCodeFromName(str_tmp,cmb_model_cb_d,cmb_model_cb.Items.Count); //���ڵ�
    smem^.serial_no   := grd_display.Cells[6,grd_display.Row];		   	      //�ܸ����Ϸù�ȣ
    smem^.ibgo_date   := grd_display.Cells[8,grd_display.Row];		   	      //�԰�����

//    str_tmp           := Trim(firstString(grd_display.Cells[2,grd_display.Row],'-'));	//������� ����
//    str_tmp           := IntToStr(year1)+ Copy(str_tmp,3, Length(str_tmp)-2);
//    smem^.birth       := InsHyphen(str_tmp);					   			              //�������
    smem^.birth       := delHyphen(Copy(grd_display.Cells[2,grd_display.Row],0,8));
    smem^.phone_no    := grd_display.Cells[7,grd_display.Row];		   	      //�н��ڵ�����ȣ
    smem^.phone_no2   := grd_display.Cells[9,grd_display.Row];		   	      //��ȭ��ȣ

    UnLock;
  end;

	if STR005 = '12' then //LOSTB130P.EXE���� ȣ��
    	//�з�Ʈ �����츦 ȣ��
		PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, searchCondition)
	else
		PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, 0);

  //�����޸𸮸� �ݴ´�.
  CloseMap;

  //�ڽ��� �ݴ´�.
  PostMessage(self.Handle, WM_QUIT, 0,0);
end;

//On-KeyPress =>���ڵ� �޺��ڽ�
procedure Tfrm_LOSTZ810Q.cmb_model_cbKeyPress(Sender: TObject; var Key: Char);
begin
	if key = #13 then begin
		serial_edit.SetFocus;	//�ø����ȣ�� ��Ŀ�� �̵�
    end;
end;

//On-KeyPress =>�˻����� �޺��ڽ�
procedure Tfrm_LOSTZ810Q.search_condition_cbKeyPress(Sender: TObject;  var Key: Char);
begin
	if key = #13 then begin
    	Case self.searchCondition of
        1: edt_Inq_Str.SetFocus;
        2: edt_birth_date.SetFocus;
        3: edt_phone_no.SetFocus;
        4: cmb_model_cb.SetFocus;
        end;
    end;
end;

//On-KeyPressUp =>��Ʈ�� �׸���
procedure Tfrm_LOSTZ810Q.grd_displayKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
    if key = vk_F2 then
    	search_condition_cb.SetFocus;	//'�˻�����' �޺��ڽ��� ��Ŀ���̵�
end;

procedure Tfrm_LOSTZ810Q.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 0, 0);
  PostMessage(self.Handle, WM_QUIT, 0,0);

end;

procedure Tfrm_LOSTZ810Q.onKeyPress(Sender : TObject;var Key : char);
begin
  if key = #13 then btn_InquiryClick(Sender)
  else if not (key in ['0'..'9',#8,#9,'-']) then key := #0;

end;

procedure Tfrm_LOSTZ810Q.btn_resetClick(Sender: TObject);
begin
  self.initComponents;
end;

procedure Tfrm_LOSTZ810Q.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
  f         :TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\' + PGM_ID + 'QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTZ810Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
var
  LeftPos: Integer;
  TopPos : integer;
  CellStr: string;
begin
  with TStringGrid(Sender).Canvas do begin
    CellStr := TStringGrid(Sender).Cells[ACol, ARow];
    TopPos  := ((Rect.Top - Rect.Bottom -TStringGrid(Sender).Canvas.TextHeight(CellStr)) div 2) + Rect.Bottom;
    case i_align of
      1 :  LeftPos := ((Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) div 2) + Rect.Left;
      2 :  LeftPos :=  (Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) +
                        Rect.Left - 5;  
      else LeftPos := Rect.Left + 5;
    end;

    if (TStringGrid(Sender).Cells[ 4, ARow] <> '') and (ACol = 4)then
    begin
      TStringGrid(Sender).Canvas.Brush.Color := clPurple;
      TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    end;

    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;
end.
