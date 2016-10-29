unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, WinSkinData, menu_execute, IniFiles;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Dialog1: TOpenDialog;
    SkinData1: TSkinData;
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
uses Unit2;
{$R *.dfm}

function TForm1.getPrgmId:Pointer;
begin
    result:= nil; //Addr(PopupItemClick2);
end;

//이 부분은 메인폼이 완전히 생성되기 전에 실행할 것.
procedure TForm1.CreateMenus;
var
  	mainMenu: TMainMenu;
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
  var
    {
    ts  : TStringList;
    i   : Integer;
    }

    iniLost : TiniFile;
begin
	//************* 메인윈도우 적용부분***************************
	//다이나믹 메뉴에 스킨효과를 적용하기 위해서는 폼이 디스플레이 되기전에
    //메뉴를 먼저 생성해야 한다. 즉, 스킨은 모든 컴포넌트가 디스플레이 된 후에
    //적용된다.
	CreateMenus;

    // 수동형 INI
    {
    if FileExists('.\skin.ini') then
      begin
        ts := TStringList.Create;
        ts.LoadFromFile('.\skin.ini');
        for i:= ts.Count-1 downto 0
        do
          begin
            if trim(ts[i]) = '[SkinName]' then
            begin
              if (FileExists('..\..\Skin\' + ts[i+1])) then
                SkinData1.SkinFile := '..\..\Skin\' + ts[i+1]
              else
                ShowMessage('파일이 존재하지 않습니다(ts[i+1]).');
            end;
          end;
      end;
    }

    if FileExists('.\..\..\INI\LostProj.ini') then
      begin
        iniLost := TiniFile.Create('.\..\..\INI\LostProj.ini');

        SkinData1.SkinFile := '..\..\Skin\' + iniLost.ReadString('Skin','SKIN','');

        iniLost.Free;
      end;

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
  Form2.ShowModal;
end;

end.
