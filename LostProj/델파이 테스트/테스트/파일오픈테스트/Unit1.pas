unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids;

type
  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    strngrd1: TStringGrid;
    btn1: TBitBtn;
    procedure btn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    function getDirName(path:String):String;
    function getFinalName(fullName, delimiter:String):String;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
	fpath:String;
    fileName:String;
    dirName:String;
    fstr:String;
   	f: file;//  of Byte;
    fsize:LongInt;

	tempPath:String;

  i : Integer;

//   stat:TSTAT;
begin
	OpenDialog.InitialDir := GetCurrentDir;

    fstr:=	'실행 파일 (*.exe)|*.exe|'+
            '동적 라이브러리 (*.dll)|*.dll|'+
            '텍스트 파일 (*.txt)|*.txt|'+
            '한글 파일 (*.hwp)|*.hwp|'+
            'MS Word (*.doc)|*.doc|'+
            '엑셀 파일 (*.xls)|*.xls|'+
            '파워포인트 파일 (*.ppt)|*.ppt|'+
            '아크로벳 파일 (*.pdf)|*.pdf'; //|'+
			//'전체 파일 (*.*)|*.*';

	OpenDialog.Filter := FStr;

  if not OpenDialog.Execute then
    exit;

  for i := 0 to OpenDialog.Files.Count -1 do
  begin


    fpath     := OpenDialog.Files.Strings[i];
    dirName   := getDirname(fpath);
    fileName  := getFinalName(fpath,'\');

    AssignFile(f, fpath);

    try
      Reset(f,1);
      fsize := FileSize(f);
      CloseFile(f);

    //위에서 언급한 프로그램외에 실행하고 있으면
    except
      CloseFile(f);
      ShowMessage(''''+fileName+''''+'이 실행 중입니다'+#13#10+'종료후 다시 실행 하세요');
      exit;
    end;

    with strngrd1 do begin
      RowCount := RowCount +1;

      Cells[0,RowCount-1] := dirName;
      Cells[1,RowCount-1] := fileName;
      Cells[2,RowCount-1] := intToStr(fsize);
      Cells[3,RowCount-1] := fpath;

      Row:= RowCount-1;
    end;
  end;

  strngrd1.FixedRows := 1;	//column sizable...
end;

function TForm1.getDirName(path:String):String;
var
  len :Integer;
  po  :Integer;

  fileName  :String;
begin
  result  := path;
  po      := Pos('\', path);
  if po =0 then
    exit;

  fileName  := getFinalName(path, '\');
  len       := Length(path) - Length(fileName) -1;
  result    := getFinalName(Copy(path, 1, len), '\');
end;

function TForm1.getFinalName(fullName, delimiter:String):String;
var
	len:Integer;
    po:Integer;

    function unitString(org:String):String;
    var
    	len:Integer;
        po:Integer;
    begin
    	result := org;

    	po := Pos(delimiter, org);
        if po = 0 then
        	exit;

        len := Length(org);
        result := unitString(Copy(org, po+1, len-po));
    end;
begin
	result := fullName;

    po := Pos(delimiter, fullName);
    if po =0 then
    	exit;

    len := Length(fullName);
    result := unitString(Copy(fullName, po+1, len-po));
end;

end.
