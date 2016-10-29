# Microsoft Developer Studio Project File - Name="fio" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=fio - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "fio.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "fio.mak" CFG="fio - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "fio - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
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
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../common/include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "FIO_INTERNAL" /D "__IS_HYS_GPS__" /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o NUL /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o NUL /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /pdb:none /machine:I386 /def:".\fio.def" /out:"..\..\..\runtime.nt\bin/fio.dll" /implib:"..\..\..\runtime.nt\lib/fio.lib" /libpath:"..\..\..\runtime.nt\lib"
# Begin Target

# Name "fio - Win32 Release"
# Begin Group "Definition files"

# PROP Default_Filter "def"
# Begin Source File

SOURCE=.\fio.def
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "Source files"

# PROP Default_Filter "c"
# Begin Source File

SOURCE=.\bp_prtdata.c
DEP_CPP_BP_PR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\bp_prtff.c
DEP_CPP_BP_PRT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\bp_prtform.c
DEP_CPP_BP_PRTF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\bp_prtlf.c
DEP_CPP_BP_PRTL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\bp_prtline.c
DEP_CPP_BP_PRTLI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\bp_prtseg.c
DEP_CPP_BP_PRTS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\bp_prtsegf.c
DEP_CPP_BP_PRTSE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fioext.c
DEP_CPP_FIOEX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_ALLCLOSE.c
DEP_CPP_FM_AL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_CLOSE.c
DEP_CPP_FM_CL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fm_errset.c
DEP_CPP_FM_ER=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_FILLFRM.c
DEP_CPP_FM_FI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_FILLSEG.c
DEP_CPP_FM_FIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fm_getfpath.c
DEP_CPP_FM_GE=\
	"..\..\..\common\include\cbuni.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fm_getline.c
DEP_CPP_FM_GET=\
	"..\..\..\common\include\cbuni.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_GETPATH.c
DEP_CPP_FM_GETP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_GETSIZE.c
DEP_CPP_FM_GETS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FM_OPEN.c
DEP_CPP_FM_OP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fm_savefile.c
DEP_CPP_FM_SA=\
	"..\..\..\common\include\cbuni.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_ALLCLOSE.c
DEP_CPP_FS_AL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_APPEND.c
DEP_CPP_FS_AP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_BUILD.c
DEP_CPP_FS_BU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_CLOSE.c
DEP_CPP_FS_CL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_CROPEN.c
DEP_CPP_FS_CR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_DROP.c
DEP_CPP_FS_DR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fs_errset.c
DEP_CPP_FS_ER=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_GETPATH.c
DEP_CPP_FS_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_OPEN.c
DEP_CPP_FS_OP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_READ.c
DEP_CPP_FS_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_RECNUM.c
DEP_CPP_FS_REC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_REDFIRST.c
DEP_CPP_FS_RED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_REDLAST.c
DEP_CPP_FS_REDL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_REDLN.c
DEP_CPP_FS_REDLN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_REDNX.c
DEP_CPP_FS_REDN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_REDPR.c
DEP_CPP_FS_REDP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fs_savefile.c
DEP_CPP_FS_SA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_UPDAT.c
DEP_CPP_FS_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_UPDATCUR.c
DEP_CPP_FS_UPD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\FS_WRITE.c
DEP_CPP_FS_WR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_fiosethyerrno.c
DEP_CPP_L_FIO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTDATA.c
DEP_CPP_OBP_P=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTFF.c
DEP_CPP_OBP_PR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTFORM.c
DEP_CPP_OBP_PRT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTLF.c
DEP_CPP_OBP_PRTL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTLINE.c
DEP_CPP_OBP_PRTLI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTSEG.c
DEP_CPP_OBP_PRTS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OBP_PRTSEGF.c
DEP_CPP_OBP_PRTSE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_ALLCLOSE.c
DEP_CPP_OFM_A=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_CLOSE.c
DEP_CPP_OFM_C=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_FILLFRM.c
DEP_CPP_OFM_F=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_FILLSEG.c
DEP_CPP_OFM_FI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_GETPATH.c
DEP_CPP_OFM_G=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_GETSIZE.c
DEP_CPP_OFM_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFM_OPEN.c
DEP_CPP_OFM_O=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_ALLCLOSE.c
DEP_CPP_OFS_A=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_APPEND.c
DEP_CPP_OFS_AP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_BUILD.c
DEP_CPP_OFS_B=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_CLOSE.c
DEP_CPP_OFS_C=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_CROPEN.c
DEP_CPP_OFS_CR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_DROP.c
DEP_CPP_OFS_D=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_GETPATH.c
DEP_CPP_OFS_G=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_OPEN.c
DEP_CPP_OFS_O=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_READ.c
DEP_CPP_OFS_R=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_REDFIRST.c
DEP_CPP_OFS_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_REDLN.c
DEP_CPP_OFS_RED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_REDNX.c
DEP_CPP_OFS_REDN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_REDPR.c
DEP_CPP_OFS_REDP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_UPDAT.c
DEP_CPP_OFS_U=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_UPDATCUR.c
DEP_CPP_OFS_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OFS_WRITE.c
DEP_CPP_OFS_W=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\fs_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_APPEND.c
DEP_CPP_OSM_A=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_BUILD.c
DEP_CPP_OSM_B=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_CLOSE.c
DEP_CPP_OSM_C=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_CROPEN.c
DEP_CPP_OSM_CR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_DROP.c
DEP_CPP_OSM_D=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_OPEN.c
DEP_CPP_OSM_O=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_READ.c
DEP_CPP_OSM_R=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_REDFIRST.c
DEP_CPP_OSM_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_REDLAST.c
DEP_CPP_OSM_RED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_REDLN.c
DEP_CPP_OSM_REDL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_REDNX.c
DEP_CPP_OSM_REDN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_REDPR.c
DEP_CPP_OSM_REDP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_UPDAT.c
DEP_CPP_OSM_U=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_UPDATCUR.c
DEP_CPP_OSM_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OSM_WRITE.c
DEP_CPP_OSM_W=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_APPEND.c
DEP_CPP_SM_AP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_BUILD.c
DEP_CPP_SM_BU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_CLOSE.c
DEP_CPP_SM_CL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_CROPEN.c
DEP_CPP_SM_CR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_DROP.c
DEP_CPP_SM_DR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\sm_errset.c
DEP_CPP_SM_ER=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_OPEN.c
DEP_CPP_SM_OP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_READ.c
DEP_CPP_SM_RE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_REDFIRST.c
DEP_CPP_SM_RED=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_REDLAST.c
DEP_CPP_SM_REDL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_REDLN.c
DEP_CPP_SM_REDLN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_REDNX.c
DEP_CPP_SM_REDN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_REDPR.c
DEP_CPP_SM_REDP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_UPDAT.c
DEP_CPP_SM_UP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_UPDATCUR.c
DEP_CPP_SM_UPD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# Begin Source File

SOURCE=.\SM_WRITE.c
DEP_CPP_SM_WR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\fio.h"\
	"..\..\..\common\include\gps.h"\
	".\sm_fun.h"\
	
# End Source File
# End Group
# Begin Group "Header files"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=..\..\..\common\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\fio.h
# End Source File
# Begin Source File

SOURCE=.\fm_fun.h
# End Source File
# Begin Source File

SOURCE=.\fs_fun.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\gps.h
# End Source File
# Begin Source File

SOURCE=.\sm_fun.h
# End Source File
# End Group
# Begin Group "Library Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\gps.lib
# End Source File
# End Group
# End Target
# End Project
