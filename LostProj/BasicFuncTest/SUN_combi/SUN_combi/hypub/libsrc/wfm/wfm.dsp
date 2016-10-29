# Microsoft Developer Studio Project File - Name="wfm" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=wfm - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "wfm.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "wfm.mak" CFG="wfm - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "wfm - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "wfm - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "wfm - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "wfm___Win32_Release"
# PROP BASE Intermediate_Dir "wfm___Win32_Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WFM_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../common/include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WFM_EXPORTS" /D "_WINDLL" /D "_AFXDLL" /FR /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x412 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 /nologo /dll /pdb:none /machine:I386 /def:"wfm.def" /out:"../../../runtime.nt/bin/wfm.dll"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WFM_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "WFM_EXPORTS" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x412 /d "_DEBUG"
# ADD RSC /l 0x412 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "wfm - Win32 Release"
# Name "wfm - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\OWFM_ALLCLOSE.c
DEP_CPP_OWFM_=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\OWFM_CLOSE.c
DEP_CPP_OWFM_C=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\wfm.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\OWFM_FILLDATA.c
DEP_CPP_OWFM_F=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\OWFM_FILLHEAD.c
DEP_CPP_OWFM_FI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\wfm.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\OWFM_FILLTAIL.c
DEP_CPP_OWFM_FIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\wfm.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\OWFM_OPEN.c
DEP_CPP_OWFM_O=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\wfm.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_dbgfun.c
DEP_CPP_WFM_D=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_extvar.c
DEP_CPP_WFM_E=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_freeblkinfo.c
DEP_CPP_WFM_F=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_freeseginfo.c
DEP_CPP_WFM_FR=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_savefile.c
DEP_CPP_WFM_S=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_saveseginfo.c
DEP_CPP_WFM_SA=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\wfm_str2strarr.c
DEP_CPP_WFM_ST=\
	"..\..\..\common\include\cbuni.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\WFmAllClose.c
DEP_CPP_WFMAL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\WFmClose.c
DEP_CPP_WFMCL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\WFmFillData.c
DEP_CPP_WFMFI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\WFmFillHead.c
DEP_CPP_WFMFIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\WFmFillTail.c
DEP_CPP_WFMFILL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\WFmOpen.c
DEP_CPP_WFMOP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\wfm.h"\
	".\wfm_fun.h"\
	

!IF  "$(CFG)" == "wfm - Win32 Release"

!ELSEIF  "$(CFG)" == "wfm - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\wfm_fun.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Group "Library Files"

# PROP Default_Filter "lib"
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\gps.lib
# End Source File
# End Group
# End Target
# End Project
