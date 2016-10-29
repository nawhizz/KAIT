// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskinini.pas' rev: 20.00

#ifndef WinskininiHPP
#define WinskininiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Winconvert.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskinini
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TQuickIni;
class PASCALIMPLEMENTATION TQuickIni : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAuto;
	System::UnicodeString FFileName;
	Classes::TStrings* FIniFile;
	System::UnicodeString __fastcall GetName(const System::UnicodeString Line);
	System::UnicodeString __fastcall GetValue(const System::UnicodeString Line, const System::UnicodeString Name);
	int __fastcall GetSectionIndex(const System::UnicodeString Section);
	bool __fastcall IsSection(const System::UnicodeString Line);
	void __fastcall SetFileName(System::UnicodeString Value);
	void __fastcall SetIniFile(Classes::TStrings* Value);
	
protected:
	Classes::TStrings* FSections;
	void __fastcall Compress(Classes::TStream* source, Classes::TStream* dest);
	void __fastcall Decompress(Classes::TStream* source, Classes::TStream* Dest);
	
public:
	__fastcall TQuickIni(void);
	__fastcall virtual ~TQuickIni(void);
	void __fastcall LoadFromFile(System::UnicodeString aname);
	void __fastcall SaveToFile(System::UnicodeString aname);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromZip(System::UnicodeString aname);
	void __fastcall SavetoZip(System::UnicodeString aname);
	void __fastcall DeleteKey(const System::UnicodeString Section, const System::UnicodeString Ident);
	void __fastcall EraseSection(const System::UnicodeString Section);
	bool __fastcall ReadBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Default);
	int __fastcall ReadInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Default);
	void __fastcall ReadSection(const System::AnsiString Section, Classes::TStrings* Strings);
	void __fastcall ReadSections(Classes::TStrings* Strings);
	void __fastcall ReadSectionValues(const System::UnicodeString Section, Classes::TStrings* Strings);
	System::AnsiString __fastcall ReadString(const System::AnsiString Section, const System::AnsiString Ident, System::AnsiString Default);
	void __fastcall RebuildSections(void);
	void __fastcall WriteBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Value);
	void __fastcall WriteInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Value);
	void __fastcall WriteString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString Value);
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
	__property bool AutoSaveLoad = {read=FAuto, write=FAuto, nodefault};
	__property Classes::TStrings* IniFile = {read=FIniFile, write=SetIniFile};
	void __fastcall Clear(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Winskinini */
using namespace Winskinini;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WinskininiHPP
