#define diag(a,b) (diag_log format [prefix + "playerMonitorMapTents"" - " + a + ": %1",b])
#include "\nocebo\defines\scriptDefines.hpp"

// http://forums.bistudio.com/showthread.php?186650-How-to-hide-respawn-tent-markers

#define horde_dispMap (findDisplay 12)
#define horde_dispCU (findDisplay 1664)
#define horde_ctrlMap (findDisplay 12 displayCtrl 51)
#define horde_ctrlBack (findDisplay 12 displayCtrl 59500)
#define horde_ctrlRend (findDisplay 12 displayCtrl 59502)
#define horde_ctrlText (findDisplay 12 displayCtrl 59501)
/*#define horde_ctrlBack (findDisplay 1664 displayCtrl 59500)
#define horde_ctrlRend (findDisplay 1664 displayCtrl 59502)
#define horde_ctrlText (findDisplay 1664 displayCtrl 59501)*/
#define horde_cam (uiNamespace getVariable "horde_rttCam")

// partially working rtt.  Only captures image if you exit map screen hovering mouse over a tent....
// also needs some camera code in client.sqf

private ["_count","_groupTents","_ctrlArr","_skillLevel","_idc","_onTent","_mkr","_tent","_ret","_text","_mkrName","_pos","_coords","_tents","_markers"];

with uiNamespace do {
	waitUntil {
		waitUntil {
			visibleMap
		};
		// ctrlActivate ((findDisplay 12) displayCtrl 107);
		_count = 0;
		_groupTents = [[],[]];
		_ctrlArr = [];
		_skillLevel = sel(getVar(missionNamespace,"logistics"),0);
		_idc = 4000;

		waitUntil {
			// NOTE: ADD NEW TENTS
			/*{*/
				{
					if (not isNull _x and {alive _x}) then {
						if (not (_x in sel(_groupTents,0))) then {
							sel(_groupTents,0) pushBack _x;
							sel(_groupTents,1) pushBack str _x;
							_mkr = createMarkerLocal [str _x,position _x];
							_mkr setMarkerSizeLocal [1, 1];
							_mkr setMarkerTypeLocal "respawn_inf";
							_mkr setMarkerColorLocal "ColorBlack";
							_mkr setMarkerAlphaLocal 1;
						};
					} else {
						deleteMarkerLocal str _x;
					};
					true
				} count getVarDef(group player,"groupOwnedTents",[]);
				/*true
			} count units group player;*/


			// NOTE: SET ROTATION AND TEXT
			{
				_tent = _x;
				_mkr = sel2(_groupTents,1,_forEachIndex);
				if (not isNull _tent and {alive _tent}) then {
					_mkr setMarkerDirLocal _count;
				} else {
					deleteMarkerLocal _mkr;
					sel(_groupTents,0) set [_forEachIndex,objNull];
					sel(_groupTents,1) set [_forEachIndex,objNull];
				};
			} forEach sel(_groupTents,0);

			_tents = sel(_groupTents,0) - [objNull];
			_markers = sel(_groupTents,1) - [objNull];

			_groupTents = [_tents,_markers];

			// for reference, here is how to do a static screen:
			// cutrsc ["RscNoise","black"];

			// set camera

			_ret = ctrlMapMouseOver horde_ctrlMap;
			/*player sideChat format["mouseover %1",_ret];*/
			_text = "";
			_onTent = false;
			if (not empty(_ret)) then {
				if (sel(_ret,0) == "marker") then {
					_mkrName = sel(_ret,1);
					_index = sel(_groupTents,1) find _mkrName;
					if (_index > -1) then {
						_onTent = true;
						_tent = sel2(_groupTents,0,_index);
						if (isNull horde_ctrlBack) then {
							/*player sideChat format["No control so creating at %1",time];*/
							_pos = _tent modelToWorld [-8,8,8];
							horde_cam camPrepareFov 0.7;
							horde_cam camSetPos _pos;
							horde_cam camPrepareTarget _tent;
							horde_cam camCommitPrepared 0;
							horde_cam camCommit 0;
							[horde_cam,_tent] spawn horde_fnc_rotateTentCam;
							horde_dispMap ctrlCreate ["RscPicture",59500];
							horde_dispMap ctrlCreate ["horde_RscPicture",59502];
							horde_dispMap ctrlCreate ["horde_RscStructuredText",59501];

							/*createDialog "Horde_CoverUp";*/

							/*horde_dispMap createDisplay "RscObserver";*/
							/*horde_dispMap createMissionDisplay "";*/
							horde_dispMap createDisplay "horde_RscRender2"; //why???

							/*horde_dispMap createDisplay "CoverUp";
							ctrlSetText [59500,"#(argb,8,8,3)color(0,0,0,0.4)"];
							ctrlSetText [59502,"#(argb,256,256,1)r2t(rendertarget7,1.0)"];*/

							horde_ctrlBack ctrlSetText "#(argb,8,8,3)color(0,0,0,0.4)";
							horde_ctrlRend ctrlSetText "#(argb,256,256,1)r2t(rendertarget7,1.0)";
							horde_cam cameraEffect ["INTERNAL","BACK","rendertarget7"];
							"rendertarget7" setPiPEffect [0];
							horde_ctrlRend ctrlCommit 0;
							horde_ctrlText ctrlSetBackgroundColor [0,0,0,0.8];
						};
						_coords = horde_ctrlMap ctrlMapWorldToScreen markerPos _mkrName;
						horde_ctrlBack ctrlSetPosition [
							sel(_coords,0),
							sel(_coords,1),
							0.182292 * safezoneW,
							0.574 * safezoneH
						];
						horde_ctrlRend ctrlSetPosition [
							((sel(_coords,0) / (safezoneW + safezoneX)) + 0.009) * (safezoneW + safezoneX),
							((sel(_coords,1) / (safezoneW + safezoneX)) + 0.014) * (safezoneW + safezoneX),
							0.167708 * safezoneW,
							0.266 * safezoneH
						];
						horde_ctrlText ctrlSetPosition [
							((sel(_coords,0) / (safezoneW + safezoneX)) + 0.009) * (safezoneW + safezoneX),
							((sel(_coords,1) / (safezoneW + safezoneX)) + 0.31) * (safezoneW + safezoneX),
							0.167708 * safezoneW,
							0.266 * safezoneH
						];

						/*call {
							if (_skillLevel >= 5) exitWith {
							};
							if (_skillLevel >= 4) exitWith {
							};
							if (_skillLevel >= 3) exitWith {
							};
							if (_skillLevel >= 2) exitWith {
							};
						};*/
						_text = format ["<t size='3'color='#FFFFFF'align='center'shadow='2'><br/><br/>GRID: %1<br/>ITEMS: %2<br/>MAGS: %3<br/>WEAPS: %4</t>",
							mapGridPosition _tent,
							count itemCargo _tent,
							count magazineCargo _tent,
							count weaponCargo _tent
						];
						horde_ctrlText ctrlSetStructuredText parseText _text;
						horde_ctrlBack ctrlCommit 0;
						horde_ctrlRend ctrlCommit 0;
						horde_ctrlText ctrlCommit 0;
						waitUntil {
							ctrlCommitted horde_ctrlBack
							and {ctrlCommitted horde_ctrlRend}
							and {ctrlCommitted horde_ctrlText}
						};
					};
				};
			};
			if (not _onTent) then {
				if (not isNull horde_ctrlBack) then {
					// diag("========================== TIME DESTROYING CONTROLS ==========================",time);
					ctrlDelete horde_ctrlBack;
					ctrlDelete horde_ctrlRend;
					ctrlDelete horde_ctrlText;
					/*closeDialog 1664;*/
					// horde_dispMap closeDisplay 1;
					// camDestroy horde_cam;
				};
			};

			sleep 0.001;
			/*sleep 1;*/
			_count = (_count + 5) % 360;
			_count = _count call horde_fnc_normalDir;
			not visibleMap
		};
		false
	};
};
true