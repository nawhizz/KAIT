{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ150P (메뉴 등록)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 19
완료일	      : ####. ##. ##
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}


unit u_LOSTZ150P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ150P_pop, ComObj;

type
  Tfrm_LOSTZ150P_child = class(TForm)
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cmb_mu_gu: TComboBox;
    cmb_pg_st: TComboBox;
    edt_mu_nv: TEdit;
    edt_mu_sv: TEdit;
    edt_mu_nm: TEdit;
    edt_pg_id: TEdit;
    edt_mu_sq: TEdit;
    Panel2: TPanel;
    rdo_Sh_Yes: TRadioButton;
    rdo_Sh_No: TRadioButton;
    btn1: TBitBtn;
    sts_Message: TStatusBar;
    edt_pg_nm: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure edt_pg_idKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_mu_nvKeyPress(Sender: TObject; var Key: Char);
    procedure edt_mu_svKeyPress(Sender: TObject; var Key: Char);
    procedure cmb_pg_stChange(Sender: TObject);
    procedure edt_mu_sqKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cmb_mu_gu_d: TZ0xxArray;
    cmb_pg_st_d: TZ0xxArray;
  public
    { Public declarations }
  end;

var

  PG_ID : String;
  
  frm_LOSTZ150P_child: Tfrm_LOSTZ150P_child;

implementation
uses u_LOSTZ150P;
{$R *.dfm}

procedure Tfrm_LOSTZ150P_child.FormCreate(Sender: TObject);
begin
{   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
}
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

    //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);


  initComboBoxWithZ0xx('Z094.dat', cmb_mu_gu_d, '', ' ',cmb_mu_gu);
  initComboBoxWithZ0xx('Z095.dat', cmb_pg_st_d, '', ' ',cmb_pg_st);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ150P_child.btn_CloseClick(Sender: TObject);
begin
  close;
  frm_LOSTZ150P.Enabled := True;
  frm_LOSTZ150P.Show;
  frm_LOSTZ150P.btn_InquiryClick(Sender);
end;


procedure Tfrm_LOSTZ150P_child.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin

  cmb_pg_st.ItemIndex := 2;
  frm_LOSTZ150P.Enabled := False;
  if (Button.Name = 'btn_Add') then begin

     btn_Add.Enabled := true;
     btn_Update.Enabled := False;
     btn_Delete.Enabled := False;
     btn_Inquiry.Enabled := False;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;


     cmb_mu_gu.Enabled := True;
     edt_mu_nv.Enabled := True;
     edt_mu_sv.Enabled := True;
     edt_mu_nm.Enabled := True;
     edt_pg_id.Enabled := True;
     cmb_pg_st.Enabled := True;
     edt_mu_sq.Enabled := True;

     edt_mu_nv.Text := '';
     edt_mu_sv.Text := '';
     edt_mu_nm.Text := '';
     edt_pg_id.Text := '';
     edt_pg_nm.Text := '';
     edt_mu_sq.Text := '';

     self.Show;

     cmb_mu_gu.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin

     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     cmb_mu_gu.Enabled := False;
     edt_mu_nv.Enabled := False;
     edt_mu_sv.Enabled := False;
     edt_pg_nm.Enabled := False;

     cmb_mu_gu.ItemIndex := cmb_mu_gu.Items.IndexOf(findNameFromCode(MU_GU,cmb_mu_gu_d,cmb_mu_gu.Items.Count));
     edt_mu_nv.Text := MU_MV;
     edt_mu_sv.Text := MU_SV;
     edt_mu_nm.Text := MU_NM;
     edt_pg_id.Text := PG_ID1;
     edt_pg_nm.Text := PG_NM;
     cmb_pg_st.ItemIndex := cmb_pg_st.Items.IndexOf(findNameFromCode(MU_TY,cmb_pg_st_d,cmb_pg_st.Items.Count));
     edt_mu_sq.Text := MU_SQ;

     if US_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

     self.Show;

     edt_mu_nm.SelectAll;

  end else if (Button.Name = 'btn_Update') then  begin

     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     cmb_mu_gu.Enabled := False;
     edt_mu_nv.Enabled := False;
     edt_mu_sv.Enabled := False;
     edt_pg_nm.Enabled := False;

     cmb_mu_gu.ItemIndex := cmb_mu_gu.Items.IndexOf(findNameFromCode(MU_GU,cmb_mu_gu_d,cmb_mu_gu.Items.Count));
     edt_mu_nv.Text := MU_MV;
     edt_mu_sv.Text := MU_SV;
     edt_mu_nm.Text := MU_NM;
     edt_pg_id.Text := PG_ID1;
     edt_pg_nm.Text := PG_NM;
     cmb_pg_st.ItemIndex := cmb_pg_st.Items.IndexOf(findNameFromCode(MU_TY,cmb_pg_st_d,cmb_pg_st.Items.Count));
     edt_mu_sq.Text := MU_SQ;

     if US_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

     self.Show;

     edt_mu_nm.SelectAll;

  end else if (Button.Name = 'btn_Delete') then  begin
  
     btn_Add.Enabled := false;
     btn_Update.Enabled := false;
     btn_Delete.Enabled := true;
     btn_Inquiry.Enabled := false;
     btn_excel.Enabled := False;
     btn_Print.Enabled := False;
     btn_Link.Enabled := False;

     cmb_mu_gu.Enabled := False;
     edt_mu_nv.Enabled := False;
     edt_mu_sv.Enabled := False;
     edt_mu_nm.Enabled := False;
     edt_pg_id.Enabled := False;
     cmb_pg_st.Enabled := False;
     edt_mu_sq.Enabled := False;
     edt_pg_nm.Enabled := False;

     cmb_mu_gu.ItemIndex := cmb_mu_gu.Items.IndexOf(findNameFromCode(MU_GU,cmb_mu_gu_d,cmb_mu_gu.Items.Count));
     edt_mu_nv.Text := MU_MV;
     edt_mu_sv.Text := MU_SV;
     edt_mu_nm.Text := MU_NM;
     edt_pg_id.Text := PG_ID1;
     edt_pg_nm.Text := PG_NM;
     cmb_pg_st.ItemIndex := cmb_pg_st.Items.IndexOf(findNameFromCode(MU_TY,cmb_pg_st_d,cmb_pg_st.Items.Count));
     edt_mu_sq.Text := MU_SQ;

     if US_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

     self.Show;

     edt_mu_nv.SelectAll;

  end;


end;

procedure Tfrm_LOSTZ150P_child.btn1Click(Sender: TObject);
begin
  PG_ID := edt_pg_id.Text;
  frm_LOSTZ150P_pop.Show;
end;

procedure Tfrm_LOSTZ150P_child.btn_AddClick(Sender: TObject);
 var
 US_YN : String;
 LABEL LIQUIDATION;
begin
  if ( not fChkLength(edt_mu_nv,1,1,'중분류')) then Exit;
  if ( not fChkLength(edt_mu_sv,1,1,'소분류')) then Exit;
  if cmb_pg_st.Items.Strings[cmb_pg_st.ItemIndex] <> '분리선' then
  begin
    if ( not fChkLength(edt_mu_nm,1,1,'메뉴명')) then Exit;
    if ( not fChkLength(edt_pg_id,1,1,'프로그램ID')) then Exit;
  end;

  if ( not fChkLength(edt_mu_sq,1,1,'메뉴순번')) then Exit;

  US_YN := ' ';

   if rdo_Sh_Yes.Checked then begin
      US_YN := 'Y';
   end else begin
      US_YN := 'N';
   end;

 //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
        goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX 시작에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ150P'      )   < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', cmb_mu_gu_d[cmb_mu_gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT001', StrtoInt(edt_mu_nv.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT002', StrtoInt(edt_mu_sv.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_mu_nm.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', edt_pg_id.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_pg_st_d[cmb_pg_st.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT003', StrtoInt(edt_mu_sq.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', US_YN          ) < 0) then  goto LIQUIDATION;


    //서비스 호출
	if not TMAX.Call('LOSTZ150P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 등록 완료';
         ShowMessage('성공적으로 등록되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  

end;

procedure Tfrm_LOSTZ150P_child.btn_UpdateClick(Sender: TObject);
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

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
        goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX 시작에 실패 하였습니다.');
        goto LIQUIDATION;
	end;



    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ150P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', cmb_mu_gu_d[cmb_mu_gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT001', StrtoInt(edt_mu_nv.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT002', StrtoInt(edt_mu_sv.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_mu_nm.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', edt_pg_id.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_pg_st_d[cmb_pg_st.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT003', StrtoInt(edt_mu_sq.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', USYN          ) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ150P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 수정  완료';
         ShowMessage('성공적으로 수정되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTZ150P_child.btn_DeleteClick(Sender: TObject);
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

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
        goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX 시작에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ150P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', cmb_mu_gu_d[cmb_mu_gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT001', StrtoInt(edt_mu_nv.Text )) < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT002', StrtoInt(edt_mu_sv.Text )) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ150P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 삭제 완료';
         ShowMessage('성공적으로 삭제되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTZ150P_child.edt_pg_idKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key = #13 then begin
  frm_LOSTZ150P_child.btn1Click(Sender);
 end;
end;

procedure Tfrm_LOSTZ150P_child.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTZ150P.Enabled := True;
  frm_LOSTZ150P.Show;
end;

procedure Tfrm_LOSTZ150P_child.edt_mu_nvKeyPress(Sender: TObject;
  var Key: Char);

begin
  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTZ150P_child.edt_mu_svKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTZ150P_child.cmb_pg_stChange(Sender: TObject);
begin
 if  cmb_pg_st.ItemIndex = 1 then begin
  edt_mu_nm.Text := '';
  edt_mu_nm.Enabled := False;

  edt_pg_id.Text :='';
  edt_pg_nm.Text :='';
  edt_pg_id.Enabled := False;
  edt_pg_nm.Enabled := False;
  btn1.Enabled := False;
 end else if  cmb_pg_st.ItemIndex = 0 then begin
  edt_pg_id.Text :='';
  edt_pg_nm.Text :='';
  edt_pg_id.Enabled := False;
  edt_pg_nm.Enabled := False;
  edt_mu_nm.Enabled := True;
  btn1.Enabled := False;
 end else if  cmb_pg_st.ItemIndex = 2 then begin
  edt_pg_id.Text :='';
  edt_pg_nm.Text :='';
  edt_mu_nm.Text := '';
  edt_mu_nm.Enabled := True;
  edt_pg_id.Enabled := True;
  edt_pg_nm.Enabled := True;
  btn1.Enabled := True;
 end;
end;

procedure Tfrm_LOSTZ150P_child.edt_mu_sqKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;

end;

end.
