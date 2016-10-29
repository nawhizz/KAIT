
#include 	<usrinc/atmi.h>

#include 	<usrinc/svct.h>

#if defined (__cplusplus)
extern "C" {
#endif

#if defined(_CBL_MODULE)
/* COBOL function declaration */
extern int TMAXADMIN(void);
#else
/* C/C++ function declaration */
extern void TMAXADMIN(TPSVCINFO *);
#endif

#if defined (__cplusplus)
}
#endif


_svc_t _svc_tab[] = {
	{"TMAXADMIN", TMAXADMIN, 0}};

int _svc_tab_size = 1;
