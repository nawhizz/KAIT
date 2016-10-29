unit FileUploaP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP,IdMultipartFormData, OleCtrls, SHDocVw, MSHTML,
  HTTPApp, IdCookieManager, ExtCtrls, UREdits, URCtrls,UrlMon, ComCtrls,
  XiDateEdit, OverbyteIcsWndControl, OverbyteIcsHttpProt,XiPanel, URGrids,
  URMGrid, XiEdit, XiButton, URLabels, jpeg, Gauges, Grids, Mask, ToolEdit,
  common_lib, WinSkinData, SimpleSFTP;

type
  TFileUploadP = class(TForm)
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
  private
    { Private declarations }
    selectedRow : Integer;
    DefaultPosi:Int64;
    PrevCurrent:Int64;
    TotalFSize:Int64;
  public
    { Public declarations }
    function delHyphen(src:String):String;
    function getFinalName(fullName, delimiter:String):String;
    function getDirName(path:String):String;
    function TransferProgress(UserData:Pointer;Current,Total:Int64):Boolean;
  end;

var
  FileUploadP: TFileUploadP;

implementation

uses Math;

{$R *.dfm}

function TFileUploadP.TransferProgress(UserData:Pointer;Current,Total:Int64):Boolean;
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
function TFileUploadP.getDirName(path:String):String;
var
	len:Integer;
    po:Integer;

    fileName:String;
begin
	result := path;
    po := Pos('\', path);
    if po =0 then
    	exit;

    fileName := getFinalName(path, '\');
    len := Length(path) - Length(fileName) -1;
    result := getFinalName(Copy(path, 1, len), '\');
end;

//파일만 추출하여 반환한다.
//예) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'에서
//마지막 부분 'FileUpload_prj.exe'만 반환한다.
function TFileUploadP.getFinalName(fullName, delimiter:String):String;
var
	len:Integer;
    po:Integer;

    function unitString(org:String):String;
    var
    	len:Integer;
        po:Integer;
    begin
    	result := org;

    	po := Pos(delimiter, org);
        if po = 0 then
        	exit;

        len := Length(org);
        result := unitString(Copy(org, po+1, len-po));
    end;
begin
	result := fullName;

    po := Pos(delimiter, fullName);
    if po =0 then
    	exit;

    len := Length(fullName);
    result := unitString(Copy(fullName, po+1, len-po));
end;

//2011-07-20 => 20110720
function TFileUploadP.delHyphen(src:String):String;
var
	len:Integer;
    po:Integer;

	function unitString(org:String):String;
    var
    	len:Integer;
        po:Integer;
    begin
		result := org;

    	len:= Length(org);
        po := Pos('-', org);
        if po <> 0 then
        	result := Copy(org,1,po-1) + unitString(Copy(org, po+1, len-po));
    end;
begin
	result := src;

    len:= Length(src);
    po:= Pos('-', src);
	if po <> 0 then
        	result := Copy(src,1,po-1) + unitString(Copy(src, po+1, len-po));
end;

//'파일찾기'버튼 클릭
procedure TFileUploadP.XiButton2Click(Sender: TObject);
var
	fpath:String;
    fileName:String;
    dirName:String;
    fstr:String;
   	f: file;//  of Byte;
    fsize:LongInt;

//   stat:TSTAT;
begin
	OpenDialog.InitialDir := GetCurrentDir;
    fstr:=	'실행 파일 (*.exe)|*.exe|'+
            '초기화 파일 (*.ini)|*.ini|'+
            '환경변수 파일 (*.env)|*.env|'+
			'전체 파일 (*.*)|*.*';
	OpenDialog.Filter := FStr;

    if not OpenDialog.Execute then
     	exit;

	fpath := OpenDialog.FileName;
    fileName := self.getFinalName(fpath,'\');
    dirName := getDirname(fpath);
    //파일 사이즈 얻음
 	AssignFile(f, fpath);
    try
 		Reset(f,1);
 		fsize := FileSize(f);
    except
    	//on EInOutErr do
        	ShowMessage('파일 읽기 오류'+#13#10+'실행중인 파일은 업로드 불가');
	end;
	CloseFile(f);

    with GR_regGrid do begin
    	RowCount := RowCount +1;
    	Cells[0,RowCount-1] := dirName;
    	Cells[1,RowCount-1] := fileName;
    	Cells[2,RowCount-1] := intToStr(fsize);
    	Cells[3,RowCount-1] := fpath;
        Row:= RowCount-1;
    end;
end;

//'초기화'버튼 클릭
procedure TFileUploadP.XiButton3Click(Sender: TObject);
var
	i,j: Integer;
begin
	GR_regGrid.RowCount :=1;

	XiEdit1.Text := '';
	XiDateEdit1.Text := DateToStr(Date);
	CheckBox1.Checked := false;
   //Btn_select.Enabled := false;
	XiButton1.Enabled := true;
	XiButton2.Enabled := true;
end;

//'버전셋팅'버튼 클릭
procedure TFileUploadP.XiButton1Click(Sender: TObject);
var
	ver:String;
begin
	ver:= delHyphen(XiDateEdit1.Text) + Edit2.Text;
    XiEdit1.Text := ver;
    Edit1.Text := 'version/'+ver;
end;

//'전송'버튼 클릭
procedure TFileUploadP.Btn_selectClick(Sender: TObject);
var
	path:String;
    len:Integer;
    remoteDir:String;
    f:TextFile;
    f2:File;
    i:Integer;
    recStr:String;

	FSFTP:TSimpleSFTP;
begin
	if GR_regGrid.RowCount <= 1 then
    	exit;

	path := GetCurrentDir;	// ../KAI/LostPrj/bin
    len := Length(path) - Length(getFinalName(path, '\'));
    path := Copy(path, 1, len) + 'Temp\';	//../KAI/LostPrj/Temp

    remoteDir := getFinalName(Edit1.Text, '/');
    if remoteDir = '0000000000' then
    	path := path + 'version0000.txt'
    else
    	path := path + 'versionFile.txt';

    AssignFile(f, path);
    Rewrite(f);

    Writeln(f, getFinalName(Edit1.Text, '/')+ '|'+ intToStr(GR_regGrid.RowCount-1));
    with GR_regGrid do begin
    	for i:=1 to (RowCount-1) do begin
			recStr:= Cells[0,i] + '\'+ Cells[1,i];
            Writeln(f, recStr);
        end;
    end;
    CloseFile(f);

    //여기서 파일을 전송한다.

    //전송할 파일들의 전체 사이즈 계산
 	AssignFile(f2, path);
 	Reset(f2,1);
 	TotalFSize := FileSize(f2);
	CloseFile(f2);

    for i:=1 to (GR_regGrid.RowCount -1) do
    	TotalFSize := TotalFSize + strToInt(GR_regGrid.Cells[2,i]);

  	FSFTP:=TSimpleSFTP.Create;
    //SFTP 서버 연결
    FSFTP.Connect('192.168.1.196','22', 'lomofos', '1111');
	//서버에 서브디렉토리를 생성한다.
    FSFTP.CreateDir('/approg/version/' + remoteDir); //

    //프로그레스바를 보이게...
    progressMain.Visible := True;
    //업그레이드정보 전송
    TransferProgress(nil,0,0);
    FSFTP.PutFile(path,'/approg/version',True,True,False,0,TransferProgress,nil);

    for i:= 1 to (GR_regGrid.RowCount-1) do begin
    	TransferProgress(nil,0,0);
    	FSFTP.PutFile(GR_regGrid.Cells[3,i],'/approg/version/' + remoteDir ,True,True,False,0,TransferProgress,nil);
    end;

    FSFTP.Disconnect;
    FSFTP.Free;

    progressMain.Visible:= false;
end;

//'레코드삭제' 버튼 클릭
procedure TFileUploadP.XiButton4Click(Sender: TObject);
begin
	DeleteStringGridRow1(GR_regGrid, selectedRow);
end;

//'최초버전'체크박스 클릭
procedure TFileUploadP.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    XiEdit1.Text := '0000000000';
    Edit1.Text := 'version/0000000000';
    
    XiButton1.Enabled := false;
    Btn_select.Enabled := true;
  end;
end;

//'닫기'버튼 클릭
procedure TFileUploadP.XiButton5Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFileUploadP.FormCreate(Sender: TObject);
begin
	with GR_regGrid do begin
    	RowCount :=1;
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

    XiDateEdit1.Text := DateToStr(Date);
    UpDown1.Position := strToInt(Edit2.Text);

    DefaultPosi:=0;
    PrevCurrent:=0;

end;

procedure TFileUploadP.GR_regGridDrawCell(Sender: TObject; ACol,
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
        grid.Canvas.Font.Color := clBlack;
    	grid.Canvas.FillRect(Rect);
    	DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
    end;

end;

//UpDown 버튼 값이 변경 되었을 경우
procedure TFileUploadP.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
	Edit2.Text := Format('%.2d', [UpDown1.Position]);
end;

procedure TFileUploadP.GR_regGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
	selectedRow := ARow;
end;

end.
