unit u_LOSTZ220P_child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  monthEdit, ComObj;

const
  TITLE   = '우편번호등록';
  PGM_ID  = 'LOSTZ220P';

type
  Tfrm_LOSTZ220P_CHILD = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    msk_po_no: TMaskEdit;
    pnl_Command: TPanel;
    TMAX: TTMAX;
    Bevel6: TBevel;
    msk_sq_no: TMaskEdit;
    Label4: TLabel;
    msk_si_do: TEdit;
    Bevel7: TBevel;
    Label5: TLabel;
    Bevel8: TBevel;
    msk_gu_nm: TEdit;
    Label6: TLabel;
    Bevel9: TBevel;
    Label7: TLabel;
    msk_dn_nm: TEdit;
    Bevel10: TBevel;
    Label8: TLabel;
    msk_ri_nm: TEdit;
    Bevel11: TBevel;
    Label9: TLabel;
    msk_do_bj: TEdit;
    Bevel12: TBevel;
    Label10: TLabel;
    msk_sn_bj: TEdit;
    Bevel13: TBevel;
    msk_st_01: TEdit;
    Bevel14: TBevel;
    msk_st_02: TEdit;
    Bevel17: TBevel;
    msk_ed_01: TEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    msk_bd_nm: TEdit;
    msk_st_do: TEdit;
    Bevel4: TBevel;
    Label3: TLabel;
    msk_ed_do: TEdit;
    Bevel16: TBevel;
    Label16: TLabel;
    msk_ch_dt: TMaskEdit;
    Bevel18: TBevel;
    msk_ju_so: TEdit;
    Panel1: TPanel;
    rdo_Sh_Yes: TRadioButton;
    rdo_Sh_No: TRadioButton;
    Bevel19: TBevel;
    Label18: TLabel;
    Bevel20: TBevel;
    msk_bi_go: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel3: TBevel;
    Label2: TLabel;
    Bevel21: TBevel;
    Label20: TLabel;
    msk_ed_02: TEdit;
    Label14: TLabel;
    Label17: TLabel;
    Bevel5: TBevel;
    Label19: TLabel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    msk_dd_no: TComboBox;
    btn_reset: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
  private
    { Private declarations }
    msk_dd_no_d: TZ0xxArray;
  public
    { Public declarations }
  end;

var
  frm_LOSTZ220P_CHILD : Tfrm_LOSTZ220P_CHILD;

implementation

uses cpaklibm, u_LOSTZ220P;

{$R *.DFM}

procedure Tfrm_LOSTZ220P_CHILD.setEdtKeyPress;
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

procedure Tfrm_LOSTZ220P_CHILD.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}


procedure Tfrm_LOSTZ220P_CHILD.FormCreate(Sender: TObject);
begin
  {----------------------- 공통 어플리케이션 설정 ---------------------------}
   setEdtKeyPress;
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
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

	//initSkinForm(SkinData1); //common_lib.pas에 있다.
  initComboBoxWithZ0xx('Z073.dat', msk_dd_no_d, '', ' ',msk_dd_no);

  //스태터스바에 사용자 정보를 보여준다.

  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ220P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin

  btn_query.Enabled := False;
  frm_LOSTZ220P.Enabled := False;

  if (Button.Name = 'btn_Add') then begin
    changeBtn(Self);

    btn_Add.Enabled := true;
    btn_Update.Enabled := false;
    btn_Delete.Enabled := false;
    btn_Inquiry.Enabled := false;
    btn_Link.Enabled := False;
    btn_excel.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := True;
    btn_query.Enabled := False;

    msk_po_no.Enabled := True;
    msk_sq_no.Enabled := True;
    msk_si_do.Enabled := True;
    msk_gu_nm.Enabled := True;
    msk_dn_nm.Enabled := True;
    msk_ri_nm.Enabled := True;
    msk_do_bj.Enabled := True;
    msk_sn_bj.Enabled := True;
    msk_st_01.Enabled := True;
    msk_st_02.Enabled := True;
    msk_ed_01.Enabled := True;
    msk_ed_02.Enabled := True;
    msk_bd_nm.Enabled := True;
    msk_st_do.Enabled := True;
    msk_ed_do.Enabled := True;
    msk_ch_dt.Enabled := True;
    msk_ju_so.Enabled := True;
    msk_dd_no.Enabled := True;
    msk_bi_go.Enabled := True;

    msk_po_no.Text := '';
    msk_sq_no.Text := '';
    msk_si_do.Text := '';
    msk_gu_nm.Text := '';
    msk_dn_nm.Text := '';
    msk_ri_nm.Text := '';
    msk_do_bj.Text := '';
    msk_sn_bj.Text := '';
    msk_st_01.Text := '';
    msk_st_02.Text := '';
    msk_ed_01.Text := '';
    msk_ed_02.Text := '';
    msk_bd_nm.Text := '';
    msk_st_do.Text := '';
    msk_ed_do.Text := '';
    msk_ch_dt.Text := '';
    msk_ju_so.Text := '';
    msk_dd_no.ItemIndex := 0;
    msk_bi_go.Text := '';

    self.Show;

    msk_po_no.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin
    changeBtn(Self);

    btn_Add.Enabled := false;
    btn_Update.Enabled := true;
    btn_Delete.Enabled := false;
    btn_Inquiry.Enabled := false;
    btn_Link.Enabled := False;
    btn_excel.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;
    btn_query.Enabled := False;

    msk_po_no.Enabled := False;
    msk_sq_no.Enabled := False;
    msk_si_do.Enabled := True;
    msk_gu_nm.Enabled := True;
    msk_dn_nm.Enabled := True;
    msk_ri_nm.Enabled := True;
    msk_do_bj.Enabled := True;
    msk_sn_bj.Enabled := True;
    msk_st_01.Enabled := True;
    msk_st_02.Enabled := True;
    msk_ed_01.Enabled := True;
    msk_ed_02.Enabled := True;
    msk_bd_nm.Enabled := True;
    msk_st_do.Enabled := True;
    msk_ed_do.Enabled := True;
    msk_ch_dt.Enabled := True;
    msk_ju_so.Enabled := True;
    msk_dd_no.Enabled := True;
    msk_bi_go.Enabled := True;


    msk_po_no.Text := frm_LOSTZ220P.grd_display.Cells[0,  frm_LOSTZ220P.grd_display.Row];
    msk_sq_no.Text := frm_LOSTZ220P.grd_display.Cells[1,  frm_LOSTZ220P.grd_display.Row];  
    msk_si_do.Text := frm_LOSTZ220P.grd_display.Cells[2,  frm_LOSTZ220P.grd_display.Row];
    msk_gu_nm.Text := frm_LOSTZ220P.grd_display.Cells[3,  frm_LOSTZ220P.grd_display.Row];
    msk_dn_nm.Text := frm_LOSTZ220P.grd_display.Cells[4,  frm_LOSTZ220P.grd_display.Row];  
    msk_ri_nm.Text := frm_LOSTZ220P.grd_display.Cells[5,  frm_LOSTZ220P.grd_display.Row];
    msk_do_bj.Text := frm_LOSTZ220P.grd_display.Cells[6,  frm_LOSTZ220P.grd_display.Row];
    msk_sn_bj.Text := frm_LOSTZ220P.grd_display.Cells[7,  frm_LOSTZ220P.grd_display.Row];
    msk_st_01.Text := frm_LOSTZ220P.grd_display.Cells[8,  frm_LOSTZ220P.grd_display.Row];
    msk_st_02.Text := frm_LOSTZ220P.grd_display.Cells[9,  frm_LOSTZ220P.grd_display.Row];
    msk_ed_01.Text := frm_LOSTZ220P.grd_display.Cells[10, frm_LOSTZ220P.grd_display.Row];
    msk_ed_02.Text := frm_LOSTZ220P.grd_display.Cells[11, frm_LOSTZ220P.grd_display.Row];
    msk_bd_nm.Text := frm_LOSTZ220P.grd_display.Cells[12, frm_LOSTZ220P.grd_display.Row];
    msk_st_do.Text := frm_LOSTZ220P.grd_display.Cells[13, frm_LOSTZ220P.grd_display.Row];
    msk_ed_do.Text := frm_LOSTZ220P.grd_display.Cells[14, frm_LOSTZ220P.grd_display.Row];
    msk_ch_dt.Text := frm_LOSTZ220P.grd_display.Cells[15, frm_LOSTZ220P.grd_display.Row];
    msk_ju_so.Text := frm_LOSTZ220P.grd_display.Cells[16, frm_LOSTZ220P.grd_display.Row];
    msk_dd_no.ItemIndex := msk_dd_no.Items.IndexOf(findNameFromCode(DD_NO,msk_dd_no_d,msk_dd_no.Items.Count));
    msk_bi_go.Text := frm_LOSTZ220P.grd_display.Cells[19, frm_LOSTZ220P.grd_display.Row];

    if DL_YN = 'Y' then begin
     rdo_Sh_Yes.Checked := True;
    end else begin
     rdo_Sh_No.Checked := True;
    end;

    self.Show;

    msk_si_do.SelectAll;

  end else if (Button.Name = 'btn_Update') then  begin
    changeBtn(Self);

    btn_Add.Enabled := false;
    btn_Update.Enabled := true;
    btn_Delete.Enabled := false;
    btn_Inquiry.Enabled := false;
    btn_Link.Enabled := False;
    btn_excel.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;
    btn_query.Enabled := False;

    msk_po_no.Enabled := False;
    msk_sq_no.Enabled := False;
    msk_si_do.Enabled := True;
    msk_gu_nm.Enabled := True;
    msk_dn_nm.Enabled := True;
    msk_ri_nm.Enabled := True;
    msk_do_bj.Enabled := True;
    msk_sn_bj.Enabled := True;
    msk_st_01.Enabled := True;
    msk_st_02.Enabled := True;
    msk_ed_01.Enabled := True;
    msk_ed_02.Enabled := True;
    msk_bd_nm.Enabled := True;
    msk_st_do.Enabled := True;
    msk_ed_do.Enabled := True;
    msk_ch_dt.Enabled := True;
    msk_ju_so.Enabled := True;
    msk_dd_no.Enabled := True;
    msk_bi_go.Enabled := True;

    msk_po_no.Text := frm_LOSTZ220P.grd_display.Cells[0,  frm_LOSTZ220P.grd_display.Row];
    msk_sq_no.Text := frm_LOSTZ220P.grd_display.Cells[1,  frm_LOSTZ220P.grd_display.Row];  
    msk_si_do.Text := frm_LOSTZ220P.grd_display.Cells[2,  frm_LOSTZ220P.grd_display.Row];
    msk_gu_nm.Text := frm_LOSTZ220P.grd_display.Cells[3,  frm_LOSTZ220P.grd_display.Row];
    msk_dn_nm.Text := frm_LOSTZ220P.grd_display.Cells[4,  frm_LOSTZ220P.grd_display.Row];  
    msk_ri_nm.Text := frm_LOSTZ220P.grd_display.Cells[5,  frm_LOSTZ220P.grd_display.Row];
    msk_do_bj.Text := frm_LOSTZ220P.grd_display.Cells[6,  frm_LOSTZ220P.grd_display.Row];
    msk_sn_bj.Text := frm_LOSTZ220P.grd_display.Cells[7,  frm_LOSTZ220P.grd_display.Row];
    msk_st_01.Text := frm_LOSTZ220P.grd_display.Cells[8,  frm_LOSTZ220P.grd_display.Row];
    msk_st_02.Text := frm_LOSTZ220P.grd_display.Cells[9,  frm_LOSTZ220P.grd_display.Row];
    msk_ed_01.Text := frm_LOSTZ220P.grd_display.Cells[10, frm_LOSTZ220P.grd_display.Row];
    msk_ed_02.Text := frm_LOSTZ220P.grd_display.Cells[11, frm_LOSTZ220P.grd_display.Row];
    msk_bd_nm.Text := frm_LOSTZ220P.grd_display.Cells[12, frm_LOSTZ220P.grd_display.Row];
    msk_st_do.Text := frm_LOSTZ220P.grd_display.Cells[13, frm_LOSTZ220P.grd_display.Row];
    msk_ed_do.Text := frm_LOSTZ220P.grd_display.Cells[14, frm_LOSTZ220P.grd_display.Row];
    msk_ch_dt.Text := frm_LOSTZ220P.grd_display.Cells[15, frm_LOSTZ220P.grd_display.Row];
    msk_ju_so.Text := frm_LOSTZ220P.grd_display.Cells[16, frm_LOSTZ220P.grd_display.Row];
    msk_dd_no.ItemIndex := msk_dd_no.Items.IndexOf(findNameFromCode(DD_NO,msk_dd_no_d,msk_dd_no.Items.Count));
    msk_bi_go.Text := frm_LOSTZ220P.grd_display.Cells[19, frm_LOSTZ220P.grd_display.Row];

    if DL_YN = 'Y' then begin
     rdo_Sh_Yes.Checked := True;
    end else begin
     rdo_Sh_No.Checked := True;
    end;

    self.Show;

    msk_si_do.SelectAll;


  end else if (Button.Name = 'btn_Delete') then  begin
    changeBtn(Self);
  
    btn_Add.Enabled := False;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := True;
    btn_Inquiry.Enabled := False;
    btn_Link.Enabled := False;
    btn_excel.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;
    btn_query.Enabled := False;

    msk_po_no.Enabled := False;
    msk_sq_no.Enabled := False;
    msk_si_do.Enabled := False;
    msk_gu_nm.Enabled := False;
    msk_dn_nm.Enabled := False;
    msk_ri_nm.Enabled := False;
    msk_do_bj.Enabled := False;
    msk_sn_bj.Enabled := False;
    msk_st_01.Enabled := False;
    msk_st_02.Enabled := False;
    msk_ed_01.Enabled := False;
    msk_ed_02.Enabled := False;
    msk_bd_nm.Enabled := False;
    msk_st_do.Enabled := False;
    msk_ed_do.Enabled := False;
    msk_ch_dt.Enabled := False;
    msk_ju_so.Enabled := False;
    msk_dd_no.Enabled := False;
    msk_bi_go.Enabled := False;

    msk_po_no.Text := frm_LOSTZ220P.grd_display.Cells[0,  frm_LOSTZ220P.grd_display.Row];
    msk_sq_no.Text := frm_LOSTZ220P.grd_display.Cells[1,  frm_LOSTZ220P.grd_display.Row];  
    msk_si_do.Text := frm_LOSTZ220P.grd_display.Cells[2,  frm_LOSTZ220P.grd_display.Row];
    msk_gu_nm.Text := frm_LOSTZ220P.grd_display.Cells[3,  frm_LOSTZ220P.grd_display.Row];
    msk_dn_nm.Text := frm_LOSTZ220P.grd_display.Cells[4,  frm_LOSTZ220P.grd_display.Row];  
    msk_ri_nm.Text := frm_LOSTZ220P.grd_display.Cells[5,  frm_LOSTZ220P.grd_display.Row];
    msk_do_bj.Text := frm_LOSTZ220P.grd_display.Cells[6,  frm_LOSTZ220P.grd_display.Row];
    msk_sn_bj.Text := frm_LOSTZ220P.grd_display.Cells[7,  frm_LOSTZ220P.grd_display.Row];
    msk_st_01.Text := frm_LOSTZ220P.grd_display.Cells[8,  frm_LOSTZ220P.grd_display.Row];
    msk_st_02.Text := frm_LOSTZ220P.grd_display.Cells[9,  frm_LOSTZ220P.grd_display.Row];
    msk_ed_01.Text := frm_LOSTZ220P.grd_display.Cells[10, frm_LOSTZ220P.grd_display.Row];
    msk_ed_02.Text := frm_LOSTZ220P.grd_display.Cells[11, frm_LOSTZ220P.grd_display.Row];
    msk_bd_nm.Text := frm_LOSTZ220P.grd_display.Cells[12, frm_LOSTZ220P.grd_display.Row];
    msk_st_do.Text := frm_LOSTZ220P.grd_display.Cells[13, frm_LOSTZ220P.grd_display.Row];
    msk_ed_do.Text := frm_LOSTZ220P.grd_display.Cells[14, frm_LOSTZ220P.grd_display.Row];
    msk_ch_dt.Text := frm_LOSTZ220P.grd_display.Cells[15, frm_LOSTZ220P.grd_display.Row];
    msk_ju_so.Text := frm_LOSTZ220P.grd_display.Cells[16, frm_LOSTZ220P.grd_display.Row];
    msk_dd_no.Text := frm_LOSTZ220P.grd_display.Cells[17, frm_LOSTZ220P.grd_display.Row];
    msk_bi_go.Text := frm_LOSTZ220P.grd_display.Cells[19, frm_LOSTZ220P.grd_display.Row];

     if DL_YN = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

     self.Show;

  end;
end;

procedure Tfrm_LOSTZ220P_CHILD.btn_CloseClick(Sender: TObject);
begin

  frm_LOSTZ220P.Enabled := True;
  frm_LOSTZ220P.Show;
   close;
end;

procedure Tfrm_LOSTZ220P_CHILD.btn_AddClick(Sender: TObject);
var
  DL_YN : String;
  LABEL LIQUIDATION;
begin

    if Length(msk_po_no.Text) < 1 then begin
      ShowMessage('우편번호 를 입력해 주십시오.');
      exit;
    end;

    if Length(msk_sq_no.Text) < 1 then begin
      ShowMessage('일련번호 를 입력해 주십시오.');
      exit;
    end;

    DL_YN := ' ';

   if rdo_Sh_Yes.Checked then begin
      DL_YN := 'Y';
   end else begin
      DL_YN := 'N';
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
	if (TMAX.SendString('INF003','LOSTZ220P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR101', msk_po_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR102', msk_sq_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR103', msk_si_do.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR104', msk_gu_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR105', msk_dn_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR106', msk_ri_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR107', msk_do_bj.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR108', msk_sn_bj.Text  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR109', msk_st_01.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR110', msk_st_02.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR111', msk_ed_01.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR112', msk_ed_02.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR113', msk_bd_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR114', msk_st_do.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR115', msk_ed_do.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR116', msk_ch_dt.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR117', msk_ju_so.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR118',  msk_dd_no_d[msk_dd_no.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR119', DL_YN           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR120', msk_bi_go.Text  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ220P') then
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

procedure Tfrm_LOSTZ220P_CHILD.btn_UpdateClick(Sender: TObject);
var
  DL_YN : String;
  LABEL LIQUIDATION;
begin

    DL_YN := ' ';

   if rdo_Sh_Yes.Checked then begin
      DL_YN := 'Y';
   end else begin
      DL_YN := 'N';
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
	if (TMAX.SendString('INF003','LOSTZ220P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR101', msk_po_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR102', msk_sq_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR103', msk_si_do.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR104', msk_gu_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR105', msk_dn_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR106', msk_ri_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR107', msk_do_bj.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR108', msk_sn_bj.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR109', msk_st_01.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR110', msk_st_02.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR111', msk_ed_01.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR112', msk_ed_02.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR113', msk_bd_nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR114', msk_st_do.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR115', msk_ed_do.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR116', msk_ch_dt.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR117', msk_ju_so.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR118',  msk_dd_no_d[msk_dd_no.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR119', DL_YN           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR120', msk_bi_go.Text  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ220P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 수정 완료';
         ShowMessage('성공적으로 수정 되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

end;

procedure Tfrm_LOSTZ220P_CHILD.btn_DeleteClick(Sender: TObject);
LABEL LIQUIDATION;
begin
  if MessageDlg('삭제하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='삭제가 취소되었습니다';
      exit;
   end
   else
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
	if (TMAX.SendString('INF003','LOSTZ220P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR101', msk_po_no.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR102', msk_sq_no.Text  )   < 0) then  goto LIQUIDATION;


    //서비스 호출
	if not TMAX.Call('LOSTZ220P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 삭제 완료';
         ShowMessage('성공적으로 삭제 되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

end;

procedure Tfrm_LOSTZ220P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTZ220P.Enabled := True;
  frm_LOSTZ220P.Show;
end;

procedure Tfrm_LOSTZ220P_CHILD.btn_resetClick(Sender: TObject);
begin
    changeBtn(Self);

    btn_Add.Enabled := true;
    btn_Update.Enabled := false;
    btn_Delete.Enabled := false;
    btn_Inquiry.Enabled := false;
    btn_Link.Enabled := False;
    btn_excel.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := True;
    btn_query.Enabled := False;
    
    msk_po_no.Text := '';
    msk_sq_no.Text := '';
    msk_si_do.Text := '';
    msk_gu_nm.Text := '';
    msk_dn_nm.Text := '';
    msk_ri_nm.Text := '';
    msk_do_bj.Text := '';
    msk_sn_bj.Text := '';
    msk_st_01.Text := '';
    msk_st_02.Text := '';
    msk_ed_01.Text := '';
    msk_ed_02.Text := '';
    msk_bd_nm.Text := '';
    msk_st_do.Text := '';
    msk_ed_do.Text := '';
    msk_ch_dt.Text := '';
    msk_ju_so.Text := '';
    msk_dd_no.ItemIndex := 0;
    msk_bi_go.Text := '';

end;

end.
