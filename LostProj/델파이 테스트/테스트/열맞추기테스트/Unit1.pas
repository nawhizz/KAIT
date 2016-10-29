unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Clipbrd;

type
  TForm1 = class(TForm)
    btn1: TButton;
    mmo1: TMemo;
    procedure btn1Click(Sender: TObject);
    procedure MMOKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
type
  arrStrValue =  Array of array of string;
var
 strLst : TStringList;
 arrStrValue1 : arrStrValue;
 strHead,strTail : string;
 MaxLength : Integer;

 procedure SwapArr(var str1, str2 : String);
 var strTmp : string;
  begin
    strTmp := '';
    strTmp := str2;
    str2 := str1;
    str1 := strTmp;
  end;
  
 procedure setList();
 var
   i : Integer;
 begin
    for i := 0 to mmo1.Lines.Count do
      begin
        if(mmo1.Lines.Strings[i] = '') then
          begin
            mmo1.Lines.Delete(i);
            Continue;
          end;
        strHead := Trim(Copy( mmo1.Lines.Strings[i],0
                        ,Pos(':',mmo1.Lines.Strings[i]) - 1));
        strTail := Trim(Copy( mmo1.Lines.Strings[i],Pos(':',mmo1.Lines.Strings[i]) + 1
                        ,Length(mmo1.Lines.Strings[i]) - Pos(':',mmo1.Lines.Strings[i]) -1));
        if (Pos(',',strHead) > 0) then
        begin
          mmo1.Lines.Add(Trim(Copy(strHead,0, Pos(',',strHead) -1)) + ' : ' + strTail + ';');
          mmo1.Lines.Add(Trim(Copy(strHead,Pos(',',strHead) + 1,Length(strHead))) + ' : ' + strTail + ';');
          mmo1.Lines.Delete(i);
          setList();
        end
      end;
 end;

 procedure putArrLst();
 var
   i : Integer;
 begin
    SetLength(arrStrValue1,mmo1.Lines.Count,2);
    //FillChar((@arrStrValue[0])^,Length(arrStrValue)*sizeof(string),0);
    strLst.Text := mmo1.Text;

    for i := 0 to strLst.Count - 1 do
      begin
        arrStrValue1[i,0] := Trim(Copy(strLst.Strings[i],0
                    ,Pos(':',strLst.Strings[i]) - 1));
        arrStrValue1[i,1] := Trim(Copy( strLst.Strings[i],Pos(':',strLst.Strings[i]) + 1
                    ,Length(strLst.Strings[i]) - Pos(':',strLst.Strings[i]) -1));
      end;
 end;

 procedure setArrSort(var arrStr : arrStrValue);
 var
  i,j : Integer;

 begin
  for i := 0 to Length(arrStr) -1  do
    begin
      if(MaxLength < Length(arrStr[i,0])) then MaxLength := Length(arrStr[i,0]);

      for j := i + 1 to Length(arrStr) -1 do
      begin
        if (arrStr[i,1] > arrStr[j,1]) then
          begin
            SwapArr(arrStr[i,0],arrStr[j,0]);
            SwapArr(arrStr[i,1],arrStr[j,1]);
          end
      end;
    end;
 end;

 procedure displayArr(Const arrStr : arrStrValue);
 var
   i : Integer;
   s : String;
 begin
 mmo1.Clear;
  for i := 0 to Length(arrStr) -1  do
    begin
      s := '%-' + IntToStr(MaxLength) + 's';
      mmo1.Lines.Add((Format(s,[arrStr[i,0]])) + ': ' + arrStr[i,1] + ';');
    end;
 end;

begin
  strLst := TStringList.Create;
  MaxLength := 0;
  setList();
  putArrLst();
  setArrSort(arrStrValue1);
  displayArr(arrStrValue1);
  Clipboard.AsText := mmo1.Text;

end;

 procedure TForm1.MMOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
    if ((ssCtrl in Shift) AND (Key = ord('C'))) then
     Clipboard.AsText := mmo1.SelText;

    if ((ssCtrl in Shift) AND (Key = ord('A'))) then
      mmo1.SelectAll;
  end;

end.
