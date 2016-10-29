# Microsoft Developer Studio Project File - Name="pisamtst" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=PISAMTST - WIN32 RELEASE
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "pisamtst.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "pisamtst.mak" CFG="PISAMTST - WIN32 RELEASE"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "pisamtst - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe
# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "pisamtst___Win32_Release"
# PROP BASE Intermediate_Dir "pisamtst___Win32_Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "pisamtst___Win32_Release"
# PROP Intermediate_Dir "pisamtst___Win32_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../common/include" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /c
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x412 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 /nologo /subsystem:console /pdb:none /machine:I386 /out:"../../../runtime.nt/bin/pisamtst.exe"
# Begin Target

# Name "pisamtst - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\main.c
DEP_CPP_MAIN_=\
	"..\..\..\common\include\cbuni.h"\
	
# End Source File
# Begin Source File

SOURCE=.\TPI_KEYLENGTH.c
DEP_CPP_TPI_K=\
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
	
# End Source File
# Begin Source File

SOURCE=.\TPI_OPEN.c
DEP_CPP_TPI_O=\
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
	
# End Source File
# Begin Source File

SOURCE=.\TPI_READ.c
DEP_CPP_TPI_R=\
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
	
# End Source File
# End Group
# Begin Group "Library Files"

# PROP Default_Filter "lib"
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\gps.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\pisam.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\disam32.lib
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=..\..\..\common\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\disamdec.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\nt\disamdec.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\unix\disamdec.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\gps.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\isconfig.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\nt\isconfig.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\unix\isconfig.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\iscustom.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\nt\iscustom.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\unix\iscustom.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\isdecs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\nt\isdecs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\unix\isdecs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\iswrap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\nt\iswrap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\unix\iswrap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\pisam.h
# End Source File
# End Group
# End Target
# End Project
