unit cpaklibm;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, IniFiles, cpakmsg, shellapi, checklst ;

Const
	TCA_CLIID		= 0 ;
	TCA_CLINM		= 1 ;
	TCA_CLIKIND		= 2 ;
	TCA_CLIOS		= 3 ;
	TCA_TPHOME		= 4 ;
	TCA_TPINI		= 5 ;
	TCA_ASID		= 6 ;
	TCA_ASHOME		= 7 ;
	TCA_ASCNTL		= 8 ;
	TCA_ASAPPL		= 9 ;
	TCA_ASINI		=10 ;
	TCA_USID		=11 ;
	TCA_USNM		=12 ;
	TCA_UGRP		=13 ;
	TCA_UGRPNM		=14 ;
	TCA_ULEV		=15 ;
	TCA_ULEVNM		=16 ;
	TCA_TXID		=17 ;
        TCA_UCASIZE		=18 ;

var
   bApiInit : Boolean = True ;
   LinkRcvRecNo : integer = -1 ;
   LinkSndRecNo : integer = -1 ;


{------------------------- 함수 선언 ----------------------------}
function CSendData (txid : shortstring ; data : pchar ; datalen : integer)
			: integer ; forward;
function CRecvData (data : pchar ; bEndtx : Bool)
          : integer ; forward;
function CSendRecv (txid : shortstring ; sdata : pchar ; datalen : integer
          ; rdata : pchar ; bEndtx : Bool) : integer ; forward;
function CGetTca (itemNo : integer)
			: shortstring ; forward;
function CArrToStr (src : array of char)
          : shortstring ; forward;
function CStrToArr (src : shortstring ; var dest : array of char ; NullTerm : Bool)
          : integer ; forward;
function CFillStr (src : shortstring ; fChar : char ; size : integer ; bFront : Bool)
          : shortstring ; forward;
function CNumOnly (src : shortstring)
			 : shortstring ; forward;
function CRemoveSpace (src : shortstring)
			 : shortstring ; forward;
function CRunPgm (MyHwnd : HWnd ; PgmId, RunArg : shortstring ; Opt : Cardinal)
		 : integer ; forward;
function CExecuteFile( MyHwnd : HWnd ; const FileName, Params, DefaultDir: shortstring;
  ShowCmd: Integer): THandle; forward;
function CLoadCode (codgu, cmdcd1, cmdcd2, cmdcd3 : shortstring ; dest : TControl)
			 : Bool ; forward;
function CLoadCodeNm (codgu, cmdcd1, cmdcd2, cmdcd3, codnm : shortstring ; dest : TControl)
			 : Bool ; forward;
//------------- 사용자 check ---------------------------------//
procedure Capiinit ; forward;
procedure Capiend ; forward;
//-------------------------code help------------------------------------------//
function CFindCode (codgu, codno : shortstring)
			 : shortstring ; forward;
//-------------------------link---------------------------------------------//
function CLinkFindFreeUca( FPgmId, TPgmId : shortstring ) : integer ; forward;
function CLinkFindById (ToPgmId : shortstring ; var LinkRec : TLinkRec)
		 : integer ; forward;
function CLinkFindByNo (LinkRecNo : longint ; var LinkRec : TLinkRec)
		 : Bool ; forward;
function CLinkRecv (MyHwnd : HWND ; LinkRecNo : longint ; var LinkRec : TLinkRec)
		 : bool ; forward;
function CLinkSendOK (MyHwnd : hwnd ; LinkRecNo : longint)
		 : bool ; forward;
procedure CLinkEnd (MyHwnd : Hwnd ; LinkRecNo : integer ; RtnStr : shortstring)
		 ; forward;
function CLinkSend (MyHwnd : HWnd ; FPgmId, TPgmId, RunArg : shortstring ; bWaitRtn : Bool)
		 : integer ; forward;
function CLinkEndRecv (MyHwnd : HWnd ; LinkRecNo : longint ; var LinkRec : TLinkRec)
		 : Bool ; forward;
procedure CLinkInit (MyHwnd : HWnd ; PgmId : shortstring)
		 ; forward;

{------------------------- dltp 함수 선언 ---------------------------}
function Zapiinit (asid : pchar)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zapiend : integer ; stdcall ; external 'tpapi32.dll';
function ZapiendX (option : integer)
			: integer ; stdcall ; external 'tpapi32.dll';

function Zstarttx (txid : pchar ; data : pchar ; datalen : integer)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zsupertx (txid : pchar ; data : pchar ; datalen : integer)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zendtx : integer ; stdcall ; external 'tpapi32.dll';

function Zulogin (usid, pswd : pchar)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zulogout : integer ; stdcall ; external 'tpapi32.dll';

function Zsend (data : pchar ; datalen : integer)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zrecv (data : pchar)
          : integer ; stdcall ; external 'tpapi32.dll';

function Zreaduca (data : pchar ; size : integer ; offset : integer)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zwrtuca (data : pchar ; size : integer ; offset : integer)
          : integer ; stdcall ; external 'tpapi32.dll';

function Zgettca (data : pchar)
          : integer ; stdcall ; external 'tpapi32.dll';
function Zputtca (data : pchar)
          : integer ; stdcall ; external 'tpapi32.dll';

function Zsendfile (fpath : pchar ; ftype, compress : char)
			: integer ; stdcall ; external 'tpapi32.dll';
function Zrecvfile (fpath : pchar ; overwrite : char)
			: integer ; stdcall ; external 'tpapi32.dll';

{------------------------------------------------------------------------------}


implementation

procedure Capiinit ;
begin
     if Zapiinit ('CPAK') = -1 then
     begin
   	  MessageBeep (0) ;
          ShowMessage ('프로그램이 종료됩니다') ;
   	  bApiInit := False ;
          Application.Terminate ;
     end ;
end ;

procedure Capiend ;
begin
	if bApiInit then
   	Zapiend ;
end ;

function CSendData (txid : shortstring ; data : pchar ; datalen : integer)
          : integer ; 
var lptxid : array[0..8] of char ;
    rtn : integer ;
begin
     CStrToArr (txid, lptxid, True) ;

     if length (Trim (txid)) <> 0 then
        rtn := Zstarttx (lptxid, data, datalen)
     else
     begin
         rtn := Zsend (data, datalen) ;
         if rtn < 0 then
            Zendtx ;
     end ;

     result := rtn ;
end ;

function CRecvData (data : pchar ; bEndtx : Bool) : integer ; 
var rtn : integer ;
begin
     rtn := Zrecv (data) ;
     if bEndtx or (rtn < 0) then
        Zendtx ;

     result := rtn ;
end ;

function CSendRecv (txid : shortstring ; sdata : pchar ; datalen : integer
          ; rdata : pchar ; bEndtx : Bool) : integer ; 
begin
     if CSendData (txid, sdata, datalen) < 0 then
     begin
        result := -1 ;
        exit ;
     end ;

     result := CRecvData (rdata, bEndtx) ;
end ;

function CGetTca (itemNo : integer) : shortstring ; 
type
	ptca = ^Ttca ;
	Ttca = record // 1024 bytes
		myproc	: longint ;
		// Client Information (252)
		cliid	: array[0..7]  of char ;	// client id
		clinm	: array[0..19] of char ;	// client name rcved from server
		clikind : array[0..0]  of char ;	// client kind = 'T'erminal always
		clios	: array[0..0]  of char ;	// client o/s '0'=DOS,'1'=WIN31,'2'=WIN95
		tphome	: array[0..79] of char ;	// DLTP install home directory
		tpini	: array[0..79] of char ;	// TPCLI.ini file path
		filler1	: array[0..61] of char ;
		// AS Information ( 512 )
		asid	: array[0..3]  of char ;	// Appl. system id
		ashome	: array[0..79] of char ;	// Appl. home directory
		ascntl	: array[0..79] of char ;	// Appl. Control data directory
		asappl	: array[0..79] of char ;	// Appl. Runfile directory
		asini	: array[0..79] of char ;	// ASINI.ini file path
		filler2 : array[0..75] of char ;
		ucasize : integer ;					// UCASIZE in bytes
		mainhost: array[0..0]  of char ;	// MAIN SERVER hostid
		filler3	:array[0..106] of char ;
		// User Information ( 128 )
		usid	: array[0..7]  of char ;	// User id loggedin
		filler7 : array[0..7]  of char ;	// 이전 password 자리
		usnm	: array[0..11] of char ;	// User name logged in. rcved from server
		ugrp	: array[0..3]  of char ;	// User groupid. rcved from server
		ugrpnm	: array[0..19] of char ;	// User group name. rcved from server
		ulev	: array[0..0]  of char ;	// User Level Id. rcved from server
		ulevnm	: array[0..19] of char ;	// User Level name. rcved from server
		filler4 : array[0..54] of char ;
		// Session Information ( 64 )
		ssno	: array[0..3]  of char ;	// host session no. rcved from server
		proto	: array[0..0]  of char ;	// comm. protocol. '0'=TCP,'1'=ASYNC
											// '2'=SNA
		loginmode:array[0..0]  of char ;	// 'T'=개발자모드, 'U'=user mode
		persist : array[0..0]  of char ;	// 서버접속모드.'T'ransient, 'R'esident
		hostid	: array[0..0]  of char ;	// current HOSTID
		portno	: Cardinal ;			 	// current host portno
		hostname: array[0..19] of char ;	// current host hostname
		txid	: array[0..7]  of char ;	// current host TXID
		bind	: array[0..0]  of char ;	// 세션접속모드, 'B'ound, 'U'nbound
		usercaps: array[0..0]  of char ;	// User ID, password 대소문자 구분 여부. 0:대소문자 구분, 1:User ID
											// 대문자 처리, 2:password도 대문자 처리
		filler5 : array[0..21] of char ;
		// status time ( 64 )
		logintm	: longint ;					// session login time ( time_t )
		tpstarttm:longint ;					// tp start	 time ( time_t )
		txstarttm:longint ;					// transaction start time ( time_t )
		ulogintm: longint ;					// user    login time ( time_t )
		uloginsts:array[0..0]  of char ;	// user login status
		filler6	: array[0..46] of char ;
   end ;
var
       tca : ptca ;
begin
   New (tca) ;
   Zgettca (PChar (tca)) ;
	case itemNo of
		TCA_CLIID	: result := Trim (CArrToStr (tca^.cliid)) ;
		TCA_CLINM	: result := Trim (CArrToStr (tca^.clinm)) ;
		TCA_CLIKIND : result := Trim (CArrToStr (tca^.clikind)) ;
		TCA_CLIOS	: result := Trim (CArrToStr (tca^.clios)) ;
		TCA_TPHOME	: result := Trim (CArrToStr (tca^.tphome)) ;
		TCA_TPINI	: result := Trim (CArrToStr (tca^.tpini)) ;
		TCA_ASID	: result := Trim (CArrToStr (tca^.asid)) ;
		TCA_ASHOME	: result := Trim (CArrToStr (tca^.ashome)) ;
		TCA_ASCNTL	: result := Trim (CArrToStr (tca^.ascntl)) ;
		TCA_ASAPPL	: result := Trim (CArrToStr (tca^.asappl)) ;
		TCA_ASINI	: result := Trim (CArrToStr (tca^.asini)) ;
		TCA_USID	: result := Trim (CArrToStr (tca^.usid)) ;
		TCA_USNM	: result := Trim (CArrToStr (tca^.usnm)) ;
		TCA_UGRP	: result := Trim (CArrToStr (tca^.ugrp)) ;
		TCA_UGRPNM	: result := Trim (CArrToStr (tca^.ugrpnm)) ;
		TCA_ULEV	: result := Trim (CArrToStr (tca^.ulev)) ;
		TCA_ULEVNM	: result := Trim (CArrToStr (tca^.ulevnm)) ;
		TCA_TXID	: result := Trim (CArrToStr (tca^.txid)) ;
                TCA_UCASIZE : result := IntToStr (tca^.ucasize) ;
       else	result := '' ;
   end ;
   Dispose (tca) ;
end ;

function CArrToStr (src : array of char)
          : shortstring ; 
var
   tmppchar : pchar ;
begin
   tmppchar := StrAlloc (sizeof (src) + 1) ;
   strlcopy (tmppchar, @src, sizeof (src)) ;
   tmppchar[sizeof (src)] := #0 ;
   result := StrPas (tmppchar) ;
   StrDispose (tmppchar) ;
end ;

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

//-------------------------code help------------------------------------------//
function CFindCode (codgu, codno : shortstring)
		 : shortstring ; 
var
   FName : shortstring ;
   RFile : TextFile ;
   ReadStr : shortstring ;
begin
     result := '' ;

     if (length (Trim (codgu)) = 0) or (length (Trim (codno)) = 0)then
        exit ;

     FName := CGetTca (TCA_ASAPPL) ;
     if length (FName) = 0 then
        exit ;

     FName := FName + '\' + Trim (codgu) + '.dat' ;

     if Not FileExists (FName) then
        exit ;

     AssignFile(RFile, FName);
     Reset(RFile);
     try
     repeat
   	   Readln (RFile, ReadStr) ;
           if Trim (copy (ReadStr, 41, 10)) = trim (codno) then
           begin
       	        result := ReadStr ;
       	        exit ;
           end ;
     until eoln (RFile) ;

     finally
   	    CloseFile(RFile);
     end;
end ;
//-------------------- For Link-----------------------------------------//
function CLinkFindFreeUca( FPgmId, TPgmId : shortstring ) : integer ; 
{
return val
	-1 : Error
   else : Free LinkRec No
}
var
   idx : integer ;
   UcaSize : integer ;
   LinkRec : TLinkRec ;
begin
     result := -1 ;

     try
        UcaSize := StrToInt (CGetTca (TCA_UCASIZE)) ;
     Except
   	on EConvertError do
       	   exit ;
     end ;

     for idx := 0 to UcaSize div sizeof (TLinkRec) - 1 do
     begin
          if Zreaduca (@LinkRec, sizeof (TLinkRec), idx * sizeof (TLinkRec)) = -1 then
          begin
               exit ;
          end ;
          if LinkRec.UseYN <> 'Y' then
          begin
               result := idx ;
       	       break ;
          end ;
          // 추가 : 같은 FPgmId, TPgmId이면 그 코드를 return한다.
          if ( trim (CArrToStr (LinkRec.ToPgm.PgmId)) = trim (TPgmId) ) and
             ( trim (CArrToStr (LinkRec.FromPgm.PgmId)) = trim (FPgmId) ) then
          begin
       	       result := idx + 10 ;
               break ;
          end ;
     end ;
end ;

function CLinkFindById (ToPgmId : shortstring ; var LinkRec : TLinkRec)
		 : integer ; 
var
   UcaSize : integer ;
   idx : integer ;
begin
     result := -1 ;

     if trim (ToPgmId) = '' then
        exit ;

     try
   	UcaSize := StrToInt (CGetTca (TCA_UCASIZE)) ;
     Except
   	on EConvertError do
       	   exit ;
     end ;

     for idx := 0 to UcaSize div sizeof (TLinkRec) - 1 do
     begin
          if Zreaduca (@LinkRec, sizeof (TLinkRec), idx * sizeof (TLinkRec)) = -1 then
          begin
       	       exit ;
          end ;
          if trim (CArrToStr (LinkRec.ToPgm.PgmId)) = trim (ToPgmId) then
          begin
       	       result := idx ;
               break ;
          end ;
     end ;

end ;

function CLinkFindByNo (LinkRecNo : longint ; var LinkRec : TLinkRec)
		 : Bool ; 
var
   UcaSize : integer ;
begin
     result := false ;

     if LinkRecNo < 0 then
   	exit ;

     try
   	UcaSize := StrToInt (CGetTca (TCA_UCASIZE)) ;
     Except
   	on EConvertError do
       	   exit ;
     end ;

     if UcaSize div sizeof (TLinkRec) - 1 < LinkRecNo then
        exit ;

     if Zreaduca (@LinkRec, sizeof (TLinkRec), LinkRecNo * sizeof (TLinkRec)) = 0 then
   	result := true ;
end ;

function CLinkRecv (MyHwnd : HWND ; LinkRecNo : longint ; var LinkRec : TLinkRec)
		 : bool ; 
begin
   if (not CLinkFindByNo (LinkRecNo, LinkRec)) or
      (LinkRec.ToPgm.handle <> MyHwnd) or
      (LinkRec.UseYN <> 'Y') then
   begin
   	result := false ;
   	exit ;
   end ;

   result := true ;
end ;

function CLinkSendOK (MyHwnd : hwnd ; LinkRecNo : longint)
		 : bool ; 
var
   LinkRec : TLinkRec ;
begin
   if (not CLinkFindByNo (LinkRecNo, LinkRec)) or
      (LinkRec.ToPgm.handle <> MyHwnd) or
      (LinkRec.UseYN <> 'Y') then
   begin
   	result := false ;
   	exit ;
   end ;

   postmessage (LinkRec.FromPgm.handle, WM_LINK, LINKOK, LinkRecNo) ;
   result := true ;
end ;

procedure CLinkEnd (MyHwnd : Hwnd ; LinkRecNo : integer ; RtnStr : shortstring) ; 
var
   LinkRec : TLinkRec ;
begin
   if (not CLinkFindByNo (LinkRecNo, LinkRec)) or
      (LinkRec.ToPgm.handle <> MyHwnd) or
      (LinkRec.UseYN <> 'Y') then
   	exit ;

   LinkRec.RtnStr := RtnStr ;

   if Zwrtuca (@LinkRec, sizeof (LinkRec), LinkRecNo * sizeof (LinkRec)) = -1 then
   	exit ;

   postmessage (LinkRec.FromPgm.handle, WM_LINK, LINKRETURN, LinkRecNo) ;
end ;

function CRunPgm (MyHwnd : HWnd ; PgmId, RunArg : shortstring ; Opt : Cardinal)
		 : integer ; 
var
   FPath : shortstring ;
   lpszFPath : array [0..255] of char ;
   lpszFName : array [0..12] of char ;
   lpszRunArg : array [0..100] of char ;
begin
     result := -1 ;

     FPath := CGetTca (TCA_ASAPPL) ;
     if trim (FPath) = '' then
   	exit ;

     CStrToArr (FPath, lpszFPath, true) ;
     CStrToArr (PgmId + '.exe', lpszFName, true) ;
     CStrToArr (RunArg, lpszRunArg, true) ;
     result := ShellExecute (MyHwnd, 'open', lpszFName,
                                     lpszRunArg, lpszFPath, Opt) ;
end ;

function CExecuteFile( MyHwnd : HWnd ; const FileName, Params, DefaultDir: shortstring;
  ShowCmd: Integer): THandle;
var
  zFileName, zParams, zDir: array[0..99] of Char;
begin
    Result := ShellExecute( MyHwnd, nil,
           StrPCopy(zFileName, FileName), StrPCopy(zParams, Params),
           StrPCopy(zDir, DefaultDir), ShowCmd);
end;

function CLinkSend (MyHwnd : HWnd ; FPgmId, TPgmId, RunArg : shortstring ; bWaitRtn : Bool)
		 : integer ; 
var
   LinkRecNo : integer ;
   LinkRec : TLinkRec ;
   ToHandle : THandle;
begin
     result := -1 ;

     if (trim (FPgmId) = '') or (trim (TPgmId) = '') then
   	exit ;

     LinkRecNo := CLinkFindFreeUca( FPgmId, TPgmId ) ;
     if LinkRecNo = -1 then
   	exit ;

     LinkRec.UseYN := 'Y' ;
     CStrToArr (trim (FPgmId), LinkRec.FromPgm.PgmId, false) ;
     LinkRec.FromPgm.handle := MyHwnd ;
     CStrToArr (trim (TPgmId), LinkRec.ToPgm.PgmId, false) ;
     LinkRec.WaitRtn := bWaitRtn ;

//   if Zwrtuca (@LinkRec, sizeof (TLinkRec), LinkRecNo * sizeof (TLinkRec)) = -1 then
//   	exit ;

   if LinkRecNO < 9 then
   begin
      ToHandle := CRunPgm (MyHwnd, TPgmId, RunArg, SW_SHOW);     // 추가
      if ToHandle < 32 then
      begin
   	   LinkRec.UseYN := ' ' ;
           Zwrtuca (@LinkRec, 1, LinkRecNo * sizeof (TLinkRec)) ;
   	   exit ;
      end ;
      LinkRec.ToPgm.handle := ToHandle;   // 추가
      if Zwrtuca (@LinkRec, sizeof (LinkRec), LinkRecNo * sizeof (TLinkRec)) = -1 then
   	 exit ;
   end
   else
       LinkRecNo := LinkRecNO - 10;

   result := LinkRecNo ;
end ;

function CLinkEndRecv (MyHwnd : HWnd ; LinkRecNo : longint ; var LinkRec : TLinkRec)
		: Bool ; 
begin
	result := false ;

   if (not CLinkFindByNo (LinkRecNo, LinkRec)) or
	   (LinkRec.FromPgm.handle <> MyHwnd) or
      (LinkRec.UseYN <> 'Y') then
   	exit ;

	LinkRec.UseYN := ' ' ;
        Zwrtuca (@LinkRec, 1, LinkRecNo * sizeof (TLinkRec)) ;
        result := true ;
end ;

procedure CLinkInit (MyHwnd : HWnd ; PgmId : shortstring)
		 ; 
var
	LinkRec : TLinkRec ;
        LinkRecNo : integer ;
begin
	LinkRecNo := CLinkFindById (PgmId, LinkRec) ;
	if (LinkRecNo < 0) or
           (LinkRec.UseYN <> 'Y') then
   	exit ;

	LinkRec.ToPgm.handle := MyHwnd ;

        if Zwrtuca (@LinkRec, sizeof (TLinkRec), LinkRecNo * sizeof (TLinkRec)) = -1 then
   	exit ;

	postmessage (MyHwnd, WM_LINK, LINKSTART, LinkRecNo) ;

end ;

function CLoadCode (codgu, cmdcd1, cmdcd2, cmdcd3 : shortstring ; dest : TControl)
			 : Bool ;
{
   이 함수는 combobox나 listbox에 결과를 넣어 주기 위해 cpaklib.dll에 넣지
   않고 cpakmain.pas에 코드를 작성했다.
}
{
   코드 구분과 전산코드에 해당하는 코드 아이템들을 dest (combobox or listbox)에
   넣어 준다.
   전산코드의 조건 검색은 'and' 연산이며, '' 값은 해당 전산코드의 조건 검색을
   하지 않을 경우 사용한다.
   코드 명 (40) + 코드 (10) + 전산코드1 (10) + 전산코드2 (10) + 전산코드3 (10)
}
{
   예 : 코드 구분이 'CA01'이고 전산 코드 1이 '2'에 해당하는 코드들을 원할 경우
   CLoadCode ('CA01', '2', '', '', combobox1) ;
}
// return value : OK - True, Error - False
var
   FName : shortstring ;
   RFile : TextFile ;
   ReadStr : shortstring ;
begin
     result := false ;

     if (dest.classtype = TCombobox) then
   	 TCombobox (dest).clear
     else if (dest.classtype = TListBox) then
   	 TListbox (dest).clear
     else if (dest.classtype = TCheckListBox) then
   	 TListbox (dest).clear
     else
         exit ;

     if length (Trim (codgu)) = 0 then
         exit ;

     FName := CGetTca (TCA_ASAPPL) ;
     if length (FName) = 0 then
         exit ;

     FName := FName + '\' + Trim (codgu) + '.dat' ;

     if Not FileExists (FName) then
        exit ;

     AssignFile(RFile, FName);
     Reset(RFile);
     try
     repeat
   	Readln (RFile, ReadStr) ;
    	if (cmdcd1 <> '') then
    		if Trim (copy (ReadStr, 51, 10)) <> trim (cmdcd1) then
       		continue ;
    	if (cmdcd2 <> '') then
    		if Trim (copy (ReadStr, 61, 10)) <> trim (cmdcd2) then
       		continue ;
    	if (cmdcd3 <> '') then
    		if Trim (copy (ReadStr, 71, 10)) <> trim (cmdcd3) then
       		continue ;
        if (dest.classtype = TCombobox) then
    		TComboBox (dest).Items.add (ReadStr)
        else if (dest.classtype = TListbox) then
    		TListBox (dest).Items.add (ReadStr)
        else
    		TCheckListBox (dest).Items.add (ReadStr) ;
     until eoln (RFile) ;

     finally
   	    CloseFile(RFile);
     end;

     result := true ;
end ;

function CLoadCodeNm (codgu, cmdcd1, cmdcd2, cmdcd3, codnm : shortstring ; dest : TControl)
			 : Bool ;
{
   이 함수는 combobox나 listbox에 결과를 넣어 주기 위해 cpaklib.dll에 넣지
   않고 cpakmain.pas에 코드를 작성했다.
}
{
   코드 구분과 전산코드에 해당하는 코드 아이템들을 dest (combobox or listbox)에
   넣어 준다.
   전산코드의 조건 검색은 'and' 연산이며, '' 값은 해당 전산코드의 조건 검색을
   하지 않을 경우 사용한다.
   코드 명 (40) + 코드 (10) + 전산코드1 (10) + 전산코드2 (10) + 전산코드3 (10)
}
{
   예 : 코드 구분이 'CH03'이고 전산 코드 1이 '2'이고 코드명이 '가'에 해당하는
   코드들을 원할 경우
   CLoadCodeNm ('CH03', '2', '', '', '가', combobox1) ;
}
// return value : OK - True, Error - False
var
   FName : shortstring ;
   RFile : TextFile ;
   ReadStr : shortstring ;
   codnmlen : integer;
begin
     result := false ;

     if (dest.classtype = TCombobox) then
        TCombobox (dest).clear
     else if (dest.classtype = TListBox) then
   	TListbox (dest).clear
     else if (dest.classtype = TCheckListBox) then
   	TListbox (dest).clear
     else
         exit ;

     if length (Trim (codgu)) = 0 then
        exit ;

     FName := CGetTca (TCA_ASAPPL) ;
     if length (FName) = 0 then
        exit ;

     FName := FName + '\' + Trim (codgu) + '.dat' ;

     if Not FileExists (FName) then
        exit ;

     codnmLen := length(trim (codnm)) ;
     if codnmLen > 40 then
   	codnmLen := 40 ;

     AssignFile(RFile, FName);
     Reset(RFile);
     try
     repeat
   	   Readln (RFile, ReadStr) ;
    	   if (codnmLen > 0) then
    	      if Trim (copy (ReadStr, 1, codnmLen)) < trim (codnm) then
       		 continue ;
           if (cmdcd1 <> '') then
              if Trim (copy (ReadStr, 51, 10)) <> trim (cmdcd1) then
                 continue ;
           if (cmdcd2 <> '') then
              if Trim (copy (ReadStr, 61, 10)) <> trim (cmdcd2) then
       		 continue ;
           if (cmdcd3 <> '') then
              if Trim (copy (ReadStr, 71, 10)) <> trim (cmdcd3) then
       		 continue ;
           if (dest.classtype = TCombobox) then
              TComboBox (dest).Items.add (ReadStr)
           else if (dest.classtype = TListbox) then
    		TListBox (dest).Items.add (ReadStr)
           else
    		TCheckListBox (dest).Items.add (ReadStr) ;
     until eoln (RFile) ;

     finally
   	    CloseFile(RFile);
     end;

     result := true ;
end ;

end.

