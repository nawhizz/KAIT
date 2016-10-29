{*---------------------------------------------------------------------------
���α׷�ID    : landprt
���α׷� ���� : Online
�ۼ���	      : ������
�ۼ���	      : 1999. 03. 12
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
unit u_landprt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, ComCtrls,common_lib;

type
  Tfrm_LANDPRT = class(TForm)
    pnl_Command: TPanel;
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    PrintDialog1: TPrintDialog;
    edt_Filename: TEdit;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_Preview: TSpeedButton;
    btn_Prn_Set: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_PreviewClick(Sender: TObject);
    procedure btn_Prn_SetClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
    filePath:String;
    fHeight : Cardinal;
    gap     : Cardinal;
    exGap   : Cardinal;
    lGap    : Cardinal;

  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
    procedure FormSet(CFileNm, CPgmNm: shortstring); overload;
    procedure FormSet(CFileNm, CPgmNm: shortstring;orient : String); overload;
    procedure FormSet(CFileNm, CPgmNm: shortstring;orient : String; nPage : Integer); overload;    


  published

    procedure FormSet(CFileNm, CPgmNm: shortstring;orient : String; nPage : Integer;
                              fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap: Cardinal); overload;    


  end;

var
	frm_LANDPRT: Tfrm_LANDPRT;
  prt_orient : string;
  newPage    : Integer;

implementation

uses bsysprv;

{$R *.DFM}

procedure Tfrm_LANDPRT.disableComponents;
begin
    btn_Print.Enabled   := False;
    btn_Close.Enabled   := False;
    btn_Preview.Enabled := False;
    btn_Prn_Set.Enabled := False;
end;

procedure Tfrm_LANDPRT.enableComponents;
begin
    btn_Print.Enabled   := True;
    btn_Close.Enabled   := True;
    btn_Preview.Enabled := True;
    btn_Prn_Set.Enabled := True;
end;

//�ܺο��� ȣ��
procedure Tfrm_LANDPRT.FormSet(CFileNm, CPgmNm: shortstring);
begin
  Self.FormSet(CFileNm,CPgmNm,'L');
end;

//�ܺο��� ȣ��
procedure Tfrm_LANDPRT.FormSet(CFileNm, CPgmNm: shortstring; orient : string);
begin
  Self.FormSet(CFileNm,CPgmNm,orient,0);
end;

procedure Tfrm_LANDPRT.FormSet(CFileNm, CPgmNm: shortstring;orient : String; nPage : Integer);
begin
  Self.FormSet(CFileNm,CPgmNm,orient,0,0,0,0,0);
end;

//�ܺο��� ȣ��
procedure Tfrm_LANDPRT.FormSet(CFileNm, CPgmNm: shortstring;orient : String; nPage : Integer;
                              fHeight : Cardinal; gap: Cardinal; exGap : Cardinal;lGap : Cardinal);
begin
   lbl_Program_Name.Caption := CPgmNm;
   edt_Filename.Text        := CFileNm;

   //������丮 = ..\KAI\LostPrj\bin
   filePath                 := '..\temp\'+CFileNm;

   prt_orient               := orient;
   newPage                  := nPage;
   Self.fHeight             := fHeight;
   Self.gap                 := gap;
   self.exGap               := exGap;
   Self.lGap                := lGap;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LANDPRT.FormCreate(Sender: TObject);
begin
	//�̸����� ȭ�����
	frm_bsysprv := Tfrm_bsysprv.Create(self);

  edt_Filename.text := '';

  newPage := 0;

  changeBtn(Self);

end;

procedure Tfrm_LANDPRT.btn_CloseClick(Sender: TObject);
begin
   close;
end;

//'���'��ư Ŭ��
procedure Tfrm_LANDPRT.btn_PrintClick(Sender: TObject);
begin
	self.disableComponents;

  frm_bsysprv.f_print(sts_Message, filePath,prt_orient,newPage,fHeight,gap,exGap,lGap);

  self.enableComponents;
end;

//'�̸�����' ��ư Ŭ��
procedure Tfrm_LANDPRT.btn_PreviewClick(Sender: TObject);
begin
	frm_bsysprv.f_Preview(filePath,prt_orient,newPage,fHeight,gap,exGap,lGap);
end;

//'�μ⼳��' ��ư Ŭ��
procedure Tfrm_LANDPRT.btn_Prn_SetClick(Sender: TObject);
begin
	PrintDialog1.Execute;
end;

procedure Tfrm_LANDPRT.FormDestroy(Sender: TObject);
begin
	//�̸����� ȭ�� ����
	frm_bsysprv.Free;
end;

end.