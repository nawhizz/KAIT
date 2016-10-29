// client Application 간의 Windows Messaging을 위한 상수 선언 모듈

unit cpakmsg;

interface

uses
	Messages;

const
	LINKSTART		=80 ;
	LINKOK			=81 ;
	LINKRETURN		=82 ;
	WM_LINK			=WM_USER + $490 ;

type
   TPgmInfo = record
   	PgmId : array[0..7] of char ;
        handle : LongWord ;
   end ;
   TLinkRec = record
   	UseYN : char ;
   	FromPgm : TPgmInfo ;
        ToPgm : TPgmInfo ;
       	RtnStr : shortstring ;
        WaitRtn : Boolean ;
   end ;

implementation

end.
