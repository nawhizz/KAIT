#include <stdio.h>

main()
{
	char	str[9];

	memcpy(	str, "<35<?-7^]", 8 );
/*
	str[0] = (str[0]+15)-4;
	str[1] = str[1] + 3;
	str[2] = str[2] + 5;
	str[3] = str[3] + 7;
	str[4] = (str[4]+10)-3;
	str[5] = (str[5]+6)-10;
	str[6] = (str[6]+3)-5;
	str[7] = (str[7]+8)-11;
*/
	str[0] = (str[0]+4)-15;
	str[1] = str[1] - 3;
	str[2] = str[2] - 5;
	str[3] = str[3] - 7;
	str[4] = (str[4]-10)+3;
	str[5] = (str[5]-6)+10;
	str[6] = (str[6]-3)+5;
	str[7] = (str[7]-8)+11;
	str[8] = 0;
	printf( "str=%s\n", str );
}
