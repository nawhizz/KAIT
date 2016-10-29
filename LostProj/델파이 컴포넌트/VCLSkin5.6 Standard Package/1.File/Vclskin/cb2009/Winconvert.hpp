// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winconvert.pas' rev: 20.00

#ifndef WinconvertHPP
#define WinconvertHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winconvert
{
//-- type declarations -------------------------------------------------------
typedef short Int16;

class DELPHICLASS ElzhException;
class PASCALIMPLEMENTATION ElzhException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ElzhException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ElzhException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ElzhException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ElzhException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ElzhException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ElzhException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ElzhException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ElzhException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ElzhException(void) { }
	
};


typedef void __fastcall (__closure *TWriteProc)(void *DTA, System::Word NBytes, System::Word &Bytes_Put);

typedef TWriteProc PutBytesProc;

typedef void __fastcall (__closure *TReadProc)(void *DTA, System::Word NBytes, System::Word &Bytes_Got);

typedef TReadProc GetBytesProc;

typedef StaticArray<System::Word, 628> Freqtype;

typedef Freqtype *FreqPtr;

typedef StaticArray<short, 941> PntrType;

typedef PntrType *pntrPtr;

typedef StaticArray<short, 627> SonType;

typedef SonType *SonPtr;

typedef StaticArray<System::Byte, 4155> TextBufType;

typedef TextBufType *TBufPtr;

typedef StaticArray<short, 4097> WordRay;

typedef WordRay *WordRayPtr;

typedef StaticArray<short, 4353> BWordRay;

typedef BWordRay *BWordRayPtr;

class DELPHICLASS TLZH;
class PASCALIMPLEMENTATION TLZH : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Word code;
	System::Word len;
	void __fastcall InitTree(void);
	void __fastcall InsertNode(short r);
	void __fastcall DeleteNode(short p);
	short __fastcall GetBit(TReadProc GetBytes);
	short __fastcall GetByte(TReadProc GetBytes);
	void __fastcall update(short c);
	void __fastcall StartHuff(void);
	void __fastcall Putcode(short l, System::Word c, TWriteProc PutBytes);
	void __fastcall reconst(void);
	void __fastcall EncodeChar(System::Word c, TWriteProc PutBytes);
	void __fastcall EncodePosition(System::Word c, TWriteProc PutBytes);
	void __fastcall EncodeEnd(TWriteProc PutBytes);
	short __fastcall DecodeChar(TReadProc GetBytes);
	System::Word __fastcall DecodePosition(TReadProc GetBytes);
	void __fastcall InitLZH(void);
	void __fastcall EndLZH(void);
	
public:
	Classes::TStream* StreamIn;
	Classes::TStream* StreamOut;
	System::Word getbuf;
	System::Byte getlen;
	System::Byte putlen;
	System::Word putbuf;
	int textsize;
	int codesize;
	int printcount;
	short match_position;
	short match_length;
	TextBufType *text_buf;
	WordRay *lson;
	WordRay *dad;
	BWordRay *rson;
	Freqtype *freq;
	PntrType *prnt;
	SonType *son;
	void __fastcall LZHPack(int &Bytes_Written, TReadProc GetBytes, TWriteProc PutBytes);
	void __fastcall LZHUnpack(int TextSize, TReadProc GetBytes, TWriteProc PutBytes);
	void __fastcall GetBlockStream(void *DTA, System::Word NBytes, System::Word &Bytes_Got);
	void __fastcall PutBlockStream(void *DTA, System::Word NBytes, System::Word &Bytes_Got);
public:
	/* TObject.Create */ inline __fastcall TLZH(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLZH(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt EXIT_OK = 0x0;
static const ShortInt EXIT_FAILED = 0x1;
static const Word N = 0x1000;
static const ShortInt F = 0x3c;
static const ShortInt THRESHOLD = 0x2;
static const Word NUL = 0x1000;
static const Word N_CHAR = 0x13a;
static const Word T = 0x273;
static const Word R = 0x272;
static const Word MAX_FREQ = 0x8000;
extern PACKAGE StaticArray<System::Byte, 64> p_len;
extern PACKAGE StaticArray<System::Byte, 64> p_code;
extern PACKAGE StaticArray<System::Byte, 256> d_code;
extern PACKAGE StaticArray<System::Byte, 256> d_len;

}	/* namespace Winconvert */
using namespace Winconvert;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WinconvertHPP
