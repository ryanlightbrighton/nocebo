// #define HELLO_WORLD {"an array"} // <== defines made here are available in included files.

class CfgPatches {
	class NoceboMapData {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {
			"nocebo"
		};
	};
};

class CfgZones {
	#include "hpp\altis.hpp"
	#include "hpp\stratis.hpp"
	#include "hpp\abramia.hpp"
	#include "hpp\malden.hpp"
	#include "hpp\tanoa.hpp"
	#include "hpp\chernarus.hpp"
};



