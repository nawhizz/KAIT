{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ820Q (�ֹ�/�����/�ܱ��ι�ȣ ��ȸ)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011. 09. ##
�Ϸ���	      : ####. ##. ##
���α׷� ���� : �ֹ�/�����/�ܱ��ι�ȣ�� ��ȸ�Ѵ�.

-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ820Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud, ComObj;

const
  TITLE   = '�ֹ�/�����/�ܱ��ι�ȣ ��ȸ';
  PGM_ID  = 'LOSTZ820Q';

type
  Tfrm_LOSTZ820Q = class(TForm)
    sts_Message:    TStatusBar;
    Bevel16:        TBevel;
    edt_Inq_Str:    TEdit;
    grd_display:    TStringGrid;
    Bevel1:         TBevel;
    lbl_Inq_Str:    TLabel;
    jo_gu_label:    TLabel;
        Label12:    TLabel;
    GroupBox1:      TGroupBox;
    RadioButton1:   TRadioButton;
    RadioButton2:   TRadioButton;
    serial_no_pnl:  TPanel;
    pnl_Command:    TPanel;
    Panel2:         TPanel;
    Panel3:         TPanel;
    Panel1:         TPanel;
    Panel4:         TPanel;
    edt_phone_no:   TMaskEdit;
    cmb_model_cb:   TComboBox;
    serial_edit:    TEdit;
    SkinData1:      TSkinData;
    TMAX:           TTMAX;

    search_condition_cb: TComboBox;
    edt_ga_no: TEdit;
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

    procedure FormCreate                  (Sender: TObject);
    procedure btn_CloseClick              (Sender: TObject);
    procedure btn_InquiryClick            (Sender: TObject);
    procedure grd_displayKeyPress         (Sender: TObject; var Key: Char);
    procedure search_condition_cbChange   (Sender: TObject);
    procedure grd_displayDrawCell         (Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow                    (Sender: TObject);
    procedure btn_LinkClick               (Sender: TObject);
    procedure cmb_model_cbKeyPress        (Sender: TObject; var Key: Char);
    procedure search_condition_cbKeyPress (Sender: TObject; var Key: Char);
    procedure grd_displayKeyUp            (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose                   (Sender: TObject; var Action: TCloseAction);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);

    procedure btn_resetClick(Sender: TObject);

    procedure onKeyPress(Sender : TObject; var key : Char);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    cmb_model_cb_d:TZ0xxArray;
    searchCondition:Integer; 	  // �˻�����, 1=����, 2=��¥, 3= ����, 4=�𵨸�+�ø����ȣ
    STR005:String;	            // �ܺη� �޴� �˻�����
    isData:Boolean;	            // ��Ʈ�� �׸��忡 �����Ͱ� �ִ�.
    grdFocousEnable:Boolean;	  // ��Ʈ���׸��忡 ��Ŀ���� �����Ѱ�?

  public
    { Public declarations }
    procedure initComponents;
    procedure unvisiableComponents;
    procedure initStrGrid;

  end;

var
  frm_LOSTZ820Q: Tfrm_LOSTZ820Q;

  qrystr : string;

implementation
{$R *.DFM}

//�׸����� ù��° ����(�޸�)�� �̻ڰ� Ʃ���Ѵ�.
procedure Tfrm_LOSTZ820Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    grid.Canvas.Font.Color  := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
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
		grid.Canvas.Fil lRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;

procedure Tfrm_LOSTZ820Q.initStrGrid;
begin
	with grd_display do begin
    RowCount       := 2;
    ColCount       := 16;
    RowHeights[0]  := 21;

    ColWidths[0]   := 42;
    ColWidths[1]   := 100;
    ColWidths[2]   := 160;
    ColWidths[3]   := 80;
    ColWidths[4]   := 82;
    ColWidths[5 ]  := 100;
    ColWidths[6 ]  := 120;
    ColWidths[7 ]  := 95;
    ColWidths[8 ]  := 80;
    ColWidths[9 ]  := 80;
    ColWidths[10]  := 140;
    ColWidths[11]  := 350;
    ColWidths[12]  := 80;
    ColWidths[13]  := -1;
    ColWidths[14]  := -1;
    ColWidths[15]  := -1;

    Cells[ 0,0]    :='SEQ'                    ;
    Cells[ 1,0]    :='����(��ü��)'           ;
    Cells[ 2,0]    :='�ֹ�/�����/�ܱ��ι�ȣ' ;
    Cells[ 3,0]    :='��ü��'                 ;
    Cells[ 4,0]    :='�������'               ;
    Cells[ 5,0]    :='����'                   ;
    Cells[ 6,0]    :='����ݻ���'             ;
    Cells[ 7,0]    :='�𵨸�'                 ;
    Cells[ 8,0]    :='serial no'              ;
    Cells[ 9,0]    :='����SEQ'                ;
    Cells[10,0]    :='��ȭ��ȣ'               ;
    Cells[11,0]    :='�ּ�'                   ;
    Cells[12,0]    :='�����ȣ'               ;
    Cells[13,0]    :='�԰�����'               ;
    Cells[14,0]    :='��ü���ڵ�'             ;
    Cells[15,0]    :='�н��ڵ�����ȣ'         ;
  end;
end;

//��� ������Ʈ �����
procedure Tfrm_LOSTZ820Q.unvisiableComponents;
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

    //�ֹ� ����ں�ȣ
    edt_ga_no.Visible       := False;
end;

//������Ʈ �ڸ� �� ��ġ
procedure Tfrm_LOSTZ820Q.initComponents;
var
  i : Integer;
	compTop:Integer;
begin
    // ��ư �ʱ�ȭ
    changeBtn(Self);

    btn_Print.Enabled := false;
    btn_excel.Enabled := false;

    if common_usergroup = 'SYSM' then btn_query.Enabled;

    edt_Inq_Str.Text        := '';
    edt_phone_no.Text       := '';
    cmb_model_cb.ItemIndex  := 0;
    edt_birth_date.Text     := '';
    serial_edit.Text        := '';

    compTop             := edt_Inq_Str.Top;
    edt_birth_date.Top  := compTop;		      //�������
    edt_phone_no.Top    := compTop;	        //�н��ڵ�����ȣ
    cmb_model_cb.Top    := compTop; 	      //�𵨸�+�ø����ȣ
    serial_edit.Top     := compTop;		      //
    edt_ga_no.Top       := compTop;         // �ֹ�/����ڹ�ȣ
    serial_no_pnl.Top   := compTop-1;

    for i := grd_display.FixedRows to grd_display.RowCount - 1 do
      grd_display.Rows[i].Clear;

    qrystr := '';

    initStrGrid;
end;

procedure Tfrm_LOSTZ820Q.FormCreate(Sender: TObject);
begin
	initSkinForm(SkinData1); //common_lib.pas�� �ִ�.

   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
//	if ParamCount < 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
//    	ShowMessage('���޵� �Ķ���� ��������!');
//        PostMessage(self.Handle, WM_QUIT, 0,0);
//        exit;
//  end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);
    STR005            := ParamStr(6);	//ȣ���ϴ� ���α׷��� ���� ���� �޶�����.

    {----------------------- ���� ���ø����̼� ���� ---------------------------}
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    Application.Title := TITLE;

    fSetIcon(Application);
    pSetStsWidth(sts_Message);
    pSetTxtSelAll(Self);

    Self.BorderIcons  := [biSystemMenu,biMinimize];
    Self.Position     := poScreenCenter;

    {--------------------------------------------------------------------------}

    // �̺�Ʈ �ο�
    serial_edit.OnKeyPress    := Self.onKeyPress;
    edt_phone_no.OnKeyPress   := Self.onKeyPress;
    edt_birth_date.OnKeyPress := Self.onKeyPress;
    edt_ga_no.OnKeyPress      := Self.onKeyPress;

    //�޺��ڽ� 'cmb_model_cb'�� �������� ä���.
    initComboBoxWithZ0xx('Z008.dat', cmb_model_cb_d, '','',  cmb_model_cb);

    //��Ʈ�� �׸��带 �ʱ�ȭ �Ѵ�.
    initStrGrid;

	  //��Ʈ���׸��忡 �����Ͱ� ����.
    isData:= False;

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ820Q.btn_CloseClick(Sender: TObject);
begin
   close;
end;

//'��ȸ' ��ư Ŭ��
procedure Tfrm_LOSTZ820Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;
    STR001,STR002,STR003,STR004:String;

    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_name, seed_idno, seed_tlno:String;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');
    
    qrystr := '';

    //�׸��� ���÷���
    grd_display.RowCount  := 2;     // �׸��� ���ڵ� ũ�� ����
    grd_display.FixedRows := 1;     // �׸��� ���� �ο� ����
    isData                := False; // ��Ʈ�� �׸��忡 �����Ͱ� ����.
    totalCount            := 0;     // ��ü ��ȸ �Ǽ� �ʱ�ȭ

    grd_display.Cursor    := crSQLWait;	//�۾���....
    //disableComponents;	//�۾��� �ٸ� ��� ��� ����.

    //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
    TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server   := 'KAIT_LOSTPRJ';

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

    TMAX.InitBuffer;

    STR001 := intToStr(searchCondition);
    STR002 := ' ';
    STR003 := '1';
    STR004 := '1';
    STR005 := '01'; // �� ���α׷����� �ܺ���ȸ ȣ�� ������ �����Ѵ�. ������ �ϳ��ۿ� ���� -_-;;

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';

    // ��ȸ ���� �� ������ ����
    case searchCondition of
      	//����
      1:	begin
            STR002 := Trim(edt_Inq_Str.Text);

            if RadioButton1.Checked then STR004:= '1'
            else STR004:= '2';
          end;
      2: STR002 := delHyphen(Trim(edt_birth_date.Text));  //1973-08-16 ==> 19630816

      3: STR002 := delHyphenPhone(edt_phone_no.Text);

      4:  begin
            STR002 := findCodeFromName(cmb_model_cb.Text, cmb_model_cb_d, cmb_model_cb.Items.Count);
            STR003 := Trim(serial_edit.Text);
            STR004 := '2';
          end;

      5: STR002 := edt_ga_no.Text;
    end;

    if (Length(Trim(STR002)) = 0) then
    begin
      ShowMessage('�ּ� �ѱ��� �̻� �Է����ּ���.');
      Exit;
    end;

      //�����Է� �κ�
    if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTZ820Q'      ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', STR001          ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', STR002          ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', STR003          ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR004', STR004          ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR005', STR005          ) < 0) then  goto LIQUIDATION;

      //���� ȣ��
    if not TMAX.Call('LOSTZ820Q') then goto LIQUIDATION;

    count1 := TMAX.RecvInteger('INT100',0);

    totalCount := totalCount + count1;

    if totalCount > 0 then
      isData:= True;	//��Ʈ���׸��忡 �����Ͱ� �ִ�.

    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
      for i:=0 to count1-1 do
      begin
          Cells[ 0,i+1] := intToStr(i+1);                             // SEQ
        //Cells[ 1,i+1] :=           TMAX.RecvString('STR101',i);     // ����(��ü��)
          seed_name     :=           TMAX.RecvString('STR101',i);     // ����(��ü��)
          Cells[ 1,i+1] := ECPlazaSeed.Decrypt(seed_name, common_seedkey);
        //Cells[ 2,i+1] := InsHyphen(TMAX.RecvString('STR102',i));    // �ֹλ���ڹ�ȣ
          seed_idno     := InsHyphen(TMAX.RecvString('STR102',i));    // �ֹλ���ڹ�ȣ
          Cells[ 2,i+1] := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
          Cells[ 3,i+1] :=           TMAX.RecvString('STR104',i);     // ��ü���ڵ��
          Cells[ 4,i+1] := InsHyphen(TMAX.RecvString('STR105',i));    // �������
          Cells[ 9,i+1] :=           TMAX.RecvString('STR106',i);     // ����SEQ
        //Cells[ 7,i+1] :=           TMAX.RecvString('STR107',i);     // ���ڵ�|Z008
          Cells[ 7,i+1] :=           TMAX.RecvString('STR108',i);     // �𵨸�
          Cells[ 8,i+1] :=           TMAX.RecvString('STR109',i);	    // �ܸ����Ϸù�ȣ
        //Cells[10,i+1] :=           TMAX.RecvString('STR110',i);	    // ó�������ڵ�|Z040
          Cells[ 5,i+1] :=           TMAX.RecvString('STR111',i);		  // ó�����и�
        //Cells[10,i+1] := TMAX.RecvString('STR112',i);		            // ��ȭ��ȣ
          seed_tlno     := TMAX.RecvString('STR112',i);		            // ��ȭ��ȣ
          Cells[10,i+1] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
          Cells[11,i+1] :=      Trim(TMAX.RecvString('STR113',i));	  // �ּ�
          Cells[12,i+1] :=           TMAX.RecvString('STR114',i); 	  // �����ȣ
          Cells[13,i+1] := InsHyphen(TMAX.RecvString('STR116',i));	  // �԰�����
          Cells[14,i+1] :=           TMAX.RecvString('STR103',i);     // ��ü���ڵ�|Z042
          Cells[15,i+1] :=      Trim(TMAX.RecvString('STR115',i));    // �н��ڵ�����ȣ
          Cells[ 6,i+1] :=      Trim(TMAX.RecvString('STR117',i));    // ����ݻ���

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

  if isData then grd_display.RowCount := grd_display.RowCount -1;

  if grdFocousEnable and isData then
    grd_display.SetFocus	//��Ʈ�� �׸���� ��Ŀ�� �̵�
  else
    search_condition_cbChange(Sender);
//    enableComponents;
end;

//On-KeyPress => ��Ʈ�� �׸���
procedure Tfrm_LOSTZ820Q.grd_displayKeyPress(Sender: TObject; var Key: Char);
begin
	if key = #13 then
		btn_LinkClick(self)	//'����' ��ư Ŭ��
end;

//'��ȸ����' ���� ����� ���
procedure Tfrm_LOSTZ820Q.search_condition_cbChange(Sender: TObject);
begin
	  //��� ������Ʈ�� �����.
    unvisiableComponents;

    searchCondition:= search_condition_cb.ItemIndex + 1;

    Case  search_condition_cb.ItemIndex of
      //����
      0:  begin
            edt_Inq_Str.Visible   := True;
            jo_gu_label.Visible   := True;
            Bevel1.Visible        := True;
            GroupBox1.Visible     := True;

            edt_Inq_Str.SetFocus;
          end;

      //�������
      1:  begin
            edt_birth_date.Visible := True;
            edt_birth_date.SetFocus;
          end;

      //�н��ڵ�����ȣ
      2:  begin
              edt_phone_no.Visible  := True;
              edt_phone_no.SetFocus;
          end;

      //�𵨸�+�Ϸù�ȣ
      3:  begin
            cmb_model_cb.Visible  := True;
            serial_edit.Visible   := True;
            serial_no_pnl.Visible := True;

            cmb_model_cb.SetFocus;
          end;
      // �ֹ�/����ڹ�ȣ
      4: edt_ga_no.Visible            := True;
    end;
end;

procedure Tfrm_LOSTZ820Q.FormShow(Sender: TObject);
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

    case searchCondition of
      1: edt_Inq_Str.Text         := str1;			//�������� �˻�
      2: edt_birth_date.Text      := str1;			//��¥�� �˻�
      3: edt_phone_no.EditText    := str1;			//�н����������� �˻�
      4: begin cmb_model_cb.Text  := str1;      //�𵨸�+�ø����ȣ�� �˻�
               serial_edit.Text   := str2;
         end;
      5: edt_ga_no.Text           := str1;      // ������ �ֹι�ȣ
    end;

    search_condition_cbChange(Sender);    
    grdFocousEnable:= Enabled;

    if (str1 <> '') then
      btn_InquiryClick(self); 	//'��ȸ' ��ư Ŭ��
  end else
  begin
    grdFocousEnable     := Enabled;
    searchCondition     := 1;
    edt_birth_date.Text := '';

  search_condition_cbChange(Sender);
  end;



end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTZ820Q.btn_LinkClick(Sender: TObject);
var
  smem:TPSharedMem;
  str_tmp:String;

  currentYear:Integer;
  year1, year2:Integer;

begin
	if not isData then begin 			    //��Ʈ�� �׸��忡 �����Ͱ� ������
    	search_condition_cb.SetFocus;	//'�˻�����' �޺��ڽ��� �̵�
      exit;
    end;

//    str_tmp := '';
//    case StrToInt(copy(grd_display.Cells[2,grd_display.Row],8,1)) of
//      1,2,5,6 : str_tmp := '19';
//      3,4,7,8 : str_tmp := '20';
//    else str_tmp := '19';
//    end;

	//�����޸𸮸� ��´�.
	smem:= OpenMap;

	if smem <> nil then
  begin
    Lock;  //���� ���ӹ���

    smem^.id_no       := delHyphen(grd_display.Cells[2,grd_display.Row]);                   // �ֹι�ȣ
    smem^.birth       := Copy(delHyphen(grd_display.Cells[2,grd_display.Row]),0,7);         // �������
    smem^.name        := grd_display.Cells[1,grd_display.Row];				                      // ����(��ü��)
    str_tmp           := Trim(grd_display.Cells[7,grd_display.Row]);
    smem^.model_name  := str_tmp;                                                           // �𵨸�
    smem^.model_code  := findCodeFromName(str_tmp,cmb_model_cb_d,cmb_model_cb.Items.Count); // ���ڵ�
    smem^.serial_no   := grd_display.Cells[8,grd_display.Row];		   	                      // �ܸ����Ϸù�ȣ
    smem^.ibgo_date   := grd_display.Cells[13,grd_display.Row];		   	                      // �԰�����
    smem^.pg_dt       := delHyphen(grd_display.Cells[4,grd_display.Row]);                   // �������
    smem^.po_cd       := delHyphen(grd_display.Cells[14,grd_display.Row]);                  // ��ü���ڵ�
    smem^.phone_no    := grd_display.Cells[10,grd_display.Row];		   	                      // �н��ڵ�����ȣ
    smem^.ju_seq      := grd_display.Cells[9,grd_display.Row];                              // ��� SEQ

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

//On-KeyPressUp =>��Ʈ�� �׸���
procedure Tfrm_LOSTZ820Q.grd_displayKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if key = vk_F2 then
    search_condition_cb.SetFocus;	//'�˻�����' �޺��ڽ��� ��Ŀ���̵�
end;

procedure Tfrm_LOSTZ820Q.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
	//�з�Ʈ �����츦 ȣ��
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 0, 0);

end;


//On-KeyPress =>���ڵ� �޺��ڽ�
procedure Tfrm_LOSTZ820Q.cmb_model_cbKeyPress(Sender: TObject; var Key: Char);
begin
	if key = #13 then serial_edit.SetFocus;	//�ø����ȣ�� ��Ŀ�� �̵�
end;

//On-KeyPress =>�˻����� �޺��ڽ�
procedure Tfrm_LOSTZ820Q.search_condition_cbKeyPress(Sender: TObject;  var Key: Char);
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

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTZ820Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

    if (TStringGrid(Sender).Cells[ 6, ARow] <> '') and (ACol = 6)then
    begin
      TStringGrid(Sender).Canvas.Brush.Color := clPurple;
      TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    end;

    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;

procedure Tfrm_LOSTZ820Q.btn_resetClick(Sender: TObject);
begin
  Self.initComponents;
end;

procedure Tfrm_LOSTZ820Q.onKeyPress(Sender : TObject;var Key : char);
begin
  if key = #13 then btn_InquiryClick(Sender)
  else if not (key in ['0'..'9',#8,#9,#22]) then key := #0;

end;

procedure Tfrm_LOSTZ820Q.edt_Inq_StrKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ820Q.btn_queryClick(Sender: TObject);
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

end.
