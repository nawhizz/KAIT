unit LOSTA320Q_PRT_HEAD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, printers,
  WinSkinData, so_tmax, Menus, common_lib, Func_Lib, Clipbrd;

const
	titles: Array[0..6] of String =(
         '사업자'
         ,'입고'
         ,'출고'
         ,'장기/귀속'
         ,'보험사매각(협회)'
         ,'잔고'
         ,'보험사매각(경찰)');
type
TLOSTA320Q_PRT_HEAD = class(TObject)
public
	Constructor Create(margin, maxWidth:Integer; Canvas:TCanvas);
    function getLength(index :Integer):Cardinal;
    function getRightPosition(index: Integer):Cardinal;
private
	len: Array[0..6] of Cardinal;
	xRpoints:Array[0..6] of Cardinal;
end;

implementation

function TLOSTA320Q_PRT_HEAD.getLength(index :Integer):Cardinal;
begin
	result:= len[index];
    if (index <0) or (index >6) then
    	result:= 0;
end;

function TLOSTA320Q_PRT_HEAD.getRightPosition(index: Integer):Cardinal;
begin
	result:= xRpoints[index];
    if (index <0) or (index >6) then
    	result := 0;
end;

Constructor TLOSTA320Q_PRT_HEAD.Create(margin, maxWidth:Integer; Canvas:TCanvas);
var
  i:Integer;
  gap:Integer;
  xstart:Integer;
begin
  //각 타이틀에 대한 길이(.1mm 단위)를 계산한다.
  for i:=0 to 6 do
  len[i] := Canvas.TextWidth(titles[i]);

  gap := maxWidth - margin *2;
  for i:=0 to 6 do
  gap:= gap - len[i];

  //문자열 사이의 간격( 숫자 '8'은 위 타이틀 갯수 보다 '1'을 작게한다.
  gap := gap div 6;

  //각 타이틀에 대한 x-축 시작점(오른쪽 맞춤)을 계산한다.
  xstart:= margin;
  for i:=0 to 6 do begin
    xstart:= xstart + len[i];
    xRpoints[i]:= xstart;
    xstart:= xstart + gap;
  end;
end;

end.
