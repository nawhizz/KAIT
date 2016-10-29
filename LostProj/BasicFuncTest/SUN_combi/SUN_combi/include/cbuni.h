#ifndef	__CBUNI_H__
#define	__CBUNI_H__

#ifdef  WIN32
# include       <windows.h>
#endif

#ifndef	WIN32
# define CBD1
#else
# ifdef __CB_STATIC__
#  define CBD1	
# else
#  define CBD1	CALLBACK
# endif
#endif

#ifndef	WIN32
# if defined( __STDC__ )
#  define CBD2(s)	s
# else
#  define CBD2(s)	()
# endif
#else
# define CBD2(s)	s
#endif

#ifndef	WIN32
# ifdef	__STDC__
#  define	__CB_STDC__
# endif
#else
# define	__CB_STDC__
#endif

#endif /* __CBUNI_H__ */
