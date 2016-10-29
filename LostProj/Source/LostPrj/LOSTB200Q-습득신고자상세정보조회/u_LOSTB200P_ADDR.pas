unit u_LOSTB200P_ADDR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, checklst, cpakmsg, common_lib,
  localCloud, so_tmax;

type
  Tfrm_LOSTA110P_ADDR = class(TForm)
    GroupBox3: TGroupBox;
    Bevel7: TBevel;
    Label7: TLabel;
    Bevel8: TBevel;
    Bevel26: TBevel;
    Bevel20: TBevel;
    Label20: TLabel;
    Bevel21: TBevel;
    Label21: TLabel;
    Bevel22: TBevel;
    Label22: TLabel;
    Bevel23: TBevel;
    Label23: TLabel;
    Bevel24: TBevel;
    Label24: TLabel;
    lbl_Gid_Gu: TLabel;
    Bevel30: TBevel;
    lbl_Gju_So: TLabel;
    Label8: TLabel;
    sts_Message: TStatusBar;
    msk_Gpt_No: TMaskEdit;
    edt_Gbo_So: TEdit;
    msk_Gtl_No: TMaskEdit;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label2: TLabel;
    Bevel5: TBevel;
    Label3: TLabel;
    Bevel6: TBevel;
    Label4: TLabel;
    Bevel9: TBevel;
    Label5: TLabel;
    Bevel10: TBevel;
    Label6: TLabel;
    lbl_Nid_Gu: TLabel;
    Bevel14: TBevel;
    lbl_Nju_So: TLabel;
    Label14: TLabel;
    msk_Npt_No: TMaskEdit;
    edt_Nbo_So: TEdit;
    msk_Ntl_No: TMaskEdit;
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Next_Inq: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Help: TSpeedButton;
    btn_Close: TSpeedButton;
    edt_Gid_Nm: TEdit;
    edt_Nid_nm: TEdit;
    btn_GPostno_Inq: TBitBtn;
    btn_NPostno_Inq: TBitBtn;
    Bevel11: TBevel;
    lbl_Program_Name: TLabel;
    Bevel13: TBevel;
    Label9: TLabel;
    cmb_up_gu: TComboBox;
    msk_Gid_No: TMaskEdit;
    msk_Nid_No: TMaskEdit;
    cmb_Id_Cd: TComboBox;
    Label10: TLabel;
    Bevel12: TBevel;
    TMAX: TTMAX;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure msk_Gpt_NoKeyPress(Sender: TObject; var Key: Char);
    procedure msk_Npt_NoKeyPress(Sender: TObject; var Key: Char);
    procedure btn_UpdateClick(Sender: TObject);
    function ExecExternProg(progID:String):Boolean;
    procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT;
    procedure btn_click(Sender: TObject);
    procedure onKeyDown(Sender: TObject; var Key: Char);
    procedure msk_Gpt_NoClick(Sender: TObject);

  private
    { Private declarations }
    cmb_id_cd_d :TZ0xxArray;

    recvedMessage:Boolean;

    //LOSTZ820Q.exe ȣ��� ���
    itemNo        :String;
    value1, value2:String;


  public
    { Public declarations }

  end;

var
  frm_LOSTA110P_ADDR: Tfrm_LOSTA110P_ADDR;
  gs_gid_gu,gs_nid_gu : String;
  callValue : Integer;

implementation
uses u_LOSTA110P;
{$R *.DFM}

{--------------- user define function and procedure declaration -------------}
procedure btninit_rtn; forward;
{--------------- user define function and procedure code --------------------}
procedure btninit_rtn;
begin

  with frm_LOSTA110P_ADDR do
  begin
    btn_Add.Enabled	      := False;
    btn_Update.Enabled	  := True;
    btn_Delete.Enabled	  := False;
    btn_Inquiry.Enabled   := False;
    btn_Next_Inq.Enabled  := False;
    btn_Link.Enabled	    := False;
    btn_Print.Enabled	    := False;
  end;

end;
{----------------------------------------------------------------------------}


{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA110P_ADDR.btn_CloseClick(Sender: TObject);
begin
  // �ڽ�â ����� �θ�â�� ��밡���ϰ� �ϸ� �����ش�.
   self.hide;
   frm_LOSTA110P.Enabled := True;
   frm_LOSTA110P.Show;
end;

procedure Tfrm_LOSTA110P_ADDR.FormShow(Sender: TObject);
var tempstr : shortstring;

begin
{ �ڵ� load }
   initComboBoxWithZ0xx('Z001.dat', cmb_Id_Cd_d , '', '',cmb_Id_Cd  );

   cmb_Id_Cd.ItemIndex := -1;

   if( Length(delHyphen(frm_LOSTA110P.lbl_Gid_No.Caption)) = 13) then  gs_gid_gu := '1'
   else gs_gid_gu := '3';

   if( Length(delHyphen(frm_LOSTA110P.lbl_Nid_No.Caption)) = 13) then  gs_nid_gu := '1'
   else gs_nid_gu := '3';

   btninit_rtn;

   lbl_Gid_Gu.Caption := frm_LOSTA110P.lbl_Gid_Gu.Caption;

   if gs_gid_gu = '1' then
   begin
      msk_Gid_No.editmask := '999999-9999999;0;_' ;
      tempstr := copy(frm_LOSTA110P.lbl_Gid_No.Caption,1,6)
               + copy(frm_LOSTA110P.lbl_Gid_No.Caption,8,7);
   end
   else if gs_gid_gu = '3' then
   begin
      msk_Gid_No.editmask := '999-99-99999;0;_' ;
      tempstr := copy(frm_LOSTA110P.lbl_Gid_No.Caption,1,3)
               + copy(frm_LOSTA110P.lbl_Gid_No.Caption,5,2)
               + copy(frm_LOSTA110P.lbl_Gid_No.Caption,8,5);
   end
   else
   begin
      msk_Gid_No.editmask := '';
      msk_Gid_No.MaxLength := 16;
      tempstr := frm_LOSTA110P.lbl_Gid_No.Caption;
   end;
   msk_Gid_No.text := tempstr;

   edt_Gid_Nm.text    := frm_LOSTA110P.lbl_Gid_Nm.Caption;
   msk_Gpt_No.Text    := delHyphen(frm_LOSTA110P.lbl_Gpt_No.Caption);
   lbl_Gju_So.Caption := frm_LOSTA110P.lbl_Gju_So.Caption;
   edt_Gbo_so.Text    := trim(frm_LOSTA110P.lbl_Gbo_so.Caption);
   tempstr := frm_LOSTA110P.lbl_Gtl_No.Caption;
   msk_Gtl_No.Text    := copy(tempstr,1,4)+copy(tempstr,5,4)+copy(tempstr,9,4);

   lbl_Nid_Gu.Caption := frm_LOSTA110P.lbl_Nid_Gu.Caption;
   if gs_nid_gu = '1' then
   begin
      msk_Nid_No.editmask := '999999-9999999;0;_' ;
      tempstr := copy(frm_LOSTA110P.lbl_Nid_No.Caption,1,6)
               + copy(frm_LOSTA110P.lbl_Nid_No.Caption,8,7);
   end
   else if gs_gid_gu = '3' then
   begin
      msk_Nid_No.editmask := '999-99-99999;0;_' ;
      tempstr := copy(frm_LOSTA110P.lbl_Nid_No.Caption,1,3)
               + copy(frm_LOSTA110P.lbl_Nid_No.Caption,5,2)
               + copy(frm_LOSTA110P.lbl_Nid_No.Caption,8,5);
   end
   else
   begin
      msk_Nid_No.editmask := '';
      msk_Nid_No.MaxLength := 16;
      tempstr := frm_LOSTA110P.lbl_Nid_No.Caption;
   end;
   msk_Nid_No.text := tempstr;

   edt_Nid_Nm.text    := frm_LOSTA110P.lbl_Nid_Nm.Caption;
   msk_Npt_No.Text    := delHyphen(frm_LOSTA110P.lbl_Npt_No.Caption);
   lbl_Nju_So.Caption := frm_LOSTA110P.lbl_Nju_So.Caption;
   edt_Nbo_so.Text    := trim(frm_LOSTA110P.lbl_Nbo_so.Caption);
   tempstr            := frm_LOSTA110P.lbl_Ntl_No.Caption;
   msk_Ntl_No.Text    := copy(tempstr,1,4)+copy(tempstr,5,4)+copy(tempstr,9,4);

//   if trim(gs_up_gu) = '' then
//      cmb_up_gu.itemindex := -1
//   else
//   begin
//      cmb_up_gu.itemindex := strtoint(gs_up_gu) - 1;
//   end;
   sts_Message.Panels[1].text := '';
   frm_LOSTA110P.enabled := false;
end;

procedure Tfrm_LOSTA110P_ADDR.FormHide(Sender: TObject);
begin
   frm_LOSTA110P.Enabled := true;
end;

procedure Tfrm_LOSTA110P_ADDR.msk_Gpt_NoKeyPress(Sender: TObject;
  var Key: Char);
begin
msk_Gpt_no.OnKeyPress := nil;

   if key = #13 then
   begin

   end;
msk_Gpt_no.OnKeyPress := msk_Gpt_noKeyPress;

end;

procedure Tfrm_LOSTA110P_ADDR.msk_Npt_NoKeyPress(Sender: TObject;
  var Key: Char);
begin
msk_Npt_no.OnKeyPress := nil;
   if key = #13 then
   begin

   end;

  msk_Npt_no.OnKeyPress := msk_Npt_noKeyPress;

end;

procedure Tfrm_LOSTA110P_ADDR.btn_click(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin

    if(Length(msk_Gpt_No.Text) = 6) then
    begin
      	if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit)) then
        begin
          if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
          else  mskEdt := Sender as TMaskEdit;

          if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = msk_Gpt_No ) then
            begin
              callValue := 0;
              value1 := msk_Gpt_No.Text;
            end
          else if(bitBtn = btn_NPostno_Inq) or (mskEdt = msk_Npt_No ) then
            begin
              callValue := 1;
              value1 := msk_Npt_No.Text;
            end
        end;

      CreateMap;	//�����޸� ����
      self.ExecExternProg('LOSTZ800Q');
    end;
end;

//common_lib.pas�� �ִ� �Լ��� �ٸ���.
function Tfrm_LOSTA110P_ADDR.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  (****************************************************************************)
  (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
    			      (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '12'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  itemNo
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  value1
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  value2
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');
   end
end;

//'LOSTZ810Q.exe'���� �޼����� �����ش�.
procedure Tfrm_LOSTA110P_ADDR.Link_rtn (var Msg : TMessage);
var
  (**************************************************)
  (*  localcloud.pas                                *)
  (*  type :TPSharedMem                             *)
  (*  Using       :Integer;		  //�����=1,�̻��=0 *)
  (*  ProgID      :String[30];	//������� ���α׷� *)
  (*                                                *)
  (*  name        :String[30];                      *)
  (*  model_name  :String[30];                      *)
  (*  model_code  :String[30];                      *)
  (*  serial_no   :String[30];                      *)
  (*  ibgo_date   :String[30];                      *)
  (*  birth       :String[30];                      *)
  (*  phone_no    :String[30];                      *)
  (**************************************************)
  smem  :TPSharedMem;
  //modelName, serial_no, ibgoil:String;
  //str:String;

begin
	//'LOSTZ810.exe'���� ���� �޼����� �޾Ҵ�.
	recvedMessage:= True;


  //�����޸� ������ �ʿ俩�δ� wparam�� ������ ��.
  if Msg.wParam = 1 then
  begin
    //�����޸𸮸� ��´�.
    smem:= OpenMap;
    if smem <> nil then
    begin
      Lock;  //���� ���ӹ���

      if(callValue = 0 ) then
        begin
          msk_gPt_No.Text        := smem^.po_no;			    //����(��ü��)
          lbl_Gju_so.Caption     := smem^.ju_so;	        //�𵨸�
          //msk_Gtl_No.Text        := smem^.ddd_no;	        //�ܸ����Ϸù�ȣ
        end else
        begin
          msk_Npt_No.Text        := smem^.po_no;			    //����(��ü��)
          lbl_Nju_So.Caption     := smem^.ju_so;	        //�𵨸�
          //msk_Ntl_No.Text        := smem^.ddd_no;	        //�ܸ����Ϸù�ȣ
        end;

      //if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //�����޸𸮸� ��� ��.
      CloseMapMain;
      smem:= nil;
    end;

    edt_Gbo_So.SetFocus;

  end;
end;

procedure Tfrm_LOSTA110P_ADDR.onKeyDown(Sender: TObject; var Key: Char);
begin
	if Key <> #13 then 	//����Ű�� �ƴϸ�
    	exit;

  btn_click(Sender);
end;

procedure Tfrm_LOSTA110P_ADDR.btn_UpdateClick(Sender: TObject);

var
  STRVALUE : array[1..19] of string;
  i : Integer;
  STRNUM : string;

LABEL LIQUIDATION;

begin

  // �Է��ʵ� üũ
  if (not fChkLength(msk_Gid_No,13,0,'�ֹ�/����ڵ��/�ܱ��ι�ȣ' )) then Exit;
  if (not fChkLength(edt_Gid_Nm,1,1,'����/��ü��'                 )) then Exit;
  if (not fChkLength(msk_Gpt_No,6,0,'�����ȣ'                    )) then Exit;
  if (not fChkLength(edt_Gbo_So,1,1,'�����ּ�'                    )) then Exit;
  if (not fChkLength(msk_Gtl_No,8,1,'��ȭ��ȣ'                    )) then Exit;
  if (not fChkLength(msk_Nid_No,13,0,'�ֹ�/����ڵ��/�ܱ��ι�ȣ' )) then Exit;
  if (not fChkLength(edt_Nid_nm,1,1,'����/��ü��'                 )) then Exit;
  if (not fChkLength(msk_Npt_No,6,0,'�����ȣ'                    )) then Exit;
  if (not fChkLength(edt_Nbo_So,1,1,'�����ּ�'                    )) then Exit;
  if (not fChkLength(msk_Ntl_No,8,1,'��ȭ��ȣ'                    )) then Exit;

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

  FillChar(STRVALUE, SizeOf(STRVALUE),#0);

  i := 0;

  (*  ���ڵ�            *)STRVALUE[ 1] := frm_LOSTA110P.edt_md_cd.Text;
  (*  �ܸ����Ϸù�ȣ      *)STRVALUE[ 2] := frm_LOSTA110P.serial_edit.Text;
  (*  �԰�����            *)STRVALUE[ 3] := delHyphen(frm_LOSTA110P.dte_Ip_Dt.Text);
  (*  ���������ڵ�        *)STRVALUE[ 4] := IntToStr(cmb_up_gu.itemIndex + 1);
  (*  ����ڽĺ��ڵ�      *)STRVALUE[ 5] := cmb_id_cd_d[cmb_Id_Cd.itemIndex].code;
  (*  �����ڱ����ڵ�      *)STRVALUE[ 6] := gs_gid_gu;

  if (delHyphen(Trim(frm_LOSTA110P.lbl_Gid_No.Caption)) <> delHyphen(Trim(msk_Gid_No.Text))) then
        STRVALUE[ 7] := delHyphen(msk_Gid_No.Text )
  else  STRVALUE[ 7] := frm_LOSTA110P.frtnRealIdNo(0);

  (*  �����ڼ���(��ü��)  *)STRVALUE[ 8] := edt_Gid_Nm.Text;
  (*  �����ڿ����ȣ      *)STRVALUE[ 9] := delHyphen(msk_Gpt_No.Text);
  (*  �����ڱ⺻�ּ�      *)STRVALUE[10] := lbl_Gju_So.Caption;
  (*  �����ڻ��ּ�      *)STRVALUE[11] := edt_Gbo_So.Text;
  (*  ��������ȭ��ȣ      *)STRVALUE[12] := delHyphen(msk_Gtl_No.Text);
  (*  �����ڱ����ڵ�      *)STRVALUE[13] := gs_nid_gu;

  (*  �������ֹλ����    *)
  if (delHyphen(Trim(frm_LOSTA110P.lbl_Nid_No.Caption)) <> delHyphen(Trim(msk_Nid_No.Text))) then
       STRVALUE[14] := delHyphen(msk_Nid_No.Text )
  else STRVALUE[14] := frm_LOSTA110P.frtnRealIdNo(1);

  (*  �����ڼ���(��ü��)  *)STRVALUE[15] := edt_Nid_nm.Text;
  (*  �����ڿ����ȣ      *)STRVALUE[16] := delHyphen(msk_Npt_No.Text);
  (*  �����ڱ⺻�ּ�      *)STRVALUE[17] := lbl_Nju_So.Caption;
  (*  �����ڻ��ּ�      *)STRVALUE[18] := edt_Nbo_So.Text;
  (*  ��������ȭ��ȣ      *)STRVALUE[19] := delHyphen(msk_Ntl_No.Text);

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA110P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','U02')   < 0) then  goto LIQUIDATION;

  for i := Low( STRVALUE ) to High( STRVALUE ) do
  begin
    case Length(IntToStr(i)) of
      1 : STRNUM := '00' + IntToStr(i);
      2 : STRNUM := '0'  + IntToStr(i);
      3 : STRNUM :=        IntToStr(i);
    end;

    if (TMAX.SendString('STR' + STRNUM , STRVALUE[i]     ) < 0) then  goto LIQUIDATION;
  end;

  //���� ȣ��
	if not TMAX.Call('LOSTA110P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
      ShowMessage('���������� �����Ǿ����ϴ�.');
      sts_Message.Panels[1].Text := ' ���� �Ϸ�';
      frm_LOSTA110P.btn_InquiryClick(self);
    end;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;
procedure Tfrm_LOSTA110P_ADDR.msk_Gpt_NoClick(Sender: TObject);
begin
  (Sender as TMaskEdit).SelectAll;
end;

end.
