unit u_LOSTZ240P_child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,localCloud, ComObj;

const
  TITLE   = '�Ѱ������� ���';
  PGM_ID  = 'LOSTZ240P';

type
  Tfrm_LOSTZ240P_CHILD = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    edt_Gm_Nm: TEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    edt_ge_no: TEdit;
    Bevel3: TBevel;
    Label2: TLabel;
    edt_gm_cd: TMaskEdit;
    edt_gm_tl: TMaskEdit;
    pnl_Command: TPanel;
    Bevel4: TBevel;
    Label3: TLabel;
    Bevel5: TBevel;
    Label4: TLabel;
    cmb_pl_cd: TComboBox;
    edt_bi_go: TEdit;
    Bevel6: TBevel;
    Label5: TLabel;
    edt_dm_nm: TMaskEdit;
    Bevel7: TBevel;
    Label6: TLabel;
    edt_dm_ml: TEdit;
    Bevel8: TBevel;
    Label7: TLabel;
    edt_dm_pt: TMaskEdit;
    Bevel9: TBevel;
    Label8: TLabel;
    edt_dm_ju: TMaskEdit;
    Bevel11: TBevel;
    Label10: TLabel;
    Panel1: TPanel;
    rdo_Sh_Yes: TRadioButton;
    rdo_Sh_No: TRadioButton;
    TMAX: TTMAX;
    Bevel12: TBevel;
    edt_dm_bo: TMaskEdit;
    Label11: TLabel;
    Bevel13: TBevel;
    edt_dp_nm: TEdit;
    Label12: TLabel;
    Bevel14: TBevel;
    Label13: TLabel;
    edt_ps_nm: TEdit;
    Bevel17: TBevel;
    Label14: TLabel;
    edt_mt_no: TMaskEdit;
    btn_GPostno_Inq: TBitBtn;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_GPostno_InqClick(Sender: TObject);
    function ExecExternProg(progID:String):Boolean;
    procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT2;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
    cmb_pl_cd_d: TZ0xxArray;
    recvedMessage:Boolean;
    value1,value2 :String;

  public
    { Public declarations }
  end;

var
  callValue : Integer;
  frm_LOSTZ240P_CHILD : Tfrm_LOSTZ240P_CHILD;

implementation

uses cpaklibm, u_LOSTZ240P;

{$R *.DFM}

procedure Tfrm_LOSTZ240P_CHILD.setEdtKeyPress;
var i : Integer;
begin
 for i := 0 to componentCount -1 do
 begin
   if (Components[i] is TEdit) then
   begin
     (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
   end;
 end;
end;

procedure Tfrm_LOSTZ240P_CHILD.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ240P_CHILD.FormCreate(Sender: TObject);
begin
  {----------------------- ���� ���ø����̼� ���� ---------------------------}
   setEdtKeyPress;
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
  {   }
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
  //initSkinForm(SkinData1);
  initComboBoxWithZ0xx('Z050.dat', cmb_pl_cd_d, '', ' ',cmb_pl_cd);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ240P_CHILD.btn_CloseClick(Sender: TObject);
begin
   self.Hide;
   frm_LOSTZ240P.Enabled := True;
   frm_LOSTZ240P.Show;
   frm_LOSTZ240P.btn_InquiryClick(Sender);
end;



procedure Tfrm_LOSTZ240P_CHILD.FormShow(Sender: TObject);
var

 Button : TSpeedButton absolute Sender;
begin
  frm_LOSTZ240P.Enabled := False;
  if (Button.Name = 'btn_Add') then begin
    changeBtn(Self);

    btn_Add.Enabled := True;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := True;

    edt_gm_cd.Enabled := True;

    edt_gm_cd.Text :='';
    edt_Gm_Nm.Text :='';
    cmb_pl_cd.ItemIndex := 0;
    edt_ge_no.Text :='';
    edt_dp_nm.Text :='';
    edt_ps_nm.Text :='';
    edt_dm_nm.Text :='';
    edt_dm_ml.Text :='';
    edt_gm_tl.Text :='';
    edt_mt_no.Text :='';
    edt_dm_pt.Text :='';
    edt_dm_ju.Text :='';
    edt_dm_bo.Text :='';
    edt_bi_go.Text :='';

    self.Show;

    edt_gm_cd.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin
    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    edt_gm_cd.Enabled := False;

    edt_gm_cd.Text := frm_LOSTZ240P.grd_display.Cells[0,  frm_LOSTZ240P.grd_display.Row];
    edt_Gm_Nm.Text := frm_LOSTZ240P.grd_display.Cells[1,  frm_LOSTZ240P.grd_display.Row];
    cmb_pl_cd.ItemIndex := cmb_pl_cd.Items.IndexOf(findNameFromCode(PL_CD,cmb_pl_cd_d,cmb_pl_cd.Items.Count));
    edt_ge_no.Text := frm_LOSTZ240P.grd_display.Cells[4,  frm_LOSTZ240P.grd_display.Row];
    edt_dp_nm.Text := frm_LOSTZ240P.grd_display.Cells[5,  frm_LOSTZ240P.grd_display.Row];
    edt_ps_nm.Text := frm_LOSTZ240P.grd_display.Cells[6,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_nm.Text := frm_LOSTZ240P.grd_display.Cells[7,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_ml.Text := frm_LOSTZ240P.grd_display.Cells[10,  frm_LOSTZ240P.grd_display.Row];
    edt_gm_tl.Text := frm_LOSTZ240P.grd_display.Cells[8,  frm_LOSTZ240P.grd_display.Row];
    edt_mt_no.Text := frm_LOSTZ240P.grd_display.Cells[9,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_pt.EditText := frm_LOSTZ240P.grd_display.Cells[11, frm_LOSTZ240P.grd_display.Row];
    edt_dm_ju.Text := frm_LOSTZ240P.grd_display.Cells[12, frm_LOSTZ240P.grd_display.Row];
    edt_dm_bo.Text := frm_LOSTZ240P.grd_display.Cells[13, frm_LOSTZ240P.grd_display.Row];
    edt_bi_go.Text := frm_LOSTZ240P.grd_display.Cells[14, frm_LOSTZ240P.grd_display.Row];

    if Trim(GM_YN) = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
    end else
      rdo_Sh_No.Checked  := True;

     self.Show;

     edt_Gm_Nm.SelectAll;

  end else if (Button.Name = 'btn_Update') then  begin

    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    edt_gm_cd.Enabled := False;

    edt_gm_cd.Text := frm_LOSTZ240P.grd_display.Cells[0,  frm_LOSTZ240P.grd_display.Row];
    edt_Gm_Nm.Text := frm_LOSTZ240P.grd_display.Cells[1,  frm_LOSTZ240P.grd_display.Row];
    cmb_pl_cd.ItemIndex := cmb_pl_cd.Items.IndexOf(findNameFromCode(PL_CD,cmb_pl_cd_d,cmb_pl_cd.Items.Count));
    edt_ge_no.Text := frm_LOSTZ240P.grd_display.Cells[4,  frm_LOSTZ240P.grd_display.Row];
    edt_dp_nm.Text := frm_LOSTZ240P.grd_display.Cells[5,  frm_LOSTZ240P.grd_display.Row];
    edt_ps_nm.Text := frm_LOSTZ240P.grd_display.Cells[6,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_nm.Text := frm_LOSTZ240P.grd_display.Cells[7,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_ml.Text := frm_LOSTZ240P.grd_display.Cells[10,  frm_LOSTZ240P.grd_display.Row];
    edt_gm_tl.Text := frm_LOSTZ240P.grd_display.Cells[8,  frm_LOSTZ240P.grd_display.Row];
    edt_mt_no.Text := frm_LOSTZ240P.grd_display.Cells[9,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_pt.EditText := frm_LOSTZ240P.grd_display.Cells[11, frm_LOSTZ240P.grd_display.Row];
    edt_dm_ju.Text := frm_LOSTZ240P.grd_display.Cells[12, frm_LOSTZ240P.grd_display.Row];
    edt_dm_bo.Text := frm_LOSTZ240P.grd_display.Cells[13, frm_LOSTZ240P.grd_display.Row];
    edt_bi_go.Text := frm_LOSTZ240P.grd_display.Cells[14, frm_LOSTZ240P.grd_display.Row];

    if Trim(GM_YN) = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
    end else
      rdo_Sh_No.Checked := True;


     self.Show;
     edt_Gm_Nm.SelectAll;

  end else if (Button.Name = 'btn_Delete') then  begin

    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := True;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    edt_gm_cd.Text := frm_LOSTZ240P.grd_display.Cells[0,  frm_LOSTZ240P.grd_display.Row];
    edt_Gm_Nm.Text := frm_LOSTZ240P.grd_display.Cells[1,  frm_LOSTZ240P.grd_display.Row];
    cmb_pl_cd.ItemIndex := cmb_pl_cd.Items.IndexOf(findNameFromCode(PL_CD,cmb_pl_cd_d,cmb_pl_cd.Items.Count));
    edt_ge_no.Text := frm_LOSTZ240P.grd_display.Cells[4,  frm_LOSTZ240P.grd_display.Row];
    edt_dp_nm.Text := frm_LOSTZ240P.grd_display.Cells[5,  frm_LOSTZ240P.grd_display.Row];
    edt_ps_nm.Text := frm_LOSTZ240P.grd_display.Cells[6,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_nm.Text := frm_LOSTZ240P.grd_display.Cells[7,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_ml.Text := frm_LOSTZ240P.grd_display.Cells[10,  frm_LOSTZ240P.grd_display.Row];
    edt_gm_tl.Text := frm_LOSTZ240P.grd_display.Cells[8,  frm_LOSTZ240P.grd_display.Row];
    edt_mt_no.Text := frm_LOSTZ240P.grd_display.Cells[9,  frm_LOSTZ240P.grd_display.Row];
    edt_dm_pt.EditText := frm_LOSTZ240P.grd_display.Cells[11, frm_LOSTZ240P.grd_display.Row];
    edt_dm_ju.Text := frm_LOSTZ240P.grd_display.Cells[12, frm_LOSTZ240P.grd_display.Row];
    edt_dm_bo.Text := frm_LOSTZ240P.grd_display.Cells[13, frm_LOSTZ240P.grd_display.Row];
    edt_bi_go.Text := frm_LOSTZ240P.grd_display.Cells[14, frm_LOSTZ240P.grd_display.Row];

    if GM_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
    end else
      rdo_Sh_No.Checked := True;

     self.Show;

  end;
end;

procedure Tfrm_LOSTZ240P_CHILD.btn_AddClick(Sender: TObject);
var
  USYN : String;
  LABEL LIQUIDATION;
begin

    if Length(edt_gm_cd.Text) < 1 then begin
      ShowMessage('�Ѱ����ڵ� �� �Է��� �ֽʽÿ�.');
      exit;
    end;

    USYN := ' ';

   if rdo_Sh_Yes.Checked then begin
      USYN := 'Y';
   end else begin
      USYN := 'N';
   end;

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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ240P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR002', edt_Gm_Nm.Text  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', cmb_pl_cd_d[cmb_pl_cd.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', edt_ge_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', edt_dp_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', edt_ps_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', edt_dm_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', edt_dm_ml.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', edt_gm_tl.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR010', edt_mt_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR011', edt_dm_pt.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR012', edt_dm_ju.Text  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR013', edt_dm_bo.Text  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR014', edt_bi_go.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR015', USYN  )   < 0) then  goto LIQUIDATION;


    //���� ȣ��
	if not TMAX.Call('LOSTZ240P') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' ��� �Ϸ�';
         ShowMessage('���������� ��ϵǾ����ϴ�.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;


end;

procedure Tfrm_LOSTZ240P_CHILD.btn_UpdateClick(Sender: TObject);
var
  USYN : String;
  LABEL LIQUIDATION;
begin
   USYN := ' ';

   if rdo_Sh_Yes.Checked then begin
      USYN := 'Y';
   end else begin
      USYN := 'N';
   end;

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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ240P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR002', edt_Gm_Nm.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_pl_cd_d[cmb_pl_cd.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', edt_ge_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', edt_dp_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', edt_ps_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', edt_dm_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', edt_dm_ml.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', edt_gm_tl.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR010', edt_mt_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR011', edt_dm_pt.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR012', edt_dm_ju.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR013', edt_dm_bo.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR014', edt_bi_go.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR015', USYN  )   < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTZ240P') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' ����  �Ϸ�';
         ShowMessage('���������� �����Ǿ����ϴ�.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

end;

procedure Tfrm_LOSTZ240P_CHILD.btn_DeleteClick(Sender: TObject);
LABEL LIQUIDATION;
begin
  if MessageDlg('�����Ͻðڽ��ϱ� ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='������ ��ҵǾ����ϴ�';
      exit;
   end
   else
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

        //�����Է� �κ�
      if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF003','LOSTZ240P'      )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR001', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;


        //���� ȣ��
      if not TMAX.Call('LOSTZ240P') then
        begin
         if (TMAX.RecvString('INF011',0) = 'Y') then
           sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
         else
           MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
          goto LIQUIDATION;
        end
      else
        begin
            sts_Message.Panels[1].Text := ' ���� �Ϸ�';
             ShowMessage('���������� �����Ǿ����ϴ�.')
        end;

    LIQUIDATION:
      TMAX.InitBuffer;
      TMAX.FreeBuffer;
      TMAX.EndTMAX;
      TMAX.Disconnect;
end;

procedure Tfrm_LOSTZ240P_CHILD.btn_GPostno_InqClick(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin
if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit)) then
  begin
    if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
    else  mskEdt := Sender as TMaskEdit;

    if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = edt_dm_pt ) then
      begin
        callValue := 0;
        value1 := edt_dm_pt.Text;
      end;
    end;

  CreateMap;	//�����޸� ����
  self.ExecExternProg('LOSTZ800Q');
end;

function Tfrm_LOSTZ240P_CHILD.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  '1'
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
procedure Tfrm_LOSTZ240P_CHILD.Link_rtn (var Msg : TMessage);
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
          edt_dm_pt.Text        := smem^.po_no;			    //����(��ü��)
          edt_dm_ju.Text        := smem^.ju_so;	        //�𵨸�
          //msk_Gtl_No.Text        := smem^.ddd_no;	        //�ܸ����Ϸù�ȣ
        end;

      //if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //�����޸𸮸� ��� ��.
      CloseMapMain;
      smem:= nil;
    end;

    edt_dm_bo.SetFocus;

  end;
end;

procedure Tfrm_LOSTZ240P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frm_LOSTZ240P.Enabled := True;
   frm_LOSTZ240P.Show;
end;

procedure Tfrm_LOSTZ240P_CHILD.btn_resetClick(Sender: TObject);
begin
    edt_gm_cd.Text :='';
    edt_Gm_Nm.Text :='';
    cmb_pl_cd.ItemIndex := 0;
    edt_ge_no.Text :='';
    edt_dp_nm.Text :='';
    edt_ps_nm.Text :='';
    edt_dm_nm.Text :='';
    edt_dm_ml.Text :='';
    edt_gm_tl.Text :='';
    edt_mt_no.Text :='';
    edt_dm_pt.Text :='';
    edt_dm_ju.Text :='';
    edt_dm_bo.Text :='';
    edt_bi_go.Text :='';
end;

end.


