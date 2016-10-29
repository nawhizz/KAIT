/* PI_DDCHK() : LIB dsml */
/************************************************************************
*	check delete page and update					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
************************************************************************/

#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	check delete page						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DDCHK( int fd )
#else
PI_DDCHK( fd )
int	fd;
#endif
{
	int			verno;
	int			datasize;
	int			chgblkcnt;
	union	dsmuFORM	duo;
	int			volno;
	int			delseq;
	int			docid;
	int			deldocid;
	int			dflix;
	int			outcnt;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** change delete page
	**-------------------------------------------------------------*/
	if( verno < 2 )
		datasize = sizeof du.o1.dfl;
	else
		datasize = dsfi[fd].blksz * 1024 - DS_DEL_HEADSZ - 1;

	for( volno=0; verno < 2 ? volno < 1 : volno<dsfi[fd].volcnt; volno++ )
	{
		if( verno == 2 )
		{
			if( dsfi[fd].vol[volno].volgen != DS_GEN_VOLUME &&
			    dsfi[fd].vol[volno].volgen != DS_CGEN_VOLUME )
			{
				continue;
			}

			if( ds_volopen( fd, volno ) < 0 )
				return( -1 );
		}

		chgblkcnt = 0;

		/*-------------------------------------------------------
		** all delete page deleting
		**-----------------------------------------------------*/
		if( verno < 2 )
		{
			stint( 0, (char *)&du.o1.id );
			stint( 0, (char *)&du.o1.seq );
		}
		else
		{
			stlong( (long)0, (char *)&du.o.id );
			stlong( (long)0, (char *)&du.o.seq );
		}

		if( DP_REDGE( fd, verno, du ) >= 0 )
		{
			while( ( verno < 2 ? (int)ldint( (char *)&du.o1.id )
					  : (int)ldlong( ( char *)&du.o.id ) ) == 0 )
			{
				if( DP_DELETE( fd, verno, du ) < 0 )
				{
					if( verno )
						l_dsmlsethyerrno( iserrno );
					return( -1 );
				}

				chgblkcnt --;

				if( DP_REDNX( fd, verno, du ) < 0 )
					break;
			}
		}

		/*-------------------------------------------------------
		** check that document exist
		**-----------------------------------------------------*/
		if( verno < 2 )
		{
			stint( 1, (char *)&du.h1.id );
			stint( 0, (char *)&du.h1.seq );
		}
		else
		{
			stlong( (long)1, (char *)&du.h.id );
			stlong( (long)0, (char *)&du.h.seq );
		}

		if( DP_REDGE( fd, verno, du ) < 0 )
		{
			if( verno == 2 )
				if( ds_usedblkcnt( fd, chgblkcnt, 0 ) < 0 )
					return( -1 );

			continue;
		}

		/*-------------------------------------------------------
		** add delete page
		**-----------------------------------------------------*/
		delseq = -1;
		outcnt = 0;
		if( verno < 2 )
			deldocid = 1;
		else
			deldocid = dsfi[fd].vol[volno].mindocid;

		for( ; ; )
		{
			if( verno < 2 )
				docid = ldint( (char *)&du.h1.id );
			else
				docid = (int)ldlong( (char *)&du.h.id );

			for( ; deldocid<docid; deldocid ++ )
			{
				if( delseq != deldocid / ( datasize * 8 ) )
				{
					if( outcnt != 0 )
					{
						if( verno < 2 )
							stint( (short)outcnt,
						       (char *)&duo.o1.outcnt );
						else
							stlong( (long)outcnt,
							(char *)&duo.o.outcnt );

						if( DP_INSERT( fd, verno,
								duo ) < 0 )
						{
							if( verno )
							      l_dsmlsethyerrno( iserrno );
							return( -1 );
						}
						chgblkcnt++;

						outcnt = 0;
					}

					delseq = deldocid / ( datasize * 8 );
					memset( &duo, 0, sizeof duo );
					if( verno < 2 )
					{
						stint( 0, (char *)&duo.o1.id );
						stint( delseq,
							(char *)&duo.o1.seq );
					}
					else
					{
						stlong( (long)0, (char *)&duo.o.id );
						stlong( (long)delseq,
							(char *)&duo.o.seq );
					}

				} /* end of if ( new delete page ) */

				dflix = deldocid % ( datasize * 8 );
				outcnt++;
				if( verno < 2 )
					duo.o1.dfl[dflix / 8] |= 1 << dflix % 8;
				else
					duo.o.dfl[dflix / 8] |= 1 << dflix % 8;

			} /* end of for add delete document id to delete page */
			deldocid = docid + 1;

			if( verno < 2 )
			{
				stint( (short)( docid + 1 ),
							(char *)&du.h1.id );
				stint( 0, (char *)&du.h1.seq );
			}
			else
			{
				stlong( (long)(docid + 1), (char *)&du.h.id );
				stlong( (long)0, (char *)&du.h.seq );
			}

			if( DP_REDGE( fd, verno, du ) < 0 )
				break;

		} /* end of for document read */

		/* add last delete page */
		if( outcnt != 0 )
		{
			if( verno < 2 )
				stint( (short)outcnt, (char *)&duo.o1.outcnt );
			else
				stlong( (long)outcnt, (char *)&duo.o.outcnt );

			if( DP_INSERT( fd, verno, duo ) < 0 )
			{
				if( verno )
				      l_dsmlsethyerrno( iserrno );
				return( -1 );
			}
			chgblkcnt++;
		}

		/*-------------------------------------------------------
		** change block count
		**-----------------------------------------------------*/
		if( verno == 2 )
			if( ds_usedblkcnt( fd, chgblkcnt, 0 ) < 0 )
				return( -1 );

	} /* end of for ( volume ) */

	return( 0 );
}

/******* The end of PI_DDCHK.c *****************************************/
