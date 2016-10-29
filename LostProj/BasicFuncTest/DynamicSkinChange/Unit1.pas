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

//�� �κ��� �������� ������ �����Ǳ� ���� ������ ��.
procedure TForm1.CreateMenus;
var
  	mainMenu: TMainMenu;
	  menuitem: TMenuItem;
begin
	//���θ޴� ����
	mainMenu := TMainMenu.Create(self);
    self.Menu := mainMenu;

    //���θ޴� ������ ����
   	menuItem := TMenuItem.Create(self) ;
   	menuItem.Caption := '�Է°���&';
   	//menuItem.OnClick := PopupItemClick; //���θ޴� �����ۿ� �̺�Ʈ�� �߰��� �� �ִ�.
   	menuItem.Tag := 1;

    //���θ޴��� ���θ޴��������� �߰��Ѵ�.
    mainMenu.Items.Add(menuItem) ;

   	menuItem := TMenuItem.Create(self);
   	menuItem.Caption := '��ȸ����&';
   	menuItem.OnClick := PopupItemClick;
    menuItem.Name := 'johoi';
   	menuItem.Tag := 2;

    mainMenu.Items.Add(menuItem) ;

    //����޴������� ����
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '�԰����Է�';
    menuItem.OnClick := PopupItemClick;
    menuItem.Name:='ibgo';
    menuItem.Tag := 1;

    //���θ޴������ۿ� ����޴��������� �߰��Ѵ�.
//    menuItem.Add(smitem);
    mainMenu.Items[0].Add(menuItem);

    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '-';
    mainMenu.Items[0].Add(menuItem);

    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '�н��ڼ���Ȯ���Է�';
    //menuItem.OnClick := PopupItemClick2;
    menuItem.Tag := 2;
    mainMenu.Items[0].Add(menuItem);

    //2�� ����޴� ������ �߰�
    menuItem := TMenuItem.Create(self);
    menuItem.Caption := '�Է�â����';
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
		ShowMessage('��ȸ����')

    else if menuItem.Name = 'ibgo' then
		ShowMessage('�԰����Է�')

    else if menuItem.Name = 'ibryeok' then
		ShowMessage('�Է�â����');
end;

procedure TForm1.FormCreate(Sender: TObject);
  var
    {
    ts  : TStringList;
    i   : Integer;
    }

    iniLost : TiniFile;
begin
	//************* ���������� ����κ�***************************
	//���̳��� �޴��� ��Ųȿ���� �����ϱ� ���ؼ��� ���� ���÷��� �Ǳ�����
    //�޴��� ���� �����ؾ� �Ѵ�. ��, ��Ų�� ��� ������Ʈ�� ���÷��� �� �Ŀ�
    //����ȴ�.
	CreateMenus;

    // ������ INI
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
                ShowMessage('������ �������� �ʽ��ϴ�(ts[i+1]).');
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



	//********** ��� ���ϵ� ������ ���� ����κ�*****************
    kait := ParamStr(1);
    if length(ParamStr(2)) > 0 then
    	parent_window := strToInt(ParamStr(2));
    user_id := ParamStr(3);
    user_name := ParamStr(4);
    user_group := ParamStr(5);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
	ShowMessage('���̳��� �޴��� ���� ������ �������� ���� ������ ��.');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

end.
