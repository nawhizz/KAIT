{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ850Q (새우편번호 주소 조회)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2015. 06.18
완료일	      : 2015. 06.23
프로그램 개요 : 새우편번호 주소 자료를 조회한다.

-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	          :
-----------------------------------------------------------------------------*}
unit u_LOSTZ850Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud;

type
  Tfrm_LOSTZ850Q = class(TForm)
    Bevel2          : TBevel;
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
    Bevel3: TBevel;
    Label2: TLabel;
    edt_search: TEdit;
    pnl1: TPanel;
    rdo_Gubun1: TRadioButton;
    rdo_Gubun2: TRadioButton;
    rdo_Gubun3: TRadioButton;
    rdo_Gubun4: TRadioButton;
    rdo_Gubun5: TRadioButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    cmb_Provnm: TComboBox;
    cmb_Ccwnm: TComboBox;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure edt_searchKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure grd_displayKeyPress(Sender: TObject; var Key: Char);
    procedure cmb_ProvnmChange(Sender: TObject);
    procedure rdo_Gubun1Click(Sender: TObject);
    procedure rdo_Gubun2Click(Sender: TObject);
    procedure rdo_Gubun3Click(Sender: TObject);
    procedure rdo_Gubun4Click(Sender: TObject);
    procedure rdo_Gubun5Click(Sender: TObject);
    procedure cmb_CcwnmChange(Sender: TObject);
    procedure edt_searchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    isData:Boolean;

  public
    { Public declarations }
     procedure initStrGrid;

  end;

var
  frm_LOSTZ850Q: Tfrm_LOSTZ850Q;

  cmb_Provnm_d   : TZ0xxArray;
  cmb_Ccwnm_d    : TZ0xxArray;

implementation
{$R *.DFM}

procedure Tfrm_LOSTZ850Q.initStrGrid;
begin
	with grd_display do begin
    RowCount := 2;
    ColCount := 5;
    RowHeights[0] := 21;

    ColWidths[0]  := 55;
    Cells[0,0]    :='우편번호';

    ColWidths[1]  := 373;
    Cells[1,0]    :='도로명주소';

    ColWidths[2]  := 272;
    Cells[2,0]    :='지번주소';

    ColWidths[3]  := 85;
    Cells[3,0]    :='관련지번여부';

    ColWidths[4]  := 0;
    Cells[4,0]    :='5자리우편번호사용';

    // 그리드 데이타 clear
    Cells[0,1]    :='';
    Cells[1,1]    :='';
    Cells[2,1]    :='';
    Cells[3,1]    :='';
    Cells[4,1]    :='';

  end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ850Q.FormCreate(Sender: TObject);

begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.

//	if ParamCount < 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
//    	ShowMessage('전달된 파라메터 개수오류!');
//        PostMessage(self.Handle, WM_QUIT, 0,0);
//        exit;
//    end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294'; //ParamStr(2);
//    common_username   := '정호영';
//    ParamStr(3);
//    common_usergroup  := 'KAIT'; //ParamStr(4);

    initSkinForm(SkinData1);

    // 공통코드 콤보세팅
    initComboBoxWithZ0xx('Z020.dat', cmb_Provnm_d, '전체','',cmb_Provnm);
    initComboBoxWithZ0xx('Z021.dat', cmb_Ccwnm_d , '전체','',cmb_Ccwnm, '**', '', '' );

    initStrGrid;	//그리드 초기화

    isData:= False;  //스트링그리드에 데이터가 없다.

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ850Q.btn_CloseClick(Sender: TObject);
begin
    close;
end;


procedure Tfrm_LOSTZ850Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 0, 0);

end;

procedure Tfrm_LOSTZ850Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1,  totalCount:Integer;
    RowPos:Integer;
    STR001,STR002,STR003,STR004,STR005,STR006:String;

    strList_Text  : TStrings;
    strList_Text2 : TStrings;

    Label LIQUIDATION;
    Label INQUIRY;
begin

  //그리드 디스플레이

  RowPos:= 1;	//그리드 레코드 포지션
  grd_display.RowCount := 2;
  grd_display.FixedRows:=1;

  grd_display.Cursor := crSQLWait;	//작업중....
  //disableComponents;	//작업중 다른 기능 잠시 중지.

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

//내역조회
INQUIRY:


	TMAX.InitBuffer;

	STR001:=' ';
	STR002:=' ';
	STR003:=' ';
	STR004:=' ';

  totalCount := 0;

  if (rdo_Gubun1.Checked = True) then STR001 := '1'
  else if (rdo_Gubun2.Checked = True) then STR001 := '2'
  else if (rdo_Gubun3.Checked = True) then STR001 := '3'
  else if (rdo_Gubun4.Checked = True) then STR001 := '4'
  else if (rdo_Gubun5.Checked = True) then STR001 := '5';

  if (cmb_Provnm_d[cmb_Provnm.ItemIndex].name = '전체') then
     STR002 := ''
  else
     STR002 := cmb_Provnm_d[cmb_Provnm.ItemIndex].name;

  if (cmb_Provnm_d[cmb_Ccwnm.ItemIndex].name = '전체') then
     STR003 := ''
  else
     STR003 := cmb_Provnm_d[cmb_Ccwnm.ItemIndex].name;

  strList_Text := TStringList.Create;
  strList_Text.Clear;

  strList_Text2 := TStringList.Create;
  strList_Text2.Clear;

  //Showmessage('edt_search.Text = ' + edt_search.Text);
  strList_Text := UDF_GetToken(Trim(edt_search.Text) , ' ');
  STR004 := strList_Text[00];
  //Showmessage('strList_Text.Count = ' + IntToStr(strList_Text.Count));
  //Showmessage('strList_Text[00] = ' + strList_Text[00]);

  if strList_Text.Count > 1 then
  begin
     strList_Text2 := UDF_GetToken(Trim(strList_Text[01]) , '-');

     if strList_Text2.Count = 1 then
     begin
        STR005 := strList_Text2[00];
     end
     else
     begin
        STR005 := strList_Text2[00];
        STR006 := strList_Text2[01];
     end;
  end;

  //ShowMessage('STR004 = ' + STR004);
  //ShowMessage('STR005 = ' + STR005);
  //ShowMessage('STR006 = ' + STR006);

  //STR004 := '고인돌길';
  //STR005 := '';
  //STR006 := '';

  //공통입력 부분
  if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF003','LOSTZ850Q'      ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ850Q') then goto LIQUIDATION;

  count1 := TMAX.RecvInteger('INT100',0);

  if count1 > 0 then isData := True;	//스트링그리드에 데이터가 있다.

  if count1 > 0 then
    totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);	// 우편번호
      Cells[1,RowPos] := TMAX.RecvString('STR102',i);	// 도로명주소
      Cells[2,RowPos] := TMAX.RecvString('STR103',i);	// 지번주소
      Cells[3,RowPos] := TMAX.RecvString('STR104',i);	// 기존우편번호
      Cells[4,RowPos] := TMAX.RecvString('STR105',i);	// 5자리우편번호사용여부

      Inc(RowPos);
    end;

  end;
  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';

  Application.ProcessMessages;

   // count2 := TMAX.RecvInteger('INT100',0);
   // if count1 = count2 then
   // 	goto INQUIRY;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//작업완료

  if isData then grd_display.RowCount := grd_display.RowCount -1;

  if isData then
    grd_display.SetFocus	//스트링 그리드로 포커스 이동
  else
    edt_search.SetFocus;


end;


procedure Tfrm_LOSTZ850Q.btn_LinkClick(Sender: TObject);
var
	smem:TPSharedMem;
  zip_no:String;

begin

	if not isData then begin 			//스트링 그리드에 데이터가 없으면
    	edt_search.SetFocus;	//'검색조건' 콤보박스로 이동
      exit;
  end;

  if (Trim(grd_display.Cells[4,grd_display.Row]) = 'Y') then
        zip_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row]))  //5자리우편번호
  else  zip_no   := delHyphen(Trim(grd_display.Cells[3,grd_display.Row])); //6자리우편번호

  //공유메모리를 얻는다.
	smem:= OpenMap;

	if smem <> nil then
    begin
        Lock;  //동시 접속방지

        //smem^.po_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row])); //우편번호
        smem^.po_no   := zip_no; //우편번호
        smem^.ju_so   := Trim(grd_display.Cells[1,grd_display.Row]); // 도로명주소
        smem^.ddd_no  := Trim(grd_display.Cells[2,grd_display.Row]); // 지번주소

        UnLock;
    end;

    PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 1, 0);

   CloseMap;

   PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure Tfrm_LOSTZ850Q.edt_searchKeyPress(Sender: TObject;
  var Key: Char);
begin
//	if Key <> #13 then 	//엔터키가 아니면
//    	exit;
//
//  btn_InquiryClick(Sender);

//    ShowMessage('Key = ' + Key);

    if Key = #13 then 	//엔터키면
    begin
      btn_InquiryClick(Sender);
    end;


end;

procedure Tfrm_LOSTZ850Q.FormShow(Sender: TObject);
var
  s : string;
  i : integer;
begin

  changeBtn(Self);

  btn_reset.Enabled := False;
  btn_excel.Enabled := False;

  // 부모창에서 데이터를 넘겨받으면 바로 조회
  if(ParamStr(8) <> '') then
  begin
    edt_search.Text      := StringReplace(Trim(ParamStr(8)),'|','',[rfReplaceAll]);
    s := Trim(edt_search.Text);
    // 2015.06.29 유영배 추가
    if (TryStrToInt(s, i) = True) then
    begin
      if (Length(s) = 5) then
      begin
         rdo_Gubun4.Checked := True;
      end
      else if (Length(s) = 6) then
      begin
         rdo_Gubun4.Checked := True;
      end
      else
      begin
         rdo_Gubun3.Checked := True;
      end;
    end;

    rdo_Gubun3.Checked := True;

    edt_search.Text := s;
    edt_search.SelectAll;
    Self.btn_InquiryClick(Sender);
  end else
  begin
    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.grd_displayKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_LinkClick(Sender);
end;

// 시도명 콤보 변경시
procedure Tfrm_LOSTZ850Q.cmb_ProvnmChange(Sender: TObject);
begin
   //ShowMessage('cmb_Provnm.code = ' + cmb_Provnm_d[cmb_Provnm.ItemIndex].code);
   //ShowMessage('cmb_Provnm.name = ' + cmb_Provnm_d[cmb_Provnm.ItemIndex].name);
   if cmb_Provnm_d[cmb_Provnm.ItemIndex].name = '전체' then   // 전체 선택시
   begin
      cmb_Ccwnm.Clear;
      initComboBoxWithZ0xx('Z021', cmb_Ccwnm_d, '전체', '' ,cmb_Ccwnm  ,'**', '', '');
   end
   else
   begin
      cmb_Ccwnm.Clear;
      initComboBoxWithZ0xx('Z021', cmb_Ccwnm_d, '전체', '' ,cmb_Ccwnm  ,cmb_Provnm_d[cmb_Provnm.itemIndex].name, '', '');
   end;

   initStrGrid;	//그리드 초기화

   //edt_search.SetFocus;
end;

procedure Tfrm_LOSTZ850Q.cmb_CcwnmChange(Sender: TObject);
begin
  initStrGrid;	//그리드 초기화

  //edt_search.SetFocus;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun1Click(Sender: TObject);
begin
  if (rdo_Gubun1.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 50;
    initStrGrid;	//그리드 초기화

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun2Click(Sender: TObject);
begin
  if (rdo_Gubun2.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 50;
    initStrGrid;	//그리드 초기화

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun3Click(Sender: TObject);
begin
  if (rdo_Gubun3.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 50;
    initStrGrid;	//그리드 초기화

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun4Click(Sender: TObject);
begin
  if (rdo_Gubun4.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 5;
    initStrGrid;	//그리드 초기화

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun5Click(Sender: TObject);
begin
  if (rdo_Gubun5.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 6;
    initStrGrid;	//그리드 초기화

    edt_search.SetFocus;
  end;
end;


procedure Tfrm_LOSTZ850Q.edt_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_UP then 	//업키
    begin
      if (rdo_Gubun1.Checked = True) then
      begin
        rdo_Gubun1.Checked := False;
        rdo_Gubun4.Checked := True;
      end
      else if (rdo_Gubun2.Checked = True) then
      begin
        rdo_Gubun2.Checked := False;
        rdo_Gubun1.Checked := True;
      end
      else if (rdo_Gubun3.Checked = True) then
      begin
        rdo_Gubun3.Checked := False;
        rdo_Gubun2.Checked := True;
      end
      else if (rdo_Gubun4.Checked = True) then
      begin
        rdo_Gubun4.Checked := False;
        rdo_Gubun3.Checked := True;
      end;
    end;

    if Key = VK_DOWN then 	//다운키
    begin
      if (rdo_Gubun1.Checked = True) then
      begin
        rdo_Gubun1.Checked := False;
        rdo_Gubun2.Checked := True;
      end
      else if (rdo_Gubun2.Checked = True) then
      begin
        rdo_Gubun2.Checked := False;
        rdo_Gubun3.Checked := True;
      end
      else if (rdo_Gubun3.Checked = True) then
      begin
        rdo_Gubun3.Checked := False;
        rdo_Gubun4.Checked := True;
      end
      else if (rdo_Gubun4.Checked = True) then
      begin
        rdo_Gubun4.Checked := False;
        rdo_Gubun1.Checked := True;
      end;
    end;
end;

end.
