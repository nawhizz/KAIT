# Microsoft Developer Studio Project File - Name="cmreg" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=CMREG - WIN32 RELEASE
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "cmreg.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "cmreg.mak" CFG="CMREG - WIN32 RELEASE"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "cmreg - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
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
# PROP BASE Output_Dir "cmreg___"
# PROP BASE Intermediate_Dir "cmreg___"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "..\..\include" /I "..\..\..\dltp\dblay" /I "..\..\..\pscon\dblay" /I "..\..\..\cvms\dblay" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x412 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 /nologo /subsystem:windows /dll /pdb:none /machine:I386 /out:"..\..\..\runtime.nt\bin\cmreg.dll" /implib:"..\..\..\runtime.nt\lib\cmreg.lib"
# Begin Target

# Name "cmreg - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\CmRegAscl.c
DEP_CPP_CMREG=\
	"..\..\..\cvms\dblay\ascl.h"\
	"..\..\..\cvms\dblay\asclv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegClose.c
DEP_CPP_CMREGC=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\pisam.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegCommit.c
DEP_CPP_CMREGCO=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\pisam.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegEvct.c
DEP_CPP_CMREGE=\
	"..\..\..\pscon\dblay\evct.h"\
	"..\..\..\pscon\dblay\evctv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\cmregext.c
# End Source File
# Begin Source File

SOURCE=.\CmRegFmid.c
DEP_CPP_CMREGF=\
	"..\..\..\pscon\dblay\fmid.h"\
	"..\..\..\pscon\dblay\fmidv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegLusr.c
DEP_CPP_CMREGL=\
	"..\..\..\dltp\dblay\lusr.h"\
	"..\..\..\dltp\dblay\lusrv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegOpen.c
DEP_CPP_CMREGO=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegRollback.c
DEP_CPP_CMREGR=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\pisam.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegTxid.c
DEP_CPP_CMREGT=\
	"..\..\..\dltp\dblay\txid.h"\
	"..\..\..\dltp\dblay\txidv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegUser.c
DEP_CPP_CMREGU=\
	"..\..\..\dltp\dblay\lusr.h"\
	"..\..\..\dltp\dblay\lusrv.h"\
	"..\..\..\dltp\dblay\usid.h"\
	"..\..\..\dltp\dblay\usidv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpapi.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\CmRegUsid.c
DEP_CPP_CMREGUS=\
	"..\..\..\dltp\dblay\usid.h"\
	"..\..\..\dltp\dblay\usidv.h"\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\stpmacro.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_cmregcom.c
DEP_CPP_L_CMR=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\disamdec.h"\
	"..\..\include\gps.h"\
	"..\..\include\isconfig.h"\
	"..\..\include\iscustom.h"\
	"..\..\include\isdecs.h"\
	"..\..\include\iswrap.h"\
	"..\..\include\nt\disamdec.h"\
	"..\..\include\nt\isconfig.h"\
	"..\..\include\nt\iscustom.h"\
	"..\..\include\nt\isdecs.h"\
	"..\..\include\nt\iswrap.h"\
	"..\..\include\pisam.h"\
	"..\..\include\unix\disamdec.h"\
	"..\..\include\unix\isconfig.h"\
	"..\..\include\unix\iscustom.h"\
	"..\..\include\unix\isdecs.h"\
	"..\..\include\unix\iswrap.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_errset.c
DEP_CPP_L_ERR=\
	"..\..\include\cbuni.h"\
	"..\..\include\gps.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_sethyerrno.c
DEP_CPP_L_SET=\
	"..\..\include\cbuni.h"\
	"..\..\include\gps.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGASCL.c
DEP_CPP_OCMRE=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGCLOSE.c
DEP_CPP_OCMREG=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGCOMMIT.c
DEP_CPP_OCMREGC=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGEVCT.c
DEP_CPP_OCMREGE=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGFMID.c
DEP_CPP_OCMREGF=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGLUSR.c
DEP_CPP_OCMREGL=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGOPEN.c
DEP_CPP_OCMREGO=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\stpapi.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGROLLBACK.c
DEP_CPP_OCMREGR=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGTXID.c
DEP_CPP_OCMREGT=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGUSER.c
DEP_CPP_OCMREGU=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\stpapi.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OCMREGUSID.c
DEP_CPP_OCMREGUS=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	".\cmregdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\tracelog.c
DEP_CPP_TRACE=\
	"..\..\include\cbuni.h"\
	"..\..\include\cmreg.h"\
	"..\..\include\gps.h"\
	".\cmregdef.h"\
	
# End Source File
# End Group
# Begin Group "Definition Files"

# PROP Default_Filter "def"
# Begin Source File

SOURCE=.\cmreg.def
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=..\..\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=..\..\include\cmreg.h
# End Source File
# Begin Source File

SOURCE=.\cmregdef.h
# End Source File
# Begin Source File

SOURCE=..\..\include\gps.h
# End Source File
# Begin Source File

SOURCE=..\..\include\iswrap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\dltp\dblay\lusr.h
# End Source File
# Begin Source File

SOURCE=..\..\..\dltp\dblay\lusrv.h
# End Source File
# Begin Source File

SOURCE=..\..\include\pisam.h
# End Source File
# Begin Source File

SOURCE=..\..\include\stpapi.h
# End Source File
# Begin Source File

SOURCE=..\..\..\dltp\dblay\usid.h
# End Source File
# Begin Source File

SOURCE=..\..\..\dltp\dblay\usidv.h
# End Source File
# End Group
# Begin Group "Library Files"

# PROP Default_Filter "lib"
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\stpapi.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\pisam.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\gps.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\disam32.lib
# End Source File
# End Group
# End Target
# End Project
