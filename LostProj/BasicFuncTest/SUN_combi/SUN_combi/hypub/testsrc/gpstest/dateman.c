/************************************************************************
*	GPS library testing program ( date maniplation )		*
************************************************************************/

/*******************************************************************************
*	변경내역							       *
* 2000.6.23 : 김성환. gps 함수 변경에 따른 수정. e_gdatebydu		       *
*******************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>

#include	"cbuni.h"

#include	"gps.h"

/*---------------------------------------------------------------------*/
void
E_ALLDAYGET()
{
	char	srcdate[80];
	char	mask[80];
	int	allday;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_alldayget( char *srcdate(i), char *mask(i) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate    : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask       : " );
	gets( mask );

	allday = e_alldayget( srcdate, mask );

	printf( " Result day : [%d]\n", allday );

} /* E_ALLFAYGET */

/*---------------------------------------------------------------------*/
void
E_CDATE2FORM()
{
	char	tmpstr[80];
	char	srcdate[80];
	char	destdate[80];
	int	form;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_cdate2form( char *srcdate(i), int form(i),    |\n" );
	printf( "|                    char *destdate(o) )                |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " form        : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}

	memset( destdate, 0, sizeof destdate );
	if( e_cdate2form( srcdate, form, destdate ) < 0 )
	{
		printf( "e_cdate2form error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_CDATE2FORM */

/*---------------------------------------------------------------------*/
void
E_CHKDATE()
{
	char	tmpstr[80];
	char	date[80];
	int	form;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_chkdate( char *date(i), int form(i) )         |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " date   : " );
	gets( date );
	gets( date );
	printf( " form   : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}

	if( e_chkdate( date, form ) < 0 )
		printf( " Result : FALSE\n" );
	else
		printf( " Result : TRUE\n" );

} /* E_CHKDATE */

/*---------------------------------------------------------------------*/
void
E_DATE2JUL()
{
	char	srcdate[80];
	char	mask[80];
	int	jul;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_date2jul( char *srcdate(i), char *mask(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate        : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask           : " );
	gets( mask );

	jul = e_date2jul( srcdate, mask );

	printf( " Result jul_day : [%d]\n", jul );

} /* E_DATE2JUL */

/*---------------------------------------------------------------------*/
void
E_DATECHK()
{
	char	date[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_datechk( char *date(i), char *mask(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " date   : " );
	gets( date );
	gets( date );
	printf( " mask   : " );
	gets( mask );

	if( e_datechk( date, mask ) < 0 )
		printf( " Result : FALSE\n" );
	else
		printf( " Result : TRUE\n" );

} /* E_DATECHK */

/*---------------------------------------------------------------------*/
void
E_DATECMP()
{
	char	date1[80];
	char	date2[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_datecmp( char *date1(i), char *date2(i),      |\n" );
	printf( "|                  char *mask(i) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " date1  : " );
	gets( date1 );
	gets( date1 );
	printf( " date2  : " );
	gets( date2 );
	printf( " mask   : " );
	gets( mask );

	if( e_datecmp( date1, date2, mask ) < 0 )
		printf( " Result : Differ\n" );
	else
		printf( " Result : Same\n" );

} /* E_DATECMP */

/*---------------------------------------------------------------------*/
void
E_DAY2NDAY()
{
	char	tmpstr[80];
	char	srcdate[80];
	char	destdate[80];
	int	nmonth;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_day2nday( char *srcdate(i), int nmonth(i),    |\n" );
	printf( "|                   char *destdate(o) )                 |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " nmonth      : " );
	scanf( "%s", tmpstr );
	if( ( nmonth = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid nmonth ......\n" );
		return;
	}

	memset( destdate, 0, sizeof destdate );
	if( e_day2nday( srcdate, nmonth, destdate ) < 0 )
	{
		printf( "e_day2nday error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_DAY2NDAY */

/*---------------------------------------------------------------------*/
void
E_DUDATE()
{
	char	tmpstr[80];
	int	dur;
	char	srcdate[80];
	char	destdate[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_dudate( int dur(i), char *srcdate(i),         |\n" );
	printf( "|                 char *destdate(o), char *mask(i) )    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " dur         : " );
	scanf( "%s", tmpstr );
	if( ( dur = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid dur ......\n" );
		return;
	}
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask        : " );
	gets( mask );

	memset( destdate, 0, sizeof destdate );
	if( e_dudate( dur, srcdate, destdate, mask ) < 0 )
	{
		printf( "e_dudate error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_DUDATE */

/*---------------------------------------------------------------------*/
void
E_FULLYEAR()
{
	char	srcdate[80];
	char	destdate[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_fullyear( char *srcdate(i),                   |\n" );
	printf( "|                 char *destdate(o) )                   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );

	memset( destdate, 0, sizeof destdate );
	if( e_fullyear( srcdate, destdate ) < 0 )
	{
		printf( "e_fullyear error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_FULLYEAR */

/*---------------------------------------------------------------------*/
void
E_GDATE2DATE()
{
	char	tmpstr[80];
	char	date[80];
	int	form;
	long	ldate;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_gdate2date( char *date(i), int form(i),       |\n" );
	printf( "|                  long *ldate(o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " date        : " );
	gets( date );
	gets( date );
	printf( " form        : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}

	if( e_gdate2date( date, form, &ldate ) < 0 )
	{
		printf( "e_gdate2date error ....\n" );
		return;
	}

	printf( " Result date : [%d]\n", ldate );

} /* E_GDATE2DATE */

/*---------------------------------------------------------------------*/
void
E_GDATE2YEAR()
{
	char	tmpstr[80];
	char	date[80];
	int	form;
	long	ldate;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_gdate2year( char *date(i), int form(i),       |\n" );
	printf( "|                  long *ldate(o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " date        : " );
	gets( date );
	gets( date );
	printf( " form        : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}

	if( e_gdate2year( date, form, &ldate ) < 0 )
	{
		printf( "e_gdate2year error ....\n" );
		return;
	}

	printf( " Result date : [%d]\n", ldate );

} /* E_GDATE2YEAR */

/*---------------------------------------------------------------------*/
void
E_GDATEBYDU()
{
	char	tmpstr[80];
	int	form;
	char	srcdate[80];
	char	destdate[80];
	int	duration;
	int	flag;
	int	i;		/*2000.6.23*/

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_gdatebydu( int form(i), char *srcdate(i),     |\n" );
	printf( "|                  int duration(i), int flag(i),        |\n" );
	printf( "|                  char *destdate(o) )                  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " form       : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}
	printf( " srcdate    : " );
	gets( srcdate );
	gets( srcdate );
	printf( " duration   : " );
	scanf( "%s", tmpstr );
/*2000.6.23 수정 start----------------------------------------------------------
	if( ( duration = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid duration ......\n" );
		return;
	}
------------------------------------------------------------------------------*/
	if( tmpstr[0] == '+' || tmpstr[0] == '-' )
		i = 1;
	else
		i = 0;
	for( ; i<strlen(tmpstr); i++ )
	{
		if( !isdigit( tmpstr[i] ) )
		{
			printf( "invalid duration ......\n" );
			return;
		}
	}
	duration = atoi( tmpstr );
/*2000.6.23 end---------------------------------------------------------------*/
	printf( " flag        : " );
	scanf( "%s", tmpstr );
	if( ( flag = atoi( tmpstr ) ) < -1 || flag > 0 )
	{
		printf( "invalid flag ......\n" );
		return;
	}

	memset( destdate, 0, sizeof destdate );
	if( e_gdatebydu( form, srcdate, duration, flag, destdate ) < 0 )
	{
		printf( "e_gdatebydu error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_GDATEBYDU */

/*---------------------------------------------------------------------*/
void
E_GETDATESTR()
{
	char	tmpstr[80];
	long	timeval;
	int	choice;
	char	datestr[80];
	char	timestr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_getdatestr( long timeval(i), int choice(i),   |\n" );
	printf( "|                  char *datestr(o), char *timestr(o) ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " timeval     : " );
	scanf( "%s", tmpstr );
	if( (timeval = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid timeval ......\n" );
		return;
	}
	printf( " choice      : " );
	scanf( "%s", tmpstr );
	if( ( choice = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid choice ......\n" );
		return;
	}

	memset( datestr, 0, sizeof datestr );
	memset( timestr, 0, sizeof timestr );
	if( e_getdatestr( timeval, choice, datestr, timestr ) < 0 )
	{
		printf( "e_getdatestr error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", datestr );
	printf( " Result time : [%s]\n", timestr );

} /* E_GETDATESTR */

/*---------------------------------------------------------------------*/
void
E_GETSYSDATE()
{
	char	tmpstr[80];
	int	choice;
	char	datestr[80];
	char	timestr[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_getsysdate( int choice(i),                    |\n" );
	printf( "|                  char *datestr(o), char *timestr(o) ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " choice      : " );
	scanf( "%s", tmpstr );
	if( ( choice = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid choice ......\n" );
		return;
	}

	memset( datestr, 0, sizeof datestr );
	memset( timestr, 0, sizeof timestr );
	if( e_getsysdate( choice, datestr, timestr ) < 0 )
	{
		printf( "e_getsysdate error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", datestr );
	printf( " Result time : [%s]\n", timestr );

} /* E_GETSYSDATE */

/*---------------------------------------------------------------------*/
void
E_GETTIME()
{
	E_TIMESEC	tsc;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_gettime( E_TIMESEC *tsc(o) )                  |\n" );
	printf( "+-------------------------------------------------------+\n" );

	e_gettime( &tsc );

	printf( " Result tsc.sec   : [%d]\n", tsc.sec );
	printf( " Result tsc.micro : [%d]\n", tsc.micro );

} /* E_GETTIME */

/*---------------------------------------------------------------------*/
void
E_GETWEEKDAY()
{
	int	weekday;
	char	srcdate[41], mask[41];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_getweekday( char *srcdate(i) char *mask(i)    |\n" );
	printf( "+-------------------------------------------------------+\n" );

	printf( " srcdate        : " );
	gets( srcdate );
	gets( srcdate );

	printf( " mask           : " );
	gets( mask );

	if( srcdate[0] == '\0' )
		weekday = e_getweekday( (char *)0, mask );
	else
		weekday = e_getweekday( srcdate, mask );

	printf( " Result weekday : [%d] (0 is 일요일)\n", weekday );
}

/*---------------------------------------------------------------------*/
void
E_GETYEAR()
{
	char	tmpstr[80];
	int	year;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_getyear( int year(i) )                        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " year        : " );
	scanf( "%s", tmpstr );
	if( ( year = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid year ......\n" );
		return;
	}

	if( ( year = e_getyear( year ) ) < 0 )
	{
		printf( "e_getyear error ....\n" );
		return;
	}

	printf( " Result year : [%d]\n", year );

} /* E_GETYEAR */

/*---------------------------------------------------------------------*/
void
E_GMONTBYDU()
{
	char	tmpstr[80];
	int	form;
	char	srcdate[80];
	char	destdate[80];
	int	duration;
	int	flag;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_gmontbydu( int form(i), char *srcdate(i),     |\n" );
	printf( "|                  int duration(i), int flag(i),        |\n" );
	printf( "|                  char *destdate(o) )                  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " form        : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " duration    : " );
	scanf( "%s", tmpstr );
	if( ( duration = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid duration ......\n" );
		return;
	}
	printf( " flag        : " );
	scanf( "%s", tmpstr );
	if( ( flag = atoi( tmpstr ) ) < -1 || flag > 0 )
	{
		printf( "invalid flag ......\n" );
		return;
	}

	memset( destdate, 0, sizeof destdate );
	if( e_gmontbydu( form, srcdate, duration, flag, destdate ) < 0 )
	{
		printf( "e_gmontbydu error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_GMONTBYDU */

/*---------------------------------------------------------------------*/
void
E_GRE2JUL()
{
	char	tmpstr[80];
	int	form;
	char	date[80];
	int	jul;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_gmontbydu( char *date(i), int form(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " date       : " );
	gets( date );
	gets( date );
	printf( " form       : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}

	if( ( jul = e_gre2jul( date, form ) ) < 0 )
	{
		printf( "e_gre2jul error ....\n" );
		return;
	}

	printf( " Result jul : [%d]\n", jul );

} /* E_GRE2JUL */

/*---------------------------------------------------------------------*/
void
E_JUL2DATE()
{
	char	tmpstr[80];
	int	jul;
	char	srcdate[80];
	char	destdate[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_jul2date( int jul(i), char *srcdate(i),       |\n" );
	printf( "|                 char *destdate(o), char *mask(i) )    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " jul         : " );
	scanf( "%s", tmpstr );
	if( ( jul = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid jul ......\n" );
		return;
	}
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask        : " );
	gets( mask );

	memset( destdate, 0, sizeof destdate );
	if( e_jul2date( jul, srcdate, destdate, mask ) < 0 )
	{
		printf( "e_jul2date error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_JUL2DATE */

/*---------------------------------------------------------------------*/
void
E_JUL2GRE()
{
	char	tmpstr[80];
	int	jul;
	int	form;
	char	srcdate[80];
	char	destdate[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_jul2gre( int jul(i), int form(i),             |\n" );
	printf( "|                char *srcdate(i), char *destdate(o) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " jul         : " );
	scanf( "%s", tmpstr );
	if( ( jul = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid jul ......\n" );
		return;
	}
	printf( " form        : " );
	scanf( "%s", tmpstr );
	if( ( form = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid form ......\n" );
		return;
	}
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );

	memset( destdate, 0, sizeof destdate );
	if( e_jul2gre( jul, form, srcdate, destdate ) < 0 )
	{
		printf( "e_gmontbydu error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_JUL2GRE */

/*---------------------------------------------------------------------*/
void
E_LSTDAYGET()
{
	char	srcdate[80];
	char	lstday[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_lstdayget( char *srcdate(i), char *lstday(o), |\n" );
	printf( "|                    char *mask(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate       : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask          : " );
	gets( mask );

	if( e_lstdayget( srcdate, lstday, mask ) < 0 )
	{
		printf( "e_lstdayget error ....\n" );
		return;
	}

	printf( " Result lstday : [%s]\n", lstday );

} /* E_LSTDAYGET */

/*---------------------------------------------------------------------*/
void
E_NEXTDAY()
{
	char	srcdate[80];
	char	destdate[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_nextday( char *srcdate(i),                    |\n" );
	printf( "|                  char *destdate(o), char *mask(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask        : " );
	gets( mask );

	memset( destdate, 0, sizeof destdate );
	if( e_nextday( srcdate, destdate, mask ) < 0 )
	{
		printf( "e_nextday error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_NEXTDAY */

/*---------------------------------------------------------------------*/
void
E_NEXTMONTH()
{
	char	srcdate[80];
	char	destdate[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_nextmonth( char *srcdate(i),                  |\n" );
	printf( "|                  char *destdate(o), char *mask(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask        : " );
	gets( mask );

	memset( destdate, 0, sizeof destdate );
	if( e_nextmonth( srcdate, destdate, mask ) < 0 )
	{
		printf( "e_nextmonth error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_NEXTMONTH */

/*---------------------------------------------------------------------*/
void
E_PREVDAY()
{
	char	srcdate[80];
	char	destdate[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_prevday( char *srcdate(i),                    |\n" );
	printf( "|                  char *destdate(o), char *mask(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask        : " );
	gets( mask );

	memset( destdate, 0, sizeof destdate );
	if( e_prevday( srcdate, destdate, mask ) < 0 )
	{
		printf( "e_prevday error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_PREVDAY */

/*---------------------------------------------------------------------*/
void
E_PREVMONTH()
{
	char	srcdate[80];
	char	destdate[80];
	char	mask[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       e_prevmonth( char *srcdate(i),                  |\n" );
	printf( "|                  char *destdate(o), char *mask(i) )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " srcdate     : " );
	gets( srcdate );
	gets( srcdate );
	printf( " mask        : " );
	gets( mask );

	memset( destdate, 0, sizeof destdate );
	if( e_prevmonth( srcdate, destdate, mask ) < 0 )
	{
		printf( "e_prevmonth error ....\n" );
		return;
	}

	printf( " Result date : [%s]\n", destdate );

} /* E_PREVMONTH */

/*----------------------------------------------------------------------+
|	Display function for date maniplation				|
+----------------------------------------------------------------------*/
void
DisplayDateManF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( date maniplation )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( "  1. e_alldayget   2. e_cdate2form   3. e_chkdate\n" );
	printf( "  4. e_date2jul    5. e_datechk      6. e_datecmp\n" );
	printf( "  7. e_day2nday    8. e_dudate       9. e_fullyear\n" );
	printf( " 10. e_gdate2date 11. e_gdate2year  12. e_gdatebydu\n" );
	printf( " 13. e_getdatestr 14. e_getsysdate  15. e_gettime\n" );
	printf( " 16. e_getweekday 17. e_getyear     18. e_gmontbydu\n" );
	printf( " 19. e_gre2jul    20. e_jul2date    21. e_jul2gre\n" );
	printf( " 22. e_lstdayget  23. e_nextday     24. e_nextmonth\n" );
	printf( " 25. e_prevday    26. e_prevmonth\n" );
	printf( " 99. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayDateManF */

/*----------------------------------------------------------------------+
|	Choose function for date maniplation				|
+----------------------------------------------------------------------*/
int
ChooseDateManF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 99 && ( choosenum < 1 || choosenum > 25 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseDateManF */

/*----------------------------------------------------------------------+
|	Main function for date maniplation				|
+----------------------------------------------------------------------*/
void
DateManF()
{
	for( ; ; )
	{
		DisplayDateManF();
		switch( ChooseDateManF() )
		{
		case	 1	:	E_ALLDAYGET();	break;
		case	 2	:	E_CDATE2FORM();	break;
		case	 3	:	E_CHKDATE();	break;
		case	 4	:	E_DATE2JUL();	break;
		case	 5	:	E_DATECHK();	break;
		case	 6	:	E_DATECMP();	break;
		case	 7	:	E_DAY2NDAY();	break;
		case	 8	:	E_DUDATE();	break;
		case	 9	:	E_FULLYEAR();	break;
		case	10	:	E_GDATE2DATE();	break;
		case	11	:	E_GDATE2YEAR();	break;
		case	12	:	E_GDATEBYDU();	break;
		case	13	:	E_GETDATESTR();	break;
		case	14	:	E_GETSYSDATE();	break;
		case	15	:	E_GETTIME();	break;
		case	16	:	E_GETWEEKDAY();	break;
		case	17	:	E_GETYEAR();	break;
		case	18	:	E_GMONTBYDU();	break;
		case	19	:	E_GRE2JUL();	break;
		case	20	:	E_JUL2DATE();	break;
		case	21	:	E_JUL2GRE();	break;
		case	22	:	E_LSTDAYGET();	break;
		case	23	:	E_NEXTDAY();	break;
		case	24	:	E_NEXTMONTH();	break;
		case	25	:	E_PREVDAY();	break;
		case	26	:	E_PREVMONTH();	break;
		default		:			return;
		}
	}

} /* DateManF */

/****** End of dateman.c ***********************************************/
