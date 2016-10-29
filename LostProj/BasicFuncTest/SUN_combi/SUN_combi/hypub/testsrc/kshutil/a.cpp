#include <iostream.h>

class testcls
{
public:
	testcls();
	void disp() { cout << itsid << endl; cout << itskey << endl; }

protected:
	int	itsid;
	char	itskey[2];
};

testcls::testcls() : itsid(-1)
{
	cout << "create" << endl;
}

main()
{
	testcls	tcls;

	tcls.disp();
	cout << __STDC__ << endl;
}
