#include "\nocebo\defines\scriptDefines.hpp"

private _display = uiNamespace getVariable "Horde_InteractionMenu";

/*panel #1*/

(_display displayCtrl 1004) ctrlSetText "";
(_display displayCtrl 1200) ctrlSetText "";
(_display displayCtrl 1005) ctrlSetText "";

/*panel #2*/

(_display displayCtrl 1006) ctrlSetText "";
(_display displayCtrl 1201) ctrlSetText "";
(_display displayCtrl 1007) ctrlSetText "";

/*panel #3*/

(_display displayCtrl 1008) ctrlSetText "";
(_display displayCtrl 1202) ctrlSetText "";
(_display displayCtrl 1009) ctrlSetText "";

/*panel #4*/

(_display displayCtrl 1010) ctrlSetText "";
(_display displayCtrl 1203) ctrlSetText "";
(_display displayCtrl 1011) ctrlSetText "";

/*misc*/

(_display displayCtrl 1013) ctrlSetText ""; /*FUEL DISPLAY (panel #1)*/
(_display displayCtrl 1204) ctrlSetText ""; /*DESTROYED ICON (panel #1)*/

/*weapon repair/reammo buttons*/

for "_i" from 0 to 4 do {
	private _button = _display displayCtrl (1700 + _i);
	_button ctrlSetPosition [0,0,0,0];
	_button ctrlCommit 0;
};

ctrlSetFocus (_display displayCtrl 1599);
true