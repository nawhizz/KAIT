unit LOSTA340Q_PRT_HEAD2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, printers,
  WinSkinData, so_tmax, Menus, common_lib, Func_Lib, Clipbrd;

const
	titles2: Array[0..5] of String =(
          '�𵨸�'
         ,'�����'
         ,'�԰�'
         ,'���'
         ,'���������'
         ,'�����Ű�');

type
TLOSTA340Q_PRT_HEAD2 = class(TObject)
public
	Constructor Create(margin, maxWidth:Integer; Canvas:TCanvas);
    function getLength(index :Integer):Cardinal;
    function getRightPosition(index: Integer):Cardinal;
private
	len: Array[0..5] of Cardinal;
	xRpoints:Array[0..5] of Cardinal;
end;

implementation

function TLOSTA340Q_PRT_HEAD2.getLength(index :Integer):Cardinal;
begin
	result:= len[index];
    if (index <0) or (index >5) then
    	result:= 0;
end;

function TLOSTA340Q_PRT_HEAD2.getRightPosition(index: Integer):Cardinal;
begin
	result:= xRpoints[index];
    if (index <0) or (index >5) then
    	result := 0;
end;

Constructor TLOSTA340Q_PRT_HEAD2.Create(margin, maxWidth:Integer; Canvas:TCanvas);
var
  i:Integer;
  gap:Integer;
  xstart:Integer;
begin
  //�� Ÿ��Ʋ�� ���� ����(.1mm ����)�� ����Ѵ�.
  for i:=0 to 5 do
  len[i] := Canvas.TextWidth(titles2[i]);

  gap := maxWidth - margin *2;
  for i:=0 to 5 do
  gap:= gap - len[i];

  //���ڿ� ������ ����( ���� '8'�� �� Ÿ��Ʋ ���� ���� '1'�� �۰��Ѵ�.
  gap := gap div 5;

  //�� Ÿ��Ʋ�� ���� x-�� ������(������ ����)�� ����Ѵ�.
  xstart:= margin;
  for i:=0 to 5 do begin
    xstart:= xstart + len[i];
    xRpoints[i]:= xstart;
    xstart:= xstart + gap;
  end;
end;

end.
