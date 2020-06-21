#define diag(a,b) (diag_log format [prefix + "resetVehicleAddWeaponMainMenuDlg"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

_display = getVar(uiNamespace,"Horde_InteractionMenu");

(_display displayCtrl 6666) ctrlSetModel "\A3\Weapons_f\empty";
(_display displayCtrl 6667) ctrlSetModel "\A3\Weapons_f\empty";
(_display displayCtrl 6669) ctrlSetModel "\A3\Weapons_f\empty";
(_display displayCtrl 6670) ctrlSetModel "\A3\Weapons_f\empty";
/*(_display displayCtrl 6668) ctrlSetText "\A3\Weapons_f\empty";
(_display displayCtrl 6671) ctrlSetText "\A3\Weapons_f\empty";*/

(_display displayCtrl 1006) ctrlSetText "";
(_display displayCtrl 1007) ctrlSetText "";
(_display displayCtrl 1008) ctrlSetText "";
(_display displayCtrl 1009) ctrlSetText ""; // LOCATION_WEAPONBAG
(_display displayCtrl 1010) ctrlSetText "";
(_display displayCtrl 1011) ctrlSetText "";  // LOCATION_STANDBAG
(_display displayCtrl 1200) ctrlSetText "client\gui\images\banned.paa";
(_display displayCtrl 1201) ctrlSetText "client\gui\images\banned.paa";
(_display displayCtrl 1202) ctrlSetText "client\gui\images\banned.paa";
(_display displayCtrl 1203) ctrlSetText "client\gui\images\banned.paa";

ctrlSetFocus (_display displayCtrl 1599);