//공통함수
//작성일 : 2011.7.20
//작성자 : 구내영

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

  SEEDPBKAITSHOPKEY = 'K2I5I4S3L3C0H1U1';

  // 메세지
  SEL_SUCCESS = '조회 할 내역이 없습니다.';
  ADD_SUCCESS = '등록 완료';
  MOD_SUCCESS = '수정 완료';
  DEL_SUCCESS = '삭제 완료';

//Z001 데이터 구조
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



//Z001 데이터를 저장하기위한 변수
var
	z001Data:Array of TZ001;
	z001DataCount:Integer;

var EvHandler:TEventHandlers;

//공통변수
var common_kait       :String = 'X/hhP1cTg/pXHxebWsq/txFVvW8=';	// KAIT를 암호화
var common_handle     :String ='0'; 		                        // 자신의 윈도우 핸들
var common_caller     :String ='0';		                          // 호출한 윈도우 핸들
var common_userid     :String ='';   	                          // 사용자ID
var common_username   :String ='';		                          // 사용자명
var common_usergroup  :String ='';	                            // 사용자그롭
var common_seedkey    :String ='';	                            // SEED암호화키

var bitmap : TBitmap;

//파일명을 변경한다. 예)LostPrj.exe ==> LostPrj_.exe
function fChngUnderbar(fname:String):String;forward;

//코드로 부터 네임을 찾는다.
function findNameFromCode(code:String; var data:TZ0xxArray; number:Integer):String;forward;

//네임으로부터 코드를 찾는다.
function findCodeFromName(name:String; var data:TZ0xxArray; number:Integer):String;forward;

function InsHyphen( const strSrc : String) : String; overload; forward;
function InsHyphen( Const strSrc , strType : String) : String; overload; forward;

//파일만 추출하여 반환한다.
//예) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'에서
//마지막 부분 'FileUpload_prj.exe'만 반환한다.
function getFinalName(fullName, delimiter:String):String;forward;

//디렉토리만 추출하여 반환한다.
//예) 'D:\KAIT\LostPrj\BasicFuncTest\File_Upload\FileUpload_prj.exe'에서
//'D:\KAIT\LostPrj\BasicFuncTest\File_Upload'만 반환한다.
function getDirPath(fullName, delimiter:String):String;forward;
function getFrontName(fullName, delimiter:String):String;forward;

//주어진 문자열을 암호하 하여 반환한다.
//패스에 'INIcrypto01h.dll'가 있어야 한다.
function  Get_EncStr(strPara: String):String;forward;

//스트링 그리드의 선택된 레코드를 삭제한다.
procedure DeleteStringGridRow1(var AStringGrid:TStringGrid;Arow:Integer); forward;

//외부 프로그램을 실행시킨다.
function ExecExternProg(progID:String):Boolean; forward;

//스킨초기화
procedure initSkinForm(var skinData:TSkinData);forward;

//문자열변경 (2011-07-11 => 20110711)
function delHyphen(src:String):String;forward;

//폰번호 문자열 변경(010- 234-1943 =>0102341934)
function delHyphenPhone(src:String):String;forward;

//문자열에서 특수문자(space,-,/,...등)을 제거한다.
function delDelimiter(src:String; delimiter:Char):String;forward;

//앞부분의 문자열만 반환한다.
//ex) 123.000 => 123, abcd/dfsjls =>abcd
function firstString(src:String; delimiter:Char):String;forward;

//정수문자열을 콤마가 포함된 문자열로 변환
//예) -123456789 => -123,456,789
function convertWithCommer(src:String):String;forward;

//문자열의 픽셀수를 리턴한다.
function TextSize(AFont: TFont;  Text: String): TPoint;forward;

//Z001 데이터를 콤보박스에 채운다.
procedure initComboBoxWithZ001(var combo:TComboBox);forward;

//Z0xx 데이터를 콤보박스에 채운다.
function initComboBoxWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var combo:TComboBox): Boolean;overload;forward;

function initComboBoxWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var combo:TComboBox;cmdcd1, cmdcd2, cmdcd3 : shortstring): Boolean; overload;forward;

//Z0xx 데이터를 리스트박스에 채운다.
procedure initStrinGridWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var grid:TStringGrid;cmdcd1, cmdcd2, cmdcd3 : shortstring);overload;forward;

procedure initStrinGridWithZ0xx(fname:String; var data:TZ0xxArray; head,tail:String; var grid:TStringGrid); overload;forward;

//파일을 출력한다.
procedure linePrint(orient, fname:String; nPage : Integer;
                    fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal); overload;
procedure linePrint_z4mplus(orient, fname:String; nPage : Integer;
                    fHeight : Cardinal; gap: Cardinal; exGap : Cardinal; lGap : Cardinal); overload;
procedure linePrint(orient, fname:String;nPage : Integer);forward; overload;
procedure linePrint(orient, fname:String);forward; overload;

// 해당 개체의 문자열을 체크하고 팝업으로 알려주며, 포커스를 맞추어 입력할 수 있게 한다.
// 설정한 비교값에 따라 비교하며 성공시 True, 실패시 False 를 반환한다.
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

// 기존 공통에서 가져옮
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

// 2015.06.22 추가
function  UDF_GetToken(Const Source: String; Source_Type: String): TStrings;

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
{* function   명   : InsHyphen											                      *}
{* function 기능   : 지정한 문자열에 하이픈을 붙여서 되돌려 준다		      *}
{* function 사용법 : InsHyphen(전환변수) or InsHyphen(전환변수,전환형식)  *}
{* 작     성    자 : 최대성												                        *}
{* 작     성    일 : 2011.08.08											                      *}
{**************************************************************************}
function InsHyphen( const strSrc : String) : String; overload;
var
  strTar : String;
begin
  strTar := '';

	Case Length(Trim(Strsrc)) Of
		5 : Strtar := '3-2';		// 새로운 우편번호
		6 : Strtar := '3-3';		// 우편번호
		8 : Strtar := '4-2-2';	// 년월일
		9 : Strtar := '2-3-4';	// 전화번호(서울)
		10 : If(Copy(Strsrc,0,2) = '02') Then Strtar := '2-4-4'
				Else Strtar := '3-3-4';	// 유선전화(서울) Or 핸드폰
		11 : Strtar := '3-4-4'; // 핸드폰 Or 지역 유선전화
		13 : Strtar := '6-7';		// 주민> 번호
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

  //배열 크기를 구하기 위해 '-'의 개수를 구함
  for i:= 0 to Length(strType) -1 do
    begin
    if(copy(strType,i,1) = '-') then _cnt := _cnt + 1;
    end;

  setLength(arrInt,_cnt + 1);

  // 배열에 문자열의 길이를 담음
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

  // 배열에 문자열을 추가
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

  // 배열에 담긴 문자열에 '-'를 추가함
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

  sheight :Cardinal;	  //문자열 높이
  ygap    :Cardinal;		//라인 사이의 갭, 1mm
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

  Printer.BeginDoc;	//이부분을 위것 보다 먼저실행하면 에러발생...

  //본 단위를 바꾸면 글자 숫자 계산을 다시해야 함.
  SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm 단위

  Canvas.Font.Name    := '굴림체';   		  //위치 조정불가 하므로 폰트는 변경불가
  Canvas.Font.Height  := fHeight;  				    //글자체 높이 4mm

  //Canvas.Font.Style:= [fsBold];

  sheight := Canvas.TextHeight('가'); 	  //문자높이 계산, 4mm
  ygap:= gap;								              //line사이의 갭, 1mm 갭

  //첫번째는 빈 라인이 없으므로
  yposi :=  sheight + ygap + exGap;
  buff  :=  '';

  while  not EOF(F) do
  begin

    //마지막 빈 페이지 출력을 방지하기 위해 앞 부분에서 비교한다.
    //페이지를 바꿔야 할 경우 아래 문자열이 있는지 첵크할 것
    Inc(_cnt);

    if (Pos('한국정보통신진흥협회', buff) <> 0) or ((nPage <> 0) and ((nPage + 1) = _cnt)) then
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
  printerName : string;

  sheight :Cardinal;	  //문자열 높이
  ygap    :Cardinal;		//라인 사이의 갭, 1mm
  yposi   :Cardinal;

  i       : Integer;
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

  sPrn  :=  '';
  buff  :=  '';

  //for i := 0 to Printer.Printers.Count - 1 do
  //  Showmessage(Printer.Printers.Strings[i]);

  printerName := 'LPT1';
  for i := 0 to Printer.Printers.Count - 1 do
  begin
      if ( Pos('\ZDesigner', Printer.Printers.Strings[i]) <> 0 ) then
          printerName := Printer.Printers.Strings[i];
  end;

  //sPrn := '^XA' + #13#10;
  //sPrn := sPrn + '^BY2,2.0^FS'               + #13#10;
  //sPrn := sPrn + '^SEE:UHANGUL.DAT^FS'       + #13#10;
  //sPrn := sPrn + '^CW1,E:KFONT3.FNT^CI26^FS' + #13#10;

  YY   := 0;
  while  not EOF(F) do
  begin
    Inc(_cnt);

    //showMessage(intToStr(_cnt));
    if (_cnt MOD 5) = 1 then
    begin
      YY   := 0;
      sPrn := sPrn + '^XA' + #13#10;
      sPrn := sPrn + '^BY2,2.0^FS'               + #13#10;
      sPrn := sPrn + '^SEE:UHANGUL.DAT^FS'       + #13#10;
      sPrn := sPrn + '^CW1,E:KFONT3.FNT^CI26^FS' + #13#10;
    end;

    Readln(F, buff);
    buff := TrimRight(buff);

    YY := YY + 50;
    if (_cnt MOD 5) = 2 then
      sPrn := sPrn + '^FO30,' + intToStr(YY) + '^A1N,22,22^FD' +  buff +  '^FS' + #13#10
    else if (_cnt MOD 5) = 5 then
      sPrn := sPrn + '^FO30,' + intToStr(YY) + '^A1N,22,22^FD' +  buff +  '^FS' + #13#10
    else
      sPrn := sPrn + '^FO30,' + intToStr(YY) + '^A1N,24,24^FD' +  buff +  '^FS' + #13#10;

    if (_cnt MOD 5) = 0 then
    begin
      sPrn := sPrn + '^PQ1,1,1,Y^FS' + #13#10;
      sPrn := sPrn + '^XZ' + #13#10;
    end;

  end;

  //sPrn := sPrn + '^PQ1,1,1,Y^FS';
  //sPrn := sPrn + '^XZ';

  //showMessage(sPrn);
  try
    //AssignFile(OutFile, 'LPT1');
    //Showmessage('printerName = ' + printerName);
    AssignFile(OutFile, printerName);
    //AssignFile(OutFile, '\\192.168.100.104\ZDesigner Z4Mplus 203DPI');
    Rewrite(OutFile);
    Writeln(OutFile, sPrn);
    CloseFile(OutFile);
  except
 //Showmessage('바코드 출력에 문제가 발생했습니다');
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

        // 91번째 값이 'Y' 인 것만 가져옮
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
    z001Data[z001DataCount-1].name := '전체';
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
    z001Data[z001DataCount-1].name := '불명단말기';
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

    //파일 다운로드나 공통코드 업데이트
    if (progID = 'FileDownload') or (progID = 'CodeUpdate') then
		  commandStr := progID +'.exe '+ common_kait +' '+ common_handle
    else if (progID = 'LOSTB150P') then
      commandStr := progID +'.exe ' +
                    common_kait     +' '+
                    common_handle   +' '+
                    common_userid   +' '+
                    common_username +' '+
                    common_usergroup
    else
      commandStr := progID +'.exe ' +
                    common_kait     +' '+
                    common_handle   +' '+
                    common_userid   +' '+
                    common_username +' '+
                    common_usergroup +' '+
                    common_seedkey;

	ret := WinExec(PChar(commandStr), SW_Show);
	if ret <= 31 then begin
		result:= False;

        MessageBeep (0) ;
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');
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
        sErrMsg := '암호를 Hash암호화 하는데 실패했습니다.'+ #13#10 +
                   '전산본부로 연락하십시오' ;
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
        ShowMessage(obj.ClassName + '의 객체 타입이 정의되지 않았습니다.');
        Exit;
      end;

    strValue := delHyphen(Trim(strValue));

    case cond of
      0 : if(Length(strValue) = len)  then Result := True;

      1 : if(Length(strValue) >= len) then Result := True;

      2 : if(Length(strValue) <= len) then Result := True;

      else begin
        ShowMessage('잘못된 사용방법입니다.');
        result := False;
      end;
    end;

    if (not result) then
    begin
      ShowMessage(strTitle + '이(가) 정확하지 않습니다.');
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
  ShowMessage('문자열은 : ' + strVal + ' ' + '길이는 : ' + IntToStr(Length(strval)));
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

    // 아이콘 컴퍼넌트
    bitmap := TBitmap.Create;

    if (component is TSpeedButton) then
    begin
       if UpperCase((component as TSpeedButton).Name) = 'BTN_ADD' then
         begin
           bitmap.LoadFromFile(Loc + '등록.bmp');
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
           bitmap.LoadFromFile(Loc + '수정.bmp');
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
           bitmap.LoadFromFile(Loc + '삭제.bmp');
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
           bitmap.LoadFromFile(Loc + '조회.bmp');
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
           bitmap.LoadFromFile(Loc + '연결.bmp');
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
           bitmap.LoadFromFile(Loc + '인쇄.bmp');
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
           bitmap.LoadFromFile(Loc + '엑셀.bmp');
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
           bitmap.LoadFromFile(Loc + '쿼리.bmp');
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
           bitmap.LoadFromFile(Loc + '초기화.bmp');
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
           bitmap.LoadFromFile(Loc + '미리보기.bmp');
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
           bitmap.LoadFromFile(Loc + '인쇄설정.bmp');
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
           bitmap.LoadFromFile(Loc + '닫기.bmp');
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
    ShowMessage('일반적이지 않은 상태바 타입입니다.');
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

    // 91번째 값이 'Y' 인 것만 가져옮
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


function  UDF_GetToken(Const Source: String; Source_Type: String): TStrings;
var
  sText: String;
begin
   Result := TStringList.Create;
   sText  := Source;
   while  Length(sText)  >  0  Do begin
          if   Pos(Source_Type, sText) > 0 then
          begin
               Result.Add(Copy(sText, 1, Pos(Source_Type, sText)-1));
               System.Delete(sText,1, Pos(Source_Type, sText));
          end
          else
          begin
               Result.Add(sText);
               sText := '';
          end; // of If Pos ... Else...
   end; // of While.
end;

end.

