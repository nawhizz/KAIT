unit COMM_PRT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, printers,common_lib;

type
  COMM_PRT = class(TObject)

  PPSIZE = record
    prntMargin : Integer;
    ptntWidth  : Integer;
    prntHeight : Integer;
  end;

public
	Constructor Create(objGrd : TStringGrid) overload;
	Constructor Create(objGrd : TStringGrid, prtSize : PPSIZE) overload;

  function getLength(index :Integer):Cardinal;
  function getRightPosition(index: Integer):Cardinal;

  procedure setPrtSize(width,height,margin : Integer);

private
	len      : Array[0..4] of Cardinal;
	xRpoints : Array[0..4] of Cardinal;
  Canvas: TCanvas;
  i, j, page : integer;
  prtSize : PPSIZE;

  datetime : string;

  currentY        :Integer;         //현재 y측 포인트
  prntWidth       :Cardinal;	      //프린터 폭(297mm)
  prntHeight      :Cardinal;        //프린터 높이(210mm)
  prntMargin      :Cardinal;        //오른쪽, 왼쪽 마진(20mm);
  swidth, sheight :Cardinal;	      //문자열 높이

  lineStart       :Cardinal;	      //줄긋기 시작점;
  lineEnd         :Cardinal;
  ygap            :Cardinal;		    //y축 -갭

end;

implementation

// 타이틀의 길이를 반환한다.
function COMM_PRT.getLength(index :Integer):Cardinal;
begin
	result:= len[index];
    if (index <0) or (index >4) then
    	result:= 0;
end;

function COMM_PRT.getRightPosition(index: Integer):Cardinal;
begin
	result:= xRpoints[index];
    if (index <0) or (index >4) then
    	result := 0;
end;

Constructor COMM_PRT.Create(margin, maxWidth:Integer; Canvas:TCanvas);
var
  i:Integer;
  gap:Integer;
  xstart:Integer;
begin
  //타이틀의 길이를 계산하여 배열에 넣는다.
  for i:=0 to 4 do
  len[i] := Canvas.TextWidth(titles[i]);

  // 최대 넓이에서 마진을 뺀 나머지를 구한다.
  gap := maxWidth - margin *2;
  for i:=0 to 4 do
  // gap 에서 타이틀 문자열의 길이를 뺀다.
  gap:= gap - len[i];

  //최종 타이틀의 문자열 간격을 구한다.
  gap := gap div 4;

  // xstart는 마진의 값을 기준으로 시작된다.
  xstart:= margin;
  for i:=0 to 4 do begin
    xstart:= xstart + len[i]; // 마진 + 각각 타이틀의 길이
    xRpoints[i]:= xstart;  // xRpoint의 배열에 각각 집어 넣음(타이틀이 찍히는 위치를 저장
    xstart:= xstart + gap; // 길이 누적화 타이틀 + 타이틀간 간격
  end;
end;

Constructor COMM_PRT.Create(objGrd : TStringGrid);
begin
end;

procedure setPrtSize(width,height,margin : Integer);
begin
  prtSize.
end
end.

