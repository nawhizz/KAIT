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


  // ����� ���� ���
  GetSearchedFileList('..\..\Skin\Skin_picture', slFileList, '*' + locTar + '.jpg', false);

  if (slFileList.Count <> 0) then
    begin
      locTar := '..\..\Skin\Skin_picture\' + slFileList.Strings[0];
      Image1.Picture.LoadFromFile(locTar);
    end;

end;

// ************************************************************
// ������ ���� �ؿ� ������ ���͸��Ͽ�
// ������ ���� ���� ���� ����Ʈ�� ��� �Լ�
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
  // �ڿ� '\' ���̱�
  if sPath[length(sPath)] <> '\' then sPath := sPath + '\';

  // ���ϵ� ī�� ����
  if (sWildStr = '') or (bSchSubFolder = true) then
    sTempPath := sPath + '*.*'
  else
    sTempPath := sPath + sWildStr;

  iSchRec := FindFirst(sTempPath, faAnyFile or faDirectory, SchRec);
  while (iSchRec = 0) do
  begin
    // '.', '..' ������ ����
    if not ((SchRec.Name = '.') or (SchRec.Name = '..')) then
    begin
      // ������ �ƴ� ��
      if (SchRec.Attr and faDirectory) = 0 then
      begin
        // ���ϵ�ī�带 �����ϰ� �������� �ص� �˻��� ���
        if (bSchSubFolder = true) and
           ((sWildStr <> '') or (sWildStr <> '*.*')) then
        begin
          // ���� ���͸� : *.Ȯ���ڸ� ���� / '?'�� ��������
          if ExtractFileExt(SchRec.Name) = ExtractFileExt(sWildStr) then
            //slFileList.add(sPath + SchRec.Name);
            slFileList.add(SchRec.Name);
        end
        // �Ϲ����� ��� : �������� �� �˻�����
        else
          begin
            //slFileList.add(sPath + SchRec.Name);
            slFileList.add(SchRec.Name);
          end
      end
      // ������ ���
      else
      begin
        // ���� �ȿ� ���ϵ� �˻��ϴ� ���
        if bSchSubFolder = true then
        begin
          // ���� �˻� �Լ� : ���ȣ��
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
// ������ ���� �ؿ� ������ ���͸��Ͽ� StringList�� ��ȯ
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

  // ����� ���� ���
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

        // ������ ���� INI
        {
        StrLst  := TStringList.Create;
        StrData := ListBox1.Items.Strings[ListBox1.ItemIndex];
        StrLst.Add('[SkinName]');
        StrLst.Add(StrData);
        StrLst.SaveToFile('skin.ini');
        StrLst.Free;
        }

        // ���� INI ���� ���
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
