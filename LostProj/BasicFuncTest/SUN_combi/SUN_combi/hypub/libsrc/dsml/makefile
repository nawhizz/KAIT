include $(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	dsmldef.h \
	$(COMMON)/include/dsml.h \
	$(COMMON)/include/pisam.h \
	$(COMMON)/include/gps.h

STATIC_OBJS	= \
	$(SDOBJ)/OPI_ADDDOC.o $(SDOBJ)/OPI_DALLCLOSE.o $(SDOBJ)/OPI_DBUILD.o\
	$(SDOBJ)/OPI_DCLOSE.o $(SDOBJ)/OPI_DCONV.o $(SDOBJ)/OPI_DCROPEN.o\
	$(SDOBJ)/OPI_DDCHK.o $(SDOBJ)/OPI_DELDOC.o $(SDOBJ)/OPI_DHCHK.o\
	$(SDOBJ)/OPI_DHREAD.o $(SDOBJ)/OPI_DICHK.o $(SDOBJ)/OPI_DIFIRST.o\
	$(SDOBJ)/OPI_DILAST.o $(SDOBJ)/OPI_DINEXT.o $(SDOBJ)/OPI_DIPREV.o\
	$(SDOBJ)/OPI_DIREAD.o $(SDOBJ)/OPI_DOPEN.o $(SDOBJ)/OPI_DUOPEN.o\
	$(SDOBJ)/OPI_DVADD.o $(SDOBJ)/OPI_DVCHK.o $(SDOBJ)/OPI_DVDEL.o\
	$(SDOBJ)/OPI_DVREAD.o $(SDOBJ)/OPI_DVREN.o $(SDOBJ)/OPI_DVUPD.o\
	$(SDOBJ)/OPI_REDDOC.o $(SDOBJ)/OPI_UPDDOC.o $(SDOBJ)/OPI_DBUILD2.o\
	$(SDOBJ)/OPI_ADDDIR.o $(SDOBJ)/OPI_DELDIR.o $(SDOBJ)/OPI_UPDDIR.o\
	$(SDOBJ)/OPI_UPDDIRINFO.o $(SDOBJ)/OPI_DLMREAD.o $(SDOBJ)/OPI_DLVREAD.o\
	$(SDOBJ)/OPI_DLFREAD.o\
	$(SDOBJ)/PI_ADDDOC.o $(SDOBJ)/PI_DCOMMIT.o $(SDOBJ)/PI_DROLLBACK.o\
	$(SDOBJ)/PI_DALLCLOSE.o $(SDOBJ)/PI_DBUILD.o $(SDOBJ)/PI_DCLOSE.o\
	$(SDOBJ)/PI_DCONV.o $(SDOBJ)/PI_DCROPEN.o $(SDOBJ)/PI_DDCHK.o\
	$(SDOBJ)/PI_DELDOC.o $(SDOBJ)/PI_DHCHK.o $(SDOBJ)/PI_DHREAD.o\
	$(SDOBJ)/PI_DICHK.o $(SDOBJ)/PI_DIFIRST.o $(SDOBJ)/PI_DILAST.o\
	$(SDOBJ)/PI_DINEXT.o $(SDOBJ)/PI_DIPREV.o $(SDOBJ)/PI_DIREAD.o\
	$(SDOBJ)/PI_DOPEN.o $(SDOBJ)/PI_DUOPEN.o $(SDOBJ)/PI_DVADD.o\
	$(SDOBJ)/PI_DVCHK.o $(SDOBJ)/PI_DVDEL.o $(SDOBJ)/PI_DVREAD.o\
	$(SDOBJ)/PI_DVREN.o $(SDOBJ)/PI_DVUPD.o $(SDOBJ)/PI_REDDOC.o\
	$(SDOBJ)/PI_UPDDOC.o $(SDOBJ)/PI_DBUILD2.o $(SDOBJ)/PI_ADDDIR.o\
	$(SDOBJ)/PI_UPDDIR.o $(SDOBJ)/PI_DELDIR.o $(SDOBJ)/PI_UPDDIRINFO.o\
	$(SDOBJ)/PI_DLMREAD.o $(SDOBJ)/PI_DLVREAD.o $(SDOBJ)/PI_DLFREAD.o\
	$(SDOBJ)/ds_chkbuildinf.o $(SDOBJ)/ds_chkdocid.o $(SDOBJ)/ds_splitpath.o\
	$(SDOBJ)/ds_chkvolinf.o $(SDOBJ)/ds_convert.o $(SDOBJ)/ds_erase.o\
	$(SDOBJ)/ds_errset.o $(SDOBJ)/ds_filegen.o $(SDOBJ)/ds_fileopen.o\
	$(SDOBJ)/ds_fullpath.o $(SDOBJ)/ds_getver.o $(SDOBJ)/ds_getvolno.o\
	$(SDOBJ)/ds_getvolseq.o $(SDOBJ)/ds_movedoc.o $(SDOBJ)/ds_newdocid.o\
	$(SDOBJ)/ds_newvolno.o $(SDOBJ)/ds_nextfd.o $(SDOBJ)/ds_setver.o\
	$(SDOBJ)/ds_splitvol.o $(SDOBJ)/ds_usedblkcnt.o $(SDOBJ)/ds_volgen.o\
	$(SDOBJ)/ds_volopen.o $(SDOBJ)/ds_chkfsize.o $(SDOBJ)/l_dsmlsethyerrno.o\
	$(SDOBJ)/ds_splitpath.o $(SDOBJ)/ds_getnewdir.o $(SDOBJ)/ds_getdirseq.o\
	$(SDOBJ)/ds_chkfdavail.o $(SDOBJ)/ds_log.o $(SDOBJ)/ds_getnewdir.o\
	$(SDOBJ)/ds_dprintf.o

DYNAMIC_OBJS	= \
	$(DDOBJ)/OPI_ADDDOC.o $(DDOBJ)/OPI_DALLCLOSE.o $(DDOBJ)/OPI_DBUILD.o\
	$(DDOBJ)/OPI_DCLOSE.o $(DDOBJ)/OPI_DCONV.o $(DDOBJ)/OPI_DCROPEN.o\
	$(DDOBJ)/OPI_DDCHK.o $(DDOBJ)/OPI_DELDOC.o $(DDOBJ)/OPI_DHCHK.o\
	$(DDOBJ)/OPI_DHREAD.o $(DDOBJ)/OPI_DICHK.o $(DDOBJ)/OPI_DIFIRST.o\
	$(DDOBJ)/OPI_DILAST.o $(DDOBJ)/OPI_DINEXT.o $(DDOBJ)/OPI_DIPREV.o\
	$(DDOBJ)/OPI_DIREAD.o $(DDOBJ)/OPI_DOPEN.o $(DDOBJ)/OPI_DUOPEN.o\
	$(DDOBJ)/OPI_DVADD.o $(DDOBJ)/OPI_DVCHK.o $(DDOBJ)/OPI_DVDEL.o\
	$(DDOBJ)/OPI_DVREAD.o $(DDOBJ)/OPI_DVREN.o $(DDOBJ)/OPI_DVUPD.o\
	$(DDOBJ)/OPI_REDDOC.o $(DDOBJ)/OPI_UPDDOC.o $(DDOBJ)/OPI_DBUILD2.o\
	$(DDOBJ)/OPI_ADDDIR.o $(DDOBJ)/OPI_DELDIR.o $(DDOBJ)/OPI_UPDDIR.o\
	$(DDOBJ)/OPI_UPDDIRINFO.o $(DDOBJ)/OPI_DLMREAD.o $(DDOBJ)/OPI_DLVREAD.o\
	$(DDOBJ)/OPI_DLFREAD.o\
	$(DDOBJ)/PI_ADDDOC.o $(DDOBJ)/PI_DCOMMIT.o $(DDOBJ)/PI_DROLLBACK.o\
	$(DDOBJ)/PI_DALLCLOSE.o $(DDOBJ)/PI_DBUILD.o $(DDOBJ)/PI_DCLOSE.o\
	$(DDOBJ)/PI_DCONV.o $(DDOBJ)/PI_DCROPEN.o $(DDOBJ)/PI_DDCHK.o\
	$(DDOBJ)/PI_DELDOC.o $(DDOBJ)/PI_DHCHK.o $(DDOBJ)/PI_DHREAD.o\
	$(DDOBJ)/PI_DICHK.o $(DDOBJ)/PI_DIFIRST.o $(DDOBJ)/PI_DILAST.o\
	$(DDOBJ)/PI_DINEXT.o $(DDOBJ)/PI_DIPREV.o $(DDOBJ)/PI_DIREAD.o\
	$(DDOBJ)/PI_DOPEN.o $(DDOBJ)/PI_DUOPEN.o $(DDOBJ)/PI_DVADD.o\
	$(DDOBJ)/PI_DVCHK.o $(DDOBJ)/PI_DVDEL.o $(DDOBJ)/PI_DVREAD.o\
	$(DDOBJ)/PI_DVREN.o $(DDOBJ)/PI_DVUPD.o $(DDOBJ)/PI_REDDOC.o\
	$(DDOBJ)/PI_UPDDOC.o $(DDOBJ)/PI_DBUILD2.o $(DDOBJ)/PI_ADDDIR.o\
	$(DDOBJ)/PI_UPDDIR.o $(DDOBJ)/PI_DELDIR.o $(DDOBJ)/PI_UPDDIRINFO.o\
	$(DDOBJ)/PI_DLMREAD.o $(DDOBJ)/PI_DLVREAD.o $(DDOBJ)/PI_DLFREAD.o\
	$(DDOBJ)/ds_chkbuildinf.o $(DDOBJ)/ds_chkdocid.o\
	$(DDOBJ)/ds_chkvolinf.o $(DDOBJ)/ds_convert.o $(DDOBJ)/ds_erase.o\
	$(DDOBJ)/ds_errset.o $(DDOBJ)/ds_filegen.o $(DDOBJ)/ds_fileopen.o\
	$(DDOBJ)/ds_fullpath.o $(DDOBJ)/ds_getver.o $(DDOBJ)/ds_getvolno.o\
	$(DDOBJ)/ds_getvolseq.o $(DDOBJ)/ds_movedoc.o $(DDOBJ)/ds_newdocid.o\
	$(DDOBJ)/ds_newvolno.o $(DDOBJ)/ds_nextfd.o $(DDOBJ)/ds_setver.o\
	$(DDOBJ)/ds_splitvol.o $(DDOBJ)/ds_usedblkcnt.o $(DDOBJ)/ds_volgen.o\
	$(DDOBJ)/ds_volopen.o $(DDOBJ)/ds_chkfsize.o $(DDOBJ)/l_dsmlsethyerrno.o\
	$(DDOBJ)/ds_splitpath.o $(DDOBJ)/ds_getnewdir.o $(DDOBJ)/ds_getdirseq.o\
	$(DDOBJ)/ds_chkfdavail.o $(DDOBJ)/ds_log.o $(DDOBJ)/ds_dprintf.o

all	: echo $(RUNUX)/lib/libdsml.a $(RUNUX)/lib/libdsml.$(MAKESLN)

echo	:
	@echo	HYPUB/LIBSRC/DSML$(ECHOLANG)

$(RUNUX)/lib/libdsml.a	: $(STATIC_OBJS)
	ar vcr $(RUNUX)/lib/libdsml.a $(STATIC_OBJS)

$(RUNUX)/lib/libdsml.$(MAKESLN)	: $(DYNAMIC_OBJS)
	$(GENSL) -o $(RUNUX)/lib/libdsml.$(MAKESLN) $(MAKESL) $(DYNAMIC_OBJS)

$(SDOBJ)/OPI_ADDDOC.o	    : OPI_ADDDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_ADDDOC.o	       $(CFLAGS) -c    OPI_ADDDOC.c

$(SDOBJ)/OPI_DALLCLOSE.o    : OPI_DALLCLOSE.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DALLCLOSE.o      $(CFLAGS) -c    OPI_DALLCLOSE.c

$(SDOBJ)/OPI_DBUILD.o	    : OPI_DBUILD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DBUILD.o	       $(CFLAGS) -c    OPI_DBUILD.c

$(SDOBJ)/OPI_DCLOSE.o	    : OPI_DCLOSE.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DCLOSE.o	       $(CFLAGS) -c    OPI_DCLOSE.c

$(SDOBJ)/OPI_DCONV.o	    : OPI_DCONV.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DCONV.o	       $(CFLAGS) -c    OPI_DCONV.c

$(SDOBJ)/OPI_DCROPEN.o	    : OPI_DCROPEN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DCROPEN.o        $(CFLAGS) -c    OPI_DCROPEN.c

$(SDOBJ)/OPI_DDCHK.o	    : OPI_DDCHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DDCHK.o	       $(CFLAGS) -c    OPI_DDCHK.c

$(SDOBJ)/OPI_DELDOC.o	    : OPI_DELDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DELDOC.o	       $(CFLAGS) -c    OPI_DELDOC.c

$(SDOBJ)/OPI_DHCHK.o	    : OPI_DHCHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DHCHK.o	       $(CFLAGS) -c    OPI_DHCHK.c

$(SDOBJ)/OPI_DHREAD.o	    : OPI_DHREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DHREAD.o	       $(CFLAGS) -c    OPI_DHREAD.c

$(SDOBJ)/OPI_DICHK.o	    : OPI_DICHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DICHK.o	       $(CFLAGS) -c    OPI_DICHK.c

$(SDOBJ)/OPI_DIFIRST.o	    : OPI_DIFIRST.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DIFIRST.o        $(CFLAGS) -c    OPI_DIFIRST.c

$(SDOBJ)/OPI_DILAST.o	    : OPI_DILAST.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DILAST.o	       $(CFLAGS) -c    OPI_DILAST.c

$(SDOBJ)/OPI_DINEXT.o	    : OPI_DINEXT.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DINEXT.o	       $(CFLAGS) -c    OPI_DINEXT.c

$(SDOBJ)/OPI_DIPREV.o	    : OPI_DIPREV.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DIPREV.o	       $(CFLAGS) -c    OPI_DIPREV.c

$(SDOBJ)/OPI_DIREAD.o	    : OPI_DIREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DIREAD.o	       $(CFLAGS) -c    OPI_DIREAD.c

$(SDOBJ)/OPI_DOPEN.o	    : OPI_DOPEN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DOPEN.o	       $(CFLAGS) -c    OPI_DOPEN.c

$(SDOBJ)/OPI_DUOPEN.o	    : OPI_DUOPEN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DUOPEN.o	       $(CFLAGS) -c    OPI_DUOPEN.c

$(SDOBJ)/OPI_DVADD.o	    : OPI_DVADD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DVADD.o	       $(CFLAGS) -c    OPI_DVADD.c

$(SDOBJ)/OPI_DVCHK.o	    : OPI_DVCHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DVCHK.o	       $(CFLAGS) -c    OPI_DVCHK.c

$(SDOBJ)/OPI_DVDEL.o	    : OPI_DVDEL.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DVDEL.o	       $(CFLAGS) -c    OPI_DVDEL.c

$(SDOBJ)/OPI_DVREAD.o	    : OPI_DVREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DVREAD.o	       $(CFLAGS) -c    OPI_DVREAD.c

$(SDOBJ)/OPI_DVREN.o	    : OPI_DVREN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DVREN.o	       $(CFLAGS) -c    OPI_DVREN.c

$(SDOBJ)/OPI_DVUPD.o	    : OPI_DVUPD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DVUPD.o	       $(CFLAGS) -c    OPI_DVUPD.c

$(SDOBJ)/OPI_REDDOC.o	    : OPI_REDDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_REDDOC.o	       $(CFLAGS) -c    OPI_REDDOC.c

$(SDOBJ)/OPI_UPDDOC.o	    : OPI_UPDDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_UPDDOC.o	       $(CFLAGS) -c    OPI_UPDDOC.c

$(SDOBJ)/OPI_DBUILD2.o	    : OPI_DBUILD2.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DBUILD2.o	       $(CFLAGS) -c    OPI_DBUILD2.c

$(SDOBJ)/OPI_ADDDIR.o	    : OPI_ADDDIR.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_ADDDIR.o	       $(CFLAGS) -c    OPI_ADDDIR.c

$(SDOBJ)/OPI_DELDIR.o	    : OPI_DELDIR.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DELDIR.o	       $(CFLAGS) -c    OPI_DELDIR.c

$(SDOBJ)/OPI_UPDDIR.o	    : OPI_UPDDIR.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_UPDDIR.o	       $(CFLAGS) -c    OPI_UPDDIR.c

$(SDOBJ)/OPI_UPDDIRINFO.o   : OPI_UPDDIRINFO.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_UPDDIRINFO.o	$(CFLAGS) -c    OPI_UPDDIRINFO.c

$(SDOBJ)/OPI_DLMREAD.o   : OPI_DLMREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DLMREAD.o	$(CFLAGS) -c    OPI_DLMREAD.c

$(SDOBJ)/OPI_DLVREAD.o   : OPI_DLVREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DLVREAD.o	$(CFLAGS) -c    OPI_DLVREAD.c

$(SDOBJ)/OPI_DLFREAD.o   : OPI_DLFREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/OPI_DLFREAD.o	$(CFLAGS) -c    OPI_DLFREAD.c

$(SDOBJ)/PI_ADDDOC.o	    : PI_ADDDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_ADDDOC.o	       $(CFLAGS) -c    PI_ADDDOC.c

$(SDOBJ)/PI_DALLCLOSE.o     : PI_DALLCLOSE.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DALLCLOSE.o       $(CFLAGS) -c    PI_DALLCLOSE.c

$(SDOBJ)/PI_DBUILD.o	    : PI_DBUILD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DBUILD.o	       $(CFLAGS) -c    PI_DBUILD.c

$(SDOBJ)/PI_DBUILD2.o	    : PI_DBUILD2.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DBUILD2.o	       $(CFLAGS) -c    PI_DBUILD2.c

$(SDOBJ)/PI_ADDDIR.o	    : PI_ADDDIR.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_ADDDIR.o	       $(CFLAGS) -c    PI_ADDDIR.c

$(SDOBJ)/PI_UPDDIR.o	    : PI_UPDDIR.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_UPDDIR.o	       $(CFLAGS) -c    PI_UPDDIR.c

$(SDOBJ)/PI_DELDIR.o	    : PI_DELDIR.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DELDIR.o	       $(CFLAGS) -c    PI_DELDIR.c

$(SDOBJ)/PI_DCLOSE.o	    : PI_DCLOSE.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DCLOSE.o	       $(CFLAGS) -c    PI_DCLOSE.c

$(SDOBJ)/PI_DCONV.o	    : PI_DCONV.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DCONV.o	       $(CFLAGS) -c    PI_DCONV.c

$(SDOBJ)/PI_DCROPEN.o	    : PI_DCROPEN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DCROPEN.o	       $(CFLAGS) -c    PI_DCROPEN.c

$(SDOBJ)/PI_DDCHK.o	    : PI_DDCHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DDCHK.o	       $(CFLAGS) -c    PI_DDCHK.c

$(SDOBJ)/PI_DELDOC.o	    : PI_DELDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DELDOC.o	       $(CFLAGS) -c    PI_DELDOC.c

$(SDOBJ)/PI_DHCHK.o	    : PI_DHCHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DHCHK.o	       $(CFLAGS) -c    PI_DHCHK.c

$(SDOBJ)/PI_DHREAD.o	    : PI_DHREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DHREAD.o	       $(CFLAGS) -c    PI_DHREAD.c

$(SDOBJ)/PI_DICHK.o	    : PI_DICHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DICHK.o	       $(CFLAGS) -c    PI_DICHK.c

$(SDOBJ)/PI_DIFIRST.o	    : PI_DIFIRST.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DIFIRST.o	       $(CFLAGS) -c    PI_DIFIRST.c

$(SDOBJ)/PI_DILAST.o	    : PI_DILAST.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DILAST.o	       $(CFLAGS) -c    PI_DILAST.c

$(SDOBJ)/PI_DINEXT.o	    : PI_DINEXT.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DINEXT.o	       $(CFLAGS) -c    PI_DINEXT.c

$(SDOBJ)/PI_DIPREV.o	    : PI_DIPREV.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DIPREV.o	       $(CFLAGS) -c    PI_DIPREV.c

$(SDOBJ)/PI_DIREAD.o	    : PI_DIREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DIREAD.o	       $(CFLAGS) -c    PI_DIREAD.c

$(SDOBJ)/PI_DOPEN.o	    : PI_DOPEN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DOPEN.o	       $(CFLAGS) -c    PI_DOPEN.c

$(SDOBJ)/PI_DUOPEN.o	    : PI_DUOPEN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DUOPEN.o	       $(CFLAGS) -c    PI_DUOPEN.c

$(SDOBJ)/PI_DVADD.o	    : PI_DVADD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DVADD.o	       $(CFLAGS) -c    PI_DVADD.c

$(SDOBJ)/PI_DVCHK.o	    : PI_DVCHK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DVCHK.o	       $(CFLAGS) -c    PI_DVCHK.c

$(SDOBJ)/PI_DVDEL.o	    : PI_DVDEL.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DVDEL.o	       $(CFLAGS) -c    PI_DVDEL.c

$(SDOBJ)/PI_DVREAD.o	    : PI_DVREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DVREAD.o	       $(CFLAGS) -c    PI_DVREAD.c

$(SDOBJ)/PI_DVREN.o	    : PI_DVREN.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DVREN.o	       $(CFLAGS) -c    PI_DVREN.c

$(SDOBJ)/PI_DVUPD.o	    : PI_DVUPD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DVUPD.o	       $(CFLAGS) -c    PI_DVUPD.c

$(SDOBJ)/PI_REDDOC.o	    : PI_REDDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_REDDOC.o	       $(CFLAGS) -c    PI_REDDOC.c

$(SDOBJ)/PI_UPDDOC.o	    : PI_UPDDOC.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_UPDDOC.o	       $(CFLAGS) -c    PI_UPDDOC.c

$(SDOBJ)/PI_DCOMMIT.o	    : PI_DCOMMIT.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DCOMMIT.o	       $(CFLAGS) -c    PI_DCOMMIT.c

$(SDOBJ)/PI_UPDDIRINFO.o	    : PI_UPDDIRINFO.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_UPDDIRINFO.o	       $(CFLAGS) -c    PI_UPDDIRINFO.c

$(SDOBJ)/PI_DROLLBACK.o	    : PI_DROLLBACK.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DROLLBACK.o	       $(CFLAGS) -c    PI_DROLLBACK.c

$(SDOBJ)/PI_DLMREAD.o	    : PI_DLMREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DLMREAD.o	       $(CFLAGS) -c    PI_DLMREAD.c

$(SDOBJ)/PI_DLVREAD.o	    : PI_DLVREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DLVREAD.o	       $(CFLAGS) -c    PI_DLVREAD.c

$(SDOBJ)/PI_DLFREAD.o	    : PI_DLFREAD.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/PI_DLFREAD.o	       $(CFLAGS) -c    PI_DLFREAD.c

$(SDOBJ)/ds_chkbuildinf.o   : ds_chkbuildinf.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_chkbuildinf.o     $(CFLAGS) -c    ds_chkbuildinf.c

$(SDOBJ)/ds_chkdocid.o	    : ds_chkdocid.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_chkdocid.o        $(CFLAGS) -c    ds_chkdocid.c

$(SDOBJ)/ds_chkvolinf.o     : ds_chkvolinf.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_chkvolinf.o       $(CFLAGS) -c    ds_chkvolinf.c

$(SDOBJ)/ds_convert.o	    : ds_convert.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_convert.o	       $(CFLAGS) -c    ds_convert.c

$(SDOBJ)/ds_erase.o	    : ds_erase.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_erase.o	       $(CFLAGS) -c    ds_erase.c

$(SDOBJ)/ds_errset.o	    : ds_errset.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_errset.o	       $(CFLAGS) -c    ds_errset.c

$(SDOBJ)/ds_filegen.o	    : ds_filegen.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_filegen.o	       $(CFLAGS) -c    ds_filegen.c

$(SDOBJ)/ds_fileopen.o	    : ds_fileopen.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_fileopen.o        $(CFLAGS) -c    ds_fileopen.c

$(SDOBJ)/ds_fullpath.o	    : ds_fullpath.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_fullpath.o        $(CFLAGS) -c    ds_fullpath.c

$(SDOBJ)/ds_getver.o	    : ds_getver.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_getver.o	       $(CFLAGS) -c    ds_getver.c

$(SDOBJ)/ds_getvolno.o	    : ds_getvolno.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_getvolno.o        $(CFLAGS) -c    ds_getvolno.c

$(SDOBJ)/ds_getvolseq.o     : ds_getvolseq.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_getvolseq.o       $(CFLAGS) -c    ds_getvolseq.c

$(SDOBJ)/ds_movedoc.o	    : ds_movedoc.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_movedoc.o	       $(CFLAGS) -c    ds_movedoc.c

$(SDOBJ)/ds_newdocid.o	    : ds_newdocid.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_newdocid.o        $(CFLAGS) -c    ds_newdocid.c

$(SDOBJ)/ds_newvolno.o	    : ds_newvolno.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_newvolno.o        $(CFLAGS) -c    ds_newvolno.c

$(SDOBJ)/ds_nextfd.o	    : ds_nextfd.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_nextfd.o	       $(CFLAGS) -c    ds_nextfd.c

$(SDOBJ)/ds_setver.o	    : ds_setver.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_setver.o	       $(CFLAGS) -c    ds_setver.c

$(SDOBJ)/ds_splitvol.o	    : ds_splitvol.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_splitvol.o        $(CFLAGS) -c    ds_splitvol.c

$(SDOBJ)/ds_usedblkcnt.o    : ds_usedblkcnt.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_usedblkcnt.o      $(CFLAGS) -c    ds_usedblkcnt.c

$(SDOBJ)/ds_volgen.o	    : ds_volgen.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_volgen.o	       $(CFLAGS) -c    ds_volgen.c

$(SDOBJ)/ds_volopen.o	    : ds_volopen.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_volopen.o	       $(CFLAGS) -c    ds_volopen.c

$(SDOBJ)/ds_chkfsize.o	    : ds_chkfsize.c	    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_chkfsize.o	       $(CFLAGS) -c    ds_chkfsize.c

$(SDOBJ)/l_dsmlsethyerrno.o : l_dsmlsethyerrno.c    $(HEADER)
	$(CC) -o $(SDOBJ)/l_dsmlsethyerrno.o   $(CFLAGS) -c    l_dsmlsethyerrno.c

$(SDOBJ)/ds_splitpath.o : ds_splitpath.c    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_splitpath.o   $(CFLAGS) -c    ds_splitpath.c

$(SDOBJ)/ds_getnewdir.o : ds_getnewdir.c    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_getnewdir.o   $(CFLAGS) -c    ds_getnewdir.c

$(SDOBJ)/ds_getdirseq.o : ds_getdirseq.c    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_getdirseq.o   $(CFLAGS) -c    ds_getdirseq.c

$(SDOBJ)/ds_chkfdavail.o : ds_chkfdavail.c    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_chkfdavail.o   $(CFLAGS) -c    ds_chkfdavail.c

$(SDOBJ)/ds_log.o : ds_log.c    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_log.o   $(CFLAGS) -c    ds_log.c

$(SDOBJ)/ds_dprintf.o	: ds_dprintf.c    $(HEADER)
	$(CC) -o $(SDOBJ)/ds_dprintf.o   $(CFLAGS) -c    ds_dprintf.c

$(DDOBJ)/OPI_ADDDOC.o	    : OPI_ADDDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_ADDDOC.o	       $(MAKESLO) $(CFLAGS) -c	OPI_ADDDOC.c

$(DDOBJ)/OPI_DALLCLOSE.o    : OPI_DALLCLOSE.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DALLCLOSE.o      $(MAKESLO) $(CFLAGS) -c	OPI_DALLCLOSE.c

$(DDOBJ)/OPI_DBUILD.o	    : OPI_DBUILD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DBUILD.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DBUILD.c

$(DDOBJ)/OPI_DCLOSE.o	    : OPI_DCLOSE.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DCLOSE.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DCLOSE.c

$(DDOBJ)/OPI_DCONV.o	    : OPI_DCONV.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DCONV.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DCONV.c

$(DDOBJ)/OPI_DCROPEN.o	    : OPI_DCROPEN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DCROPEN.o        $(MAKESLO) $(CFLAGS) -c	  OPI_DCROPEN.c

$(DDOBJ)/OPI_DDCHK.o	    : OPI_DDCHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DDCHK.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DDCHK.c

$(DDOBJ)/OPI_DELDOC.o	    : OPI_DELDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DELDOC.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DELDOC.c

$(DDOBJ)/OPI_DHCHK.o	    : OPI_DHCHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DHCHK.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DHCHK.c

$(DDOBJ)/OPI_DHREAD.o	    : OPI_DHREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DHREAD.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DHREAD.c

$(DDOBJ)/OPI_DICHK.o	    : OPI_DICHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DICHK.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DICHK.c

$(DDOBJ)/OPI_DIFIRST.o	    : OPI_DIFIRST.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DIFIRST.o        $(MAKESLO) $(CFLAGS) -c	  OPI_DIFIRST.c

$(DDOBJ)/OPI_DILAST.o	    : OPI_DILAST.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DILAST.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DILAST.c

$(DDOBJ)/OPI_DINEXT.o	    : OPI_DINEXT.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DINEXT.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DINEXT.c

$(DDOBJ)/OPI_DIPREV.o	    : OPI_DIPREV.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DIPREV.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DIPREV.c

$(DDOBJ)/OPI_DIREAD.o	    : OPI_DIREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DIREAD.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DIREAD.c

$(DDOBJ)/OPI_DOPEN.o	    : OPI_DOPEN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DOPEN.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DOPEN.c

$(DDOBJ)/OPI_DUOPEN.o	    : OPI_DUOPEN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DUOPEN.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DUOPEN.c

$(DDOBJ)/OPI_DVADD.o	    : OPI_DVADD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DVADD.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DVADD.c

$(DDOBJ)/OPI_DVCHK.o	    : OPI_DVCHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DVCHK.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DVCHK.c

$(DDOBJ)/OPI_DVDEL.o	    : OPI_DVDEL.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DVDEL.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DVDEL.c

$(DDOBJ)/OPI_DVREAD.o	    : OPI_DVREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DVREAD.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DVREAD.c

$(DDOBJ)/OPI_DVREN.o	    : OPI_DVREN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DVREN.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DVREN.c

$(DDOBJ)/OPI_DVUPD.o	    : OPI_DVUPD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DVUPD.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DVUPD.c

$(DDOBJ)/OPI_REDDOC.o	    : OPI_REDDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_REDDOC.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_REDDOC.c

$(DDOBJ)/OPI_UPDDOC.o	    : OPI_UPDDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_UPDDOC.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_UPDDOC.c

$(DDOBJ)/OPI_DBUILD2.o	    : OPI_DBUILD2.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DBUILD2.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DBUILD2.c

$(DDOBJ)/OPI_ADDDIR.o	    : OPI_ADDDIR.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_ADDDIR.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_ADDDIR.c

$(DDOBJ)/OPI_DELDIR.o	    : OPI_DELDIR.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DELDIR.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_DELDIR.c

$(DDOBJ)/OPI_UPDDIR.o	    : OPI_UPDDIR.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_UPDDIR.o	       $(MAKESLO) $(CFLAGS) -c	  OPI_UPDDIR.c

$(DDOBJ)/OPI_UPDDIRINFO.o   : OPI_UPDDIRINFO.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_UPDDIRINFO.o     $(MAKESLO) $(CFLAGS) -c	  OPI_UPDDIRINFO.c

$(DDOBJ)/OPI_DLMREAD.o   : OPI_DLMREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DLMREAD.o     $(MAKESLO) $(CFLAGS) -c	  OPI_DLMREAD.c

$(DDOBJ)/OPI_DLVREAD.o   : OPI_DLVREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DLVREAD.o     $(MAKESLO) $(CFLAGS) -c	  OPI_DLVREAD.c

$(DDOBJ)/OPI_DLFREAD.o   : OPI_DLFREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/OPI_DLFREAD.o     $(MAKESLO) $(CFLAGS) -c	  OPI_DLFREAD.c

$(DDOBJ)/PI_ADDDOC.o	    : PI_ADDDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_ADDDOC.o	       $(MAKESLO) $(CFLAGS) -c	  PI_ADDDOC.c

$(DDOBJ)/PI_DALLCLOSE.o     : PI_DALLCLOSE.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DALLCLOSE.o       $(MAKESLO) $(CFLAGS) -c	  PI_DALLCLOSE.c

$(DDOBJ)/PI_DBUILD.o	    : PI_DBUILD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DBUILD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DBUILD.c

$(DDOBJ)/PI_DBUILD2.o	    : PI_DBUILD2.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DBUILD2.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DBUILD2.c

$(DDOBJ)/PI_ADDDIR.o	    : PI_ADDDIR.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_ADDDIR.o	       $(MAKESLO) $(CFLAGS) -c	  PI_ADDDIR.c

$(DDOBJ)/PI_UPDDIR.o	    : PI_UPDDIR.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_UPDDIR.o	       $(MAKESLO) $(CFLAGS) -c	  PI_UPDDIR.c

$(DDOBJ)/PI_DELDIR.o	    : PI_DELDIR.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DELDIR.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DELDIR.c

$(DDOBJ)/PI_DCLOSE.o	    : PI_DCLOSE.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DCLOSE.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DCLOSE.c

$(DDOBJ)/PI_DCONV.o	    : PI_DCONV.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DCONV.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DCONV.c

$(DDOBJ)/PI_DCROPEN.o	    : PI_DCROPEN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DCROPEN.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DCROPEN.c

$(DDOBJ)/PI_DDCHK.o	    : PI_DDCHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DDCHK.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DDCHK.c

$(DDOBJ)/PI_DELDOC.o	    : PI_DELDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DELDOC.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DELDOC.c

$(DDOBJ)/PI_DHCHK.o	    : PI_DHCHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DHCHK.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DHCHK.c

$(DDOBJ)/PI_DHREAD.o	    : PI_DHREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DHREAD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DHREAD.c

$(DDOBJ)/PI_DICHK.o	    : PI_DICHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DICHK.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DICHK.c

$(DDOBJ)/PI_DIFIRST.o	    : PI_DIFIRST.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DIFIRST.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DIFIRST.c

$(DDOBJ)/PI_DILAST.o	    : PI_DILAST.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DILAST.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DILAST.c

$(DDOBJ)/PI_DINEXT.o	    : PI_DINEXT.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DINEXT.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DINEXT.c

$(DDOBJ)/PI_DIPREV.o	    : PI_DIPREV.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DIPREV.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DIPREV.c

$(DDOBJ)/PI_DIREAD.o	    : PI_DIREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DIREAD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DIREAD.c

$(DDOBJ)/PI_DOPEN.o	    : PI_DOPEN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DOPEN.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DOPEN.c

$(DDOBJ)/PI_DUOPEN.o	    : PI_DUOPEN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DUOPEN.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DUOPEN.c

$(DDOBJ)/PI_DVADD.o	    : PI_DVADD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DVADD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DVADD.c

$(DDOBJ)/PI_DVCHK.o	    : PI_DVCHK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DVCHK.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DVCHK.c

$(DDOBJ)/PI_DVDEL.o	    : PI_DVDEL.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DVDEL.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DVDEL.c

$(DDOBJ)/PI_DVREAD.o	    : PI_DVREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DVREAD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DVREAD.c

$(DDOBJ)/PI_DVREN.o	    : PI_DVREN.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DVREN.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DVREN.c

$(DDOBJ)/PI_DVUPD.o	    : PI_DVUPD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DVUPD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DVUPD.c

$(DDOBJ)/PI_REDDOC.o	    : PI_REDDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_REDDOC.o	       $(MAKESLO) $(CFLAGS) -c	  PI_REDDOC.c

$(DDOBJ)/PI_UPDDOC.o	    : PI_UPDDOC.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_UPDDOC.o	       $(MAKESLO) $(CFLAGS) -c	  PI_UPDDOC.c

$(DDOBJ)/PI_DCOMMIT.o	    : PI_DCOMMIT.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DCOMMIT.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DCOMMIT.c

$(DDOBJ)/PI_DROLLBACK.o	    : PI_DROLLBACK.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DROLLBACK.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DROLLBACK.c

$(DDOBJ)/PI_UPDDIRINFO.o	    : PI_UPDDIRINFO.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_UPDDIRINFO.o	       $(MAKESLO) $(CFLAGS) -c	  PI_UPDDIRINFO.c

$(DDOBJ)/PI_DLMREAD.o	    : PI_DLMREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DLMREAD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DLMREAD.c

$(DDOBJ)/PI_DLVREAD.o	    : PI_DLVREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DLVREAD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DLVREAD.c

$(DDOBJ)/PI_DLFREAD.o	    : PI_DLFREAD.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/PI_DLFREAD.o	       $(MAKESLO) $(CFLAGS) -c	  PI_DLFREAD.c

$(DDOBJ)/ds_chkbuildinf.o   : ds_chkbuildinf.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_chkbuildinf.o     $(MAKESLO) $(CFLAGS) -c	  ds_chkbuildinf.c

$(DDOBJ)/ds_chkdocid.o	    : ds_chkdocid.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_chkdocid.o        $(MAKESLO) $(CFLAGS) -c	  ds_chkdocid.c

$(DDOBJ)/ds_chkvolinf.o     : ds_chkvolinf.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_chkvolinf.o       $(MAKESLO) $(CFLAGS) -c	  ds_chkvolinf.c

$(DDOBJ)/ds_convert.o	    : ds_convert.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_convert.o	       $(MAKESLO) $(CFLAGS) -c	  ds_convert.c

$(DDOBJ)/ds_erase.o	    : ds_erase.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_erase.o	       $(MAKESLO) $(CFLAGS) -c	  ds_erase.c

$(DDOBJ)/ds_errset.o	    : ds_errset.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_errset.o	       $(MAKESLO) $(CFLAGS) -c	  ds_errset.c

$(DDOBJ)/ds_filegen.o	    : ds_filegen.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_filegen.o	       $(MAKESLO) $(CFLAGS) -c	  ds_filegen.c

$(DDOBJ)/ds_fileopen.o	    : ds_fileopen.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_fileopen.o        $(MAKESLO) $(CFLAGS) -c	  ds_fileopen.c

$(DDOBJ)/ds_fullpath.o	    : ds_fullpath.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_fullpath.o        $(MAKESLO) $(CFLAGS) -c	  ds_fullpath.c

$(DDOBJ)/ds_getver.o	    : ds_getver.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_getver.o	       $(MAKESLO) $(CFLAGS) -c	  ds_getver.c

$(DDOBJ)/ds_getvolno.o	    : ds_getvolno.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_getvolno.o        $(MAKESLO) $(CFLAGS) -c	  ds_getvolno.c

$(DDOBJ)/ds_getvolseq.o     : ds_getvolseq.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_getvolseq.o       $(MAKESLO) $(CFLAGS) -c	  ds_getvolseq.c

$(DDOBJ)/ds_movedoc.o	    : ds_movedoc.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_movedoc.o	       $(MAKESLO) $(CFLAGS) -c	  ds_movedoc.c

$(DDOBJ)/ds_newdocid.o	    : ds_newdocid.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_newdocid.o        $(MAKESLO) $(CFLAGS) -c	  ds_newdocid.c

$(DDOBJ)/ds_newvolno.o	    : ds_newvolno.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_newvolno.o        $(MAKESLO) $(CFLAGS) -c	  ds_newvolno.c

$(DDOBJ)/ds_nextfd.o	    : ds_nextfd.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_nextfd.o	       $(MAKESLO) $(CFLAGS) -c	  ds_nextfd.c

$(DDOBJ)/ds_setver.o	    : ds_setver.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_setver.o	       $(MAKESLO) $(CFLAGS) -c	  ds_setver.c

$(DDOBJ)/ds_splitvol.o	    : ds_splitvol.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_splitvol.o        $(MAKESLO) $(CFLAGS) -c	  ds_splitvol.c

$(DDOBJ)/ds_usedblkcnt.o    : ds_usedblkcnt.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_usedblkcnt.o      $(MAKESLO) $(CFLAGS) -c	  ds_usedblkcnt.c

$(DDOBJ)/ds_volgen.o	    : ds_volgen.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_volgen.o	       $(MAKESLO) $(CFLAGS) -c	  ds_volgen.c

$(DDOBJ)/ds_volopen.o	    : ds_volopen.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_volopen.o	       $(MAKESLO) $(CFLAGS) -c	  ds_volopen.c

$(DDOBJ)/ds_chkfsize.o	    : ds_chkfsize.c	    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_chkfsize.o	       $(MAKESLO) $(CFLAGS) -c	  ds_chkfsize.c

$(DDOBJ)/l_dsmlsethyerrno.o : l_dsmlsethyerrno.c    $(HEADER)
	$(CC) -o $(DDOBJ)/l_dsmlsethyerrno.o   $(MAKESLO) $(CFLAGS) -c	  l_dsmlsethyerrno.c

$(DDOBJ)/ds_splitpath.o : ds_splitpath.c    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_splitpath.o   $(MAKESLO) $(CFLAGS) -c	  ds_splitpath.c

$(DDOBJ)/ds_getnewdir.o : ds_getnewdir.c    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_getnewdir.o   $(MAKESLO) $(CFLAGS) -c	  ds_getnewdir.c

$(DDOBJ)/ds_getdirseq.o : ds_getdirseq.c    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_getdirseq.o   $(MAKESLO) $(CFLAGS) -c	  ds_getdirseq.c

$(DDOBJ)/ds_chkfdavail.o : ds_chkfdavail.c    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_chkfdavail.o   $(MAKESLO) $(CFLAGS) -c	  ds_chkfdavail.c

$(DDOBJ)/ds_log.o : ds_log.c    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_log.o   $(MAKESLO) $(CFLAGS) -c	  ds_log.c

$(DDOBJ)/ds_dprintf.o : ds_dprintf.c    $(HEADER)
	$(CC) -o $(DDOBJ)/ds_dprintf.o   $(MAKESLO) $(CFLAGS) -c  ds_dprintf.c
