#include "\nocebo\defines\scriptDefines.hpp"

params ["_array1","_array2","_result"];

_result = [
	(sel2(_array1,0,0) * sel(_array2,0)) + (sel2(_array1,0,1) * sel(_array2,1)),
	(sel2(_array1,1,0) * sel(_array2,0)) + (sel2(_array1,1,1) * sel(_array2,1))
];

_result