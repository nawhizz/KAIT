# Microsoft Developer Studio Project File - Name="ipcwrap" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=ipcwrap - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ipcwrap.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ipcwrap.mak" CFG="ipcwrap - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ipcwrap - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
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
# ADD CPP /nologo /MD /W3 /GX /O2 /I "..\..\..\common\include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x412 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 /nologo /subsystem:windows /dll /pdb:none /machine:I386 /def:".\ipcwrap.def" /out:"..\..\..\runtime.nt\bin/ipcwrap.dll" /implib:"..\..\..\runtime.nt\lib/ipcwrap.lib"
# Begin Target

# Name "ipcwrap - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ftok.c
DEP_CPP_FTOK_=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\getsemid.c
DEP_CPP_GETSE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\getshmid.c
DEP_CPP_GETSH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ipcwrap.c
DEP_CPP_IPCWR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\semctl.c
DEP_CPP_SEMCT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\semget.c
DEP_CPP_SEMGE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\semop.c
DEP_CPP_SEMOP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\semopx.c
DEP_CPP_SEMOPX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\shmat.c
DEP_CPP_SHMAT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\shmctl.c
DEP_CPP_SHMCT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\shmdt.c
DEP_CPP_SHMDT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\shmget.c
DEP_CPP_SHMGE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\ipcwrap.h"\
	".\ipcwrapdef.h"\
	
# End Source File
# End Group
# Begin Group "Definition Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ipcwrap.def
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\common\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\ipcwrap.h
# End Source File
# Begin Source File

SOURCE=.\ipcwrapdef.h
# End Source File
# End Group
# End Target
# End Project
