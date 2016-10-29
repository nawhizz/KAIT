unit LOSTB240Q_PRT_HEAD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, printers,
  WinSkinData, so_tmax, Menus, common_lib, Func_Lib, Clipbrd;

const
	titles: Array[0..8] of String =(
    		'발송일자',
            'KT 건수',
            'LGU+ 건수',
            'PCS불명 건수',
            'PCS 총건수',
            'SKT 건수',
            '셀룰러불명 건수',
            '셀룰러 총건수',
            '총 건수');
type
TLOSTB240Q_PRT_HEAD = class(TObject)
public
	Constructor Create(margin, maxWidth:Integer; Canvas:TCanvas);
    function getLength(index :Integer):Cardinal;
    function getRightPosition(index: Integer):Cardinal;
private
	len: Array[0..8] of Cardinal;
	xRpoints:Array[0..8] of Cardinal;
end;

implementation

function TLOSTB240Q_PRT_HEAD.getLength(index :Integer):Cardinal;
begin
	result:= len[index];
    if (index <0) or (index >8) then
    	result:= 0;
end;

function TLOSTB240Q_PRT_HEAD.getRightPosition(index: Integer):Cardinal;
begin
	result:= xRpoints[index];
    if (index <0) or (index >8) then
    	result := 0;
end;

Constructor TLOSTB240Q_PRT_HEAD.Create(margin, maxWidth:Integer; Canvas:TCanvas);
var
	i:Integer;
    gap:Integer;
    xstart:Integer;
begin
	//각 타이틀에 대한 길이(.1mm 단위)를 계산한다.
	for i:=0 to 8 do
    	len[i] := Canvas.TextWidth(titles[i]);

    gap := maxWidth - margin *2;
    for i:=0 to 8 do
    	gap:= gap - len[i];

    //문자열 사이의 간격( 숫자 '8'은 위 타이틀 갯수 보다 '1'을 작게한다.
    gap := gap div 8;

    //각 타이틀에 대한 x-축 시작점(오른쪽 맞춤)을 계산한다.
    xstart:= margin;
	for i:=0 to 8 do begin
    	xstart:= xstart + len[i];
		xRpoints[i]:= xstart;
        xstart:= xstart + gap;
    end;
end;

end.
