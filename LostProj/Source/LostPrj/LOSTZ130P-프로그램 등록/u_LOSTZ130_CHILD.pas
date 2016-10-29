{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ130P_CHILD (���α׷� ���)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 16
�Ϸ���	      : ####. ##. ##
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTZ130_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

type
  Tfrm_LOSTZ130P_CHILD = class(TForm)
    pnl_Command: TPanel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label7: TLabel;
    Bevel3: TBevel;
    lbl_Inq_Str: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel8: TBevel;
    Label6: TLabel;
    edt_Cd_Nm: TEdit;
    edt_Cd_No: TEdit;
    Panel1: TPanel;
    rdo_Sh_Yes: TRadioButton;
    rdo_Sh_No: TRadioButton;
    sts_Message: TStatusBar;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    btn_Close: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    cmb_pg_Gu: TComboBox;
    Bevel4: TBevel;
    Label2: TLabel;
    cmb_pg_ty: TComboBox;
    Bevel5: TBevel;
    cmb_pg_st: TComboBox;
    Label3: TLabel;
    Bevel6: TBevel;
    Label4: TLabel;
    edt_Cd_Sm: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    cmb_pg_gu_d: TZ0xxArray;
    cmb_pg_ty_d: TZ0xxArray;
    cmb_pg_st_d: TZ0xxArray;

  public
    { Public declarations }
  end;

var
  frm_LOSTZ130P_CHILD: Tfrm_LOSTZ130P_CHILD;

implementation
uses u_LOSTZ130P ;
{$R *.dfm}



{-----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ130P_CHILD.FormCreate(Sender: TObject);
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

  initComboBoxWithZ0xx('Z092.dat', cmb_pg_gu_d, '', ' ',cmb_pg_Gu);
  initComboBoxWithZ0xx('Z093.dat', cmb_pg_ty_d, '', ' ',cmb_pg_Ty);
  initComboBoxWithZ0xx('Z096.dat', cmb_pg_st_d, '', ' ',cmb_pg_St);

   //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;


end;

procedure Tfrm_LOSTZ130P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin
  frm_LOSTZ130P.Enabled := False;
  if (Button.Name = 'btn_Add') then begin

     btn_Add.Enabled := true;
     btn_Update.Enabled := False;
     btn_Delete.Enabled := False;
     btn_Inquiry.Enabled := False;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     edt_Cd_No.Text := '';
     edt_Cd_Nm.Text := '';
     edt_Cd_Sm.Text := '';

     edt_Cd_Nm.Enabled := true;
     edt_Cd_No.Enabled := true;
     edt_Cd_Sm.Enabled := true;
     cmb_pg_Gu.Enabled := true;
     cmb_pg_ty.Enabled := true;
     cmb_pg_st.Enabled := true;
     self.Show;

     edt_Cd_No.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin

     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     edt_Cd_Nm.Enabled := true;
     edt_Cd_No.Enabled := false;
     edt_Cd_Sm.Enabled := true;
     cmb_pg_Gu.Enabled := true;
     cmb_pg_ty.Enabled := true;
     cmb_pg_st.Enabled := true;

     edt_Cd_No.Text := PG_ID;
     edt_Cd_Nm.Text := PG_NM;
     edt_Cd_Sm.Text := PG_SM;
     cmb_pg_Gu.ItemIndex := cmb_pg_Gu.Items.IndexOf(findNameFromCode(PG_GU,cmb_pg_gu_d,cmb_pg_gu.Items.Count));
     cmb_pg_ty.ItemIndex := cmb_pg_ty.Items.IndexOf(findNameFromCode(PG_TY,cmb_pg_ty_d,cmb_pg_ty.Items.Count));
     cmb_pg_st.ItemIndex := cmb_pg_st.Items.IndexOf(findNameFromCode(PG_ST,cmb_pg_st_d,cmb_pg_st.Items.Count));

     if US_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

  end else if (Button.Name = 'btn_Update') then  begin

     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     edt_Cd_Nm.Enabled := true;
     edt_Cd_No.Enabled := false;
     edt_Cd_Sm.Enabled := true;
     cmb_pg_Gu.Enabled := true;
     cmb_pg_ty.Enabled := true;
     cmb_pg_st.Enabled := true;

     edt_Cd_No.Text := PG_ID;
     edt_Cd_Nm.Text := PG_NM;
     edt_Cd_Sm.Text := PG_SM;
     cmb_pg_Gu.ItemIndex := cmb_pg_Gu.Items.IndexOf(findNameFromCode(PG_GU,cmb_pg_gu_d,cmb_pg_gu.Items.Count));
     cmb_pg_ty.ItemIndex := cmb_pg_ty.Items.IndexOf(findNameFromCode(PG_TY,cmb_pg_ty_d,cmb_pg_ty.Items.Count));
     cmb_pg_st.ItemIndex := cmb_pg_st.Items.IndexOf(findNameFromCode(PG_ST,cmb_pg_st_d,cmb_pg_st.Items.Count));


     if US_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;
  end else if (Button.Name = 'btn_Delete') then  begin
  
     btn_Add.Enabled := false;
     btn_Update.Enabled := false;
     btn_Delete.Enabled := true;
     btn_Inquiry.Enabled := false;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     edt_Cd_Nm.Enabled := False;
     edt_Cd_No.Enabled := False;
     edt_Cd_Sm.Enabled := False;
     cmb_pg_Gu.Enabled := False;
     cmb_pg_ty.Enabled := False;
     cmb_pg_st.Enabled := False;

     edt_Cd_No.Text := PG_ID;
     edt_Cd_Nm.Text := PG_NM;
     edt_Cd_Sm.Text := PG_SM;
     cmb_pg_Gu.ItemIndex := cmb_pg_Gu.Items.IndexOf(findNameFromCode(PG_GU,cmb_pg_gu_d,cmb_pg_gu.Items.Count));
     cmb_pg_ty.ItemIndex := cmb_pg_ty.Items.IndexOf(findNameFromCode(PG_TY,cmb_pg_ty_d,cmb_pg_ty.Items.Count));
     cmb_pg_st.ItemIndex := cmb_pg_st.Items.IndexOf(findNameFromCode(PG_ST,cmb_pg_st_d,cmb_pg_st.Items.Count));
  end;

   self.Show;
end;

procedure Tfrm_LOSTZ130P_CHILD.btn_CloseClick(Sender: TObject);
begin
  close;
  frm_LOSTZ130P.Enabled := True;
  frm_LOSTZ130P.Show;
end;



procedure Tfrm_LOSTZ130P_CHILD.btn_AddClick(Sender: TObject);
 var
 US_YN : String;

 LABEL LIQUIDATION;
begin

  if ( not fChkLength(edt_Cd_No,1,1,'���α׷�ID')) then Exit;
  if ( not fChkLength(edt_Cd_Nm,1,1,'���α׷���')) then Exit;
  if ( not fChkLength(edt_Cd_Sm,1,1,'���α׷����')) then Exit;

  US_YN := ' ';

   if rdo_Sh_Yes.Checked then begin
      US_YN := 'Y';
   end else begin
      US_YN := 'N';
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
	if (TMAX.SendString('INF003','LOSTZ130P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_Cd_No.Text  )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR002', edt_Cd_Nm.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', edt_Cd_Sm.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_pg_gu_d[cmb_pg_Gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', cmb_pg_ty_d[cmb_pg_Ty.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR006', cmb_pg_st_d[cmb_pg_St.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', US_YN            )   < 0) then  goto LIQUIDATION;


    //���� ȣ��
	if not TMAX.Call('LOSTZ130P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

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

procedure Tfrm_LOSTZ130P_CHILD.btn_UpdateClick(Sender: TObject);
var
  US_YN : String;
  LABEL LIQUIDATION;
begin
   US_YN := ' ';

   if rdo_Sh_Yes.Checked then begin
      US_YN := 'Y';
   end else begin
      US_YN := 'N';
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
	if (TMAX.SendString('INF003','LOSTZ130P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_Cd_No.Text  )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR002', edt_Cd_Nm.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', edt_Cd_Sm.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_pg_gu_d[cmb_pg_Gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', cmb_pg_ty_d[cmb_pg_Ty.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR006', cmb_pg_st_d[cmb_pg_St.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', US_YN            )   < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTZ130P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

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




procedure Tfrm_LOSTZ130P_CHILD.btn_DeleteClick(Sender: TObject);
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
      if (TMAX.SendString('INF003','LOSTZ130P'      )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR001', edt_Cd_No.Text  )   < 0) then  goto LIQUIDATION;


        //���� ȣ��
      if not TMAX.Call('LOSTZ130P') then
        begin
          sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

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

procedure Tfrm_LOSTZ130P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  frm_LOSTZ130P.Enabled := True;
  frm_LOSTZ130P.Show;
end;

end.
