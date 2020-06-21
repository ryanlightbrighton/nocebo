#include "\nocebo\defines\scriptDefines.hpp"

ncb_gv_civilianTypes = "configName _x isKindOf 'CAManBase' and {getNumber (_x >> 'side') == 3} and {getNumber (_x >> 'scope') == 2}" configClasses (configFile >> "CfgVehicles") apply {configName _x};

diag_log "civilians enabled";

true