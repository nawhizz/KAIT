unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, printers;

type
  paperSize = record
    maxWidth  : Integer;
    maxHeight : Integer;
    margin    : Integer;
  end;

  mArrSTR = record
    xCrd    : Array of Integer;
    yCrd    : Array of Integer;
    strSrc  : Array of String;
  end;

type
 TCOMM = class



public
 	Constructor Create(objGrd : TStringGrid); overload;
 	Constructor Create(objGrd : TStringGrid; pSize : paperSize); overload;

  procedure showTitle;
  procedure run; overload;
  procedure run(poDirection : Integer); overload;


  // 배열의 크기를 설정한다.
  procedure setArrSize(size : Integer; mas : mArrSTR);

  // 헤드라인을 추가한다.
  procedure headAdd(lineNum : Integer; strHeadLine : String);

  // 수동으로 직접 문자열을 입력한다.
  procedure mAdd(xCrd , yCrd : Integer;strSrc : String);

  function getLength(index :Integer):Cardinal;
  function getRightPosition(index: Integer):Cardinal;

private
  arrStrTitle : Array of String;
  arrGrdSize  : Array of Integer;
	len         : Array of Cardinal;
	xRpoints    : Array of Cardinal;

  pSize       : paperSize;
  mHeadStr    : mArrSTR;
  mManStr     : mArrSTR;
  capHeight   : Integer;  //문자높이 계산, 4mm
  ygap        : Integer;  // 1mm 갭
  curntY      : Integer;  //문자열을 쓰거나 라인을 그을때 y-축 기준점
  Canvas      : TCanvas;

  objGrid     : TStringGrid;
  procedure lineOver;


published

end;

implementation

  // 생성자 메소드
	Constructor TCOMM.Create(objGrd : TStringGrid);
  begin

    // A4 = 297mm
    // A4 = 210mm
    // left, right margin = 20mm
    self.pSize.maxWidth   := 2960 ;
    self.pSize.maxHeight  := 2090 ;
    self.pSize.margin     := 200  ;

    Create(objGrd,self.pSize);
  end;

  // 생성자 메소드
  Constructor TCOMM.Create(objGrd : TStringGrid; pSize : paperSize);
  var
    i,j : Integer;
  begin
    objGrid := objGrd;
    SetLength(arrStrTitle,objGrd.ColCount);
    SetLength(len        ,objGrd.ColCount);
    SetLength(xRpoints   ,objGrd.ColCount);
    SetLength(arrGrdSize ,objGrd.ColCount);

    for i:=0 to objGrd.ColCount - 1 do
    begin
      arrStrTitle[i] := objGrid.cells[i,0];// 그리드의 타이틀을 저장
      if(i <> 0 ) then arrGrdSize[i] := arrGrdSize[i-1] + Trunc(objGrd.ColWidths[i])    // 그리드의 넓이를 저장
      else arrGrdSize[i] := Trunc(objGrd.ColWidths[i]);
    end;

  end;

  // 타이틀을 보여준다.
  procedure TCOMM.showTitle();
  var
    strTitle : String;
    i : Integer;
  begin
    strTitle := '';

    for i:=0 to Length(arrStrTitle) - 1 do
      strTitle := strTitle + ' ' + arrStrTitle[i];

    ShowMessage(strTitle);
  end;

  // 실행한다.
  procedure TCOMM.run;
  begin
    run(0);
  end;

  // 실행한다.
  // run(방향설정 0:세로 1: 가로)
  procedure TCOMM.run(poDirection : Integer);
  var
    lineStart,lineEnd : Integer;
    page : Integer;

    // 프린트 초기값설정
    procedure initPrt();
    begin
      SetMapMode(Canvas.Handle, MM_LOMETRIC);	            // 0.1mm 단위
      Canvas.Font.Name := '굴림체';
      Canvas.Font.Height := 40;                           // 글자체 높이 4mm
      capHeight := Canvas.TextHeight('가');               // 문자높이 계산, 4mm
      ygap      := 10;							                      // 1mm 갭
      self.curntY  := -100;   				                      // 문자열을 쓰거나 라인을 그을때 y-축 기준점
    end;

    Procedure procPrtTitle(page: Integer);
    begin
    end;
        
    // 페이지 개행 조건
    procedure procCheckPage(Y : Integer);
    begin
      if self.curntY >= self.pSize.maxWidth then
      begin
        Printer.NewPage;      // 새 페이지 추가
        Inc(page);   			    // 페이지 번호 카운트 업
        self.curntY := -100;  // y축  position을 새로 시작한다.

        //기타 초기화 해야 할 항목이 있으면 여기서...
        //procPrtTitle(page);		//타이틀을 다시 프린트...
      end;
    end;

    // 출력
    procedure procPrtLine(x : Integer;strTar : String);
    begin
      Canvas.TextOut(x + 200,self.curntY,strTar);
    end;
    // 본문 출력부
    procedure procPrtBody();
    var
      i,j : Integer;
    begin
      with objGrid do begin
        for i:= 0 to RowCount - 1 do begin
            for j:= 0 to ColCount- 1 do
              procPrtLine(Canvas.TextWidth(arrGrdSize[j]), Cells[j,i]);

            lineOver();
        end;
      end;
    end;

  begin
    if (poDirection <> 0) or (poDirection <> 1) then poDirection := 0;

    Canvas := Printer.Canvas;

    // 출력 방향 설정(0: poPortrait 1: poLandscape)
    if (poDirection = 0) then Printer.Orientation := poPortrait
    else Printer.Orientation := poLandscape;

    // 출력 시작 설정
    Printer.BeginDoc;

    initPrt();

    //lineStart := getRightPosition(0)- getLength(0) -20;	// 선긋기 x-축 시작점

    //lineEnd   := getRightPosition(8) +20;						    // 선긋기 x-축 끝점

    // 머릿말 출력

    // 헤드라인 출력

    // 본문 출력
    procPrtBody();

    //내용 프린트---마지막 줄은 따로 프린트

   	Printer.EndDoc;
  end;

  // 라인을 개행하는 기능을 한다.
  procedure TCOMM.lineOver();
  begin
    Inc(curntY, -capHeight);	//다음줄 이동
    Inc(curntY, -ygap);		    //1mm 아래로 이동
  end;

  // 헤드라인을 추가한다.
  procedure TCOMM.headAdd(lineNum : Integer; strHeadLine : String);
  begin
  end;

  // 좌표를 직접입력하여 문자열을 추가한다.
  procedure TCOMM.mAdd(xCrd , yCrd : Integer;strSrc : String);
  begin
    mManStr.xCrd[Length(mManStr.xCrd)]  := xCrd;
    mManStr.yCrd[Length(mManStr.yCrd)]  := yCrd;
    mManStr.strSrc[Length(strSrc)]      := strSrc;
  end;

  procedure TCOMM.setArrSize(size : Integer; mas : mArrSTR);
  begin
    SetLength(mas.xCrd  ,size);
    SetLength(mas.yCrd  ,size);
    SetLength(mas.strSrc,size);
  end;

  function TCOMM.getLength(index :Integer):Cardinal;
  begin
    result:= len[index];
      if (index < low(len)) or (index > high(len)) then
        result:= 0;
  end;

  function TCOMM.getRightPosition(index: Integer):Cardinal;
  begin
    result:= xRpoints[index];
      if (index < low(xRpoints)) or (index > high(xRpoints)) then
        result := 0;
  end;

end.


