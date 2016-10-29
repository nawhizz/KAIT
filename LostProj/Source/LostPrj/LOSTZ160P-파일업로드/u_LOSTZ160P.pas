unit u_LOSTZ160P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  jpeg, Gauges, Grids, Mask, ToolEdit,
  common_lib, WinSkinData, SimpleSFTP, so_tmax, ComObj;

const
  TITLE   = '��������';
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
    procedure setFinalVersion;	//������ ���������� �ִ��� ýũ ��...
    function deleteRemoteDir:Boolean;	//������ ���ʹ����� ������ ���丮(version/0000000)�� ����
    function getFtpIp:ftpInfo;
  end;

var
  LOSTZ160P_frm: TLOSTZ160P_frm;

implementation

uses Math;

{$R *.dfm}

//������ ������ �ִ� ���丮�� �����Ѵ�.
//���丮 ������ ���丮 �ȿ� �ִ� ��� ������ ���� �����ؾ� �Ѵ�.
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
    ShowMessage('deleteRemoteDir- version0000.txt �� �����ϴ�');  //0000000000 �� ���ٰ� ����
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

//���α׷� ������ ���� ������ �����´�.
procedure TLOSTZ160P_frm.setFinalVersion;	//������ ���������� �ִ��� ýũ ��...
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
	�Ʒ��κ��� ������ ������ ��. �ð� ������ Ʈ���� �� ���� �͵� ������ ���� ��....
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

    //���� ��¥�� ���� ������
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

//���丮�� �����Ͽ� ��ȯ�Ѵ�.
//��) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'����
//���丮 �κ� 'File_Upload'�� ��ȯ�Ѵ�.
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

//'����ã��'��ư Ŭ��
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

  fstr:=	'���� ���� (*.exe)|*.exe|'+
          '���� ���̺귯�� (*.dll)|*.dll|'+
          '�ؽ�Ʈ ���� (*.txt)|*.txt|'+
          '�ѱ� ���� (*.hwp)|*.hwp|'+
          'MS Word (*.doc)|*.doc|'+
          '���� ���� (*.xls)|*.xls|'+
          '�Ŀ�����Ʈ ���� (*.ppt)|*.ppt|'+
          '��ũ�κ� ���� (*.pdf)|*.pdf'; //|'+
    //'��ü ���� (*.*)|*.*';
	OpenDialog.Filter := FStr;

  if not OpenDialog.Execute then
    exit;

  for i := 0 to OpenDialog.files.Count - 1 do
  begin
    fpath     := OpenDialog.Files.Strings[i];
    dirName   := getDirname(fpath);
    fileName  := getFinalName(fpath,'\');
    fsize     := 0;

    //������ ����ϱ� ���ؼ� ������ �����Ѵ�.
    //���� ���� ���� ���α׷��� �����ϸ� ���� �߻��Ѵ�.
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

      //������ ����� ���α׷��ܿ� �����ϰ� ������
      except
        CloseFile(f);
        ShowMessage(''''+fileName+''''+'�� ���� ���Դϴ�'+#13#10+'������ �ٽ� ���� �ϼ���');
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

//'�ʱ�ȭ'��ư Ŭ��
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

//'��������'��ư Ŭ��
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

//'����'��ư Ŭ��
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

  //���ʹ��� ���丮�� �ִٸ� �����Ѵ�.
  if remoteDir = '0000000000' then begin
    StatusBar1.Panels[1].Text:= '������ ���ϰ� ���丮�� ���� ��...��� ��ٷ� �ֽʽÿ�';
    Application.ProcessMessages;
    self.deleteRemoteDir;
    StatusBar1.Panels[1].Text:= '���� �Ϸ�!';
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

  //������ ���ϵ��� ��ü ������ ���
  AssignFile(f2, path);
  Reset(f2,1);
  TotalFSize := FileSize(f2);
  CloseFile(f2);

  for i:=1 to (GR_regGrid.RowCount -1) do
    TotalFSize := TotalFSize + strToInt(GR_regGrid.Cells[2,i]);


  StatusBar1.Panels[1].Text:= '���� ���ε� ��...��� ��ٷ� �ֽʽÿ�';
  Application.ProcessMessages;

  FSFTP:=TSimpleSFTP.Create;

  //SFTP ���� ����
  FSFTP.Connect(Trim(XiEdit2.Text),Self.ftp.ftpPort, Self.ftp.ftpId, Self.ftp.ftpPw);

 	try
		//������ ������丮�� �����Ѵ�.
    	FSFTP.CreateDir('./version/' + remoteDir); //

    	//���α׷����ٸ� ���̰�...
    	progressMain.Visible := True;
    	//���׷��̵����� ����
    	TransferProgress(nil,0,0);
    	FSFTP.PutFile(path,'./version',True,True,False,0,TransferProgress,nil);

    	//���� ���ε� ���� ����!
    	//1. ���� �ٿ�ε�� ����ǰ� �ִ� ���α׷�(LostLogin.exe, FileDownload.exe)��
    	//    ���ϸ��� �����ؼ� ���ε� �� ��.
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

   		StatusBar1.Panels[1].Text:= '���� ���ε� �Ϸ� �Ͽ����ϴ�';
		  Application.ProcessMessages;

    	progressMain.Visible:= false;
    except
      FSFTP.Disconnect;
      FSFTP.Free;
      StatusBar1.Panels[1].Text:= '���� ���ε� ���� �Ͽ����ϴ�';
      Application.ProcessMessages;
    end;
end;

//'���ڵ����' ��ư Ŭ��
procedure TLOSTZ160P_frm.XiButton4Click(Sender: TObject);
begin
	DeleteStringGridRow1(GR_regGrid, selectedRow);
end;

//'���ʹ���'üũ�ڽ� Ŭ��
procedure TLOSTZ160P_frm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    XiEdit1.Text  := '0000000000';
    Edit1.Text    := 'version/0000000000';
  end;
end;

//'�ݱ�'��ư Ŭ��
procedure TLOSTZ160P_frm.XiButton5Click(Sender: TObject);
begin
    PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure TLOSTZ160P_frm.FormCreate(Sender: TObject);
begin
    //common_lib.pas�� �ִ�.
	initSkinForm(SkinData1);	initSkinForm(SkinData1);

   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    ShowMessage('�������α׷����� ���� ��Ű����');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait     := ParamStr(1);
  common_caller   := ParamStr(2);  	//�������α׷� �ڵ�
  common_handle   := intToStr(self.Handle);
  common_userid   := ParamStr(3);
  common_username := ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  //common_userid   := '0294';    //ParamStr(3);
  //common_username := '��ȣ��';  //ParamStr(4);
  //common_usergroup:= 'KAIT';    //ParamStr(5);

  {----------------------- ���� ���ø����̼� ���� ---------------------------}

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ��� ������ ����
  fSetIcon(Application);

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

	with GR_regGrid do begin
    RowCount := 1;
    ColWidths[0] := 100;
    ColWidths[1] := 150;
    ColWidths[2] := 150;
    ColWidths[3] := 300;

    RowHeights[0] := 21;

		Cells[0,0] :='���ð��';
		Cells[1,0] :='���ϸ�';
		Cells[2,0] :='���ϻ�����';
		Cells[3,0] :='���ϰ��';
  end;

  Self.ftp := getFtpIp;

  setFinalVersion;	//�������� ���ε�

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

//UpDown ��ư ���� ���� �Ǿ��� ���
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
	//�������α׷����� ���Ḧ �˸���.
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, LOSTPRJRETURN, 0);
end;

procedure TLOSTZ160P_frm.FormShow(Sender: TObject);
begin
	//�������α׷����� ������ �˸���.
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, LOSTPRJSTART, 0);
end;

//�ø��� ��ȣ�� �ٲ�� ���õ� ������Ʈ�� �ؽ�Ʈ�� �ڵ����� �ٲ۴�.
procedure TLOSTZ160P_frm.Edit2Change(Sender: TObject);
begin
	XiButton1Click(self);
end;

function TLOSTZ160P_frm.getFtpIp: ftpInfo;
var ftp : ftpInfo;

  Label LIQUIDATION;
begin


  //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

  ftp.ftpIp   := TMAX.Host;
  ftp.ftpPort := fGetftpPort;
  ftp.ftpId   := fGetftpId;
  ftp.ftpPw   := fGetftpPw;

  result := ftp;

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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'                      ) < 0) then  goto LIQUIDATION;


  //���� ȣ��
  if not TMAX.Call('LOSTZ900Q') then
  begin
    ShowMessage('FTP ������ �������µ� �����Ͽ����ϴ�.');
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


