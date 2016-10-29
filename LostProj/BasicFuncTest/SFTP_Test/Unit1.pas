unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CHILKATSSHLib_TLB, OleCtrls, StdCtrls, ComCtrls;

type
	TDataArray = Array of Byte;
type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
	sftp: TChilkatSFtp;
	success: Integer;
	port: Integer;
	hostname: String;
	handle: String;
begin
	//  Important: It is helpful to send the contents of the
	//  sftp.LastErrorText property when requesting support.

	sftp := TChilkatSFtp.Create(Self);

	//  Any string automatically begins a fully-functional 30-day trial.
	success := sftp.UnlockComponent('Anything for 30-day trial');
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Set some timeouts, in milliseconds:
	sftp.ConnectTimeoutMs := 5000;
	sftp.IdleTimeoutMs := 10000;

	//  Connect to the SSH server.
	//  The standard SSH port = 22
	//  The hostname may be a hostname or IP address.

	hostname := '192.168.1.196';
	port := 22;
	success := sftp.Connect(hostname,port);
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Authenticate with the SSH server.  Chilkat SFTP supports
	//  both password-based authenication as well as public-key
	//  authentication.  This example uses password authenication.
	success := sftp.AuthenticatePw('lomofos','1111');
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  After authenticating, the SFTP subsystem must be initialized:
	success := sftp.InitializeSftp();
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Open a file on the server:

	//handle := sftp.OpenFile('hamlet.xml','readOnly','openExisting');
	//handle := sftp.OpenFile('/.cshrc','readOnly','openExisting');
	//handle := sftp.OpenFile('/var/apache/tomcat55/webapps/ROOT/favicon.ico','readOnly','openExisting');
	handle := sftp.OpenFile('/approg/Project1.exe','readOnly','openExisting');
	if (Length(handle) = 0 ) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Download the file:
	//success := sftp.DownloadFile(handle,'D:/KAIT/LostPrj/.cshrc');
	success := sftp.DownloadFile(handle,'D:/KAIT/LostPrj/Project1.exe');
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Close the file.
	success := sftp.CloseHandle(handle);
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

    sftp.Free;
	ShowMessage('Success.');
end;


procedure TForm1.Button2Click(Sender: TObject);
var
	sftp: TChilkatSFtp;
	success: Integer;
	port: Integer;
	hostname: String;
	handle: String;
begin
	//  Important: It is helpful to send the contents of the
	//  sftp.LastErrorText property when requesting support.

	sftp := TChilkatSFtp.Create(Self);

	//  Any string automatically begins a fully-functional 30-day trial.
	success := sftp.UnlockComponent('Anything for 30-day trial');
	if (success <> 1) then  begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Set some timeouts, in milliseconds:
	sftp.ConnectTimeoutMs := 5000;
	sftp.IdleTimeoutMs := 10000;

	//  Connect to the SSH server.
	//  The standard SSH port = 22
	//  The hostname may be a hostname or IP address.

	hostname := '192.168.1.196';
	port := 22;
	success := sftp.Connect(hostname,port);
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Authenticate with the SSH server.  Chilkat SFTP supports
	//  both password-based authenication as well as public-key
	//  authentication.  This example uses password authenication.
	success := sftp.AuthenticatePw('lomofos','1111');
	if (success <> 1) then  begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  After authenticating, the SFTP subsystem must be initialized:
	success := sftp.InitializeSftp();
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Open a file for writing on the SSH server.
	//  If the file already exists, it is overwritten.
	//  (Specify "createNew" instead of "createTruncate" to
	//  prevent overwriting existing files.)

	handle := sftp.OpenFile('/approg/MSN.skn','writeOnly','createTruncate');
	if (Length(handle) = 0 ) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Upload from the local file to the SSH server.
	success := sftp.UploadFile(handle,'D:/KAIT/LostPrj/Skin/MSN.skn');
	if (success <> 1) then  begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Close the file.
	success := sftp.CloseHandle(handle);
	if (success <> 1) then  begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

    sftp.Free;
	ShowMessage('Success.');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
	sftp: TChilkatSFtp;
	success: Integer;
	port: Integer;
	hostname: String;
	fhandle: String;
	pData: Array of Byte;
	bEof: Integer;
	chunkSize: Integer;
    fsize:Integer;
    fsize2:Integer;
    blockLength:Integer;

   	localFile:File;
  	Buffer: Array[1..1024] of Byte; //PByte;
    currPosi:Integer;
    blockBuffer:^Byte;

    procedure AssignData(pData:Array of Byte; len:Integer);
    var
    	i:Integer;
    begin
		for i:=1 to len do begin
        	//Buffer[currPosi] := pData[i];
        	Buffer[i] := pData[i];
            //Inc(currPosi);
        end;
    end;
begin
	//  Important: It is helpful to send the contents of the
	//  sftp.LastErrorText property when requesting support.

	sftp := TChilkatSFtp.Create(Self);

	//  Any string automatically begins a fully-functional 30-day trial.
	success := sftp.UnlockComponent('Anything for 30-day trial');
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Set some timeouts, in milliseconds:
	sftp.ConnectTimeoutMs := 5000;
	sftp.IdleTimeoutMs := 15000;

	//  Connect to the SSH server.
	//  The standard SSH port = 22
	//  The hostname may be a hostname or IP address.

	hostname := '192.168.1.196';
	port := 22;
	success := sftp.Connect(hostname,port);
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Authenticate with the SSH server.  Chilkat SFTP supports
	//  both password-based authenication as well as public-key
	//  authentication.  This example uses password authenication.
	success := sftp.AuthenticatePw('lomofos','1111');
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  After authenticating, the SFTP subsystem must be initialized:
	success := sftp.InitializeSftp();
	if (success <> 1) then   begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	//  Open a file on the server:
	fhandle := sftp.OpenFile('/approg/Project1.exe','readOnly','openExisting');
	if (Length(fhandle) = 0 ) then   begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;

	fsize := sftp.GetFileSize32(fhandle, 1, 1);
    if fsize =-1 then begin
    	ShowMessage(sftp.LastErrorText);
        CloseFile(localFile);
    	Exit;
 	end;


    fsize2:= fsize;
    //GetMem(blockBuffer, fsize);
   // SetLength(Buffer, fsize+1);
    ProgressBar2.Max := fsize;
   	// Try to open the Test.byt file for writing to
    currPosi := 1;
  	AssignFile(localFile, 'D:/KAIT/LostPrj/Project1.exe');
   	ReWrite(localFile,1);

	bEof := 0;
	chunkSize := 2048;


	while bEof = 0 do begin
    	if fsize < chunkSize then
        	chunkSize := fsize;

        if chunkSize =0 then
        	break;
            
    	pData := sftp.ReadFileBytes(fhandle,chunkSize);
    	if (sftp.LastReadFailed(fhandle) = 1) then begin
        	ShowMessage(sftp.LastErrorText);
        	break;
      	end
    	else begin
        	blockLength:= Length(pData);
            AssignData(pData, blockLength);
   		   	//BlockWrite(localFile, pData, blockLength);
            BlockWrite(localFile, Buffer, blockLength);

            ProgressBar2.Position := ProgressBar2.Position + blockLength;
            fsize := fsize - blockLength;
      	end;

    	bEof := sftp.Eof(fhandle);
  	end;

    //FreeMem(Buffer);
    //BlockWrite(localFile, Buffer, 100);//fsize2);
	CloseFile(localFile);

	//  Close the file.
	success := sftp.CloseHandle(fhandle);
	if (success <> 1) then begin
    	ShowMessage(sftp.LastErrorText);
    	Exit;
  	end;
	sftp.Free;
	ShowMessage('Success.');
end;

end.
