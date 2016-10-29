unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, localCloud, StdCtrls;

const
	LINKSTART		=80;
	LINKOK			=81;
	LINKRETURN		=82;
	WM_LINK			= WM_USER + $490 ;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure Link_rtn (var Msg:TMessage); message WM_LINK;

  end;

var	smem: TPSharedMem = nil;

var
  Form1: TForm1;


implementation

{$R *.dfm}

procedure TForm1.Link_rtn (var Msg : TMessage) ;
begin
	if smem <> nil then begin
    	Lock;
    	Edit1.Text := smem^.Name;
		Edit2.Text :=smem^.Phone;
        UnLock;
	end;
{
	case Msg.wParam of
		LINKSTART :
     begin
        if not CLinkRecv (handle, Msg.lParam, LinkRec) then
           exit ;
        if not CLinkSendOK (handle, Msg.lParam) then
           exit ;
        LinkRcvRecNo := Msg.lParam ;
        LinkStart_rtn (CArrToStr (LinkRec.FromPgm.PgmId)) ;
     end ;
     LINKOK :
     begin
        if (Msg.LParam <> LinkSndRecNo) or
           (not CLinkFindByNo (Msg.LParam, LinkRec)) or
           (LinkRec.FromPgm.handle <> handle) or
           (LinkRec.UseYN <> 'Y') or
           (not LinkRec.WaitRtn) then
           exit ;
        Enabled := False ;
     end ;
     LINKRETURN :
     begin
        if (Msg.LParam <> LinkSndRecNo) or
           (not CLinkEndRecv (handle, Msg.LParam, LinkRec)) then
           exit ;
        Enabled := true ;
        LinkEnd_rtn (CArrToStr (LinkRec.ToPgm.PgmId), LinkRec.RtnStr);
        SetForegroundWindow(LinkRec.FromPgm.handle);
     end ;
   end ;
}
end ;

//고유메모리 공유메모리 생성
procedure TForm1.Button1Click(Sender: TObject);
begin
	smem := CreateMap;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
	CloseMap;
    smem := nil;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
	if smem <> nil then begin
    	Lock;
    	smem^.Name := Edit1.Text;
		smem^.Phone:= Edit2.Text;
        UnLock;
	end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
	CloseMap;
    smem := nil;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
	hstr:String;
begin
	hstr := 'Project2.exe '+ intToStr(handle);
    WinExec(PChar(hstr), SW_SHOW);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	//공유메모리 생성
	Button1Click(self);
end;

end.
