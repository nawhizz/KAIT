{*----------------------------------------------------------------------------*}
{* Uint_Name    : menu_execute.PAS                                                *}
{* �� �� �� ��  : �����Լ� Unit                                               *}
{* ��  ��  ��   : 2011.7.12                                                  *}
{* ��  ��  ��   : NAE YOUNG KOO                                                  *}
{*----------------------------------------------------------------------------*}

unit menu_execute;

interface

Uses
  	Windows, SysUtils, Dialogs;

//�Ʒ� �������� �Լ��� ȣ���ϱ� ���� ä������ �Ѵ�.
var kait:String = 'X/hhP1cTg/pXHxebWsq/txFVvW8=';	//KAIT�� ��ȣȭ �ڵ�
var	parent_window:THandle =0;
var	user_id :String ='';
var user_name :String ='';
var user_group:String ='';

//������ �����Լ�
procedure execute_Window(prgm_id:String);forward;

implementation

procedure execute_Window(prgm_id:String);
var
	str:String;
begin
	str := prgm_id + '.exe '+ kait +' '+ intToStr(parent_window) +' '+ user_id +' '+
    	user_name +' '+ user_group;

    if WinExec(pchar(str), SW_SHOW) <= 31 then
    	ShowMessage('Program '''+ prgm_id +''' �������!');
end;

end.

