{*----------------------------------------------------------------------------*}
{* Uint_Name    : menu_execute.PAS                                                *}
{* 작 성 내 용  : 공통함수 Unit                                               *}
{* 작  성  일   : 2011.7.12                                                  *}
{* 작  성  자   : NAE YOUNG KOO                                                  *}
{*----------------------------------------------------------------------------*}

unit menu_execute;

interface

Uses
  	Windows, SysUtils, Dialogs;

//아래 변수들은 함수를 호출하기 전에 채워져야 한다.
var kait:String = 'X/hhP1cTg/pXHxebWsq/txFVvW8=';	//KAIT의 암호화 코드
var	parent_window:THandle =0;
var	user_id :String ='';
var user_name :String ='';
var user_group:String ='';

//윈도우 실행함수
procedure execute_Window(prgm_id:String);forward;

implementation

procedure execute_Window(prgm_id:String);
var
	str:String;
begin
	str := prgm_id + '.exe '+ kait +' '+ intToStr(parent_window) +' '+ user_id +' '+
    	user_name +' '+ user_group;

    if WinExec(pchar(str), SW_SHOW) <= 31 then
    	ShowMessage('Program '''+ prgm_id +''' 실행오류!');
end;

end.

