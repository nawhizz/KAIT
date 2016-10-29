unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, WinSkinData, menu_execute;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    SkinData1: TSkinData;
    Button2: TButton;
    Dialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    function getPrgmId:Pointer;

    { Public declarations }
    Procedure PopupItemClick ( Sender : TObject );
    Procedure CreateMenus;

//    function getPrgmId:Pointer;
end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.getPrgmId:Pointer;
begin
    result:= nil; //Addr(PopupItemClick2);
end;

//이 부분은 메인폼이 완전히 생성되기 전에 실행할 것.
procedure TForm1.CreateMenus;
var
  	mainMenu:TMainMenu;
	menuitem: TMenuItem;
begin
	//메인메뉴 생성
	mainMenu := TMainMenu.Create(self);
    self.Menu := mainMenu;

    //메인메뉴 아이템 생성
   	menuItem := TMenuItem.Create(self) ;
   	menuItem.Caption := '입력관리&';
   	//menuItem.OnClick := PopupItemClick; //메인메뉴 아이템에 이벤트를 추가할 수 있다.
   	menuItem.Tag := 1;

    //메인메뉴에 메인메뉴아이템을 추가한다.
    mainMenu.Items.Add(menuItem) ;

   	menuItem := TMenuItem.Create(self);
   	menuItem.Caption := '조회관리&';
   	menuItem.OnClick := PopupItemClick;
    menuItem.Name := 'johoi';
   	menuItem.Tag := 2;

    mainMenu.Items.Add(menuItem) ;

    //서브메뉴아이템 생성
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '입고내역입력';
    menuItem.OnClick := PopupItemClick;
    menuItem.Name:='ibgo';
    menuItem.Tag := 1;

    //메인메뉴아이템에 서브메뉴아이템을 추가한다.
//    menuItem.Add(smitem);
    mainMenu.Items[0].Add(menuItem);

    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '-';
    mainMenu.Items[0].Add(menuItem);

    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '분실자수취확인입력';
    //menuItem.OnClick := PopupItemClick2;
    menuItem.Tag := 2;
    mainMenu.Items[0].Add(menuItem);

    //2차 서브메뉴 아이템 추가
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '입력창띄우기';
    menuItem.OnClick := PopupItemClick;
    menuItem.Tag := 1;
    menuItem.Name:='ibryeok';
    mainMenu.Items[0].Items[2].Add(menuItem);
end;

Procedure TForm1.PopupItemClick(Sender : TObject);
var
	menuItem:TMenuItem;
begin
	menuItem := Sender as TMenuItem;
    if menuItem.Name = 'johoi' then
		ShowMessage('조회관리')

    else if menuItem.Name = 'ibgo' then
		ShowMessage('입고내역입력')

    else if menuItem.Name = 'ibryeok' then
		ShowMessage('입력창띄우기');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	//************* 메인윈도우 적용부분***************************
	//다이나믹 메뉴에 스킨효과를 적용하기 위해서는 폼이 디스플레이 되기전에
    //메뉴를 먼저 생성해야 한다. 즉, 스킨은 모든 컴포넌트가 디스플레이 된 후에
    //적용된다.
	CreateMenus;

    SkinData1.Active:= False;
    SkinData1.SkinFile := './mxskin71.skn';
    SkinData1.Active:= True;

	//********** 모든 차일드 윈도우 공통 적용부분*****************
    kait := ParamStr(1);
    if length(ParamStr(2)) > 0 then
    	parent_window := strToInt(ParamStr(2));
    user_id := ParamStr(3);
    user_name := ParamStr(4);
    user_group := ParamStr(5);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
	ShowMessage('다이나믹 메뉴는 폼이 완전히 보여지기 전에 생성할 것.');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Dialog1.filter:='Skin files (*.skn)|*.SKN';
  Dialog1.initialdir:= GetCurrentDir;
  if Dialog1.execute then
     SkinData1.skinfile:=dialog1.filename;
  if not SkinData1.Active then
   SkinData1.Active:=true;

end;

end.
