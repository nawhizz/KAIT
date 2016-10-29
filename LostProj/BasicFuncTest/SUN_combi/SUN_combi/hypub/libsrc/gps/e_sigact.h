/* e_sigact.h */
/*----------------------------------------------------------------------*/
/* HEADER for GPSLIB							*/
/*----------------------------------------------------------------------*/
/* Signal Function's common header */

#ifndef E_SIG_H
#define E_SIG_H

#define MAX_signal	36
#define MAX_action	20

extern	(*e_sigaction[MAX_signal][MAX_action])	();

#endif
