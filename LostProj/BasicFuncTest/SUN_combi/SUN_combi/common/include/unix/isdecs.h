/*------------------------------------------------------------------------
   isdecs.h

  
          +----------------------------------------------------+
          |  Worldwide Copyright (c) Byte Designs Ltd (1997)   |    
          |                                                    |
          |               20568 - 32 Avenue                    |
          |               LANGLEY, BC                          |
          |               V3A 4P5 CANADA                       |
          |                                                    |
          | Sales: sales@byted.com  Support: support@byted.com |
          | Phone: (604) 534 0722   Fax: (604) 534 2601        |
          +----------------------------------------------------+
                             Version 6.12 

 ------------------------------------------------------------------------- */
#define ACCSIZE (DECSIZE+1)

struct decacc
  { short dec_exp, dec_pos, dec_ndgts; char dec_dgts[ACCSIZE]; };

typedef struct decacc dec_a;

#include <isconfig.h>

/* PORTING change KJC 98.06.27 *************************************************
#define ISINTERNAL 1
*******************************************************************************/
#define ISINTERNAL 0
/******************************************************************************/

/* function prototypes ------------------------------------------- */

#if( ISDECLARE )
# define ISD3(s) s
#else
# define ISD3(s) ()
#endif

#if( ISDATAVOID )
# define ISDD void
#else
# define ISDD char
#endif

#if( ISDYNAMIC == 0 )
# if( ISINTERNAL )
#  define ISD1
#  define ISD2
# else
#  define ISD1 extern
#  define ISD2
# endif
#endif

#if( ISDYNAMIC == 1 || ISDYNAMIC == 3 )
# if( ISINTERNAL )
#  define ISD2 __far __pascal __export
# else
#  define ISD2 __far __pascal
# endif
# define ISD1 
#endif

#if( ISDYNAMIC == 2 || ISDYNAMIC == 4 )
# if( ISINTERNAL )
#  define ISD1 __declspec( dllexport )
# else
#  define ISD1 __declspec( dllimport )
# endif
# define ISD2
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* dec_roun.c */
ISD1 int ISD2 dec_round ISD3(( dec_a *s, int c ));

/* decadd.c */
ISD1 int ISD2 decadd ISD3(( dec_t *x, dec_t *y, dec_t *r ));

/* deccmp.c */
ISD1 int ISD2 deccmp ISD3(( dec_t *x, dec_t *y ));

/* decconv.c */
ISD1 int ISD2 deccvint ISD3(( short i, dec_t *dp ));
ISD1 int ISD2 dectoint ISD3(( dec_t *dp,  short *ip ));
ISD1 int ISD2 deccvlong ISD3(( long i, dec_t *dp ));
ISD1 int ISD2 dectolong ISD3(( dec_t *dp, long *ip ));
ISD1 int ISD2 deccvdbl ISD3(( double dbl, dec_t *dp ));
ISD1 int ISD2 dectodbl ISD3(( dec_t *dp, double *dblp ));
ISD1 int ISD2 deccvflt ISD3(( float flt, dec_t *dp ));
ISD1 int ISD2 dectoflt ISD3(( dec_t *dp,  float *fltp ));
ISD1 int ISD2 stdecimal ISD3(( dec_t *dp, unsigned char *cp, int len ));
ISD1 int ISD2 lddecimal ISD3(( unsigned char *cp, int len, dec_t *dp ));

/* deccvasc.c */
ISD1 int ISD2 deccvasc ISD3(( char *cp, int ln, dec_t *rp ));

/* decdiv.c */
ISD1 int ISD2 decdiv ISD3(( dec_t *x, dec_t *y, dec_t *r ));

/* dececvt.c */
ISD1 char * ISD2 dececvt ISD3(( dec_t *np, int dg, int *pt, int *sg ));

/* decefcvt.c */
ISD1 char * ISD2 decefcvt ISD3(( dec_t *np, int dg, int *pt, int *sg, int fl));

/* decextra.c */
ISD1 int ISD2 decchs ISD3(( dec_t *np ));
ISD1 int ISD2 decround ISD3(( dec_t *np, int prec ));
ISD1 int ISD2 dectrunc ISD3(( dec_t *np, int prec ));
ISD1 int ISD2 isdbdec ISD3(( dec_t *dec ));

/* decfcvt.c */
ISD1 char * ISD2 decfcvt ISD3(( dec_t *np, int dg, int *pt, int *sg ));

/* decmul.c */
ISD1 int ISD2 decmul ISD3(( dec_t *x, dec_t *y, dec_t *r ));
ISD1 int ISD2 mod100 ISD3(( int c, int *d ));

/* decsub.c */
ISD1 int ISD2 decsub ISD3(( dec_t *x, dec_t *y, dec_t *r ));

/* dectoasc.c */
ISD1 int ISD2 dectoasc ISD3(( dec_t *np, char *cp, int ln, int dg ));

#ifdef __cplusplus
};
#endif

#if( ISINTERNAL )
#else
# undef ISD1
# undef ISD2
# undef ISD3
# undef ISDD
#endif

/* end header ---------------------------------------------------- */

