/* sm_fun.h */
/*----------------------------------------------------------------------*/
/* Common Header Internally Included within FIOLIB			*/
/*----------------------------------------------------------------------*/
/* SAMIO : SAM OUTPUT FUNCTIONS */

#ifndef SM_FUN_H
#define SM_FUN_H

/* 980423 for compatibility */
#include	"cbuni.h"

/*----------------------------------------------------------------------*/
/*  DEFINE VARIABLES							*/
/*----------------------------------------------------------------------*/
#define 	SM_LINESIZE	8192	/* line buffer size */

/*----------------------------------------------------------------------*/
/*	FUNCTION PROTOTYPE						*/
/*----------------------------------------------------------------------*/
void	sm_errset CBD2(( char *retcode ));

void	l_fiosethyerrno( int fio_hyerrno );

#endif
