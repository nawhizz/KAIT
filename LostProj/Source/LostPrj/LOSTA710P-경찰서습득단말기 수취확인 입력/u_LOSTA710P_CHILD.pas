unit u_LOSTA710P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls,common_lib, so_tmax, ComObj;

type
  Tfm_LOSTA710P_CHILD = class(TForm)
    pnl_Command: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    rb3: TRadioButton;
    rb4: TRadioButton;
    rb5: TRadioButton;
    rb6: TRadioButton;
    rb7: TRadioButton;
    rb8: TRadioButton;
    rb9: TRadioButton;
    rb10: TRadioButton;
    rb11: TRadioButton;
    rb12: TRadioButton;
    rb13: TRadioButton;
    rb14: TRadioButton;
    rb15: TRadioButton;
    rb0: TRadioButton;
    pnl1: TPanel;
    cmb_sts_research: TComboBox;
    Panel3: TPanel;
    lbl1: TLabel;
    edt_etc: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    TMAX: TTMAX;
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
    cmb_topic: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure onClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure cmb_topicChange(Sender: TObject);
    procedure fillCmbTopic(Sender: TObject);    

  private
    { Private declarations }
    cmb_sts_research_d : TZ0xxArray;
  public
    { Public declarations }
    // ������Ʈ �ʱ�ȭ
    procedure InitComponent;
    procedure attachOnclickEvt;

  end;

var
  fm_LOSTA710P_CHILD: Tfm_LOSTA710P_CHILD;

implementation
uses u_LOSTA710P;
{$R *.dfm}

procedure Tfm_LOSTA710P_CHILD.FormCreate(Sender: TObject);
begin
  {----------------------- ���� ���ø����̼� ���� ---------------------------}

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ĸ�� ����
  Label4.Caption := TITLE;

  // ���α׷� ��� ������ ����
  fSetIcon(Application);

  // �ؽ�Ʈ ���ý� ��ü ���� ���
  pSetTxtSelAll(Self);

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
  initComboBoxWithZ0xx('Z078.dat',cmb_sts_research_d  , ''    ,'', cmb_sts_research);

  attachOnclickEvt;
end;

procedure Tfm_LOSTA710P_CHILD.InitComponent;
var
  i : Integer;
  component : TComponent;
  strSelVal : string;
begin

  // ��ư �̹��� �ʱ�ȭ
  changeBtn(Self);

  btn_query.Enabled   := False;
  btn_Print.Enabled   := False;
  btn_Inquiry.Enabled := False;
  btn_reset.Enabled   := False;

  cmb_sts_research.ItemIndex := 0;

  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if(Pos((component as TLabel).name,'Label') = 0) and ((component as TLabel).name <> 'lbl1') then
      begin
        (component as TLabel).Visible := False;
        (component as TLabel).Caption := '';
      end;

    if (component is TRadioButton) then
    begin

      if(Pos((component as TRadioButton).name,'rb') = 0) and ((component as TRadioButton).name <> 'rb0') then
      begin
        (component as TRadioButton).Visible := False;
        (component as TRadioButton).Checked := False;
      end;
    end;
  end;

  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TRadioButton) then
    begin
      if(Pos((component as TRadioButton).name,'rb') = 0) then
        (component as TRadioButton).Checked := False;
    end;
  end;

  // ��Ÿ�ǰ� �ʱ�ȭ
  edt_etc.Clear;

  // ���� ���� �� ��� �ش� ������ ����
  // ������ ���� ���� ��� ���� ��
  // 2012.01.16 - ���� ��� �ٽ� �߰���
  if (frm_LOSTA710P.lbl_wk_no.Caption <> '0') then
  begin
      btn_Add.Enabled    := False;
      btn_Update.Enabled := True;
      btn_Delete.Enabled := False;
  end else
  begin
    btn_Add.Enabled    := True;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := False;
  end;

end;

procedure Tfm_LOSTA710P_CHILD.onClick(Sender: TObject);
var
  color : Tcolor;
begin
  cmb_sts_research.ItemIndex := cmb_sts_research.Items.IndexOf('�����Ϸ�');

  if (Sender as TRadioButton).Name = 'rb0' then
  begin
    edt_etc.Enabled := True;
    edt_etc.SetFocus;
  end
  else
  begin
    edt_etc.Enabled := False;
    edt_etc.Clear;
  end;

end;

procedure Tfm_LOSTA710P_CHILD.attachOnclickEvt();
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
    begin
      component := Components[i];

      if (component is TRadioButton) then
      begin
        if(Pos((component as TRadioButton).name,'rb') = 0) then
          (component as TRadioButton).OnClick := Self.onClick;
      end;
    end;

end;

procedure Tfm_LOSTA710P_CHILD.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfm_LOSTA710P_CHILD.fillCmbTopic(Sender: TObject);
var   i:Integer;

  function CfillChar(src : string; fchar : Char;size : Integer) : string;
  var idx : Integer;
      dest : string;
  begin
    for idx := Length(Trim(src)) to Size - 1 do
     dest := dest + fchar;

    result := src + dest;
  end;

  Label LIQUIDATION;
begin
  InitComponent;

  cmb_topic.Clear;

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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT110P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S04'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001',Trim(frm_LOSTA710P.edt_md_cd.Text     )) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR002',Trim(frm_LOSTA710P.serial_edit.Text   )) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR003',delHyphen(frm_LOSTA710P.dte_Ip_Dt.Text)) < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTT110P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      //sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  for i := 0 to TMAX.RecvInteger('INT100',0) -1 do
    cmb_topic.Items.Add(   CfillChar(Trim(TMAX.RecvString('STR103',i))      ,' ',100)
                         + CfillChar(TMAX.RecvString('STR101',i)            ,' ', 10)
                         + CfillChar(IntToStr(TMAX.RecvInteger('INT102',i)) ,' ',  3)
                       );

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if (cmb_topic.Items.Count = 0) then self.Close
  else
  begin
    cmb_topic.ItemIndex := 0;
    cmb_topicChange(Sender);
  end;  
end;

procedure Tfm_LOSTA710P_CHILD.FormShow(Sender: TObject);
begin
  //Self.Show;
  //InitComponent;
  fillCmbTopic(Sender);
end;

procedure Tfm_LOSTA710P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  self.Hide;
  frm_LOSTA710P.Enabled := True;
  frm_LOSTA710P.Show;
  frm_LOSTA710P.btn_InquiryClick(Sender);
end;

procedure Tfm_LOSTA710P_CHILD.btn_AddClick(Sender: TObject);
var
  i,j:Integer;

  chkValue : Integer;

  component : TComponent;

  STRVALUE : array[1..9] of string;

  svcNm : string;

  Label LIQUIDATION;
begin
  j := 0;
  chkValue := 0;
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

  if (sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

	TMAX.InitBuffer;

  fillchar(STRVALUE,SizeOf(STRVALUE),#0);

  STRVALUE[fInc(j)] := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],101,10));
  STRVALUE[fInc(j)] := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],110, 3));

  if (svcNm = 'I01') then
  begin
    STRVALUE[fInc(j)] := frm_LOSTA710P.edt_md_cd.Text;
    STRVALUE[fInc(j)] := frm_LOSTA710P.serial_edit.Text;
    STRVALUE[fInc(j)] := delHyphen(frm_LOSTA710P.dte_Ip_Dt.Text);
  end else
  begin
    STRVALUE[fInc(j)] := Trim(frm_LOSTA710P.lbl_wk_no.Caption);
    STRVALUE[fInc(j)] := frm_LOSTA710P.edt_md_cd.Text;
    STRVALUE[fInc(j)] := frm_LOSTA710P.serial_edit.Text;
    STRVALUE[fInc(j)] := delHyphen(frm_LOSTA710P.dte_Ip_Dt.Text);
  end;



  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TRadioButton) then
    begin
      if(Pos((component as TRadioButton).name,'rb') = 0) then
        if (component as TRadioButton).Checked then
        begin
          chkValue := StrToInt(Copy((component as TRadioButton).name,3,Length((component as TRadioButton).name) -2));
        end;
    end;
  end;

  if(chkValue = 0) and (Length(Trim(edt_etc.Text)) = 0) and (cmb_sts_research_d[cmb_sts_research.itemindex].code = '9') then
  begin
    ShowMessage('�����ϷḦ �� �� ���� �����Դϴ�. ���� ������ Ȯ���ϼ���. ' + #13 + #13 + '1. üũ�׸��� ����' + #13 + '2. ��Ÿ�ǰ� ���� �� �ǰ� �̱���');
    Exit;
  end;


  fInc(j);

  STRVALUE[fInc(j)] := Trim(edt_etc.Text);
  STRVALUE[fInc(j)] := cmb_sts_research_d[cmb_sts_research.itemindex].code;

  j := 0;

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT110P'          ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002',StrToInt(STRVALUE[fInc(j)])   ) < 0) then  goto LIQUIDATION;

  if (svcNm = 'I01') then
  begin
    if (TMAX.SendString ('STR003',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR004',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR005',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    fInc(j);
    if (TMAX.SendInteger('INT006',chkValue            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR007',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR008',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
  end else
  begin
    if (TMAX.SendInteger('INT003',StrToInt(STRVALUE[fInc(j)])   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR004',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR005',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR006',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    fInc(j);
    if (TMAX.SendInteger('INT007',chkValue            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR008',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR009',STRVALUE[fInc(j)]   ) < 0) then  goto LIQUIDATION;
  end;

  //���� ȣ��
	if not TMAX.Call('LOSTT110P') then
  begin
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  //self.Close;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if svcNm = 'I01' then
  begin
    ShowMessage('���������� �����Ͽ����ϴ�.');
    fillCmbTopic(Sender);
  end else
  begin
    ShowMessage('���������� �����Ͽ����ϴ�.');
    fillCmbTopic(Sender);
  end;

end;


procedure Tfm_LOSTA710P_CHILD.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfm_LOSTA710P_CHILD.btn_DeleteClick(Sender: TObject);
var
  j:Integer;

  STRVALUE : array[1..8] of string;

  Label LIQUIDATION;
begin

  j := 0;

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

	TMAX.InitBuffer;

  fillchar(STRVALUE,SizeOf(STRVALUE),#0);

  STRVALUE[fInc(j)] := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],101,10));
  STRVALUE[fInc(j)] := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],110, 3));
  STRVALUE[fInc(j)] := frm_LOSTA710P.lbl_wk_no.Caption;

  j := 0;

  //�����Է� �κ�
	if (TMAX.SendString ('INF002',common_userid        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('INF002',common_username      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('INF002',common_usergroup     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('INF003','LOSTT110P'          ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('INF001','D01'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001',STRVALUE[fInc(j)]    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002',StrToInt(STRVALUE[fInc(j)])   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT003',StrToInt(STRVALUE[fInc(j)])   ) < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTT110P') then
  begin
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  ShowMessage(' '+ TMAX.RecvString('INF012',0));

  self.Close;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfm_LOSTA710P_CHILD.cmb_topicChange(Sender: TObject);
var
  i,j:Integer;

  component : TComponent;

  Label LIQUIDATION;
begin
  
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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT110P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001',Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],101,10))            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002',StrToInt(Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],110, 3)))            ) < 0) then  goto LIQUIDATION;


  //���� ȣ��
	if not TMAX.Call('LOSTT110P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      //sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
      goto LIQUIDATION;
  end;

  InitComponent;

  for i := 0 to TMAX.recvInteger('INT100',0) -1 do
  begin
    for j := 0 to ComponentCount -1 do
      begin
        component := Components[j];

        if( component is TLabel) then
        begin
          if (( component as TLabel).Name = 'Label' + IntToStr(i+1)) then
          begin
            ( component as TLabel).Visible := True;
            ( component as TLabel).Caption := self.TMAX.RecvString('STR122',i);
          end;

        end;

        if( component is TRadioButton) then
        begin
          if (( component as TRadioButton).Name = 'rb' + IntToStr(i+1)) then
            ( component as TRadioButton).Visible := True;

        end;
      end;
  end;
  
  lbl1.Visible := True;
  rb0.Visible  := True;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
 end;

end.
