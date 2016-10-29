{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ850Q (�������ȣ �ּ� ��ȸ)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2015. 06.18
�Ϸ���	      : 2015. 06.23
���α׷� ���� : �������ȣ �ּ� �ڷḦ ��ȸ�Ѵ�.

-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
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
    Cells[0,0]    :='�����ȣ';

    ColWidths[1]  := 373;
    Cells[1,0]    :='���θ��ּ�';

    ColWidths[2]  := 272;
    Cells[2,0]    :='�����ּ�';

    ColWidths[3]  := 85;
    Cells[3,0]    :='������������';

    ColWidths[4]  := 0;
    Cells[4,0]    :='5�ڸ������ȣ���';

    // �׸��� ����Ÿ clear
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
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.

//	if ParamCount < 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
//    	ShowMessage('���޵� �Ķ���� ��������!');
//        PostMessage(self.Handle, WM_QUIT, 0,0);
//        exit;
//    end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//    common_userid     := '0294'; //ParamStr(2);
//    common_username   := '��ȣ��';
//    ParamStr(3);
//    common_usergroup  := 'KAIT'; //ParamStr(4);

    initSkinForm(SkinData1);

    // �����ڵ� �޺�����
    initComboBoxWithZ0xx('Z020.dat', cmb_Provnm_d, '��ü','',cmb_Provnm);
    initComboBoxWithZ0xx('Z021.dat', cmb_Ccwnm_d , '��ü','',cmb_Ccwnm, '**', '', '' );

    initStrGrid;	//�׸��� �ʱ�ȭ

    isData:= False;  //��Ʈ���׸��忡 �����Ͱ� ����.

    //�����ͽ��ٿ� ����� ������ �����ش�.
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

  //�׸��� ���÷���

  RowPos:= 1;	//�׸��� ���ڵ� ������
  grd_display.RowCount := 2;
  grd_display.FixedRows:=1;

  grd_display.Cursor := crSQLWait;	//�۾���....
  //disableComponents;	//�۾��� �ٸ� ��� ��� ����.

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

//������ȸ
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

  if (cmb_Provnm_d[cmb_Provnm.ItemIndex].name = '��ü') then
     STR002 := ''
  else
     STR002 := cmb_Provnm_d[cmb_Provnm.ItemIndex].name;

  if (cmb_Provnm_d[cmb_Ccwnm.ItemIndex].name = '��ü') then
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

  //STR004 := '���ε���';
  //STR005 := '';
  //STR006 := '';

  //�����Է� �κ�
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

  //���� ȣ��
  if not TMAX.Call('LOSTZ850Q') then goto LIQUIDATION;

  count1 := TMAX.RecvInteger('INT100',0);

  if count1 > 0 then isData := True;	//��Ʈ���׸��忡 �����Ͱ� �ִ�.

  if count1 > 0 then
    totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);	// �����ȣ
      Cells[1,RowPos] := TMAX.RecvString('STR102',i);	// ���θ��ּ�
      Cells[2,RowPos] := TMAX.RecvString('STR103',i);	// �����ּ�
      Cells[3,RowPos] := TMAX.RecvString('STR104',i);	// ���������ȣ
      Cells[4,RowPos] := TMAX.RecvString('STR105',i);	// 5�ڸ������ȣ��뿩��

      Inc(RowPos);
    end;

  end;
  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';

  Application.ProcessMessages;

   // count2 := TMAX.RecvInteger('INT100',0);
   // if count1 = count2 then
   // 	goto INQUIRY;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  if isData then grd_display.RowCount := grd_display.RowCount -1;

  if isData then
    grd_display.SetFocus	//��Ʈ�� �׸���� ��Ŀ�� �̵�
  else
    edt_search.SetFocus;


end;


procedure Tfrm_LOSTZ850Q.btn_LinkClick(Sender: TObject);
var
	smem:TPSharedMem;
  zip_no:String;

begin

	if not isData then begin 			//��Ʈ�� �׸��忡 �����Ͱ� ������
    	edt_search.SetFocus;	//'�˻�����' �޺��ڽ��� �̵�
      exit;
  end;

  if (Trim(grd_display.Cells[4,grd_display.Row]) = 'Y') then
        zip_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row]))  //5�ڸ������ȣ
  else  zip_no   := delHyphen(Trim(grd_display.Cells[3,grd_display.Row])); //6�ڸ������ȣ

  //�����޸𸮸� ��´�.
	smem:= OpenMap;

	if smem <> nil then
    begin
        Lock;  //���� ���ӹ���

        //smem^.po_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row])); //�����ȣ
        smem^.po_no   := zip_no; //�����ȣ
        smem^.ju_so   := Trim(grd_display.Cells[1,grd_display.Row]); // ���θ��ּ�
        smem^.ddd_no  := Trim(grd_display.Cells[2,grd_display.Row]); // �����ּ�

        UnLock;
    end;

    PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 1, 0);

   CloseMap;

   PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure Tfrm_LOSTZ850Q.edt_searchKeyPress(Sender: TObject;
  var Key: Char);
begin
//	if Key <> #13 then 	//����Ű�� �ƴϸ�
//    	exit;
//
//  btn_InquiryClick(Sender);

//    ShowMessage('Key = ' + Key);

    if Key = #13 then 	//����Ű��
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

  // �θ�â���� �����͸� �Ѱܹ����� �ٷ� ��ȸ
  if(ParamStr(8) <> '') then
  begin
    edt_search.Text      := StringReplace(Trim(ParamStr(8)),'|','',[rfReplaceAll]);
    s := Trim(edt_search.Text);
    // 2015.06.29 ������ �߰�
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

// �õ��� �޺� �����
procedure Tfrm_LOSTZ850Q.cmb_ProvnmChange(Sender: TObject);
begin
   //ShowMessage('cmb_Provnm.code = ' + cmb_Provnm_d[cmb_Provnm.ItemIndex].code);
   //ShowMessage('cmb_Provnm.name = ' + cmb_Provnm_d[cmb_Provnm.ItemIndex].name);
   if cmb_Provnm_d[cmb_Provnm.ItemIndex].name = '��ü' then   // ��ü ���ý�
   begin
      cmb_Ccwnm.Clear;
      initComboBoxWithZ0xx('Z021', cmb_Ccwnm_d, '��ü', '' ,cmb_Ccwnm  ,'**', '', '');
   end
   else
   begin
      cmb_Ccwnm.Clear;
      initComboBoxWithZ0xx('Z021', cmb_Ccwnm_d, '��ü', '' ,cmb_Ccwnm  ,cmb_Provnm_d[cmb_Provnm.itemIndex].name, '', '');
   end;

   initStrGrid;	//�׸��� �ʱ�ȭ

   //edt_search.SetFocus;
end;

procedure Tfrm_LOSTZ850Q.cmb_CcwnmChange(Sender: TObject);
begin
  initStrGrid;	//�׸��� �ʱ�ȭ

  //edt_search.SetFocus;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun1Click(Sender: TObject);
begin
  if (rdo_Gubun1.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 50;
    initStrGrid;	//�׸��� �ʱ�ȭ

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun2Click(Sender: TObject);
begin
  if (rdo_Gubun2.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 50;
    initStrGrid;	//�׸��� �ʱ�ȭ

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun3Click(Sender: TObject);
begin
  if (rdo_Gubun3.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 50;
    initStrGrid;	//�׸��� �ʱ�ȭ

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun4Click(Sender: TObject);
begin
  if (rdo_Gubun4.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 5;
    initStrGrid;	//�׸��� �ʱ�ȭ

    edt_search.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ850Q.rdo_Gubun5Click(Sender: TObject);
begin
  if (rdo_Gubun5.Checked = True) then
  begin
    edt_search.Clear;
    edt_search.MaxLength := 6;
    initStrGrid;	//�׸��� �ʱ�ȭ

    edt_search.SetFocus;
  end;
end;


procedure Tfrm_LOSTZ850Q.edt_searchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_UP then 	//��Ű
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

    if Key = VK_DOWN then 	//�ٿ�Ű
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
