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

  currentY        :Integer;         //���� y�� ����Ʈ
  prntWidth       :Cardinal;	      //������ ��(297mm)
  prntHeight      :Cardinal;        //������ ����(210mm)
  prntMargin      :Cardinal;        //������, ���� ����(20mm);
  swidth, sheight :Cardinal;	      //���ڿ� ����

  lineStart       :Cardinal;	      //�ٱ߱� ������;
  lineEnd         :Cardinal;
  ygap            :Cardinal;		    //y�� -��

end;

implementation

// Ÿ��Ʋ�� ���̸� ��ȯ�Ѵ�.
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
  //Ÿ��Ʋ�� ���̸� ����Ͽ� �迭�� �ִ´�.
  for i:=0 to 4 do
  len[i] := Canvas.TextWidth(titles[i]);

  // �ִ� ���̿��� ������ �� �������� ���Ѵ�.
  gap := maxWidth - margin *2;
  for i:=0 to 4 do
  // gap ���� Ÿ��Ʋ ���ڿ��� ���̸� ����.
  gap:= gap - len[i];

  //���� Ÿ��Ʋ�� ���ڿ� ������ ���Ѵ�.
  gap := gap div 4;

  // xstart�� ������ ���� �������� ���۵ȴ�.
  xstart:= margin;
  for i:=0 to 4 do begin
    xstart:= xstart + len[i]; // ���� + ���� Ÿ��Ʋ�� ����
    xRpoints[i]:= xstart;  // xRpoint�� �迭�� ���� ���� ����(Ÿ��Ʋ�� ������ ��ġ�� ����
    xstart:= xstart + gap; // ���� ����ȭ Ÿ��Ʋ + Ÿ��Ʋ�� ����
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

