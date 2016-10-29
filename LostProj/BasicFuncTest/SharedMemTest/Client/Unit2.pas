unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, localCloud;

const
	LINKSTART		=80;
	LINKOK			=81;
	LINKRETURN		=82;
	WM_LINK			= WM_USER + $490 ;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  serverHandle:THandle;

var smem:TPSharedMem = nil;

implementation

{$R *.dfm}

//�����޸� ����
procedure TForm2.Button1Click(Sender: TObject);
begin
	smem := OpenMap;
{
	if smem <> nil then begin
    	Lock;
		Edit1.Text := smem^.Name;
		Edit2.Text := smem^.Phone;
        UnLock;
	end;
}
end;

//�����޸� �ݱ�
procedure TForm2.FormDestroy(Sender: TObject);
begin
	CloseMap;
end;

//GET data
procedure TForm2.Button2Click(Sender: TObject);
begin
	if smem <> nil then begin
    	Lock;
		Edit1.Text := 'rtn->'+ smem^.Name;
		Edit2.Text := 'rtn->'+ smem^.Phone;
        UnLock;
	end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
	//�����޸𸮿� �����͸� �ø�
	if smem <> nil then begin
    	Lock;
		smem^.Name := Edit1.Text;
		smem^.Phone := Edit2.Text;
        UnLock;
	end;
    //�������� �˸���.
    PostMessage(serverHandle, WM_LINK, 0, 0);

    PostMessage(handle, WM_QUIT, 0,0);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
	//�����ڵ��� ����
	serverHandle := strToInt(ParamStr(1));
    //�����޸𸮸� ã�´�.
 	Button1Click(Self);
    //�����͸� �д´�.
	Button2Click(self);
end;

end.
