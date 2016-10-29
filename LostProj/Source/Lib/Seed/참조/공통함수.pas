unit LALMCommon;

interface

Uses  SysUtils, Classes, IniFiles, Messages, StdCtrls, Dialogs;

type
  TAucInfo =  Packed record
    AucDate         :  String;   // �����
    AucType         :  String;   // ��Ŵ��       1.�۾���  2.������   3.���Ŀ�
    NaBzplc         :  String;   // �������ջ�����ڵ�
    NaBzplcNm       :  String;   // �������ջ�����
    CurOslpNo       :  String;   // ���õ� ��ǥ��ȣ
    AmtUnit         :  Integer;  // ��������ݾ� ����
    AucNo           :  String;   // ���õ� ��Ź�ȣ
    BcowType        :  String;   // ������ ��Ŵ��� (Kg / �δ�)
    BcowTrunc       :  String;   // ������ �������
    BcowTruncAmt    :  Real;   // ������ ����ݾ״���
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
    DispHost1         : String;  // ������                                    Display_Host
    DispHostPort1     : String;  // ������                                    Display_Host  port
    PDPType           : String;  // PDPȭ�鼳��
    PDPHost1          : String;  // PDP                                       Display_Host1
    PDPHostPort1      : String;  // PDP                                       Display_Host1 port
    PDPHost2          : String;  // �����ڼ� PDP                              Display_Host2
    PDPHostPort2      : String;  // PDP                                       Display_Host2 port
    DispFormat        : String;  // ǥ�ⵥ��Ÿ ����                           Display_format

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

    TerminalYn        : String;  //������ ��뿩��                            Terminal
    AucBaseUnit       : String;  // ��ű⺻����                              Add_zero
    DataFormat        : String;  // ����Ÿ ����                               Com_Format
    SerialPort        : String;  // �����Ʈ                                  Com_Port
    SerialSpeed       : String;  // ��� �ӵ�                                 Com_Speed
    LowNo             : string;  //���ι�ȣ                                   Low_No
    TablelNo          : string;  //��Ŵ� ��ȣ                                Tag_No
    TerminalGubun     : string;  // ������ ����/����  0 : ����,   1 : ����

    Voice             : string;  //���� ����                                  Select_chk
    ReAucCnt          : string;  //���� Ƚ��                                ReAuct_cnt
    NotBidVoice       : string;  // ������� ���� ���� (1:��Ʈ�� 0:����)      chk_result_gubun

    VoiceType         : string;   // ��Ҹ� ����                              Voice_Speaker
    AucLimitSec       : string;   // 1�� ������ѽð� default: 30��           Limit_Sec
    FinalSec          : string;   // �ʻ���  3, 5 ��                          Final_Sec
    VoiceSpeed        : string;   // ���� �ӵ�                                Voice_Speed
    VoicePitch        : string;   //  ��Ҹ� ��                               Voice_Pitch
    VoiceYn           : string;   //  ������ſ���
{
    cMaxAmt           : string;   // �۾��� �ѵ�                              cMax_amt
    nMaxamt           : string;   // ���Ŀ� �ѵ�                              nMax_amt
    bMaxamt           : string;   // ������ �ѵ�                              bMax_amt
}
    MaxAmt            : String;   // �����ѵ�.

    FAutotRunning     : Boolean;
    PTTS_ChangeAttr   : array[0..255] of char;
  end;
  PAucConfig = ^TAucConfig;

  type
  TPDPDisp =  Packed record
    AucNo          :  String; // ��Ź�ȣ
    FarmNm         :  String; // ������
    Sex            :  String; // ����
    Weight         :  String; // �߷�
    ReservAmt      :  String; // ������
    BidAmt         :  String; // ������
    Bidder         :  String; // ������
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

    Query_Flag    :integer; //�����÷���
    count_flag    :boolean;

    AucInfo   : PAucInfo;
    AucConfig : PAucConfig;
    VoiceInfo : PVoiceInfo;


    // �α����� ����
    Next_pointer      : integer;
    _sLogOnOff        : shortstring;
    _iLogLvl          : integer;                                              //Log ��� Level
    _sAppId           : string;                                               //���� ��⿡�� Application�� Ư��ó���� ���� Application ID

Const Inifile = 'LALMConfig.Ini';
      _LOG_PATH_        = '.\log\';                                            //Log file ��� ���
//      PDPInifile = 'PDPConfig.Ini';
      start_wav  = '.\edasstart.wav';
      Cnt_wav    = '.\ding.wav';
      end_wav    = '.\edasend.wav';

      STX = #2;
      ETX = #3;
      ing_row       = 1;  //����ȭ��迭��ũ��
      complite_row  = 4;  //�Ϸ�ȭ��迭��ũ��
      Wait_Row      = 10; //���ȭ��迭��ũ��
      AAcomplite    = 1;  //�Ϸ����   //
      AAing         = 2;  //�������   //
      AAwait        = 3;  //������   //

      WM_USER_100   = WM_USER + 100;

     //�迭����
      Csheetno     =  0;// ����
      Csangi       =  1;// ����
      Cchulhaju    =  2;// ������
      Csex         =  3;// �ϼ�����
      Cbloodline   =  4;// ����
      CSancha      =  5;// ����
      Cage         =  6;// ���
      CKpn         =  7;// �ƺ� KPN
      Cweight      =  8;// �߷�
      Cplanprice   =  9;// ������
      Cprice       =  10;//������                            1
      Cbroker      =  11;//������
      Cresult      =  12;//���
      Cmemo        =  13;//�޸�
      Cbar_code    =  14;//���ڵ�
      COslpno      =  15;// ��ǥ��ȣ
      CMacoYn      =  16;// ���տ�����
      CPrnyJugYn   =  17;// �ӽŰ�������
      CNcssJugYn   =  18;// ���簨������
      CPPGCOW      =  19;
      CRmhnYn      =  20;//��������
      CTransYn     =  21;//��ۺ����޿���

      count_col     = 22; //�迭���÷���
      Cbroker_cnt  = 20; //�ߵ����� �ݾ�ǥ�� Count

procedure ReadConfig;
function GetBaseAddr(sRegion: string):string;
function GetSanjiByRegion(sRegion: string):string;
function format_str_fill_Space(str:string;strlen,left_right:integer):string;
Function LPad(iSize : Integer; sValue : String; sPadChar:String): String;
Function RPad(iSize : Integer; sValue : String; sPadChar:String): String;
function str_format(str:string;strlen,left_right:integer):string;
procedure FILE_LOG      (pId          : shortstring;                            //Log File Name ���� �� ������ �α����� �ۼ�(fWriteLogFile) Call
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
function  cfDelDateGb (pStr  : string)     : string;                 //Date���� ������ Delete
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

//�Էµ� ���ڿ��� �޸��� �����ϴ� ��ƾ
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
  if(Code = '11') then Result:= '���';
  if(Code = '22') then Result:= '����';
  if(Code = '23') then Result:= '����';
end;

//------------------------------------------------------------------------------
// ### Date���� ������ Delete
// pStr: �Է� Date ���ڿ�
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
// ### ��¥�� 10�ڸ� ����(yyyy.mm.dd)���� ǥ���ϴ� �Լ�
// pDate: �Է� ���ڿ�(���� ���ڿ�)
//------------------------------------------------------------------------------
function cfF10Date(pDate: string): string;
begin
  pDate := cfDelDateGb(pDate);                                                  //Date���� ������ Delete

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
// ### ������ �α����� �ۼ�
// pLogStr  : Log ���� String
// pFileName: Log File Name
// pStdLevel: ���� Level
// pLevel   : ��� Level
//------------------------------------------------------------------------------
function fWriteLogFile(pLogStr,
                       pFileName: string;
                       pStdLevel,
                       pLevel   : shortint): Boolean;
begin
  try
    //����󼼷α�(Low Level) 0 <- 1 <- 2<- 3 �⺻�α�(High Level)
    if pLevel >= pStdLevel then
      pWriteFile(pLogStr, pFileName);                                           //�����ۼ�

    result := True;
  except
    result := False;
  end;
end;

//------------------------------------------------------------------------------
// ### �Է��� ��θ����� �ش� ��ο� �ش�Ǵ� ��� Directory �����
// pPath: �Է��� ���
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
// ### ���� �� ���� ����
// pPath    : �Է� �α����� ���
// pFileName: �Է� Log File Name
//------------------------------------------------------------------------------
function fCreateFile(pPath, pFileName: string): Boolean;
var F        : TextFile;
    sFileName: string;
begin
  try
    if not DirectoryExists(pPath) then
      cfMkDir(pPath);                                                           //�Է��� ��θ����� �ش� ��ο� �ش�Ǵ� ��� Directory �����

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
// ### �����ۼ�
// pLogStr  : File ���� String
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
// ### Log File Name ���� �� ������ �α����� �ۼ�(fWriteLogFile) Call
// pId : Application ID
// pIP : Cient IP
// pLvl: ��� Level
// pMsg: Log ���� String
//------------------------------------------------------------------------------
procedure FILE_LOG(pId: shortstring; pIP: shortstring; pLvl: integer; pMsg,  AucType : string);
var sFileName  : string;
    sPath      : string;
    sFileNmDate: shortstring;
begin
  sFileNmDate := cfF10Date(cfNow);                                                         //���� ���ϸ� ���� �κ�

  sPath       := _LOG_PATH_ + '����� ' + sFileNmDate+'\';
  If AucType = '1' then
    sFileName   := sFileNmDate + '�۾��� �������α�.TXT'
  else If AucType = '2' then
    sFileName   := sFileNmDate + '������ �������α�.TXT'
  else If AucType = '3' then
    sFileName   := sFileNmDate + '���Ŀ� �������α�.TXT';

  if _sLogOnOff = '1' then                                                      //Log ���� ����(0:������� 1:����)
  begin
    pMsg :=  pMsg ;
    if fCreateFile(sPath, sFileName) then                                    //�α����� �� ���� ����
        fWriteLogFile(pMsg, sPath+sFileName, _iLogLvl, pLvl);                   //������ �α����� �ۼ�
  end;
end;

{���ڿ��� �¿������ϱ������Լ�}
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

//����Ÿ�׸���� ��,������������, ������ä���.
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

// ������ ������ �⺻�ּ� ��ȯ
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

        // ��������
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

  if (Trim(StrPas(P)) = '��') or
     (Trim(StrPas(P)) = '����') or
     (Trim(StrPas(P)) = '�����') then
  begin
     sRegion:= Copy(sRegion, 1, p- (@sRegion[1]));
  end;

  if Copy(sRegion, Length(sRegion)-3, 4) = '����' then
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

  // '��','����','�����', �� ����, - ����
  sRegion:= GetBaseAddr(sRegion);
  if Length(sRegion) = 0 then Exit;

  // ��� ���ֽ� ����� ���㸮 -> ���㸮
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
    AucConfig^.DispHost1     := AIni.ReadString('DISPLAY', 'DispHost1', '');            // ������
    AucConfig^.DispHostPort1 := AIni.ReadString('DISPLAY', 'DispHostPort1', '0');            // ������
    AucConfig^.PDPType       := AIni.ReadString('DISPLAY', 'PDPType', '0');             // PDPȭ�鼳��      1. ������ȭ��   2. �������ȭ��

    AucConfig^.PDPHost1      := AIni.ReadString('DISPLAY', 'PDPHost1', '');             // PDP
    AucConfig^.PDPHostPort1  := AIni.ReadString('DISPLAY', 'PDPHostPort1', '0');             // PDP
    AucConfig^.PDPHost2      := AIni.ReadString('DISPLAY', 'PDPHost2', '');             // �����ڼ� PDP
    AucConfig^.PDPHostPort2  := AIni.ReadString('DISPLAY', 'PDPHostPort2', '0');             // PDP
    AucConfig^.DispFormat    := AIni.ReadString('DISPLAY', 'DispFormat', '1');           // ǥ�ⵥ��Ÿ ����


    AucConfig^.AucNo_Len         := AIni.ReadInteger('DISPLAY', 'AucNo', 3);            // ��Ź�ȣ �ڸ���
    AucConfig^.FarmNo_Len        := AIni.ReadInteger('DISPLAY', 'FarmNo', 6);           // ������ �ڸ���
    AucConfig^.Sex_Len           := AIni.ReadInteger('DISPLAY', 'Sex', 2);              // ���� �ڸ���
    AucConfig^.Weight_Len        := AIni.ReadInteger('DISPLAY', 'Weight', 3);           // �߷� �ڸ���
    AucConfig^.Mother_Len        := AIni.ReadInteger('DISPLAY', 'Mother', 4);           // ��̱��� �ڸ���

    AucConfig^.Geydae_Len           := AIni.ReadInteger('DISPLAY', 'Geydae', 2);              // ���
    AucConfig^.Sancha_Len          := AIni.ReadInteger('DISPLAY', 'Sancha_Len', 2);           // ����

    AucConfig^.Kpn_Len           := AIni.ReadInteger('DISPLAY', 'Kpn', 3);              // KPN �ڸ���
    AucConfig^.Area_Len          := AIni.ReadInteger('DISPLAY', 'Area', 4);             // ������ �ڸ���
    AucConfig^.Bigo_Len          := AIni.ReadInteger('DISPLAY', 'Bigo', 12);            // ��� �ڸ���
    AucConfig^.MinAmt_Len        := AIni.ReadInteger('DISPLAY', 'MinAmt', 3);           // ������ �ڸ���
    AucConfig^.MaxAmt_Len        := AIni.ReadInteger('DISPLAY', 'MaxAmt', 3);           // ������ �ڸ���
    AucConfig^.AmnNo_Len         := AIni.ReadInteger('DISPLAY', 'AmnNo', 3);            // ������ �ڸ���


    AucConfig^.PAucNo_Len         := AIni.ReadInteger('DISPLAY', 'PAucNo', 3);            // ��Ź�ȣ �ڸ���
    AucConfig^.PFarmNo_Len        := AIni.ReadInteger('DISPLAY', 'PFarmNo', 6);           // ������ �ڸ���
    AucConfig^.PSex_Len           := AIni.ReadInteger('DISPLAY', 'PSex', 2);              // ���� �ڸ���
    AucConfig^.PWeight_Len        := AIni.ReadInteger('DISPLAY', 'PWeight', 3);           // �߷� �ڸ���
    AucConfig^.PMother_Len        := AIni.ReadInteger('DISPLAY', 'PMother', 4);           // ��̱��� �ڸ���

    AucConfig^.PGeydae_Len           := AIni.ReadInteger('DISPLAY', 'PGeydae', 2);              // ���
    AucConfig^.PSancha_Len          := AIni.ReadInteger('DISPLAY', 'PSancha_Len', 2);           // ����

    AucConfig^.PKpn_Len           := AIni.ReadInteger('DISPLAY', 'PKpn', 3);              // KPN �ڸ���
    AucConfig^.PArea_Len          := AIni.ReadInteger('DISPLAY', 'PArea', 4);             // ������ �ڸ���
    AucConfig^.PBigo_Len          := AIni.ReadInteger('DISPLAY', 'PBigo', 12);            // ��� �ڸ���
    AucConfig^.PMinAmt_Len        := AIni.ReadInteger('DISPLAY', 'PMinAmt', 3);           // ������ �ڸ���
    AucConfig^.PMaxAmt_Len        := AIni.ReadInteger('DISPLAY', 'PMaxAmt', 3);           // ������ �ڸ���
    AucConfig^.PAmnNo_Len         := AIni.ReadInteger('DISPLAY', 'PAmnNo', 6);            // ������ �ڸ���





    AucConfig^.TerminalYn    := AIni.ReadString('TERMINAL', 'TerminalYn', '1');         // ������ ��뿩��     1.���  2.�̻��
    AucConfig^.AucBaseUnit   := AIni.ReadString('TERMINAL', 'AucBaseUnit', '');         // ��ű⺻����
    AucConfig^.DataFormat    := AIni.ReadString('TERMINAL', 'DataFormat', '1');         // ����Ÿ ����
    AucConfig^.SerialPort    := AIni.ReadString('TERMINAL', 'SerialPort', 'Com1');      // �����Ʈ
    AucConfig^.SerialSpeed   := AIni.ReadString('TERMINAL', 'SerialSpeed', '115200');     // ��� �ӵ�
    AucConfig^.LowNo         := AIni.ReadString('TERMINAL', 'LowNo', '1');                           //���ι�ȣ
    AucConfig^.TablelNo      := AIni.ReadString('TERMINAL', 'TablelNo', '1');                            //��Ŵ� ��ȣ
    AucConfig^.TerminalGubun := AIni.ReadString('TERMINAL', 'TerminalGubun', '1');      // ������ ����/����  1 : ����,   2 : ����


    AucConfig^.Voice         := AIni.ReadString('AUCTION_PROC', 'Voice', '0');          //���� ����
    AucConfig^.ReAucCnt      := AIni.ReadString('AUCTION_PROC', 'ReAucCnt', '3');        //���� Ƚ��
    AucConfig^.NotBidVoice   := AIni.ReadString('AUCTION_PROC', 'NotBidVoice', '0');    // ������� ���� ���� (1:��Ʈ�� 0:����)

    AucConfig^.VoiceType     := AIni.ReadString('VOICE_AUCTION', 'VoiceType', '0');     // ��Ҹ� ����
    AucConfig^.AucLimitSec   := AIni.ReadString('VOICE_AUCTION', 'AucLimitSec', '30');  // 1�� ������ѽð� default: 30��
    AucConfig^.FinalSec      := AIni.ReadString('VOICE_AUCTION', 'FinalSec', '3');      // �ʻ���  3, 5 ��
    AucConfig^.VoiceSpeed    := AIni.ReadString('VOICE_AUCTION', 'VoiceSpeed', '110');  // ���� �ӵ�
    AucConfig^.VoicePitch    := AIni.ReadString('VOICE_AUCTION', 'VoicePitch', '100');  // ��Ҹ� ��
    AucConfig^.VoiceYn       := AIni.ReadString('VOICE_AUCTION', 'VoiceYn', 'N');  // ������ſ���

 {
    AucConfig^.cMaxAmt       := AIni.ReadString('AUCTION_LIMIT', 'cMaxAmt', '');        // �۾��� �ѵ�
    AucConfig^.nMaxamt       := AIni.ReadString('AUCTION_LIMIT', 'nMaxamt', '');        // ���Ŀ� �ѵ�
    AucConfig^.bMaxamt       := AIni.ReadString('AUCTION_LIMIT', 'bMaxamt', '');        // ������ �ѵ�
 }
  finally
    FreeAndNil(AIni);
  end;
end;


end.
 