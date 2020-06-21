#include "\nocebo\defines\scriptDefines.hpp"
#define wp(a) (waypoints a)

for "_i" from count wp(_this) - 1 to 0 step -1 do {
	deleteWaypoint (wp(_this) select _i)
};

_this