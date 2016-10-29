{*---------------------------------------------------------------------------
프로그램ID    : losta01p (사은품 제외 입력)
프로그램 종류 : Online
작성자	      :
작성일	      : 2000. 01. 07
완료일	      : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTA100P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg;

type
  Tfrm_LOSTA100P_CHILD = class(TForm)
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    GroupBox1: TGroupBox;
    Bevel13: TBevel;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Bevel8: TBevel;
    Label8: TLabel;
    Bevel9: TBevel;
    Label9: TLabel;
    Bevel10: TBevel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel14: TBevel;
    lbl_Ju_So: TLabel;
    GroupBox2: TGroupBox;
    Bevel32: TBevel;
    Bevel19: TBevel;
    Label19: TLabel;
    Label32: TLabel;
    GroupBox3: TGroupBox;
    Bevel26: TBevel;
    Bevel22: TBevel;
    Label20: TLabel;
    Bevel23: TBevel;
    Label21: TLabel;
    Bevel24: TBevel;
    Label22: TLabel;
    Bevel25: TBevel;
    Label23: TLabel;
    Bevel27: TBevel;
    Label24: TLabel;
    Bevel28: TBevel;
    Label25: TLabel;
    lbl_ch_Gu: TLabel;
    Bevel29: TBevel;
    lbl_gt_yn: TLabel;
    Bevel30: TBevel;
    lbl_bn_dt: TLabel;
    Bevel31: TBevel;
    lbl_bl_dt: TLabel;
    Bevel33: TBevel;
    lbl_ju_dt: TLabel;
    Bevel34: TBevel;
    lbl_bn_sy: TLabel;
    Bevel2: TBevel;
    msk_id_no: TMaskEdit;
    Label1: TLabel;
    lbl_gt_dt: TLabel;
    Bevel4: TBevel;
    lbl_bn_ji: TLabel;
    Bevel15: TBevel;
    lbl_bo_so: TLabel;
    Bevel16: TBevel;
    Bevel20: TBevel;
    lbl_ph_gb: TLabel;
    lbl_ph_cd: TLabel;
    Bevel35: TBevel;
    lbl_pt_no: TLabel;
    Bevel36: TBevel;
    lbl_sp_cd: TLabel;
    Bevel37: TBevel;
    lbl_tl_no: TLabel;
    Bevel38: TBevel;
    Label28: TLabel;
    Bevel39: TBevel;
    Bevel40: TBevel;
    Label30: TLabel;
    Bevel41: TBevel;
    lbl_bl_id: TLabel;
    Bevel42: TBevel;
    lbl_ip_id: TLabel;
    Label16: TLabel;
    Bevel21: TBevel;
    dte_ip_dt: TDateEdit;
    Label3: TLabel;
    Bevel43: TBevel;
    lbl_ch_id: TLabel;
    Bevel44: TBevel;
    Label11: TLabel;
    Bevel47: TBevel;
    lbl_id_cd: TLabel;
    Bevel48: TBevel;
    Label14: TLabel;
    Bevel49: TBevel;
    lbl_sp_gu: TLabel;
    Bevel50: TBevel;
    md_grid1: TStringGrid;
    Bevel12: TBevel;
    Bevel6: TBevel;
    Bevel11: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Label15: TLabel;
    Label18: TLabel;
    Label6: TLabel;
    lbl_cg_no: TLabel;
    msk_Sr_No: TMaskEdit;
    md_cb1: TComboEdit;
    cmb_md_cd: TComboBox;
    Bevel45: TBevel;
    Label4: TLabel;
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Next_Inq: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Help: TSpeedButton;
    btn_Close: TSpeedButton;
    Panel4: TPanel;
    rdo_bl_Yes: TRadioButton;
    rdo_bl_No: TRadioButton;
    Bevel46: TBevel;
    Bevel3: TBevel;
    Label2: TLabel;
    edt_Id_Nm: TEdit;
    btn_Name_Inq: TBitBtn;
    Bevel51: TBevel;
    Label17: TLabel;
    edt_sp_yu: TEdit;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_Next_InqClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure md_grid1Click(Sender: TObject);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_Id_NmEnter(Sender: TObject);
    procedure btn_Name_InqClick(Sender: TObject);
    procedure msk_Sr_NoEnter(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure rdo_bl_YesClick(Sender: TObject);
    procedure rdo_bl_NoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTA100P_CHILD: Tfrm_LOSTA100P_CHILD;

Const
     MAXRECCNT = 1;

implementation
uses cpaklibm, u_LOSTA100P;
{$R *.DFM}

//type
//    Tsendbody = record
//           id_no   : array[0..15] of char;
//           ip_dt   : array[0..7] of char;
//           md_cd   : array[0..3] of char;
//           sr_no   : array[0..6] of char;
//           bl_yn   : char;
//           sp_yu   : array[0..39] of char;
//    end ;
//
//    Trecvbody = record
//           gt_dt   : array[0..9] of char;
//           bl_dt   : array[0..9] of char;
//           id_cd   : array[0..19] of char;
//           ph_gb   : array[0..19] of char;
//           ph_cd   : array[0..19] of char;
//           id_nm   : array[0..39] of char;
//           pt_no   : array[0..6] of char;
//           ju_so   : array[0..59] of char;
//           bn_ji   : array[0..13] of char;
//           bo_so   : array[0..39] of char;
//           tl_no   : array[0..13] of char;
//           ch_gu   : array[0..11] of char;
//           gt_yn   : array[0..9] of char;
//           ju_dt   : array[0..9] of char;
//           bn_dt   : array[0..9] of char;
//           bn_sy   : array[0..19] of char;
//           sp_cd   : array[0..19] of char;
//           sp_gu   : array[0..19] of char;
//           ip_id   : array[0..9] of char;
//           bl_id   : array[0..9] of char;
//           ch_id   : array[0..9] of char;
//           cg_no   : array[0..5] of char;
//    end ;
//
//    Trecvhead = record
//           id_no   : array[0..15] of char;
//           ip_dt   : array[0..7] of char;
//           md_cd   : array[0..3] of char;
//           sr_no   : array[0..6] of char;
//           bl_yn   : char;
//           sp_yu   : array[0..39] of char;
//    end ;
//
//    Tsendrec = record
//           func : char ;
//           bd : Tsendbody ;
//    end ;
//
//    Trecvrec = record
//          ContFlag : char;
//          ErrFlag : char;
//          MsgStr : array [0..59] of char;
//          RecCnt : array [0..3] of char;
//          hd  : Trecvhead;
//          bd  : Trecvbody ;
//    end ;
//
//    Tsavkey = record
//          id_no, ip_dt : shortstring;
//    end ;
//
//var
//  send : Tsendrec;
//  recv : Trecvrec;
//  savkey : Tsavkey;

{--------------- user define function and procedure declaration -------------}
//procedure btninit_rtn; forward;
//procedure scrinit_rtn; forward;
//procedure comm_rtn( func : char ); forward;
//procedure scr2buff_rtn; forward;
//procedure buff2scr_rtn; forward;
//function errchk_rtn : integer ; forward ;
{--------------- user define function and procedure code --------------------}
//procedure btninit_rtn;
//begin
//  with frm_losta01p_child do
//  begin
//    btn_Add.Enabled	  := True;
//    btn_Update.Enabled	  := True;
//    btn_Delete.Enabled	  := True;
//    btn_Inquiry.Enabled   := True;
//    btn_Next_Inq.Enabled  := False;
//    btn_Link.Enabled	  := False;
//    btn_Print.Enabled	  := False;
//  end;
//end;
//{----------------------------------------------------------------------------}
//procedure scrinit_rtn;
//begin
//   with frm_losta01p_child do
//   begin
//      md_cb1.Text := '';
//      msk_sr_no.text := '';
//      rdo_bl_Yes.Checked := true;
//      rdo_bl_No.Checked := false;
//      edt_sp_yu.Clear;
//      lbl_bl_dt.Caption := '';
//      lbl_gt_dt.Caption := '';
//      lbl_ph_gb.Caption := '';
//      lbl_ph_cd.Caption := '';
//      lbl_pt_no.Caption := '';
//      lbl_Ju_So.Caption := '';
//      lbl_bn_ji.Caption := '';
//      lbl_bo_so.Caption := '';
//      lbl_tl_no.Caption := '';
//      lbl_ch_Gu.Caption := '';
//      lbl_gt_yn.Caption := '';
//      lbl_ju_dt.Caption := '';
//      lbl_bn_dt.Caption := '';
//      lbl_bn_sy.Caption := '';
//      lbl_sp_gu.Caption := '';
//      lbl_sp_cd.Caption := '';
//      lbl_ip_id.Caption := '';
//      lbl_ch_id.Caption := '';
//      lbl_cg_no.Caption := '';
//      lbl_bl_id.Caption := '';
//      lbl_id_cd.Caption := '';
//   end;
//end;
//{----------------------------------------------------------------------------}
//procedure comm_rtn( func : char );
//begin
//  with frm_losta01p_child do
//  begin
//
//     sts_Message.Panels[1].text := '통신중입니다.';
//     update;
//
//     { send buffer 초기화 }
//     FillChar (send, sizeof (send), ' ') ;
//     FillChar (recv, sizeof (recv), ' ') ;
//     send.func := func ;
//
//     if errchk_rtn = -1 then
//     begin
//        sts_Message.Panels[1].text := '';
//	exit ;
//     end;
//
//     scr2buff_rtn ;
//
//     if CSendRecv ('losta20p', @send, sizeof (send), @recv, True) = -1 then
//        exit ;
//
//     if (send.func = 'I') or (send.func = 'L') then
//     begin
//	scrinit_rtn;
//        FillChar (savkey, sizeof (savkey), ' ') ;
//     end;
//
//     sts_Message.Panels[1].text := recv.MsgStr;
//
//     if recv.ErrFlag = 'E' then
//     begin
//	showmessage(recv.MsgStr);
//	exit ;
//     end ;
//
//     if send.func = 'N' then
//	scrinit_rtn;
//
//     if (send.func = 'I') or (send.func = 'N') or (send.func = 'L') then
//         buff2scr_rtn ;
//
//     if (send.func = 'I') or (send.func = 'L') then
//        btn_Next_Inq.Enabled  := True;
//
//     { 조회나 입력일 경우 키 값을 저장한다 }
//     if send.func <> 'D' then
//     begin
//        savkey.id_no := msk_id_no.text;
//        savkey.ip_dt := dte_ip_dt.text;
//     end;
//  end;
//end;
//{----------------------------------------------------------------------------}
//function errchk_rtn : integer ;
//begin
//   result := 0;
//
//   with frm_losta01p_child do
//   begin
//      msk_id_no.text := trim(msk_id_no.text);
//
//      if (send.func = 'U') or (send.func = 'D') or
//         (send.func = 'A') or (send.func = 'N') then
//      begin
//         if (msk_id_No.text <> savkey.id_no) or
//            (dte_ip_dt.text <> savkey.ip_dt) then
//         begin
//      	    showmessage('조회후 작업하십시요 !!');
//            result := -1 ;
//  	    exit ;
//         end;
//      end;
//
//      try
//         dte_Ip_Dt.Date := strtodate(dte_Ip_Dt.text);
//      except
//      on E: EConvertError do
//         begin
//            ShowMessage('일자 입력 오류' + #13 + E.Message);
//	    dte_Ip_Dt.setfocus;
//	    result := -1 ;
//	    exit ;
//	 end;
//      end;
//
//      if (send.func = 'A') or (send.func = 'U') or
//         (send.func = 'D') then
//      begin
//         if (rdo_bl_yes.checked = true) and
//            (trim(edt_sp_yu.text) = '') then
//         begin
//      	    showmessage('사은품 제외사유를 입력하여 주십시요 !!');
//            edt_sp_yu.setfocus;
//            result := -1 ;
//  	    exit ;
//         end;
//      end;
//
//   end;
//end;
//{----------------------------------------------------------------------------}
//procedure scr2buff_rtn;
//var tempdt1 : string;
//begin
//   with frm_losta01p_child do
//   begin
//      CStrToArr(msk_id_no.Text,send.bd.id_no,false);
//      datetimetostring(tempdt1, 'yyyymmdd', dte_Ip_dt.date);
//      CStrToArr (tempdt1, send.bd.ip_dt, False) ;
//      if rdo_bl_Yes.Checked then
//         CStrToArr('Y', send.bd.bl_yn, False)
//      else if rdo_bl_No.Checked then
//         CStrToArr (' ', send.bd.bl_yn, False);
//      CStrToArr(edt_sp_yu.Text, send.bd.sp_yu,false);
//      CStrToArr(trim(md_grid1.Cells[1,md_grid1.row]), send.bd.md_cd, False) ;
//      CStrToArr(msk_Sr_No.text, send.bd.sr_no, False) ;
//   end;
//end;
//{----------------------------------------------------------------------------}
//procedure buff2scr_rtn;
//var tempstr : shortstring;
//begin
//  with frm_losta01p_child do
//  begin
//      msk_Id_No.Text := trim(CArrToStr(recv.hd.id_no));
//      tempstr := CArrToStr(recv.hd.ip_dt);
//      dte_ip_dt.Text := copy(tempstr,1,4) + '-' + copy(tempstr,5,2) + '-' +
//                        copy(tempstr,7,2);
//      if trim(CArrToStr(recv.hd.bl_yn)) = 'Y' then
//      begin
//         rdo_bl_Yes.Checked := True;
//         edt_sp_yu.Visible := True;
//         label17.visible := True;
//         Bevel51.Visible := True;
//         edt_sp_yu.Text := trim(CArrToStr(recv.hd.sp_yu));
//      end
//      else
//      begin
//         rdo_bl_No.Checked := True;
//         edt_sp_yu.Visible := False;
//         label17.visible := False;
//         Bevel51.Visible := False;
//         edt_sp_yu.Clear;
//      end;
//      
//      cmb_md_cd.ItemIndex := cmb_md_cd.Items.IndexOf(CFindCode('Z008',CArrToStr(recv.hd.md_cd)));
//      md_cb1.Text := trim(copy(cmb_md_cd.Text,1,40));
//      md_grid1.Row := cmb_md_cd.ItemIndex;
//      msk_Sr_No.Text := CArrToStr(recv.hd.sr_no);
//      
//      edt_Id_Nm.Text := trim(CArrToStr(recv.bd.id_nm));
//      lbl_ph_gb.Caption := CArrToStr(recv.bd.ph_gb);
//      lbl_gt_dt.Caption := CArrToStr(recv.bd.gt_dt);
//      lbl_bl_dt.Caption := CArrToStr(recv.bd.bl_dt);
//      lbl_ph_cd.Caption := CArrToStr(recv.bd.ph_cd);
//      lbl_pt_no.Caption := CArrToStr(recv.bd.pt_no);
//      lbl_Ju_So.Caption := CArrToStr(recv.bd.ju_so);
//      lbl_bn_ji.Caption := CArrToStr(recv.bd.bn_ji);
//      lbl_bo_so.Caption := CArrToStr(recv.bd.bo_so);
//      lbl_tl_no.Caption := CArrToStr(recv.bd.tl_no);
//      lbl_ch_Gu.Caption := CArrToStr(recv.bd.ch_gu);
//      lbl_gt_yn.Caption := CArrToStr(recv.bd.gt_yn);
//      lbl_ju_dt.Caption := CArrToStr(recv.bd.ju_dt);
//      lbl_bn_dt.Caption := CArrToStr(recv.bd.bn_dt);
//      lbl_bn_sy.Caption := CArrToStr(recv.bd.bn_sy);
//      lbl_sp_cd.Caption := CArrToStr(recv.bd.sp_cd);
//      lbl_sp_gu.Caption := CArrToStr(recv.bd.sp_gu);
//      lbl_ip_id.Caption := CArrToStr(recv.bd.ip_id);
//      lbl_ch_id.Caption := CArrToStr(recv.bd.ch_id);
//      lbl_cg_no.Caption := CArrToStr(recv.bd.cg_no);
//      lbl_bl_id.Caption := CArrToStr(recv.bd.bl_id);
//      lbl_id_cd.Caption := CArrToStr(recv.bd.id_cd);
//  end;
//end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA100P_CHILD.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA100P_CHILD.FormCreate(Sender: TObject);
var i : integer;
begin
     { 프로그램 초기화에 필요한 코드를 작성한다}
//     Capiinit ;
     { 키 저장 버퍼 clear }
//     FillChar (savkey, sizeof (savkey), ' ') ;
//     btninit_rtn;
//     scrinit_rtn;
//     dte_ip_dt.date := date;
//     CLoadCode('Z008','','','',cmb_md_cd);
//     cmb_Md_Cd.ItemIndex := -1;
//     md_grid1.ColWidths[1] := 50;
//     md_grid1.ColWidths[2] := 20;
//     for i := 0 to cmb_md_Cd.Items.Count-1 do
//     begin
//        md_Grid1.rowcount := md_Grid1.rowcount + 1;
//        md_Grid1.Cells[0,i] := trim(Copy(cmb_md_cd.Items[i],1,40));
//        md_Grid1.Cells[1,i] := trim(Copy(cmb_md_cd.Items[i],41,10));
//        md_Grid1.Cells[2,i] := trim(Copy(cmb_md_cd.Items[i],51,10));
//     end;
//     sts_Message.Panels[2].text := CGetTca(TCA_USID);

//   CLinkInit(handle, 'losta20p');
end;

procedure Tfrm_LOSTA100P_CHILD.btn_InquiryClick(Sender: TObject);
begin
//    Screen.Cursor := crAppStart;
//    comm_rtn('I');
//    Screen.Cursor := crDefault;
end;

procedure Tfrm_LOSTA100P_CHILD.btn_Next_InqClick(Sender: TObject);
begin
//    Screen.Cursor := crAppStart;
//    comm_rtn('N');
//    Screen.Cursor := crDefault;
end;

procedure Tfrm_LOSTA100P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//   CLinkEnd (handle, LinkRcvRecNo, ' ' ) ;
//   Capiend;
end;

procedure Tfrm_LOSTA100P_CHILD.md_grid1Click(Sender: TObject);
begin
 md_cb1.text :=md_grid1.Cells[0,md_grid1.row];
// md_cb1.SetFocus;
 md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA100P_CHILD.md_cb1ButtonClick(Sender: TObject);
begin
 md_cb1.onButtonClick := nil;
 md_cb1.OnKeyUp := nil;
 md_grid1.OnClick := nil;
   if not md_Grid1.Visible then
   begin
     md_Grid1.Visible := true;
   end else
     md_Grid1.Visible := false;

 md_cb1.OnButtonClick := md_cb1ButtonClick;
 md_cb1.OnKeyUp := md_cb1KeyUp;
 md_grid1.OnClick := md_Grid1Click;

end;

procedure Tfrm_LOSTA100P_CHILD.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var  i : integer;
begin
 md_cb1.onButtonClick := nil;
 md_cb1.OnKeyUp := nil;
 md_grid1.OnClick := nil;
 if key = 13 then
 begin
   if md_grid1.Visible then
     md_grid1.Visible := false
   else
     md_grid1.Visible := true;
   md_cb1.Text := '';
   md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
   md_cb1.SelectAll;
 end else
 if (key = vk_up) and (md_grid1.Visible) then
 begin
  if ( md_grid1.row <> 0 ) then
  begin
    md_grid1.Row := md_grid1.Row - 1;
    md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
    md_cb1.SelectAll;
  end;
 end else
 if key = vk_escape then
 begin
  md_grid1.Visible := false;
 end else
 if (key = vk_down) and (md_grid1.Visible) then
 begin
  if ( md_grid1.row <> ( md_grid1.RowCount - 1 ) ) then
  begin
    md_grid1.Row := md_grid1.Row + 1;
    md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
    md_cb1.SelectAll;
  end;
 end else
 if (trim(md_cb1.Text) <> '') and (key <> 229) then
 begin
   if not md_grid1.Visible then
     md_grid1.Visible := true;
   for i := 0 to md_grid1.RowCount do
     if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
     begin
       md_grid1.Row := i;
       break;
     end;
end;
   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp := md_cb1KeyUp;
   md_grid1.OnClick := md_Grid1Click;
end;

procedure Tfrm_LOSTA100P_CHILD.edt_Id_NmEnter(Sender: TObject);
begin
  md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA100P_CHILD.btn_Name_InqClick(Sender: TObject);
var sndstr : shortstring;
begin
//   sndstr := CRemoveSpace(edt_id_nm.text);
//   if sndstr = '' then
//   begin
//     showmessage('성명을 입력하십시오.');
//     exit;
//   end;
//   LinkSndRecNo := CLinkSend (handle, 'losta20p', 'losta91p', sndstr, true);
//   if LinkSndRecNo = -1 then
//   begin
//      showmessage('성명 조회 프로그램 실행 오류 !!');
//      sts_Message.Panels[1].Text := '성명 조회 프로그램 실행 오류 !!';
//   end ;
end;



procedure Tfrm_LOSTA100P_CHILD.msk_Sr_NoEnter(Sender: TObject);
begin
 md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA100P_CHILD.btn_DeleteClick(Sender: TObject);
begin
   if MessageDlg('정말 삭제하시겠습니까 ?',
      mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
   end
   else
   begin
//      Screen.Cursor := crAppStart;
//      comm_rtn('D');
//      Screen.Cursor := crDefault;
   end;
end;

procedure Tfrm_LOSTA100P_CHILD.rdo_bl_YesClick(Sender: TObject);
begin
   edt_sp_yu.Visible := True;
   label17.visible := True;
   Bevel51.Visible := True;
end;

procedure Tfrm_LOSTA100P_CHILD.rdo_bl_NoClick(Sender: TObject);
begin
   edt_sp_yu.Visible := False;
   label17.visible := False;
   Bevel51.Visible := False;
   edt_sp_yu.Clear;
end;

end.
