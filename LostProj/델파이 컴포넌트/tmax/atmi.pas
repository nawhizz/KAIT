unit Atmi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const
	TmaxDLL = 'TMAX.DLL';

{ Flags to tpinit() for Tuxedo compatability }
	TPU_MASK	= $00000007;
	TPU_SIG		= $00000001;
	TPU_DIP		= $00000002;
	TPU_IGN		= $00000004;
	TPSA_FASTPATH	= $00000008;
	TPSA_PROTECTED	= $00000010;

{ ---------- flags from API ----- }
	TPNOBLOCK	= $00000001;
	TPSIGRSTRT  = $00000002;
	TPNOREPLY	= $00000004;
	TPNOTRAN	= $00000008;
	TPTRAN		= $00000010;
	TPNOTIME	= $00000020;
	TPNOGETANY	= $00000040;
	TPGETANY	= $00000080;
	TPNOCHANGE	= $00000100;
	TPBLOCK	        = $00000200;
	TPCONV		= $00000400;
	TPSENDONLY	= $00000800;
	TPRECVONLY	= $00001000;
	TPUDP           = $00002000;
	TPRQS		= $00004000;

{ --- flags used in tpstart() --- }
	TPUNSOL_MASK = $00000007;
	TPUNSOL_HND  = $00000001;
	TPUNSOL_I    = $00000002;
	TPUNSOL_POLL = $00000004;
	TPUNIQUE	= $00000010;
	TPONLYONE	= $00000020;

	TPFAIL		= $0001;
	TPSUCCESS	= $0002;
	TPEXIT	        = $0004;

{ ------ flags for reply type check ----- }
	TPREQ           =  0;
	TPERR           = -1;

{ Flags to tpscmt() - Valid TP_COMMIT_CONTROL characteristic values }
	TP_CMT_LOGGED	= $01;	{* return after commit decision is logged }
	TP_CMT_COMPLETE	= $02;	{ return after commit has completed }

{ Return values to tpchkauth() }
	TPNOAUTH	= 0;	{ no authentication }
	TPSYSAUTH	= 1;	{ system authentication }
	TPAPPAUTH	= 2;	{ system and application authentication }

{ unsolicited msg type }
	TPPOSTMSG       = 1;
	TPBROADCASTMSG  = 2;
	TPNOTIFY        = 3;
	TPSENDTOCLI     = 4;

{ client logout type }
	CLIENT_CLOSE_NORMAL	= 0;
	CLIENT_CLOSE_ABNORMAL	= 1;
	CLIENT_PRUNED		= 2;

	XATMI_SERVICE_NAME_LENGTH = 16;	{ where x must be > 15 }
        MAXTIDENT = XATMI_SERVICE_NAME_LENGTH;
        MAX_PASSWD_LENGTH = 16;

	TPEBADDESC	= 2 ;
	TPEBLOCK	= 3 ;
	TPEINVAL	= 4 ;
	TPELIMIT	= 5 ;
	TPENOENT	= 6 ;
	TPEOS	        = 7 ;
	TPEPROTO	= 9 ;
	TPESVCERR	= 10;
	TPESVCFAIL	= 11;
	TPESYSTEM	= 12;
	TPETIME		= 13;
	TPETRAN		= 14;
	TPGOTSIG	= 15;
	TPEITYPE	= 17;
	TPEOTYPE	= 18;
	TPEEVENT	= 22;
	TPEMATCH	= 23;
	TPENOREADY	= 24;
	TPESECURITY	= 25;
	TPEQFULL	= 26;
	TPEQPURGE	= 27;
	TPECLOSE	= 28;
	TPESVRDOWN	= 29;
	TPEPRESVC	= 30;
	TPEMAXNO	= 31;

{ ---- flags used in conv[]: don't use dummy flags ----}
	TPEV_DISCONIMM	= $00000001;
	TPEV_SVCERR	= $00000002;
	TPEV_SVCFAIL	= $00000004;
	TPEV_SVCSUCC	= $00000008;
	TPEV_SENDONLY	= $00000020;
	TPCONV_DUMMY1	= $00000800;  { don't use this flag: TPSENDONLY }
	TPCONV_DUMMY2	= $00001000;  { don't use this flag: TPRECVONLY }
	TPCONV_OUT	= $00010000;
	TPCONV_IN	= $00020000;

	X_OCTET		= 'X_OCTET';
	X_C_TYPE	= 'X_C_TYPE';
	X_COMMON	= 'X_COMMON';

	TMTYPEFAIL	= -1;
	TMTYPESUCC      = 0 ;

        TMQNAMELEN      = 15;
        TMMSGIDLEN      = 32;
        TMCORRIDLEN     = 32;

        TPUNSOLERR = TFarProc(-1);
type
    atmi_h = class(TComponent)
    public
        constructor Create(AOwner: TComponent); override;
    end;

    { tpstart/tpinit interface structure }
    tpstart_t = record
	     usrname: array[0..MAXTIDENT + 1] of char;	{ client user name }
	     cltname: array[0..MAXTIDENT + 1] of char;	{ application client name }
	     dompwd:  array[0..MAX_PASSWD_LENGTH + 1] of char;	{ application password }
	     usrpwd: array[0..MAX_PASSWD_LENGTH + 1] of char;	{ client group name }
	     flags:   LongInt;		                { initialization flags }
     end;
     pTPSTART = ^tpstart_t;

     { client identifier structure }
     clientid_t = record
	        clientdata: array[0..3] of LongInt;	{ reserved for internal use }
     end;
     pCLIENTID = ^clientid_t;

     tpqctl_t = record		                          { control parameters to queue primitives }
	      flags: LongInt;		                  { indicates which of the values are set }
	      deq_time: LongInt;		          { absolute/relative  time for dequeuing }
	      priority: LongInt;		          { enqueue priority }
	      diagnostic: LongInt;	                  { indicates reason for failure }
	      msgid: array[0..TMMSGIDLEN-1] of char;	  { id of message before which to queue }
	      corrid: array[0..TMCORRIDLEN-1] of char;    { correlation id used to identify message }
	      replyqueue: array[0..TMQNAMELEN] of char;	  { queue name for reply message }
	      failurequeue: array[0..TMQNAMELEN] of char; { queue name for failure message }
	      cltid: clientid_t;		                  { client identifier for originating client }
	      urcode: LongInt;		                  { application user-return code }
	      appkey: LongInt;		                  { application authentication client key }
     end;
     pTPQCTL = ^tpqctl_t;

     { Subscription Control structure }
     tpevctl_t = record
	       flags: LongInt;
	       name1: array[0..XATMI_SERVICE_NAME_LENGTH-1] of char;
	       name2: array[0..XATMI_SERVICE_NAME_LENGTH-1] of char;
	       qctl: tpqctl_t;
     end;
     pTPEVCTL = ^tpevctl_t;

     pLongInt = ^LongInt;
     pInteger = ^Integer;

{ ----- client API ----- }
Function gettperrno:Integer; cdecl; far;
Function gettpurcode:LongInt; cdecl; far;

Function tpalloc(a:PChar; b:PChar; c:LongInt):Pointer; cdecl; far;
Function tprealloc(a:Pointer; b:LongInt):Pointer; cdecl; far;
Procedure tpfree(a:Pointer); cdecl; far;

Function tpstart(a:pTPSTART):Integer; cdecl; far;
Function tpend:Integer; cdecl; far;
Function tpcall(a:PChar; b:Pointer; c:LongInt; d:Pointer; e:pLongInt; f:LongInt):Integer; cdecl; far;
Function tpacall(a:PChar; b:Pointer; c:LongInt; d:LongInt):Integer; cdecl; far;
Function tpgetrply(a:pInteger; b:Pointer; c:pLongInt; d:LongInt):Integer; cdecl; far;
Function tpcancel(a:Integer):Integer; cdecl; far;

{ ----- conversation API ----- }
Function tpsend(a:Integer; b:Pointer; c:LongInt; d:LongInt; e:pLongInt):Integer; cdecl; far;
Function tprecv(a:Integer; b:Pointer; c:pLongInt; d:LongInt; e:pLongInt):Integer; cdecl; far;
Function tpconnect(a:PChar; b:Pointer; c:LongInt; d:LongInt):Integer; cdecl; far;
Function tpdiscon(a:Integer):Integer; cdecl; far;

{ ----- environment setting API ----- }
Function tpgetenv(a:PChar):PChar; cdecl; far;
Function tpputenv(a:PChar):Integer; cdecl; far;
Function tmaxreadenv(a:PChar; b:PChar):Integer; cdecl; far;

{ ----- RQ(Reliable Queue) API ----- }
Function tpenq(a:PChar; b:PChar; c:Pointer; d:LongInt; e:LongInt):Integer; cdecl; far;
Function tpdeq(a:PChar; b:PChar; c:Pointer; d:pLongInt; e:LongInt):Integer; cdecl; far

{ ----- transaction API ----- }
Function tx_begin:Integer; cdecl; far;
Function tx_commit:Integer; cdecl; far;
Function tx_rollback:Integer; cdecl; far;
Function tx_set_transaction_timeout(a:Integer):Integer; cdecl; far;

{ ----- messaging API ----- }
Function tppost(a:PChar; b:Pointer; c:LongInt; d:LongInt):Integer; cdecl; far;
Function tpbroadcast(a:PChar; b:PChar; c:PChar; d:Pointer; e:LongInt; f:LongInt):Integer; cdecl; far;
Function tpsetunsol(a:TFarProc):TFarProc; cdecl; far;
Function tpgetunsol(a:Integer; b:Pointer; c:pLongInt; d:LongInt):Integer; cdecl; far;
Function tpsetunsol_flag(a:Integer):Integer; cdecl; far;
Function tpstrerror(a:Integer):PChar; cdecl; far;
Function tpsubscribe(a:PChar; b:PChar; c:pTPEVCTL; d:LongInt):LongInt; cdecl; far;
//Function tp_sleep(a:LongInt):LongInt; cdecl; far;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tmax3.0', [atmi_h]);
end;

constructor atmi_h.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{ ----- client API ----- }
Function gettperrno:Integer; cdecl; external TmaxDLL;
Function gettpurcode:LongInt; cdecl; external TmaxDLL;

Function tpalloc(a:PChar; b:PChar; c:LongInt):Pointer; cdecl; external TmaxDLL;
Function tprealloc(a:Pointer; b:LongInt):Pointer; cdecl; external TmaxDLL;
Procedure tpfree(a:Pointer); cdecl; external TmaxDLL;

Function tpstart(a:pTPSTART):Integer; cdecl; external TmaxDLL;
Function tpend:Integer; cdecl; external TmaxDLL;
Function tpcall(a:PChar; b:Pointer; c:LongInt; d:Pointer; e:pLongInt; f:LongInt):Integer; cdecl; external TmaxDLL;
Function tpacall(a:PChar; b:Pointer; c:LongInt; d:LongInt):Integer; cdecl; external TmaxDLL;
Function tpgetrply(a:pInteger; b:Pointer; c:pLongInt; d:LongInt):Integer; cdecl; external TmaxDLL;
Function tpcancel(a:Integer):Integer; cdecl; external TmaxDLL;

{ ----- conversations API ----- }
Function tpsend(a:Integer; b:Pointer; c:LongInt; d:LongInt; e:pLongInt):Integer; cdecl; external TmaxDLL;
Function tprecv(a:Integer; b:Pointer; c:pLongInt; d:LongInt; e:pLongInt):Integer; cdecl; external TmaxDLL;
Function tpconnect(a:PChar; b:Pointer; c:LongInt; d:LongInt):Integer; cdecl; external TmaxDLL;
Function tpdiscon(a:Integer):Integer; cdecl; external TmaxDLL;

{ ----- environment setting API ----- }
Function tpgetenv(a:PChar):PChar; cdecl; external TmaxDLL;
Function tpputenv(a:PChar):Integer; cdecl; external TmaxDLL;
Function tmaxreadenv(a:PChar; b:PChar):Integer; cdecl; external TmaxDLL;

{ ----- RQ(Reliable Queue) API ----- }
Function tpenq(a:PChar; b:PChar; c:Pointer; d:LongInt; e:LongInt):Integer; cdecl; external TmaxDLL;
Function tpdeq(a:PChar; b:PChar; c:Pointer; d:pLongInt; e:LongInt):Integer; cdecl; external TmaxDLL

{ ----- transaction API ----- }
Function tx_begin:Integer; cdecl; external TmaxDLL;
Function tx_commit:Integer; cdecl; external TmaxDLL;
Function tx_rollback:Integer; cdecl; external TmaxDLL;
Function tx_set_transaction_timeout(a:Integer):Integer; cdecl; external TmaxDLL;

{ ----- messaging API ----- }
Function tppost(a:PChar; b:Pointer; c:LongInt; d:LongInt):Integer; cdecl; external TmaxDLL;
Function tpbroadcast(a:PChar; b:PChar; c:PChar; d:Pointer; e:LongInt; f:LongInt):Integer; cdecl; external TmaxDLL;
Function tpsetunsol(a:TFarProc):TFarProc; cdecl; external TmaxDLL;
Function tpgetunsol(a:Integer; b:Pointer; c:pLongInt; d:LongInt):Integer; cdecl; external TmaxDLL;
Function tpsetunsol_flag(a:Integer):Integer; cdecl; external TmaxDLL;
Function tpstrerror(a:Integer):PChar; cdecl; external TmaxDLL;
Function tpsubscribe(a:PChar; b:PChar; c:pTPEVCTL; d:LongInt):LongInt; cdecl; external TmaxDLL;
Function tpunsubscribe(a:LongInt; b:LongInt):Integer; cdecl; external TmaxDLL;

end.
