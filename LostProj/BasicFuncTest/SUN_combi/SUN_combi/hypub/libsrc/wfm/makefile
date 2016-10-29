include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	$(COMMON)/include/wfm.h 	$(COMMON)/include/gps.h \
	wfm_fun.h

STATIC_OBJS	= \
	$(SDOBJ)/OWFM_ALLCLOSE.o	$(SDOBJ)/OWFM_CLOSE.o \
	$(SDOBJ)/OWFM_OPEN.o		$(SDOBJ)/OWFM_FILLDATA.o \
	$(SDOBJ)/OWFM_FILLHEAD.o	$(SDOBJ)/OWFM_FILLTAIL.o \
	$(SDOBJ)/WFmAllClose.o	$(SDOBJ)/WFmClose.o $(SDOBJ)/WFmOpen.o \
	$(SDOBJ)/WFmFillData.o $(SDOBJ)/WFmFillHead.o $(SDOBJ)/WFmFillTail.o \
	$(SDOBJ)/wfm_extvar.o	$(SDOBJ)/wfm_savefile.o	\
	$(SDOBJ)/wfm_saveseginfo.o	$(SDOBJ)/wfm_freeseginfo.o \
	$(SDOBJ)/wfm_freeblkinfo.o	$(SDOBJ)/wfm_dbgfun.o \
	$(SDOBJ)/wfm_str2strarr.o	$(SDOBJ)/wfm_errset.o \
	$(SDOBJ)/l_wfmsethyerrno.o

DYNAMIC_OBJS	= \
	$(DDOBJ)/OWFM_ALLCLOSE.o	$(DDOBJ)/OWFM_CLOSE.o \
	$(DDOBJ)/OWFM_OPEN.o		$(DDOBJ)/OWFM_FILLDATA.o \
	$(DDOBJ)/OWFM_FILLHEAD.o	$(DDOBJ)/OWFM_FILLTAIL.o \
	$(DDOBJ)/WFmAllClose.o	$(DDOBJ)/WFmClose.o $(DDOBJ)/WFmOpen.o \
	$(DDOBJ)/WFmFillData.o $(DDOBJ)/WFmFillHead.o $(DDOBJ)/WFmFillTail.o \
	$(DDOBJ)/wfm_extvar.o	$(DDOBJ)/wfm_savefile.o \
	$(DDOBJ)/wfm_saveseginfo.o	$(DDOBJ)/wfm_freeseginfo.o \
	$(DDOBJ)/wfm_freeblkinfo.o	$(DDOBJ)/wfm_dbgfun.o \
	$(DDOBJ)/wfm_str2strarr.o	$(DDOBJ)/wfm_errset.o \
	$(DDOBJ)/l_wfmsethyerrno.o

all	: echo $(RUNUX)/lib/libwfm.a $(RUNUX)/lib/libwfm.$(MAKESLN)

echo		:
	@echo	HYPUB/LIBSRC/WFM$(ECHOLANG)

$(RUNUX)/lib/libwfm.a	: $(STATIC_OBJS) 
	ar vcr $(RUNUX)/lib/libwfm.a $(STATIC_OBJS)

$(RUNUX)/lib/libwfm.$(MAKESLN)	: $(DYNAMIC_OBJS)
	$(GENSL) -o $(RUNUX)/lib/libwfm.$(MAKESLN) $(MAKESL) $(DYNAMIC_OBJS)


$(SDOBJ)/OWFM_ALLCLOSE.o	: OWFM_ALLCLOSE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OWFM_ALLCLOSE.o $(CFLAGS) -c OWFM_ALLCLOSE.c

$(SDOBJ)/OWFM_CLOSE.o		: OWFM_CLOSE.c $(HEADER)
	$(CC) -o $(SDOBJ)/OWFM_CLOSE.o $(CFLAGS) -c OWFM_CLOSE.c

$(SDOBJ)/OWFM_OPEN.o		: OWFM_OPEN.c $(HEADER)
	$(CC) -o $(SDOBJ)/OWFM_OPEN.o $(CFLAGS) -c OWFM_OPEN.c

$(SDOBJ)/OWFM_FILLDATA.o	: OWFM_FILLDATA.c $(HEADER)
	$(CC) -o $(SDOBJ)/OWFM_FILLDATA.o $(CFLAGS) -c OWFM_FILLDATA.c

$(SDOBJ)/OWFM_FILLHEAD.o	: OWFM_FILLHEAD.c $(HEADER)
	$(CC) -o $(SDOBJ)/OWFM_FILLHEAD.o $(CFLAGS) -c OWFM_FILLHEAD.c

$(SDOBJ)/OWFM_FILLTAIL.o	: OWFM_FILLTAIL.c $(HEADER)
	$(CC) -o $(SDOBJ)/OWFM_FILLTAIL.o $(CFLAGS) -c OWFM_FILLTAIL.c

$(SDOBJ)/WFmAllClose.o		: WFmAllClose.c $(HEADER)
	$(CC) -o $(SDOBJ)/WFmAllClose.o $(CFLAGS) -c WFmAllClose.c

$(SDOBJ)/WFmClose.o		: WFmClose.c $(HEADER)
	$(CC) -o $(SDOBJ)/WFmClose.o $(CFLAGS) -c WFmClose.c

$(SDOBJ)/WFmOpen.o		: WFmOpen.c $(HEADER)
	$(CC) -o $(SDOBJ)/WFmOpen.o $(CFLAGS) -c WFmOpen.c

$(SDOBJ)/WFmFillData.o		: WFmFillData.c $(HEADER)
	$(CC) -o $(SDOBJ)/WFmFillData.o $(CFLAGS) -c WFmFillData.c

$(SDOBJ)/WFmFillHead.o		: WFmFillHead.c $(HEADER)
	$(CC) -o $(SDOBJ)/WFmFillHead.o $(CFLAGS) -c WFmFillHead.c

$(SDOBJ)/WFmFillTail.o		: WFmFillTail.c $(HEADER)
	$(CC) -o $(SDOBJ)/WFmFillTail.o $(CFLAGS) -c WFmFillTail.c

$(SDOBJ)/wfm_extvar.o		: wfm_extvar.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_extvar.o $(CFLAGS) -c wfm_extvar.c

$(SDOBJ)/wfm_savefile.o		: wfm_savefile.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_savefile.o $(CFLAGS) -c wfm_savefile.c

$(SDOBJ)/wfm_saveseginfo.o	: wfm_saveseginfo.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_saveseginfo.o $(CFLAGS) -c wfm_saveseginfo.c

$(SDOBJ)/wfm_freeseginfo.o	: wfm_freeseginfo.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_freeseginfo.o $(CFLAGS) -c wfm_freeseginfo.c

$(SDOBJ)/wfm_freeblkinfo.o	: wfm_freeblkinfo.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_freeblkinfo.o $(CFLAGS) -c wfm_freeblkinfo.c

$(SDOBJ)/wfm_dbgfun.o		: wfm_dbgfun.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_dbgfun.o $(CFLAGS) -c wfm_dbgfun.c

$(SDOBJ)/wfm_str2strarr.o	: wfm_str2strarr.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_str2strarr.o $(CFLAGS) -c wfm_str2strarr.c

$(SDOBJ)/wfm_errset.o		: wfm_errset.c $(HEADER)
	$(CC) -o $(SDOBJ)/wfm_errset.o $(CFLAGS) -c wfm_errset.c

$(SDOBJ)/l_wfmsethyerrno.o	: l_wfmsethyerrno.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_wfmsethyerrno.o $(CFLAGS) -c l_wfmsethyerrno.c


$(DDOBJ)/OWFM_ALLCLOSE.o	: OWFM_ALLCLOSE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OWFM_ALLCLOSE.o $(CFLAGS) -c OWFM_ALLCLOSE.c

$(DDOBJ)/OWFM_CLOSE.o		: OWFM_CLOSE.c $(HEADER)
	$(CC) -o $(DDOBJ)/OWFM_CLOSE.o $(CFLAGS) -c OWFM_CLOSE.c

$(DDOBJ)/OWFM_OPEN.o		: OWFM_OPEN.c $(HEADER)
	$(CC) -o $(DDOBJ)/OWFM_OPEN.o $(CFLAGS) -c OWFM_OPEN.c

$(DDOBJ)/OWFM_FILLDATA.o	: OWFM_FILLDATA.c $(HEADER)
	$(CC) -o $(DDOBJ)/OWFM_FILLDATA.o $(CFLAGS) -c OWFM_FILLDATA.c

$(DDOBJ)/OWFM_FILLHEAD.o	: OWFM_FILLHEAD.c $(HEADER)
	$(CC) -o $(DDOBJ)/OWFM_FILLHEAD.o $(CFLAGS) -c OWFM_FILLHEAD.c

$(DDOBJ)/OWFM_FILLTAIL.o	: OWFM_FILLTAIL.c $(HEADER)
	$(CC) -o $(DDOBJ)/OWFM_FILLTAIL.o $(CFLAGS) -c OWFM_FILLTAIL.c

$(DDOBJ)/WFmAllClose.o		: WFmAllClose.c $(HEADER)
	$(CC) -o $(DDOBJ)/WFmAllClose.o $(CFLAGS) -c WFmAllClose.c

$(DDOBJ)/WFmClose.o		: WFmClose.c $(HEADER)
	$(CC) -o $(DDOBJ)/WFmClose.o $(CFLAGS) -c WFmClose.c

$(DDOBJ)/WFmOpen.o		: WFmOpen.c $(HEADER)
	$(CC) -o $(DDOBJ)/WFmOpen.o $(CFLAGS) -c WFmOpen.c

$(DDOBJ)/WFmFillData.o		: WFmFillData.c $(HEADER)
	$(CC) -o $(DDOBJ)/WFmFillData.o $(CFLAGS) -c WFmFillData.c

$(DDOBJ)/WFmFillHead.o		: WFmFillHead.c $(HEADER)
	$(CC) -o $(DDOBJ)/WFmFillHead.o $(CFLAGS) -c WFmFillHead.c

$(DDOBJ)/WFmFillTail.o		: WFmFillTail.c $(HEADER)
	$(CC) -o $(DDOBJ)/WFmFillTail.o $(CFLAGS) -c WFmFillTail.c

$(DDOBJ)/wfm_extvar.o		: wfm_extvar.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_extvar.o $(CFLAGS) -c wfm_extvar.c

$(DDOBJ)/wfm_savefile.o		: wfm_savefile.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_savefile.o $(CFLAGS) -c wfm_savefile.c

$(DDOBJ)/wfm_saveseginfo.o	: wfm_saveseginfo.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_saveseginfo.o $(CFLAGS) -c wfm_saveseginfo.c

$(DDOBJ)/wfm_freeseginfo.o	: wfm_freeseginfo.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_freeseginfo.o $(CFLAGS) -c wfm_freeseginfo.c

$(DDOBJ)/wfm_freeblkinfo.o	: wfm_freeblkinfo.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_freeblkinfo.o $(CFLAGS) -c wfm_freeblkinfo.c

$(DDOBJ)/wfm_dbgfun.o		: wfm_dbgfun.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_dbgfun.o $(CFLAGS) -c wfm_dbgfun.c

$(DDOBJ)/wfm_str2strarr.o	: wfm_str2strarr.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_str2strarr.o $(CFLAGS) -c wfm_str2strarr.c

$(DDOBJ)/wfm_errset.o		: wfm_errset.c $(HEADER)
	$(CC) -o $(DDOBJ)/wfm_errset.o $(CFLAGS) -c wfm_errset.c

$(DDOBJ)/l_wfmsethyerrno.o	: l_wfmsethyerrno.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_wfmsethyerrno.o $(CFLAGS) -c l_wfmsethyerrno.c

