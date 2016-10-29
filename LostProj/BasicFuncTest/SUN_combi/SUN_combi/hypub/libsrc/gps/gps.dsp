# Microsoft Developer Studio Project File - Name="gps" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=gps - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "gps.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gps.mak" CFG="gps - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gps - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
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
# PROP BASE Output_Dir "gps___Wi"
# PROP BASE Intermediate_Dir "gps___Wi"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "../../../common/include" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "GPS_INTERNAL" /D "__IS_HYS_GPS__" /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x412 /d "NDEBUG"
# ADD RSC /l 0x412 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib /nologo /subsystem:windows /dll /pdb:none /machine:I386 /def:".\gps.def" /out:"..\..\..\runtime.nt\bin/gps.dll" /implib:"..\..\..\runtime.nt\lib/gps.lib" /libpath:"..\..\..\runtime.nt\lib"
# Begin Target

# Name "gps - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter "c"
# Begin Source File

SOURCE=.\cfgfun.c
DEP_CPP_CFGFU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_adjndecimal.c
DEP_CPP_D_ADJ=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_d2nstr.c
DEP_CPP_D_D2N=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_dectoint.c
DEP_CPP_D_DEC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_filldata.c
DEP_CPP_D_FIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_fillform.c
DEP_CPP_D_FILL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_fmask.c
DEP_CPP_D_FMA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_hanadjt.c
DEP_CPP_D_HAN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_hextoint.c
DEP_CPP_D_HEX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_imask.c
DEP_CPP_D_IMA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_int2ndec.c
DEP_CPP_D_INT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_int2nhex.c
DEP_CPP_D_INT2=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_inttodec.c
DEP_CPP_D_INTT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_inttohex.c
DEP_CPP_D_INTTO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_isnumstr.c
DEP_CPP_D_ISN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_isspacenstr.c
DEP_CPP_D_ISS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_isspacestr.c
DEP_CPP_D_ISSP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_julsa.c
DEP_CPP_D_JUL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_leftalign.c
DEP_CPP_D_LEF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_mkstr.c
DEP_CPP_D_MKS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_mkstradd.c
DEP_CPP_D_MKST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_ndec2int.c
DEP_CPP_D_NDE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_nhex2int.c
DEP_CPP_D_NHE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_nstr2d.c
DEP_CPP_D_NST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_nstradd.c
DEP_CPP_D_NSTR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_nstradd2.c
DEP_CPP_D_NSTRA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_rightalign.c
DEP_CPP_D_RIG=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_strendnull.c
DEP_CPP_D_STR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_strsort.c
DEP_CPP_D_STRS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\d_umask.c
DEP_CPP_D_UMA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_alldayget.c
DEP_CPP_E_ALL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_cdate2form.c
DEP_CPP_E_CDA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_chkdate.c
DEP_CPP_E_CHK=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_cmdarg.c
DEP_CPP_E_CMD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_date2jul.c
DEP_CPP_E_DAT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_datechk.c
DEP_CPP_E_DATE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_datecmp.c
DEP_CPP_E_DATEC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_day2nday.c
DEP_CPP_E_DAY=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_delenv.c
DEP_CPP_E_DEL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_dudate.c
DEP_CPP_E_DUD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_fullyear.c
DEP_CPP_E_FUL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_gdate2date.c
DEP_CPP_E_GDA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_gdate2year.c
DEP_CPP_E_GDAT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_gdatebydu.c
DEP_CPP_E_GDATE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_getdatestr.c
DEP_CPP_E_GET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_getenv.c
DEP_CPP_E_GETE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_getsysdate.c
DEP_CPP_E_GETS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_gettime.c
DEP_CPP_E_GETT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_getyear.c
DEP_CPP_E_GETY=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_gmontbydu.c
DEP_CPP_E_GMO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_gre2jul.c
DEP_CPP_E_GRE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_jul2date.c
DEP_CPP_E_JUL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_jul2gre.c
DEP_CPP_E_JUL2=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_lstdayget.c
DEP_CPP_E_LST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_nextday.c
DEP_CPP_E_NEX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_nextmonth.c
DEP_CPP_E_NEXT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_prevday.c
DEP_CPP_E_PRE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_prevmonth.c
DEP_CPP_E_PREV=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_runp.c
DEP_CPP_E_RUN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_runpsts.c
DEP_CPP_E_RUNP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_runsys.c
DEP_CPP_E_RUNS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_runsyssts.c
DEP_CPP_E_RUNSY=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_setenv.c
DEP_CPP_E_SET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_sleep0001.c
DEP_CPP_E_SLE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\e_timegap.c
DEP_CPP_E_TIM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_chmod.c
DEP_CPP_F_CHM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_chown.c
DEP_CPP_F_CHO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_copy.c
DEP_CPP_F_COP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_getfpath.c
DEP_CPP_F_GET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_lock.c
DEP_CPP_F_LOC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_lockwait.c
DEP_CPP_F_LOCK=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_mkdir.c
DEP_CPP_F_MKD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\f_unlock.c
DEP_CPP_F_UNL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\fifofun.c
DEP_CPP_FIFOF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\gps.c
DEP_CPP_GPS_C=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\gpsdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\h_errno.c
DEP_CPP_H_ERR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\gpsdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\hymsg.c
DEP_CPP_HYMSG=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\gpsdef.h"\
	
# End Source File
# Begin Source File

SOURCE=.\k_acceptstr.c
DEP_CPP_K_ACC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\k_getchar.c
DEP_CPP_K_GET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\k_inpnnumeric.c
DEP_CPP_K_INP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\k_inpnstring.c
DEP_CPP_K_INPN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_allday2date.c
DEP_CPP_L_ALL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_allday2get.c
DEP_CPP_L_ALLD=\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_datechkconv.c
DEP_CPP_L_DAT=\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_gpssethyerrno.c
DEP_CPP_L_GPS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_lstdaychkget.c
DEP_CPP_L_LST=\
	".\e_date.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_ntchmod.c
# End Source File
# Begin Source File

SOURCE=.\l_ntchown.c
# End Source File
# Begin Source File

SOURCE=.\l_pickdata.c
DEP_CPP_L_PIC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\l_readline.c
# End Source File
# Begin Source File

SOURCE=.\OD_ADJNDECIMAL.c
DEP_CPP_OD_AD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_DECTOINT.c
DEP_CPP_OD_DE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_FILLDATA.c
DEP_CPP_OD_FI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_FILLFORM.c
DEP_CPP_OD_FIL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_FMASK.c
DEP_CPP_OD_FM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_HANADJT.c
DEP_CPP_OD_HA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_HEXTOINT.c
DEP_CPP_OD_HE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_IMASK.c
DEP_CPP_OD_IM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_INT2NDEC.c
DEP_CPP_OD_IN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_INT2NHEX.c
DEP_CPP_OD_INT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_INTTODEC.c
DEP_CPP_OD_INTT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_INTTOHEX.c
DEP_CPP_OD_INTTO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_ISSPACENSTR.c
DEP_CPP_OD_IS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_LEFTALIGN.c
DEP_CPP_OD_LE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_MKSTR.c
DEP_CPP_OD_MK=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_MKSTRADD.c
DEP_CPP_OD_MKS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_NDECTOINT.c
DEP_CPP_OD_ND=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_NSTRADD.c
DEP_CPP_OD_NS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_NSTRADD2.c
DEP_CPP_OD_NST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_RIGHTALIGN.c
DEP_CPP_OD_RI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_STRENDNULL.c
DEP_CPP_OD_ST=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_STRNCAT.c
DEP_CPP_OD_STR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_STRSORT.c
DEP_CPP_OD_STRS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OD_UMASK.c
DEP_CPP_OD_UM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_ALLDAYGET.c
DEP_CPP_OE_AL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_CHKDATE.c
DEP_CPP_OE_CH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_DATE2JUL.c
DEP_CPP_OE_DA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_DATECHK.c
DEP_CPP_OE_DAT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_DATECMP.c
DEP_CPP_OE_DATE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_DUDATE.c
DEP_CPP_OE_DU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_FULLYEAR.c
DEP_CPP_OE_FU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GDATE2DATE.c
DEP_CPP_OE_GD=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GDATE2YEAR.c
DEP_CPP_OE_GDA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GDATEBYDU.c
DEP_CPP_OE_GDAT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GETENV.c
DEP_CPP_OE_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GETSYSTIME.c
DEP_CPP_OE_GET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GETYEAR.c
DEP_CPP_OE_GETY=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GMONTBYDU.c
DEP_CPP_OE_GM=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_GRE2JUL.c
DEP_CPP_OE_GR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_JUL2DATE.c
DEP_CPP_OE_JU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_JUL2GRE.c
DEP_CPP_OE_JUL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_LSTDAYGET.c
DEP_CPP_OE_LS=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_NEXTDAY.c
DEP_CPP_OE_NE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_NEXTMONTH.c
DEP_CPP_OE_NEX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_PREVDAY.c
DEP_CPP_OE_PR=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_PREVMONTH.c
DEP_CPP_OE_PRE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_RUNSYS.c
DEP_CPP_OE_RU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_RUNSYSSTS.c
DEP_CPP_OE_RUN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OE_SLEEP0001.c
DEP_CPP_OE_SL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_CHMOD.c
DEP_CPP_OF_CH=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_CHOWN.c
DEP_CPP_OF_CHO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_COPY.c
DEP_CPP_OF_CO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_GETFPATH.c
DEP_CPP_OF_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_LOCK.c
DEP_CPP_OF_LO=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_LOCKWAIT.c
DEP_CPP_OF_LOC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_TEMPNAM.c
DEP_CPP_OF_TE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_UNLINK.c
DEP_CPP_OF_UN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OF_UNLOCK.c
DEP_CPP_OF_UNL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OK_ACCEPTSTR.c
DEP_CPP_OK_AC=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OK_GETCHAR.c
DEP_CPP_OK_GE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OK_INPNNUMERIC.c
DEP_CPP_OK_IN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OK_INPNSTRING.c
DEP_CPP_OK_INP=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OR_EXECPRG.c
DEP_CPP_OR_EX=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OR_RUNCONT.c
DEP_CPP_OR_RU=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\OR_RUNWAIT.c
DEP_CPP_OR_RUN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_chkshm.c
DEP_CPP_R_CHK=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\ipcwrap.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_crtshm.c
DEP_CPP_R_CRT=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\ipcwrap.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_delshm.c
DEP_CPP_R_DEL=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\ipcwrap.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_execprg.c
DEP_CPP_R_EXE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_getshm.c
DEP_CPP_R_GET=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	"..\..\..\common\include\ipcwrap.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_runcont.c
DEP_CPP_R_RUN=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\r_runwait.c
DEP_CPP_R_RUNW=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\ringfun.c
DEP_CPP_RINGF=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\s_readstream.c
DEP_CPP_S_REA=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\s_writestream.c
DEP_CPP_S_WRI=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# Begin Source File

SOURCE=.\tracelog.c
DEP_CPP_TRACE=\
	"..\..\..\common\include\cbuni.h"\
	"..\..\..\common\include\gps.h"\
	
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=..\..\..\common\include\cbuni.h
# End Source File
# Begin Source File

SOURCE=.\e_date.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\gps.h
# End Source File
# Begin Source File

SOURCE=.\gpsdef.h
# End Source File
# Begin Source File

SOURCE=..\..\..\common\include\ipcwrap.h
# End Source File
# End Group
# Begin Group "Definition Files"

# PROP Default_Filter "def"
# Begin Source File

SOURCE=.\gps.def
# PROP Exclude_From_Build 1
# End Source File
# End Group
# Begin Group "Library Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\runtime.nt\lib\ipcwrap.lib
# End Source File
# End Group
# End Target
# End Project
