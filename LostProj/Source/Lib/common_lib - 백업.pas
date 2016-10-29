//�����Լ�
//�ۼ��� : 2011.7.20
//�ۼ��� : ������

unit common_lib;

interface

Uses
  	Windows, SysUtils, Dialogs, Grids, WinSkinData, IniFiles, Graphics,
    StdCtrls, Printers, Messages, Mask,ToolEdit,Forms,Buttons,Classes,ComCtrls,
    Controls, monthEdit;


const
	LOSTPRJSTART		= 80;
	LOSTPRJOK			  = 81;
	LOSTPRJRETURN		= 82;
  STSMESSAGEBAR   = 200;
	WM_LOSTPROJECT	= WM_USER + $490;
	WM_LOSTPROJECT2	= WM_USER + $491;
  FTP_IP          = '192.168.1.198';
  FTP_PORT        = '22';
  FTP_ID          = 'lomofos';
  FTP_PW          = '000lomofos';
  TICONLOCATION   = '../Image/lostproj.ico';

  // �޼���
  SEL_SUCCESS = '��ȸ �� ������ �����ϴ�.';
  ADD_SUCCESS = '��� �Ϸ�';
  MOD_SUCCESS = '���� �Ϸ�';
  DEL_SUCCESS = '���� �Ϸ�';

//Z001 ������ ����
type
TZ001 = record
	name:     String[40];
    code:   String[10];
    Jcode1: String[10];
    Jcode2: String[10];
    JCode3: String[10];
    JCode4: String[10];
    JCode5: String[30];
    Used:   Char;
end;

TZ0xx = record
	  name:   String[40];
    code:   String[10];
    Jcode1: String[10];
    Jcode2: String[10];
    JCode3: String[10];
    JCode4: String[10];
    JCode5: String[30];
    Used:   Char;
end;

TZ0xxArray = Array of TZ0xx;

TEventHandlers = class(TWinControl) // create a dummy class
   procedure onClick(Sender: TObject) ;
end;



//Z001 �����͸� �����ϱ����� ����
var
	z001Data:Array of TZ001;
	z001DataCount:Integer;

var EvHandler:TEventHandlers;

//���뺯��
var common_kait       :String = 'X/hhP1cTg/pXHxebWsq/txFVvW8=';	// KAIT�� ��ȣȭ
var common_handle     :String ='0'; 		                        // �ڽ��� ������ �ڵ�
var common_caller     :String ='0';		                          // ȣ���� ������ �ڵ�
var common_userid     :String ='';   	                          // �����ID
var common_username   :String ='';		                          // ����ڸ�
var common_usergroup  :String ='';	                            // ����ڱ׷�

var bitmap : TBitmap;

//���ϸ��� �����Ѵ�. ��)LostPrj.exe ==> LostPrj_.exe
function fChngUnderbar(fname:String):String;forward;

//�ڵ�� ���� ������ ã�´�.
function findNameFromCode(code:String; var data:TZ0xxArray; number:Integer):String;forward;

//�������κ��� �ڵ带 ã�´�.
function findCodeFromName(name:String; var data:TZ0xxArray; number:Integer):String;forward;

function InsHyphen( const strSrc : String) : String; overload; forward;
function InsHyphen( Const strSrc , strType : String) : String; overload; forward;

//���ϸ� �����Ͽ� ��ȯ�Ѵ�.
//��) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'����
//������ �κ� 'FileUpload_prj.exe'�� ��ȯ�Ѵ�.
function getFinalName(fullName, delimiter:String):String;forward;

//���丮�� �����Ͽ� ��ȯ�Ѵ�.
//��) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'����
//'D:\KAIT\LostPrj\BasicFuncTest\File_Upload'�� ��ȯ�Ѵ�.
function getDirPath(fullName, delimiter:String):String;forward;
function getFrontName(fullName, delimiter:String):String;forward;

//�־��� ���ڿ��� ��ȣ�� �Ͽ� ��ȯ�Ѵ�.
//�н��� 'INIcrypto01h.dll'�� �־�� �Ѵ�.
function  Get_EncStr(strPara: String):String;forward;

//��Ʈ�� �׸����� ���õ� ���ڵ带 �����Ѵ�.
procedure DeleteStringGridRow1(var AStringGrid:TStringGrid;Arow:Integer); forward;

//�ܺ� ���α׷��� �����Ų��.
function ExecExternProg(progID:String):Boolean; forward;

//��Ų�ʱ�ȭ
procedure initSkinForm(var skinData:TSkinData);forward;

//���ڿ����� (2011-07-11 => 20110711)
function delHyphen(src:String):String;forward;

//����ȣ ���ڿ� ����(010- 234-1943 =>0102341934)
function delHyphenPhone(src:String):String;forward;

//���ڿ����� Ư������(space,-,/,...��)�� �����Ѵ�.
function delDelimiter(src:String; delimiter:Char):String;forward;

//�պκ��� ���ڿ��� ��ȯ�Ѵ�.
//ex) 123.000 => 123, abcd/dfsjls =>abcd
function firstString(src:String; delimiter:Char):String;forward;

//�������ڿ��� �޸��� ���Ե� ���ڿ��� ��ȯ
//��) -123456789 => -123,456,789
function convertWithCommer(src:String):String;forward;

//���ڿ��� �ȼ����� �����Ѵ�.
function TextSize(AFont: TFont;  Text: String): TPoint;forward;

//Z001 �����͸� �޺��ڽ��� ä���.
procedure initComboBoxWithZ001(var combo:TComboBox);forward;

//Z0xx �����͸� �޺��ڽ��� ä���.
function initComboBoxWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var combo:TComboBox): Boolean;overload;forward;

function initComboBoxWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var combo:TComboBox;cmdcd1, cmdcd2, cmdcd3 : shortstring): Boolean; overload;forward;

//Z0xx �����͸� ����Ʈ�ڽ��� ä���.
procedure initStrinGridWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var grid:TStringGrid;cmdcd1, cmdcd2, cmdcd3 : shortstring);overload;forward;

procedure initStrinGridWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var grid:TStringGrid); overload;forward;

//������ ����Ѵ�.
procedure linePrint(orient, fname:String; nPage : Integer;
                    fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal); overload;
procedure linePrint_z4mplus(orient, fname:String; nPage : Integer;
                    fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal); overload;
procedure linePrint(orient, fname:String;nPage : Integer);forward; overload;
procedure linePrint(orient, fname:String);forward; overload;

// �ش� ��ü�� ���ڿ��� üũ�ϰ� �˾����� �˷��ָ�, ��Ŀ���� ���߾� �Է��� �� �ְ� �Ѵ�.
// ������ �񱳰��� ���� ���ϸ� ������ True, ���н� False �� ��ȯ�Ѵ�.
function fChkLength(obj       : TObject;
                    len       : Integer;
                    cond      : Integer;
                    strTitle  : string): Boolean; forward;// Cond 0: Equal 1:Min 2:Max);

procedure pShowMessage(strInt  : Integer); overload; forward;
procedure pShowMessage(strBool : Boolean); overload; forward;
procedure pShowMessage(strVal  : string);  overload; forward;

procedure fSetIcon(app :TApplication ); forward;

procedure changeBtn(frm : TForm);

function fGetftpIp():   string; forward;
function fGetftpPort(): string; forward;
function fGetftpId():   string; forward;
function fGetftpPw():   string; forward;

// ���� ���뿡�� ������
function CNumOnly( src : shortstring ) : shortstring;
function CRemoveSpace (src : shortstring) : shortstring ;
function CStrToArr (src : shortstring ; var dest : array of char ; NullTerm : Bool)
          : integer ; forward;
function CFillStr (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : shortstring ;
{------------------------------------------------------------------------------}
function fInc(var val : Integer) : Integer;

procedure pSetstsWidth(var sts_Message : TStatusBar); forward;

procedure pSetOnkeydown(Sender : TObject;var Key: Char); forward;

procedure pSetOnEnter(Sender : TObject); forward;

procedure pSetTxtSelAll(frm : TForm); forward;

procedure pFillCmCdCmb(fname : string; var cmb : TComboBox); forward;

procedure disableBtn(frm : TForm); forward;

procedure pInitStrGrd(frm : TForm);       forward; overload;
procedure pInitStrGrd(grd : TStringGrid); forward; overload;

function fNVL(var strVal : string) : string; overload;
function fNVL(var strVal, strRpl : String) : string; overload;

function fRNVL( strVal : string) : string;

implementation

function fChngUnderbar(fname:String):String;
var
	name,ext:String;
begin
	result:= fname;
    if Pos('.',fname) = 0 then
    	exit;

    name:= GetFrontName(fname, '.');
    ext:= GetFinalName(fname, '.');

    result:= name + '_.'+ ext;
end;

function delDelimiter(src:String; delimiter:Char):String;
var
	len:Integer;
	po:Integer;
begin
	result := Trim(src);

	len:= Length(src);
	po := Pos(delimiter, src);
	if po <> 0 then
		result := Trim(Copy(src,1,po-1)) + delDelimiter(Copy(src, po+1, len-po), delimiter);
end;

function getFrontName(fullName, delimiter:String):String;
begin
	result:= getDirPath(fullName, delimiter);
end;

function findCodeFromName(name:String; var data:TZ0xxArray; number:Integer):String;
var
	i:Integer;
begin
	result:='';
    for i:=0 to number-1 do begin
    	if Trim(data[i].name) = name then begin
    		result:= data[i].code;
            break;
        end;
    end;
end;

function findNameFromCode(code:String; var data:TZ0xxArray; number:Integer):String;
var
	i:Integer;
begin
	result:='';
    for i:=0 to number-1 do begin
    	if data[i].code = code then begin
    		result:= data[i].name;
            break;
        end;
    end;
end;

{**************************************************************************}
{* function   ��   : InsHyphen											                      *}
{* function ���   : ������ ���ڿ��� �������� �ٿ��� �ǵ��� �ش�		      *}
{* function ���� : InsHyphen(��ȯ����) or InsHyphen(��ȯ����,��ȯ����)  *}
{* ��     ��    �� : �ִ뼺												                        *}
{* ��     ��    �� : 2011.08.08											                      *}
{**************************************************************************}
function InsHyphen( const strSrc : String) : String; overload;
var
  strTar : String;
begin
  strTar := '';

	Case Length(Strsrc) Of
		6 : Strtar := '3-3';		// �����ȣ
		8 : Strtar := '4-2-2';	// �����
		9 : Strtar := '2-3-4';	// ��ȭ��ȣ(����)
		10 : If(Copy(Strsrc,0,2) = '02') Then Strtar := '2-4-4'
				Else Strtar := '3-3-4';	// ������ȭ(����) Or �ڵ���
		11 : Strtar := '3-4-4'; // �ڵ��� Or ���� ������ȭ
		13 : Strtar := '6-7';		// �ֹ�> ��ȣ
	End;

  if( strTar = '') then Result := strSrc
  else Result := InsHyphen(strSrc,strTar);
end;

function InsHyphen( Const strSrc , strType : String) : String; overload;
var
  _cnt,i,_idx : Integer;
  arrInt : array of Integer;
  arrStr : array of String;
  strTmp : String;

begin
  _cnt := 0;
  strTmp := strType;

  SetLength(arrInt,0);

  //�迭 ũ�⸦ ���ϱ� ���� '-'�� ������ ����
  for i:= 0 to Length(strType) -1 do
    begin
    if(copy(strType,i,1) = '-') then _cnt := _cnt + 1;
    end;

  setLength(arrInt,_cnt + 1);

  // �迭�� ���ڿ��� ���̸� ����
  i := 0;

  if  (Length(strTmp) <> 0) then
    begin
      repeat
          arrInt[i] := StrToInt(copy(strTmp,0,pos('-',strTmp)-1));
          strTmp := copy(strTmp,pos('-',strType) + 1,Length(strTmp));
          i := i + 1;
      until pos('-',strTmp) = 0;

      arrInt[i] := StrToInt(strTmp);
    end;

  // �迭�� ���ڿ��� �߰�
  setLength(arrStr,_cnt + 1);

  _idx := 1;

  for i := 0 to Length(arrInt) -1 do
    begin
      if(strType = '6-7') and (arrInt[i] = 7 ) then
          arrStr[i] := copy(strSrc,7 ,1)+ '******'
       else
        begin
          arrStr[i] := copy(strSrc,_idx ,arrInt[i]);
         _idx := _idx + arrInt[i];
        end;
    end;

  // �迭�� ��� ���ڿ��� '-'�� �߰���
  strTmp := '';

  for i := 0 to Length(arrStr) - 1 do
    begin
      if (i = Length(arrStr) -1 ) then strTmp := strTmp + arrStr[i]
      else strTmp := strTmp + arrStr[i] + '-';
    end;

  result := strTmp;
end;
{********************      End of Function InsHyphen       *********************}

function getDirPath(fullName, delimiter:String):String;
var
    len:Integer;
begin
	result:= fullName;
    if Pos(delimiter, fullName) = 0 then
    	exit;

    len := Length(fullName);
	result := Copy(fullName, 1, len-1-Length(getFinalName(fullName,delimiter)));
end;

function getFinalName(fullName, delimiter:String):String;
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

procedure linePrint(orient, fname:String); overload;
begin
  linePrint(orient,fname,0);
end;

procedure linePrint(orient, fname:String;nPage : Integer); overload;
begin
  linePrint(orient,fname,0,0,0,0,0);
end;

procedure linePrint(orient, fname:String; nPage : Integer;
                    fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal); overload;
var
  Canvas  : TCanvas;
  F       : TextFile;
  buff    : string;

  sheight :Cardinal;	  //���ڿ� ����
  ygap    :Cardinal;		//���� ������ ��, 1mm
  yposi   :Cardinal;

  _cnt    : Integer;

begin
  _cnt := 0;

  if fHeight  = 0 then fHeight :=  40;
  if gap      = 0 then gap     :=  10;
  if lGap     = 0 then lGap    := 100;

  Assignfile(F, fname);
  Reset(F);

  Canvas:= Printer.Canvas;

  if (orient = 'L') then
    Printer.Orientation := poLandscape
  else  //orient = 'P'
    Printer.Orientation := poPortrait;

//  if (GetPaperOrientation() = 1) then Printer.Orientation := poPortrait
//  else Printer.Orientation := poLandscape;

  Printer.BeginDoc;	//�̺κ��� ���� ���� ���������ϸ� �����߻�...

  //�� ������ �ٲٸ� ���� ���� ����� �ٽ��ؾ� ��.
  SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm ����

  Canvas.Font.Name    := '����ü';   		  //��ġ �����Ұ� �ϹǷ� ��Ʈ�� ����Ұ�
  Canvas.Font.Height  := fHeight;  				    //����ü ���� 4mm

  //Canvas.Font.Style:= [fsBold];

  sheight := Canvas.TextHeight('��'); 	  //���ڳ��� ���, 4mm
  ygap:= gap;								              //line������ ��, 1mm ��

  //ù��°�� �� ������ �����Ƿ�
  yposi :=  sheight + ygap + exGap;
  buff  :=  '';

  while  not EOF(F) do
  begin

    //������ �� ������ ����� �����ϱ� ���� �� �κп��� ���Ѵ�.
    //�������� �ٲ�� �� ��� �Ʒ� ���ڿ��� �ִ��� ýũ�� ��
    Inc(_cnt);

    if (Pos('�ѱ��������������ȸ', buff) <> 0) or ((nPage <> 0) and ((nPage + 1) = _cnt)) then
    begin
      Printer.NewPage;

      yposi := sheight + ygap + exGap;
      _cnt  := 0;
    end;

    Readln(F, buff);
    buff := TrimRight(buff);

    //Left Margin = 10mm
    Canvas.TextOut(lGap, -yposi, buff);

    yposi := yposi + sheight + ygap;

  end;
  {
  if i >= 40 then  begin
  NewPage;
  i := 0;
  end;
  Canvas.TextOut(600,300+i*100, S);
  }
  Printer.EndDoc;
  CloseFile(F);
end;

procedure linePrint_z4mplus(orient, fname:String; nPage : Integer;
                    fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal); overload;
var
  Canvas  : TCanvas;
  F       : TextFile;
  buff    : string;
  OutFile : TextFile;

  sheight :Cardinal;	  //���ڿ� ����
  ygap    :Cardinal;		//���� ������ ��, 1mm
  yposi   :Cardinal;

  _cnt    : Integer;

  sPrn     : String;
  YY      : integer;

begin
  _cnt := 0;

  if fHeight  = 0 then fHeight :=  40;
  if gap      = 0 then gap     :=  10;
  if lGap     = 0 then lGap    := 100;

  Assignfile(F, fname);
  Reset(F);

  //Canvas:= Printer.Canvas;

  //if (orient = 'L') then
 //   Printer.Orientation := poLandscape
 // else  //orient = 'P'
 //   Printer.Orientation := poPortrait;

//  if (GetPaperOrientation() = 1) then Printer.Orientation := poPortrait
//  else Printer.Orientation := poLandscape;

 // Printer.BeginDoc;	//�̺κ��� ���� ���� ���������ϸ� �����߻�...

  //�� ������ �ٲٸ� ���� ���� ����� �ٽ��ؾ� ��.
  //SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm ����

  //Canvas.Font.Name    := '����ü';   		  //��ġ �����Ұ� �ϹǷ� ��Ʈ�� ����Ұ�
  //Canvas.Font.Size    := 20;
 // Canvas.Font.Height  := fHeight;  				    //����ü ���� 4mm

  //Canvas.Font.Style:= [fsBold];

 // sheight := Canvas.TextHeight('��'); 	  //���ڳ��� ���, 4mm
 // ygap:= gap;								              //line������ ��, 1mm ��

  //ù��°�� �� ������ �����Ƿ�
 // yposi :=  sheight + ygap + exGap;
  buff  :=  '';

  sPrn := '^XA' + #13#10;
  sPrn := sPrn + '^BY2,2.0^FS'               + #13#10;
  sPrn := sPrn + '^SEE:UHANGUL.DAT^FS'       + #13#10;
  sPrn := sPrn + '^CW1,E:KFONT3.FNT^CI26^FS' + #13#10;
  YY   := 0;
  while  not EOF(F) do
  begin

    //������ �� ������ ����� �����ϱ� ���� �� �κп��� ���Ѵ�.
    //�������� �ٲ�� �� ��� �Ʒ� ���ڿ��� �ִ��� ýũ�� ��
    Inc(_cnt);
  //
  //  if (Pos('�ѱ��������������ȸ', buff) <> 0) or ((nPage <> 0) and ((nPage + 1) = _cnt)) then
  //  begin
  //    Printer.NewPage;

  //    yposi := sheight + ygap + exGap;
 //     _cnt  := 0;
  //  end;

    Readln(F, buff);
    buff := TrimRight(buff);

    YY := YY + 50;
    sPrn := sPrn + '^FO50,' + intToStr(YY) + '^A1N,40,40^FD' +  buff +  '^FS' + #13#10;
   //Left Margin = 10mm
//    Canvas.TextOut(lGap, -yposi, buff);

//    yposi := yposi + sheight + ygap;

  end;

  sPrn := sPrn + '^PQ2,1,1,Y^FS';
  sPrn := sPrn + '^XZ';

  {
  if i >= 40 then  begin
  NewPage;
  i := 0;
  end;
  Canvas.TextOut(600,300+i*100, S);
  }
  //Printer.EndDoc;

  showMessage(sPrn);
  try
    AssignFile(OutFile, 'LPT1');
    Rewrite(OutFile);
    Writeln(OutFile, sPrn);
    CloseFile(OutFile);
  except
 //Showmessage('���ڵ� ��¿� ������ �߻��߽��ϴ�');
    CloseFile(OutFile);
  end;

  CloseFile(F);
end;

procedure initStrinGridWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var grid:TStringGrid; cmdcd1, cmdcd2, cmdcd3 : shortstring); overload;
var
	f:TextFile;
    path:String;
    buffer:String;
    trimBuf:String;
    i:Integer;

    dataCount:Cardinal;
begin
  if(Pos('.',fname) = 0) then fname := fname + '.dat';

	path := '..\data\'+ fname;

	if Length(Trim(head)) <> 0 then begin
    	dataCount := 1;
    	SetLength(data, dataCount);
    	data[dataCount-1].name := head;
    	data[dataCount-1].code := '****';
    end
    else
    	dataCount:=0;

	AssignFile(f, path);
	Reset(f);

	while not Eof(f) do begin
		ReadLn(f, buffer);
        trimBuf := Trim(buffer);
        if trimBuf ='' then
        	continue;

        if (cmdcd1 <> '') then
          if Trim (copy (trimBuf, 51, 10)) <> trim (cmdcd1) then
            continue ;

        if (cmdcd2 <> '') then
          if Trim (copy (trimBuf, 61, 10)) <> trim (cmdcd2) then
            continue ;

        if (cmdcd3 <> '') then
          if Trim (copy (trimBuf, 71, 10)) <> trim (cmdcd3) then
            continue ;

        if trimBuf[91] ='Y' then begin
        	Inc(dataCount);
        	SetLength(data,dataCount);
        	data[dataCount-1].name := Trim(Copy(trimBuf, 1, 40));
        	data[dataCount-1].code := Trim(Copy(trimBuf, 41, 10));
        	data[dataCount-1].Jcode1 := Trim(Copy(trimBuf, 51, 10));
        	data[dataCount-1].Jcode2 := Trim(Copy(trimBuf, 61, 10));
        	data[dataCount-1].Jcode3 := Trim(Copy(trimBuf, 71, 10));
        	data[dataCount-1].Jcode4 := Trim(Copy(trimBuf, 81, 10));
        	data[dataCount-1].Jcode5 := Trim(Copy(trimBuf, 92, 30));
        	data[dataCount-1].Used := trimBuf[91];
    	end;
    end;
	CloseFile(f) ;

	if Length(Trim(tail)) <> 0 then begin
    	Inc(dataCount);
    	SetLength(data, dataCount);
    	data[dataCount-1].name := tail;
    	data[dataCount-1].code := 'XXXX';
    end;

    grid.RowCount := dataCount;
    for i:=0 to dataCount-1 do begin
    	grid.RowHeights[i]:=15;
    	grid.Cells[0,i] := data[i].name;
    end;

	grid.Row := 0;
end;

procedure initStrinGridWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var grid:TStringGrid); overload;
begin
  initStrinGridWithZ0xx(fname,data,head,tail,grid,'','','');
end;

function initComboBoxWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var combo:TComboBox;cmdcd1, cmdcd2, cmdcd3 : shortstring): Boolean; overload;
var
	  f       :TextFile;
    path    :String;
    buffer  :String;
    trimBuf :String;
    i       :Integer;

    dataCount:Cardinal;

function getCharXX(c : Char; _cnt : integer): string;
var
  j : Integer;
begin
  for j := 1 to _cnt do
  begin
    Result := Result + c;
  end;
end;
begin

  if(Pos('.',fname) = 0) then fname := fname + '.dat';

	path := '..\data\'+ fname;

	if Length(Trim(head)) <> 0 then begin
    	dataCount := 1;
    	SetLength(data, dataCount);
    	data[dataCount-1].name := head;
    	data[dataCount-1].code := '****';
    end
  else
    	dataCount:=0;

	AssignFile(f, path);
	Reset(f);

	while not Eof(f) do begin
		ReadLn(f, buffer);
        trimBuf := Trim(buffer);

        if trimBuf ='' then
        	continue;

        if (cmdcd1 <> '') then
          if Trim (copy (trimBuf, 51, 10)) <> trim (cmdcd1) then
            continue ;

        if (cmdcd2 <> '') then
          if Trim (copy (trimBuf, 61, 10)) <> trim (cmdcd2) then
            continue ;

        if (cmdcd3 <> '') then
          if Trim (copy (trimBuf, 71, 10)) <> trim (cmdcd3) then
            continue ;

        // 91��° ���� 'Y' �� �͸� ������
        if trimBuf[91] ='Y' then begin
        	Inc(dataCount);
        	SetLength(data,dataCount);
        	data[dataCount-1].name    := Trim(Copy(trimBuf, 1, 40));
        	data[dataCount-1].code    := Trim(Copy(trimBuf, 41, 10));
        	data[dataCount-1].Jcode1  := Trim(Copy(trimBuf, 51, 10));
        	data[dataCount-1].Jcode2  := Trim(Copy(trimBuf, 61, 10));
        	data[dataCount-1].Jcode3  := Trim(Copy(trimBuf, 71, 10));
        	data[dataCount-1].Jcode4  := Trim(Copy(trimBuf, 81, 10));
        	data[dataCount-1].Used    := trimBuf[91];
        	data[dataCount-1].Jcode5  := Trim(Copy(trimBuf, 92, 30));
    	end;
    end;
	CloseFile(f) ;

	if Length(Trim(head)) <> 0 then begin
    	data[0].name := head;
    	data[0].code := getCharXX( '*',Length(data[dataCount-1].code));
  end;

	if Length(Trim(tail)) <> 0 then begin
    	Inc(dataCount);
    	SetLength(data, dataCount);
    	data[dataCount-1].name := tail;
    	data[dataCount-1].code := getCharXX( 'X',Length(data[dataCount-2].code))
    end;

  combo.Clear;

  for i:=0 to dataCount-1 do
    combo.ItemS.Add(data[i].name);

  combo.ItemIndex := 0;

  Result := True;
end;

function initComboBoxWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var combo:TComboBox): Boolean; overload;
begin
  result := initComboBoxWithZ0xx(fname , data , head , tail , combo, '','','');
end;

procedure initComboBoxWithZ001(var combo:TComboBox);
var
	f:TextFile;
    path:String;
    buffer:String;
    trimBuf:String;
    i:Integer;
begin
	path := '..\data\Z001.dat';

    z001DataCount := 1;
    SetLength(z001Data, z001DataCount);
    z001Data[z001DataCount-1].name := '��ü';
    z001Data[z001DataCount-1].code := '****';

	AssignFile(f, path);
	Reset(f);

	while not Eof(f) do begin
		ReadLn(f, buffer);
        trimBuf := Trim(buffer);
        if trimBuf ='' then
        	continue;

        if trimBuf[91] ='Y' then begin
        	Inc(z001DataCount);
        	SetLength(z001Data, z001DataCount);
        	z001Data[z001DataCount-1].name := Trim(Copy(trimBuf, 1, 40));
        	z001Data[z001DataCount-1].code := Trim(Copy(trimBuf, 41, 10));
        	z001Data[z001DataCount-1].Jcode1 := Trim(Copy(trimBuf, 51, 10));
        	z001Data[z001DataCount-1].Jcode2 := Trim(Copy(trimBuf, 61, 10));
        	z001Data[z001DataCount-1].Jcode3 := Trim(Copy(trimBuf, 71, 10));
        	z001Data[z001DataCount-1].Jcode4 := Trim(Copy(trimBuf, 81, 10));
        	z001Data[z001DataCount-1].Used := trimBuf[91];
    	end;
    end;
	CloseFile(f) ;

    Inc(z001DataCount);
    SetLength(z001Data, z001DataCount);
    z001Data[z001DataCount-1].name := '�Ҹ�ܸ���';
    z001Data[z001DataCount-1].code := 'XXXX';

    combo.Clear;
    for i:=0 to z001DataCount-1 do
    	combo.ItemS.Add(z001Data[i].name);

	combo.ItemIndex := 1;
end;

//Result.X -> Width
//Result.Y -> Height
function TextSize(AFont: TFont; Text: String): TPoint;
var
  Bitmap: Graphics.TBitmap;
begin
  Bitmap := Graphics.TBitmap.Create;
  try
    Bitmap.Canvas.Font.Assign(AFont);
    Result.X := Bitmap.Canvas.TextWidth(Text);
    Result.Y := Bitmap.Canvas.TextHeight(Text);
  finally
    Bitmap.Free;
  end; // finally
end; // TextSize

function convertWithCommer(src:String):String;
  function cnvrtString(src:String):String;
  var
    len:Integer;
  begin
    result:= src;

    len:= Length(src);

    if len <= 1 then Exit;

    if src[1] = '-' then
    begin
      if len <= 4 then exit;
    end
    else if len <= 3 then exit;

    if src[1] = '-' then
    begin
      result:= cnvrtString(Copy(src, 1, len-3))+ ',' + Copy(src, len-2, 3);
    end else
      result:= cnvrtString(Copy(src, 1, len-3)) + ',' + Copy(src, len-2, 3);
  end;
begin
  result:= cnvrtString(src);
end;

function firstString(src:String; delimiter:Char):String;
var
	posi:Integer;
begin
	result := src;

	posi := Pos(delimiter, src);
    if posi <> 0 then
    	result := Copy(src, 1, posi-1);
end;

function delHyphenPhone(src:String):String;
begin
    result:= delDelimiter(src,' ');
end;

function delHyphen(src:String):String;
begin
	result:= delDelimiter(src,'-');
end;

procedure initSkinForm(var skinData:TSkinData);
var
	iniPath:String;
	skinPath:String;
	str : String;
	ini : TiniFile;
begin
	iniPath := '..\Ini\LostProj.ini';
	skinPath := '..\Skin\';

	ini := TiniFile.Create(iniPath);
	str := ini.ReadString('Skin','SKIN','');
	skinPath := skinPath + str;

	SkinData.SkinFile := skinPath;
	SkinData.Active := True;

	ini.Free;
end;

function ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

    //���� �ٿ�ε峪 �����ڵ� ������Ʈ
    if (progID = 'FileDownload') or (progID = 'CodeUpdate') then
		  commandStr := progID +'.exe '+ common_kait +' '+ common_handle
    else
      commandStr := progID +'.exe ' +
                    common_kait     +' '+
                    common_handle   +' '+
                    common_userid   +' '+
                    common_username +' '+
                    common_usergroup;

	ret := WinExec(PChar(commandStr), SW_Show);
	if ret <= 31 then begin
		result:= False;

        MessageBeep (0) ;
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');
   end
end;


function  Get_EncStr(strPara: String):String;
type
   TFunc = function (type_str:PChar;input_str:PChar;output_str:PChar):Integer; stdcall;
var
   ret:         integer;
   out_str:     PChar;
   H:           THandle;
   hash:        TFunc;
   sErrMsg:     String ;
begin
   try
      out_str := '';
      Result := strPara;
      H := LoadLibrary( PChar( 'INIcrypto01h.dll') );
      GETMEM(out_str, 100);
      @hash := GetProcAddress(H, 'Hash' );
      ret := hash(Pchar('SHA1'),Pchar(strPara),out_str);
      if ret < 0 then begin
        sErrMsg := '��ȣ�� Hash��ȣȭ �ϴµ� �����߽��ϴ�.'+ #13#10 +
                   '���꺻�η� �����Ͻʽÿ�' ;
        case MessageDlg( sErrMsg , mtError	 , [mbOK] , 0 ) of
          mrOK : begin
                 end;
        end;
        Exit;
      end;
      Result := TRIM(out_str);
   finally
      FreeLibrary( H );
      FreeMem(out_str);
   end;
end;

procedure DeleteStringGridRow1(var AStringGrid:TStringGrid;Arow:Integer);
var
  i,j:integer;
begin
  for i := Arow to AStringGrid.RowCount - 2 do
  begin
    for j := 0 to AStringGrid.ColCount - 1 do
    begin
      AStringGrid.Cells[j,i] := AStringGrid.Cells[j,i+1];
    end;
  end;
  AStringGrid.RowCount := AStringGrid.RowCount-1;
end;

function fChkLength(obj       : TObject;
                    len       : Integer;
                    cond      : Integer;
                    strTitle  : string): Boolean; // Cond 0: Equal 1:Min 2:Max);
var
  strValue : string;

begin
    strValue := '';
    Result   := False;

    if      ( obj is TEdit     ) then strValue := (obj as TEdit      ).Text
    else if ( obj is TMaskEdit ) then strValue := (obj as TMaskEdit  ).Text
    else if ( obj is TLabel    ) then strValue := (obj as TLabel     ).Caption
    else if ( obj is TDateEdit ) then strValue := (obj as TDateEdit  ).Text
    else if ( obj is TComboEdit) then strValue := (obj as TComboEdit ).Text
    else if ( obj is TComboBox ) then strValue := (obj as TComboBox  ).Items.Strings[(obj as TComboBox  ).itemIndex]
    else
      begin
        ShowMessage(obj.ClassName + '�� ��ü Ÿ���� ���ǵ��� �ʾҽ��ϴ�.');
        Exit;
      end;

    strValue := delHyphen(Trim(strValue));

    case cond of
      0 : if(Length(strValue) = len)  then Result := True;

      1 : if(Length(strValue) >= len) then Result := True;

      2 : if(Length(strValue) <= len) then Result := True;

      else begin
        ShowMessage('�߸��� ������Դϴ�.');
        result := False;
      end;
    end;

    if (not result) then
    begin
      ShowMessage(strTitle + '��(��) ��Ȯ���� �ʽ��ϴ�.');
      if      ( obj is TEdit      ) and ((obj as TEdit      ).Visible = True) and  (obj as TEdit     ).CanFocus then (obj as TEdit     ).SetFocus
      else if ( obj is TMaskEdit  ) and ((obj as TMaskEdit  ).Visible = True) and  (obj as TMaskEdit ).CanFocus then (obj as TMaskEdit ).SetFocus
      else if ( obj is TDateEdit  ) and ((obj as TDateEdit  ).Visible = True) and  (obj as TDateEdit ).CanFocus then (obj as TDateEdit ).SetFocus
      else if ( obj is TComboEdit ) and ((obj as TComboEdit ).Visible = True) and  (obj as TComboEdit).CanFocus then (obj as TComboEdit).SetFocus
    end;
end;

procedure pShowMessage(strInt : Integer); overload;
begin
  pShowMessage(IntToStr(strInt));
end;

procedure pShowMessage(strBool : Boolean); overload;
begin
  if strBool then pShowMessage('Boolean : true')
  else pShowMessage('Boolean : false');

end;

procedure pShowMessage(strVal  : string);  overload;
begin
  ShowMessage('���ڿ��� : ' + strVal + ' ' + '���̴� : ' + IntToStr(Length(strval)));
end;

procedure changeBtn(frm : TForm);
const
  LOC = '.\..\Icons\Blue Icon Pack\';
type
  PGM_INFO = (P,Q,L,E);
var
  i : Integer;
  component : TComponent;
  pgm_info1 : PGM_INFO;
  icon : TIcon;
begin

  if ( Pos('_ADDR',frm.Name) > 0) or ( Pos('_CHILD',frm.Name) > 0)then
  begin
         if (Copy(frm.Name,Pos('_ADDR',frm.Name)-1,1) = 'P') or (Copy(frm.Name,Pos('_CHILD',frm.Name)-1,1) = 'P') then pgm_info1 := P
    else if (Copy(frm.Name,Pos('_ADDR',frm.Name)-1,1) = 'Q') or (Copy(frm.Name,Pos('_CHILD',frm.Name)-1,1) = 'Q') then pgm_info1 := Q
    else if (Copy(frm.Name,Pos('_ADDR',frm.Name)-1,1) = 'L') or (Copy(frm.Name,Pos('_CHILD',frm.Name)-1,1) = 'L') then pgm_info1 := L
    else pgm_info1 := E;
  end else
  begin
         if Copy(frm.Name,Length(frm.Name)  ,1) = 'P' then pgm_info1 := P
    else if Copy(frm.Name,Length(frm.Name)  ,1) = 'Q' then pgm_info1 := Q
    else if Copy(frm.Name,Length(frm.Name)  ,1) = 'L' then pgm_info1 := L
    else pgm_info1 := E;
  end;

  for i := 0 to frm.ComponentCount - 1 do
  begin

    component := frm.Components[i];

    // ������ ���۳�Ʈ
    bitmap := TBitmap.Create;

    if (component is TSpeedButton) then
    begin
       if UpperCase((component as TSpeedButton).Name) = 'BTN_ADD' then
         begin
           bitmap.LoadFromFile(Loc + '���.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := True;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Visible := False;
             E : (component as TSpeedButton).Enabled := True;
           end;

         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_UPDATE' then
         begin
           bitmap.LoadFromFile(Loc + '����.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := True;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Visible := False;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_DELETE' then
         begin
           bitmap.LoadFromFile(Loc + '����.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := True;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Visible := False;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_INQUIRY' then
         begin
           bitmap.LoadFromFile(Loc + '��ȸ.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := True;
             Q : (component as TSpeedButton).Enabled := True;
             L : (component as TSpeedButton).Visible := False;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_LINK' then
         begin
           bitmap.LoadFromFile(Loc + '����.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := False;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Enabled := False;
             E :  (component as TSpeedButton).Enabled := False;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_PRINT' then
         begin
           bitmap.LoadFromFile(Loc + '�μ�.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := False;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Enabled := True;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_EXCEL' then
         begin
           bitmap.LoadFromFile(Loc + '����.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled  := False;
             Q : (component as TSpeedButton).Enabled  := True;
             L : (component as TSpeedButton).Enabled  := False;
             E :  (component as TSpeedButton).Visible := False;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_QUERY' then
         begin
           bitmap.LoadFromFile(Loc + '����.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           if (common_usergroup = 'SYSM') then
             Case pgm_info1 of
               P : (component as TSpeedButton).Enabled  := False;
               Q : (component as TSpeedButton).Enabled  := True;
               L : (component as TSpeedButton).Enabled  := True;
               E :  (component as TSpeedButton).Enabled := True;
             end
           else
            (component as TSpeedButton).Enabled := False;
                       
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_RESET' then
         begin
           bitmap.LoadFromFile(Loc + '�ʱ�ȭ.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := True;
             Q : (component as TSpeedButton).Enabled := True;
             L : (component as TSpeedButton).Enabled := True;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_PREVIEW' then
         begin
           bitmap.LoadFromFile(Loc + '�̸�����.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := False;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Visible := True;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_PRN_SET' then
         begin
           bitmap.LoadFromFile(Loc + '�μ⼳��.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := False;
             Q : (component as TSpeedButton).Enabled := False;
             L : (component as TSpeedButton).Visible := True;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end
       else if UpperCase((component as TSpeedButton).Name) = 'BTN_CLOSE' then
         begin
           bitmap.LoadFromFile(Loc + '�ݱ�.bmp');
           (component as TSpeedButton).Glyph := bitmap;
           (component as TSpeedButton).Cursor := crHandPoint;

           Case pgm_info1 of
             P : (component as TSpeedButton).Enabled := True;
             Q : (component as TSpeedButton).Enabled := True;
             L : (component as TSpeedButton).Enabled := True;
             E :  (component as TSpeedButton).Enabled := True;
           end;
         end;
    end;
  end;
end;

function fGetftpIp() :string;
begin
  result := FTP_IP;
end;
function fGetftpPort() : string;
begin
  result := FTP_PORT;
end;
function fGetftpId() : string;
begin
  result := FTP_ID;
end;

function fGetftpPw() : string;
begin
  Result := FTP_PW;
end;

function fInc(var val : Integer) : Integer;
begin
  result := val;
  val := val + 1;
end;

function CNumOnly( src : shortstring ) : shortstring;
var
   temp  : string[1];
   iLen  : integer;
   index : integer;
begin
     result := '';
     iLen := Length( src );
     for index := 1 to iLen do
     begin
          temp := copy( src, index, 1 );
          if ( temp >= '0' ) and ( temp <= '9' ) then
             result := result + temp;
     end;
end;

function CRemoveSpace (src : shortstring) : shortstring ;
var
   temp  : string[1];
   idx : integer;
begin
	result := '';

	for idx := 1 to length (src) do
	if ( src[idx] <> ' ' ) and		// space
      ( src[idx] <> #13 ) and		// new line
      ( src[idx] <> #10 ) and		//
      ( src[idx] <> #0  ) and      // null
      ( src[idx] <> '	') then		// tab
   begin
   	temp := copy( src, idx, 1 );
        result := result + temp;
   end ;
end;

function CStrToArr (src : shortstring ; var dest : array of char ; NullTerm : Bool)
          : integer ;
var
   idx, destlen : integer ;
   tmppchar : pchar ;
begin
     result := 0 ;

     tmppchar := StrAlloc (length (src) + 1) ;
     StrPCopy (tmppchar, src) ;

     destlen := sizeof (dest) ;
     FillChar (dest, destlen, ' ') ;

     if int(StrLen(tmppchar)) < destlen then
   	destlen := StrLen (tmppchar) ;

     for idx := 0 to destlen - 1 do
   	dest[idx] := tmppchar[idx] ;

     if NullTerm then
        dest [idx] := #0 ;

     StrDispose (tmppchar) ;
end ;

function CFillStr (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : shortstring ;
var
   dest : shortstring ;
   idx : integer ;
begin

     FillChar (dest, size, '0') ;

     if length (src) > size then
   	dest := copy (src, 1, size)
     else
     begin
      if bFront then
      begin
        Insert (src, dest, 1) ;

        for idx := length (src) + 1 to size do
          dest[idx] := fChar ;
      end
      else
      begin
        Insert (src, dest, size - length (src) + 1) ;

        for idx := 1 to size - length (src) do
          dest[idx] := fChar ;
      end ;
     end ;

     result := copy (dest, 1, size) ;
end ;


procedure fSetIcon(app :TApplication );
var
  icon : TIcon;
begin
  icon := TIcon.Create;
  icon.LoadFromFile(TICONLOCATION);
  app.Icon := icon;

end;

procedure pSetstsWidth(var sts_Message : TStatusBar);
begin
  if (sts_Message.Panels.Count <> 3 ) then
  begin
    ShowMessage('�Ϲ������� ���� ���¹� Ÿ���Դϴ�.');
  end;

  sts_Message.Panels.Items[1].Width := sts_Message.Width - sts_Message.Panels.Items[0].Width
                                       - STSMESSAGEBAR;
  sts_Message.Panels.Items[2].Width := STSMESSAGEBAR;
end;

procedure pSetOnkeydown(Sender : TObject;var key:Char);
begin
  if Key = #13 then Exit;

end;

procedure pSetOnEnter(Sender : TObject);
begin
  if ( Sender is TEdit) then
    (Sender as TEdit).SelectAll;
end;

procedure pSetTxtSelAll(frm : TForm);
var
  i : Integer;
  component : TComponent;

begin
  for i := 0 to frm.ComponentCount - 1 do
  begin
    component := frm.Components[i];

    if (component is TEdit) then
    begin
        (component as TEdit).onClick := EvHandler.onClick;
    end;

  end;
end;

procedure pFillCmCdCmb(fname : string; var cmb : TComboBox);
var
	  f       :TextFile;
    path    :String;
    buffer  :String;
    trimBuf :String;
    i       :Integer;
begin
  if(Pos('.',fname) = 0) then fname := fname + '.dat';

	path := '..\data\'+ fname;

  AssignFile(f, path);
	Reset(f);

	while not Eof(f) do begin
    ReadLn(f, buffer);
    trimBuf := Trim(buffer);

    if trimBuf ='' then
      continue;

    // 91��° ���� 'Y' �� �͸� ������
    if trimBuf[91] ='Y' then begin
      cmb.Items.Add(Trim(Copy(trimBuf, 1, 40)) + '/' + Trim(Copy(trimBuf, 41, 10)));

    end;
  end;

	CloseFile(f) ;
end;

procedure disableBtn(frm : TForm);
 var
   i : Integer;
   component : TComponent;
 begin
   for i := 0 to frm.ComponentCount - 1 do begin
   component := frm.Components[i];
 
     if (component is TSpeedButton) then
         (component as TSpeedButton).Enabled := False;
 
     if (component is TComboBox) then
         (component as TComboBox).Enabled := False;
 
     if (component is TSpeedButton) then
         (component as TSpeedButton).Enabled := False;
 
     if (component is TCalendarMonth) then
         (component as TCalendarMonth).Enabled := False;

     if (component is TEdit) then
         (component as TEdit).Enabled := False;
 
     if (component is TDateTimePicker) then
         (component as TDateTimePicker).Enabled := False;
   end;
 end;

procedure TEventHandlers.onClick(Sender : TObject);
begin
  (Sender as TEdit).SelectAll;
end;

procedure pInitStrGrd(frm : TForm);
var i,j : Integer;
begin
  for i := 0 to frm.ComponentCount -1 do
    if frm.Components[i] is TStringGrid then
    begin
      for j := (frm.Components[i] as TStringGrid).FixedRows to (frm.Components[i] as TStringGrid).RowCount -1 do
        (frm.Components[i] as TStringGrid).Rows[j].Clear;

      (frm.Components[i] as TStringGrid).RowCount := (frm.Components[i] as TStringGrid).FixedRows + 1;
    end;


end;

procedure pInitStrGrd(grd : TStringGrid);
var j : Integer;
begin
  for j := grd.FixedRows to grd.RowCount -1 do
    grd.Rows[j].Clear;

  grd.RowCount := grd.FixedRows + 1;
end;

function fNVL(var strVal : string) : string;
begin
  if strVal = '' then Result := '|'
  else result := StringReplace(Trim(strVal),' ','@',[rfReplaceAll]);;
end;

function fNVL(var strVal,strRpl : string) : string;
begin
  if strVal = '' then Result := strRpl
  else result := StringReplace(Trim(strVal),' ','@',[rfReplaceAll]);
end;

function fRNVL( strVal : string) : string;
begin
  if strVal = '|' then result := ''
  else result := StringReplace(Trim(strVal),'@',' ',[rfReplaceAll]);
end;

end.

