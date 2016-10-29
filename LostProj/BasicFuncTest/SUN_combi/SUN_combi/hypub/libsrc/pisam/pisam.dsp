# Microsoft Developer Studio Project File - Name="pisam" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=pisam - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "pisam.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "pisam.mak" CFG="pisam - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "pisam - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""$/hypub/libsrc/pisam", BOFAAAAA"
# PROP Scc_LocalPath "."
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe
# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../common/include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "PI_INTERNAL" /D "__ISHYS_GPS__" /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /pdb:none /machine:I386 /def:".\pisam.def" /out:"..\..\..\runtime.nt\bin/pisam.dll" /implib:"..\..\..\runtime.nt\lib/pisam.lib" /libpath:"..\..\..\runtime.nt\lib"
# Begin Target

# Name "pisam - Win32 Release"
# Begin Group "Definition files"

# PROP Default_Filter "def"
# Begin Source File

SOURCE=.\pisam.def
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "Source files"

# PROP Default_Filter "c"
# Begin Source File

SOURCE=.\l_pisamsethyerrno.c
DEP_CPP_L_PIS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ADDIT.c
DEP_CPP_OPI_A=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ALLCLOSE.c
DEP_CPP_OPI_AL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_BUILD.c
DEP_CPP_OPI_B=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_CHMOD.c
DEP_CPP_OPI_C=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_CHOWN.c
DEP_CPP_OPI_CH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_CLOSE.c
DEP_CPP_OPI_CL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_COMMIT.c
DEP_CPP_OPI_CO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\pisam.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_CRLOCKOPEN.c
DEP_CPP_OPI_CR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_CROPEN.c
DEP_CPP_OPI_CRO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DELET.c
DEP_CPP_OPI_D=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DROP.c
DEP_CPP_OPI_DR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_EBUILD.c
DEP_CPP_OPI_E=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ECRLOCKOPEN.c
DEP_CPP_OPI_EC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ECROPEN.c
DEP_CPP_OPI_ECR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_EDROP.c
DEP_CPP_OPI_ED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ELOCKOPEN.c
DEP_CPP_OPI_EL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ENDTRAN.c
DEP_CPP_OPI_EN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\pisam.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_EOPEN.c
DEP_CPP_OPI_EO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ETRBUILD.c
DEP_CPP_OPI_ET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ETRCROPEN.c
DEP_CPP_OPI_ETR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ETROPEN.c
DEP_CPP_OPI_ETRO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_EUOPEN.c
DEP_CPP_OPI_EU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ISTRAN.c
DEP_CPP_OPI_I=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\pisam.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_KEYLENGTH.c
DEP_CPP_OPI_K=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_LOCKOPEN.c
DEP_CPP_OPI_L=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_OPEN.c
DEP_CPP_OPI_O=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_RDUEQ.c
DEP_CPP_OPI_R=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_RDUGE.c
DEP_CPP_OPI_RD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_RECLENGTH.c
DEP_CPP_OPI_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_RECNO.c
DEP_CPP_OPI_REC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_RECSIZE.c
DEP_CPP_OPI_RECS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDEQ.c
DEP_CPP_OPI_RED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDFIRST.c
DEP_CPP_OPI_REDF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDGE.c
DEP_CPP_OPI_REDG=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDGT.c
DEP_CPP_OPI_REDGT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDLAST.c
DEP_CPP_OPI_REDL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDLE.c
DEP_CPP_OPI_REDLE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDLT.c
DEP_CPP_OPI_REDLT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDNX.c
DEP_CPP_OPI_REDN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDPR.c
DEP_CPP_OPI_REDP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ROLLBACK.c
DEP_CPP_OPI_RO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\pisam.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_SETKEY.c
DEP_CPP_OPI_S=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_START.c
DEP_CPP_OPI_ST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TRAN.c
DEP_CPP_OPI_T=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TRBEGIN.c
DEP_CPP_OPI_TR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TRBUILD.c
DEP_CPP_OPI_TRB=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TRCROPEN.c
DEP_CPP_OPI_TRC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TRLOGCLOSE.c
DEP_CPP_OPI_TRL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\pisam.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TRLOGOPEN.c
DEP_CPP_OPI_TRLO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_TROPEN.c
DEP_CPP_OPI_TRO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_UOPEN.c
DEP_CPP_OPI_U=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_UPDAT.c
DEP_CPP_OPI_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_UPTCUR.c
DEP_CPP_OPI_UPT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ADDIT.c
DEP_CPP_PI_AD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ALLCLOSE.c
DEP_CPP_PI_AL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_BUILD.c
DEP_CPP_PI_BU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_CHMOD.c
DEP_CPP_PI_CH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_CHOWN.c
DEP_CPP_PI_CHO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_CLOSE.c
DEP_CPP_PI_CL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_COMMIT.c
DEP_CPP_PI_CO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_CRLOCKOPEN.c
DEP_CPP_PI_CR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_CROPEN.c
DEP_CPP_PI_CRO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DELET.c
DEP_CPP_PI_DE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DROP.c
DEP_CPP_PI_DR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_EBUILD.c
DEP_CPP_PI_EB=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ECRLOCKOPEN.c
DEP_CPP_PI_EC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ECROPEN.c
DEP_CPP_PI_ECR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_EDROP.c
DEP_CPP_PI_ED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ELOCKOPEN.c
DEP_CPP_PI_EL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ENDTRAN.c
DEP_CPP_PI_EN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_EOPEN.c
DEP_CPP_PI_EO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pi_erasefile.c
DEP_CPP_PI_ER=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pi_errset.c
DEP_CPP_PI_ERR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ETRBUILD.c
DEP_CPP_PI_ET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ETRCROPEN.c
DEP_CPP_PI_ETR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ETROPEN.c
DEP_CPP_PI_ETRO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_EUOPEN.c
DEP_CPP_PI_EU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pi_filegen.c
DEP_CPP_PI_FI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pi_getinfpath.c
DEP_CPP_PI_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_INFPATH.c
DEP_CPP_PI_IN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ISTRAN.c
DEP_CPP_PI_IS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_KEYLENGTH.c
DEP_CPP_PI_KE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_LOCKOPEN.c
DEP_CPP_PI_LO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_OPEN.c
DEP_CPP_PI_OP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_RDUEQ.c
DEP_CPP_PI_RD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_RDUGE.c
DEP_CPP_PI_RDU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_RECLENGTH.c
DEP_CPP_PI_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_RECNO.c
DEP_CPP_PI_REC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_RECSIZE.c
DEP_CPP_PI_RECS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDEQ.c
DEP_CPP_PI_RED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDFIRST.c
DEP_CPP_PI_REDF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDGE.c
DEP_CPP_PI_REDG=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDGT.c
DEP_CPP_PI_REDGT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDLAST.c
DEP_CPP_PI_REDL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDLE.c
DEP_CPP_PI_REDLE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDLT.c
DEP_CPP_PI_REDLT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDNX.c
DEP_CPP_PI_REDN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDPR.c
DEP_CPP_PI_REDP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ROLLBACK.c
DEP_CPP_PI_RO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pi_savefile.c
DEP_CPP_PI_SA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_SETKEY.c
DEP_CPP_PI_SE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pi_setkeymode.c
DEP_CPP_PI_SET=\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_START.c
DEP_CPP_PI_ST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TRAN.c
DEP_CPP_PI_TR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TRBEGIN.c
DEP_CPP_PI_TRB=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TRBUILD.c
DEP_CPP_PI_TRBU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TRCROPEN.c
DEP_CPP_PI_TRC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TRLOGCLOSE.c
DEP_CPP_PI_TRL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\pisam.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TRLOGOPEN.c
DEP_CPP_PI_TRLO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_TROPEN.c
DEP_CPP_PI_TRO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_UOPEN.c
DEP_CPP_PI_UO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_UPDAT.c
DEP_CPP_PI_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_UPTCUR.c
DEP_CPP_PI_UPT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\pisamext.c
DEP_CPP_PISAM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\isconfig.h"\
	"..\..\..\common\include\iscustom.h"\
	"..\..\..\common\include\isdecs.h"\
	"..\..\..\common\include\iswrap.h"\
	"..\..\..\common\include\nt\disamdec.h"\
	"..\..\..\common\include\nt\isconfig.h"\
	"..\..\..\common\include\nt\iscustom.h"\
	"..\..\..\common\include\nt\isdecs.h"\
	"..\..\..\common\include\nt\iswrap.h"\
	"..\..\..\common\include\pisam.h"\
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\pisamdef.h"\
	
# End Source File
# End Group
# Begin Group "Header files"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=..\..\..\common\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\gps.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\nt\iswrap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\pisam.h
# End Source File
# Begin Source File

SOURCE=.\pisamdef.h
# End Source File
# End Group
# Begin Group "Library Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\disam32.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\gps.lib
# End Source File
# End Group
# End Target
# End Project
