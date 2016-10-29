include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	$(COMMON)/include/gps.h \
	gpsdef.h	e_date.h 	e_sigact.h

STATIC_OBJS	= \
	$(SDOBJ)/OD_ADJNDECIMAL.o	$(SDOBJ)/OD_DECTOINT.o \
	$(SDOBJ)/OD_FILLDATA.o	$(SDOBJ)/OD_FILLFORM.o \
	$(SDOBJ)/OD_FMASK.o	$(SDOBJ)/OD_HANADJT.o \
	$(SDOBJ)/OD_HEXTOINT.o	$(SDOBJ)/OD_IMASK.o \
	$(SDOBJ)/OD_INT2NDEC.o	$(SDOBJ)/OD_INT2NHEX.o \
	$(SDOBJ)/OD_INTTODEC.o	$(SDOBJ)/OD_INTTOHEX.o \
	$(SDOBJ)/OD_ISSPACENSTR.o	$(SDOBJ)/OD_LEFTALIGN.o \
	$(SDOBJ)/OD_MKSTR.o	$(SDOBJ)/OD_MKSTRADD.o \
	$(SDOBJ)/OD_NDECTOINT.o	$(SDOBJ)/OD_NSTRADD.o \
	$(SDOBJ)/OD_NSTRADD2.o	$(SDOBJ)/OD_RIGHTALIGN.o \
	$(SDOBJ)/OD_STRENDNULL.o	$(SDOBJ)/OD_STRNCAT.o \
	$(SDOBJ)/OD_STRSORT.o	$(SDOBJ)/OD_UMASK.o \
	$(SDOBJ)/OE_ALLDAYGET.o	$(SDOBJ)/OE_CHKDATE.o \
	$(SDOBJ)/OE_DATE2JUL.o	$(SDOBJ)/OE_DATECHK.o \
	$(SDOBJ)/OE_DATECMP.o	$(SDOBJ)/OE_DUDATE.o \
	$(SDOBJ)/OE_FULLYEAR.o	$(SDOBJ)/OE_GDATE2DATE.o \
	$(SDOBJ)/OE_GDATE2YEAR.o	$(SDOBJ)/OE_GDATEBYDU.o \
	$(SDOBJ)/OE_GETENV.o	$(SDOBJ)/OE_GETSYSTIME.o \
	$(SDOBJ)/OE_GETWEEKDAY.o \
	$(SDOBJ)/OE_GETYEAR.o	$(SDOBJ)/OE_GMONTBYDU.o \
	$(SDOBJ)/OE_GRE2JUL.o	$(SDOBJ)/OE_JUL2DATE.o \
	$(SDOBJ)/OE_JUL2GRE.o	$(SDOBJ)/OE_LSTDAYGET.o \
	$(SDOBJ)/OE_NEXTDAY.o	$(SDOBJ)/OE_NEXTMONTH.o \
	$(SDOBJ)/OE_PREVDAY.o	$(SDOBJ)/OE_PREVMONTH.o \
	$(SDOBJ)/OE_RUNSYS.o	$(SDOBJ)/OE_SLEEP0001.o \
	$(SDOBJ)/OE_RUNSYSSTS.o \
	$(SDOBJ)/OF_CHMOD.o	$(SDOBJ)/OF_CHOWN.o \
	$(SDOBJ)/OF_GETENV.o	$(SDOBJ)/OF_GETFPATH.o \
	$(SDOBJ)/OF_LOCK.o	$(SDOBJ)/OF_LOCKWAIT.o \
	$(SDOBJ)/OF_TEMPNAM.o	$(SDOBJ)/OF_UNLINK.o \
	$(SDOBJ)/OF_UNLOCK.o	$(SDOBJ)/OF_COPY.o \
	$(SDOBJ)/OK_ACCEPTSTR.o \
	$(SDOBJ)/OK_GETCHAR.o	$(SDOBJ)/OK_INPNNUMERIC.o \
	$(SDOBJ)/OK_INPNSTRING.o	$(SDOBJ)/OR_EXECPRG.o \
	$(SDOBJ)/OR_RUNCONT.o	$(SDOBJ)/OR_RUNWAIT.o \
	$(SDOBJ)/cfgfun.o	$(SDOBJ)/d_adjndecimal.o \
	$(SDOBJ)/d_d2nstr.o	$(SDOBJ)/d_dectoint.o \
	$(SDOBJ)/d_filldata.o	$(SDOBJ)/d_fillform.o \
	$(SDOBJ)/d_fmask.o	$(SDOBJ)/d_hanadjt.o \
	$(SDOBJ)/d_hextoint.o	$(SDOBJ)/d_imask.o \
	$(SDOBJ)/d_int2ndec.o	$(SDOBJ)/d_int2nhex.o \
	$(SDOBJ)/d_inttodec.o	$(SDOBJ)/d_inttohex.o \
	$(SDOBJ)/d_isnumstr.o	$(SDOBJ)/d_isspacenstr.o \
	$(SDOBJ)/d_isspacestr.o	$(SDOBJ)/d_leftalign.o \
	$(SDOBJ)/d_mkstr.o	$(SDOBJ)/d_mkstradd.o \
	$(SDOBJ)/d_ndec2int.o	$(SDOBJ)/d_nhex2int.o \
	$(SDOBJ)/d_nstr2d.o	$(SDOBJ)/d_nstradd.o \
	$(SDOBJ)/d_nstradd2.o	$(SDOBJ)/d_rightalign.o \
	$(SDOBJ)/d_strendnull.o	$(SDOBJ)/d_strsort.o \
	$(SDOBJ)/d_umask.o	$(SDOBJ)/e_addsigact.o \
	$(SDOBJ)/e_alldayget.o	$(SDOBJ)/e_cdate2form.o \
	$(SDOBJ)/e_chkdate.o	$(SDOBJ)/e_cmdarg.o \
	$(SDOBJ)/e_date2jul.o	$(SDOBJ)/e_datechk.o \
	$(SDOBJ)/e_dates2du.o \
	$(SDOBJ)/e_datecmp.o	$(SDOBJ)/e_day2nday.o \
	$(SDOBJ)/e_delenv.o	$(SDOBJ)/e_dudate.o \
	$(SDOBJ)/e_fullyear.o	$(SDOBJ)/e_gdate2date.o \
	$(SDOBJ)/e_gdate2year.o	$(SDOBJ)/e_gdatebydu.o \
	$(SDOBJ)/e_getdatestr.o	$(SDOBJ)/e_getenv.o \
	$(SDOBJ)/e_getweekday.o	\
	$(SDOBJ)/e_getsysdate.o	$(SDOBJ)/e_gettime.o \
	$(SDOBJ)/e_getyear.o	$(SDOBJ)/e_gmontbydu.o \
	$(SDOBJ)/e_gre2jul.o	$(SDOBJ)/e_jul2date.o \
	$(SDOBJ)/e_jul2gre.o	$(SDOBJ)/e_lstdayget.o \
	$(SDOBJ)/e_nextday.o	$(SDOBJ)/e_nextmonth.o \
	$(SDOBJ)/e_prevday.o	$(SDOBJ)/e_prevmonth.o \
	$(SDOBJ)/e_runp.o	$(SDOBJ)/e_runsys.o \
	$(SDOBJ)/e_setenv.o	$(SDOBJ)/e_sighandle.o \
	$(SDOBJ)/e_sleep0001.o	$(SDOBJ)/e_timegap.o \
	$(SDOBJ)/f_chmod.o	$(SDOBJ)/f_chown.o \
	$(SDOBJ)/f_getenv.o	$(SDOBJ)/f_getfpath.o \
	$(SDOBJ)/f_lock.o	$(SDOBJ)/f_lockwait.o \
	$(SDOBJ)/f_mkdir.o	$(SDOBJ)/f_setenv.o \
	$(SDOBJ)/f_unlock.o	$(SDOBJ)/f_copy.o \
	$(SDOBJ)/fifofun.o \
	$(SDOBJ)/h_errno.o	$(SDOBJ)/k_acceptstr.o \
	$(SDOBJ)/k_getchar.o	$(SDOBJ)/k_inpnnumeric.o \
	$(SDOBJ)/k_inpnstring.o	$(SDOBJ)/l_allday2date.o \
	$(SDOBJ)/l_allday2get.o	$(SDOBJ)/l_datechkconv.o \
	$(SDOBJ)/l_lstdaychkget.o	$(SDOBJ)/l_pickdata.o \
	$(SDOBJ)/l_readline.o	$(SDOBJ)/r_chkshm.o \
	$(SDOBJ)/r_crtshm.o	$(SDOBJ)/r_delshm.o \
	$(SDOBJ)/r_execprg.o	$(SDOBJ)/r_getshm.o \
	$(SDOBJ)/r_runcont.o	$(SDOBJ)/r_runwait.o \
	$(SDOBJ)/ringfun.o	$(SDOBJ)/s_readstream.o \
	$(SDOBJ)/s_select.o	$(SDOBJ)/s_writestream.o \
	$(SDOBJ)/tracelog.o	$(SDOBJ)/l_gpssethyerrno.o \
	$(SDOBJ)/hymsg.o	$(SDOBJ)/e_runpsts.o \
	$(SDOBJ)/e_runsyssts.o

#	d_julsa		# delete for unlink libm
#	l_ntchmod	# #######
#	l_ntchown	# #######

DYNAMIC_OBJS	= \
	$(DDOBJ)/OD_ADJNDECIMAL.o	$(DDOBJ)/OD_DECTOINT.o \
	$(DDOBJ)/OD_FILLDATA.o	$(DDOBJ)/OD_FILLFORM.o \
	$(DDOBJ)/OD_FMASK.o	$(DDOBJ)/OD_HANADJT.o \
	$(DDOBJ)/OD_HEXTOINT.o	$(DDOBJ)/OD_IMASK.o \
	$(DDOBJ)/OD_INT2NDEC.o	$(DDOBJ)/OD_INT2NHEX.o \
	$(DDOBJ)/OD_INTTODEC.o	$(DDOBJ)/OD_INTTOHEX.o \
	$(DDOBJ)/OD_ISSPACENSTR.o	$(DDOBJ)/OD_LEFTALIGN.o \
	$(DDOBJ)/OD_MKSTR.o	$(DDOBJ)/OD_MKSTRADD.o \
	$(DDOBJ)/OD_NDECTOINT.o	$(DDOBJ)/OD_NSTRADD.o \
	$(DDOBJ)/OD_NSTRADD2.o	$(DDOBJ)/OD_RIGHTALIGN.o \
	$(DDOBJ)/OD_STRENDNULL.o	$(DDOBJ)/OD_STRNCAT.o \
	$(DDOBJ)/OD_STRSORT.o	$(DDOBJ)/OD_UMASK.o \
	$(DDOBJ)/OE_ALLDAYGET.o	$(DDOBJ)/OE_CHKDATE.o \
	$(DDOBJ)/OE_DATE2JUL.o	$(DDOBJ)/OE_DATECHK.o \
	$(DDOBJ)/OE_DATECMP.o	$(DDOBJ)/OE_DUDATE.o \
	$(DDOBJ)/OE_FULLYEAR.o	$(DDOBJ)/OE_GDATE2DATE.o \
	$(DDOBJ)/OE_GDATE2YEAR.o	$(DDOBJ)/OE_GDATEBYDU.o \
	$(DDOBJ)/OE_GETENV.o	$(DDOBJ)/OE_GETSYSTIME.o \
	$(DDOBJ)/OE_GETWEEKDAY.o \
	$(DDOBJ)/OE_GETYEAR.o	$(DDOBJ)/OE_GMONTBYDU.o \
	$(DDOBJ)/OE_GRE2JUL.o	$(DDOBJ)/OE_JUL2DATE.o \
	$(DDOBJ)/OE_JUL2GRE.o	$(DDOBJ)/OE_LSTDAYGET.o \
	$(DDOBJ)/OE_NEXTDAY.o	$(DDOBJ)/OE_NEXTMONTH.o \
	$(DDOBJ)/OE_PREVDAY.o	$(DDOBJ)/OE_PREVMONTH.o \
	$(DDOBJ)/OE_RUNSYS.o	$(DDOBJ)/OE_SLEEP0001.o \
	$(DDOBJ)/OE_RUNSYSSTS.o \
	$(DDOBJ)/OF_CHMOD.o	$(DDOBJ)/OF_CHOWN.o \
	$(DDOBJ)/OF_GETENV.o	$(DDOBJ)/OF_GETFPATH.o \
	$(DDOBJ)/OF_LOCK.o	$(DDOBJ)/OF_LOCKWAIT.o \
	$(DDOBJ)/OF_TEMPNAM.o	$(DDOBJ)/OF_UNLINK.o \
	$(DDOBJ)/OF_UNLOCK.o	$(DDOBJ)/OF_COPY.o \
	$(DDOBJ)/OK_ACCEPTSTR.o \
	$(DDOBJ)/OK_GETCHAR.o	$(DDOBJ)/OK_INPNNUMERIC.o \
	$(DDOBJ)/OK_INPNSTRING.o	$(DDOBJ)/OR_EXECPRG.o \
	$(DDOBJ)/OR_RUNCONT.o	$(DDOBJ)/OR_RUNWAIT.o \
	$(DDOBJ)/cfgfun.o	$(DDOBJ)/d_adjndecimal.o \
	$(DDOBJ)/d_d2nstr.o	$(DDOBJ)/d_dectoint.o \
	$(DDOBJ)/d_filldata.o	$(DDOBJ)/d_fillform.o \
	$(DDOBJ)/d_fmask.o	$(DDOBJ)/d_hanadjt.o \
	$(DDOBJ)/d_hextoint.o	$(DDOBJ)/d_imask.o \
	$(DDOBJ)/d_int2ndec.o	$(DDOBJ)/d_int2nhex.o \
	$(DDOBJ)/d_inttodec.o	$(DDOBJ)/d_inttohex.o \
	$(DDOBJ)/d_isnumstr.o	$(DDOBJ)/d_isspacenstr.o \
	$(DDOBJ)/d_isspacestr.o	$(DDOBJ)/d_leftalign.o \
	$(DDOBJ)/d_mkstr.o	$(DDOBJ)/d_mkstradd.o \
	$(DDOBJ)/d_ndec2int.o	$(DDOBJ)/d_nhex2int.o \
	$(DDOBJ)/d_nstr2d.o	$(DDOBJ)/d_nstradd.o \
	$(DDOBJ)/d_nstradd2.o	$(DDOBJ)/d_rightalign.o \
	$(DDOBJ)/d_strendnull.o	$(DDOBJ)/d_strsort.o \
	$(DDOBJ)/d_umask.o	$(DDOBJ)/e_addsigact.o \
	$(DDOBJ)/e_alldayget.o	$(DDOBJ)/e_cdate2form.o \
	$(DDOBJ)/e_chkdate.o	$(DDOBJ)/e_cmdarg.o \
	$(DDOBJ)/e_date2jul.o	$(DDOBJ)/e_datechk.o \
	$(DDOBJ)/e_dates2du.o \
	$(DDOBJ)/e_datecmp.o	$(DDOBJ)/e_day2nday.o \
	$(DDOBJ)/e_delenv.o	$(DDOBJ)/e_dudate.o \
	$(DDOBJ)/e_fullyear.o	$(DDOBJ)/e_gdate2date.o \
	$(DDOBJ)/e_gdate2year.o	$(DDOBJ)/e_gdatebydu.o \
	$(DDOBJ)/e_getdatestr.o	$(DDOBJ)/e_getenv.o \
	$(DDOBJ)/e_getweekday.o	\
	$(DDOBJ)/e_getsysdate.o	$(DDOBJ)/e_gettime.o \
	$(DDOBJ)/e_getyear.o	$(DDOBJ)/e_gmontbydu.o \
	$(DDOBJ)/e_gre2jul.o	$(DDOBJ)/e_jul2date.o \
	$(DDOBJ)/e_jul2gre.o	$(DDOBJ)/e_lstdayget.o \
	$(DDOBJ)/e_nextday.o	$(DDOBJ)/e_nextmonth.o \
	$(DDOBJ)/e_prevday.o	$(DDOBJ)/e_prevmonth.o \
	$(DDOBJ)/e_runp.o	$(DDOBJ)/e_runsys.o \
	$(DDOBJ)/e_setenv.o	$(DDOBJ)/e_sighandle.o \
	$(DDOBJ)/e_sleep0001.o	$(DDOBJ)/e_timegap.o \
	$(DDOBJ)/f_chmod.o	$(DDOBJ)/f_chown.o \
	$(DDOBJ)/f_getenv.o	$(DDOBJ)/f_getfpath.o \
	$(DDOBJ)/f_lock.o	$(DDOBJ)/f_lockwait.o \
	$(DDOBJ)/f_mkdir.o	$(DDOBJ)/f_setenv.o \
	$(DDOBJ)/f_unlock.o	$(DDOBJ)/f_copy.o \
	$(DDOBJ)/fifofun.o \
	$(DDOBJ)/h_errno.o	$(DDOBJ)/k_acceptstr.o \
	$(DDOBJ)/k_getchar.o	$(DDOBJ)/k_inpnnumeric.o \
	$(DDOBJ)/k_inpnstring.o	$(DDOBJ)/l_allday2date.o \
	$(DDOBJ)/l_allday2get.o	$(DDOBJ)/l_datechkconv.o \
	$(DDOBJ)/l_lstdaychkget.o	$(DDOBJ)/l_pickdata.o \
	$(DDOBJ)/l_readline.o	$(DDOBJ)/r_chkshm.o \
	$(DDOBJ)/r_crtshm.o	$(DDOBJ)/r_delshm.o \
	$(DDOBJ)/r_execprg.o	$(DDOBJ)/r_getshm.o \
	$(DDOBJ)/r_runcont.o	$(DDOBJ)/r_runwait.o \
	$(DDOBJ)/ringfun.o	$(DDOBJ)/s_readstream.o \
	$(DDOBJ)/s_select.o	$(DDOBJ)/s_writestream.o \
	$(DDOBJ)/tracelog.o	$(DDOBJ)/l_gpssethyerrno.o \
	$(DDOBJ)/hymsg.o	$(DDOBJ)/e_runpsts.o \
	$(DDOBJ)/e_runsyssts.o

#	d_julsa		# delete for unlink libm
#	l_ntchmod	# #######
#	l_ntchown	# #######

all	: echo $(RUNUX)/lib/libgps.a $(RUNUX)/lib/libgps.$(MAKESLN)

echo		:
	@echo	HYPUB/LIBSRC/GPS$(ECHOLANG)

$(RUNUX)/lib/libgps.a		: $(STATIC_OBJS)
	ar vcr $(RUNUX)/lib/libgps.a $(STATIC_OBJS)

$(RUNUX)/lib/libgps.$(MAKESLN)	: $(DYNAMIC_OBJS)
	$(GENSL) -o $(RUNUX)/lib/libgps.$(MAKESLN) $(MAKESL) $(DYNAMIC_OBJS)


$(SDOBJ)/OD_ADJNDECIMAL.o	: OD_ADJNDECIMAL.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_ADJNDECIMAL.o $(CFLAGS) -c OD_ADJNDECIMAL.c

$(SDOBJ)/OD_DECTOINT.o		: OD_DECTOINT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_DECTOINT.o $(CFLAGS) -c OD_DECTOINT.c

$(SDOBJ)/OD_FILLDATA.o		: OD_FILLDATA.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_FILLDATA.o $(CFLAGS) -c OD_FILLDATA.c

$(SDOBJ)/OD_FILLFORM.o		: OD_FILLFORM.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_FILLFORM.o $(CFLAGS) -c OD_FILLFORM.c

$(SDOBJ)/OD_FMASK.o		: OD_FMASK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_FMASK.o $(CFLAGS) -c OD_FMASK.c

$(SDOBJ)/OD_HANADJT.o		: OD_HANADJT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_HANADJT.o $(CFLAGS) -c OD_HANADJT.c

$(SDOBJ)/OD_HEXTOINT.o		: OD_HEXTOINT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_HEXTOINT.o $(CFLAGS) -c OD_HEXTOINT.c

$(SDOBJ)/OD_IMASK.o		: OD_IMASK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_IMASK.o $(CFLAGS) -c OD_IMASK.c

$(SDOBJ)/OD_INT2NDEC.o		: OD_INT2NDEC.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_INT2NDEC.o $(CFLAGS) -c OD_INT2NDEC.c

$(SDOBJ)/OD_INT2NHEX.o		: OD_INT2NHEX.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_INT2NHEX.o $(CFLAGS) -c OD_INT2NHEX.c

$(SDOBJ)/OD_INTTODEC.o		: OD_INTTODEC.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_INTTODEC.o $(CFLAGS) -c OD_INTTODEC.c

$(SDOBJ)/OD_INTTOHEX.o		: OD_INTTOHEX.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_INTTOHEX.o $(CFLAGS) -c OD_INTTOHEX.c

$(SDOBJ)/OD_ISSPACENSTR.o	: OD_ISSPACENSTR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_ISSPACENSTR.o $(CFLAGS) -c OD_ISSPACENSTR.c

$(SDOBJ)/OD_LEFTALIGN.o		: OD_LEFTALIGN.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_LEFTALIGN.o $(CFLAGS) -c OD_LEFTALIGN.c

$(SDOBJ)/OD_MKSTR.o		: OD_MKSTR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_MKSTR.o $(CFLAGS) -c OD_MKSTR.c

$(SDOBJ)/OD_MKSTRADD.o		: OD_MKSTRADD.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_MKSTRADD.o $(CFLAGS) -c OD_MKSTRADD.c

$(SDOBJ)/OD_NDECTOINT.o		: OD_NDECTOINT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_NDECTOINT.o $(CFLAGS) -c OD_NDECTOINT.c

$(SDOBJ)/OD_NSTRADD.o		: OD_NSTRADD.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_NSTRADD.o $(CFLAGS) -c OD_NSTRADD.c

$(SDOBJ)/OD_NSTRADD2.o		: OD_NSTRADD2.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_NSTRADD2.o $(CFLAGS) -c OD_NSTRADD2.c

$(SDOBJ)/OD_RIGHTALIGN.o	: OD_RIGHTALIGN.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_RIGHTALIGN.o $(CFLAGS) -c OD_RIGHTALIGN.c

$(SDOBJ)/OD_STRENDNULL.o	: OD_STRENDNULL.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_STRENDNULL.o $(CFLAGS) -c OD_STRENDNULL.c

$(SDOBJ)/OD_STRNCAT.o		: OD_STRNCAT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_STRNCAT.o $(CFLAGS) -c OD_STRNCAT.c

$(SDOBJ)/OD_STRSORT.o		: OD_STRSORT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_STRSORT.o $(CFLAGS) -c OD_STRSORT.c

$(SDOBJ)/OD_UMASK.o		: OD_UMASK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OD_UMASK.o $(CFLAGS) -c OD_UMASK.c

$(SDOBJ)/OE_ALLDAYGET.o		: OE_ALLDAYGET.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_ALLDAYGET.o $(CFLAGS) -c OE_ALLDAYGET.c

$(SDOBJ)/OE_CHKDATE.o		: OE_CHKDATE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_CHKDATE.o $(CFLAGS) -c OE_CHKDATE.c

$(SDOBJ)/OE_DATE2JUL.o		: OE_DATE2JUL.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_DATE2JUL.o $(CFLAGS) -c OE_DATE2JUL.c

$(SDOBJ)/OE_DATECHK.o		: OE_DATECHK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_DATECHK.o $(CFLAGS) -c OE_DATECHK.c

$(SDOBJ)/OE_DATECMP.o		: OE_DATECMP.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_DATECMP.o $(CFLAGS) -c OE_DATECMP.c

$(SDOBJ)/OE_DUDATE.o		: OE_DUDATE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_DUDATE.o $(CFLAGS) -c OE_DUDATE.c

$(SDOBJ)/OE_FULLYEAR.o		: OE_FULLYEAR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_FULLYEAR.o $(CFLAGS) -c OE_FULLYEAR.c

$(SDOBJ)/OE_GDATE2DATE.o	: OE_GDATE2DATE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GDATE2DATE.o $(CFLAGS) -c OE_GDATE2DATE.c

$(SDOBJ)/OE_GDATE2YEAR.o	: OE_GDATE2YEAR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GDATE2YEAR.o $(CFLAGS) -c OE_GDATE2YEAR.c

$(SDOBJ)/OE_GDATEBYDU.o		: OE_GDATEBYDU.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GDATEBYDU.o $(CFLAGS) -c OE_GDATEBYDU.c

$(SDOBJ)/OE_GETENV.o		: OE_GETENV.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GETENV.o $(CFLAGS) -c OE_GETENV.c

$(SDOBJ)/OE_GETSYSTIME.o	: OE_GETSYSTIME.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GETSYSTIME.o $(CFLAGS) -c OE_GETSYSTIME.c

$(SDOBJ)/OE_GETWEEKDAY.o	: OE_GETWEEKDAY.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GETWEEKDAY.o $(CFLAGS) -c OE_GETWEEKDAY.c

$(SDOBJ)/OE_GETYEAR.o		: OE_GETYEAR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GETYEAR.o $(CFLAGS) -c OE_GETYEAR.c

$(SDOBJ)/OE_GMONTBYDU.o		: OE_GMONTBYDU.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GMONTBYDU.o $(CFLAGS) -c OE_GMONTBYDU.c

$(SDOBJ)/OE_GRE2JUL.o		: OE_GRE2JUL.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_GRE2JUL.o $(CFLAGS) -c OE_GRE2JUL.c

$(SDOBJ)/OE_JUL2DATE.o		: OE_JUL2DATE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_JUL2DATE.o $(CFLAGS) -c OE_JUL2DATE.c

$(SDOBJ)/OE_JUL2GRE.o		: OE_JUL2GRE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_JUL2GRE.o $(CFLAGS) -c OE_JUL2GRE.c

$(SDOBJ)/OE_LSTDAYGET.o		: OE_LSTDAYGET.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_LSTDAYGET.o $(CFLAGS) -c OE_LSTDAYGET.c

$(SDOBJ)/OE_NEXTDAY.o		: OE_NEXTDAY.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_NEXTDAY.o $(CFLAGS) -c OE_NEXTDAY.c

$(SDOBJ)/OE_NEXTMONTH.o		: OE_NEXTMONTH.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_NEXTMONTH.o $(CFLAGS) -c OE_NEXTMONTH.c

$(SDOBJ)/OE_PREVDAY.o		: OE_PREVDAY.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_PREVDAY.o $(CFLAGS) -c OE_PREVDAY.c

$(SDOBJ)/OE_PREVMONTH.o		: OE_PREVMONTH.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_PREVMONTH.o $(CFLAGS) -c OE_PREVMONTH.c

$(SDOBJ)/OE_RUNSYS.o		: OE_RUNSYS.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_RUNSYS.o $(CFLAGS) -c OE_RUNSYS.c

$(SDOBJ)/OE_SLEEP0001.o		: OE_SLEEP0001.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_SLEEP0001.o $(CFLAGS) -c OE_SLEEP0001.c

$(SDOBJ)/OE_RUNSYSSTS.o		: OE_RUNSYSSTS.c $(HEADER)
	$(CC) -o $(SDOBJ)/OE_RUNSYSSTS.o $(CFLAGS) -c OE_RUNSYSSTS.c

$(SDOBJ)/OF_CHMOD.o		: OF_CHMOD.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_CHMOD.o $(CFLAGS) -c OF_CHMOD.c

$(SDOBJ)/OF_CHOWN.o		: OF_CHOWN.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_CHOWN.o $(CFLAGS) -c OF_CHOWN.c

$(SDOBJ)/OF_GETENV.o		: OF_GETENV.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_GETENV.o $(CFLAGS) -c OF_GETENV.c

$(SDOBJ)/OF_GETFPATH.o		: OF_GETFPATH.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_GETFPATH.o $(CFLAGS) -c OF_GETFPATH.c

$(SDOBJ)/OF_LOCK.o		: OF_LOCK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_LOCK.o $(CFLAGS) -c OF_LOCK.c

$(SDOBJ)/OF_LOCKWAIT.o		: OF_LOCKWAIT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_LOCKWAIT.o $(CFLAGS) -c OF_LOCKWAIT.c

$(SDOBJ)/OF_TEMPNAM.o		: OF_TEMPNAM.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_TEMPNAM.o $(CFLAGS) -c OF_TEMPNAM.c

$(SDOBJ)/OF_UNLINK.o		: OF_UNLINK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_UNLINK.o $(CFLAGS) -c OF_UNLINK.c

$(SDOBJ)/OF_UNLOCK.o		: OF_UNLOCK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_UNLOCK.o $(CFLAGS) -c OF_UNLOCK.c

$(SDOBJ)/OF_COPY.o		: OF_COPY.c $(HEADER)
	$(CC) -o $(SDOBJ)/OF_COPY.o $(CFLAGS) -c OF_COPY.c

$(SDOBJ)/OK_ACCEPTSTR.o		: OK_ACCEPTSTR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OK_ACCEPTSTR.o $(CFLAGS) -c OK_ACCEPTSTR.c

$(SDOBJ)/OK_GETCHAR.o		: OK_GETCHAR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OK_GETCHAR.o $(CFLAGS) -c OK_GETCHAR.c

$(SDOBJ)/OK_INPNNUMERIC.o	: OK_INPNNUMERIC.c $(HEADER)
	$(CC) -o $(SDOBJ)/OK_INPNNUMERIC.o $(CFLAGS) -c OK_INPNNUMERIC.c

$(SDOBJ)/OK_INPNSTRING.o	: OK_INPNSTRING.c $(HEADER)
	$(CC) -o $(SDOBJ)/OK_INPNSTRING.o $(CFLAGS) -c OK_INPNSTRING.c

$(SDOBJ)/OR_EXECPRG.o		: OR_EXECPRG.c $(HEADER)
	$(CC) -o $(SDOBJ)/OR_EXECPRG.o $(CFLAGS) -c OR_EXECPRG.c

$(SDOBJ)/OR_RUNCONT.o		: OR_RUNCONT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OR_RUNCONT.o $(CFLAGS) -c OR_RUNCONT.c

$(SDOBJ)/OR_RUNWAIT.o		: OR_RUNWAIT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OR_RUNWAIT.o $(CFLAGS) -c OR_RUNWAIT.c

$(SDOBJ)/cfgfun.o		: cfgfun.c $(HEADER)
	$(CC) -o $(SDOBJ)/cfgfun.o $(CFLAGS) -c cfgfun.c

$(SDOBJ)/d_adjndecimal.o	: d_adjndecimal.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_adjndecimal.o $(CFLAGS) -c d_adjndecimal.c

$(SDOBJ)/d_d2nstr.o		: d_d2nstr.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_d2nstr.o $(CFLAGS) -c d_d2nstr.c

$(SDOBJ)/d_dectoint.o		: d_dectoint.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_dectoint.o $(CFLAGS) -c d_dectoint.c

$(SDOBJ)/d_filldata.o		: d_filldata.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_filldata.o $(CFLAGS) -c d_filldata.c

$(SDOBJ)/d_fillform.o		: d_fillform.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_fillform.o $(CFLAGS) -c d_fillform.c

$(SDOBJ)/d_fmask.o		: d_fmask.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_fmask.o $(CFLAGS) -c d_fmask.c

$(SDOBJ)/d_hanadjt.o		: d_hanadjt.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_hanadjt.o $(CFLAGS) -c d_hanadjt.c

$(SDOBJ)/d_hextoint.o		: d_hextoint.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_hextoint.o $(CFLAGS) -c d_hextoint.c

$(SDOBJ)/d_imask.o		: d_imask.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_imask.o $(CFLAGS) -c d_imask.c

$(SDOBJ)/d_int2ndec.o		: d_int2ndec.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_int2ndec.o $(CFLAGS) -c d_int2ndec.c

$(SDOBJ)/d_int2nhex.o		: d_int2nhex.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_int2nhex.o $(CFLAGS) -c d_int2nhex.c

$(SDOBJ)/d_inttodec.o		: d_inttodec.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_inttodec.o $(CFLAGS) -c d_inttodec.c

$(SDOBJ)/d_inttohex.o		: d_inttohex.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_inttohex.o $(CFLAGS) -c d_inttohex.c

$(SDOBJ)/d_isnumstr.o		: d_isnumstr.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_isnumstr.o $(CFLAGS) -c d_isnumstr.c

$(SDOBJ)/d_isspacenstr.o	: d_isspacenstr.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_isspacenstr.o $(CFLAGS) -c d_isspacenstr.c

$(SDOBJ)/d_isspacestr.o		: d_isspacestr.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_isspacestr.o $(CFLAGS) -c d_isspacestr.c

$(SDOBJ)/d_leftalign.o		: d_leftalign.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_leftalign.o $(CFLAGS) -c d_leftalign.c

$(SDOBJ)/d_mkstr.o		: d_mkstr.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_mkstr.o $(CFLAGS) -c d_mkstr.c

$(SDOBJ)/d_mkstradd.o		: d_mkstradd.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_mkstradd.o $(CFLAGS) -c d_mkstradd.c

$(SDOBJ)/d_ndec2int.o		: d_ndec2int.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_ndec2int.o $(CFLAGS) -c d_ndec2int.c

$(SDOBJ)/d_nhex2int.o		: d_nhex2int.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_nhex2int.o $(CFLAGS) -c d_nhex2int.c

$(SDOBJ)/d_nstr2d.o		: d_nstr2d.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_nstr2d.o $(CFLAGS) -c d_nstr2d.c

$(SDOBJ)/d_nstradd.o		: d_nstradd.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_nstradd.o $(CFLAGS) -c d_nstradd.c

$(SDOBJ)/d_nstradd2.o		: d_nstradd2.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_nstradd2.o $(CFLAGS) -c d_nstradd2.c

$(SDOBJ)/d_rightalign.o		: d_rightalign.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_rightalign.o $(CFLAGS) -c d_rightalign.c

$(SDOBJ)/d_strendnull.o		: d_strendnull.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_strendnull.o $(CFLAGS) -c d_strendnull.c

$(SDOBJ)/d_strsort.o		: d_strsort.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_strsort.o $(CFLAGS) -c d_strsort.c

$(SDOBJ)/d_umask.o		: d_umask.c $(HEADER)
	$(CC) -o $(SDOBJ)/d_umask.o $(CFLAGS) -c d_umask.c

$(SDOBJ)/e_addsigact.o		: e_addsigact.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_addsigact.o $(CFLAGS) -c e_addsigact.c

$(SDOBJ)/e_alldayget.o		: e_alldayget.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_alldayget.o $(CFLAGS) -c e_alldayget.c

$(SDOBJ)/e_cdate2form.o		: e_cdate2form.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_cdate2form.o $(CFLAGS) -c e_cdate2form.c

$(SDOBJ)/e_chkdate.o		: e_chkdate.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_chkdate.o $(CFLAGS) -c e_chkdate.c

$(SDOBJ)/e_cmdarg.o		: e_cmdarg.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_cmdarg.o $(CFLAGS) -c e_cmdarg.c

$(SDOBJ)/e_date2jul.o		: e_date2jul.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_date2jul.o $(CFLAGS) -c e_date2jul.c

$(SDOBJ)/e_datechk.o		: e_datechk.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_datechk.o $(CFLAGS) -c e_datechk.c

$(SDOBJ)/e_dates2du.o		: e_dates2du.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_dates2du.o $(CFLAGS) -c e_dates2du.c

$(SDOBJ)/e_datecmp.o		: e_datecmp.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_datecmp.o $(CFLAGS) -c e_datecmp.c

$(SDOBJ)/e_day2nday.o		: e_day2nday.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_day2nday.o $(CFLAGS) -c e_day2nday.c

$(SDOBJ)/e_delenv.o		: e_delenv.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_delenv.o $(CFLAGS) -c e_delenv.c

$(SDOBJ)/e_dudate.o		: e_dudate.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_dudate.o $(CFLAGS) -c e_dudate.c

$(SDOBJ)/e_fullyear.o		: e_fullyear.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_fullyear.o $(CFLAGS) -c e_fullyear.c

$(SDOBJ)/e_gdate2date.o		: e_gdate2date.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_gdate2date.o $(CFLAGS) -c e_gdate2date.c

$(SDOBJ)/e_gdate2year.o		: e_gdate2year.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_gdate2year.o $(CFLAGS) -c e_gdate2year.c

$(SDOBJ)/e_gdatebydu.o		: e_gdatebydu.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_gdatebydu.o $(CFLAGS) -c e_gdatebydu.c

$(SDOBJ)/e_getdatestr.o		: e_getdatestr.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_getdatestr.o $(CFLAGS) -c e_getdatestr.c

$(SDOBJ)/e_getenv.o		: e_getenv.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_getenv.o $(CFLAGS) -c e_getenv.c

$(SDOBJ)/e_getsysdate.o		: e_getsysdate.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_getsysdate.o $(CFLAGS) -c e_getsysdate.c

$(SDOBJ)/e_gettime.o		: e_gettime.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_gettime.o $(CFLAGS) -c e_gettime.c

$(SDOBJ)/e_getweekday.o		: e_getweekday.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_getweekday.o $(CFLAGS) -c e_getweekday.c

$(SDOBJ)/e_getyear.o		: e_getyear.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_getyear.o $(CFLAGS) -c e_getyear.c

$(SDOBJ)/e_gmontbydu.o		: e_gmontbydu.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_gmontbydu.o $(CFLAGS) -c e_gmontbydu.c

$(SDOBJ)/e_gre2jul.o		: e_gre2jul.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_gre2jul.o $(CFLAGS) -c e_gre2jul.c

$(SDOBJ)/e_jul2date.o		: e_jul2date.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_jul2date.o $(CFLAGS) -c e_jul2date.c

$(SDOBJ)/e_jul2gre.o		: e_jul2gre.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_jul2gre.o $(CFLAGS) -c e_jul2gre.c

$(SDOBJ)/e_lstdayget.o		: e_lstdayget.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_lstdayget.o $(CFLAGS) -c e_lstdayget.c

$(SDOBJ)/e_nextday.o		: e_nextday.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_nextday.o $(CFLAGS) -c e_nextday.c

$(SDOBJ)/e_nextmonth.o		: e_nextmonth.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_nextmonth.o $(CFLAGS) -c e_nextmonth.c

$(SDOBJ)/e_prevday.o		: e_prevday.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_prevday.o $(CFLAGS) -c e_prevday.c

$(SDOBJ)/e_prevmonth.o		: e_prevmonth.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_prevmonth.o $(CFLAGS) -c e_prevmonth.c

$(SDOBJ)/e_runp.o		: e_runp.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_runp.o $(CFLAGS) -c e_runp.c

$(SDOBJ)/e_runsys.o		: e_runsys.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_runsys.o $(CFLAGS) -c e_runsys.c

$(SDOBJ)/e_setenv.o		: e_setenv.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_setenv.o $(CFLAGS) -c e_setenv.c

$(SDOBJ)/e_sighandle.o		: e_sighandle.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_sighandle.o $(CFLAGS) -c e_sighandle.c

$(SDOBJ)/e_sleep0001.o		: e_sleep0001.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_sleep0001.o $(CFLAGS) -c e_sleep0001.c

$(SDOBJ)/e_timegap.o		: e_timegap.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_timegap.o $(CFLAGS) -c e_timegap.c

$(SDOBJ)/f_chmod.o		: f_chmod.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_chmod.o $(CFLAGS) -c f_chmod.c

$(SDOBJ)/f_chown.o		: f_chown.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_chown.o $(CFLAGS) -c f_chown.c

$(SDOBJ)/f_getenv.o		: f_getenv.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_getenv.o $(CFLAGS) -c f_getenv.c

$(SDOBJ)/f_getfpath.o		: f_getfpath.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_getfpath.o $(CFLAGS) -c f_getfpath.c

$(SDOBJ)/f_lock.o		: f_lock.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_lock.o $(CFLAGS) -c f_lock.c

$(SDOBJ)/f_lockwait.o		: f_lockwait.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_lockwait.o $(CFLAGS) -c f_lockwait.c

$(SDOBJ)/f_mkdir.o		: f_mkdir.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_mkdir.o $(CFLAGS) -c f_mkdir.c

$(SDOBJ)/f_setenv.o		: f_setenv.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_setenv.o $(CFLAGS) -c f_setenv.c

$(SDOBJ)/f_unlock.o		: f_unlock.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_unlock.o $(CFLAGS) -c f_unlock.c

$(SDOBJ)/f_copy.o		: f_copy.c $(HEADER)
	$(CC) -o $(SDOBJ)/f_copy.o $(CFLAGS) -c f_copy.c

$(SDOBJ)/fifofun.o		: fifofun.c $(HEADER)
	$(CC) -o $(SDOBJ)/fifofun.o $(CFLAGS) -c fifofun.c

$(SDOBJ)/h_errno.o		: h_errno.c $(HEADER)
	$(CC) -o $(SDOBJ)/h_errno.o $(CFLAGS) -c h_errno.c

$(SDOBJ)/k_acceptstr.o		: k_acceptstr.c $(HEADER)
	$(CC) -o $(SDOBJ)/k_acceptstr.o $(CFLAGS) -c k_acceptstr.c

$(SDOBJ)/k_getchar.o		: k_getchar.c $(HEADER)
	$(CC) -o $(SDOBJ)/k_getchar.o $(CFLAGS) -c k_getchar.c

$(SDOBJ)/k_inpnnumeric.o	: k_inpnnumeric.c $(HEADER)
	$(CC) -o $(SDOBJ)/k_inpnnumeric.o $(CFLAGS) -c k_inpnnumeric.c

$(SDOBJ)/k_inpnstring.o		: k_inpnstring.c $(HEADER)
	$(CC) -o $(SDOBJ)/k_inpnstring.o $(CFLAGS) -c k_inpnstring.c

$(SDOBJ)/l_allday2date.o		: l_allday2date.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_allday2date.o $(CFLAGS) -c l_allday2date.c

$(SDOBJ)/l_allday2get.o		: l_allday2get.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_allday2get.o $(CFLAGS) -c l_allday2get.c

$(SDOBJ)/l_datechkconv.o	: l_datechkconv.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_datechkconv.o $(CFLAGS) -c l_datechkconv.c

$(SDOBJ)/l_lstdaychkget.o	: l_lstdaychkget.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_lstdaychkget.o $(CFLAGS) -c l_lstdaychkget.c

$(SDOBJ)/l_pickdata.o		: l_pickdata.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_pickdata.o $(CFLAGS) -c l_pickdata.c

$(SDOBJ)/l_readline.o		: l_readline.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_readline.o $(CFLAGS) -c l_readline.c

$(SDOBJ)/r_chkshm.o		: r_chkshm.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_chkshm.o $(CFLAGS) -c r_chkshm.c

$(SDOBJ)/r_crtshm.o		: r_crtshm.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_crtshm.o $(CFLAGS) -c r_crtshm.c

$(SDOBJ)/r_delshm.o		: r_delshm.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_delshm.o $(CFLAGS) -c r_delshm.c

$(SDOBJ)/r_execprg.o		: r_execprg.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_execprg.o $(CFLAGS) -c r_execprg.c

$(SDOBJ)/r_getshm.o		: r_getshm.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_getshm.o $(CFLAGS) -c r_getshm.c

$(SDOBJ)/r_runcont.o		: r_runcont.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_runcont.o $(CFLAGS) -c r_runcont.c

$(SDOBJ)/r_runwait.o		: r_runwait.c $(HEADER)
	$(CC) -o $(SDOBJ)/r_runwait.o $(CFLAGS) -c r_runwait.c

$(SDOBJ)/ringfun.o		: ringfun.c $(HEADER)
	$(CC) -o $(SDOBJ)/ringfun.o $(CFLAGS) -c ringfun.c

$(SDOBJ)/s_readstream.o		: s_readstream.c $(HEADER)
	$(CC) -o $(SDOBJ)/s_readstream.o $(CFLAGS) -c s_readstream.c

$(SDOBJ)/s_select.o		: s_select.c $(HEADER)
	$(CC) -o $(SDOBJ)/s_select.o $(CFLAGS) -c s_select.c

$(SDOBJ)/s_writestream.o	: s_writestream.c $(HEADER)
	$(CC) -o $(SDOBJ)/s_writestream.o $(CFLAGS) -c s_writestream.c

$(SDOBJ)/tracelog.o		: tracelog.c $(HEADER)
	$(CC) -o $(SDOBJ)/tracelog.o $(CFLAGS) -c tracelog.c

$(SDOBJ)/l_gpssethyerrno.o		: l_gpssethyerrno.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_gpssethyerrno.o $(CFLAGS) -c l_gpssethyerrno.c

$(SDOBJ)/hymsg.o		: hymsg.c $(HEADER)
	$(CC) -o $(SDOBJ)/hymsg.o $(CFLAGS) -c hymsg.c

$(SDOBJ)/e_runpsts.o		: e_runpsts.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_runpsts.o $(CFLAGS) -c e_runpsts.c

$(SDOBJ)/e_runsyssts.o		: e_runsyssts.c $(HEADER)
	$(CC) -o $(SDOBJ)/e_runsyssts.o $(CFLAGS) -c e_runsyssts.c


$(DDOBJ)/OD_ADJNDECIMAL.o	: OD_ADJNDECIMAL.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_ADJNDECIMAL.o $(MAKESLO) $(CFLAGS) -c OD_ADJNDECIMAL.c

$(DDOBJ)/OD_DECTOINT.o		: OD_DECTOINT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_DECTOINT.o $(MAKESLO) $(CFLAGS) -c OD_DECTOINT.c

$(DDOBJ)/OD_FILLDATA.o		: OD_FILLDATA.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_FILLDATA.o $(MAKESLO) $(CFLAGS) -c OD_FILLDATA.c

$(DDOBJ)/OD_FILLFORM.o		: OD_FILLFORM.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_FILLFORM.o $(MAKESLO) $(CFLAGS) -c OD_FILLFORM.c

$(DDOBJ)/OD_FMASK.o		: OD_FMASK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_FMASK.o $(MAKESLO) $(CFLAGS) -c OD_FMASK.c

$(DDOBJ)/OD_HANADJT.o		: OD_HANADJT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_HANADJT.o $(MAKESLO) $(CFLAGS) -c OD_HANADJT.c

$(DDOBJ)/OD_HEXTOINT.o		: OD_HEXTOINT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_HEXTOINT.o $(MAKESLO) $(CFLAGS) -c OD_HEXTOINT.c

$(DDOBJ)/OD_IMASK.o		: OD_IMASK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_IMASK.o $(MAKESLO) $(CFLAGS) -c OD_IMASK.c

$(DDOBJ)/OD_INT2NDEC.o		: OD_INT2NDEC.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_INT2NDEC.o $(MAKESLO) $(CFLAGS) -c OD_INT2NDEC.c

$(DDOBJ)/OD_INT2NHEX.o		: OD_INT2NHEX.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_INT2NHEX.o $(MAKESLO) $(CFLAGS) -c OD_INT2NHEX.c

$(DDOBJ)/OD_INTTODEC.o		: OD_INTTODEC.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_INTTODEC.o $(MAKESLO) $(CFLAGS) -c OD_INTTODEC.c

$(DDOBJ)/OD_INTTOHEX.o		: OD_INTTOHEX.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_INTTOHEX.o $(MAKESLO) $(CFLAGS) -c OD_INTTOHEX.c

$(DDOBJ)/OD_ISSPACENSTR.o	: OD_ISSPACENSTR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_ISSPACENSTR.o $(MAKESLO) $(CFLAGS) -c OD_ISSPACENSTR.c

$(DDOBJ)/OD_LEFTALIGN.o		: OD_LEFTALIGN.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_LEFTALIGN.o $(MAKESLO) $(CFLAGS) -c OD_LEFTALIGN.c

$(DDOBJ)/OD_MKSTR.o		: OD_MKSTR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_MKSTR.o $(MAKESLO) $(CFLAGS) -c OD_MKSTR.c

$(DDOBJ)/OD_MKSTRADD.o		: OD_MKSTRADD.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_MKSTRADD.o $(MAKESLO) $(CFLAGS) -c OD_MKSTRADD.c

$(DDOBJ)/OD_NDECTOINT.o		: OD_NDECTOINT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_NDECTOINT.o $(MAKESLO) $(CFLAGS) -c OD_NDECTOINT.c

$(DDOBJ)/OD_NSTRADD.o		: OD_NSTRADD.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_NSTRADD.o $(MAKESLO) $(CFLAGS) -c OD_NSTRADD.c

$(DDOBJ)/OD_NSTRADD2.o		: OD_NSTRADD2.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_NSTRADD2.o $(MAKESLO) $(CFLAGS) -c OD_NSTRADD2.c

$(DDOBJ)/OD_RIGHTALIGN.o	: OD_RIGHTALIGN.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_RIGHTALIGN.o $(MAKESLO) $(CFLAGS) -c OD_RIGHTALIGN.c

$(DDOBJ)/OD_STRENDNULL.o	: OD_STRENDNULL.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_STRENDNULL.o $(MAKESLO) $(CFLAGS) -c OD_STRENDNULL.c

$(DDOBJ)/OD_STRNCAT.o		: OD_STRNCAT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_STRNCAT.o $(MAKESLO) $(CFLAGS) -c OD_STRNCAT.c

$(DDOBJ)/OD_STRSORT.o		: OD_STRSORT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_STRSORT.o $(MAKESLO) $(CFLAGS) -c OD_STRSORT.c

$(DDOBJ)/OD_UMASK.o		: OD_UMASK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OD_UMASK.o $(MAKESLO) $(CFLAGS) -c OD_UMASK.c

$(DDOBJ)/OE_ALLDAYGET.o		: OE_ALLDAYGET.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_ALLDAYGET.o $(MAKESLO) $(CFLAGS) -c OE_ALLDAYGET.c

$(DDOBJ)/OE_CHKDATE.o		: OE_CHKDATE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_CHKDATE.o $(MAKESLO) $(CFLAGS) -c OE_CHKDATE.c

$(DDOBJ)/OE_DATE2JUL.o		: OE_DATE2JUL.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_DATE2JUL.o $(MAKESLO) $(CFLAGS) -c OE_DATE2JUL.c

$(DDOBJ)/OE_DATECHK.o		: OE_DATECHK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_DATECHK.o $(MAKESLO) $(CFLAGS) -c OE_DATECHK.c

$(DDOBJ)/OE_DATECMP.o		: OE_DATECMP.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_DATECMP.o $(MAKESLO) $(CFLAGS) -c OE_DATECMP.c

$(DDOBJ)/OE_DUDATE.o		: OE_DUDATE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_DUDATE.o $(MAKESLO) $(CFLAGS) -c OE_DUDATE.c

$(DDOBJ)/OE_FULLYEAR.o		: OE_FULLYEAR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_FULLYEAR.o $(MAKESLO) $(CFLAGS) -c OE_FULLYEAR.c

$(DDOBJ)/OE_GDATE2DATE.o	: OE_GDATE2DATE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GDATE2DATE.o $(MAKESLO) $(CFLAGS) -c OE_GDATE2DATE.c

$(DDOBJ)/OE_GDATE2YEAR.o	: OE_GDATE2YEAR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GDATE2YEAR.o $(MAKESLO) $(CFLAGS) -c OE_GDATE2YEAR.c

$(DDOBJ)/OE_GDATEBYDU.o		: OE_GDATEBYDU.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GDATEBYDU.o $(MAKESLO) $(CFLAGS) -c OE_GDATEBYDU.c

$(DDOBJ)/OE_GETENV.o		: OE_GETENV.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GETENV.o $(MAKESLO) $(CFLAGS) -c OE_GETENV.c

$(DDOBJ)/OE_GETSYSTIME.o	: OE_GETSYSTIME.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GETSYSTIME.o $(MAKESLO) $(CFLAGS) -c OE_GETSYSTIME.c

$(DDOBJ)/OE_GETWEEKDAY.o	: OE_GETWEEKDAY.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GETWEEKDAY.o $(MAKESLO) $(CFLAGS) -c OE_GETWEEKDAY.c

$(DDOBJ)/OE_GETYEAR.o		: OE_GETYEAR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GETYEAR.o $(MAKESLO) $(CFLAGS) -c OE_GETYEAR.c

$(DDOBJ)/OE_GMONTBYDU.o		: OE_GMONTBYDU.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GMONTBYDU.o $(MAKESLO) $(CFLAGS) -c OE_GMONTBYDU.c

$(DDOBJ)/OE_GRE2JUL.o		: OE_GRE2JUL.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_GRE2JUL.o $(MAKESLO) $(CFLAGS) -c OE_GRE2JUL.c

$(DDOBJ)/OE_JUL2DATE.o		: OE_JUL2DATE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_JUL2DATE.o $(MAKESLO) $(CFLAGS) -c OE_JUL2DATE.c

$(DDOBJ)/OE_JUL2GRE.o		: OE_JUL2GRE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_JUL2GRE.o $(MAKESLO) $(CFLAGS) -c OE_JUL2GRE.c

$(DDOBJ)/OE_LSTDAYGET.o		: OE_LSTDAYGET.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_LSTDAYGET.o $(MAKESLO) $(CFLAGS) -c OE_LSTDAYGET.c

$(DDOBJ)/OE_NEXTDAY.o		: OE_NEXTDAY.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_NEXTDAY.o $(MAKESLO) $(CFLAGS) -c OE_NEXTDAY.c

$(DDOBJ)/OE_NEXTMONTH.o		: OE_NEXTMONTH.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_NEXTMONTH.o $(MAKESLO) $(CFLAGS) -c OE_NEXTMONTH.c

$(DDOBJ)/OE_PREVDAY.o		: OE_PREVDAY.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_PREVDAY.o $(MAKESLO) $(CFLAGS) -c OE_PREVDAY.c

$(DDOBJ)/OE_PREVMONTH.o		: OE_PREVMONTH.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_PREVMONTH.o $(MAKESLO) $(CFLAGS) -c OE_PREVMONTH.c

$(DDOBJ)/OE_RUNSYS.o		: OE_RUNSYS.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_RUNSYS.o $(MAKESLO) $(CFLAGS) -c OE_RUNSYS.c

$(DDOBJ)/OE_SLEEP0001.o		: OE_SLEEP0001.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_SLEEP0001.o $(MAKESLO) $(CFLAGS) -c OE_SLEEP0001.c

$(DDOBJ)/OE_RUNSYSSTS.o		: OE_RUNSYSSTS.c $(HEADER)
	$(CC) -o $(DDOBJ)/OE_RUNSYSSTS.o $(MAKESLO) $(CFLAGS) -c OE_RUNSYSSTS.c

$(DDOBJ)/OF_CHMOD.o		: OF_CHMOD.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_CHMOD.o $(MAKESLO) $(CFLAGS) -c OF_CHMOD.c

$(DDOBJ)/OF_CHOWN.o		: OF_CHOWN.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_CHOWN.o $(MAKESLO) $(CFLAGS) -c OF_CHOWN.c

$(DDOBJ)/OF_GETENV.o		: OF_GETENV.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_GETENV.o $(MAKESLO) $(CFLAGS) -c OF_GETENV.c

$(DDOBJ)/OF_GETFPATH.o		: OF_GETFPATH.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_GETFPATH.o $(MAKESLO) $(CFLAGS) -c OF_GETFPATH.c

$(DDOBJ)/OF_LOCK.o		: OF_LOCK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_LOCK.o $(MAKESLO) $(CFLAGS) -c OF_LOCK.c

$(DDOBJ)/OF_LOCKWAIT.o		: OF_LOCKWAIT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_LOCKWAIT.o $(MAKESLO) $(CFLAGS) -c OF_LOCKWAIT.c

$(DDOBJ)/OF_TEMPNAM.o		: OF_TEMPNAM.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_TEMPNAM.o $(MAKESLO) $(CFLAGS) -c OF_TEMPNAM.c

$(DDOBJ)/OF_UNLINK.o		: OF_UNLINK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_UNLINK.o $(MAKESLO) $(CFLAGS) -c OF_UNLINK.c

$(DDOBJ)/OF_UNLOCK.o		: OF_UNLOCK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_UNLOCK.o $(MAKESLO) $(CFLAGS) -c OF_UNLOCK.c

$(DDOBJ)/OF_COPY.o		: OF_COPY.c $(HEADER)
	$(CC) -o $(DDOBJ)/OF_COPY.o $(MAKESLO) $(CFLAGS) -c OF_COPY.c

$(DDOBJ)/OK_ACCEPTSTR.o		: OK_ACCEPTSTR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OK_ACCEPTSTR.o $(MAKESLO) $(CFLAGS) -c OK_ACCEPTSTR.c

$(DDOBJ)/OK_GETCHAR.o		: OK_GETCHAR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OK_GETCHAR.o $(MAKESLO) $(CFLAGS) -c OK_GETCHAR.c

$(DDOBJ)/OK_INPNNUMERIC.o	: OK_INPNNUMERIC.c $(HEADER)
	$(CC) -o $(DDOBJ)/OK_INPNNUMERIC.o $(MAKESLO) $(CFLAGS) -c OK_INPNNUMERIC.c

$(DDOBJ)/OK_INPNSTRING.o	: OK_INPNSTRING.c $(HEADER)
	$(CC) -o $(DDOBJ)/OK_INPNSTRING.o $(MAKESLO) $(CFLAGS) -c OK_INPNSTRING.c

$(DDOBJ)/OR_EXECPRG.o		: OR_EXECPRG.c $(HEADER)
	$(CC) -o $(DDOBJ)/OR_EXECPRG.o $(MAKESLO) $(CFLAGS) -c OR_EXECPRG.c

$(DDOBJ)/OR_RUNCONT.o		: OR_RUNCONT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OR_RUNCONT.o $(MAKESLO) $(CFLAGS) -c OR_RUNCONT.c

$(DDOBJ)/OR_RUNWAIT.o		: OR_RUNWAIT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OR_RUNWAIT.o $(MAKESLO) $(CFLAGS) -c OR_RUNWAIT.c

$(DDOBJ)/cfgfun.o		: cfgfun.c $(HEADER)
	$(CC) -o $(DDOBJ)/cfgfun.o $(MAKESLO) $(CFLAGS) -c cfgfun.c

$(DDOBJ)/d_adjndecimal.o	: d_adjndecimal.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_adjndecimal.o $(MAKESLO) $(CFLAGS) -c d_adjndecimal.c

$(DDOBJ)/d_d2nstr.o		: d_d2nstr.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_d2nstr.o $(MAKESLO) $(CFLAGS) -c d_d2nstr.c

$(DDOBJ)/d_dectoint.o		: d_dectoint.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_dectoint.o $(MAKESLO) $(CFLAGS) -c d_dectoint.c

$(DDOBJ)/d_filldata.o		: d_filldata.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_filldata.o $(MAKESLO) $(CFLAGS) -c d_filldata.c

$(DDOBJ)/d_fillform.o		: d_fillform.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_fillform.o $(MAKESLO) $(CFLAGS) -c d_fillform.c

$(DDOBJ)/d_fmask.o		: d_fmask.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_fmask.o $(MAKESLO) $(CFLAGS) -c d_fmask.c

$(DDOBJ)/d_hanadjt.o		: d_hanadjt.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_hanadjt.o $(MAKESLO) $(CFLAGS) -c d_hanadjt.c

$(DDOBJ)/d_hextoint.o		: d_hextoint.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_hextoint.o $(MAKESLO) $(CFLAGS) -c d_hextoint.c

$(DDOBJ)/d_imask.o		: d_imask.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_imask.o $(MAKESLO) $(CFLAGS) -c d_imask.c

$(DDOBJ)/d_int2ndec.o		: d_int2ndec.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_int2ndec.o $(MAKESLO) $(CFLAGS) -c d_int2ndec.c

$(DDOBJ)/d_int2nhex.o		: d_int2nhex.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_int2nhex.o $(MAKESLO) $(CFLAGS) -c d_int2nhex.c

$(DDOBJ)/d_inttodec.o		: d_inttodec.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_inttodec.o $(MAKESLO) $(CFLAGS) -c d_inttodec.c

$(DDOBJ)/d_inttohex.o		: d_inttohex.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_inttohex.o $(MAKESLO) $(CFLAGS) -c d_inttohex.c

$(DDOBJ)/d_isnumstr.o		: d_isnumstr.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_isnumstr.o $(MAKESLO) $(CFLAGS) -c d_isnumstr.c

$(DDOBJ)/d_isspacenstr.o	: d_isspacenstr.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_isspacenstr.o $(MAKESLO) $(CFLAGS) -c d_isspacenstr.c

$(DDOBJ)/d_isspacestr.o		: d_isspacestr.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_isspacestr.o $(MAKESLO) $(CFLAGS) -c d_isspacestr.c

$(DDOBJ)/d_leftalign.o		: d_leftalign.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_leftalign.o $(MAKESLO) $(CFLAGS) -c d_leftalign.c

$(DDOBJ)/d_mkstr.o		: d_mkstr.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_mkstr.o $(MAKESLO) $(CFLAGS) -c d_mkstr.c

$(DDOBJ)/d_mkstradd.o		: d_mkstradd.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_mkstradd.o $(MAKESLO) $(CFLAGS) -c d_mkstradd.c

$(DDOBJ)/d_ndec2int.o		: d_ndec2int.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_ndec2int.o $(MAKESLO) $(CFLAGS) -c d_ndec2int.c

$(DDOBJ)/d_nhex2int.o		: d_nhex2int.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_nhex2int.o $(MAKESLO) $(CFLAGS) -c d_nhex2int.c

$(DDOBJ)/d_nstr2d.o		: d_nstr2d.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_nstr2d.o $(MAKESLO) $(CFLAGS) -c d_nstr2d.c

$(DDOBJ)/d_nstradd.o		: d_nstradd.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_nstradd.o $(MAKESLO) $(CFLAGS) -c d_nstradd.c

$(DDOBJ)/d_nstradd2.o		: d_nstradd2.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_nstradd2.o $(MAKESLO) $(CFLAGS) -c d_nstradd2.c

$(DDOBJ)/d_rightalign.o		: d_rightalign.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_rightalign.o $(MAKESLO) $(CFLAGS) -c d_rightalign.c

$(DDOBJ)/d_strendnull.o		: d_strendnull.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_strendnull.o $(MAKESLO) $(CFLAGS) -c d_strendnull.c

$(DDOBJ)/d_strsort.o		: d_strsort.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_strsort.o $(MAKESLO) $(CFLAGS) -c d_strsort.c

$(DDOBJ)/d_umask.o		: d_umask.c $(HEADER)
	$(CC) -o $(DDOBJ)/d_umask.o $(MAKESLO) $(CFLAGS) -c d_umask.c

$(DDOBJ)/e_addsigact.o		: e_addsigact.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_addsigact.o $(MAKESLO) $(CFLAGS) -c e_addsigact.c

$(DDOBJ)/e_alldayget.o		: e_alldayget.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_alldayget.o $(MAKESLO) $(CFLAGS) -c e_alldayget.c

$(DDOBJ)/e_cdate2form.o		: e_cdate2form.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_cdate2form.o $(MAKESLO) $(CFLAGS) -c e_cdate2form.c

$(DDOBJ)/e_chkdate.o		: e_chkdate.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_chkdate.o $(MAKESLO) $(CFLAGS) -c e_chkdate.c

$(DDOBJ)/e_cmdarg.o		: e_cmdarg.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_cmdarg.o $(MAKESLO) $(CFLAGS) -c e_cmdarg.c

$(DDOBJ)/e_date2jul.o		: e_date2jul.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_date2jul.o $(MAKESLO) $(CFLAGS) -c e_date2jul.c

$(DDOBJ)/e_datechk.o		: e_datechk.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_datechk.o $(MAKESLO) $(CFLAGS) -c e_datechk.c

$(DDOBJ)/e_dates2du.o		: e_dates2du.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_dates2du.o $(MAKESLO) $(CFLAGS) -c e_dates2du.c

$(DDOBJ)/e_datecmp.o		: e_datecmp.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_datecmp.o $(MAKESLO) $(CFLAGS) -c e_datecmp.c

$(DDOBJ)/e_day2nday.o		: e_day2nday.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_day2nday.o $(MAKESLO) $(CFLAGS) -c e_day2nday.c

$(DDOBJ)/e_delenv.o		: e_delenv.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_delenv.o $(MAKESLO) $(CFLAGS) -c e_delenv.c

$(DDOBJ)/e_dudate.o		: e_dudate.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_dudate.o $(MAKESLO) $(CFLAGS) -c e_dudate.c

$(DDOBJ)/e_fullyear.o		: e_fullyear.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_fullyear.o $(MAKESLO) $(CFLAGS) -c e_fullyear.c

$(DDOBJ)/e_gdate2date.o		: e_gdate2date.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_gdate2date.o $(MAKESLO) $(CFLAGS) -c e_gdate2date.c

$(DDOBJ)/e_gdate2year.o		: e_gdate2year.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_gdate2year.o $(MAKESLO) $(CFLAGS) -c e_gdate2year.c

$(DDOBJ)/e_gdatebydu.o		: e_gdatebydu.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_gdatebydu.o $(MAKESLO) $(CFLAGS) -c e_gdatebydu.c

$(DDOBJ)/e_getdatestr.o		: e_getdatestr.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_getdatestr.o $(MAKESLO) $(CFLAGS) -c e_getdatestr.c

$(DDOBJ)/e_getenv.o		: e_getenv.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_getenv.o $(MAKESLO) $(CFLAGS) -c e_getenv.c

$(DDOBJ)/e_getsysdate.o		: e_getsysdate.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_getsysdate.o $(MAKESLO) $(CFLAGS) -c e_getsysdate.c

$(DDOBJ)/e_gettime.o		: e_gettime.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_gettime.o $(MAKESLO) $(CFLAGS) -c e_gettime.c

$(DDOBJ)/e_getweekday.o		: e_getweekday.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_getweekday.o $(MAKESLO) $(CFLAGS) -c e_getweekday.c

$(DDOBJ)/e_getyear.o		: e_getyear.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_getyear.o $(MAKESLO) $(CFLAGS) -c e_getyear.c

$(DDOBJ)/e_gmontbydu.o		: e_gmontbydu.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_gmontbydu.o $(MAKESLO) $(CFLAGS) -c e_gmontbydu.c

$(DDOBJ)/e_gre2jul.o		: e_gre2jul.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_gre2jul.o $(MAKESLO) $(CFLAGS) -c e_gre2jul.c

$(DDOBJ)/e_jul2date.o		: e_jul2date.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_jul2date.o $(MAKESLO) $(CFLAGS) -c e_jul2date.c

$(DDOBJ)/e_jul2gre.o		: e_jul2gre.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_jul2gre.o $(MAKESLO) $(CFLAGS) -c e_jul2gre.c

$(DDOBJ)/e_lstdayget.o		: e_lstdayget.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_lstdayget.o $(MAKESLO) $(CFLAGS) -c e_lstdayget.c

$(DDOBJ)/e_nextday.o		: e_nextday.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_nextday.o $(MAKESLO) $(CFLAGS) -c e_nextday.c

$(DDOBJ)/e_nextmonth.o		: e_nextmonth.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_nextmonth.o $(MAKESLO) $(CFLAGS) -c e_nextmonth.c

$(DDOBJ)/e_prevday.o		: e_prevday.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_prevday.o $(MAKESLO) $(CFLAGS) -c e_prevday.c

$(DDOBJ)/e_prevmonth.o		: e_prevmonth.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_prevmonth.o $(MAKESLO) $(CFLAGS) -c e_prevmonth.c

$(DDOBJ)/e_runp.o		: e_runp.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_runp.o $(MAKESLO) $(CFLAGS) -c e_runp.c

$(DDOBJ)/e_runsys.o		: e_runsys.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_runsys.o $(MAKESLO) $(CFLAGS) -c e_runsys.c

$(DDOBJ)/e_setenv.o		: e_setenv.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_setenv.o $(MAKESLO) $(CFLAGS) -c e_setenv.c

$(DDOBJ)/e_sighandle.o		: e_sighandle.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_sighandle.o $(MAKESLO) $(CFLAGS) -c e_sighandle.c

$(DDOBJ)/e_sleep0001.o		: e_sleep0001.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_sleep0001.o $(MAKESLO) $(CFLAGS) -c e_sleep0001.c

$(DDOBJ)/e_timegap.o		: e_timegap.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_timegap.o $(MAKESLO) $(CFLAGS) -c e_timegap.c

$(DDOBJ)/f_chmod.o		: f_chmod.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_chmod.o $(MAKESLO) $(CFLAGS) -c f_chmod.c

$(DDOBJ)/f_chown.o		: f_chown.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_chown.o $(MAKESLO) $(CFLAGS) -c f_chown.c

$(DDOBJ)/f_getenv.o		: f_getenv.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_getenv.o $(MAKESLO) $(CFLAGS) -c f_getenv.c

$(DDOBJ)/f_getfpath.o		: f_getfpath.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_getfpath.o $(MAKESLO) $(CFLAGS) -c f_getfpath.c

$(DDOBJ)/f_lock.o		: f_lock.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_lock.o $(MAKESLO) $(CFLAGS) -c f_lock.c

$(DDOBJ)/f_lockwait.o		: f_lockwait.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_lockwait.o $(MAKESLO) $(CFLAGS) -c f_lockwait.c

$(DDOBJ)/f_mkdir.o		: f_mkdir.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_mkdir.o $(MAKESLO) $(CFLAGS) -c f_mkdir.c

$(DDOBJ)/f_setenv.o		: f_setenv.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_setenv.o $(MAKESLO) $(CFLAGS) -c f_setenv.c

$(DDOBJ)/f_unlock.o		: f_unlock.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_unlock.o $(MAKESLO) $(CFLAGS) -c f_unlock.c

$(DDOBJ)/f_copy.o		: f_copy.c $(HEADER)
	$(CC) -o $(DDOBJ)/f_copy.o $(MAKESLO) $(CFLAGS) -c f_copy.c

$(DDOBJ)/fifofun.o		: fifofun.c $(HEADER)
	$(CC) -o $(DDOBJ)/fifofun.o $(MAKESLO) $(CFLAGS) -c fifofun.c

$(DDOBJ)/h_errno.o		: h_errno.c $(HEADER)
	$(CC) -o $(DDOBJ)/h_errno.o $(MAKESLO) $(CFLAGS) -c h_errno.c

$(DDOBJ)/k_acceptstr.o		: k_acceptstr.c $(HEADER)
	$(CC) -o $(DDOBJ)/k_acceptstr.o $(MAKESLO) $(CFLAGS) -c k_acceptstr.c

$(DDOBJ)/k_getchar.o		: k_getchar.c $(HEADER)
	$(CC) -o $(DDOBJ)/k_getchar.o $(MAKESLO) $(CFLAGS) -c k_getchar.c

$(DDOBJ)/k_inpnnumeric.o	: k_inpnnumeric.c $(HEADER)
	$(CC) -o $(DDOBJ)/k_inpnnumeric.o $(MAKESLO) $(CFLAGS) -c k_inpnnumeric.c

$(DDOBJ)/k_inpnstring.o		: k_inpnstring.c $(HEADER)
	$(CC) -o $(DDOBJ)/k_inpnstring.o $(MAKESLO) $(CFLAGS) -c k_inpnstring.c

$(DDOBJ)/l_allday2date.o	: l_allday2date.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_allday2date.o $(MAKESLO) $(CFLAGS) -c l_allday2date.c

$(DDOBJ)/l_allday2get.o		: l_allday2get.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_allday2get.o $(MAKESLO) $(CFLAGS) -c l_allday2get.c

$(DDOBJ)/l_datechkconv.o	: l_datechkconv.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_datechkconv.o $(MAKESLO) $(CFLAGS) -c l_datechkconv.c

$(DDOBJ)/l_lstdaychkget.o	: l_lstdaychkget.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_lstdaychkget.o $(MAKESLO) $(CFLAGS) -c l_lstdaychkget.c

$(DDOBJ)/l_pickdata.o		: l_pickdata.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_pickdata.o $(MAKESLO) $(CFLAGS) -c l_pickdata.c

$(DDOBJ)/l_readline.o		: l_readline.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_readline.o $(MAKESLO) $(CFLAGS) -c l_readline.c

$(DDOBJ)/r_chkshm.o		: r_chkshm.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_chkshm.o $(MAKESLO) $(CFLAGS) -c r_chkshm.c

$(DDOBJ)/r_crtshm.o		: r_crtshm.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_crtshm.o $(MAKESLO) $(CFLAGS) -c r_crtshm.c

$(DDOBJ)/r_delshm.o		: r_delshm.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_delshm.o $(MAKESLO) $(CFLAGS) -c r_delshm.c

$(DDOBJ)/r_execprg.o		: r_execprg.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_execprg.o $(MAKESLO) $(CFLAGS) -c r_execprg.c

$(DDOBJ)/r_getshm.o		: r_getshm.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_getshm.o $(MAKESLO) $(CFLAGS) -c r_getshm.c

$(DDOBJ)/r_runcont.o		: r_runcont.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_runcont.o $(MAKESLO) $(CFLAGS) -c r_runcont.c

$(DDOBJ)/r_runwait.o		: r_runwait.c $(HEADER)
	$(CC) -o $(DDOBJ)/r_runwait.o $(MAKESLO) $(CFLAGS) -c r_runwait.c

$(DDOBJ)/ringfun.o		: ringfun.c $(HEADER)
	$(CC) -o $(DDOBJ)/ringfun.o $(MAKESLO) $(CFLAGS) -c ringfun.c

$(DDOBJ)/s_readstream.o		: s_readstream.c $(HEADER)
	$(CC) -o $(DDOBJ)/s_readstream.o $(MAKESLO) $(CFLAGS) -c s_readstream.c

$(DDOBJ)/s_select.o		: s_select.c $(HEADER)
	$(CC) -o $(DDOBJ)/s_select.o $(MAKESLO) $(CFLAGS) -c s_select.c

$(DDOBJ)/s_writestream.o	: s_writestream.c $(HEADER)
	$(CC) -o $(DDOBJ)/s_writestream.o $(MAKESLO) $(CFLAGS) -c s_writestream.c

$(DDOBJ)/tracelog.o		: tracelog.c $(HEADER)
	$(CC) -o $(DDOBJ)/tracelog.o $(MAKESLO) $(CFLAGS) -c tracelog.c

$(DDOBJ)/l_gpssethyerrno.o		: l_gpssethyerrno.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_gpssethyerrno.o $(MAKESLO) $(CFLAGS) -c l_gpssethyerrno.c

$(DDOBJ)/hymsg.o		: hymsg.c $(HEADER)
	$(CC) -o $(DDOBJ)/hymsg.o $(MAKESLO) $(CFLAGS) -c hymsg.c

$(DDOBJ)/e_runpsts.o		: e_runpsts.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_runpsts.o $(MAKESLO) $(CFLAGS) -c e_runpsts.c

$(DDOBJ)/e_runsyssts.o		: e_runsyssts.c $(HEADER)
	$(CC) -o $(DDOBJ)/e_runsyssts.o $(MAKESLO) $(CFLAGS) -c e_runsyssts.c

