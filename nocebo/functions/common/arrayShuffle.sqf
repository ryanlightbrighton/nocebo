#include "\nocebo\defines\scriptDefines.hpp"

params ["_result","_count"];
_result = [];
_count = count _this;
for "_i" from 1 to _count do {
	_result pushBack (_this deleteAt floor random count _this);
};
_result