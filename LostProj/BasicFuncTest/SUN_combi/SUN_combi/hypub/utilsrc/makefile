SUBDIR	= \
	dsmladm \
	showsem showshm \
	socktst \
	isinfo isutil \
	dgrep sgrep fchk fcom fsep fstr mann manv \
	pinfo top dwc

all 	:
	@echo HYPUB/UTILSRC
	@for i in $(SUBDIR); do ( cd $$i; make $@ ); done;
