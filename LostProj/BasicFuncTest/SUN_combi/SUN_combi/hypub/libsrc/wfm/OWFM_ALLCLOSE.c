/* OWFM_ALLCLOSE () : LIB wfm */
/*----------------------------------------------------------------------*
|									|
|	void OWFM_ALLCLOSE()						|
|									|
|	close all opened form file					|
|									|
*----------------------------------------------------------------------*/

#include	"wfm.h"

void CBD1
#if	defined( __CB_STDC__ )
OWFM_ALLCLOSE()
#else
OWFM_ALLCLOSE()
#endif
{
	WFmAllClose();
}
