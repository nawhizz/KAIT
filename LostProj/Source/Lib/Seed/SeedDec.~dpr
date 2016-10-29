library SeedDec;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  system,
  windows,
  Classes,
  dialogs,
  Seed in 'Seed.pas';

const
  KEY_LEN = 16;
{$R *.res}

function SeedDecryptA(SeedKey, DecData : Pchar) : Pchar; stdcall;
var
    user_key        : array[0  ..16] of char;
    pdwRoundKey     : Array[0   ..31]               of LongWord;
    pbData          : Array[0 ..KEY_LEN*2]          of BYTE;
    u_key           : Array[0 ..KEY_LEN  ]          of BYTE;
    i               : Integer;
    iStrlen         : integer;
    c               : string;
    myData          : Array[0 ..4095 * 10] of char;
    myCol           : Array[0 ..2 ]        of char;
    u_Col           : Array[0 ..0 ]        of char;
    idx,j,k, out_len  : integer;
    out_data        : String;
begin
    result := Pchar('');

    try
      FillChar(pbData         , sizeof(pbData)        , #0);
      FillChar(u_key          , sizeof(u_key)         , #0);
      FillChar(pdwRoundKey    , sizeof(pdwRoundKey)   , #0);
      FillChar(myData         , sizeof(myData)        , #0);


      if strlen(user_key) <=0 then
      begin
          FillChar( user_key    , sizeof(user_key)   , #0);
          strpCopy( user_key    , (SeedKey) );
      end;

      for i := 0 to KEY_LEN -1 do u_key[i]       := Byte(user_key[I]);

      FillChar        (pdwRoundKey    , sizeof(pdwRoundKey)   , #0);
      SeedEncRoundKey (pdwRoundKey    , u_key );

      iStrlen := strlen(DecData);

      i   := 0;
      j   := 0;
      idx := 0;
      c   := '';
      k   := 0;

      while true do
      begin
          if i >= iStrlen then break;

          FillChar(myCol    , sizeof(myCol)   , #0);
          FillChar(u_Col    , sizeof(u_Col)   , #0);

          for j:= 0 to 1 do
          begin
              myCol[j] := DecData[i];
              i := i +1;
          end;

          HexToBin( myCol, u_Col, sizeof(u_Col) );

          pbData[idx] := BYTE(u_Col);
          if ( (i mod 32 ) = 0 ) then
          begin

              SeedDecrypt(pbData, pdwRoundKey);

              for k := 0 to KEY_LEN -1 do c    := c + IntToHex(pbData[k], 2);

              idx := 0;
              FillChar(pbData         , sizeof(pbData)        , #0);
              continue;
          end;

          idx := idx +1;

      end;

      if idx >=1 then
      begin
          SeedDecrypt(pbData, pdwRoundKey);

          for i := 0 to idx -1 do     c := c + IntToHex(pbData[i], 2);
        
      end;

      HexToBin( pchar(c), myData, sizeof(myData));

      out_len := strlen(myData);

     // SetLength(out_data, Out_len);
    //  CopyMemory(@out_data[1], @myData[0], Out_len);


      result := myData;
    except
        on E: Exception do
        begin
            result      := '';
        end;
    end;
end;

Function DataDecrypt(seedKey, sData : Pchar) : Pchar; stdcall;
begin
  Result := SeedDecryptA((SeedKey), (sData));

end;

exports
  DataDecrypt;

begin
end.
 