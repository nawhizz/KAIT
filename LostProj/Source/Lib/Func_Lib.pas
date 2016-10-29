












































































































































































































































































































































































































































































































































































































































































































































































































































































































































































                                                                                {*----------------------------------------------------------------------------*}
{* Uint_Name    : Func_Lib.PAS                                                *}
{* �� �� �� ��  : �����Լ� Unit                                               *}
{* ��  ��  ��   : 1998.11.11                                                  *}
{* ��  ��  ��   : Nason Park                                                  *}
{*----------------------------------------------------------------------------*}
{*  EXCEL ��ġ��ġ �о���� : Func_GetExcelPath                               *}
{*  ����ڹ�ȣ �˻� : Func_CheckSaUpJa (����ڹ�ȣ:String)                    *}
{*  �ֹε�Ϲ�ȣ �˻� : Func_CheckJumin (�ֹι�ȣ:String)                     *}
{*  ��¥���� �˻� : Func_ChekcDate (��¥:String)                              *}
{*  ComboBox�׸� ã�� :                                                       *}
{*             Func_FindItem(ComboBoxName:TComboBox; ���� data:String)      *}
{*  õ����',' �����ϱ� : Func_FormatChangeStr( ���ڹ��ڿ�:String)             *}
{*  ���ڿ��� Ư�� ���� ��ȯ�ϱ� : Func_ChgString( InputStr, Old_Str, New_Str )*}
{*  �ѱۺ���� ©���������� :                                                 *}
{*      Func_GetKorCharPos(letter: string; WishCnt: Integer)                  *}
{*  �ѱۺ���� ©���������� :                                                 *}
{*  �ŷ��α� �����ϱ� : Func_LogExecute( SndrForm :TForm;                     *}
{*               sTaskID, sActivity, sUserID, sDataKey : string ) : Integer;  *}
{*  DBText�� 74column������ CRLF�߰��ϱ� :                                    *}
{*                      Func_AddCRLF( OrgText : String ):string ;             *}
{*                                                                            *}
{*  StringGrid�� ReSet�ϱ� : Proc_XStrReSet( StringGrid�̸� :TStringGrid)           *}
{*  StringGrid�� Vertical ScrollBar�����ϱ� :                                   *}
{*             Proc_XStrModify(StringGrid�̸�, ������ Colum Index)              *}
{*  Form�� Control Enable��Ű�� : Proc_EnableForm( FormName :TForm )          *}
{*  Form�� Control Disable��Ű�� : Proc_DisableForm( FormName :TForm )        *}
{*  StringGrid���� Ư��Row �����ϱ� : Proc_XStrDelete( StringGrid�̸�:TStringGrid)  *}
{*  DB�� Error Message�����ֱ� :                                              *}
{*      Proc_ShowDBError( E : EDBEngineError ; ����� �޼���:String )         *}
{*  Query�� ������ SYLKȭ�Ϸ� ������ EXCEL�� �����Ͽ� �о���� :              *}
{*      Proc_QueryToExcel( Query : TQuery, Title : String )                   *}
{*  WinExec�Լ� ���� ErrorCode Check :                                      *}
{*      Proc_ExecuteErrorChecking(iErrorCode : integer);                      *}
{*  Form�� ����̹��� �� Į�� Setting : Proc_FormColor( FormName :TForm )     *}
{*  Ÿ��ũ ���� �о����            : Proc_HelpExecute( sTaskID : string )  *}
{*----------------------------------------------------------------------------*}
{*----------------------------------------------------------------------------*}

unit Func_Lib;

interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, ComCtrls, Buttons, Db, DBTables, Registry,
 { Ustrgrid, NumEdit,} Grids, IniFiles, DBGrids, JPEG ;

Function  Func_GetExcelPath:String;
Function  Func_CheckSaUpJa(No:String):Boolean;
Function  Func_CheckJumin(No:String):Boolean;
Function  Func_CheckDate(Date:String):Boolean;
Function  Func_FindItem( Sender : TComboBox; Find_Str : String ) : Integer ;
Function  Func_FormatChangeStr(sValue: string): string;
Function  Func_ChgString(sValue: string; sOldStr: string; sNewStr: string ): string;
Function  Func_GetKorCharPos(letter: string; WishCnt: Integer): Integer;
Function  Func_LogExecute( SndrForm :TForm;
               sTaskID, sActivity, sUserID, sDataKey : string ) : Integer;
function  Func_AddCRLF( OrgText : String ):string ;

Procedure Proc_XStrReSet(TempXStr: TStringGrid) ;
Procedure Proc_XStrModify(TempXStr: TStringGrid; Col_Index : Integer);
Procedure Proc_DisableForm( SndrForm : TForm );
Procedure Proc_EnableForm( SndrForm : TForm );
Procedure Proc_XStrDelete(TempXStr : TStringGrid; Rowindex : Integer);
Procedure Proc_ShowDBError( SndErr : EDBEngineError ; UserErrMsg : String ) ;
Procedure Proc_QueryToExcel(QueryData : TQuery; sTitle : String);
Procedure Proc_ExecuteErrorChecking(iErrorCode : integer);
Procedure Proc_FormColor( SndrForm : TForm );
Procedure Proc_HelpExecute( sTaskID : string );
procedure Proc_gridtoexcel(Title : String; row : Integer; col : Integer; grid_list : TStringGrid; file_name : String);
procedure Proc_gridtoexcelfile(Title : String; row : Integer; col : Integer; grid_list : TStringGrid; file_name : String);
procedure Proc_excel(Title : String; file_name : String);
implementation

{*----------------------------------------------------------------------------*}
{*  EXCEL ��ġ��ġ �о���� : Func_GetExcelPath                               *}
{*  ��) ExcelPath := Func_GetExcelPath ;                                      *}
{*----------------------------------------------------------------------------*}
Function  Func_GetExcelPath:String;
Var
  Temp : Hkey;
  MyReg : TRegistry;
Begin
 MyReg:= TRegistry.Create;
 Temp:= HKEY_LOCAL_MACHINE;
 MyReg.RootKey:= Temp;
 if not MyReg.OpenKey('SoftWare', False) then
 begin
		Result := '';
    MyReg.Destroy ;
    exit;
 end;
 if not MyReg.OpenKey('Microsoft', False) then
 begin
		Result := '';
    MyReg.Destroy ;
    exit;
 end;
 if not MyReg.OpenKey('Windows', False) then
 begin
 		Result := '';
 		MyReg.Destroy ;
    exit;
 end;
 if not MyReg.OpenKey('CurrentVersion', False) then
 begin
 		Result := '';
 		MyReg.Destroy ;
    exit;
 end;
 if not MyReg.OpenKey('App Paths', False) then
 begin
 		Result := '';
 		MyReg.Destroy ;
    exit;
 end;

 if not MyReg.OpenKey('EXCEL.EXE', False) then
 begin
 		Result := '';
 		MyReg.Destroy ;
    exit;
 end;

 Result:= MyReg.ReadString('Path');

 MyReg.Destroy ;
End;

{*----------------------------------------------------------------------------*}
{*  ����ڹ�ȣ �˻� : Func_CheckSaUpJa (����ڹ�ȣ:String)                    *}
{*  ��) If Not Func_CheckJumin(edSaUpja.Text) then                            *}
{*        ShowMessage('����ڹ�ȣ�� �߸��Ǿ����ϴ�.');                        *}
{*----------------------------------------------------------------------------*}
Function  Func_CheckSaUpJa(No:String):Boolean;
Const
     Weight : Packed Array [1..8] of Integer =
              ( 1, 3, 7, 1, 3, 7, 1, 3 );
Var
   TempStr : String;
   Loop, Sum : Integer;
Begin
  Result:= True;
  Sum:= 0;
  For Loop:= 1 to 8 do
      Sum:= Sum+StrToInt(No[Loop])*Weight[Loop];
  Loop:= StrToInt(No[9])*5;
  Sum:= Sum + (Loop Div 10) + (Loop Mod 10);
  Sum:= Sum Mod 10;
  If Sum = 0 then TempStr:= '0'
  Else TempStr:= IntToStr(10-Sum);
  If TempStr <> No[10] then Result:= False;
End;

{*----------------------------------------------------------------------------*}
{*  �ֹε�Ϲ�ȣ �˻� : Func_CheckJumin (�ֹι�ȣ:String)                     *}
{*  ��) If Not Func_CheckJumin(edJumin.Text) then                             *}
{*        ShowMessage('�ֹι�ȣ�� �߸��Ǿ����ϴ�.');                          *}
{*----------------------------------------------------------------------------*}
Function  Func_CheckJumin(No:String):Boolean;
Const
     Weight : Packed Array [1..12] of Integer =
            ( 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 );
Var
   Loop, Sum, Rest : Integer;
Begin
  If Length(No) <> 13 then Result:= False
  Else
    Try
       Sum:= 0;
       For Loop:= 1 to  12 do
           Sum:= Sum + StrToInt(No[Loop])*Weight[Loop];
       Rest:= 11-(Sum Mod 11);
       If Rest = 11 then Rest:= 1;
       If Rest = 10 then Rest:= 0;
       Result:= Char(Rest+48) = No[13];
    Except
      Result:= False;
    End;
End;

{*----------------------------------------------------------------------------*}
{*  ��¥���� �˻� : Func_ChekcDate (��¥:String)                              *}
{*  ��) If Not Func_Checkdate(EdDate.Text) then                               *}
{*        ShowMessage('��¥�� �߸��Ǿ����ϴ�.');                              *}
{*----------------------------------------------------------------------------*}
Function Func_CheckDate( date : string ) : Boolean ;
begin
	DateSeparator := '/';

   { �Էµ� ��¥�� 8�ڸ����� �˻� }
   if (Length(date) <> 8) then
   begin
   	result := false;
       exit;
   end;

   {�Էµ� �ڷḦ Data������ ������ �� ������ �߻��ϸ� �߸��� ��¥�� �ν�}
   try
       StrToDate( copy(date,1,4) + '/' + copy(date, 5,2) + '/' + copy(date,7,2));
   except
   	on EConvertError do
       begin
       	result := False;
           exit ;
       end;
   end ;
   result := True;
end;

{*----------------------------------------------------------------------------*}
{* ComboBox�׸� ã�� : Func_FindItem(ComboBoxName:TComboBox; ã�� ���:String)*}
{* ��) FindIndex := Func_FindItem(CodeComboBox, 'ã������ڷ�')               *}
{*----------------------------------------------------------------------------*}
Function Func_FindItem( Sender : TComboBox; Find_Str : String ) : Integer ;
var
	intCount : Integer ;
begin
   for  intCount := 0 to Sender.Items.Count - 1 do
   	begin
        	if Sender.Items.Strings[ intCount ] = Find_Str then
           begin
              	result := intCount ;
               exit;
           end;
       end;
   result := -1 ;
end;

{*----------------------------------------------------------------------------*}
{* õ������ ',' �����ϱ�                                                      *}
{* ��) ReturnStr := Func_FormatChangeStr( InputStr ) ;                        *}
{*----------------------------------------------------------------------------*}
function Func_FormatChangeStr(sValue: string): string;
var
  sReturn : string;
  iCount  : Integer;
begin
   for iCount := 1 to Length(sValue) do
       if Copy(sValue,iCount,1) <> ',' then
          sReturn := sReturn + Copy(sValue,iCount,1);

   if sReturn = '' then
      Func_FormatChangeStr := '0'
   else
      Func_FormatChangeStr := sReturn;
end;

{*----------------------------------------------------------------------------*}
{* ���ڿ��� Ư�� ���� ��ȯ�ϱ�                                                *}
{* ��) ReturnStr := Func_ChgString( InputStr, Old_Str, New_Str ) ;            *}
{*----------------------------------------------------------------------------*}
function Func_ChgString(sValue: string; sOldStr: string; sNewStr: string): string;
var
	sTempStr,  sReturn : string;
  iPos  : Integer;
begin
	sTempStr := sValue;

	repeat
  	iPos := Pos( sOldStr, sTempStr);

    if iPos > 0 then
    begin
			sReturn := sReturn + Copy( sTempStr, 1, iPos - 1 ) + sNewStr;
      sTempStr := Copy( sTempStr, iPos + Length( sOldStr ),
      							Length( sTempStr ) - iPos )
    end
    else
    	sReturn := sReturn + sTempStr;

  until iPos = 0;

  Func_ChgString := sReturn;
end;

{*----------------------------------------------------------------------------*}
{*  �ѱۺ���� ©���������� :                                                 *}
{*      function Func_GetKorCharPos(letter: string; WishCnt: Integer)         *}
{*   ���ϰ� -1 : ��� ���ڿ��� ���̰� �ڸ��� ���ϴ� ���̺��� ����.            *}
{*        ��� : �ѱ��� ©���� �ʴ� ��ġ                                      *}
{*   ��)                                                                      *}
{*                                                                            *}
{*   // �ּҸ� �и�                                                           *}
{*   i := Func_GetKorCharPos(Query1.FieldByName('ADDR').AsString, 30);        *}
{*   if i = -1 then                                                           *}
{*   begin                                                                    *}
{*     QRL_addr1.Caption := Query1.FieldByName('ADDR').AsString;              *}
{*     QRL_addr2.Caption := '';                                               *}
{*   end                                                                      *}
{*   else                                                                     *}
{*   begin                                                                    *}
{*     QRL_addr1.Caption := Copy(Query1.FieldByName('ADDR').AsString,1,i);    *}
{*     QRL_addr2.Caption := Copy(Query1.FieldByName('ADDR').AsString,i+1,40); *}
{*   end;                                                                     *}
{*----------------------------------------------------------------------------*}
Function Func_GetKorCharPos(letter: string; WishCnt: Integer): Integer;
var
	i, msb: integer;
begin
	if Length(letter) <= WishCnt then
  begin
  	Result := -1;
    Exit;
  end;

  msb := 0;
  for i := 1 to WishCnt do
  	if (Integer(letter[i]) and Integer($80)) = Integer($80) then
    	Inc(msb);
{*  '$80'�ΰ��� ¦�����̸� �ϼ��� �ѱ۹���                                     }
 	if (msb mod 2) = 0 then
  	Result := WishCnt
  else
   	Result := WishCnt - 1;
end;

{*----------------------------------------------------------------------------*}
{*  �ŷ��α� �����ϱ� : Func_LogExecute( SndrForm :TForm;                     *}
{*               sTaskID, sActivity, sUserID, sDataKey : string ) : Integer;  *}
{*----------------------------------------------------------------------------*}
Function  Func_LogExecute( SndrForm :TForm;
               sTaskID, sActivity, sUserID, sDataKey : string ) : Integer;
var
  spUserLog : TStoredProc;
  //aMsg : array[0..128] of char;
begin
  if (sTaskID = '') or (sActivity = '') or (sUserID = '') or (sDataKey = '') then
  begin
    Result := 1;
    Exit;
  end;

  spUserLog := TStoredProc.Create(SndrForm);
  spUserLog.Active := False;
  spUserLog.DatabaseName   := 'Database1';
  spUserLog.StoredProcName := 'PSBADB.dbo.proc_UserLog;1';

  spUserLog.Params.CreateParam( ftString, '@TASK_ID',  ptInput );
  spUserLog.Params.CreateParam( ftString, '@ACT_GB',   ptInput );
  spUserLog.Params.CreateParam( ftString, '@USER_ID',  ptInput );
  spUserLog.Params.CreateParam( ftString, '@DATA_KEY', ptInput );
  spUserLog.Params.CreateParam( ftInteger,'Result',    ptResult);

	with spUserLog do
  begin
    if not Prepared then
       Prepare;
    Close;
    try
      ParamByName('@TASK_ID' ).AsString := sTaskID;
      ParamByName('@ACT_GB'  ).AsString := sActivity;
      ParamByName('@USER_ID' ).AsString := sUserID;
      ParamByName('@DATA_KEY').AsString := sDataKey;
      ExecProc;
    except on E:EDBEngineError do
      begin
        Result := 1;
        Exit;
      end;
    end;
  end;

  spUserLog.Destroy;
  Result := 0;
end;

{*----------------------------------------------------------------------------*}
{*  DBText�� 74column������ CRLF�߰��ϱ� :                                    *}
{*                      Func_AddCRLF( OrgText : String ):string ;             *}
{*----------------------------------------------------------------------------*}
function  Func_AddCRLF( OrgText : String ):string ;
var
  i : Integer;
  sCRLF : String;
begin
  sCRLF := #13+#10;
  Result := '';
  if Func_GetKorCharPos(OrgText, 74) = -1 then
  begin
    Result := OrgText;
    Exit;
  end   ;

  repeat

    i := Pos( #13#10, OrgText );
    if (i > 0) and (i < 75) then
    begin
      Result := Result + Copy(OrgText, 1, i + 1);
      OrgText := Copy( OrgText, i + 2, length(OrgText) - ( i + 2));
    end;

    i := Func_GetKorCharPos(OrgText, 74);
    if i = -1 then
    begin
      Result := Result + OrgText;
    end
    else
    begin
      Result := Result + Copy(OrgText, 1, i) + #13#10;
      OrgText := Copy( OrgText, i+1, length(OrgText) - 74);
    end;
  until ( i = -1 ) ;

end;

{*----------------------------------------------------------------------------*}
{*  StringGrid�� ReSet�ϱ� : Proc_XStrReSet( StringGrid�̸� : TStringGrid)          *}
{*----------------------------------------------------------------------------*}
Procedure Proc_XStrReSet(TempXStr: TStringGrid);
var
	iRow, iCol : Integer ;
begin
  for iRow := TempXStr.FixedRows to TempXStr.RowCount -  TempXStr.FixedRows do
	  for iCol := TempXStr.FixedCols to TempXStr.ColCount -  TempXStr.FixedCols do
  		TempXStr.Cells[iCol,iRow] := '';

	TempXStr.RowCount := TempXStr.FixedRows + 1;
end;

{*----------------------------------------------------------------------------*}
{*  StringGrid���� Ư��Row �����ϱ� : Proc_XStrDelete( StringGrid�̸�:TStringGrid)  *}
{*----------------------------------------------------------------------------*}
Procedure Proc_XStrDelete(TempXStr : TStringGrid; Rowindex : Integer);
var
	iRow, iCol : Integer ;
begin
	for iRow := RowIndex to TempXStr.RowCount - 1 do
		for iCol := 0 to TempXStr.ColCount - 1 do
    	if ( iRow < TempXStr.RowCount - 1 ) then
	    	TempXStr.Cells[ iCol, iRow ] := TempXStr.Cells[ iCol, iRow + 1 ]
      else
	    	TempXStr.Cells[ iCol, iRow ] := '';

  if TempXStr.RowCount = TempXStr.FixedRows + 1 then
		for iCol := 0 to TempXStr.ColCount - 1 do
    	TempXStr.Cells[ iCol, TempXStr.FixedRows + 1 ] := ''
  else
		TempXStr.RowCount := TempXStr.RowCount - 1;
end;

{*----------------------------------------------------------------------------*}
{*  StringGrid�� Vertical ScrollBar�����ϱ� :                                   *}
{*       Proc_XStrModify(StringGrid�̸�:TStringGrid, ������ Colum Index:Integer)  *}
{*----------------------------------------------------------------------------*}
Procedure Proc_XStrModify(TempXStr: TStringGrid; Col_Index : Integer);
var
	iCol, iRow : Integer ;
  iSize1, iSize2 : Integer ;
begin
	iSize1 := 0;
  iSize2 := 0;
  for iRow := 0 to TempXStr.RowCount - 1 do
  	iSize1 := iSize1 + TempXStr.RowHeights[ iRow ] + TempXStr.GridLineWidth ;

  for iCol := 0 to Col_Index - 1 do
  	iSize2 := iSize2 + TempXStr.ColWidths[ iCol ] + TempXStr.GridLineWidth;

  if iSize1 > TempXStr.Height then
  begin
		TempXStr.ColWidths[ Col_Index ] := TempXStr.Width - iSize2 - 22;
  	exit;
  end;

{  if ( iSize2 + TempXStr.ColWidths[ Col_Index ] ) = TempXStr.Width then
  	exit ; }

	TempXStr.ColWidths[ Col_Index ] := TempXStr.Width - iSize2 - 6 ;
end;

{*----------------------------------------------------------------------------*}
{*  Form�� Control Disable��Ű�� : Proc_DisableForm( FormName :TForm )        *}
{*----------------------------------------------------------------------------*}
Procedure Proc_DisableForm( SndrForm : TForm );
var
	iCount : Integer ;
begin
	SndrForm.Cursor := crHourGlass;
	SndrForm.Hint := '';
	for iCount := 0 to SndrForm.ComponentCount - 1do
  begin
  	if SndrForm.Components[ iCount ] is TControl then
      	TWinControl( SndrForm.Components[ iCount ]).Cursor := crHourGlass;
  	if (SndrForm.Components[ iCount ] is TWinControl) then
    begin
    	if TWinControl( SndrForm.Components[ iCount ]).Enabled then
				TWinControl( SndrForm.Components[ iCount ]).Enabled := False
      else
       	SndrForm.Hint := SndrForm.Hint + '[' +
        				TWinControl( SndrForm.Components[ iCount ]).Name + '],'
    end;
  end;

end;

{*----------------------------------------------------------------------------*}
{*  Form�� Control Enable��Ű�� : Proc_EnableForm( FormName :TForm )          *}
{*----------------------------------------------------------------------------*}
Procedure Proc_EnableForm( SndrForm : TForm );
var
	iCount : Integer ;
begin

	SndrForm.Cursor := crDefault;

	for iCount := 0 to SndrForm.ComponentCount - 1do
  begin
  	if SndrForm.Components[ iCount ] is TControl   then
    	begin
				TWinControl( SndrForm.Components[ iCount ]).Enabled := True ;
      	if SndrForm.Components[ iCount ] is TButtonControl   then
	      	TWinControl( SndrForm.Components[ iCount ]).Cursor := crHandPoint
        else
	      	TWinControl( SndrForm.Components[ iCount ]).Cursor := crDefault;

        if Pos( '[' + TWinControl( SndrForm.Components[ iCount ]).Name + ']', SndrForm.Hint ) > 0 then
					TWinControl( SndrForm.Components[ iCount ]).Enabled := False ;
      end;
  end;
	SndrForm.Hint := '';
end;

{*----------------------------------------------------------------------------*}
{*  DB�� Error Message�����ֱ� :                                              *}
{*        Proc_ShowDBError( E : EDBEngineError ; ����� �޼���:String )       *}
{*----------------------------------------------------------------------------*}
Procedure Proc_ShowDBError( SndErr : EDBEngineError; UserErrMsg : String ) ;
var
	bDupError : Boolean;
  sErrMsg : String ;
  iCount : Integer ;
begin
 	bDupError := False ;
	sErrMsg := UserErrMsg + ':';
	for iCount := 0 to SndErr.ErrorCount - 1 do
		begin
    	sErrMsg := sErrMsg + #13 + SndErr.Errors[iCount].message ;
{*    SYBASE DB�� Duplicate Error Code 2601�� Check��                         *}
      if SndErr.Errors[iCount].NativeError = 2601 then
      	bDupError := True ;
		end;
	if bDupError then
  	sErrMsg := UserErrMsg + ':' + #13 +
    					'�Է��ϰ��� �ϴ� KEY���� �̹� ���̺� �����մϴ�.';

	Application.MessageBox( PChar(sErrMsg) , '����', MB_ICONHAND)
end;


{*----------------------------------------------------------------------------*}
{*  Query�� ������ SYLKȭ�Ϸ� ������ EXCEL�� �����Ͽ� �о����                *}
{*      Proc_QueryToExcel( Query : TQuery, Title : String )                   *}
{*  ��)  with Query1 do                                                       *}
{*       begin                                                                *}
{*         if not Prepared then                                               *}
{*           Prepare;                                                         *}
{*         Close;                                                             *}
{*       try                                                                  *}
{*         Open;                                                              *}
{*       except on E:EDBEngineError do                                        *}
{*         begin                                                              *}
{*           Proc_ShowDBError(E, '�ڷ� �˻��� ������ �߻��Ͽ����ϴ�');        *}
{*         end;                                                               *}
{*       end;                                                                 *}
{*                                                                            *}
{*	     if RecordCount > 0 then                                              *}
{*       begin                                                                *}
{*         Proc_QueryToExcel( Query1, '���ϴ� ����' )                         *}
{*----------------------------------------------------------------------------*}
Procedure Proc_QueryToExcel(QueryData : TQuery; sTitle : String);
var
	iCount, iRow : Integer ;
  aNstr: array[0..128] of char;
  OutFile : TextFile ;
  sFileName, StrWinDir, sNowTime : String;
  Windir: array[0..144] of char;
begin

	if Func_GetExcelPath = '' then
  begin
		Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
    exit;
  end;

  if Not FileExists(  Func_GetExcelPath + '\EXCEL.EXE' ) then
  begin
		Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
    exit;
  end;


{*  Windows ���丮�� ã�� Temp���丮�� �ӽ�ȭ���� ����                    *}
{*  Excel���� �о���̱� ���� SYLK(Symbolic Link)�� �̿��Ѵ�                  *}
  GetWindowsDirectory(Windir, 144);
  StrWindir := strpas(Windir);
  DateTimeToString( sNowTime, 'hhmm', Now );
  sFileName := StrWindir + '\TEMP\' + QueryData.Name + '.SLK';
  AssignFile( OutFile, sFileName );
  ReWrite( OutFile );
{*  SYLK Format�� ����� �����                                               *}
	Writeln( OutFile, 'ID;PWXL;N;E' );
{*  Title(����)�� ȭ�Ͽ� �����                                               *}
 	Writeln( OutFile, 'C;Y1;X1;K' + '"' + sTitle + '"' );
{*  Excel Data ��ȯ�� ����κ��� ����� (���̺��� �÷����� �̿�)              *}
	with QueryData do
  begin
	 	Writeln( OutFile, 'C;Y2;X1;K' + '"' + Fields[ 0 ].FieldName + '"' );
    for iCount := 1 to FieldCount - 1 do
    begin
		 	Writeln( OutFile, 'C;X' + IntToStr(iCount + 1) + ';K"' + Fields[ iCount ].FieldName + '"' );
    end;

		First;
    iRow := 3;
    while not Eof do
    begin
     Writeln( OutFile, 'C;Y' + IntToStr(iRow) + ';X1;K' + '"' + Fields[ 0 ].AsString + '"' );
     for iCount := 1 to FieldCount - 1 do
     begin
      case Fields[ iCount ].DataType of
      ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency :
      begin
       Writeln( OutFile, 'C;X' + IntToStr(iCount + 1) + ';K' + Fields[ iCount ].AsString );
      end;
      else
       Writeln( OutFile, 'C;X' + IntToStr(iCount + 1) + ';K"' +	Fields[ iCount ].AsString + '"' );
     end;
    end;
    Inc(iRow);
    Next;
    end;
  end;
{*  ȭ���� Close��                                                            *}
	Writeln( OutFile, 'E' );
	CloseFile( OutFile );

{* EXCEL Path�� ã�� �ӽ�ȭ�ϰ� �Բ� ������                                   *}
  strPcopy(aNstr, Func_GetExcelPath + '\EXCEL.EXE ' + sFileName );
	Proc_ExecuteErrorChecking(WinExec( aNstr, SW_SHOWNORMAL ));

end;

{*----------------------------------------------------------------------------*}
{*  WinExec�Լ� ���� ErrorCode Check :                                      *}
{*      Proc_ExecuteErrorChecking(iErrorCode : integer);                      *}
{*  ��) Proc_ExecuteErrorChecking(WinExec(����ȭ���̸�, SW_SHOWNORMAL ));     *}
{*----------------------------------------------------------------------------*}
Procedure Proc_ExecuteErrorChecking(iErrorCode : integer);
begin
   case iErrorCode of
     2: Messagedlg('ȭ���� ã������ �����ϴ�.',mterror,[mbok],0);
     3: Messagedlg('��θ��� ã������ �����ϴ�.',mterror,[mbok],0);
     8: Messagedlg('�ش� ���α׷��� �����ϱ� ���� �޸𸮰� �����մϴ�.'
     								,mterror,[mbok],0);
    10: Messagedlg('�������� ������ ���� �ʽ��ϴ�.',mterror,[mbok],0);
     0,5,6,11,12,13,14,15,16,19,20,21:
       Messagedlg('�������������α׷� ������ �ش� ���α׷��� �������' +
       					'�ʽ��ϴ�.',mterror,[mbok],0);
   end;
end;
{*----------------------------------------------------------------------------*}
{*  Form�� Color �����ϱ� : Proc_FormColor( FormName :TForm )                 *}
{*----------------------------------------------------------------------------*}
Procedure Proc_FormColor( SndrForm : TForm );
var
  haeolIni : TIniFile;
  aWinDir   : array[0..128] of char;
  iaColor   : array[0..9]   of integer;
  sWinDir, sTileImageDir : string;
  iCount,  iTagValue : integer;
  bImageYN : Bool;

begin
  { Windows Directory ã�� }
  GetWindowsDirectory(aWinDir,128);
  sWinDir := StrPas(aWinDir);

  {Pedsis.ini �о���� *}
  haeolIni := TIniFile.Create(sWinDir + '\Pedsis.Ini');

  With haeolIni do
  begin
    sTileImageDir := ReadString( 'FormColor','TileImage',   '');
    bImageYN      := ReadBool(   'FormColor','ImageYN',  False);
    iaColor[0]    := Readinteger('FormColor','BGColor',    12632256);
    iaColor[1]    := Readinteger('FormColor','Title',       4227072);
  	iaColor[2]    := Readinteger('FormColor','Cond_Panel',  4227072);
  	iaColor[3]    := Readinteger('FormColor','Cond_Item',   8495729);
  	iaColor[4]    := Readinteger('FormColor','Input_Panel', 4227072);
  	iaColor[5]    := Readinteger('FormColor','Input_Item',  8495729);
  	iaColor[6]    := Readinteger('FormColor','Query_Panel', 4227072);
  	iaColor[7]    := Readinteger('FormColor','Query_Item',  8495729);
  	iaColor[8]    := Readinteger('FormColor','Sum_Item',    8495729);
    Free;
  end;

  SndrForm.Color := iaColor[0];
	for iCount := 0 to SndrForm.ComponentCount - 1 do
  begin
    { ��� �̹���(Image) ó��}
  	{if SndrForm.Components[ iCount ] is TTileImage then
	    begin
        if bImageYN = True then
         	TTileImage( SndrForm.Components[iCount]).Picture.LoadFromFile(sTileImageDir)
        else
        	TTileImage( SndrForm.Components[iCount]).Visible := False;
      end

    { TPanel ���
  	else} if SndrForm.Components[ iCount ] is TPanel then
	    begin
        iTagValue := TPanel(SndrForm.Components[ iCount ]).Tag;
        case iTagValue of
        	10 : TPanel( SndrForm.Components[iCount]).Color := iaColor[1];
          20 : TPanel( SndrForm.Components[iCount]).Color := iaColor[2];
          30 : TPanel( SndrForm.Components[iCount]).Color := iaColor[3];
          40 : TPanel( SndrForm.Components[iCount]).Color := iaColor[4];
          50 : TPanel( SndrForm.Components[iCount]).Color := iaColor[5];
          60 : TPanel( SndrForm.Components[iCount]).Color := iaColor[6];
          70 : TPanel( SndrForm.Components[iCount]).Color := iaColor[7];
          80 : TPanel( SndrForm.Components[iCount]).Color := iaColor[8];
        end;
      end

    { TStringGrid ��� }
  	else if SndrForm.Components[ iCount ] is TStringGrid then
	    begin
        iTagValue := TStringGrid(SndrForm.Components[ iCount ]).Tag;
        case iTagValue of
        	10 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[1];
          20 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[2];
          30 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[3];
          40 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[4];
          50 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[5];
          60 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[6];
          70 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[7];
          80 : TStringGrid( SndrForm.Components[iCount]).FixedColor := iaColor[8];
        end;
      end;
  end;
end;

{*----------------------------------------------------------------------------*}
{*  ���� �ҷ����� : Proc_HelpExecute( FormName :TForm )                     *}
{*----------------------------------------------------------------------------*}
Procedure Proc_HelpExecute( sTaskID : string );
var
  haeolIni : TIniFile;
  aWinDir   : array[0..128] of char;
  sWinDir, sAppPath  : string;
  intHandleOfWin : integer;

begin
  { Windows Directory ã�� }
  GetWindowsDirectory(aWinDir,128);
  sWinDir := StrPas(aWinDir);

  {haeol.ini �о���� *}
  haeolIni := TIniFile.Create(sWinDir + '\haeol.ini');
  With haeolIni do
  begin
    sAppPath := ReadString('Path', 'Application','');
    Free;
  end;

  if sAppPath = '' then
    begin
			Application.MessageBox('�������α׷��� ��ΰ� �߸��Ǿ����ϴ�..... ȯ�漳���� Ȯ���Ͻʽÿ�','����', MB_ICONHAND);
    	Exit;
  	end;

   intHandleOfWin := FindWindow('TCSBQ2100Form',nil);
   if intHandleOfWin = 0 then
      begin
         strPcopy(aWinDir, sAppPath + '\Basic\CSBQ21.exe ' + sTaskID );
         Proc_ExecuteErrorChecking(WinExec(aWinDir,SW_SHOWNORMAL))
      end
   else
      begin
         SetForegroundWindow(intHandleOfWin);
      end;
end;


// grid���� excel�� ���� ������
procedure Proc_gridtoexcel(Title : String; row : Integer; col : Integer; grid_list : TStringGrid; file_name : String);
var
 iCount, iRow : Integer ;
 aNstr: array[0..128] of char;
 OutFile : TextFile ;
 sFileName, StrWinDir, sNowTime : String;
 Windir: array[0..144] of char;

 count, i, j : integer;

begin
  if Func_GetExcelPath = '' then
  begin
   Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
   exit;
  end;

  if Not FileExists(  Func_GetExcelPath + '\EXCEL.EXE' ) then
  begin
   Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
   exit;
  end;

{*  Windows ���丮�� ã�� Temp���丮�� �ӽ�ȭ���� ����                    *}
{*  Excel���� �о���̱� ���� SYLK(Symbolic Link)�� �̿��Ѵ�                  *}

  GetWindowsDirectory(Windir, 144);
  StrWindir := strpas(Windir);
  DateTimeToString( sNowTime, 'hhmm', Now );
  sFileName := StrWindir + '\TEMP\' + file_name + '.SLK';
  AssignFile( OutFile, sFileName );
  ReWrite( OutFile );
{*  SYLK Format�� ����� �����                                               *}
  Writeln( OutFile, 'ID;PWXL;N;E' );
{*  Title(����)�� ȭ�Ͽ� �����                                               *}
  Writeln( OutFile, 'C;Y1;X1;K"' + Title + '"' );
{*  Excel Data ��ȯ�� ����κ��� ����� (���̺��� �÷����� �̿�)              *}


 irow := 4;
 for i:= 0 to row-1 do
 begin
  for j := 0 to col-1 do
  begin
    Writeln( OutFile, 'C;Y' + IntToStr(iRow) + ';X' + inttostr(j+1) + ';K"' + Grid_list.Cells[j,i] + '"' );
  end;
  inc(irow);
//  next;
 end;

{*  ȭ���� Close��                                                            *}
	Writeln( OutFile, 'E' );
	CloseFile( OutFile );

{* EXCEL Path�� ã�� �ӽ�ȭ�ϰ� �Բ� ������                                   *}
  strPcopy(aNstr, Func_GetExcelPath + '\EXCEL.EXE ' + sFileName );
  Proc_ExecuteErrorChecking(WinExec( aNstr, SW_SHOWNORMAL ));
end;

// grid���� excelfile�� ���� ������
procedure Proc_gridtoexcelfile(Title : String; row : Integer; col : Integer; grid_list : TStringGrid; file_name : String);
var
 iCount, iRow : Integer ;
 aNstr: array[0..128] of char;
 OutFile : TextFile ;
 sFileName, StrWinDir, sNowTime : String;
 Windir: array[0..144] of char;

 count, i, j : integer;

begin
  if Func_GetExcelPath = '' then
  begin
   Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
   exit;
  end;

  if Not FileExists(  Func_GetExcelPath + '\EXCEL.EXE' ) then
  begin
   Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
   exit;
  end;

{*  Windows ���丮�� ã�� Temp���丮�� �ӽ�ȭ���� ����                    *}
{*  Excel���� �о���̱� ���� SYLK(Symbolic Link)�� �̿��Ѵ�                  *}

  GetWindowsDirectory(Windir, 144);
  StrWindir := strpas(Windir);
  DateTimeToString( sNowTime, 'hhmm', Now );
  sFileName := StrWindir + '\TEMP\' + file_name + '.SLK';
  AssignFile( OutFile, sFileName );
  ReWrite( OutFile );
{*  SYLK Format�� ����� �����                                               *}
  Writeln( OutFile, 'ID;PWXL;N;E' );
{*  Title(����)�� ȭ�Ͽ� �����                                               *}
  Writeln( OutFile, 'C;Y1;X1;K"' + Title + '"' );
{*  Excel Data ��ȯ�� ����κ��� ����� (���̺��� �÷����� �̿�)              *}


 irow := 4;
 for i:= 0 to row-1 do
 begin
  for j := 0 to col-1 do
  begin
  Writeln( OutFile, 'C;Y' + IntToStr(iRow) + ';X' + inttostr(j+1) + ';K"' + Grid_list.Cells[j,i] + '"' );
  end;
  inc(irow);
//  next;
 end;

{*  ȭ���� Close��                                                            *}
	Writeln( OutFile, 'E' );
	CloseFile( OutFile );
end;

// excel run
procedure Proc_excel(Title : String; file_name : String);
var
 iCount, iRow : Integer ;
 aNstr: array[0..128] of char;
 OutFile : TextFile ;
 sFileName, StrWinDir, sNowTime : String;
 Windir: array[0..144] of char;

 count, i, j : integer;

begin
  if Func_GetExcelPath = '' then
  begin
   Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
   exit;
  end;

  if Not FileExists(  Func_GetExcelPath + '\EXCEL.EXE' ) then
  begin
   Application.MessageBox( 'EXCEL ���α׷��� �������� �ʽ��ϴ�.' , '����', MB_ICONHAND);
   exit;
  end;


{*  Windows ���丮�� ã�� Temp���丮�� �ӽ�ȭ���� ����                    *}
{*  Excel���� �о���̱� ���� SYLK(Symbolic Link)�� �̿��Ѵ�                  *}

  GetWindowsDirectory(Windir, 144);
  StrWindir := strpas(Windir);
  DateTimeToString( sNowTime, 'hhmm', Now );
  sFileName := StrWindir + '\TEMP\' + file_name + '.SLK';
{* EXCEL Path�� ã�� �ӽ�ȭ�ϰ� �Բ� ������                                   *}
  strPcopy(aNstr, Func_GetExcelPath + '\EXCEL.EXE ' + sFileName );
  Proc_ExecuteErrorChecking(WinExec( aNstr, SW_SHOWNORMAL ));
end;

end.
///////////////////////////    The   End    ////////////////////////////////////
