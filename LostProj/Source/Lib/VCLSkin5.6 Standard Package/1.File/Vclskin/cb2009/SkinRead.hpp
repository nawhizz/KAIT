// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Skinread.pas' rev: 20.00

#ifndef SkinreadHPP
#define SkinreadHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Filectrl.hpp>	// Pascal unit
#include <Winconvert.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Skinread
{
//-- type declarations -------------------------------------------------------
struct TSkinHeader
{
	
public:
	int Version;
	int DirLen;
	int U1;
	int U2;
};


class DELPHICLASS TSkinReader;
class PASCALIMPLEMENTATION TSkinReader : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Classes::TStringList* Dir;
	int dirlen;
	int Num;
	StaticArray<int, 1001> sizes;
	Classes::TMemoryStream* ms;
	TSkinHeader header;
	TSkinHeader header2;
	__fastcall TSkinReader(void);
	__fastcall virtual ~TSkinReader(void);
	bool __fastcall loadfromfile(const System::UnicodeString aname);
	void __fastcall readfile(System::UnicodeString aname, Classes::TMemoryStream* m);
	void __fastcall readIni(const System::UnicodeString aname, Classes::TMemoryStream* m, System::UnicodeString &fname);
	void __fastcall Decompress(Classes::TStream* source, Classes::TStream* Dest);
	bool __fastcall Loadfromstream(Classes::TMemoryStream* r2);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Skinread */
using namespace Skinread;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SkinreadHPP
