unit LOSTA360Q_PRT_HEAD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, printers,
  WinSkinData, so_tmax, Menus, common_lib, Func_Lib, Clipbrd;

const
	titles: Array[0..6] of String =(
                                   '�����'
                                  ,'�԰�'
                                  ,'����Ȯ��'
                                  ,'����ź�'
                                  ,'����������'
                                  ,'���'
                                  ,'���/�ͼ�'
                                  );

type
TLOSTA360Q_PRT_HEAD = class(TObject)
public
	Constructor Create(margin, maxWidth:Integer; Canvas:TCanvas);
    function getLength(index :Integer):Cardinal;
    function getRightPosition(index: Integer):Cardinal;
private
	len: Array[0..6] of Cardinal;
	xRpoints:Array[0..6] of Cardinal;
end;

implementation

function TLOSTA360Q_PRT_HEAD.getLength(index :Integer):Cardinal;
begin
	result:= len[index];
    if (index <0) or (index >6) then
    	result:= 0;
end;

function TLOSTA360Q_PRT_HEAD.getRightPosition(index: Integer):Cardinal;
begin
	result:= xRpoints[index];
    if (index <0) or (index >6) then
    	result := 0;
end;

Constructor TLOSTA360Q_PRT_HEAD.Create(margin, maxWidth:Integer; Canvas:TCanvas);
var
  i:Integer;
  gap:Integer;
  xstart:Integer;
begin
  //�� Ÿ��Ʋ�� ���� ����(.1mm ����)�� ����Ѵ�.
  for i:=0 to 6 do
  len[i] := Canvas.TextWidth(titles[i]);

  gap := maxWidth - margin *2;
  for i:=0 to 6 do
  gap:= gap - len[i];

  //���ڿ� ������ ����( ���� '8'�� �� Ÿ��Ʋ ���� ���� '1'�� �۰��Ѵ�.
  gap := gap div 6;

  //�� Ÿ��Ʋ�� ���� x-�� ������(������ ����)�� ����Ѵ�.
  xstart:= margin;
  for i:=0 to 6 do begin
    xstart:= xstart + len[i];
    xRpoints[i]:= xstart;
    xstart:= xstart + gap;
  end;
end;

end.
