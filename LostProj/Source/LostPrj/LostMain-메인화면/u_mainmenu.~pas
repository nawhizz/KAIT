{*---------------------------------------------------------------------------
프로그램ID    : mainmenu (분실단말기집중관리 메인메뉴)
프로그램 종류 : Online
작성자	      : 구내영
작성일	      : 2011.07.22
완료일	      : ####. ##. ##
프로그램 개요 : 각각의 서브 프로그램을 실행한다.
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_mainmenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, shellapi, ExtCtrls, RxGrdCpt, RXCtrls, Grids,
  IniFiles, RxGIF, GIFImage, WinSkinData, common_lib, so_tmax, jpeg ;

const
  TITLE   = '분실단말기집중관리 메인메뉴';
  PGM_ID  = 'mainmenu';

type
  Tfrm_MAINMENU = class(TForm)
    sts_Message: TStatusBar;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    MainMenu1: TMainMenu;
    Image: TImage;
    lbl_LOSTA100P: TLabel;
    lbl_LOSTA500L: TLabel;
    lbl_LOSTA340Q: TLabel;
    lbl_LOSTA660L: TLabel;
    lbl_LOSTA200Q: TLabel;
    lbl_LOSTA560L: TLabel;
    lbl_LOSTC500L: TLabel;
    lbl_LOSTA260Q: TLabel;
    lbl_LOSTB200Q: TLabel;
    lbl_LOSTB260Q: TLabel;
    lbl_LOSTB130P: TLabel;
    lbl_LOSTB520L: TLabel;
    lbl_LOSTC110P: TLabel;
    lbl_LOSTC250Q: TLabel;
    lbl_LOSTC520L: TLabel;
    lbl_LOSTZ240P: TLabel;
    pnl1: TPanel;
    lbl_sub_title: TLabel;
    edt_find_name: TEdit;
    strngrd1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure menuItemClick(Sender: TObject);
    procedure closeForm(Sender: TObject);
    procedure skinChangeEvent(Sender: TObject);
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure onClick(Sender: TObject);
    procedure edt_find_nameKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure strngrd1DblClick(Sender: TObject);
  private
  	subprg:Integer;	//서브프로그램 카운트
    _idx : Integer;
    { Private declarations }
    procedure attachOnMouseMove;
    procedure attachOnClick;

  public
    { Public declarations }
    procedure CreateMenus;

    procedure readSkindata;
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
    procedure DisplayHint(Sender: TObject);
  end;

type
  TpgmList = record
    pgmid : string;
    pgmNm : string;
  end;

  ArrTpgmList = array[0..150] of TpgmList;

var
  frm_MAINMENU: Tfrm_MAINMENU;

  arrPgmList : ArrTpgmList;

implementation
uses skinChange;
{$R *.DFM}

procedure Tfrm_MAINMENU.Link_rtn (var Msg : TMessage);
begin
    if Msg.wParam = LOSTPRJRETURN then
    	Dec(subprg)	//서브프로그램 종료

    else if Msg.wParam = LOSTPRJSTART then
    	Inc(subprg);
end ;

procedure Tfrm_MAINMENU.readSkindata;
var
	iniPath:String;
	skinPath:String;
	str : String;

	ini : TiniFile;
begin
	iniPath := '..\Ini\LostProj.ini';
	skinPath := '..\Skin\';

	ini := TiniFile.Create(iniPath);
	str := ini.ReadString('Skin','SKIN','');
	skinPath := skinPath + str;

	self.SkinData1.SkinFile := skinPath;
	self.SkinData1.Active := True;

	ini.Free;
end;

procedure Tfrm_MAINMENU.closeForm(Sender: TObject);
begin
	if subprg <> 0 then begin
    	ShowMessage('서브프로그램을 먼저 종료 시키세요');
        exit;
    end;
    
    self.Close;
end;

procedure Tfrm_MAINMENU.menuItemClick(Sender: TObject);
var
	menuItem:TMenuItem;
begin
	menuItem:= Sender as TMenuItem;

  //프로그램을 실행 시킨다.
  if( ExecExternProg(menuItem.Name)) then
    ;//Inc(subprg);	//서브프로그램을 시작
end;

//이 부분은 메인폼이 완전히 생성되기 전에 실행할 것.
procedure Tfrm_MAINMENU.CreateMenus;
var
    mainMenu:TMainMenu;
    menuitem: TMenuItem;
    mItem: TMenuItem;
    jungMItem: TMenuItem;

    jung, so, mcount: Integer;
    mtype :String;
    i:Integer;

    Label LIQUIDATION;
begin
    //메뉴구성
    //중분류가 '0'이고 소분류가 '0' 이면 메인메뉴 아이템 (메뉴형태=Menu) ex)MENU01
    //중분류가 '0'이 아니고  소분류가 '0'이면 서브메뉴 아이템 (메뉴형태=Group) ex)MENU01/SMENU01
    //중분류가 '0'이 아니고 소분류가 '0'이 아니면 서브서브메뉴 아이템 (메뉴형태=Program) ex)MENU01/SMENU01/SSMENU01
    //메뉴형태가 'L' 이면 SPLIT LINE을 그릴 것.
    //서비스명 : LOSTZ920Q
    //입력 : STR001 = 사용자 ID, STR002 = 사용자 그룹
    //출력 :
    //STR101 = "메뉴구분"
    //INT102 = "메뉴중레벨"
    //INT103 = "메뉴소레벨"
    //INT104 = "메뉴순번"
    //STR105 = "프로그램ID"
    //STR106 = "메뉴형태"
    //STR107 = "메뉴명"
	  //INT100 = "COUNT"
  _idx := 0;

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

	if (TMAX.SendString('INF001','S01'              ) < 0) then  goto LIQUIDATION;
    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostMain'         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', common_userid     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', common_usergroup  ) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ920Q') then goto LIQUIDATION;

	//메인메뉴 생성
	  mainMenu  := TMainMenu.Create(self);
    self.Menu := mainMenu;
    jungMItem := nil;
    mItem     := nil;

    //레코드 카운트
    mcount := TMAX.RecvInteger('INT100', 0);

    for i:=0 to mcount-1 do
    begin

      //메인메뉴 아이템 생성
      mtype := TMAX.RecvString('STR106',i);	//메뉴 형태... M,G,L,P

      menuItem := TMenuItem.Create(self);

      if mtype = 'L' then 	//split line
        menuItem.Caption := '-'
      else
        menuItem.Caption := TMAX.RecvString('STR107', i)+'&';	//메뉴명

      if mtype = 'P' then begin
        menuItem.Name     := TMAX.RecvString('STR105', i); //프로그램 ID
        menuItem.OnClick  := menuItemClick;						     //이벤트 assign
        menuitem.Hint     := TMAX.RecvString('STR105', i);
        (* 2011.08.29 최대성 추가 - 작업중인 프로그램은 메뉴 선택을 비활성화 한다. *)
        if (TMAX.RecvString('STR108', i) = '1') then menuItem.Enabled := False;

      end;

      menuItem.Tag := i;

      jung  := TMAX.RecvInteger('INT102',i); 		//메뉴 중레벨
      so    := TMAX.RecvInteger('INT103',i);    //메뉴 소레벨

      //메인메뉴아이템 구분
      if (jung = 0) and (so=0) then begin   		//M1
        mainMenu.Items.Add(menuItem);
        mItem := menuItem;
      end

      //메인메뉴아이템|서브메뉴아이템 구분
      else if (jung <> 0) and (so = 0) then
      begin	//M1/S1
        mItem.Add(menuItem);
        jungMItem := menuItem;

        inc(_idx);
        arrPgmList[_idx].pgmid  := TMAX.RecvString('STR105', i);
        arrPgmList[_idx].pgmNm  := TMAX.RecvString('STR107', i);
       end
      //메인메뉴아이템|서브메뉴아이템|서브메뉴아이템 구분
      else if (jung <>0 ) and (so <>0) then		//M1/S1/SS1
      begin
        jungMItem.Add(menuItem);
      end;
    end;

    //메인메뉴아이템(종료)을 추가한다.
    Inc(i);
    menuItem          := TMenuItem.Create(self);
    menuItem.Caption  := '종료&';
//    menuItem.OnClick  := closeForm;
   	menuItem.Tag      := i;
    mainMenu.Items.Add(menuItem);

    jungMItem := menuitem;

    menuItem          := TMenuItem.Create(self);
    menuItem.Caption  := '종료&';
    menuItem.OnClick  := closeForm;
    menuItem.Tag      := 997;
    jungMItem.Add(menuItem);

    //메인메뉴아이템(시스템관리)에 서브메뉴아이템(스킨변경)을 추가한다.
    jungMItem := nil;

    for i:=0 to mainMenu.Items.Count-1 do begin
    	jungMItem := mainMenu.Items[i];
      if jungMItem.Caption = '시스템 관리&' then break
      else jungMItem := nil;
    end;

    if jungMItem <> nil then begin
    	menuItem          := TMenuItem.Create(self);
    	menuItem.Caption  := '-';
   		menuItem.Tag      := 998;
      jungMItem.Add(menuItem);

    	menuItem          := TMenuItem.Create(self);
    	menuItem.Caption  := '스킨변경&';
    	menuItem.OnClick  := skinChangeEvent;
   		menuItem.Tag      := 999;
      jungMItem.Add(menuItem);
    end;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_MAINMENU.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 처리해야 할 부분======================
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    ShowMessage('로그인 후 사용하세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

  // 임시롤 로그인 데이터 삽입
  //common_userid   := '0294';    //ParamStr(2);
  //common_username := '정호영';  //ParamStr(3);
  //common_usergroup:= 'KAIT';    //ParamStr(4);

  Application.OnHint := DisplayHint;

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;


  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 메세지 바 넓이 설정
  pSetStsWidth(sts_Message);

  // 텍스트 선택시 전체 선택 기능
  pSetTxtSelAll(Self);

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  //테스트 후에는 이 부분을 삭제할 것.
  //common_userid:= '0294'; //ParamStr(2);
  //common_username:= '정호영'; //ParamStr(3);
  //common_usergroup:= 'KAIT'; //ParamStr(4);

  //스킨데이터를 읽는다.
  readSkindata;

  //메뉴는 서버에서 받아 온다.
  createMenus;

  attachOnMouseMove;
  attachOnClick;

  //사이즈 변경하지 말것.
  self.ClientHeight := 481;
  self.ClientWidth  := 745;

  subprg:= 0;	//실행된 서브프로그램이 없슴.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;  

end;

procedure Tfrm_MAINMENU.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
end;

//스킨설정 화면 띄우기
procedure Tfrm_MAINMENU.skinChangeEvent(Sender: TObject);
begin
    SkinChangeForm.ShowModal;
end;

procedure Tfrm_MAINMENU.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    (Sender as TLabel).Cursor := crHandPoint;
end;

procedure Tfrm_MAINMENU.attachOnMouseMove;
var i : Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TLabel then
    begin
      (Components[i] as TLabel).onMouseMove := self.onMouseMove;
      (Components[i] as TLabel).caption := '';
    end;

  lbl_sub_title.Caption := 'Fast Program Finder';
end;

procedure Tfrm_MAINMENU.attachOnClick;
var i : Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TLabel then
      (Components[i] as TLabel).onClick := self.onClick;

  lbl_sub_title.OnClick := nil;
end;

procedure Tfrm_MAINMENU.onClick(Sender: TObject);
var strTmp : String;
begin
  strTmp := (Sender as TLabel).Name;
  strTmp := Copy(strTmp,5,Length(strTmp) - 4);
  if( ExecExternProg(strTmp)) then ;
end;

procedure Tfrm_MAINMENU.DisplayHint(Sender: TObject);
begin
  sts_Message.Panels[1].Text := GetLongHint(Application.Hint);
end;

procedure Tfrm_MAINMENU.edt_find_nameKeyPress(Sender: TObject;
  var Key: Char);
var
  i : integer;
begin
  if key = #13 then
  begin
    pInitStrGrd(Self);

    for i:= Low(arrPgmList) to High(arrPgmList) do
    begin
      if (Pos(UpperCase(edt_find_name.Text) , arrPgmList[i].pgmid) > 0) or (Pos(UpperCase(edt_find_name.Text) , arrPgmList[i].pgmnm) > 0) then
      begin
        strngrd1.Cells[0,strngrd1.RowCount - strngrd1.FixedRows] := arrPgmList[i].pgmid;
        strngrd1.Cells[1,strngrd1.RowCount - strngrd1.FixedRows] := arrPgmList[i].pgmnm;
        strngrd1.RowCount := strngrd1.RowCount + 1;
      end;
    end;

    if (strngrd1.Cells[0,1] <> '') and (strngrd1.RowCount = 3) then
      strngrd1DblClick(Sender);

  end
  else if key = #27 then pnl1.Visible := False;
end;

procedure Tfrm_MAINMENU.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssCtrl in Shift) AND (Key = ord('F'))) then
  begin
    pInitStrGrd(strngrd1);
    pnl1.left := 168;
    pnl1.Top := 156;
    pnl1.Visible := True;
    edt_find_name.SetFocus;
  end;
end;

procedure Tfrm_MAINMENU.strngrd1DblClick(Sender: TObject);
begin
  if (ExecExternProg(strngrd1.Cells[0,strngrd1.row])) then pnl1.Visible := False;;
end;

end.
