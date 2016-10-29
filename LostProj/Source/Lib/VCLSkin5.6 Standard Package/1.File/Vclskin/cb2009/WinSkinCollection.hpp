// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskincollection.pas' rev: 20.00

#ifndef WinskincollectionHPP
#define WinskincollectionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskincollection
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSkinCollectionItem;
class PASCALIMPLEMENTATION TSkinCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	void __fastcall SetName(System::UnicodeString AName);
	int __fastcall GetDataSize(void);
	System::UnicodeString __fastcall GetData();
	void __fastcall SetData(const System::UnicodeString Value);
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteData(Classes::TStream* Stream);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName();
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	
public:
	Classes::TMemoryStream* FData;
	__fastcall virtual TSkinCollectionItem(Classes::TCollection* ACollection);
	__fastcall virtual ~TSkinCollectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
	void __fastcall LoadFromFile(System::UnicodeString value);
	void __fastcall CopyData(Classes::TMemoryStream* AStream);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString SkinData = {read=GetData, write=SetData, stored=false};
	__property int DataSize = {read=GetDataSize, nodefault};
};


class DELPHICLASS TSkinCollection;
class PASCALIMPLEMENTATION TSkinCollection : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	__fastcall TSkinCollection(Classes::TPersistent* AOwner);
	HIDESBASE TSkinCollectionItem* __fastcall Add(void)/* overload */;
	virtual void __fastcall Assign(Classes::TPersistent* ASource);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSkinCollection(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Winskincollection */
using namespace Winskincollection;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WinskincollectionHPP
