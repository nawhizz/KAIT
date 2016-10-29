unit LALMCommon;

interface

Uses  SysUtils, Classes, IniFiles, Messages, StdCtrls, Dialogs;

type
  TAucInfo =  Packed record
    AucDate         :  String;   // 경매일
    AucType         :  String;   // 경매대상       1.송아지  2.비육우   3.번식우
    NaBzplc         :  String;   // 경제통합사업장코드
    NaBzplcNm       :  String;   // 경제통합사업장명
    CurOslpNo       :  String;   // 선택된 원표번호
    AmtUnit         :  Integer;  // 경매응찰금액 단위
    AucNo           :  String;   // 선택된 경매번호
    BcowType        :  String;   // 비육우 경매단위 (Kg / 두당)
    BcowTrunc       :  String;   // 비육우 절사단위
    BcowTruncAmt    :  Real;   // 비육우 절사금액단위
    Login           :  String;
  end;
  PAucInfo = ^TAucInfo;

type
  TVoiceInfo =  Packed record
    Voice1       :  String;
    Voice2       :  String;
    Voice3       :  String;
    Voice4       :  String;
    Voice5       :  String;
    Voice6       :  String;
    Voice7       :  String;
    Voice8       :  String;
    Voice9       :  String;
    Voice10      :  String;
    Voice11      :  String;
    Voice12      :  String;
  end;
  PVoiceInfo = ^TVoiceInfo;

type
  TAucConfig =  Packed record
    DispHost1         : String;  // 전광판                                    Display_Host
    DispHostPort1     : String;  // 전광판                                    Display_Host  port
    PDPType           : String;  // PDP화면설정
    PDPHost1          : String;  // PDP                                       Display_Host1
    PDPHostPort1      : String;  // PDP                                       Display_Host1 port
    PDPHost2          : String;  // 응찰자석 PDP                              Display_Host2
    PDPHostPort2      : String;  // PDP                                       Display_Host2 port
    DispFormat        : String;  // 표출데이타 포멧                           Display_format

    AucNo_Len         : Integer;
    FarmNo_Len        : Integer;
    Sex_Len           : Integer;
    Weight_Len        : Integer;
    Mother_Len        : Integer;
    Geydae_Len        : Integer;
    Sancha_Len        : Integer;
    Kpn_Len           : Integer;
    Area_Len          : Integer;
    Bigo_Len          : Integer;
    MinAmt_Len        : Integer;
    MaxAmt_Len        : Integer;
    AmnNo_Len         : Integer;

    PAucNo_Len         : Integer;
    PFarmNo_Len        : Integer;
    PSex_Len           : Integer;
    PWeight_Len        : Integer;
    PMother_Len        : Integer;
    PGeydae_Len        : Integer;
    PSancha_Len        : Integer;
    PKpn_Len           : Integer;
    PArea_Len          : Integer;
    PBigo_Len          : Integer;
    PMinAmt_Len        : Integer;
    PMaxAmt_Len        : Integer;
    PAmnNo_Len         : Integer;

    TerminalYn        : String;  //응찰기 사용여부                            Terminal
    AucBaseUnit       : String;  // 경매기본단위                              Add_zero
    DataFormat        : String;  // 데이타 포맷                               Com_Format
    SerialPort        : String;  // 통신포트                                  Com_Port
    SerialSpeed       : String;  // 통신 속도                                 Com_Speed
    LowNo             : string;  //법인번호                                   Low_No
    TablelNo          : string;  //경매대 번호                                Tag_No
    TerminalGubun     : string;  // 응찰기 신형/구형  0 : 구형,   1 : 신형

    Voice             : string;  //음성 설정                                  Select_chk
    ReAucCnt          : string;  //재경매 횟수                                ReAuct_cnt
    NotBidVoice       : string;  // 유찰경매 음성 선택 (1:멘트함 0:안함)      chk_result_gubun

    VoiceType         : string;   // 목소리 선택                              Voice_Speaker
    AucLimitSec       : string;   // 1건 경매제한시간 default: 30초           Limit_Sec
    FinalSec          : string;   // 초사인  3, 5 초                          Final_Sec
    VoiceSpeed        : string;   // 음성 속도                                Voice_Speed
    VoicePitch        : string;   //  목소리 톤                               Voice_Pitch
    VoiceYn           : string;   //  음성경매여부
{
    cMaxAmt           : string;   // 송아지 한도                              cMax_amt
    nMaxamt           : string;   // 번식우 한도                              nMax_amt
    bMaxamt           : string;   // 비육우 한도                              bMax_amt
}
    MaxAmt            : String;   // 응찰한도.

    FAutotRunning     : Boolean;
    PTTS_ChangeAttr   : array[0..255] of char;
  end;
  PAucConfig = ^TAucConfig;

  type
  TPDPDisp =  Packed record
    AucNo          :  String; // 경매번호
    FarmNm         :  String; // 출하주
    Sex            :  String; // 성별
    Weight         :  String; // 중량
    ReservAmt      :  String; // 예정가
    BidAmt         :  String; // 낙찰가
    Bidder         :  String; // 낙찰자
  end;
  PPDPDisp = ^TPDPDisp;

  type
     TRx_data    = record
         key     : double;
         cost    : string;
         broker  : string;
         rx_seq  : string;
         rx_time : string;
         rx_Br_No: String;   //add
  end;

  type
     Trx_broker     = record
         key     : integer;
  end;

  type
     Tchk_broker     = record
         key      : integer;
         chk_disp : Boolean;
  end;


var   gLoginId, gDBServer, gSeedKey : String;
  //  gJohapNm, gPDPport, gAucUnit, gPDPInterval : String;

    Query_Flag    :integer; //보류플래그
    count_flag    :boolean;

    AucInfo   : PAucInfo;
    AucConfig : PAucConfig;
    VoiceInfo : PVoiceInfo;


    // 로그파일 관련
    Next_pointer      : integer;
    _sLogOnOff        : shortstring;
    _iLogLvl          : integer;                                              //Log 기록 Level
    _sAppId           : string;                                               //공통 모듈에서 Application별 특정처리를 위한 Application ID

Const Inifile = 'LALMConfig.Ini';
      _LOG_PATH_        = '.\log\';                                            //Log file 상대 경로
//      PDPInifile = 'PDPConfig.Ini';
      start_wav  = '.\edasstart.wav';
      Cnt_wav    = '.\ding.wav';
      end_wav    = '.\edasend.wav';

      STX = #2;
      ETX = #3;
      ing_row       = 1;  //진행화면배열의크기
      complite_row  = 4;  //완료화면배열의크기
      Wait_Row      = 10; //대기화면배열의크기
      AAcomplite    = 1;  //완료건을   //
      AAing         = 2;  //진행건을   //
      AAwait        = 3;  //대기건을   //

      WM_USER_100   = WM_USER + 100;

     //배열순서
      Csheetno     =  0;// 순번
      Csangi       =  1;// 산지
      Cchulhaju    =  2;// 출하주
      Csex         =  3;// 암수구분
      Cbloodline   =  4;// 혈통
      CSancha      =  5;// 산차
      Cage         =  6;// 계대
      CKpn         =  7;// 아비 KPN
      Cweight      =  8;// 중량
      Cplanprice   =  9;// 최저가
      Cprice       =  10;//낙찰가                            1
      Cbroker      =  11;//낙찰자
      Cresult      =  12;//결과
      Cmemo        =  13;//메모
      Cbar_code    =  14;//바코드
      COslpno      =  15;// 원표번호
      CMacoYn      =  16;// 조합원여부
      CPrnyJugYn   =  17;// 임신감정여부
      CNcssJugYn   =  18;// 괴사감정여부
      CPPGCOW      =  19;
      CRmhnYn      =  20;//제각여부
      CTransYn     =  21;//운송비지급여부

      count_col     = 22; //배열의컬럼수
      Cbroker_cnt  = 20; //중도매인 금액표시 Count

procedure ReadConfig;
function GetBaseAddr(sRegion: string):string;
function GetSanjiByRegion(sRegion: string):string;
function format_str_fill_Space(str:string;strlen,left_right:integer):string;
Function LPad(iSize : Integer; sValue : String; sPadChar:String): String;
Function RPad(iSize : Integer; sValue : String; sPadChar:String): String;
function str_format(str:string;strlen,left_right:integer):string;
procedure FILE_LOG      (pId          : shortstring;                            //Log File Name 생성 및 레벨별 로그파일 작성(fWriteLogFile) Call
                         pIP          : shortstring;
                         pLvl         : integer;
                         pMsg,  AucType : String);
procedure pWriteFile(pLogStr, pFileName: string);
function fCreateFile(pPath, pFileName: string): Boolean;
function cfMkDir(pPath: string): Boolean;
function fWriteLogFile(pLogStr,
                       pFileName: string;
                       pStdLevel,
                       pLevel   : shortint): Boolean;
function cfNow: string;
function cfF10Date(pDate: string): string;
function  cfDelDateGb (pStr  : string)     : string;                 //Date형식 구분자 Delete
function GetAuctionResultCodeName(Code:string): string;
function comma_format(value : string):string;
function rmspace(s:string):string;

implementation

uses LALMMain;

function rmspace(s:string):string;
var i,j  : integer;
    t    : string;
begin
   j := length(s);
   i := 1;
   t := '';
   while  (i <= j)  do  begin
     if  (copy(s,i,1) > ' ') then
          t := t + copy(s,i,1);
     i := i + 1;
   end;
   rmspace := t;
end;

//입력된 숫자열에 콤마를 삽입하는 루틴
function  comma_format(value : string):string;
var
  str : array [1..100] of char;
  i,j,k,l,m,n: integer;
  coma_cnt : integer;
begin
  result := value;
  if value = '' then  exit;
  value := rmspace(value);
  l := length(value) ;
  m := l div 3;
  n := l mod 3;
  coma_cnt := 0;
  if (l > 3) and (m > 0) and (n > 0) then
      coma_cnt := m
  else if (l > 3) and (m > 0) and (n = 0)then    coma_cnt := m - 1;

  k := l + coma_cnt + 1;
  j := 0;
  for i := l  downto 1 do
  begin
    k := k - 1;
    j := j + 1;
    if j > 3 then
    begin
       str[k] := ',';
       k := k - 1;
       j := 1;
    end;
    str[k] := value[i];
  end;
  result := copy(str,1,l + coma_cnt);
end;

function GetAuctionResultCodeName(Code:string): string;
begin
  Result:= '';
  Code:= Trim(Code);
  if(Code = '11') then Result:= '대기';
  if(Code = '22') then Result:= '낙찰';
  if(Code = '23') then Result:= '보류';
end;

//------------------------------------------------------------------------------
// ### Date형식 구분자 Delete
// pStr: 입력 Date 문자열
//------------------------------------------------------------------------------
function cfDelDateGb(pStr: string): string;
var i      : integer;
    iLen   : integer;
    sTmpStr: string;
begin
  iLen := Length(pStr);

  for i := 1 to iLen do begin
    case pStr[i] of
      '-','/','.':;
      else sTmpStr := sTmpStr + pStr[i];
    end;
  end;

  result := sTmpStr;
end;

//------------------------------------------------------------------------------
// ### 날짜를 10자리 형식(yyyy.mm.dd)으로 표현하는 함수
// pDate: 입력 문자열(일자 문자열)
//------------------------------------------------------------------------------
function cfF10Date(pDate: string): string;
begin
  pDate := cfDelDateGb(pDate);                                                  //Date형식 구분자 Delete

  if Length(pDate) = 8 then
  begin
    if pDate <> '' then
         result := Copy(pDate,1,4)
                   +'-'
                   +Copy(pDate,5,2)
                   +'-'
                   +Copy(pDate,7,2)
    else result := pDate;
  end
end;

//------------------------------------------------------------------------------
// ### 레벨별 로그파일 작성
// pLogStr  : Log 내용 String
// pFileName: Log File Name
// pStdLevel: 기준 Level
// pLevel   : 사용 Level
//------------------------------------------------------------------------------
function fWriteLogFile(pLogStr,
                       pFileName: string;
                       pStdLevel,
                       pLevel   : shortint): Boolean;
begin
  try
    //가장상세로그(Low Level) 0 <- 1 <- 2<- 3 기본로그(High Level)
    if pLevel >= pStdLevel then
      pWriteFile(pLogStr, pFileName);                                           //파일작성

    result := True;
  except
    result := False;
  end;
end;

//------------------------------------------------------------------------------
// ### 입력한 경로명으로 해당 경로에 해당되는 모든 Directory 만들기
// pPath: 입력한 경로
//------------------------------------------------------------------------------
function cfMkDir(pPath: string): Boolean;
var i    : integer;
    sPath: string;
begin
  try
    result := False;

    for i := 1 to Length(pPath) do
    begin
      if pPath[i] = '\' then
      begin
           if not DirectoryExists(sPath) then
             Mkdir(sPath);
           sPath := sPath + pPath[i];
      end
      else sPath := sPath + pPath[i];
    end;

    result := True;
  except
  end;
end;

//------------------------------------------------------------------------------
// ### 폴더 및 파일 생성
// pPath    : 입력 로그폴더 경로
// pFileName: 입력 Log File Name
//------------------------------------------------------------------------------
function fCreateFile(pPath, pFileName: string): Boolean;
var F        : TextFile;
    sFileName: string;
begin
  try
    if not DirectoryExists(pPath) then
      cfMkDir(pPath);                                                           //입력한 경로명으로 해당 경로에 해당되는 모든 Directory 만들기

    sFileName := pPath+pFileName;

    if not FileExists(sFileName) then
    begin
         try
           AssignFile(F,sFileName);
           ReWrite(F);
           CloseFile(F);
           result  := True;
         except
           CloseFile(F);
           result  := False
         end;
    end
    else result := True;
  except
         result := False;
  end;
end;

//------------------------------------------------------------------------------
// ### 파일작성
// pLogStr  : File 내용 String
// pFileName: File Name
//------------------------------------------------------------------------------
procedure pWriteFile(pLogStr, pFileName: string);
var F: TextFile;
begin
  try
    AssignFile(F, pFileName);

    if FileExists(pFileName) then Append(F)
    else                          ReWrite(F);

    Writeln(F, pLogStr);
    CloseFile(F);
  except
  end;
end;

function cfNow: string;
begin
  result := FormatDateTime('yyyymmdd',Now);
end;

//------------------------------------------------------------------------------
// ### Log File Name 생성 및 레벨별 로그파일 작성(fWriteLogFile) Call
// pId : Application ID
// pIP : Cient IP
// pLvl: 사용 Level
// pMsg: Log 내용 String
//------------------------------------------------------------------------------
procedure FILE_LOG(pId: shortstring; pIP: shortstring; pLvl: integer; pMsg,  AucType : string);
var sFileName  : string;
    sPath      : string;
    sFileNmDate: shortstring;
begin
  sFileNmDate := cfF10Date(cfNow);                                                         //저장 파일명 일자 부분

  sPath       := _LOG_PATH_ + '경매일 ' + sFileNmDate+'\';
  If AucType = '1' then
    sFileName   := sFileNmDate + '송아지 경매진행로그.TXT'
  else If AucType = '2' then
    sFileName   := sFileNmDate + '비육우 경매진행로그.TXT'
  else If AucType = '3' then
    sFileName   := sFileNmDate + '번식우 경매진행로그.TXT';

  if _sLogOnOff = '1' then                                                      //Log 저장 여부(0:저장안함 1:저장)
  begin
    pMsg :=  pMsg ;
    if fCreateFile(sPath, sFileName) then                                    //로그폴더 및 파일 생성
        fWriteLogFile(pMsg, sPath+sFileName, _iLogLvl, pLvl);                   //레벨별 로그파일 작성
  end;
end;

{문자열을 좌우정렬하기위한함수}
function  str_format(str:string;strlen,left_right:integer):string;
var
  i,j,k : integer;
  s : string;
begin
  i := length(str);
  if i >= strlen then
  begin
    Result := copy(str,1,strlen);
    exit;
  end;
  j := strlen - i;
  s:='';
  for k := 1 to j do
      s := s + ' ';
  if left_right = 0 then
     s := str + s
  else
     s := s + str;
  Result := copy(s,1,length(s));
end;

Function LPad(iSize : Integer; sValue : String; sPadChar:String): String;
var
  i : Integer;
  sZero : String;
begin
  sZero := '';
  for I := 1 to (iSize - Length(sValue)) do
    sZero := sZero + sPadChar;
  sZero := sZero + sValue;
  Result := sZero;
end;

Function RPad(iSize : Integer; sValue : String; sPadChar:String): String;
var
  i : Integer;
  sZero : String;
begin
  sZero := '';
  for I := 1 to (iSize - Length(sValue)) do
    sZero := sZero + sPadChar;
  sZero :=  sValue + sZero;
  Result := sZero;
end;

//데이타항목들을 좌,우측으로정열, 공백을채운다.
function format_str_fill_Space(str:string;strlen,left_right:integer):string;
var
  i,j,k : integer;
  s : string;
begin
  i := length(str);
  if i >= strlen then
  begin
    Result := copy(str,1,strlen);
    exit;
  end;
  j := strlen - i;
  s:='';
  for k := 1 to j do
      s := s + ' ';
  if left_right = 1 then        //1:left  2  : right
     s := str + s
  else
     s := s + str;
  Result := copy(s,1,length(s));
end;

// 번지를 제외한 기본주소 반환
function GetBaseAddr(sRegion: string):string;
var
 // s: string;
  p: pchar;
  i: Integer;
begin
  Result:= '';
  sRegion:= Trim(sRegion);
  if Length(sRegion) = 0 then Exit;

  i:= 1;
  While Length(sRegion) >= i do
  begin
    if sRegion[i] in ['0'..'9', '-'] then
    begin
        // Remove Digit or '-'
        sRegion:= Copy(sRegion, 1, i-1) +
                  Copy(sRegion, i+1, Length(sRegion)-i);

        // 공백제거
        sRegion:= Trim(sRegion);
        i:= 1;
        Continue;
    end;

    Inc(I);
  end;

  if Length(sRegion) = 0 then Exit;

  P:= @sRegion[1];
//  I:= 0;
  while StrPos(p, ' ') <> nil do
  begin
//    Inc(I);
    P:= StrPos(p, ' ');
    Inc(P);
  end;

  if (Trim(StrPas(P)) = '산') or
     (Trim(StrPas(P)) = '번지') or
     (Trim(StrPas(P)) = '산번지') then
  begin
     sRegion:= Copy(sRegion, 1, p- (@sRegion[1]));
  end;

  if Copy(sRegion, Length(sRegion)-3, 4) = '번지' then
  begin
     sRegion:= Copy(sRegion, 1, Length(sRegion)-4);
  end;

  Result:= Trim(sRegion);
end;


function GetSanjiByRegion(sRegion: string):string;
var
//  s: string;
  p: pchar;
//  i: Integer;
begin
  Result:= '';

  // '산','번지','산번지', 및 숫자, - 제거
  sRegion:= GetBaseAddr(sRegion);
  if Length(sRegion) = 0 then Exit;

  // 경북 상주시 사벌면 덕담리 -> 덕담리
  P:= @sRegion[1];
//  I:= 0;
  while StrPos(p, ' ') <> nil do
  begin
//    Inc(I);
    P:= StrPos(p, ' ');
    Inc(P);
  end;

  Result:= Trim(StrPas(P));
end;





procedure ReadConfig;
var AIni : TIniFile;
begin
  AIni := TIniFile.Create( ExtractFilePath(ParamStr(0)) + Inifile);
  try
    AucConfig^.DispHost1     := AIni.ReadString('DISPLAY', 'DispHost1', '');            // 전광판
    AucConfig^.DispHostPort1 := AIni.ReadString('DISPLAY', 'DispHostPort1', '0');            // 전광판
    AucConfig^.PDPType       := AIni.ReadString('DISPLAY', 'PDPType', '0');             // PDP화면설정      1. 전광판화면   2. 경매진행화면

    AucConfig^.PDPHost1      := AIni.ReadString('DISPLAY', 'PDPHost1', '');             // PDP
    AucConfig^.PDPHostPort1  := AIni.ReadString('DISPLAY', 'PDPHostPort1', '0');             // PDP
    AucConfig^.PDPHost2      := AIni.ReadString('DISPLAY', 'PDPHost2', '');             // 응찰자석 PDP
    AucConfig^.PDPHostPort2  := AIni.ReadString('DISPLAY', 'PDPHostPort2', '0');             // PDP
    AucConfig^.DispFormat    := AIni.ReadString('DISPLAY', 'DispFormat', '1');           // 표출데이타 포멧


    AucConfig^.AucNo_Len         := AIni.ReadInteger('DISPLAY', 'AucNo', 3);            // 경매번호 자리수
    AucConfig^.FarmNo_Len        := AIni.ReadInteger('DISPLAY', 'FarmNo', 6);           // 출하주 자리수
    AucConfig^.Sex_Len           := AIni.ReadInteger('DISPLAY', 'Sex', 2);              // 성별 자리수
    AucConfig^.Weight_Len        := AIni.ReadInteger('DISPLAY', 'Weight', 3);           // 중량 자리수
    AucConfig^.Mother_Len        := AIni.ReadInteger('DISPLAY', 'Mother', 4);           // 어미구분 자리수

    AucConfig^.Geydae_Len           := AIni.ReadInteger('DISPLAY', 'Geydae', 2);              // 계대
    AucConfig^.Sancha_Len          := AIni.ReadInteger('DISPLAY', 'Sancha_Len', 2);           // 산차

    AucConfig^.Kpn_Len           := AIni.ReadInteger('DISPLAY', 'Kpn', 3);              // KPN 자리수
    AucConfig^.Area_Len          := AIni.ReadInteger('DISPLAY', 'Area', 4);             // 지역명 자리수
    AucConfig^.Bigo_Len          := AIni.ReadInteger('DISPLAY', 'Bigo', 12);            // 비고 자리수
    AucConfig^.MinAmt_Len        := AIni.ReadInteger('DISPLAY', 'MinAmt', 3);           // 최저가 자리수
    AucConfig^.MaxAmt_Len        := AIni.ReadInteger('DISPLAY', 'MaxAmt', 3);           // 낙찰가 자리수
    AucConfig^.AmnNo_Len         := AIni.ReadInteger('DISPLAY', 'AmnNo', 3);            // 낙찰자 자리수


    AucConfig^.PAucNo_Len         := AIni.ReadInteger('DISPLAY', 'PAucNo', 3);            // 경매번호 자리수
    AucConfig^.PFarmNo_Len        := AIni.ReadInteger('DISPLAY', 'PFarmNo', 6);           // 출하주 자리수
    AucConfig^.PSex_Len           := AIni.ReadInteger('DISPLAY', 'PSex', 2);              // 성별 자리수
    AucConfig^.PWeight_Len        := AIni.ReadInteger('DISPLAY', 'PWeight', 3);           // 중량 자리수
    AucConfig^.PMother_Len        := AIni.ReadInteger('DISPLAY', 'PMother', 4);           // 어미구분 자리수

    AucConfig^.PGeydae_Len           := AIni.ReadInteger('DISPLAY', 'PGeydae', 2);              // 계대
    AucConfig^.PSancha_Len          := AIni.ReadInteger('DISPLAY', 'PSancha_Len', 2);           // 산차

    AucConfig^.PKpn_Len           := AIni.ReadInteger('DISPLAY', 'PKpn', 3);              // KPN 자리수
    AucConfig^.PArea_Len          := AIni.ReadInteger('DISPLAY', 'PArea', 4);             // 지역명 자리수
    AucConfig^.PBigo_Len          := AIni.ReadInteger('DISPLAY', 'PBigo', 12);            // 비고 자리수
    AucConfig^.PMinAmt_Len        := AIni.ReadInteger('DISPLAY', 'PMinAmt', 3);           // 최저가 자리수
    AucConfig^.PMaxAmt_Len        := AIni.ReadInteger('DISPLAY', 'PMaxAmt', 3);           // 낙찰가 자리수
    AucConfig^.PAmnNo_Len         := AIni.ReadInteger('DISPLAY', 'PAmnNo', 6);            // 낙찰자 자리수





    AucConfig^.TerminalYn    := AIni.ReadString('TERMINAL', 'TerminalYn', '1');         // 응찰기 사용여부     1.사용  2.미사용
    AucConfig^.AucBaseUnit   := AIni.ReadString('TERMINAL', 'AucBaseUnit', '');         // 경매기본단위
    AucConfig^.DataFormat    := AIni.ReadString('TERMINAL', 'DataFormat', '1');         // 데이타 포맷
    AucConfig^.SerialPort    := AIni.ReadString('TERMINAL', 'SerialPort', 'Com1');      // 통신포트
    AucConfig^.SerialSpeed   := AIni.ReadString('TERMINAL', 'SerialSpeed', '115200');     // 통신 속도
    AucConfig^.LowNo         := AIni.ReadString('TERMINAL', 'LowNo', '1');                           //법인번호
    AucConfig^.TablelNo      := AIni.ReadString('TERMINAL', 'TablelNo', '1');                            //경매대 번호
    AucConfig^.TerminalGubun := AIni.ReadString('TERMINAL', 'TerminalGubun', '1');      // 응찰기 신형/구형  1 : 구형,   2 : 신형


    AucConfig^.Voice         := AIni.ReadString('AUCTION_PROC', 'Voice', '0');          //음성 설정
    AucConfig^.ReAucCnt      := AIni.ReadString('AUCTION_PROC', 'ReAucCnt', '3');        //재경매 횟수
    AucConfig^.NotBidVoice   := AIni.ReadString('AUCTION_PROC', 'NotBidVoice', '0');    // 유찰경매 음성 선택 (1:멘트함 0:안함)

    AucConfig^.VoiceType     := AIni.ReadString('VOICE_AUCTION', 'VoiceType', '0');     // 목소리 선택
    AucConfig^.AucLimitSec   := AIni.ReadString('VOICE_AUCTION', 'AucLimitSec', '30');  // 1건 경매제한시간 default: 30초
    AucConfig^.FinalSec      := AIni.ReadString('VOICE_AUCTION', 'FinalSec', '3');      // 초사인  3, 5 초
    AucConfig^.VoiceSpeed    := AIni.ReadString('VOICE_AUCTION', 'VoiceSpeed', '110');  // 음성 속도
    AucConfig^.VoicePitch    := AIni.ReadString('VOICE_AUCTION', 'VoicePitch', '100');  // 목소리 톤
    AucConfig^.VoiceYn       := AIni.ReadString('VOICE_AUCTION', 'VoiceYn', 'N');  // 음성경매여부

 {
    AucConfig^.cMaxAmt       := AIni.ReadString('AUCTION_LIMIT', 'cMaxAmt', '');        // 송아지 한도
    AucConfig^.nMaxamt       := AIni.ReadString('AUCTION_LIMIT', 'nMaxamt', '');        // 번식우 한도
    AucConfig^.bMaxamt       := AIni.ReadString('AUCTION_LIMIT', 'bMaxamt', '');        // 비육우 한도
 }
  finally
    FreeAndNil(AIni);
  end;
end;


end.
 