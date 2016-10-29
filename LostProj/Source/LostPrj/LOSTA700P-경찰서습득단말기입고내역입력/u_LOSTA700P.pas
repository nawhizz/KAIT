{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA700P (�԰��� �Է�)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2013.10.25
�Ϸ���	      : ####. ##. ##
���α׷� ���� :
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTA700P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  checklst, cpakmsg, CurrEdit, barprint, so_tmax, WinSkinData, common_lib,
  SimpleSFTP, localCloud,Clipbrd, Menus,u_landprt, ComObj;

const
  TITLE   = '����������ܸ��� �԰��� �Է�';
  PGM_ID  = 'LOSTA700P';

type
  Tfrm_LOSTA700P = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel20         : TBevel;
    Bevel21         : TBevel;
    Bevel22         : TBevel;
    Bevel24         : TBevel;
    Bevel26         : TBevel;
    Bevel27         : TBevel;
    Bevel29         : TBevel;
    Bevel30         : TBevel;
    Bevel32         : TBevel;
    Bevel33         : TBevel;
    Bevel3          : TBevel;
    Bevel34         : TBevel;
    Bevel16         : TBevel;
    Bevel35         : TBevel;
    Bevel17         : TBevel;
    Bevel36         : TBevel;
    Bevel37         : TBevel;
    Bevel19         : TBevel;
    Bevel18         : TBevel;
    Bevel23         : TBevel;
    Bevel25         : TBevel;
    Bevel28         : TBevel;
    Bevel31         : TBevel;
    Bevel38         : TBevel;
    Bevel40         : TBevel;
    Bevel41         : TBevel;
    Bevel44         : TBevel;
    Bevel45         : TBevel;
    Bevel47         : TBevel;
    Button3         : TButton;
    Button1         : TButton;
    Button2         : TButton;
    cmb_Ph_gb       : TComboBox;
    cmb_bx_gu       : TComboBox;
    cmb_no_label    : TComboBox;
    cmb_Ju_Gu       : TComboBox;
    cmb_md_cd       : TComboBox;
    cmb_gm_gu       : TComboBox;
    cmb_Ph_Cd       : TComboBox;
    cmb_po_cd2      : TComboBox;
    cmb_po_cd1      : TComboBox;
    cmb_jy_cd       : TComboBox;
    PO_cb2          : TComboEdit;
    PO_cb1          : TComboEdit;
    md_cb1          : TComboEdit;
    dte_po_dt       : TDateEdit;
    dte_Ip_Dt       : TDateEdit;
    edt_ph_yo       : TEdit;
    edt_ba_no       : TEdit;
    GroupBox3       : TGroupBox;
    GroupBox2       : TGroupBox;
    lbl_Cg_No       : TLabel;
    lbl_Lt_No       : TLabel;
    lbl_Ip_Id       : TLabel;
    Label30         : TLabel;
    lbl_Ph_Gu       : TLabel;
    Label32         : TLabel;
    Label1          : TLabel;
    Label33         : TLabel;
    Label34         : TLabel;
    Label3          : TLabel;
    Label15         : TLabel;
    Label35         : TLabel;
    Label16         : TLabel;
    Label14         : TLabel;
    Label20         : TLabel;
    Label26         : TLabel;
    Label36         : TLabel;
    Label17         : TLabel;
    Label21         : TLabel;
    Label27         : TLabel;
    Label38         : TLabel;
    Label28         : TLabel;
    Label39         : TLabel;
    Label22         : TLabel;
    lbl_Program_Name: TLabel;
    Label19         : TLabel;
    Label24         : TLabel;
    Label41         : TLabel;
    Label18         : TLabel;
    lbl_Lt_Gu       : TLabel;
    Label29         : TLabel;
    Label23         : TLabel;
    lbl_Id_Cd       : TLabel;
    Label25         : TLabel;
    msk_Sr_No       : TMaskEdit;
    msk_bx_no       : TMaskEdit;
    msk_mt_no       : TMaskEdit;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    Panel3          : TPanel;
    Panel14         : TPanel;
    pnl1            : TPanel;
    pnl_Bar_prn     : TPanel;
    PopupMenu1      : TPopupMenu;
    rce_ip_su       : TRxCalcEdit;
    rce_bx_su       : TRxCalcEdit;
    SkinData1       : TSkinData;
    btn_Add         : TSpeedButton;
    btn_Update      : TSpeedButton;
    btn_Delete      : TSpeedButton;
    btn_Inquiry     : TSpeedButton;
    btn_Link        : TSpeedButton;
    btn_query       : TSpeedButton;
    btn_excel       : TSpeedButton;
    btn_Print       : TSpeedButton;
    btn_Close       : TSpeedButton;
    btn_reset       : TSpeedButton;
    sts_Message     : TStatusBar;
    PO_Grid1        : TStringGrid;
    md_grid1        : TStringGrid;
    grd_Phon        : TStringGrid;
    TMAX            : TTMAX;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    edt_mn_no: TEdit;
    PO_Grid2: TStringGrid;
    Bevel4: TBevel;
    Label4: TLabel;
    edt_ac_no: TEdit;
    Bevel5: TBevel;
    Label5: TLabel;
    dte_gt_dt: TDateEdit;
    btn_IMEI: TSpeedButton;
    Bevel8: TBevel;
    lbl_im_ei: TLabel;
    Label6: TLabel;
    Bevel6: TBevel;

    procedure PrtFormShow;
    procedure FormCreate        (Sender: TObject);
    procedure btn_DeleteClick   (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure msk_Sr_NoExit     (Sender: TObject);
    procedure dte_Ip_DtExit     (Sender: TObject);
    procedure dte_gt_dtExit     (Sender: TObject);
    procedure dte_po_dtExit     (Sender: TObject);
    procedure grd_PhonSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure grd_PhonClick     (Sender: TObject);
    procedure btn_Next_InqClick (Sender: TObject);
    procedure btn_PrintClick    (Sender: TObject);
    procedure Button3Click      (Sender: TObject);
    procedure Button2Click      (Sender: TObject);
    procedure Button1Click      (Sender: TObject);
    procedure PO_cb1ButtonClick (Sender: TObject);
    procedure PO_Grid1Click     (Sender: TObject);
    procedure PO_Grid2Click     (Sender: TObject);
    procedure PO_cb1KeyUp       (Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dte_po_dtEnter    (Sender: TObject);
    procedure cmb_Ph_gbEnter    (Sender: TObject);
    procedure PO_cb2ButtonClick (Sender: TObject);
    procedure PO_cb2KeyUp       (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dte_Ip_DtEnter    (Sender: TObject);
    procedure md_grid1Click     (Sender: TObject);
    procedure md_cb1ButtonClick (Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmb_Ph_CdChange   (Sender: TObject);
    procedure cmb_Sp_CdChange   (Sender: TObject);
    procedure edt_ba_noKeyUp    (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure msk_mt_noExit     (Sender: TObject);
    procedure PO_cb1Change      (Sender: TObject);
    procedure Link_rtn          (var Msg : TMessage); message WM_LOSTPROJECT2;
    procedure btn_click         (Sender: TObject);
    procedure InitComponents;
    procedure disableComponents;
    procedure enableComponents;

    procedure grd_displayDrawCell (Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; State: TGridDrawState);

    procedure grd_displayKeyDown  (Sender: TObject; var Key: Word;
              Shift: TShiftState);

    procedure Copy1Click          (Sender: TObject);

    procedure StringGrid_DrawCell (Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);

    function  ExecExternProg      (progID:String):Boolean;

    procedure btn_AddClick        (Sender: TObject);
    procedure btn_InquiryClick    (Sender: TObject);
    procedure btn_UpdateClick     (Sender: TObject);
    procedure btn_resetClick      (Sender: TObject);

    procedure Edt_onKeyPress ( Sender : TObject; var key : Char);
    procedure onKeyPress(Sender : TObject;var Key : char);
    procedure edt_ba_noKeyPress(Sender: TObject; var Key: Char);
    procedure edt_mn_noKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ac_noKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure md_cb1Exit(Sender: TObject);
    procedure PO_cb2Exit(Sender: TObject);
    procedure edt_ac_noExit(Sender: TObject);
    procedure msk_mt_noKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dte_gt_dtKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_IMEIClick(Sender: TObject);

  private
    { Private declarations }

    recvedMessage:Boolean;

    //LOSTZ820Q.exe ȣ��� ���
    itemNo        :String;
    value1, value2:String;
    delYN         :String;

  public
    { Public declarations }
    procedure cmb_Ph_gbChange   (Sender: TObject);overload;
    procedure cmb_bx_guChange   (Sender: TObject);overload;

    procedure setEdtKeyPress;

  published
    procedure cmb_bx_guChange()   ; overload;
    procedure cmb_Ph_gbChange()   ; overload;
  end;

type
  THackStringGrid = class(TStringGrid);

  (* PGM_STS : ���α׷� ����  *)
  (* 0 : ��ȸ��               *)
  (* 1 : ��ȸ��               *)
  (* 2 : ������               *)
  (* 3 : ������               *)

  PGM_STS = set of 0..3;

var
  frm_LOSTA700P: Tfrm_LOSTA700P;
  pgm_sts1   : PGM_STS;
  MD_CD,SERIAL,IP_DT : string;

  PO_Grid1_d    : TZ0xxArray;
  PO_Grid2_d    : TZ0xxArray;
  md_grid1_d    : TZ0xxArray;
  cmb_Bx_Gu_d   : TZ0xxArray;
  cmb_Ph_Gb_d   : TZ0xxArray;
  cmb_Sp_Cd_d   : TZ0xxArray;
  cmb_Gm_Gu_d   : TZ0xxArray;
  cmb_Ph_Cd_d   : TZ0xxArray;
  cmb_Md_Cd_d   : TZ0xxArray;
  cmb_Po_Cd1_d  : TZ0xxArray;
  cmb_Po_Cd2_d  : TZ0xxArray;
  cmb_No_Label_d: TZ0xxArray;
  cmb_Ju_Gu_d   : TZ0xxArray;

implementation

uses u_LOSTA700P_IMEI;
{$R *.DFM}

Const
     MAXRECCNT = 10 ;
     C_BX_GU       = 'Z063';   //����������ܸ��� Box����
     C_PH_GB       = 'Z031';   //�κ�ǰ����
     C_GB_CD       = 'Z004';   //�ֹ�/�����/�ܱ��α���
     C_SP_CD       = 'Z035';   //��ǰ�ڵ�
     C_MD_CD       = 'Z008';   //���ڵ�
     C_PO_CD       = 'Z009';   //����û����ڵ�
     C_GM_GU       = 'Z038';   //����ó�����ڵ�
     C_PH_CD       = 'Z032';   //�ܸ�������ڵ�
     C_ID_CD       = 'Z001';   //������ڵ�
     C_PH_GU       = 'Z003';   //�ܸ��ⱸ���ڵ�
     C_SP_GU       = 'Z049';   //����ǰ����
     C_NO_LABEL    = 'Z053';   //�󺧾�������
     C_JU_GU       = 'Z061';   //��������
     PCS           = '1';      //PCS�ܸ���
     WASTED_PHONE  = '2';      //�󺧾���
     CHARGER       = '3';      //������
     BATTERY       = '4';      //���͸�
     CELLULAR      = '9';      //���귯
     ANALOG        = '8';      //�Ƴ��α�

type
  Talign = ( l,c,r);

  TgridData = record
    title   : string;
    width   : integer;
    align   : Talign;
    execute : string;
  end;

  arrTgrid = Array[0..48] of TgridData;

var
  arrTgrid1 : arrTgrid;
 _selRow    : integer;

(******************************************************************************)
(* procedure Name : fillTgridData(Overload)                                   *)
(* ��  ��  ��  �� : �Լ��� ���� ����ü�� �����͸� �����Ѵ�.                   *)
(******************************************************************************)
  procedure fillTgridData( var data : TgridData; title: string; width:Integer ; align : Talign;execute : string); overload;
  begin
    data.title := title;
    data.width := width;
    data.align := align;
    data.execute := execute;
  end;

(******************************************************************************)
(* procedure Name : fillTgridData(Overload)                                   *)
(* ��  ��  ��  �� : �Լ��� ���� ����ü�� �����͸� �����Ѵ�.                   *)
(******************************************************************************)
  procedure fillTgridData( var data : TgridData; title: string; width:Integer ; align : Talign); overload;
  begin
    fillTgridData( data ,title ,width ,align, '');
  end;

(******************************************************************************)
(* procedure Name : execSubProg                                               *)
(* ��  ��  ��  �� : �ش� �׸��� �����Ϳ� ������ �Լ��� �����Ѵ�.              *)
(******************************************************************************)
  function execSubProg(var data : TgridData;strValue : string): string;
  begin
    strValue := Trim(strValue);

    if (data.execute = '') then Result := strValue;

    if (UpperCase(data.execute) = 'INSHYPHEN') then result := InsHyphen(strvalue);

  end;

(******************************************************************************)
(* procedure Name : setArrGrid                                                *)
(* ��  ��  ��  �� : Ÿ��Ʋ �� �ʺ� �����Ѵ�.                                *)
(******************************************************************************)
  procedure setArrGrid(var grid : TStringGrid ; arrTgrid1 : arrTgrid);
  var i,j : Integer;
  begin

    grid.ColCount := High(ArrTgrid1);

    for i:= low(arrTgrid1) to high(arrTgrid1) do
      for j:= 0 to grid.rowcount do
        grid.cells[i,j] := '';

    with grid do
    begin
      for i := Low(arrTgrid1) to High(arrTgrid1) -1 do
      begin
        Cells[i,0] := Trim(arrTgrid1[i].title);
        if (Length(Trim(arrTgrid1[i].title)) * 10 < arrTgrid1[i].width) OR ( arrTgrid1[i].width = -1 ) then ColWidths[i] := arrTgrid1[i].width
        else ColWidths[i] := Length(Trim(arrTgrid1[i].title)) * 10;
      end;
    end;
  end;

  procedure DeleteRow(strgrd: TStringGrid; ARow: Integer);
begin
  with THackStringGrid(strgrd) do
    DeleteRow(ARow);
end;


// ������ �� �����ֱ�
procedure Tfrm_LOSTA700P.PrtFormShow;
begin
	// ��� ���̷α� �ڽ�
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet('LostB530L.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;

// ���γ��� ����
procedure detail_clear_rtn;
begin
   with frm_LOSTA700P do
   begin
      edt_ba_no.text      := '';
      edt_mn_no.text      := '';
      po_cb2.text         := '';
      cmb_ph_gb.itemindex := 0;
      cmb_ph_gb.OnChange(frm_LOSTA700P);
      md_cb1.text         := '';
      msk_sr_no.text      := '';
      msk_mt_no.text      := '';
      cmb_ju_gu.itemindex := 2;

      lbl_Lt_Gu.Caption   := '';
      lbl_Lt_No.Caption   := '';
      lbl_Id_Cd.Caption   := '';
      lbl_Ph_Gu.Caption   := '';
      lbl_Cg_No.Caption   := '';
      lbl_Ip_Id.Caption   := '';

      edt_ph_yo.text      := '';
      cmb_no_label.itemindex := -1;

      lbl_im_ei.Caption   := '';
   end;
end;

// �ڽ� ��������
procedure box_clear_rtn;
var G_col, G_row : integer;
begin
   with frm_LOSTA700P do
   begin
      cmb_bx_gu.SetFocus;

      msk_bx_no.Clear;
      cmb_bx_gu.ItemIndex := -1;
      dte_ip_dt.Date      := date;
      dte_po_dt.Date      := date;
      po_grid1.Row        := 0;
      po_cb1.Text         := '';
      rce_bx_su.Value     := 0;
      rce_ip_su.Value     := 0;

      with grd_Phon do
      Begin
         for G_col := 0 to colcount - 1 do
    	    for G_row := 1 to rowcount - 1 do
	          cells[ G_col , G_row ] := '';
         RowCount := 2;
      End;

   end;
end;

{----------------------------------------------------------------------------}
// �� ����
procedure Tfrm_LOSTA700P.FormCreate(Sender: TObject);
var i, j,_idx : integer;

function Inc2(var val : Integer): Integer;
begin
  result  := val + 1;
  val     := val + 1;
end;
begin


    //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	  //�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.

    //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	  if ParamCount <> 6 then begin
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

    // �׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
    //common_userid     := '0294';    //ParamStr(2);
    //common_username   := '��ȣ��';  //ParamStr(3);
    //common_usergroup  := 'KAIT';    //ParamStr(4);

    // ��Ų �ʱ�ȭ
    initSkinForm(SkinData1);

    {----------------------- ���� ���ø����̼� ���� ---------------------------}

    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    Application.Title := TITLE;
    fSetIcon(Application);
    pSetStsWidth(sts_Message);
    pSetTxtSelAll(Self);

    Self.BorderIcons  := [biSystemMenu,biMinimize];
    Self.Position     := poScreenCenter;

    {=========================    �׸���   �ʱ�ȭ     ===========================}
    initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );
    initStrinGridWithZ0xx('Z009.dat', PO_Grid1_d , '', '',PO_Grid1  );

    {=========================    �޺��ڽ� �ʱ�ȭ     ===========================}

    (* �ڽ�����   *)  initComboBoxWithZ0xx('Z063',cmb_Bx_Gu_d   ,'','' ,cmb_Bx_Gu  ,'          ', '', '');
    (* �ܸ������� *)  initComboBoxWithZ0xx('Z031',cmb_Ph_Gb_d   ,'','' ,cmb_Ph_Gb  );
    (* ����ó��� *)  initComboBoxWithZ0xx('Z038',cmb_Gm_Gu_d   ,'','' ,cmb_Gm_Gu  );
    (* �ܸ������ *)  initComboBoxWithZ0xx('Z032',cmb_Ph_Cd_d   ,'','' ,cmb_Ph_Cd  );
    (* �ܸ���� *)  initComboBoxWithZ0xx('Z008',cmb_Md_Cd_d   ,'','' ,cmb_Md_Cd  ,'1', '', '');
    (* ���������� *)  initComboBoxWithZ0xx('Z009',cmb_Po_Cd1_d  ,'','' ,cmb_po_cd1 );
    (* ������   *)  initComboBoxWithZ0xx('Z053',cmb_No_Label_d,'','' ,cmb_No_Label);
    (* ��������   *)  initComboBoxWithZ0xx('Z061',cmb_Ju_Gu_d   ,'','' ,cmb_Ju_Gu   );
    (* ����ǰ��� *)  // initComboBoxWithZ0xx('Z049',cmb_Sp_Gu_d,'','',cmb_Sp_Gu); // ����
    (* �����ڵ�   *)  pFillCmCdCmb('Z060',cmb_jy_cd);

    cmb_gm_gu.itemindex := 2;
    cmb_ju_gu.itemindex := 2;

    //������ �޺� ����
    for i := 0 to cmb_Po_Cd1.Items.Count -1  do
    begin
      if i = 0 then
         PO_Grid1.rowcount := 1
      else
         PO_Grid1.rowcount   := PO_Grid1.rowcount + 1;

      PO_Grid1.Cells[0,i] := cmb_Po_Cd1_d[i].name;
      PO_Grid1.Cells[1,i] := cmb_Po_Cd1_d[i].code;
      PO_Grid1.Cells[2,i] := cmb_Po_Cd1_d[i].Jcode1;

      if i = 0 then
         PO_Grid2.rowcount := 1
      else
        PO_Grid2.rowcount := PO_Grid2.rowcount + 1;

      PO_Grid2.Cells[0,i] := cmb_Po_Cd1_d[i].name;
      PO_Grid2.Cells[1,i] := cmb_Po_Cd1_d[i].code;
      PO_Grid2.Cells[2,i] := cmb_Po_Cd1_d[i].Jcode1;
    end;

    setEdtKeyPress;

    //FillChar(arrTgrid1,SizeOf(arrTgrid1),#0);

    _idx := 0;

    {------------------------- ��Ʈ�� �׸��� ���� -----------------------------}

    msk_mt_no.OnKeyPress :=  Self.onKeyPress;

    edt_ba_no.OnKeyPress := edt_ba_noKeyPress;
    edt_mn_no.OnKeyPress := edt_mn_noKeyPress;
    edt_ac_no.OnKeyPress := edt_ac_noKeyPress;
    edt_ac_no.OnExit := edt_ac_noExit;

    fillTgridData(arrTgrid1[     _idx ],'�԰�����            ',100 ,c,'InsHyphen');
    fillTgridData(arrTgrid1[Inc2(_idx)],'������������ȣ      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'ȹ�����            ',60  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'���ڵ�            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�𵨸�              ',100 ,l);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ����Ϸù�ȣ      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'����ó�����ڵ�      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'����ó���и�        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ�������ڵ�      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ�����¸�        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�������ֹλ���ڹ�ȣ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�����ڱ����ڵ�      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�����ڼ����ü��    ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'����ڽĺ��ڵ�      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'����ڽĺ��ڵ��    ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ���κ�ǰ�����ڵ�',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ���κ�ǰ������  ',100 ,l);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ��ⱸ���ڵ�      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ��ⱸ�и�        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�����ʿ俩��        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�Ҹ�����ڵ�        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�Ҹ����            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'â���Ϸù�ȣ        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�԰���ID            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�԰��ڸ�            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�������ڵ�          ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'��������            ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�̵���ȭ��ȣ        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�ܸ�������          ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�󺧾������и�      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�н������������ڵ�  ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'�н����������и�    ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'��������            ',100 ,c,'InsHyphen');
    fillTgridData(arrTgrid1[Inc2(_idx)],'IMEI�ڵ�            ',-1  ,c);

    setArrGrid(grd_Phon,arrTgrid1);
    {--------------------------------------------------------------------------}

    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA700P.InitComponents;
var
  i ,j: Integer;
  component : TComponent;

  strTmp : array[0..6] of String;
begin

  MD_CD   := '';
  SERIAL  := '';
  IP_DT   := '';

  FillChar(component,SizeOf(component),#0);

  strTmp[0] := dte_Ip_Dt.Text;
  strTmp[1] := msk_bx_no.Text;
  strTmp[2] := IntToStr(cmb_bx_gu.ItemIndex);
  strTmp[3] := PO_cb1.Text;
  strTmp[4] := dte_po_dt.Text;
  strTmp[5] := rce_bx_su.Text;

  if rce_ip_su.Text = '' then strTmp[6] := '0'
  else strTmp[6] := rce_ip_su.Text;

  {-------------------------    ���ʵ� �ʱ�ȭ    ----------------------------}
  lbl_Cg_No.Caption := '';
  lbl_Ip_Id.Caption := '';
  lbl_Lt_No.Caption := '';
  lbl_Ph_Gu.Caption := '';
  lbl_Id_Cd.Caption := '';
  lbl_Lt_Gu.Caption := '';
  lbl_im_ei.Caption := '';

  {-------------------------    �ε��� �ʱ�ȭ      ----------------------------}
  cmb_gm_gu.ItemIndex     :=  2;
  cmb_Bx_Gu.ItemIndex     :=  0;
  cmb_Gm_Gu.ItemIndex     := -1;
  cmb_no_label.ItemIndex  := -1;

  {----------------------------------------------------------------------------}

  // ��ư�̹��� �ʱ�ȭ
  changeBtn(Self);

  btn_Print.Enabled := True;

  cmb_no_label.enabled  := false;

  Self.cmb_bx_guChange();
  self.cmb_Ph_gbChange();

  // ���� �ʱ�ȭ
  dte_Ip_Dt.date := date;
  dte_po_dt.Date := Date;
  dte_gt_dt.Text := '';

  for i := 0 to componentcount -1 do
  begin
    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
    else
    if ( Components[i] is TMaskEdit) then
       ( Components[i] as TMaskEdit).Text := ''
    else
    if (  Components[i] is TComboEdit) then
       ( Components[i] as  TComboEdit).Text := '';
  end;

  if (pgm_sts1 <> [2]) and (delYN = 'N') then
  begin
    for i := grd_Phon.FixedRows to grd_Phon.RowCount -1 do
      grd_Phon.Rows[i].Clear;

    grd_Phon.RowCount           :=   2;
    sts_Message.Panels[1].Text  :=  '';
    pgm_sts1                    := [0];
  end;

  rce_bx_su.Text := '0';
  rce_ip_su.Text := '0';

  if pgm_sts1 = [2] then
  begin
    dte_Ip_Dt.Text      := strTmp[0];
    msk_bx_no.Text      := strTmp[1];
    cmb_bx_gu.ItemIndex := StrToInt(strTmp[2]);
    PO_cb1.Text         := strTmp[3];
    dte_po_dt.Text      := strTmp[4];
    rce_bx_su.Text      := strTmp[5];
    rce_ip_su.Text      := IntToStr(StrToint(strTmp[6]) -1) ;
  end;

  PO_cb1.SetFocus;

  delYN := 'N';

end;


procedure Tfrm_LOSTA700P.btn_DeleteClick(Sender: TObject);
var
  STR001,STR002,STR003,STR004 : string;

  Label LIQUIDATION;
begin
  if pgm_sts1 = [0] then
  begin
    ShowMessage('��ȸ �� �����Ͻ� �� �ֽ��ϴ�.');
    Exit;
  end;

  if MessageDlg('���� �����Ͻðڽ��ϱ� ?',
    mtConfirmation, mbOkCancel, 0) = mrCancel then
  begin
    sts_Message.Panels[1].text := '������ ��ҵǾ����ϴ�.';
    Exit;
  end;

  if( not fChkLength(dte_Ip_Dt  ,8,0,'�԰�����'           )) then Exit;
  if( not fChkLength(msk_bx_no  ,6,0,'�ڽ��Ϸù�ȣ'       )) then Exit;
  if( not fChkLength(md_cb1     ,1,1,'���ڵ�'           )) then Exit;
  if( not fChkLength(msk_Sr_No  ,1,1,'�ܸ����Ϸù�ȣ'     )) then Exit;


  STR001 := delhyphen(dte_Ip_Dt.Text);
  STR002 := msk_bx_no.Text;
  STR003 := findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d));
  STR004 := Trim(msk_Sr_No.Text);

  delYN := 'Y';

  MD_CD   := STR003;
  SERIAL  := STR004;
  IP_DT   := STR001;

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

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA700P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','D01'            )  < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001' , STR001         )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002' , STR002         )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003' , STR003         )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004' , STR004         )  < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTA700P') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' ���� �Ϸ�';

  ShowMessage('���������� �����Ͽ����ϴ�.');

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  DeleteRow(grd_Phon,grd_Phon.Row);

  pgm_sts1 := [2];

  InitComponents;

  Exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTA700P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

// �ø����ȣ �Է� �� ����
procedure Tfrm_LOSTA700P.msk_Sr_NoExit(Sender: TObject);
var tempstr1, tempstr2 : shortstring;
    tempchr : char;
begin
   with msk_Sr_No do
   begin
      text := CRemoveSpace(text);
      if length(text) = 0 then exit;

      tempstr1 := uppercase(copy(text,1,1));

      CStrToArr(tempstr1, tempchr, False);

//      if tempchr in ['A'..'Z'] then
//      begin
//         tempstr2 := copy(text,2,length(text)-1);
//         tempstr2 := CFillStr(tempstr2, ' ', 16, false);
//         text     := tempstr1 + tempstr2;
//      end
//      else
//      begin
//       //tempstr2 := CFillStr(text, ' ', 16, false);
//       //text     := tempstr2;
//      end;
   end;
end;

procedure Tfrm_LOSTA700P.dte_Ip_DtExit(Sender: TObject);
begin
  try
    dte_Ip_Dt.Date := strtodate(dte_Ip_Dt.text);
  except
    on E: EConvertError do
    begin
      ShowMessage('���� �Է��� �߸��Ǿ����ϴ�'+#13+'�������ڷ� ����˴ϴ�');
      dte_Ip_Dt.date := date;
      dte_Ip_Dt.setfocus;
    end;
  end;
end;

procedure Tfrm_LOSTA700P.dte_gt_dtExit(Sender: TObject);
begin
  try
    dte_gt_dt.Date := strtodate(dte_gt_dt.text);
  except
    on E: EConvertError do
    begin
      ShowMessage('���� �Է��� �߸��Ǿ����ϴ�'+#13+'�������ڷ� ����˴ϴ�');
      dte_Ip_Dt.date := date;
      dte_Ip_Dt.setfocus;
    end;
  end;
end;

procedure Tfrm_LOSTA700P.cmb_Ph_gbChange(sender : TObject);
begin
  Self.cmb_Ph_gbChange;
end;
// �ܸ��� ���� ����
procedure Tfrm_LOSTA700P.cmb_Ph_gbChange();
var i : integer;
begin

   // �Ƴ��α� �ܸ����� ��� �޺��� �Ƴ��α� �ܸ��⸸ ����
   // �ƴѰ�� ��ü
   if cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = ANALOG then
   begin
      initComboBoxWithZ0xx('Z008',cmb_Md_Cd_d,'','' ,cmb_Md_Cd  ,'', 'A', '');
   end
   else
   begin
      initComboBoxWithZ0xx('Z008',cmb_Md_Cd_d,'','' ,cmb_Md_Cd  ,cmb_ph_gb_d[cmb_ph_gb.itemIndex].code, '', '');
   end;

   // �޺��� ����� �𵨸��� �׸��忡 �����Ѵ�.
   for i := 0 to cmb_md_Cd.Items.Count-1 do
   begin
      if i = 0 then
         md_Grid1.rowcount := 1
      else
         md_Grid1.rowcount := md_Grid1.rowcount + 1;

      md_Grid1.Cells[0,i] := trim(Copy(cmb_md_cd.Items[i],1,40));
//      md_Grid1.Cells[1,i] := trim(Copy(cmb_md_cd.Items[i],41,10));
//      md_Grid1.Cells[2,i] := trim(Copy(cmb_md_cd.Items[i],51,10));
   end;

   md_grid1.Row := 0;

   // �ܸ��� ������ 'PCS','���귯','�Ƴ��α�'�� ���
   // �� �޺��� ''���� �����Ѵ�. �� �׷����� �𸣰���
   // �ƴѰ�� �׸����� ó�� ���� �־��ش�.
   if ( cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = PCS ) or
      ( cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = CELLULAR ) or
      ( cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = ANALOG ) then
       md_cb1.text := ''
   else
       md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];

   // �ܸ��� ���� , ��ǰ��, ��ǰ���� ���� ����
   cmb_ph_cd.itemindex := 0;
   //cmb_sp_cd.itemindex := -1;
   //cmb_sp_gu.itemindex := -1;

   // �� ������ ���� ��, ������, ���͸��ΰ��
   if (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = WASTED_PHONE) or
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = CHARGER) or
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = BATTERY) then
   begin
      // �ø����ȣ Ŭ����
      msk_sr_no.text := '0000';
      msk_sr_no.Enabled := false;

      lbl_im_ei.Caption   := '';

      // �ܸ��� �����ڵ� ���Ұ�
      cmb_ph_cd.enabled := false;
   end
   else
   begin
      cmb_ph_cd.enabled := true;

      msk_sr_no.text := '';
      msk_sr_no.Enabled := True;

      lbl_im_ei.Caption   := '';
   end;

   cmb_no_label.itemindex := -1;

   if (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = WASTED_PHONE) then
      cmb_no_label.enabled := True
   else
      cmb_no_label.enabled := False;

end;

procedure Tfrm_LOSTA700P.dte_po_dtExit(Sender: TObject);
begin
   try
      dte_po_Dt.Date := strtodate(dte_po_Dt.text);
      except
      on E: EConvertError do
      begin
         ShowMessage('���� �Է��� �߸��Ǿ����ϴ�'+#13+
          	     '�������ڷ� ����˴ϴ�');
         dte_po_Dt.date := date;
         dte_po_Dt.setfocus;
      end;
   end;

end;

procedure Tfrm_LOSTA700P.cmb_bx_guChange(Sender : TObject);
begin
  self.cmb_bx_guChange;
end;

procedure Tfrm_LOSTA700P.cmb_bx_guChange();
begin
  po_cb1.enabled      := true;
  po_cb2.enabled      := false;
  dte_po_dt.enabled   := true;
  rce_bx_su.enabled   := true;
  cmb_gm_gu.itemindex := 2;
end;

procedure Tfrm_LOSTA700P.grd_PhonSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   _selRow := ARow;
end;

// �ϴ� �׸��� Ŭ���� �ش� �����͸� ä��
procedure Tfrm_LOSTA700P.grd_PhonClick(Sender: TObject);
var tempstr, tempdt1 : shortstring;
    i : integer;
begin
   // 0. ����û������ȣ
   edt_mn_no.Text := trim(grd_phon.Cells[1,_selRow]);

   // 0. ����ûȹ�����
   edt_ac_no.Text := trim(grd_phon.Cells[2,_selRow]);

   // 1. �ܸ��� ����
   cmb_ph_gb.itemindex := cmb_ph_Gb.items.IndexOf(Trim(grd_phon.Cells[16,_selRow]));

   // �ܸ��� ���� �������� ���� �̺�Ʈ �߻�
   cmb_Ph_gb.OnChange(frm_LOSTA700P);

   // 2. �𵨸�
   md_cb1.Text := trim(copy(grd_phon.cells[4,_selRow],1,40));

  for i := 0 to md_grid1.RowCount-1 do
    if Trim(md_grid1.Cells[0,i]) = md_cb1.text then
    begin
      md_grid1.Row := i;
      break;
    end;

   // 3. �Ϸù�ȣ
   msk_Sr_No.Text       := trim(grd_phon.Cells[5,_selRow]);

   // 4. �ܸ��� ���±���
   cmb_Ph_Cd.itemindex  := cmb_Ph_Cd.items.IndexOf
                           (trim(grd_phon.Cells[9,_selRow]));

   // 5.����ó����

   cmb_Gm_Gu.itemindex  := cmb_Gm_Gu.items.IndexOf
                           (trim(grd_phon.Cells[7,_selRow]));

   // 6.�н��� �ֹ�/�����/�ܱ��ι�ȣ
   lbl_Lt_No.Caption := grd_phon.cells[10,_selRow];


   // 7.�н��� ����
   lbl_Lt_Gu.Caption := grd_phon.cells[12,_selRow];

   // 8.��� ���� �����
   lbl_Id_Cd.Caption := grd_phon.cells[14,_selRow];

   // 9.�ܸ��� ����
   lbl_Ph_Gu.Caption := grd_phon.cells[18,_selRow];

   // 10.â�� ��ȣ
   lbl_Cg_No.Caption := grd_phon.cells[22,_selRow];

   // 11.�԰� �Է���
   lbl_Ip_Id.Caption := grd_phon.cells[23,_selRow];

   // 12.��������
   po_cb2.Text := trim(grd_phon.cells[26,_selRow]);

   for i := 0 to PO_Grid2.RowCount-1 do
    if po_cb2.Text = copy(PO_Grid2.cells[0,i],1,length(po_cb2.text)) then
    begin
       PO_Grid2.Row := i;
       break;
    end;

   // 13.�̵���ȭ��ȣ
   if (Copy(trim(grd_phon.cells[27,_selRow]),0,3) = '001') then
    msk_mt_no.text := Copy(trim(grd_phon.cells[27,_selRow]),2,Length(trim(grd_phon.cells[27,_selRow]))-1)
   else
    msk_mt_no.text         := trim(grd_phon.cells[27,_selRow]);

   // 14.�ܸ��� ����
   edt_ph_yo.text         := trim(grd_phon.cells[28,_selRow]);

   // 15.�� ���� ���и�
   cmb_no_label.itemindex := cmb_No_Label.items.IndexOf
                             (grd_phon.cells[29,_selRow]);

   // 16.�н����������и�
   cmb_ju_gu.itemindex := cmb_ju_gu.items.IndexOf
                          (grd_phon.Cells[31,_selRow]);

  // 17.���ڵ� ��ȣ
  edt_ba_no.Text := grd_phon.cells[3,_selRow]
                  + grd_phon.cells[5,_selRow]
                  + delHyphen(grd_phon.cells[0,_selRow]);

  // 18.��������
  //dte_gt_dt.Text := InsHyphen(grd_phon.cells[32,_selRow]);
  dte_gt_dt.Text := grd_phon.cells[32,_selRow];

  // IMEI�ڵ�
   lbl_im_ei.Caption := trim(grd_phon.cells[33,_selRow]);

end;

procedure Tfrm_LOSTA700P.btn_Next_InqClick(Sender: TObject);
begin
   detail_clear_rtn;
   box_clear_rtn;
   cmb_bx_gu.setfocus;
end;

procedure Tfrm_LOSTA700P.btn_PrintClick(Sender: TObject);
begin
//   if (length(trim(lbl_cg_no.caption)) <> 6) or
//      (savkey.ba_no <> edt_Ba_No.text ) or
//      (savkey.md_cd <> md_cb1.text) or
//      (savkey.sr_no <> msk_sr_no.text) or
//      (savkey.ip_dt <> dte_ip_dt.text) then
//   begin
//      sts_Message.Panels[1].Text := '';
//      showmessage('��ȸ�� �۾��ϼ���.');
//      exit;
//   end;
//

   if (not fChkLength(md_cb1    , 1,1,'���ڵ�'    ))  then Exit;
   if (not fChkLength(msk_sr_no , 1,1,'�Ϸù�ȣ'    ))  then Exit;
   if (not fChkLength(dte_ip_dt , 8,0,'�԰�����'    ))  then Exit;

   pnl_bar_prn.Visible := true;

   button1.SetFocus;
end;

procedure Tfrm_LOSTA700P.Button3Click(Sender: TObject);
begin
   pnl_bar_prn.Visible := false;

   btn_resetClick(Sender);

end;

procedure Tfrm_LOSTA700P.Button2Click(Sender: TObject);
var
  remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;

  serviceSuccess:Boolean;
  FSFTP:TSimpleSFTP;

  STR001, STR002, STR003: STring;

  Label LIQUIDATION;
begin
  self.disableComponents;

  STR001 := '';
  STR002 := '';
  STR003 := '';

  if(Length(edt_ba_no.Text) >= 18 ) then
    begin
    	STR001 := copy(Trim(edt_ba_no.Text),0,4)  ;	// ���ڵ�
      STR002 := copy(Trim(edt_ba_no.Text),5,Length(edt_ba_no.Text) - 12);	// �ܸ����Ϸù�ȣ
      STR003 := copy(Trim(edt_ba_no.Text),Length(edt_ba_no.Text) - 7,8);	// �԰�����
    end
    else
    begin
      if ( not fChkLength(md_cb1    ,1,1,'���ڵ�')      )  then exit;
      if ( not fChkLength(msk_Sr_No ,1,1,'�ܸ����Ϸù�ȣ'))  then exit;
      if ( not fChkLength(dte_Ip_Dt ,8,0,'�԰�����')      )  then exit;

      STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d));	// ���ڵ�
      STR002 := msk_Sr_No.Text;			                                          // �ܸ����Ϸù�ȣ
      STR003 := delHyphen(dte_Ip_Dt.Text);	                                  // �԰�����
    end;

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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA700P')     < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  serviceSuccess := TMAX.Call('LOSTA700P');

  if not serviceSuccess then
  begin
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  //���� �н��� ��´�.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  //���ϸ��� ��´�.
  fileName:= getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //�������� ������ ���۹޾� ..\KAI\LostPrj\temp �� �����Ѵ�.
  FSFTP:=TSimpleSFTP.Create;
  //SFTP ���� ����
//  FSFTP.Connect(fGetftpIp(),fGetftpPort(), fGetftpId(), fGetftpPw());

    FSFTP.Connect(TMAX.Host
                 ,TMAX.RecvString('STR402',0)
                 ,TMAX.RecvString('STR403',0)
                 ,TMAX.RecvString('STR404',0)
                 );

	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  //TransferProgress(nil,0,0);
  //FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,TransferProgress,nil);
  FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,nil,nil);
  FSFTP.Disconnect;
  FSFTP.Free;

  self.enableComponents;

  //��� ���̾�α׸� ������.
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(getDirPath(fileName,'_') + '.txt', lbl_Program_Name.Caption,'P',63,29,14,80,60);

	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;

  btn_resetClick(sender);

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  self.enableComponents;
end;

procedure Tfrm_LOSTA700P.Button1Click(Sender: TObject);
var
  remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;

  serviceSuccess:Boolean;
  FSFTP:TSimpleSFTP;

  STR001, STR002, STR003: STring;

  Label LIQUIDATION;
begin
  self.disableComponents;

  STR001 := '';
  STR002 := '';
  STR003 := '';

  if(Length(edt_ba_no.Text) >= 18 ) then
  begin
    STR001 := copy(Trim(edt_ba_no.Text),0,4)  ;	// ���ڵ�
    STR002 := copy(Trim(edt_ba_no.Text),5,Length(edt_ba_no.Text) - 12);	// �ܸ����Ϸù�ȣ
    STR003 := copy(Trim(edt_ba_no.Text),Length(edt_ba_no.Text) - 7,8);	// �԰�����
  end
  else
  begin
    if ( not fChkLength(md_cb1    ,1,1,'���ڵ�')      )  then exit;
    if ( not fChkLength(msk_Sr_No ,1,1,'�ܸ����Ϸù�ȣ'))  then exit;
    if ( not fChkLength(dte_Ip_Dt ,8,0,'�԰�����')      )  then exit;

    STR001 := findCodeFromName(md_cb1.Text, md_grid1_d,Length(md_grid1_d));	// ���ڵ�
    STR002 := msk_Sr_No.Text;			                                          // �ܸ����Ϸù�ȣ
    STR003 := delHyphen(dte_Ip_Dt.Text);	                                  // �԰�����
  end;

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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA700P')     < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P02') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  serviceSuccess := TMAX.Call('LOSTA700P');

  if not serviceSuccess then
  begin
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  //���� �н��� ��´�.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  //���ϸ��� ��´�.
  fileName:= getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //�������� ������ ���۹޾� ..\KAI\LostPrj\temp �� �����Ѵ�.
  FSFTP:=TSimpleSFTP.Create;

  FSFTP.Connect(TMAX.Host
               ,TMAX.RecvString('STR402',0)
               ,TMAX.RecvString('STR403',0)
               ,TMAX.RecvString('STR404',0)
               );

	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  //TransferProgress(nil,0,0);
  //FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,TransferProgress,nil);
  FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,nil,nil);
  FSFTP.Disconnect;
  FSFTP.Free;

  self.enableComponents;

  //��� ���̾�α׸� ������.
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(getDirPath(fileName,'_') + '.txt'   // ���ϸ�
                    , lbl_Program_Name.Caption            // ���α׷���
                    , 'P'                                 // ��¹��� L : ���� P: ����
                    , 63                                  // �������� ��� ���μ�
                    , 28                                  // ���� ����
                    , 15                                  // ���� �簣��
                    , 40                                  // ���� �߰� ����
                    , 60 );                               // ���� ����
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;

  btn_resetClick(Sender);

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  self.enableComponents;
end;

procedure Tfrm_LOSTA700P.PO_cb1ButtonClick(Sender: TObject);
begin
   po_cb1.onButtonClick := nil;
   po_cb1.OnKeyUp       := nil;
   po_grid1.OnClick     := nil;

   if not PO_Grid1.Visible then
   begin
     PO_Grid1.Visible := true;
   end else
     PO_Grid1.Visible := false;

   po_cb1.OnButtonClick := PO_cb1ButtonClick;
   po_cb1.OnKeyUp       := po_cb1KeyUp;
   po_grid1.OnClick     := PO_Grid1Click;
end;

procedure Tfrm_LOSTA700P.PO_Grid1Click(Sender: TObject);
begin
   po_cb1.text := po_grid1.Cells[0,po_grid1.row];
   po_cb1.OnChange(frm_LOSTA700P);
   po_cb1.SetFocus;
   po_grid1.Visible := false;
end;

procedure Tfrm_LOSTA700P.PO_Grid2Click(Sender: TObject);
begin
   po_cb2.text :=po_grid2.Cells[0,po_grid2.row];
   //po_cb2.SetFocus;
   po_grid2.Visible := false;
end;

procedure Tfrm_LOSTA700P.PO_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin
   po_cb1.OnChange      := nil;
   po_cb1.onButtonClick := nil;
   po_cb1.OnKeyUp       := nil;
   po_grid1.OnClick     := nil;

   // �����ϰ��
   if key = 13 then
   begin
      if po_grid1.Visible then
         po_grid1.Visible := false
      else
        po_grid1.Visible := true;
        po_cb1.Text := '';
        po_cb1.Text := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;

   // ����Ű ���� ���
   end else if (key = vk_up) and (po_grid1.Visible) then
   begin
      if po_grid1.row > 0 then
      po_grid1.Row  := po_grid1.Row - 1;
        po_cb1.Text := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;
   end else if key = vk_escape then
   begin
      po_grid1.Visible := false;
   end else if (key = vk_down) and (po_grid1.Visible) then
   begin
      if po_grid1.row < po_grid1.RowCount-1 then
        po_grid1.Row  := po_grid1.Row + 1;
        po_cb1.Text   := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;
   end else if (trim(po_cb1.Text) <> '') and (key <> 229) then
   begin
      if not po_grid1.Visible then
         po_grid1.Visible := true;

      for i := 0 to po_grid1.RowCount-1 do
      if po_cb1.Text = copy(po_grid1.cells[0,i],1,length(po_cb1.text)) then
      begin
         po_grid1.Row := i;
         break;
      end;
   end;

   po_cb1.OnChange      := PO_cb1Change;
   po_cb1.OnButtonClick := PO_cb1ButtonClick;
   po_cb1.OnKeyUp       := po_cb1KeyUp;
   po_grid1.OnClick     := PO_Grid1Click;

   if ( (key = 13) or (key = vk_escape) ) and ( not po_grid1.visible) then
      po_cb1.OnChange(frm_LOSTA700P);
end;

procedure Tfrm_LOSTA700P.dte_po_dtEnter(Sender: TObject);
begin
   po_grid1.Visible := false;
end;

procedure Tfrm_LOSTA700P.cmb_Ph_gbEnter(Sender: TObject);
begin
   po_grid2.Visible := true;
end;

// ���� ������ �޺� ��ư Ŭ���� �׸��带 �����ְ� �ƴϸ� �����.
procedure Tfrm_LOSTA700P.PO_cb2ButtonClick(Sender: TObject);
begin
//   po_cb2.onButtonClick := nil;
//   po_cb2.OnKeyUp := nil;
//   po_grid2.OnClick := nil;
//
//   if not PO_Grid2.Visible then
//   begin
//     PO_Grid2.Visible := true;
//   end else
//     PO_Grid2.Visible := false;
//
//   po_cb2.OnButtonClick := PO_cb2ButtonClick;
//   po_cb2.OnKeyUp := po_cb2KeyUp;
//   po_grid2.OnClick := PO_Grid2Click;
end;

// ���� ������ �޺� Ű���� �߻��Ǵ� �̺�Ʈ
procedure Tfrm_LOSTA700P.PO_cb2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin
//   po_cb2.onButtonClick := nil;
//   po_cb2.OnKeyUp := nil;
//   po_grid2.OnClick := nil;
//
//   if key = 13 then
//   begin
//      if po_grid2.Visible then
//         po_grid2.Visible := false
//      else
//         po_grid2.Visible := true;
//      po_cb2.Text := '';
//      po_cb2.Text := po_grid2.Cells[0,po_grid2.Row];
//      po_cb2.SelectAll;
//   end else
//   if (key = vk_up) and (po_grid2.Visible) then
//   begin
//      if po_grid2.row > 0 then
//         po_grid2.Row := po_grid2.Row - 1;
//      po_cb2.Text := po_grid2.Cells[0,po_grid2.Row];
//      po_cb2.SelectAll;
//   end else
//   if key = vk_escape then
//   begin
//      po_grid2.Visible := false;
//   end else
//   if (key = vk_down) and (po_grid2.Visible) then
//   begin
//      if po_grid2.Row < po_grid2.RowCount-1 then
//         po_grid2.Row := po_grid2.Row + 1;
//      po_cb2.Text := po_grid2.Cells[0,po_grid2.Row];
//      po_cb2.SelectAll;
//   end else
//   if (trim(po_cb2.Text) <> '') and (key <> 229) then
//   begin
//      if not po_grid2.Visible then
//         po_grid2.Visible := true;
//      for i := 0 to po_grid2.RowCount-1 do
//      if po_cb2.Text = copy(po_grid2.cells[0,i],1,length(po_cb2.text)) then
//      begin
//         po_grid2.Row := i;
//         break;
//      end;
//   end;
//
//   po_cb2.OnButtonClick := PO_cb2ButtonClick;
//   po_cb2.OnKeyUp := po_cb2KeyUp;
//   po_grid2.OnClick := PO_Grid2Click;
end;

// �԰����� ���� ���� ��
procedure Tfrm_LOSTA700P.dte_Ip_DtEnter(Sender: TObject);
begin
   po_grid1.Visible := false;
   po_grid2.Visible := false;
   md_grid1.Visible := false;
end;

// �� �׸��� Ŭ���� ����
procedure Tfrm_LOSTA700P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

// �� �޺� Ŭ���� ����
procedure Tfrm_LOSTA700P.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   if not md_Grid1.Visible then
   begin
      md_Grid1.Visible := true;
   end else
      md_Grid1.Visible := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;

end;

// �� �޺� Ű���� ����
procedure Tfrm_LOSTA700P.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   if key = 13 then
   begin
      if md_grid1.Visible then
        md_grid1.Visible  := false
      else
        md_grid1.Visible  := true;
        md_cb1.Text       := '';
        md_cb1.Text       := md_grid1.Cells[0,md_grid1.Row];
        md_cb1.SelectAll;
   end else
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
        md_grid1.Row  := md_grid1.Row - 1;
        md_cb1.Text   := md_grid1.Cells[0,md_grid1.Row];
        md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
        md_grid1.Row  := md_grid1.Row + 1;
        md_cb1.Text   := md_grid1.Cells[0,md_grid1.Row];
        md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then  md_grid1.Visible := true;

      for i := 0 to md_grid1.RowCount-1 do
        if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
        begin
           md_grid1.Row := i;
           break;
        end;
   end;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

procedure Tfrm_LOSTA700P.cmb_Ph_CdChange(Sender: TObject);
begin
   if (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> PCS      ) and
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> CELLULAR ) and
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> ANALOG   ) then
       exit;
end;

procedure Tfrm_LOSTA700P.cmb_Sp_CdChange(Sender: TObject);
begin
   //cmb_sp_gu.itemindex := 0;
end;

procedure Tfrm_LOSTA700P.edt_ba_noKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
   begin
    btn_InquiryClick(Sender);
   end;

   if key = 107 then
   begin
    btn_AddClick(Sender);
   end;
end;

// �̵���ȭ��ȣ����
procedure Tfrm_LOSTA700P.msk_mt_noExit(Sender: TObject);
var tempstr1, tempstr2, tempstr3 : shortstring;
begin
   if CRemoveSpace(msk_mt_no.text) = '' then
   begin
      msk_mt_no.text := '';
      exit;
   end;

   tempstr1 := CRemoveSpace(copy(msk_mt_no.text,1,3));
   tempstr2 := CRemoveSpace(copy(msk_mt_no.text,4,4));
   tempstr3 := CRemoveSpace(copy(msk_mt_no.text,8,4));

   if tempstr1 <> '' then
      tempstr1 := CFillStr(tempstr1, '0', 3, false)
   else
      tempstr1 := CFillStr(tempstr1, ' ', 3, false);
   if tempstr2 <> '' then
      tempstr2 := CFillStr(tempstr2, '0', 4, false)
   else
      tempstr2 := CFillStr(tempstr2, ' ', 4, false);
   if tempstr3 <> '' then
      tempstr3 := CFillStr(tempstr3, '0', 4, false);

   if CRemoveSpace(tempstr1+tempstr2+tempstr3) = '' then
      msk_mt_no.text := ''
   else if CRemoveSpace(tempstr2+tempstr3) = '' then
      msk_mt_no.text := tempstr1
   else
      msk_mt_no.text := tempstr1 + tempstr2 + tempstr3;
end;

// ���� �������� �����
procedure Tfrm_LOSTA700P.PO_cb1Change(Sender: TObject);
var i : integer;
begin

   //initStrinGridWithZ0xx('Z009.dat',cmb_Po_Cd2_d  ,'','' ,PO_Grid2 ,'',PO_Grid1.Cells[1,PO_Grid1.row],'');

   //po_cb2.Text := '';
   po_cb2.Text := po_cb1.Text;

   po_grid2.Row := 0;
end;

procedure Tfrm_LOSTA700P.btn_click(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin
  if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit)) then
  begin
    if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
    else  mskEdt := Sender as TMaskEdit;

  end;

  CreateMap;	//�����޸� ����
  self.ExecExternProg('LOSTZ800Q');

end;

//'LOSTZ810Q.exe'���� �޼����� �����ش�.
procedure Tfrm_LOSTA700P.Link_rtn (var Msg : TMessage);
var
  (**************************************************)
  (*  localcloud.pas                                *)
  (*  type :TPSharedMem                             *)
  (*  Using       :Integer;		  //�����=1,�̻��=0 *)
  (*  ProgID      :String[30];	//������� ���α׷� *)
  (*                                                *)
  (*  name        :String[30];                      *)
  (*  model_name  :String[30];                      *)
  (*  model_code  :String[30];                      *)
  (*  serial_no   :String[30];                      *)
  (*  ibgo_date   :String[30];                      *)
  (*  birth       :String[30];                      *)
  (*  phone_no    :String[30];                      *)
  (**************************************************)
  smem  :TPSharedMem;
  //modelName, serial_no, ibgoil:String;
  //str:String;

begin
	//'LOSTZ810.exe'���� ���� �޼����� �޾Ҵ�.
	recvedMessage:= True;

  //�����޸� ������ �ʿ俩�δ� wparam�� ������ ��.
  if Msg.wParam = 1 then
  begin
    //�����޸𸮸� ��´�.
    smem:= OpenMap;

    if smem <> nil then
    begin
      Lock;  //���� ���ӹ���

      //if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //�����޸𸮸� ��� ��.
      CloseMapMain;
      smem:= nil;
    end;


  end;

    ShowWindow(Self.Handle, SW_SHOW     );
    ShowWindow(Self.Handle, SW_RESTORE  );
end;

function Tfrm_LOSTA700P.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  (****************************************************************************)
  (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
    			      (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '12'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  '1'
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  value1
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  value2
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle, SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);

		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');

    ShowWindow(Self.Handle, SW_SHOW     );
    ShowWindow(Self.Handle, SW_RESTORE  );
  end;

end;

procedure Tfrm_LOSTA700P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid: TStringGrid;
  S     :String;
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
      case arrTgrid1[ACol].align of
        l : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
        c : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
        r : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
        else ShowMessage(IntToStr(ACol) + '�� ���� ������ �ٸ��ϴ�.');
      end;
    end;

{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;

procedure Tfrm_LOSTA700P.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTA700P.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_Phon.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_Phon.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_Phon.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

(******************************************************************************)
(* procedure Name : StringGrid_DrawCell                                       *)
(* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.                     *)
(******************************************************************************)
procedure Tfrm_LOSTA700P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA700P.btn_AddClick(Sender: TObject);
var
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  str_mtno, str_imei, seed_mtno, seed_imei : String;

  // ���� �Ķ����
  STRVALUE : array[1..33] of string;

  // ���� ���� ��ȣ ex) 001,002..xxx
  STRNUM : string;

  // ���� ���� �Ķ���� ex) I01,U01,D01..
  svcNm  : string;

  // ��������
  i : Integer;
  Label LIQUIDATION;
begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  str_mtno := '';
  str_imei := '';
  seed_mtno := '';
  seed_imei := '';

  if (rce_bx_su.AsInteger <= 0 ) then
  begin
    ShowMessage('Box�� ������ 0���� Ŀ���մϴ�.');
    Exit;
  end;

  // ���� ���� �Ķ���� ����
  if Sender is TSpeedButton then
    if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

  if Sender is TMaskEdit then
    if ((sender as TMaskEdit).Name = 'msk_mt_no')
      then svcNm := 'I01';

  if ( (pgm_sts1 = [1]) and (svcNm = 'I01')) then
  begin
    ShowMessage('�ʱ�ȭ �� �����Ͻ� �� �ֽ��ϴ�.');
    Exit;
  end else if (( pgm_sts1 = [0]) and (svcNm = 'U01')) then
  begin
    ShowMessage('��ȸ �� �����Ͻ� �� �ֽ��ϴ�.');
    Exit;
  end;

  if (rce_bx_su.AsInteger = rce_ip_su.AsInteger) AND (svcNm = 'I01') then
  begin
    ShowMessage('�̹� ��� �ڽ�������ŭ �Է��ϼ̽��ϴ�.');
    Exit;
  end;

  if( not fChkLength(dte_Ip_Dt  ,8,0,'�԰�����'                 )) then Exit;
  if( not fChkLength(cmb_bx_gu  ,1,1,'�ڽ������ڵ�'             )) then Exit;
  if( not fChkLength(PO_cb1     ,1,1,'�������ڵ�'               )) then Exit;

  if( not fChkLength(dte_po_dt  ,1,1,'�������ۺ�����'           )) then Exit;
  if( not fChkLength(cmb_Ph_gb  ,1,1,'�ܸ���κ�ǰ�����ڵ�'     )) then Exit;
  if( not fChkLength(md_cb1     ,1,1,'���ڵ�'                 )) then Exit;
  if( not fChkLength(msk_Sr_No  ,1,1,'�ܸ����Ϸù�ȣ'           )) then Exit;
  if cmb_bx_gu.ItemIndex = 0 then
  if( not fChkLength(PO_cb2     ,1,1,'�������ڵ�'               )) then Exit;
//  if( not fChkLength(msk_mt_no  ,1,1,'�̵���ȭ��ȣ'             )) then Exit;

  if( not fChkLength(edt_mn_no     ,17,0,'������ȣ'               )) then Exit;
  if( not fChkLength(edt_ac_no     ,1,1,'ȹ�����'               )) then Exit;

  if( not fChkLength(dte_gt_dt  ,8,0,'��������'                 )) then Exit;


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

  FillChar(STRVALUE,SizeOf(STRVALUE),#0);

  str_mtno := msk_mt_no.Text;
  str_imei := Trim(lbl_im_ei.Caption);

(*  �԰�����             *) STRVALUE[ 1] := delHyphen(dte_Ip_Dt.Text);
(*  �ڽ��Ϸù�ȣ         *) STRVALUE[ 2] := Trim(msk_bx_no.Text);
(*  �ڽ������ڵ�         *) STRVALUE[ 3] := cmb_bx_gu_d[cmb_bx_gu.itemindex].code;
(*  �������ڵ�           *) STRVALUE[ 4] := Trim(po_grid1.Cells[1,po_grid1.row]);
(*  �������н���������� *) STRVALUE[ 5] := delHyphen(dte_po_dt.Text);
(*  �ڽ���ܸ������     *) STRVALUE[ 6] := Trim(rce_bx_su.Text);
(*  �ܸ���κ�ǰ�����ڵ� *) STRVALUE[ 7] := cmb_Ph_gb_d[cmb_Ph_gb.itemIndex].code;
(*  ���ڵ�             *) STRVALUE[ 8] := trim(findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d)));
(*  �ܸ����Ϸù�ȣ       *) STRVALUE[ 9] := Trim(msk_Sr_No.Text);
(*  ����ó�����ڵ�       *) STRVALUE[10] := cmb_gm_gu_d[cmb_gm_gu.itemIndex].code;
(*  �ܸ�������ڵ�       *) STRVALUE[11] := cmb_Ph_Cd_d[cmb_Ph_Cd.itemIndex].code;
(*  �����������ڵ�       *) STRVALUE[12] := cmb_Po_Cd1_d[PO_Grid2.Row].code;
(*  �̵���ȭ��ȣ         *) STRVALUE[13] := ECPlazaSeed.Encrypt(str_mtno, common_seedkey);
(*  �ܸ�������           *) STRVALUE[14] := Trim(edt_ph_yo.Text);
(*  �󺧾��������ڵ�     *) STRVALUE[15] := cmb_no_label_d[cmb_no_label.itemIndex].code;
(*  �н������������ڵ�   *) STRVALUE[16] := cmb_Ju_Gu_d[cmb_Ju_Gu.itemIndex].code;
(*  ������������ȣ       *) STRVALUE[17] := Trim(edt_mn_no.Text);
(*  ������ȹ�����       *) STRVALUE[18] := Trim(edt_ac_no.Text);
(*  ��������             *) STRVALUE[19] := delHyphen(dte_gt_dt.Text);
(*  IMEI�ڵ�             *) STRVALUE[20] := ECPlazaSeed.Encrypt(str_imei, common_seedkey);

  MD_CD   := STRVALUE[ 8];
  SERIAL  := STRVALUE[ 9];
  IP_DT   := STRVALUE[ 1];

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA700P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;

  for i := Low( STRVALUE ) to High( STRVALUE ) do
  begin
    case Length(IntToStr(i)) of
      1 : STRNUM := '00' + IntToStr(i);
      2 : STRNUM := '0'  + IntToStr(i);
      3 : STRNUM :=        IntToStr(i);
    end;

    if (TMAX.SendString('STR' + STRNUM , STRVALUE[i]     ) < 0) then  goto LIQUIDATION;
  end;

    //���� ȣ��
	if not TMAX.Call('LOSTA700P') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar(PGM_ID),MB_OK);

    goto LIQUIDATION;
  end;

  if(svcNm = 'I01') then
  begin
    sts_Message.Panels[1].Text := ' ��� �Ϸ�';

    ShowMessage('���������� ����Ͽ����ϴ�.');
  end else
  begin
    sts_Message.Panels[1].Text := ' ���� �Ϸ�';

    ShowMessage('���������� �����Ͽ����ϴ�.');
  end;

  lbl_im_ei.Caption := '';

  if ((TMAX.RecvString('STR102',0) = 'Y')
  or (TMAX.RecvInteger('INI101',0) = StrToInt(rce_bx_su.Text))) then
  begin
    pnl_Bar_prn.Visible := True;
    pgm_sts1 := [3];
    button1.SetFocus;
  end;

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if pgm_sts1 <> [3] then
    pgm_sts1 := [2];

  btn_InquiryClick(Sender);

  edt_mn_no.SetFocus;

  Exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;


procedure Tfrm_LOSTA700P.btn_InquiryClick(Sender: TObject);
var
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_temp : String;

    i ,j: integer;
    STR001, STR002, STR003 , STRNUM: STring;

  Label LIQUIDATION;
begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_ganm := '';
  seed_gano := '';
  seed_gatl := '';
  seed_mtno := '';
  seed_temp := '';

  STR001 := '';
  STR002 := '';
  STR003 := '';
  STRNUM := '';

  if(Length(Trim(edt_ba_no.Text)) = 28 ) then
  begin
    STR001 := copy(Trim(edt_ba_no.Text),0,4)  ;	                        // ���ڵ�
    STR002 := copy(Trim(edt_ba_no.Text),5,Length(edt_ba_no.Text) - 12);	// �ܸ����Ϸù�ȣ
    STR003 := copy(Trim(edt_ba_no.Text),Length(edt_ba_no.Text) - 7,8);	// �԰�����
  end
  else if ( MD_CD <> '') then
  begin
    STR001 := MD_CD;
    STR002 := SERIAL;
    STR003 := IP_DT;
  end else
  begin
    if ( not fChkLength(md_cb1    ,1,1,'���ڵ�')      )  then exit;
    if ( not fChkLength(msk_Sr_No ,1,1,'�ܸ����Ϸù�ȣ'))  then exit;
    if ( not fChkLength(dte_Ip_Dt ,8,0,'�԰�����')      )  then exit;

    STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d));	// ���ڵ�
    STR002 := msk_Sr_No.Text;			                                          // �ܸ����Ϸù�ȣ
    STR003 := delHyphen(dte_Ip_Dt.Text);	                                  // �԰�����

  end;

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

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA700P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTA700P') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  InitComponents;

(* �԰�����            	 *)  dte_Ip_Dt.Text       := InsHyphen(TMAX.RecvString('STR011',0));
(* �ڽ��Ϸù�ȣ        	 *)  msk_bx_no.Text       :=           TMAX.RecvString('STR012',0);
(* �ڽ������ڵ�        	 *)  cmb_bx_gu.ItemIndex  := cmb_bx_gu.items.indexof(findNameFromCode(TMAX.RecvString('STR013',0),cmb_Bx_Gu_d,cmb_bx_gu.Items.Count));
(* �������н����������	 *)  dte_po_dt.Text       := InsHyphen(TMAX.RecvString('STR014',0));
(* ��������            	 *)  PO_cb1.Text	        :=           TMAX.RecvString('STR018',0);
                             for i := 0 to po_grid1.RowCount-1 do
                              if po_cb1.Text = copy(po_grid1.cells[0,i],1,length(po_cb1.text)) then
                              begin
                                 po_grid1.Row := i;
                                 break;
                              end;
                             PO_cb1Change(self);
(* �ڽ���ܸ������    	 *)  rce_bx_su.Text       :=           TMAX.RecvString('INT016',0);
(* �԰�ܸ������      	 *)  rce_ip_su.Text       :=           TMAX.RecvString('INT017',0);

  grd_Phon.RowCount := TMAX.RecvInteger('INF013',0) + 1;

  for i := 0 to TMAX.RecvInteger('INF013',0) -1 do
  begin

    for j := Low( arrTgrid1 ) + 1 to High( arrTgrid1 ) do
    begin
      case Length(IntToStr(j)) of
        1 : STRNUM := '10' + IntToStr(j);
        2 : STRNUM := '1'  + IntToStr(j);
        3 : STRNUM :=        IntToStr(j);
      end;

      if ( (STRNUM = '111') OR (STRNUM = '113') OR (STRNUM = '128') ) then
      begin
        seed_temp := TMAX.RecvString('STR' + STRNUM ,i);
        grd_Phon.Cells[j-1,i+1] := execSubProg(arrTgrid1[j-1],ECPlazaSeed.Decrypt(seed_temp, common_seedkey));
      end
      else
        grd_Phon.Cells[j-1,i+1] := execSubProg(arrTgrid1[j-1],TMAX.RecvString('STR' + STRNUM ,i));

    end;

    if pgm_sts1 <> [2] then
    begin
      if (STR001 = Trim(grd_Phon.Cells[3,i+1])) AND
         (Trim(CFillStr(STR002, '0', 16, false)) = Trim(grd_Phon.Cells[5,i+1])) AND
         (STR003 = Delhyphen(grd_Phon.Cells[0,i+1])) then
        grd_Phon.Row := i+1;
    end;
  end;

  sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';

  //������ ��ư Ȱ��ȭ
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

  if pgm_sts1 <> [2] then
  begin
    grd_PhonClick(Sender);
    pgm_sts1 := [1];
  end;

  MD_CD   := '';
  SERIAL  := '';
  IP_DT   := '';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  //edt_mn_no.SetFocus;
end;

procedure Tfrm_LOSTA700P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA700P.disableComponents;
begin

  btn_Add.Enabled     := False;
  btn_Update.Enabled  := False;
  btn_Delete.Enabled  := False;
  btn_Inquiry.Enabled := False;
  btn_Print.Enabled   := False;


    Application.MainForm.Cursor:= crSQLWait;
    sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
    Application.ProcessMessages;
end;

procedure Tfrm_LOSTA700P.enableComponents;
begin
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;
  btn_Inquiry.Enabled := True;
  btn_Print.Enabled   := True;

    Application.MainForm.Cursor:= crSQLWait;
    sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
    Application.ProcessMessages;
end;

procedure Tfrm_LOSTA700P.btn_resetClick(Sender: TObject);
begin
  pgm_sts1 := [0];
  Self.InitComponents;
end;

procedure Tfrm_LOSTA700P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA700P.setEdtKeyPress;
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


procedure Tfrm_LOSTA700P.onKeyPress(Sender : TObject;var Key : char);
begin
  if key = #13 then SelectNext( Sender as TWinControl , true, True)
  else if not (key in ['0'..'9',#8,#9,#45]) then key := #0
  else if Sender is TMaskEdit then
        if (Sender as TMaskEdit) = msk_mt_no then
         if key = #107 then btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA700P.edt_ba_noKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender)
  else if not (key in ['0'..'z',#8,#9,#22]) then key := #0;
end;

procedure Tfrm_LOSTA700P.edt_mn_noKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then SelectNext( Sender as TWinControl , true, True)
  else if not (key in ['0'..'z',#8,#9,#22]) then key := #0;
end;


procedure Tfrm_LOSTA700P.edt_ac_noKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then SelectNext( Sender as TWinControl , true, True)
  else if not (key in ['0'..'9',#22]) then key := #0;
end;

procedure Tfrm_LOSTA700P.edt_ac_noExit(Sender: TObject);
var i_ac_no : Integer;
begin
  if( Length(Trim(edt_ac_no.text)) > 0 ) then begin
    i_ac_no := StrToInt(edt_ac_no.text);
    edt_ac_no.text := IntToStr(i_ac_no);
  end;
end;

procedure Tfrm_LOSTA700P.FormShow(Sender: TObject);
begin
  // ������Ʈ �ʱ�ȭ
  InitComponents;
end;

procedure Tfrm_LOSTA700P.md_cb1Exit(Sender: TObject);
begin
  md_grid1.Visible := False;
end;

procedure Tfrm_LOSTA700P.PO_cb2Exit(Sender: TObject);
begin
  PO_Grid2.Visible := False;
end;

procedure Tfrm_LOSTA700P.msk_mt_noKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 107 then
  begin
    btn_AddClick(Sender);
  end;
end;

procedure Tfrm_LOSTA700P.dte_gt_dtKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    msk_mt_no.SetFocus;
  end;
end;

procedure Tfrm_LOSTA700P.btn_IMEIClick(Sender: TObject);
begin
  // ����Ʈ�ڽ� �ʱ�ȭ
  lbl_im_ei.Caption := '';
  frm_LOSTA700P_IMEI.edt_imei_cd.Text := '';
  frm_LOSTA700P_IMEI.edt_imei_md_nm.Text := '';
  frm_LOSTA700P_IMEI.edt_imei_sr_no.Text := '';
  frm_LOSTA700P_IMEI.edt_kait_md_cd.Text := '';
  frm_LOSTA700P_IMEI.edt_kait_md_nm.Text := '';
  frm_LOSTA700P_IMEI.edt_kait_sr_no.Text := '';

  Self.Enabled := false;
  frm_LOSTA700P_IMEI.Show;

  frm_LOSTA700P_IMEI.edt_imei_cd.SetFocus;

end;

end.

