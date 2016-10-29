      * WCOMTCA.H
      *-----------------------------------------------------------------------
      * DLTP APPLICATION PROGRAM TCA(WCOM) DATA for COBOL
      *-----------------------------------------------------------------------
	01 TCA-AREA.
      *						TCA AREA FORM.
	    03 TCA-CLIENT-INF.
      *						CLIENT INFO.
		05 TCA-CLIID		 PIC X(8).
      *						CLIENT ID.
		05 TCA-CLINM		 PIC X(20).
      *						CLIENT NAME.
		05 TCA-CLIKIND		 PIC X(1).
      *						CLIENT KIND.
		05 TCA-FILLER1		 PIC X(3).
      *						FILLER 1.
	    03 TCA-SESSION-INF.
      *						SESSION INFO.
		05 TCA-TERMID		 PIC X(8).
      *						TERM ID.
		05 TCA-CLIHOSTNM	 PIC X(16).
      *						CLIENT HOST NAME.
		05 TCA-TPSTARTTM	 PIC S9(8) COMP.
      *						TP START TIME.
		05 TCA-SVPID		 PIC S9(8) COMP.
      *						SERVER PROCESS ID.
	    03 TCA-AS-INF.
      *						AS INFO.
		05 TCA-ASID		 PIC X(4).
      *						ASID.
		05 TCA-ASHOME		 PIC X(80).
      *						$ASHOME DIR.
		05 TCA-ASCFG		 PIC X(80).
      *						$ASCFG FILE PATH.
		05 TCA-MYHOSTID 	 PIC X(1).
      *						MY HOST ID.
		05 TCA-TXCNTL		 PIC X(80).
      *						$TXCNTL DIR.
		05 TCA-USERCNTL 	 PIC X(80).
      *						$USERCNTL DIR.
		05 TCA-TXAPPL		 PIC X(80).
      *						$TXAPPL DIR.
		05 TCA-MYOWNER		 PIC X(16).
      *						OWNER.
		05 TCA-MAINRHOSTID	 PIC X(1).
      *						MAIN REMOTE HOST ID.
		05 TCA-FILLER2		 PIC X(2).
      *						FILLER 2.
		05 TCA-MYOWNID		 PIC S9(8) COMP.
      *						OWNER ID.
		05 TCA-MYGRPID		 PIC S9(8) COMP.
      *						GROUP ID.
	    03 TCA-USER-INF.
      *						USER INFO.
		05 TCA-USID		 PIC X(8).
      *						USER ID.
		05 TCA-USNM		 PIC X(12).
      *						USER NAME.
		05 TCA-UGRP		 PIC X(4).
      *						USER GROUP ID.
		05 TCA-UGRPNM		 PIC X(20).
      *						USER GROUP NAME.
		05 TCA-ULEV		 PIC X(1).
      *						USER LEVEL ID.
		05 TCA-ULEVNM		 PIC X(20).
      *						USER LEVEL NAME.
		05 TCA-FILLER3		 PIC X(3).
      *						FILLER 3.
		05 TCA-ULOGINTM 	 PIC S9(8) COMP.
      *						USER LOGIN TIME.
	    03 TCA-TX-INF.
      *						TX INFO.
		05 TCA-TXID		 PIC X(8).
      *						TXID.
		05 TCA-PGID		 PIC X(8).
      *						PGID.
		05 TCA-PGFPATH		 PIC X(80).
      *						PROGRAM FILE PATH.
		05 TCA-TXSTARTTM	 PIC S9(8) COMP.
      *						TX START TIME.
		05 TCA-APPID		 PIC S9(8) COMP.
      *						APPL PROCESS ID.
