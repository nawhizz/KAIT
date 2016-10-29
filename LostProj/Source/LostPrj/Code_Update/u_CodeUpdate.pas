unit u_CodeUpdate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SimpleSFTP, ComCtrls, Filectrl, WinSkinData, common_lib, IniFiles,
  ExtCtrls, so_tmax;

const
  TITLE   = '�����ڵ������Ʈ';
  PGM_ID  = 'CodeUpdate';

type
  TCodeUpdateFrm = class(TForm)
    GetFileButton: TButton;
    ProgressBar1: TProgressBar;
    SkinData1: TSkinData;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    TMAX: TTMAX;
    procedure FormCreate(Sender: TObject);
    procedure GetFileButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    DefaultPosi:Int64;
    PrevCurrent:Int64;
    TotalFSize:Int64;

  public
    { Public declarations }
  end;

var
  CodeUpdateFrm: TCodeUpdateFrm;

implementation

{$R *.DFM}

procedure TCodeUpdateFrm.FormCreate(Sender: TObject);
begin
	initSkinForm(SkinData1);

   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	if ParamCount <> 2 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    ShowMessage('�α��ο��� ���� �ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
    end;

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait  := ParamStr(1);
  common_caller:= ParamStr(2);

  Left  := 100;
  Top   := 100;
end;

//'Code Update' ��ư Ŭ��
procedure TCodeUpdateFrm.GetFileButtonClick(Sender: TObject);
var
    iniSet:TIniFile;
    f:TextFile;
    localBasicPath:String;
    fileVersion:String;
    oldGubun, newGubun:String;

    buf:Array[0..121]of Char;
    count,i:Integer;

    LABEL LIQUIDATION;

    procedure SetString(start:Integer; src:String);
    var
    	len,i:Integer;
    begin
        if src='' then
        	exit;

        len := Length(src);
        for i:=1 to len do
        	buf[start+i-1]:= src[i];
    end;

    procedure NewFile(fname:String);
    var
    	path:String;
    begin
        path:= localBasicPath + '\Data\' + fname + '.dat';
        AssignFile(f, path);
        ReWrite(f);
    end;

begin
  localBasicPath:= GetCurrentDir; //..\KAIT\LostPrj\Bin
  localBasicPath:= getFrontName(localBasicPath, '\');	//..\KAIT\LostPrj

  //Ŭ���̾�Ʈ�� ini������ ������ �о� ���δ�.
  iniSet:= TIniFile.Create(localBasicPath +'\Ini\LostProj.ini');
  fileVersion := iniSet.ReadString('CLIVER', 'LASTCODE', '');

  if fileVersion = '' then begin
    iniSet.Free;

    StatusBar1.Panels[1].Text := 'LostProj.ini ���Ͽ� LASTCODE �׸��� �����ϴ�';
    Application.ProcessMessages;

    //���⼭ ȣ���� �����쿡 �޼����� ������.
    PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 2, 0); //wParam =2, �����ڵ忡�� ����..
    PostMessage(self.Handle, WM_QUIT,0 ,0);
  end;

  //�������� �ڵ带 �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

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
	if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ910Q'      ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', fileVersion     ) < 0) then  goto LIQUIDATION;

  StatusBar1.Panels[1].Text := '������ ���� ��...��� ��ٷ� �ֽʽÿ�';
  Application.ProcessMessages;

  //���� ȣ��
	if not TMAX.Call('LOSTZ910Q') then begin
    	MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    	goto LIQUIDATION;
  end;


  fileVersion:= TMAX.RecvString('STR100',0);
  //ini���Ͽ� ���� ������ ������Ʈ �Ѵ�.
  iniSet.WriteString('CLIVER', 'LASTCODE', fileVersion);
  iniSet.Free;

  count := TMAX.RecvInteger('INT100',0);

  ProgressBar1.Min:=0;
  ProgressBar1.Max:= count;
  ProgressBar1.Position:=0;

  StatusBar1.Panels[1].Text := '�����ڵ� ������Ʈ ��...��� ��ٷ� �ֽʽÿ�';
  Application.ProcessMessages;

	oldGubun:='START';

  for i:=0 to count-1 do
  begin
    newGubun := Trim(TMAX.RecvString('STR101', i));

    if oldGubun <> newGubun then
    begin
      if oldGubun <> 'START' then
        CloseFile(f);

      NewFile(newGubun);
    end
    else
      Write(f,#13#10);

    FillChar(buf, SizeOf(buf), Ord(' '));

    SetString(0,  Trim(TMAX.RecvString('STR102',i)));	//�ڵ��
    SetString(40, Trim(TMAX.RecvString('STR103',i)));	//�ڵ��ȣ
    SetString(50, Trim(TMAX.RecvString('STR104',i)));	//�����ڵ�1
    SetString(60, Trim(TMAX.RecvString('STR105',i)));	//�����ڵ�2
    SetString(70, Trim(TMAX.RecvString('STR106',i)));	//�����ڵ�3
    SetString(80, Trim(TMAX.RecvString('STR107',i)));	//�����ڵ�4
    SetString(90, Trim(TMAX.RecvString('STR108',i)));	//��뿩��
    SetString(91, Trim(TMAX.RecvString('STR109',i)));	//�����ڵ�5


    Write(f, Copy(StrPas(buf),1,122));

    oldGubun := newGubun;

    ProgressBar1.Position :=  ProgressBar1.Position+1;
    Application.ProcessMessages;

  end;

  if  count<> 0 then
    CloseFile(f);

  StatusBar1.Panels[1].Text := '�����ڵ� ������Ʈ�� �Ϸ� �Ͽ����ϴ�';
  Application.ProcessMessages;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  //���⼭ ȣ���� �����쿡 �޼����� ������.
  PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 2, 0); //wParam =2, �����ڵ忡�� ����..
  PostMessage(self.Handle, WM_QUIT,0 ,0);
end;

procedure TCodeUpdateFrm.FormShow(Sender: TObject);
begin
	Timer1.Enabled:= True;
end;

procedure TCodeUpdateFrm.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled:= False;
  GetFileButtonClick(self);
end;

end.

