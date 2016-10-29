unit u_LOSTZ210P_POP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ210P_child, ComObj;

const
  TITLE   = '�����ڵ���';
  PGM_ID  = 'LOSTZ210P';


type
  Tfrm_LOSTZ210P_POP = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    edt_Cd_Gu: TEdit;
    lbl_Program_Name: TLabel;
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Close: TSpeedButton;
    sts_Message: TStatusBar;
    TMAX: TTMAX;
    grd_display_pop: TStringGrid;
    btn_reset: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_display_popDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure grd_display_popKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
     procedure initStrGrid_pop;
  public
    { Public declarations }
  end;

var
  frm_LOSTZ210P_POP: Tfrm_LOSTZ210P_POP;

implementation
uses cpaklibm, u_LOSTZ210P;
{$R *.dfm}

procedure Tfrm_LOSTZ210P_POP.initStrGrid_pop;
begin
	with grd_display_pop do begin
    	RowCount :=2;
      ColCount := 2;
    	RowHeights[0] := 21;

    	ColWidths[0] := 300;
		Cells[0,0] :='�ڵ��ȣ';

    	ColWidths[1] := 400;
		Cells[1,0] :='�ڵ��';
    end;
end;

procedure Tfrm_LOSTZ210P_POP.setEdtKeyPress;
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

procedure Tfrm_LOSTZ210P_POP.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;
{----------------------------------------------------------------------------}


procedure Tfrm_LOSTZ210P_POP.FormCreate(Sender: TObject);
begin
  {----------------------- ���� ���ø����̼� ���� ---------------------------}
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
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //���뺯�� ����--common_lib.pas ������ ��.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);


    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '��ȣ��';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  initStrGrid_pop;	//�׸��� �ʱ�ȭ

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
  
end;

procedure Tfrm_LOSTZ210P_POP.btn_CloseClick(Sender: TObject);
begin
  frm_LOSTZ210P.Enabled := True;
  Close;
  frm_LOSTZ210P.Show;
end;

procedure Tfrm_LOSTZ210P_POP.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;

    RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
	  //�׸��� ���÷���
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display_pop.RowCount := 2;

    //���۽ú��� �ʱ�ȭ
    totalCount :=0;
    grd_display_pop.Cursor := crSQLWait;	//�۾���....

    //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
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

//�ݺ� ��ȸ
INQUIRY:

    TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ210P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', edt_Cd_Gu.Text ) < 0) then  goto LIQUIDATION;


    //���� ȣ��
	if not TMAX.Call('LOSTZ210P') then goto LIQUIDATION;

    //��ȸ�� ����
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    for i := grd_display_pop.fixedrows to grd_display_pop.rowcount - 1 do
      grd_display_pop.rows[i].Clear;

    grd_display_pop.RowCount   := 3;
    sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';

    goto LIQUIDATION;
  end;
    totalCount:= totalCount + count1;
    grd_display_pop.RowCount := grd_display_pop.RowCount + count1;

    with grd_display_pop do begin
    	for i:=0 to count1-1 do begin

     // STR003 := Trim(TMAX.RecvString('STR101',i));  //��ȸ���ǽ��۱���
          Cells[0,RowPos] := TMAX.RecvString('STR101',i); //�ڵ��ȣ
          Cells[1,RowPos] := TMAX.RecvString('STR102',i); //�ڵ��
          Inc(RowPos);
        end;
    end;
    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display_pop.Cursor := crDefault;	//�۾��Ϸ�

  if totalCount > 1 then
  begin
    grd_display_pop.RowCount := grd_display_pop.RowCount -1;
    grd_display_pop.SetFocus;
  end;

end;

procedure Tfrm_LOSTZ210P_POP.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);

end;

procedure Tfrm_LOSTZ210P_POP.grd_display_popDblClick(Sender: TObject);
begin
  frm_LOSTZ210P.edt_Cd_Gu.Text := grd_display_pop.Cells[0, grd_display_pop.Row];
  frm_LOSTZ210P.edt_Cd_Nm.Text := grd_display_pop.Cells[1, grd_display_pop.Row];
  
  close;

  frm_LOSTZ210P.Enabled := True;
  frm_LOSTZ210P.Show;
  frm_LOSTZ210P.edt_Inq_Str.SetFocus;
end;

procedure Tfrm_LOSTZ210P_POP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTZ210P.Enabled := True;
  frm_LOSTZ210P.Show;
end;

procedure Tfrm_LOSTZ210P_POP.btn_resetClick(Sender: TObject);
begin
  changeBtn(Self);
  frm_LOSTZ210P.Enabled := False;

  edt_Cd_Gu.Text := CD_GU;


  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;

  frm_LOSTZ210P_POP.btn_InquiryClick(Sender);  
end;

procedure Tfrm_LOSTZ210P_POP.grd_display_popKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then grd_display_popDblClick(Sender);
end;

end.





