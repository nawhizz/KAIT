/* e_dates2du()	:  LIB gps */
/*----------------------------------------------------------------------------*//* FUNC :calculate duration between given two dates                           */
/*----------------------------------------------------------------------------*//*

	input	: char *date1	1st date
                  char *date2   2nd date
                  int   form    masked form number
                                1. : YYMMDD     (ex>'990909')	'1930 ~ 2029'
                                2. : YY.MM.DD   (ex>'99.09.09')	'1930 ~ 2029'
                                3. : YYYYMMDD   (ex>"19990909')	'0001 ~ ????'
                                4. : YYYY.MM.DD (ex>'1999.09.09)'0001 ~ ????'
        output	: int *dura(absolute value) 
	return	: 0/-1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_dates2du( char *date1, int form, char *date2, int *dura )
#else
e_dates2du( date1, form, date2, dura )
char *date1 ;
int form ;
char *date2 ;
int *dura ;
#endif
{
	
        int year[2], month[2], date[2], total[2], ptr ;
	int i, j ;

	static int maxdate[12]={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

	

        year[0] = d_ndec2int( date1, (form/3)*2+2 ) ;
	year[1] = d_ndec2int( date2, (form/3)*2+2 ) ;
	month[0] = d_ndec2int( &date1[form+1], 2) ;
	month[1] = d_ndec2int( &date2[form+1], 2) ;
	ptr = form%2 == 1 ? form + 3 : form + 4 ;
	date[0] = d_ndec2int( &date1[ptr], 2 ) ;
	date[1] = d_ndec2int( &date2[ptr], 2 ) ;
	
        
        for( i = 0 ; i < 2 ; i++ )
	{
		if(form==1||form==2)
		{
			if((year[i] >= 30 && year[i] <= 99))
				year[i] += 1900 ; 
			else
				year[i] += 2000 ;
		}

                if( year[i] <0 || month[i] < 1 || month[i] > 12
                               || date[i] < 1 || date[i] > 31 )
			return( -1 ) ;

		if(month[i] >= 3 )
		{
			total[i] = (year[i]-1)*365 + (year[i])/4
				- (year[i])/100 + (year[i])/400 ;
		}
		else
		{
			total[i] = (year[i]-1)*365 + (year[i]-1)/4
				- (year[i]-1)/100 + (year[i]-1)/400 ;
		}

		for( j = 0 ; j < month[i] - 1 ; j ++ )
			total[i] += maxdate[j] ;

		total[i] += date[i] ;
	}

	if ( total[0] > total[1])
		*dura = total[0] - total[1] ;
	else
		*dura = total[1] - total[0] ;

	return( 0 );
}
