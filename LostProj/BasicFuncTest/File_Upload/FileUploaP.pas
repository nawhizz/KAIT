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

//���丮�� �����Ͽ� ��ȯ�Ѵ�.
//��) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'����
//���丮 �κ� 'File_Upload'�� ��ȯ�Ѵ�.
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

//���ϸ� �����Ͽ� ��ȯ�Ѵ�.
//��) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'����
//������ �κ� 'FileUpload_prj.exe'�� ��ȯ�Ѵ�.
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

//'����ã��'��ư Ŭ��
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
    fstr:=	'���� ���� (*.exe)|*.exe|'+
            '�ʱ�ȭ ���� (*.ini)|*.ini|'+
            'ȯ�溯�� ���� (*.env)|*.env|'+
			'��ü ���� (*.*)|*.*';
	OpenDialog.Filter := FStr;

    if not OpenDialog.Execute then
     	exit;

	fpath := OpenDialog.FileName;
    fileName := self.getFinalName(fpath,'\');
    dirName := getDirname(fpath);
    //���� ������ ����
 	AssignFile(f, fpath);
    try
 		Reset(f,1);
 		fsize := FileSize(f);
    except
    	//on EInOutErr do
        	ShowMessage('���� �б� ����'+#13#10+'�������� ������ ���ε� �Ұ�');
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

//'�ʱ�ȭ'��ư Ŭ��
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

//'��������'��ư Ŭ��
procedure TFileUploadP.XiButton1Click(Sender: TObject);
var
	ver:String;
begin
	ver:= delHyphen(XiDateEdit1.Text) + Edit2.Text;
    XiEdit1.Text := ver;
    Edit1.Text := 'version/'+ver;
end;

//'����'��ư Ŭ��
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

    //���⼭ ������ �����Ѵ�.

    //������ ���ϵ��� ��ü ������ ���
 	AssignFile(f2, path);
 	Reset(f2,1);
 	TotalFSize := FileSize(f2);
	CloseFile(f2);

    for i:=1 to (GR_regGrid.RowCount -1) do
    	TotalFSize := TotalFSize + strToInt(GR_regGrid.Cells[2,i]);

  	FSFTP:=TSimpleSFTP.Create;
    //SFTP ���� ����
    FSFTP.Connect('192.168.1.196','22', 'lomofos', '1111');
	//������ ������丮�� �����Ѵ�.
    FSFTP.CreateDir('/approg/version/' + remoteDir); //

    //���α׷����ٸ� ���̰�...
    progressMain.Visible := True;
    //���׷��̵����� ����
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

//'���ڵ����' ��ư Ŭ��
procedure TFileUploadP.XiButton4Click(Sender: TObject);
begin
	DeleteStringGridRow1(GR_regGrid, selectedRow);
end;

//'���ʹ���'üũ�ڽ� Ŭ��
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

//'�ݱ�'��ư Ŭ��
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

		Cells[0,0] :='���ð��';
		Cells[1,0] :='���ϸ�';
		Cells[2,0] :='���ϻ�����';
		Cells[3,0] :='���ϰ��';
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

//UpDown ��ư ���� ���� �Ǿ��� ���
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
