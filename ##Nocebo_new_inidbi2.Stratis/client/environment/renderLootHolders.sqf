#include "\nocebo\defines\scriptDefines.hpp"

if sel(_this,1) then {
	{
		_x enableSimulation true;
		_x hideObject false;
		player reveal [_x,4];
	} count sel(_this,0);
} else {
	{
		_x enableSimulation false;
		_x hideObject true;
	} count sel(_this,0);
};

true