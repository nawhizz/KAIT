/*------------------------------------------------------------------------
   disamdec.h

  
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

   This header contains information necessary for the use of the
   decimal type numbering system.

   changes: Michael Marxmeier

   config:
   #define NO_DECIMAL_MACROS
   #define NO_DECIMAL_PROTOTYPES
   #define DECSIZE (default is 16)
------------------------------------------------------------------------*/
   

#ifndef DECIMAL_H
#define DECIMAL_H

/*------------------------------------------------------------------------
      defines
------------------------------------------------------------------------*/

#ifndef DECSIZE
# define DECSIZE 16
#endif

#define DECUNKNOWN (-2)
#define DECPOSNULL (-1)        /* if dec_pos == DECPOSNULL then value is 
                                  TRUE NULL (less than anything) */

#define DEC_BAD_EXPONENT   -1216    /* bad intermediate exponent value */
#define DEC_NON_NUMERIC    -1213    /* bad digit */
#define DEC_DIVIDE_BY_ZERO -1202    /* division by zero */
#define DEC_UNDERFLOW      -1201    /* exponent underflow */
#define DEC_OVERFLOW       -1200    /* exponent overflow */


/*------------------------------------------------------------------------
      structures
------------------------------------------------------------------------*/

struct decimal                 /* the structure on an UNPACKED decimal */
      { short dec_exp;         /* the exponent */
        short dec_pos;         /* is the value "positive", flag */
        short dec_ndgts;       /* the number of valid digits in dec_dgts */
        char  dec_dgts[DECSIZE];       /* the digits, base 100 */
      };
typedef struct decimal dec_t;


/*------------------------------------------------------------------------
      macros, pseudo functions
------------------------------------------------------------------------*/

#ifndef NO_DECIMAL_MACROS

/* declen, sig = # of significant digits, rd # digits to right of decimal,
           returns # bytes required to hold such */
#define DECLEN( sig,rd )  (( (sig) + ( (rd)&1 ) + 3 ) / 2 )
#define DECLENGTH( len )  DECLEN( PRECTOT( len ), PRECDEC( len ))
#define DECPREC( size )   ( ( ( size - 1 ) << 9 ) + 2 )
#define PRECTOT( len )    ( ( ( len ) >> 8 ) & 0xff )
#define PRECDEC( len )    ( ( len ) & 0xff )
#define PRECMAKE( len,dlen )  ( ( (len) << 8 ) + (dlen) )

/*
** value of an integer that generates a decimal flagged DECPOSNULL
**     an int of 2 bytes produces 0x8000
**     an int of 4 bytes produces 0x80000000
*/

#define VAL_DECPOSNULL(type)    (1L << ( (sizeof (type) * 8 ) - 1) )

#endif

#endif


