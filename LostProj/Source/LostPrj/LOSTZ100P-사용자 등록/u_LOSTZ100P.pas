{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ100P (사용자 등록)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 15
완료일	      : ####. ##. ##
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ100P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '사용자등록';
  PGM_ID  = 'LOSTZ100P';

type
  Tfrm_LOSTZ100P = class(TForm)
    pnl_Command: TPanel;
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Bevel16: TBevel;
    cmb_ugrp: TComboBox;
    edt_usnm: TEdit;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    msk_usid: TMaskEdit;
    msk_upwd: TMaskEdit;
    cmb_ulev: TComboBox;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    Label3: TLabel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_ResetClick(Sender: TObject);

  private
    { Private declarations }
    cmb_ugrp_d: TZ0xxArray;
    cmb_ulev_d: TZ0xxArray;
    procedure initStrGrid;

  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTZ100P: Tfrm_LOSTZ100P;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ100P.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTZ100P.enableComponents;
begin
  changeBtn(Self);

  btn_Add.Enabled := True;
  btn_Update.Enabled := True;
  btn_Delete.Enabled := True;
  btn_query.Enabled := False;

  msk_usid.Enabled := True;
  msk_upwd.Enabled := True;
  edt_usnm.Enabled := True;
  cmb_ugrp.Enabled := True;
  cmb_ulev.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTZ100P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 4;
    	RowHeights[0] := 21;

    	ColWidths[0] := 100;
		Cells[0,0] :='사용자ID';

    	ColWidths[1] := 200;
		Cells[1,0] :='사용자명';

      ColWidths[2] := 150;
		Cells[2,0] :='GROUP';

      ColWidths[3] := -1;
		Cells[3,0] :='LEVEL';

    end;
end;

procedure Tfrm_LOSTZ100P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ100P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ100P.FormCreate(Sender: TObject);
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
  {   }
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

  initStrGrid;	//그리드 초기화
  initComboBoxWithZ0xx('Z090.dat', cmb_ugrp_d, '', '',cmb_ugrp);
  initComboBoxWithZ0xx('Z091.dat', cmb_ulev_d, '', '',cmb_ulev);

  initSkinForm(SkinData1);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ100P.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTZ100P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

    btn_Update.Enabled:= True;
    btn_Delete.Enabled:= True;

	  //그리드 디스플레이
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //시작시변수 초기화
    totalCount :=0;
    grd_display.Cursor := crSQLWait;	//작업중....
    disableComponents;	//작업중 다른 기능 잠시 중지.

    //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	  TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server := 'KAIT_LOSTPRJ';

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

//반복 조회
INQUIRY:

    TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ100P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', msk_usid.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_usnm.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', msk_upwd.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_ugrp_d[cmb_ugrp.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_ulev_d[cmb_ulev.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ100P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

  //조회된 갯수
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := TMAX.RecvString('STR101',i); //사용자아이디
        	Cells[1,RowPos] := TMAX.RecvString('STR102',i); //사용자명
          Cells[2,RowPos] := TMAX.RecvString('STR104',i); //그룹
          Cells[3,RowPos] := TMAX.RecvString('STR105',i); //레벨
          
          Inc(RowPos);
        end;
    end;
    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;
LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
   enableComponents; 

end;

procedure Tfrm_LOSTZ100P.btn_AddClick(Sender: TObject);
 LABEL LIQUIDATION;
begin

  if ( not fChkLength(msk_usid,1,1,'사용자ID')) then Exit;
  if ( not fChkLength(edt_usnm,1,1,'사용자이름')) then Exit;
  if ( not fChkLength(msk_upwd,1,1,'비밀번호')) then Exit;


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
	if (TMAX.SendString('INF003','LOSTZ100P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', msk_usid.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_usnm.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', Get_EncStr(msk_upwd.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_ugrp_d[cmb_ugrp.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_ulev_d[cmb_ulev.ItemIndex].code) < 0) then  goto LIQUIDATION;


    //서비스 호출
	if not TMAX.Call('LOSTZ100P') then
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

procedure Tfrm_LOSTZ100P.grd_displayDblClick(Sender: TObject);
begin

    msk_usid.Text := grd_display.Cells[0, grd_display.Row];
    edt_usnm.Text := grd_display.Cells[1, grd_display.Row];
    msk_upwd.Text := '';
    cmb_ugrp.ItemIndex := cmb_ugrp.Items.IndexOf(grd_display.Cells[2, grd_display.Row]);
    cmb_ulev.ItemIndex := StrToInt(grd_display.Cells[3, grd_display.Row]);

    msk_upwd.SetFocus;
end;

procedure Tfrm_LOSTZ100P.btn_UpdateClick(Sender: TObject);
  LABEL LIQUIDATION;
begin


  if ( not fChkLength(msk_usid,1,1,'사용자ID')) then Exit;
  if ( not fChkLength(edt_usnm,1,1,'사용자이름')) then Exit;
 // if ( not fChkLength(msk_upwd,1,1,'비밀번호')) then Exit;


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
	if (TMAX.SendString('INF003','LOSTZ100P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', msk_usid.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_usnm.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', Get_EncStr(msk_upwd.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_ugrp_d[cmb_ugrp.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_ulev_d[cmb_ulev.ItemIndex].code) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ100P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;

    sts_Message.Panels[1].Text := ' 수정  완료';
    ShowMessage('성공적으로 수정되었습니다.');
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

   frm_LOSTZ100P.btn_InquiryClick(Sender);
   exit;
LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  enableComponents;
end;

procedure Tfrm_LOSTZ100P.btn_DeleteClick(Sender: TObject);
 LABEL LIQUIDATION;
begin
  if MessageDlg('삭제하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='삭제가 취소되었습니다';
      exit;
   end;
  if ( not fChkLength(msk_usid,1,1,'사용자ID')) then Exit;
  if ( not fChkLength(edt_usnm,1,1,'사용자이름')) then Exit;

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
	if (TMAX.SendString('INF003','LOSTZ100P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', msk_usid.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', Get_EncStr(msk_upwd.Text)) < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTZ100P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 삭제 완료';
         ShowMessage('성공적으로 삭제되었습니다.');

  // 삭제후 입력 필드 초기화 
  msk_usid.Text := '';
  msk_upwd.Text := '';
  edt_usnm.Text := '';
  cmb_ugrp.ItemIndex := -1;
  cmb_ulev.ItemIndex := 0;



  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  frm_LOSTZ100P.btn_InquiryClick(Sender);
  exit;

    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;


end;

procedure Tfrm_LOSTZ100P.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTZ100P.btn_ResetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);  

  btn_Update.Enabled:= False;
  btn_Delete.Enabled:= False;
  btn_excel.Enabled := False;
  btn_Print.Enabled := False;
  btn_query.Enabled := False;

  cmb_ugrp.ItemIndex := -1;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;




end;

end.
