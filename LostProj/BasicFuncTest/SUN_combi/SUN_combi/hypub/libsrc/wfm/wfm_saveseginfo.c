/* wfm_saveseginfo() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : save segment information					*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"wfm_fun.h"

/*----------------------------------------------------------------------*/
/* internal function */
/*----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
l_findendptr( char *i_ptr, char **f_ptr )
#else
l_findendptr( i_ptr, f_ptr )
char	*i_ptr;
char	**f_ptr;
#endif
{
	char	*tptr;

	if( (tptr= strstr( i_ptr, "</FMSEG>" ))==(char *)0 )
		return -1;	

	tptr[0] = '\0';
	(*f_ptr)=tptr;

	return 0;
}

int
#if	defined( __CB_STDC__ )
l_findnxtseg( char *f_ptr, char **n_ptr )
#else
l_findnxtseg( f_ptr, n_ptr )
char	*f_ptr;
char	**n_ptr;
#endif
{
	char	*tptr;

	if( (tptr=strstr( f_ptr, "<FMSEG" ))==(char *)0 )
		return -1;

	tptr[0] = '\0';
	(*n_ptr)=tptr;

	return 0;
}

int
#if	defined( __CB_STDC__ )
l_getsegname( char **t_ptr, char **tmpnm )
#else
l_getsegname( t_ptr, tmpnm )
char	**t_ptr;
char	**tmpnm;
#endif
{
	char	*tptr;

	/* move *t_ptr to startposition of segment name */
	*t_ptr += 13;		/* <FMSEG NAME=" */
				/* NAME = "  not allowed */
	if( (tptr = strstr( *t_ptr, "\">" ))==(char *)0 )
	{
		*t_ptr -= 13;	/* rollback ptr to start ptr */
		return -1;
	}

	tptr[0] = '\0';

	/* set ptr of tmpnm to point segment name */
	(*tmpnm) = *t_ptr;

	/* set *t_ptr to startposition of segment contents */

	for( ; *tptr!='\n';tptr++); (*t_ptr)=tptr+1;

	/* history 2000.12.9 */
	if( *(tptr+1) == '\r' ) (*t_ptr)=tptr+2;
	/* history 2000.12.9 */

	return 0;
}

struct WFM_BLKINFO *
#if	defined( __CB_STDC__ )
l_savefldinfo( char *t_ptr, int *totlen )
#else
l_savefldinfo( t_ptr, totlen )
char	*t_ptr;
int	*totlen
#endif
{
	char	*tptr1;
	char	*tptr2;
	int	sumlen=0;
	struct	WFM_BLKINFO	*i_blk;	/* first blk ptr(willbe returned) */
	struct	WFM_BLKINFO	*t_blk;	/* tmp blk ptr */
	struct	WFM_BLKINFO	*bf_blk;/* before blk ptr in for loop */

	i_blk = (struct WFM_BLKINFO *)0;
	bf_blk = (struct WFM_BLKINFO *)0;

	for( ; ; )
	{
		if( (t_blk =(struct WFM_BLKINFO *)malloc(
			sizeof(struct WFM_BLKINFO)))==(struct WFM_BLKINFO *)0 )
		{
			if( i_blk != (struct WFM_BLKINFO *)0 )
				wfm_freeblkinfo( i_blk );

			return (struct WFM_BLKINFO *)0;
		}

		/* save first blk ptr for returning */
		if( bf_blk == (struct WFM_BLKINFO *)0 )
			i_blk = t_blk;

		/* set curret ptr->next to null ptr */
		t_blk->next = (struct WFM_BLKINFO *)0;

		/* set before ptr->next to current ptr */
		if( bf_blk != (struct WFM_BLKINFO *)0 )
			bf_blk->next = t_blk;

		/* find next field position */
		if( (tptr1 = strstr( t_ptr, "[#$" ))==(char *)0 )
		{
			if( bf_blk!=(struct WFM_BLKINFO *)0 )
				bf_blk->next = t_blk;
			t_blk->next = (struct WFM_BLKINFO *)0;
			t_blk->beftxt = t_ptr;
			t_blk->fldnm = (char *)0;
			sumlen += strlen( t_ptr );
			break;
		}

		tptr1[0] = '\0';

		t_blk->beftxt = t_ptr;
		sumlen += strlen( t_ptr );

		tptr1 += 3;
		if( (tptr2 = strstr( tptr1, "]" ) )==(char *)0 )
		{
			wfm_freeblkinfo( i_blk );
			return (struct WFM_BLKINFO *)0;
		}

		tptr2[0] = '\0';

		t_blk->fldnm = tptr1;

		t_ptr = tptr2 + 1;

		/* save current ptr to bf_ptr for using in next loop */
		bf_blk = t_blk;
	}
/*
wfm_prtblk( stdout, i_blk );
*/
	(*totlen) = sumlen;
	return( i_blk ); 
}
/*----------------------------------------------------------------------*/


int
#if	defined( __CB_STDC__ )
wfm_saveseginfo( char *fbuff, int fsize, struct WFM_SEGINFO **hseg,
		 struct WFM_SEGINFO **cseg, struct WFM_SEGINFO **tseg )
#else
wfm_saveseginfo( fbuff, fsize, hseg, cseg, tseg )
	char *fbuff;
	int fsize;
	struct WFM_SEGINFO **hseg;
	struct WFM_SEGINFO **cseg;
	struct WFM_SEGINFO **tseg;
#endif
{
	struct WFM_SEGINFO	*tmpseg;
	struct WFM_SEGINFO	*bfseg;
	char	*i_ptr=fbuff;		/* seg init pointer */
	char	*f_ptr=fbuff;		/* seg end pointer */
	char	*n_ptr=fbuff;		/* next seg init pointer */
	char	*t_ptr=fbuff;		/* temp seg pointer */
	char	*tmpnm;
	int	totlen;
	int	sts = 0;		/* 0	: head */
					/* 1	: first body */
					/* 2	: body */
					/* 3	: last body */
					/* 4	: tail */
					/* 5	: no segment */
	int	oneseg = 0;		/* only one segment */

	for(;;)
	{
		/* pointer setting */
		t_ptr = i_ptr = n_ptr;

		if( (sts>=1 && sts<=3)&&( l_findendptr( i_ptr+1, &f_ptr) )<0 )
		{
			wfm_freeseginfo( (*cseg) );
			(*cseg) = (struct WFM_SEGINFO *)0;
			return -1;
		}

		if( sts<3 )
		{
			if( sts==0 ) f_ptr--;
			if( l_findnxtseg( f_ptr+1, &n_ptr) < 0 )
			{
				if( sts==0 ) sts = 5;
				else
				{
					if( sts==1) oneseg=1;
					sts = 3;
					n_ptr = f_ptr+8; /*</FMSEG>*/
					for( ; *n_ptr!='\n'; n_ptr++ ); n_ptr++;
					/* history 2000.12.9 */
					if( *n_ptr=='\r' ) n_ptr++;
					/* history 2000.12.9 */
				}
			}
		}

		if( sts==0 )
			f_ptr=n_ptr;

		if( ( tmpseg = (struct WFM_SEGINFO *)malloc(
			sizeof(struct WFM_SEGINFO)))==(struct WFM_SEGINFO *)0 )
		{
			if( sts>=2 && sts<=4 )
			{
				wfm_freeseginfo( (*cseg) );
				wfm_freeseginfo( (*hseg) );
				(*cseg) = (struct WFM_SEGINFO *)0;
				(*hseg) = (struct WFM_SEGINFO *)0;
			}
			else if( sts==1 )
				wfm_freeseginfo( (*hseg) );
				(*hseg) = (struct WFM_SEGINFO *)0;

			return -1;
		}

		if( sts>=1 && sts<=3 )
		{
			if( l_getsegname( &(t_ptr), &tmpnm ) < 0 )
			{
				free( tmpseg );
				wfm_freeseginfo( (*cseg) );
				wfm_freeseginfo( (*hseg) );
				(*cseg) = (struct WFM_SEGINFO *)0;
				(*hseg) = (struct WFM_SEGINFO *)0;
				return -1;
			}
		}

		if( ( tmpseg->blk = l_savefldinfo( t_ptr, &totlen ) )
			== (struct WFM_BLKINFO *)0 )
		{
			free( tmpseg );
			wfm_freeseginfo( (*cseg) );
			wfm_freeseginfo( (*hseg) );
			(*cseg) = (struct WFM_SEGINFO *)0;
			(*hseg) = (struct WFM_SEGINFO *)0;
			return -1;
		}
/*
printf("\n#########AFTER l_savefldinfo##################\n" );
wfm_prtblk( stdout, tmpseg->blk );
printf("##############################################\n\n" );
*/
		tmpseg->beftxt_totlen = totlen;

		if( sts==0 )
		{
			(*hseg)=tmpseg;
			(*hseg)->segnm="HEAD";
			(*hseg)->next = (struct WFM_SEGINFO *)0;
			sts=1;
		}
		else if( sts==1 )
		{
			tmpseg->segnm = tmpnm;
			tmpseg->next = (struct WFM_SEGINFO *)0;
			(*cseg) = tmpseg;
			sts=2;
		}
		else if( sts==2 )
		{
			tmpseg->segnm = tmpnm;
			tmpseg->next = (struct WFM_SEGINFO *)0;
			bfseg->next = tmpseg;
		}
		else if( sts==3 )
		{
			if( oneseg )
			{
				tmpseg->segnm = tmpnm;
				tmpseg->next = (struct WFM_SEGINFO *)0;
				(*cseg) = tmpseg;
			}
			else
			{
				tmpseg->segnm = tmpnm;
				tmpseg->next = (struct WFM_SEGINFO *)0;
				bfseg->next = tmpseg;
			}
			sts=4;
		}
		else if( sts==4 )
		{
			bfseg->next = (struct WFM_SEGINFO *)0;
			(*tseg) = tmpseg;
			(*tseg)->segnm="TAIL";
			(*tseg)->next = (struct WFM_SEGINFO *)0;
			break;
		}
		else if( sts==5 )
		{
			(*hseg) = (struct WFM_SEGINFO *)0;
			(*tseg) = (struct WFM_SEGINFO *)0;
			(*cseg) = tmpseg;
			(*cseg)->segnm=(char *)0;
			(*cseg)->next = (struct WFM_SEGINFO *)0;
			break;
		}

		/* save current seg pointer in bfseg */
		bfseg = tmpseg;
	}
/*
wfm_prtseg( stdout, *hseg, "#######HHEEDD######" );
wfm_prtseg( stdout, *cseg, "#######BBDDYY######" );
wfm_prtseg( stdout, *tseg, "#######TTAILL######" );
*/
	return( 0 );	
}
