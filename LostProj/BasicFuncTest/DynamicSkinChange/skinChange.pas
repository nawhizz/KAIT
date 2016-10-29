unit skinChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, WinSkinData, Menus, Unit1, Buttons, IniFiles;

type
  TSkinChangeForm = class(TForm)
    ListBox1: TListBox;
    Image1:   TImage;
    Panel1: TPanel;
    BtnApply: TSpeedButton;
    BtnHelp: TSpeedButton;
    BtnClose: TSpeedButton;
    procedure ListBox1Click(Sender: TObject);
    procedure GetFileList(sPath             : String;
                          slFileList        : TStringList;
                          sWildCard         : string = '';
                          bSearchSubFolder  : Bool = false);
    procedure GetSearchedFileList(sPath     : String;
                                  slFileList: TStringList;
                                  sWildStr  : string;
                                  bSchSubFolder : Bool);
    procedure FormCreate(Sender   : TObject);
    procedure BtnApplyClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SkinChangeForm: TSkinChangeForm;

implementation

{$R *.dfm}


procedure TSkinChangeForm.ListBox1Click(Sender: TObject);
  var
      slFileList : TStringList;
      locTar : String;

begin
  slFileList := TStringList.Create;

  locTar := ListBox1.Items.Strings[ListBox1.ItemIndex];
  locTar := Copy(locTar,0,Length(locTar) - 4);


  // 상대경로 지정 방식
  GetSearchedFileList('..\..\Skin\Skin_picture', slFileList, '*' + locTar + '.jpg', false);

  if (slFileList.Count <> 0) then
    begin
      locTar := '..\..\Skin\Skin_picture\' + slFileList.Strings[0];
      Image1.Picture.LoadFromFile(locTar);
    end;

end;

// ************************************************************
// 지정한 폴더 밑에 파일을 필터링하여
// 지정한 폴더 밑의 파일 리스트를 얻는 함수
// ************************************************************
procedure TSkinChangeForm.GetSearchedFileList(sPath : String;
                              slFileList : TStringList;
                              sWildStr : string;
                              bSchSubFolder : Bool);
var
  sTempPath : String;
  SchRec : TSearchRec;
  iSchRec : integer;
begin
  // 뒤에 '\' 붙이기
  if sPath[length(sPath)] <> '\' then sPath := sPath + '\';

  // 와일드 카드 설정
  if (sWildStr = '') or (bSchSubFolder = true) then
    sTempPath := sPath + '*.*'
  else
    sTempPath := sPath + sWildStr;

  iSchRec := FindFirst(sTempPath, faAnyFile or faDirectory, SchRec);
  while (iSchRec = 0) do
  begin
    // '.', '..' 폴더는 제외
    if not ((SchRec.Name = '.') or (SchRec.Name = '..')) then
    begin
      // 폴더가 아닌 것
      if (SchRec.Attr and faDirectory) = 0 then
      begin
        // 와일드카드를 설정하고 서브폴더 밑도 검색할 경우
        if (bSchSubFolder = true) and
           ((sWildStr <> '') or (sWildStr <> '*.*')) then
        begin
          // 수동 필터링 : *.확장자만 지원 / '?'는 지원안함
          if ExtractFileExt(SchRec.Name) = ExtractFileExt(sWildStr) then
            //slFileList.add(sPath + SchRec.Name);
            slFileList.add(SchRec.Name);
        end
        // 일반적인 경우 : 서브폴더 밑 검색안함
        else
          begin
            //slFileList.add(sPath + SchRec.Name);
            slFileList.add(SchRec.Name);
          end
      end
      // 폴더인 경우
      else
      begin
        // 폴더 안에 파일도 검색하는 경우
        if bSchSubFolder = true then
        begin
          // 파일 검색 함수 : 재귀호출
          GetSearchedFileList(sPath + SchRec.Name + '\',
                              slFileList, sWildStr, bSchSubFolder);
        end;
      end;
    end;
    iSchRec := FindNext(SchRec);
  end;
  FindClose(SchRec);
end;

// ************************************************************
// 지정한 폴더 밑에 파일을 필터링하여 StringList로 반환
// ************************************************************
procedure TSkinChangeForm.GetFileList(sPath : String;
                      slFileList : TStringList;
                      sWildCard : string = '';
                      bSearchSubFolder : Bool = false);
begin
  slFileList.Clear;
  GetSearchedFileList(sPath, slFileList, sWildCard, bSearchSubFolder);
end;


procedure TSkinChangeForm.FormCreate(Sender: TObject);
var
  slFileList : TStringList;
begin
  slFileList := TStringList.Create;

  // 상대경로 지정 방식
  GetSearchedFileList('..\..\Skin', slFileList, '*.skn', false);
  ListBox1.Items := slFileList;
end;

procedure TSkinChangeForm.BtnApplyClick(Sender: TObject);
  var
    {
    StrLst: TStringList;
    StrData: string;
    }
    iniLost: TiniFile;

  begin
    if(ListBox1.ItemIndex <> -1) Then
      Begin
        Unit1.Form1.SkinData1.SkinFile := '..\..\Skin\' + ListBox1.Items.Strings[ListBox1.ItemIndex];

        if not Unit1.Form1.SkinData1.Active then
          Unit1.Form1.SkinData1.Active:=true;

        // 손으로 만든 INI
        {
        StrLst  := TStringList.Create;
        StrData := ListBox1.Items.Strings[ListBox1.ItemIndex];
        StrLst.Add('[SkinName]');
        StrLst.Add(StrData);
        StrLst.SaveToFile('skin.ini');
        StrLst.Free;
        }

        // 정식 INI 설정 방법
        iniLost := TiniFile.Create('./../../INI/LostProj.ini');
        iniLost.WriteString('Skin','SKIN',ListBox1.Items.Strings[ListBox1.ItemIndex]);
        iniLost.Free;

      End;
  end;

  
procedure TSkinChangeForm.BtnCloseClick(Sender: TObject);
begin
  self.close;
end;

end.
