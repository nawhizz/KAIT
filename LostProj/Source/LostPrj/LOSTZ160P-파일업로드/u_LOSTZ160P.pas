unit u_LOSTZ160P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  jpeg, Gauges, Grids, Mask, ToolEdit,
  common_lib, WinSkinData, SimpleSFTP, so_tmax, ComObj;

const
  TITLE   = '버전관리';
  PGM_ID  = 'LOSTZ160P';

type

  ftpInfo = record
    ftpIp   : string;
    ftpPort : string;
    ftpId   : string;
    ftpPw   : string;
  end;
  
  TLOSTZ160P_frm = class(TForm)
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    XiDateEdit1: TDateEdit;
    Panel2: TPanel;
    XiEdit1: TEdit;
    CheckBox1: TCheckBox;
    Panel3: TPanel;
    XiEdit2: TEdit;
    XiButton3: TButton;
    XiButton1: TButton;
    Btn_select: TButton;
    XiButton5: TButton;
    XiButton2: TButton;
    Panel4: TPanel;
    Label2: TLabel;
    GR_regGrid: TStringGrid;
    XiButton4: TButton;
    progressMain: TPanel;
    progressBar: TProgressBar;
    Edit1: TEdit;
    Panel5: TPanel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    SkinData1: TSkinData;
    StatusBar1: TStatusBar;
    TMAX: TTMAX;
    procedure XiButton2Click(Sender: TObject);
    procedure XiButton3Click(Sender: TObject);
    procedure XiButton1Click(Sender: TObject);
    procedure Btn_selectClick(Sender: TObject);
    procedure XiButton4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure XiButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GR_regGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure GR_regGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit2Change(Sender: TObject);

  private
    { Private declarations }
    selectedRow : Integer;
    DefaultPosi:Int64;
    PrevCurrent:Int64;
    TotalFSize:Int64;

    ftp : ftpInfo;
  public
    { Public declarations }
    function getDirName(path:String):String;
    function TransferProgress(UserData:Pointer;Current,Total:Int64):Boolean;
    procedure setFinalVersion;	//서버에 최종버젼이 있는지 첵크 및...
    function deleteRemoteDir:Boolean;	//서버에 최초버전을 저장한 디렉토리(version/0000000)을 삭제
    function getFtpIp:ftpInfo;
  end;

var
  LOSTZ160P_frm: TLOSTZ160P_frm;

implementation

uses Math;

{$R *.dfm}

//서버에 기존에 있는 디렉토리를 삭제한다.
//디렉토리 삭제전 디렉토리 안에 있는 모든 파일을 먼저 삭제해야 한다.
function TLOSTZ160P_frm.deleteRemoteDir:Boolean;
var
	FSFTP   :TSimpleSFTP;
  f       :TextFile;
  fcount,i:Integer;

  localPath :String;
  buf       :String;
  fname     :String;
begin
	result:= True;

  localPath:= GetCurrentDir;
  localPath:= GetDirPath(localPath,'\') + '\Temp\version0000.txt';

  FSFTP:=TSimpleSFTP.Create;
  FSFTP.Connect(Self.ftp.ftpIp,Self.ftp.ftpPort, Self.ftp.ftpId, Self.ftp.ftpPw);

  try
  FSFTP.GetFile('/approg/version','version0000.txt', localPath ,True,True,False,0,nil,nil);
  except
    ShowMessage('deleteRemoteDir- version0000.txt 이 없습니다');  //0000000000 가 없다고 가정
  result:= True;
      exit;
  end;

	AssignFile(f, localPath);
	Reset(f);
	Readln(f,buf);
	buf:= Trim(buf);

    fcount:= StrToInt(GetFinalName(buf, '|'));
  for i:= 1 to fcount do begin
		Readln(f,buf);
		buf:= Trim(buf);

    fname:= GetFinalName(buf, '\');
		FSFTP.DeleteFile('/approg/version/0000000000/'+ fname);
	end;
	CloseFile(f);

	FSFTP.DeleteFile('/approg/version/version0000.txt');
  FSFTP.DeleteDir('/approg/version/0000000000');
	FSFTP.Disconnect;
	FSFTP.Free;
end;

//프로그램 시작전 최종 버젼을 가져온다.
procedure TLOSTZ160P_frm.setFinalVersion;	//서버에 최종버젼이 있는지 첵크 및...
var
	FSFTP:TSimpleSFTP;
  f:TextFile;
  FinalVersion:String;
  localPath:String;
  buf:String;
begin
  	FSFTP:=TSimpleSFTP.Create;
    FSFTP.Connect(self.ftp.ftpIp,Self.ftp.ftpPort, Self.ftp.ftpId, Self.ftp.ftpPw);
{
	아래부분은 열심히 삽질만 함. 시간 남으면 트라이 해 보는 것도 나쁘진 않을 듯....
    if not FileExists('/approg/version/versionFile.txt') then begin
 		XiEdit1.Text:= delHyphen(DateToStr(Date))+'01';
        Edit2.Text:= '01';
        FSFTP.Disconnect;
        FSFTP.Free;
        exit;
    end;
}
    localPath:= GetCurrentDir;
    localPath:= GetDirPath(localPath,'\') + '\versionFile.txt';

  try
		FSFTP.GetFile('./version','versionFile.txt', localPath ,True,True,False,0,nil,nil);
    FSFTP.Disconnect;
    FSFTP.Free;

		AssignFile(f, localPath);
    Reset(f);
    Readln(f,buf);
    buf:= Trim(buf);
		CloseFile(f);

    //오늘 날짜와 같지 않으면
    if Copy(buf, 1, 8) <> delHyphen(DateToStr(Date)) then begin
      XiEdit1.Text      := delHyphen(DateToStr(Date))+'01';
      UpDown1.Position  := 1;
      UpDown1.Min       := 1;
    end
    else begin
      UpDown1.Position  := strToInt(Copy(buf, 9,2));
      UpDown1.Min       := UpDown1.Position +1;
      UpDown1.Position  := UpDown1.Min;
      Edit2.Text        := Format('%.2d', [UpDown1.Position]);
      XiEdit1.Text      := delHyphen(DateToStr(Date))+ Edit2.Text;
    end;
  except
      XiEdit1.Text      := delHyphen(DateToStr(Date))+'01';
      UpDown1.Position  := 1;
      UpDown1.Min       := 1;
      FSFTP.Disconnect;
      FSFTP.Free;
	end;

    XiButton1Click(self);	//remote directory setting
end;

function TLOSTZ160P_frm.TransferProgress(UserData:Pointer;Current,Total:Int64):Boolean;
begin
  if Total=0 then begin
    DefaultPosi:= DefaultPosi + PrevCurrent;
  end
  else begin
  	ProgressBar.Position:=Round((DefaultPosi+Current)/TotalFSize*ProgressBar.Max);
    PrevCurrent:= Current;
  end;

  Application.ProcessMessages;
  Result:= true; //not FAbortFlag;
end;

//디렉토리만 추출하여 반환한다.
//예) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'에서
//디렉토리 부분 'File_Upload'만 반환한다.
function TLOSTZ160P_frm.getDirName(path:String):String;
var
  len :Integer;
  po  :Integer;

  fileName  :String;
begin
  result  := path;
  po      := Pos('\', path);
  if po =0 then
    exit;

  fileName  := getFinalName(path, '\');
  len       := Length(path) - Length(fileName) -1;
  result    := getFinalName(Copy(path, 1, len), '\');
end;

//'파일찾기'버튼 클릭
procedure TLOSTZ160P_frm.XiButton2Click(Sender: TObject);
var
  fpath:String;
  fileName:String;
  dirName:String;
  fstr:String;
  f: file;//  of Byte;
  fsize:LongInt;

  tempPath:String;

  i : Integer;

//   stat:TSTAT;
begin
	OpenDialog.InitialDir := GetCurrentDir;

  fstr:=	'실행 파일 (*.exe)|*.exe|'+
          '동적 라이브러리 (*.dll)|*.dll|'+
          '텍스트 파일 (*.txt)|*.txt|'+
          '한글 파일 (*.hwp)|*.hwp|'+
          'MS Word (*.doc)|*.doc|'+
          '엑셀 파일 (*.xls)|*.xls|'+
          '파워포인트 파일 (*.ppt)|*.ppt|'+
          '아크로벳 파일 (*.pdf)|*.pdf'; //|'+
    //'전체 파일 (*.*)|*.*';
	OpenDialog.Filter := FStr;

  if not OpenDialog.Execute then
    exit;

  for i := 0 to OpenDialog.files.Count - 1 do
  begin
    fpath     := OpenDialog.Files.Strings[i];
    dirName   := getDirname(fpath);
    fileName  := getFinalName(fpath,'\');
    fsize     := 0;

    //사이즈 계산하기 위해서 파일을 오픈한다.
    //현재 실행 중인 프로그램을 오픈하면 에러 발생한다.
    if (UpperCase(fileName) = 'LOSTZ160P.EXE') or (UpperCase(fileName) = 'LOSTMAIN.EXE') then begin
      tempPath:= getDirPath(fpath, '\') + '\imsi.exe';
      CopyFile(pchar(fpath), pchar(tempPath), False);
      AssignFile(f, tempPath);
      Reset(f,1);
      fsize := FileSize(f);
      CloseFile(f);
      DeleteFile(tempPath);
    end
    else begin
      AssignFile(f, fpath);
      try
        Reset(f,1);
        fsize := FileSize(f);
        CloseFile(f);

      //위에서 언급한 프로그램외에 실행하고 있으면
      except
        CloseFile(f);
        ShowMessage(''''+fileName+''''+'이 실행 중입니다'+#13#10+'종료후 다시 실행 하세요');
        exit;
      end;
    end;

    with GR_regGrid do begin
      RowCount := RowCount +1;

      Cells[0,RowCount-1] := dirName;
      Cells[1,RowCount-1] := fileName;
      Cells[2,RowCount-1] := intToStr(fsize);
      Cells[3,RowCount-1] := fpath;

      Row:= RowCount-1;
    end;
  end;

  GR_regGrid.FixedRows :=1;	//column sizable...
end;

//'초기화'버튼 클릭
procedure TLOSTZ160P_frm.XiButton3Click(Sender: TObject);
var
	i,j: Integer;
begin
	GR_regGrid.RowCount :=1;

	XiEdit1.Text      := '';
	XiDateEdit1.Text  := DateToStr(Date);
	CheckBox1.Checked := false;
//Btn_select.Enabled := false;
	XiButton1.Enabled := true;
	XiButton2.Enabled := true;
end;

//'버전셋팅'버튼 클릭
procedure TLOSTZ160P_frm.XiButton1Click(Sender: TObject);
var
	ver:String;
begin
	if CheckBox1.Checked then
    CheckBox1.Checked:= False;

  ver           := delHyphen(DateToStr(Date)) + Edit2.Text;
  XiEdit1.Text  := ver;
  Edit1.Text    := 'version/'+ver;
end;

//'전송'버튼 클릭
procedure TLOSTZ160P_frm.Btn_selectClick(Sender: TObject);
var
	path      :String;
  len       :Integer;
  remoteDir :String;
  f         :TextFile;
  f2        :File;
  i         :Integer;
  recStr    :String;
  chfname   :String;

	FSFTP:TSimpleSFTP;
begin
  if GR_regGrid.RowCount <= 1 then
    exit;

  ProgressBar.Position:= 0;

  path  := GetCurrentDir;	// ../KAI/LostPrj/bin
  len   := Length(path) - Length(getFinalName(path, '\'));
  path  := Copy(path, 1, len) + 'Temp\';	//../KAI/LostPrj/Temp

  remoteDir := getFinalName(Edit1.Text, '/');

  //최초버전 디렉토리가 있다면 삭제한다.
  if remoteDir = '0000000000' then begin
    StatusBar1.Panels[1].Text:= '기존의 파일과 디렉토리를 삭제 중...잠시 기다려 주십시오';
    Application.ProcessMessages;
    self.deleteRemoteDir;
    StatusBar1.Panels[1].Text:= '삭제 완료!';
  end;

  if remoteDir = '0000000000' then
    path := path + 'version0000.txt'
  else
    path := path + 'versionFile.txt';

  AssignFile(f, path);
  Rewrite(f);

  Writeln(f, getFinalName(Edit1.Text, '/')+ '|'+ intToStr(GR_regGrid.RowCount-1));

  with GR_regGrid do
  begin
    for i:=1 to (RowCount-1) do begin
      chfname := Cells[1,i];

      recStr  := Cells[0,i] + '\'+ chfname;
      Writeln(f, recStr);
    end;
  end;
  CloseFile(f);

  //전송할 파일들의 전체 사이즈 계산
  AssignFile(f2, path);
  Reset(f2,1);
  TotalFSize := FileSize(f2);
  CloseFile(f2);

  for i:=1 to (GR_regGrid.RowCount -1) do
    TotalFSize := TotalFSize + strToInt(GR_regGrid.Cells[2,i]);


  StatusBar1.Panels[1].Text:= '파일 업로드 중...잠시 기다려 주십시오';
  Application.ProcessMessages;

  FSFTP:=TSimpleSFTP.Create;

  //SFTP 서버 연결
  FSFTP.Connect(Trim(XiEdit2.Text),Self.ftp.ftpPort, Self.ftp.ftpId, Self.ftp.ftpPw);

 	try
		//서버에 서브디렉토리를 생성한다.
    	FSFTP.CreateDir('./version/' + remoteDir); //

    	//프로그레스바를 보이게...
    	progressMain.Visible := True;
    	//업그레이드정보 전송
    	TransferProgress(nil,0,0);
    	FSFTP.PutFile(path,'./version',True,True,False,0,TransferProgress,nil);

    	//파일 업로드 주의 사항!
    	//1. 파일 다운로드시 실행되고 있는 프로그램(LostLogin.exe, FileDownload.exe)은
    	//    파일명을 변경해서 업로드 할 것.
    	for i:= 1 to (GR_regGrid.RowCount-1) do begin
        TransferProgress(nil,0,0);

        chfname:= GR_regGrid.Cells[3,i];
        {
          if (Pos('LOSTLOGIN.EXE',UpperCase(chfname))<>0) or (Pos('FILEDOWNLOAD.EXE',UpperCase(chfname))<>0) then begin
          chfname:= fChngUnderbar(chfname);
          CopyFile(pchar(GR_regGrid.Cells[3,i]), pchar(chfname), False);
          FSFTP.PutFile(GR_regGrid.Cells[3,i],'/approg/version/' + remoteDir ,True,True,False,0,TransferProgress,nil);
          DeleteFile(chfname);
          end
          else
        }
        FSFTP.PutFile(chfname,'./version/' + remoteDir ,True,True,False,0,TransferProgress,nil);
    	end;

    	FSFTP.Disconnect;
    	FSFTP.Free;

   		StatusBar1.Panels[1].Text:= '파일 업로드 완료 하였습니다';
		  Application.ProcessMessages;

    	progressMain.Visible:= false;
    except
      FSFTP.Disconnect;
      FSFTP.Free;
      StatusBar1.Panels[1].Text:= '파일 업로드 실패 하였습니다';
      Application.ProcessMessages;
    end;
end;

//'레코드삭제' 버튼 클릭
procedure TLOSTZ160P_frm.XiButton4Click(Sender: TObject);
begin
	DeleteStringGridRow1(GR_regGrid, selectedRow);
end;

//'최초버전'체크박스 클릭
procedure TLOSTZ160P_frm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    XiEdit1.Text  := '0000000000';
    Edit1.Text    := 'version/0000000000';
  end;
end;

//'닫기'버튼 클릭
procedure TLOSTZ160P_frm.XiButton5Click(Sender: TObject);
begin
    PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure TLOSTZ160P_frm.FormCreate(Sender: TObject);
begin
    //common_lib.pas에 있다.
	initSkinForm(SkinData1);	initSkinForm(SkinData1);

   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    ShowMessage('메인프로그램에서 실행 시키세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait     := ParamStr(1);
  common_caller   := ParamStr(2);  	//메인프로그램 핸들
  common_handle   := intToStr(self.Handle);
  common_userid   := ParamStr(3);
  common_username := ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
  //common_userid   := '0294';    //ParamStr(3);
  //common_username := '정호영';  //ParamStr(4);
  //common_usergroup:= 'KAIT';    //ParamStr(5);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

	with GR_regGrid do begin
    RowCount := 1;
    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 150;
    ColWidths[3] := 300;

    RowHeights[0] := 21;

		Cells[0,0] :='로컬경로';
		Cells[1,0] :='파일명';
		Cells[2,0] :='파일사이즈';
		Cells[3,0] :='파일경로';
  end;

  Self.ftp := getFtpIp;

  setFinalVersion;	//최종버젼 업로드

  XiEdit2.Text := Self.ftp.ftpIp;

  XiDateEdit1.Text := DateToStr(Date);
  UpDown1.Position := strToInt(Edit2.Text);

  DefaultPosi := 0;
  PrevCurrent := 0;

end;

procedure TLOSTZ160P_frm.GR_regGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  dx: Integer;
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];

  if (ARow =0) then begin
    grid.Canvas.Brush.Color := clBtnFace;
    grid.Canvas.Font.Color  := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end;

end;

//UpDown 버튼 값이 변경 되었을 경우
procedure TLOSTZ160P_frm.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
	Edit2.Text := Format('%.2d', [UpDown1.Position]);
end;

procedure TLOSTZ160P_frm.GR_regGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
	selectedRow := ARow;
end;

procedure TLOSTZ160P_frm.FormDestroy(Sender: TObject);
begin
	//메인프로그램에게 종료를 알린다.
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, LOSTPRJRETURN, 0);
end;

procedure TLOSTZ160P_frm.FormShow(Sender: TObject);
begin
	//메인프로그램에게 시작을 알린다.
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, LOSTPRJSTART, 0);
end;

//시리얼 번호가 바뀌는 관련된 콤포넌트의 텍스트를 자동으로 바꾼다.
procedure TLOSTZ160P_frm.Edit2Change(Sender: TObject);
begin
	XiButton1Click(self);
end;

function TLOSTZ160P_frm.getFtpIp: ftpInfo;
var ftp : ftpInfo;

  Label LIQUIDATION;
begin


  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

  ftp.ftpIp   := TMAX.Host;
  ftp.ftpPort := fGetftpPort;
  ftp.ftpId   := fGetftpId;
  ftp.ftpPw   := fGetftpPw;

  result := ftp;

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

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'                      ) < 0) then  goto LIQUIDATION;


  //서비스 호출
  if not TMAX.Call('LOSTZ900Q') then
  begin
    ShowMessage('FTP 정보를 가져오는데 실패하였습니다.');
    Exit;
  end;

  ftp.ftpIp   := TMAX.Host;
  ftp.ftpPort := TMAX.RecvString('STR402',0);
  ftp.ftpId   := TMAX.RecvString('STR403',0);
  ftp.ftpPw   := TMAX.RecvString('STR404',0);

  Result := ftp;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

end;

end.


