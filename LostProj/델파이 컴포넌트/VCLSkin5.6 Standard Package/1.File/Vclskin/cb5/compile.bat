SET OLDPATH=%PATH%
CD %1
SET ROOT=d:\PROGRA~1\Borland\CBUILD~1\
SET PATH=%ROOT%Projects\Bpl;%ROOT%Projects\Lib;%ROOT%bin
SET MAKE=%ROOT%bin\make.exe
SET BPRMAKE=%ROOT%bin\bpr2mak.exe
%BPRMAKE% winskinc5.bpk
%MAKE% -B -f winskinc5.mak
SET Path=%OLDPATH%
