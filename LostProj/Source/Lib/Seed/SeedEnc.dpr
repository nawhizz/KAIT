library SeedEnc;

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
  Classes,
  dialogs,
  Seed in 'Seed.pas';

const
  KEY_LEN = 16;
{$R *.res}

function SeedEncryptA(SeedKey, EncData : Pchar) : Pchar; stdcall;
var
    user_key        : array[0  ..16] of char;
    pdwRoundKey     : Array[0   ..31] of LongWord;
    pbData          : Array[0 ..KEY_LEN     ] of BYTE;
    u_key           : Array[0 ..KEY_LEN     ] of BYTE;
    i,j             : Integer;
    iStrlen         : integer;
    c               : string;
    idx             : integer;
    lErrMsg         : array [0.. 128] of char;
    iLen : Integer;
begin
    result := PAnsiChar('');

    try
      FillChar(pbData         , sizeof(pbData)        , #0);
      FillChar(u_key          , sizeof(u_key)         , #0);
      FillChar(pdwRoundKey    , sizeof(pdwRoundKey)   , #0);

      if strlen(user_key) <=0 then
      begin
          FillChar(user_key    , sizeof(user_key)   , #0);
          strpCopy(user_key, pchar(SeedKey) );
      end;

      FillChar(pdwRoundKey    , sizeof(pdwRoundKey)   , #0);

      iStrlen := strLen(EncData);

      for i := 0 to KEY_LEN -1  do u_key[i]                := Byte(user_key [i]);

      SeedEncRoundKey(pdwRoundKey, u_key );

      idx := 0;
      c   := '';
      for i := 0 to iStrlen-1 do
      begin

          pbData[idx]          := Byte(EncData[i]);

          if idx = KEY_LEN -1 then
          begin
              SeedEncrypt(pbData, pdwRoundKey);

              for j := 0 to idx do c    := c + IntToHex(pbData[j], 2);

              FillChar(pbData         , sizeof(pbData)        , #0);

              idx := 0;
              continue;

          end;

          idx := idx + 1;

      end;
      if idx >= 1 then
      begin
    
          SeedEncrypt(pbData, pdwRoundKey);

          for i := 0 to KEY_LEN -1 do c    := c + IntToHex(pbData[i], 2);

      end;
    Result    := Pchar(c);
    except
        on E: Exception do
        begin
            result   := '';
        end;
    end;

end;

Function DataEncrypt(seedKey, sData : Pchar) : Pchar; stdcall;
begin

  Result := (SeedEncryptA((SeedKey), (sData)));
end;

exports
  DataEncrypt;

begin
end.
 