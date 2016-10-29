unit u_LOSTA250Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg,
  so_tmax, WinSkinData,common_lib, Menus, Clipbrd, Func_Lib, ComObj;

const
  TITLE   = '������� ���º� ��ȸ';
  PGM_ID  = 'LOSTA250Q';

type
  Tfrm_LOSTA250Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    Panel2: TPanel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_can: TComboBox;
    grd_display: TStringGrid;
    Bevel4: TBevel;
    Label5: TLabel;
    cmb_ph_yn: TComboBox;
    Label7: TLabel;
    Bevel5: TBevel;
    cmb_bl_gu: TComboBox;
    Label4: TLabel;
    lbl_kt: TLabel;
    Label8: TLabel;
    lbl_lg: TLabel;
    Bevel6: TBevel;
    Bevel8: TBevel;
    Label9: TLabel;
    lbl_nk_cell: TLabel;
    Bevel9: TBevel;
    Bevel11: TBevel;
    Label12: TLabel;
    lbl_sk: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    PopupMenu1: TPopupMenu;
    Label6: TLabel;
    Label10: TLabel;
    Bevel7: TBevel;
    lbl_total: TLabel;
    Label13: TLabel;
    Bevel10: TBevel;
    lbl_nk_pcs: TLabel;
    Label15: TLabel;
    Bevel12: TBevel;
    cOPY1: TMenuItem;
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
    lbl_Program_Name: TLabel;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmb_ph_ynChange(Sender: TObject);
    procedure cmb_canChange(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grd_displayDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btn_InquiryClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure InitComponents();
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
  private
    { Private declarations }
    //�׸��� �ʱ�ȭ
    procedure initStrGrid;
    //������ ������Ʈ �������
    procedure disableComponents;
    //����Ϸ� �� ������Ʈ ��� �����ϰ�
    procedure enableComponents;
  public
    { Public declarations }
  end;

procedure ButtonInit; forward;

var
  frm_LOSTA250Q: Tfrm_LOSTA250Q;
  cmb_bl_gu_d : TZ0xxArray;
  qryStr:String;

implementation
{$R *.DFM}

procedure Tfrm_LOSTA250Q.InitComponents;
var
  i : Integer;
  component : TComponent;

begin

  qryStr:= '';
  
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if((Pos('lbl_',(component as TLabel).Name) > 0) AND (Pos('lbl_Prog',(component as TLabel).Name) = 0)) then (component as TLabel).Caption := '';
  end;

  //��ư �̹��� �ʱ�ȭ
  changeBtn(Self);

  if common_usergroup = 'SYSM' then
    btn_query.Enabled := True;

  for i:= grd_display.FixedRows to grd_display.RowCount -1 do
    grd_display.Rows[i].Clear;

  //�׸��� �ʱ�ȭ
  initStrGrid;

  dte_from.Date := date-30;
  dte_to.Date   := date;

  cmb_ph_yn.ItemIndex := 0;
  cmb_can.ItemIndex   := 0;
  cmb_bl_gu.ItemIndex := 0;
  cmb_ph_yn.Enabled   := false;
  cmb_bl_gu.Enabled   := false;

  sts_Message.Panels[1].Text := ' ';
end;

procedure Tfrm_LOSTA250Q.disableComponents;
begin
	  dte_from.Enabled  := false;
    dte_to.Enabled    := false;
    btn_excel.Enabled := False;
    btn_close.Enabled := False;
end;

procedure Tfrm_LOSTA250Q.enableComponents;
begin
	  dte_from.Enabled  := True;;
    dte_to.Enabled    := True;;
    btn_excel.Enabled := True;;
    btn_close.Enabled := True;;
end;

//OnExit --- dte_to
procedure Tfrm_LOSTA250Q.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� �۰� ������ �� �����ϴ�.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then begin
		showmessage('�������ڴ� �������� ���ķ� ������ �� �����ϴ�.');
		exit;
	end;
end;

//OnExit --- dte_from
procedure Tfrm_LOSTA250Q.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
  begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
  end;
end;

//�׸����� ù��° ����(�޸�)�� �̻ڰ� Ʃ���Ѵ�.
procedure Tfrm_LOSTA250Q.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
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
  end
  else
    // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
    begin
      case ACol of
        2..6,8..12: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
        0,1,7: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      end;
    end;
end;


//�� �ʵ��� ���� ���� ����, Ȯ�� �� �� ������ ��.
procedure Tfrm_LOSTA250Q.initStrGrid;
begin
	with grd_display do begin
    RowCount      :=  2;
    ColCount      := 15;
    RowHeights[0] := 21;

    Cells[0,0] := 'SEQ';
    Cells[1,0] := '�԰�����';
    Cells[2,0] := '����(��ü��)';
    Cells[3,0] := '����ڸ�';
    Cells[4,0] := '�ֹ�/�ܱ���/����ڹ�ȣ';
    Cells[5,0] := '��������';
    Cells[6,0] := 'ó������';
    Cells[7,0] := '������ȭ��ȣ';
    Cells[8,0] := '�����ȣ';
    Cells[9,0] := '�ּ�';
    Cells[10,0] := '��';
    Cells[11,0] := 'serial';
    Cells[12,0] := '�н��ڵ�����ȣ';
    Cells[13,0] := '����';
    Cells[14,0] := '����ݻ���';

    ColWidths[0] := 45;
    ColWidths[1] := 80;
    ColWidths[2] := 80;
    ColWidths[3] := 85;
    ColWidths[4] := 160;
    ColWidths[5] := 75;
    ColWidths[6] := 70;
    ColWidths[7] := 105;
    ColWidths[8] := 60;
    ColWidths[9] := 300;
    ColWidths[10] := 65;
    ColWidths[11] := 65;
    ColWidths[12] := 120;
    ColWidths[13] := 200;
    ColWidths[14] := 120;

  end;
end;

procedure ButtonInit;
begin
//
end;

procedure Tfrm_LOSTA250Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA250Q.FormCreate(Sender: TObject);
begin

   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
   {    }
	if ParamCount <> 6 then
  begin
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait     := ParamStr(1);
  common_caller   := ParamStr(2);
  common_handle   := intToStr(self.Handle);
  common_userid   := ParamStr(3);
  common_username := ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  // common_userid     := '0294';    //ParamStr(2);
  // common_username   := '��ȣ��';  //ParamStr(3);
  // common_usergroup  := 'SYSM';    //ParamStr(4);

    {----------------------- ���� ���ø����̼� ���� ---------------------------}

    // ���α׷� ĸ�� ����
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // �׽�ũ�� ĸ�Ǽ���
    Application.Title := TITLE;

    // ���α׷� ���� ĸ�� ����
    lbl_Program_Name.Caption := TITLE;

    // ���α׷� ��� ������ ����
    fSetIcon(Application);

    // �޼��� �� ���� ����
    pSetStsWidth(sts_Message);

    // �ؽ�Ʈ ���ý� ��ü ���� ���
    pSetTxtSelAll(Self);

    // ���α׷� ���� ������ ����
    Self.BorderIcons  := [biSystemMenu,biMinimize];

    // ���α׷� ���� ��ġ ����
    Self.Position     := poScreenCenter;
    {--------------------------------------------------------------------------}

    // ��Ų �ʱ�ȭ
    initSkinForm(SkinData1);

    initComboBoxWithZ0xx('Z071',cmb_bl_gu_d,'��ü','',cmb_bl_gu);

    InitComponents;

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA250Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   //Capiend;
end;

procedure Tfrm_LOSTA250Q.FormShow(Sender: TObject);
begin

end;

// �������� ����� ����(2)
procedure Tfrm_LOSTA250Q.cmb_ph_ynChange(Sender: TObject);
begin
     case cmb_ph_yn.ItemIndex of
     0,2 : begin
             cmb_bl_gu.Enabled := false;
             cmb_bl_gu.ItemIndex := 0;
           end;
     1   : begin
             cmb_bl_gu.Enabled := True;
           end;

     end;
end;

// ���� ���� �޺������ ����(1)
procedure Tfrm_LOSTA250Q.cmb_canChange(Sender: TObject);
begin
     case cmb_can.ItemIndex of
     0,1 :
       begin
          cmb_ph_yn.Enabled := False;
          cmb_bl_gu.Enabled := False;

          cmb_ph_yn.ItemIndex := 0;
          cmb_bl_gu.ItemIndex := 0;
       end;
     2 :
       begin
          cmb_ph_yn.Enabled := True;
          cmb_bl_gu.Enabled := False;

          cmb_bl_gu.ItemIndex := 0;
       end

     end;
end;

//�˾��޴�(���콺�� �����ʹ�ư�� Ŭ��) -- �׸����� ������ Ŭ�����忡 ����
procedure Tfrm_LOSTA250Q.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_display.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_display.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

//'����'��ư Ŭ�� --- �׸����� ������ ������ ������ ȭ�鿡 ��������.
//'Proc_gridtoexcel' ���ν����� Func_Lib.pas �� �ִ�.
procedure Tfrm_LOSTA250Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('��ȸ����(LOSTA250Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA250Q');
end;

//CTRL+C �� ������ ��� �׸����� ������ Ŭ�����忡 �����Ѵ�.
procedure Tfrm_LOSTA250Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then Copy1Click(Sender);
end;

procedure Tfrm_LOSTA250Q.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    STR004 : String;
    STR005 : String;
    STR006 : String;
    STR007 : String;
    STR008 : String;
    STR009 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_ganm := '';
    seed_gano := '';
    seed_gatl := '';
    seed_mtno := '';

	//�׸��� ���÷���
    seq                   := 1; 	//����
    RowPos                := 1;	  //�׸��� ���ڵ� ������
    grd_display.RowCount  := 2;

    qryStr := '';    

    //���۽ú��� �ʱ�ȭ
    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';

    totalCount :=0;

    pInitStrGrd(Self);

    grd_display.Cursor := crSQLWait;	//�۾���....

    //�۾��� �ٸ� ��� ��� ����.
    disableComponents;


    //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

//�б���....
//    if z001Data[cmb_id_cd.ItemIndex].name <> '��ü' then
//    	goto INQUIRY;

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid                                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                                  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                                 ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA250Q'                                      ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                                            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)                        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)                          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', Copy(cmb_can.Items.Strings[cmb_can.itemindex],41,1)        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', Copy(cmb_ph_yn.Items.Strings[cmb_ph_yn.itemindex],41,1)    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_bl_gu_d[cmb_bl_gu.itemIndex].code    ) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA250Q') then goto LIQUIDATION;

  lbl_total.Caption   := convertWithCommer(TMAX.RecvString('INT101',0));
  lbl_kt.Caption	    := convertWithCommer(TMAX.RecvString('INT102',0));
  lbl_lg.Caption	    := convertWithCommer(TMAX.RecvString('INT103',0));
  lbl_sk.Caption	    := convertWithCommer(TMAX.RecvString('INT104',0));
  lbl_nk_cell.Caption := convertWithCommer(TMAX.RecvString('INT105',0));
  lbl_nk_pcs.Caption  := convertWithCommer(TMAX.RecvString('INT106',0));

//	Goto LIQUIDATION;

//������ȸ
INQUIRY:
	TMAX.InitBuffer;

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid             ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA250Q'               ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'                     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text) ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', Copy(cmb_can.Items.Strings[cmb_can.itemindex],41,1)        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', Copy(cmb_ph_yn.Items.Strings[cmb_ph_yn.itemindex],41,1)    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_bl_gu_d[cmb_bl_gu.itemIndex].code    ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR006', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', STR007) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR010', STR008) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR011', STR009) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA250Q') then goto LIQUIDATION;

  // ������ ���� ī��Ʈ
  count1 := TMAX.RecvInteger('INF013',0);

  // ���� �Ѱ�
  totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := intToStr(seq);

          (*  �԰�����       *)  Cells[1,RowPos]  := TMAX.RecvString('STR101',i);
          (*  ����(��ü��)   *)  seed_ganm        := TMAX.RecvString('STR102',i);
                                 Cells[2,RowPos]  := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
          (*  ����ڽĺ��ڵ� *)  Cells[3,RowPos]  := TMAX.RecvString('STR116',i);
        	(*  �ֹλ���ڹ�ȣ *)  seed_gano        := TMAX.RecvString('STR103',i);
        	                       Cells[4,RowPos]  := ECPlazaSeed.Decrypt(seed_gano, common_seedkey);
        	(*  ��������       *)  Cells[5,RowPos]  := TMAX.RecvString('STR104',i);
        	(*  ó�������ڵ�   *)  //Cells[5,RowPos]  := TMAX.RecvString('STR105',i);
        	(*  ó�����и�     *)  Cells[6,RowPos]  := TMAX.RecvString('STR106',i);
        	(*  ������ȭ��ȣ   *)  seed_gatl        := TMAX.RecvString('STR107',i);
        	                       Cells[7,RowPos]  := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
        	(*  �����ȣ       *)  Cells[8,RowPos]  := TMAX.RecvString('STR108',i);
        	(*  �ּ�           *)  Cells[9,RowPos]  := TMAX.RecvString('STR109',i);
        	(*  ���ڵ�       *)  //Cells[10,RowPos] := TMAX.RecvString('STR110',i);

        	(*  �𵨸�         *)  Cells[10,RowPos] := TMAX.RecvString('STR111',i);
        	(*  �ܸ����Ϸù�ȣ *)  Cells[11,RowPos] := TMAX.RecvString('STR112',i);

        	(*  �н��ڵ�����ȣ *)  seed_mtno        := TMAX.RecvString('STR113',i);
        	                       Cells[12,RowPos] := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
        	(*  ����           *)  Cells[13,RowPos] := TMAX.RecvString('STR114',i);
        	(*  ����� ����    *)  Cells[14,RowPos] := TMAX.RecvString('STR115',i);

          (* ��ȸ�����԰�����      *)  STR004 := delHyphen(TMAX.RecvString('STR101',i));
          (* ��ȸ���ۼ���          *)  STR005 := Trim(TMAX.RecvString('STR102',i));
          (* ��ȸ���۸��ڵ�      *)  STR006 := Trim(TMAX.RecvString('STR110',i));
          (* ��ȸ���۴ܸ����Ϸù�ȣ*)  STR007 := Trim(TMAX.RecvString('STR112',i));
          (* ��ȸ���ۻ���ڽĺ��ڵ�*)  STR008 := Trim(TMAX.RecvString('STR115',i));
          (* ��ȸ����ó�������ڵ�  *)  STR009 := Trim(TMAX.RecvString('STR105',i));

          Inc(seq);
          Inc(RowPos);
      end;
    end;

    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;

    count2 := TMAX.RecvInteger('INT100',0);
    if count1 = count2 then goto INQUIRY;

    // ������ ��´�.
    qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
    TMAX.InitBuffer;
    TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�

    if totalCount <> 0 then
      grd_display.RowCount := grd_display.RowCount -1;
      
    enableComponents;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTA250Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
var
  LeftPos: Integer;
  TopPos : integer;
  CellStr: string;
begin
  with TStringGrid(Sender).Canvas do begin
    CellStr := TStringGrid(Sender).Cells[ACol, ARow];
    TopPos  := ((Rect.Top - Rect.Bottom -TStringGrid(Sender).Canvas.TextHeight(CellStr)) div 2) + Rect.Bottom;
    case i_align of
      1 :  LeftPos := ((Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) div 2) + Rect.Left;
      2 :  LeftPos :=  (Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) +
                        Rect.Left - 5;  
      else LeftPos := Rect.Left + 5;
    end;
    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;

procedure Tfrm_LOSTA250Q.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA250Q.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
  f         :TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\' + PGM_ID + 'QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
