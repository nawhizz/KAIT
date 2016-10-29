# Microsoft Developer Studio Project File - Name="dsml" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=dsml - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "dsml.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "dsml.mak" CFG="dsml - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "dsml - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
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
# PROP BASE Output_Dir "dsml___W"
# PROP BASE Intermediate_Dir "dsml___W"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../common/include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x412 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /pdb:none /machine:I386 /def:".\dsml.def" /out:"..\..\..\runtime.nt\bin\dsml.dll" /implib:"..\..\..\runtime.nt\lib/dsml.lib" /libpath:"..\..\..\runtime.nt\lib"
# Begin Target

# Name "dsml - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\ds_chkbuildinf.c
DEP_CPP_DS_CH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_chkdocid.c
DEP_CPP_DS_CHK=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_chkfdavail.c
DEP_CPP_DS_CHKF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_chkfsize.c
DEP_CPP_DS_CHKFS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_chkvolinf.c
DEP_CPP_DS_CHKV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_convert.c
DEP_CPP_DS_CO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_erase.c
DEP_CPP_DS_ER=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_errset.c
DEP_CPP_DS_ERR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_filegen.c
DEP_CPP_DS_FI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_fileopen.c
DEP_CPP_DS_FIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_fullpath.c
DEP_CPP_DS_FU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_getdirseq.c
DEP_CPP_DS_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_getnewdir.c
DEP_CPP_DS_GET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_getver.c
DEP_CPP_DS_GETV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_getvolno.c
DEP_CPP_DS_GETVO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_getvolseq.c
DEP_CPP_DS_GETVOL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_log.c
DEP_CPP_DS_LO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_movedoc.c
DEP_CPP_DS_MO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_newdocid.c
DEP_CPP_DS_NE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_newvolno.c
DEP_CPP_DS_NEW=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_nextfd.c
DEP_CPP_DS_NEX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_setver.c
DEP_CPP_DS_SE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_splitpath.c
DEP_CPP_DS_SP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_splitvol.c
DEP_CPP_DS_SPL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_usedblkcnt.c
DEP_CPP_DS_US=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_volgen.c
DEP_CPP_DS_VO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ds_volopen.c
DEP_CPP_DS_VOL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_dsmlsethyerrno.c
DEP_CPP_L_DSM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ADDDIR.c
DEP_CPP_OPI_A=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_ADDDOC.c
DEP_CPP_OPI_AD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DALLCLOSE.c
DEP_CPP_OPI_D=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DBUILD.c
DEP_CPP_OPI_DB=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DBUILD2.c
DEP_CPP_OPI_DBU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DCLOSE.c
DEP_CPP_OPI_DC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DCOMMIT.c
DEP_CPP_OPI_DCO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DCONV.c
DEP_CPP_OPI_DCON=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DCROPEN.c
DEP_CPP_OPI_DCR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DDCHK.c
DEP_CPP_OPI_DD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DELDIR.c
DEP_CPP_OPI_DE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DELDOC.c
DEP_CPP_OPI_DEL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DHCHK.c
DEP_CPP_OPI_DH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DHREAD.c
DEP_CPP_OPI_DHR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DICHK.c
DEP_CPP_OPI_DI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DIFIRST.c
DEP_CPP_OPI_DIF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DILAST.c
DEP_CPP_OPI_DIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DINEXT.c
DEP_CPP_OPI_DIN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DIPREV.c
DEP_CPP_OPI_DIP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DIREAD.c
DEP_CPP_OPI_DIR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DLFREAD.c
DEP_CPP_OPI_DL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DLMREAD.c
DEP_CPP_OPI_DLM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DLVREAD.c
DEP_CPP_OPI_DLV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DOPEN.c
DEP_CPP_OPI_DO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DROLLBACK.c
DEP_CPP_OPI_DR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DUOPEN.c
DEP_CPP_OPI_DU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DVADD.c
DEP_CPP_OPI_DV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DVCHK.c
DEP_CPP_OPI_DVC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DVDEL.c
DEP_CPP_OPI_DVD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DVREAD.c
DEP_CPP_OPI_DVR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DVREN.c
DEP_CPP_OPI_DVRE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_DVUPD.c
DEP_CPP_OPI_DVU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_REDDOC.c
DEP_CPP_OPI_R=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_UPDDIR.c
DEP_CPP_OPI_U=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_UPDDIRINFO.c
DEP_CPP_OPI_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OPI_UPDDOC.c
DEP_CPP_OPI_UPD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ADDDIR.c
DEP_CPP_PI_AD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_ADDDOC.c
DEP_CPP_PI_ADD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DALLCLOSE.c
DEP_CPP_PI_DA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DBUILD.c
DEP_CPP_PI_DB=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DBUILD2.c
DEP_CPP_PI_DBU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DCLOSE.c
DEP_CPP_PI_DC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DCOMMIT.c
DEP_CPP_PI_DCO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\pisam.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DCONV.c
DEP_CPP_PI_DCON=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DCROPEN.c
DEP_CPP_PI_DCR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DDCHK.c
DEP_CPP_PI_DD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DELDIR.c
DEP_CPP_PI_DE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DELDOC.c
DEP_CPP_PI_DEL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DHCHK.c
DEP_CPP_PI_DH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DHREAD.c
DEP_CPP_PI_DHR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DICHK.c
DEP_CPP_PI_DI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DIFIRST.c
DEP_CPP_PI_DIF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DILAST.c
DEP_CPP_PI_DIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DINEXT.c
DEP_CPP_PI_DIN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DIPREV.c
DEP_CPP_PI_DIP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DIREAD.c
DEP_CPP_PI_DIR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DLFREAD.c
DEP_CPP_PI_DL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DLMREAD.c
DEP_CPP_PI_DLM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DLVREAD.c
DEP_CPP_PI_DLV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DOPEN.c
DEP_CPP_PI_DO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DROLLBACK.c
DEP_CPP_PI_DR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\pisam.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DUOPEN.c
DEP_CPP_PI_DU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DVADD.c
DEP_CPP_PI_DV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DVCHK.c
DEP_CPP_PI_DVC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DVDEL.c
DEP_CPP_PI_DVD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DVREAD.c
DEP_CPP_PI_DVR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\dsml.h"\
	"..\..\..\common\include\gps.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DVREN.c
DEP_CPP_PI_DVRE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_DVUPD.c
DEP_CPP_PI_DVU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_REDDOC.c
DEP_CPP_PI_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_UPDDIR.c
DEP_CPP_PI_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_UPDDIRINFO.c
DEP_CPP_PI_UPD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	"..\..\..\common\include\unix\disamdec.h"\
	"..\..\..\common\include\unix\isconfig.h"\
	"..\..\..\common\include\unix\iscustom.h"\
	"..\..\..\common\include\unix\isdecs.h"\
	"..\..\..\common\include\unix\iswrap.h"\
	".\dsmldef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\PI_UPDDOC.c
DEP_CPP_PI_UPDD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\disamdec.h"\
	"..\..\..\common\include\dsml.h"\
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
	".\dsmldef.h"\
	
# End Source File
# End Group
# Begin Group "Definition Files"

# PROP Default_Filter "def"
# Begin Source File

SOURCE=.\dsml.def
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=..\..\..\common\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\dsml.h
# End Source File
# Begin Source File

SOURCE=.\dsmldef.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\gps.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\unix\iswrap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\pisam.h
# End Source File
# End Group
# Begin Group "Library Files"

# PROP Default_Filter "lib"
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\disam32.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\gps.lib
# End Source File
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\pisam.lib
# End Source File
# End Group
# End Target
# End Project
