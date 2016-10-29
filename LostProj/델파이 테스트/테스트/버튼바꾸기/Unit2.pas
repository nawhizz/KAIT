unit Unit2;

interface

uses   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

  procedure changeBtn(frm : TForm);

var
  bitmap : TBitmap;

implementation

procedure changeBtn(frm : TForm);
const
  LOC = '.\..\Icons\Blue Icon Pack\';
var
  i : Integer;
  component : TComponent;
begin

  for i := 0 to frm.ComponentCount - 1 do
    begin

      component := frm.Components[i];

      bitmap := TBitmap.Create;

      if (component is TSpeedButton) then
      begin
         if (component as TSpeedButton).Name = 'btn_Add' then
           begin
             bitmap.LoadFromFile(Loc + '���.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Update' then
           begin
             bitmap.LoadFromFile(Loc + '����.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Delete' then
           begin
             bitmap.LoadFromFile(Loc + '����.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Inquiry' then
           begin
             bitmap.LoadFromFile(Loc + '��ȸ.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Link' then
           begin
             bitmap.LoadFromFile(Loc + '����.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Next_Inq' then
           begin
             bitmap.LoadFromFile(Loc + '�ݱ�.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Print' then
           begin
             bitmap.LoadFromFile(Loc + '�μ�.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Excel' then
           begin
             bitmap.LoadFromFile(Loc + '����.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end
         else if (component as TSpeedButton).Name = 'btn_Close' then
           begin
             bitmap.LoadFromFile(Loc + '�ݱ�.bmp');
             (component as TSpeedButton).Glyph := bitmap;
           end;
      end;
    end;
end;

end.
