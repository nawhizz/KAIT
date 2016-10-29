include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	-I$(DLTP)/dblay \
	-I$(PSCON)/dblay \
	-I$(CVMS)/dblay \
	-I$(DLTP)/tblay \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	$(COMMON)/include/cbuni.h	$(COMMON)/include/iswrap.h \
	$(COMMON)/include/gps.h		$(COMMON)/include/pisam.h \
	$(COMMON)/include/stpapi.h	$(COMMON)/include/cmreg.h \
	$(COMMON)/include/stpmacro.h \
	$(DLTP)/dblay/clnt.h		$(DLTP)/dblay/clntv.h \
	$(DLTP)/dblay/lusr.h		$(DLTP)/dblay/lusrv.h \
	$(DLTP)/dblay/usid.h		$(DLTP)/dblay/usidv.h \
	$(DLTP)/dblay/txid.h		$(DLTP)/dblay/txidv.h \
	$(PSCON)/dblay/fmid.h		$(PSCON)/dblay/fmidv.h \
	$(PSCON)/dblay/evct.h		$(PSCON)/dblay/evctv.h \
	$(PSCON)/dblay/stev.h		$(PSCON)/dblay/stevv.h \
	$(CVMS)/dblay/ascl.h		$(CVMS)/dblay/asclv.h \
	$(DLTP)/tblay/csa.h \
	cmregdef.h

STATIC_OBJS	= \
	$(SDOBJ)/l_cmregcom.o		$(SDOBJ)/l_errset.o \
	$(SDOBJ)/l_sethyerrno.o		$(SDOBJ)/cmregext.o \
	$(SDOBJ)/tracelog.o \
	$(SDOBJ)/OCMREGCLOSE.o		$(SDOBJ)/OCMREGCOMMIT.o \
	$(SDOBJ)/OCMREGOPEN.o		$(SDOBJ)/OCMREGROLLBACK.o \
	$(SDOBJ)/OCMREGLUSR.o		$(SDOBJ)/OCMREGUSER.o \
	$(SDOBJ)/OCMREGUSID.o		$(SDOBJ)/OCMREGTXID.o \
	$(SDOBJ)/OCMREGFMID.o		$(SDOBJ)/OCMREGEVCT.o \
	$(SDOBJ)/OCMREGASCL.o		$(SDOBJ)/OCMREGCLNT.o \
	$(SDOBJ)/CmRegClose.o		$(SDOBJ)/CmRegCommit.o \
	$(SDOBJ)/CmRegOpen.o		$(SDOBJ)/CmRegRollback.o \
	$(SDOBJ)/CmRegLusr.o		$(SDOBJ)/CmRegUser.o \
	$(SDOBJ)/CmRegUsid.o		$(SDOBJ)/CmRegTxid.o \
	$(SDOBJ)/CmRegFmid.o		$(SDOBJ)/CmRegEvct.o \
	$(SDOBJ)/CmRegAscl.o		$(SDOBJ)/CmRegClnt.o \
	$(SDOBJ)/CmRegStev.o

DYNAMIC_OBJS	= \
	$(DDOBJ)/l_cmregcom.o		$(DDOBJ)/l_errset.o \
	$(DDOBJ)/l_sethyerrno.o		$(DDOBJ)/cmregext.o \
	$(DDOBJ)/tracelog.o \
	$(DDOBJ)/OCMREGCLOSE.o		$(DDOBJ)/OCMREGCOMMIT.o \
	$(DDOBJ)/OCMREGOPEN.o		$(DDOBJ)/OCMREGROLLBACK.o \
	$(DDOBJ)/OCMREGLUSR.o		$(DDOBJ)/OCMREGUSER.o \
	$(DDOBJ)/OCMREGUSID.o		$(DDOBJ)/OCMREGTXID.o \
	$(DDOBJ)/OCMREGFMID.o		$(DDOBJ)/OCMREGEVCT.o \
	$(DDOBJ)/OCMREGASCL.o		$(DDOBJ)/OCMREGCLNT.o \
	$(DDOBJ)/CmRegClose.o		$(DDOBJ)/CmRegCommit.o \
	$(DDOBJ)/CmRegOpen.o		$(DDOBJ)/CmRegRollback.o \
	$(DDOBJ)/CmRegLusr.o		$(DDOBJ)/CmRegUser.o \
	$(DDOBJ)/CmRegUsid.o		$(DDOBJ)/CmRegTxid.o \
	$(DDOBJ)/CmRegFmid.o		$(DDOBJ)/CmRegEvct.o \
	$(DDOBJ)/CmRegAscl.o		$(DDOBJ)/CmRegClnt.o \
	$(DDOBJ)/CmRegStev.o

all	: echo $(RUNUX)/lib/libcmreg.a \
		$(RUNUX)/lib/libcmreg.$(MAKESLN)

echo	:
	@echo COMMON/LIBSRC/CMREG$(ECHOLANG)

$(RUNUX)/lib/libcmreg.a		: $(STATIC_OBJS)
	ar vcr $(RUNUX)/lib/libcmreg.a $(STATIC_OBJS)

$(RUNUX)/lib/libcmreg.$(MAKESLN)	: $(DYNAMIC_OBJS)
	$(GENSL) -o $(RUNUX)/lib/libcmreg.$(MAKESLN) $(MAKESL) $(DYNAMIC_OBJS)

$(SDOBJ)/l_cmregcom.o		: l_cmregcom.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_cmregcom.o $(CFLAGS) -c l_cmregcom.c

$(SDOBJ)/l_errset.o		: l_errset.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_errset.o $(CFLAGS) -c l_errset.c

$(SDOBJ)/l_sethyerrno.o		: l_sethyerrno.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_sethyerrno.o $(CFLAGS) -c l_sethyerrno.c

$(SDOBJ)/cmregext.o		: cmregext.c $(HEADER)
	$(CC) -o $(SDOBJ)/cmregext.o $(CFLAGS) -c cmregext.c

$(SDOBJ)/tracelog.o		: tracelog.c $(HEADER)
	$(CC) -o $(SDOBJ)/tracelog.o $(CFLAGS) -c tracelog.c

$(SDOBJ)/OCMREGCLOSE.o		: OCMREGCLOSE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGCLOSE.o $(CFLAGS) -c OCMREGCLOSE.c

$(SDOBJ)/OCMREGCOMMIT.o		: OCMREGCOMMIT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGCOMMIT.o $(CFLAGS) -c OCMREGCOMMIT.c

$(SDOBJ)/OCMREGOPEN.o		: OCMREGOPEN.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGOPEN.o $(CFLAGS) -c OCMREGOPEN.c

$(SDOBJ)/OCMREGROLLBACK.o	: OCMREGROLLBACK.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGROLLBACK.o $(CFLAGS) -c OCMREGROLLBACK.c

$(SDOBJ)/OCMREGLUSR.o		: OCMREGLUSR.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGLUSR.o $(CFLAGS) -c OCMREGLUSR.c

$(SDOBJ)/OCMREGUSER.o		: OCMREGUSER.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGUSER.o $(CFLAGS) -c OCMREGUSER.c

$(SDOBJ)/OCMREGUSID.o		: OCMREGUSID.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGUSID.o $(CFLAGS) -c OCMREGUSID.c

$(SDOBJ)/OCMREGTXID.o		: OCMREGTXID.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGTXID.o $(CFLAGS) -c OCMREGTXID.c

$(SDOBJ)/OCMREGFMID.o		: OCMREGFMID.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGFMID.o $(CFLAGS) -c OCMREGFMID.c

$(SDOBJ)/OCMREGEVCT.o		: OCMREGEVCT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGEVCT.o $(CFLAGS) -c OCMREGEVCT.c

$(SDOBJ)/OCMREGASCL.o		: OCMREGASCL.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGASCL.o $(CFLAGS) -c OCMREGASCL.c

$(SDOBJ)/OCMREGCLNT.o		: OCMREGCLNT.c $(HEADER)
	$(CC) -o $(SDOBJ)/OCMREGCLNT.o $(CFLAGS) -c OCMREGCLNT.c

$(SDOBJ)/CmRegClose.o		: CmRegClose.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegClose.o $(CFLAGS) -c CmRegClose.c

$(SDOBJ)/CmRegCommit.o		: CmRegCommit.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegCommit.o $(CFLAGS) -c CmRegCommit.c

$(SDOBJ)/CmRegOpen.o		: CmRegOpen.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegOpen.o $(CFLAGS) -c CmRegOpen.c

$(SDOBJ)/CmRegRollback.o	: CmRegRollback.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegRollback.o $(CFLAGS) -c CmRegRollback.c

$(SDOBJ)/CmRegLusr.o		: CmRegLusr.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegLusr.o $(CFLAGS) -c CmRegLusr.c

$(SDOBJ)/CmRegUser.o		: CmRegUser.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegUser.o $(CFLAGS) -c CmRegUser.c

$(SDOBJ)/CmRegUsid.o		: CmRegUsid.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegUsid.o $(CFLAGS) -c CmRegUsid.c

$(SDOBJ)/CmRegTxid.o		: CmRegTxid.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegTxid.o $(CFLAGS) -c CmRegTxid.c

$(SDOBJ)/CmRegFmid.o		: CmRegFmid.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegFmid.o $(CFLAGS) -c CmRegFmid.c

$(SDOBJ)/CmRegEvct.o		: CmRegEvct.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegEvct.o $(CFLAGS) -c CmRegEvct.c

$(SDOBJ)/CmRegAscl.o		: CmRegAscl.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegAscl.o $(CFLAGS) -c CmRegAscl.c

$(SDOBJ)/CmRegClnt.o		: CmRegClnt.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegClnt.o $(CFLAGS) -c CmRegClnt.c

$(SDOBJ)/CmRegStev.o		: CmRegStev.c $(HEADER)
	$(CC) -o $(SDOBJ)/CmRegStev.o $(CFLAGS) -c CmRegStev.c


$(DDOBJ)/l_cmregcom.o		: l_cmregcom.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_cmregcom.o $(MAKESLO) $(CFLAGS) -c l_cmregcom.c

$(DDOBJ)/l_errset.o		: l_errset.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_errset.o $(MAKESLO) $(CFLAGS) -c l_errset.c

$(DDOBJ)/l_sethyerrno.o		: l_sethyerrno.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_sethyerrno.o $(MAKESLO) $(CFLAGS) -c l_sethyerrno.c

$(DDOBJ)/cmregext.o		: cmregext.c $(HEADER)
	$(CC) -o $(DDOBJ)/cmregext.o $(MAKESLO) $(CFLAGS) -c cmregext.c

$(DDOBJ)/tracelog.o		: tracelog.c $(HEADER)
	$(CC) -o $(DDOBJ)/tracelog.o $(MAKESLO) $(CFLAGS) -c tracelog.c

$(DDOBJ)/OCMREGCLOSE.o		: OCMREGCLOSE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGCLOSE.o $(MAKESLO) $(CFLAGS) -c OCMREGCLOSE.c

$(DDOBJ)/OCMREGCOMMIT.o		: OCMREGCOMMIT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGCOMMIT.o $(MAKESLO) $(CFLAGS) -c OCMREGCOMMIT.c

$(DDOBJ)/OCMREGOPEN.o		: OCMREGOPEN.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGOPEN.o $(MAKESLO) $(CFLAGS) -c OCMREGOPEN.c

$(DDOBJ)/OCMREGROLLBACK.o	: OCMREGROLLBACK.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGROLLBACK.o $(MAKESLO) $(CFLAGS) -c OCMREGROLLBACK.c

$(DDOBJ)/OCMREGLUSR.o		: OCMREGLUSR.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGLUSR.o $(MAKESLO) $(CFLAGS) -c OCMREGLUSR.c

$(DDOBJ)/OCMREGUSER.o		: OCMREGUSER.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGUSER.o $(MAKESLO) $(CFLAGS) -c OCMREGUSER.c

$(DDOBJ)/OCMREGUSID.o		: OCMREGUSID.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGUSID.o $(MAKESLO) $(CFLAGS) -c OCMREGUSID.c

$(DDOBJ)/OCMREGTXID.o		: OCMREGTXID.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGTXID.o $(MAKESLO) $(CFLAGS) -c OCMREGTXID.c

$(DDOBJ)/OCMREGFMID.o		: OCMREGFMID.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGFMID.o $(MAKESLO) $(CFLAGS) -c OCMREGFMID.c

$(DDOBJ)/OCMREGEVCT.o		: OCMREGEVCT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGEVCT.o $(MAKESLO) $(CFLAGS) -c OCMREGEVCT.c

$(DDOBJ)/OCMREGASCL.o		: OCMREGASCL.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGASCL.o $(MAKESLO) $(CFLAGS) -c OCMREGASCL.c

$(DDOBJ)/OCMREGCLNT.o		: OCMREGCLNT.c $(HEADER)
	$(CC) -o $(DDOBJ)/OCMREGCLNT.o $(MAKESLO) $(CFLAGS) -c OCMREGCLNT.c

$(DDOBJ)/CmRegClose.o		: CmRegClose.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegClose.o $(MAKESLO) $(CFLAGS) -c CmRegClose.c

$(DDOBJ)/CmRegCommit.o		: CmRegCommit.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegCommit.o $(MAKESLO) $(CFLAGS) -c CmRegCommit.c

$(DDOBJ)/CmRegOpen.o		: CmRegOpen.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegOpen.o $(MAKESLO) $(CFLAGS) -c CmRegOpen.c

$(DDOBJ)/CmRegRollback.o	: CmRegRollback.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegRollback.o $(MAKESLO) $(CFLAGS) -c CmRegRollback.c

$(DDOBJ)/CmRegLusr.o		: CmRegLusr.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegLusr.o $(MAKESLO) $(CFLAGS) -c CmRegLusr.c

$(DDOBJ)/CmRegUser.o		: CmRegUser.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegUser.o $(MAKESLO) $(CFLAGS) -c CmRegUser.c

$(DDOBJ)/CmRegUsid.o		: CmRegUsid.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegUsid.o $(MAKESLO) $(CFLAGS) -c CmRegUsid.c

$(DDOBJ)/CmRegTxid.o		: CmRegTxid.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegTxid.o $(MAKESLO) $(CFLAGS) -c CmRegTxid.c

$(DDOBJ)/CmRegFmid.o		: CmRegFmid.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegFmid.o $(MAKESLO) $(CFLAGS) -c CmRegFmid.c

$(DDOBJ)/CmRegEvct.o		: CmRegEvct.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegEvct.o $(MAKESLO) $(CFLAGS) -c CmRegEvct.c

$(DDOBJ)/CmRegAscl.o		: CmRegAscl.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegAscl.o $(MAKESLO) $(CFLAGS) -c CmRegAscl.c

$(DDOBJ)/CmRegClnt.o		: CmRegClnt.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegClnt.o $(MAKESLO) $(CFLAGS) -c CmRegClnt.c

$(DDOBJ)/CmRegStev.o		: CmRegStev.c $(HEADER)
	$(CC) -o $(DDOBJ)/CmRegStev.o $(MAKESLO) $(CFLAGS) -c CmRegStev.c
