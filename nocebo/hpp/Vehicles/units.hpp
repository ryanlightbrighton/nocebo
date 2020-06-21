// WOODLAND CAMO GUNMEN

// Can someone clear this up for me : When viewed in arsenal, the various uniforms have a "armor" value. However, there's no armor value in any uniform's config.
// [13/03/2015 21:19:53] Markus (Wolfenswan) : What there is is some sort of inheritance to the "base soldier" of the faction the uniform belongs to (e.g. "O_soldier_F" for the hex camo uniform). Is that where it gets the "armor" from?
// [13/03/2015 21:20:15 | Edited 21:20:22] Markus (Wolfenswan) : because there are different hitpoint values for each soldier type, e.g. B_Soldier_F has 4 for hands, O_Soldier_F has 8
// [13/03/2015 21:21:28] Ghost Bear : yes
// [13/03/2015 21:21:40] Ghost Bear : you get armor values off unit
// [13/03/2015 21:23:28] Markus (Wolfenswan) : okay, does it not matter at all which uniform I wear or does that override the unit values?
// [13/03/2015 21:24:12] Markus (Wolfenswan) : and why are unit armor values all over the place? even the values between B_Soldier_F, _02_F and _03_F differ
// [13/03/2015 21:24:43 | Edited 21:25:05] Markus (Wolfenswan) : ah ignore the last, I think the other two aren't placeable
// [13/03/2015 21:24:43] Ghost Bear : check your uniform, check unit that uniform takes model off, check values there
// [13/03/2015 21:24:50] Ghost Bear : if naked, check nakeduniform
// [13/03/2015 21:25:26] Markus (Wolfenswan) : okay thanks that clears things up

// ASSAULT RIFLE

#define qty_2(a) a, a
#define qty_3(a) a, a, a
#define qty_4(a) a, a, a, a
#define qty_5(a) a, a, a, a, a
#define qty_6(a) a, a, a, a, a, a
#define qty_7(a) a, a, a, a, a, a, a
#define qty_8(a) a, a, a, a, a, a, a, a
#define qty_9(a) a, a, a, a, a, a, a, a, a
#define qty_10(a) a, a, a, a, a, a, a, a, a, a
#define qty_11(a) a, a, a, a, a, a, a, a, a, a, a
#define qty_12(a) a, a, a, a, a, a, a, a, a, a, a, a

class Man;
class CAManBase : Man {
	// extCameraPosition[] = {0.4,-0.3,-0.6}; // x,z,y// taken from here http://www.armaholic.com/page.php?id=19328
	class InteractionInfo : InteractionInfo {
		class openInventory : openInventory {
			text = "Open inventory";
			tooltip	= "'Open this' + endl + 'inventory'";
		};
		class bandage : bandage {};
		class bloodBag : bloodBag {};
		class firstAid : firstAid {};
		class revive : revive {};
		class removeBullets : removeBullets {};
		class hideBody : hideBody {};
		class interrogateNearestWreck : interrogateNearestWreck {};
		class freeHostage : freeHostage {};
		class dragPlayer : dragObject {
			text = "Drag";
			tooltip	= "'drag' + endl + 'player'";
			conditions[] = {
				{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
				{"true",""},
				{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
				{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
				{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"},
				{"alive player","You are dead"},
				{"isNull objectParent player","You can't be in a vehicle"},
				{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
				{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) == 'INCAPACITATED'","You can't drag a conscious player"},
				{"not ((attachedTo ((uiNamespace getVariable 'uiInteractionInfo') select 0)) isKindOf 'AllVehicles')","You can't drag a loaded object"},
				{"not (player call horde_fnc_isUnitSwimming)","You can't drag while swimming"}
			};
		};
	};
};

class O_UAV_AI;
class Horde_UAV_AI : O_UAV_AI {
	displayName = "UAV Brain";
	faction = "ncb_antagonists";
	class EventHandlers {
		killed = "\
		if (local (_this select 0)) then {\
			_grp = group (_this select 0);\
			[_this select 0] joinSilent (group deadUnits);\
			if (not isNull _grp and {({if (alive _x) exitWith {1}} count units _grp) isEqualTo 0}) then {\
				_grp remoteExecCall [\
					'deleteGroup',\
					groupOwner _grp\
				];\
			};\
		};";
	};
};

// east

class O_Soldier_base_F;
class Horde_Antagonist_Base : O_Soldier_base_F {
	author = "Das Attorney";
	_generalMacro = "Horde_Antagonist_Base";
	cost = 200000;
	displayName = "Base Soldier";
	faction = "ncb_antagonists";
	items[] = {};
	linkeditems[] = {"V_HarnessO_brn"};
	respawnitems[] = {};
	respawnlinkeditems[] = {"V_HarnessO_brn"};
	uniformclass = "U_O_CombatUniform_ocamo";
	class EventHandlers {
		hit = "if (local (_this select 0)) then {\
			_this call horde_fnc_unitHit;\
		}";
		killed = "if (local (_this select 0)) then {\
			_this call horde_fnc_unitKilled;\
		}";
		local = "if (_this select 1) then {\
			(_this select 0) call horde_fnc_setupDisabledAI;\
		}";
	};
};

// SNIPER

class O_Soldier_sniper_base_F;
class Horde_Antagonist_Sniper_Base : O_Soldier_sniper_base_F {
	author = "Das Attorney";
	_generalMacro = "Horde_Antagonist_Sniper_Base";
	camouflage = 0.6;
	cost = 350000;
	displayName = "Sharpshooter";
	faction = "ncb_antagonists";
	items[] = {};
	linkeditems[] = {"V_Chestrig_khk","ItemRadio"};
	namesound = "veh_infantry_sniper_s";
	respawnitems[] = {};
	respawnlinkeditems[] = {"V_Chestrig_khk","ItemRadio"};
	sensitivity = 3.3;
	textplural = "snipers";
	textsingular = "sniper";
	threat[] = {1,0.6,0.6};
	class EventHandlers {
		hit = "if (local (_this select 0)) then {\
			_this call horde_fnc_unitHit;\
		}";
		killed = "if (local (_this select 0)) then {\
			_this call horde_fnc_unitKilled;\
		}";
		local = "if (_this select 1) then {\
			(_this select 0) call horde_fnc_setupDisabledAI;\
		}";
	};
	class SpeechVariants {
		class Default {
			speechplural[] = {"veh_infantry_sniper_p"};
			speechsingular[] = {"veh_infantry_sniper_s"};
		};
	};
};

// renegades

class Horde_Renegade_Base : O_Soldier_base_F {
	armor = 1;
	author = "Das Attorney";
	_generalMacro = "Horde_Renegade_Base";
	attendant = 0;
	backpack = "";
	cost = 300000;
	displayName = "Renegade";
	engineer = 0;
	identityTypes[] = {"LanguageGRE_F", "Head_Greek", "G_GUERIL_default"};
	faceType = "Man_A3";
	faction = "ncb_renegades";
	fsmDanger = "A3\characters_f\scripts\danger.fsm";
	fsmFormation = "Formation";
	genericNames = "GreekMen";
	//hiddenSelectionsTextures[] = {};
	items[] = {};
	linkedItems[] = {};
	magazines[] = {};
	respawnItems[] = {};
	respawnLinkedItems[] = {};
	respawnMagazines[] = {};
	respawnWeapons[] = {};
	side = 1;
	uniformclass = "";
	uavHacker = 0;
	weapons[] = {};
	class EventHandlers {
		hit = "if (local (_this select 0)) then {\
			_this call horde_fnc_unitHit;\
		}";
		killed = "if (local (_this select 0)) then {\
			_this call horde_fnc_unitKilled;\
		}";
		local = "if (_this select 1) then {\
			(_this select 0) call horde_fnc_setupDisabledAI;\
		}";
	};
};

// new classes (for new universal system)

class Horde_gunmanUnit : Horde_Antagonist_Base {
	displayname = "Gunman";
	linkeditems[] = {};
	magazines[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 2;
	weapons[] = {"Throw","Put"};
};
class Horde_diverUnit : Horde_Antagonist_Base {
	displayname = "Frogman";
	linkeditems[] = {};
	magazines[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 2;
	weapons[] = {"Throw","Put"};
};
class Horde_paraUnit : Horde_Antagonist_Base {
	displayname = "Paratrooper";
	linkeditems[] = {};
	magazines[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 2;
	weapons[] = {"Throw","Put"};
};
class Horde_sniperUnit : Horde_Antagonist_Sniper_Base {
	displayname = "Sniper";
	linkeditems[] = {};
	magazines[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 2;
	weapons[] = {"Throw","Put"};
};
class Horde_renegadeUnit : Horde_Renegade_Base {
	displayname = "Renegade";
	linkeditems[] = {};
	magazines[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 2;
	weapons[] = {"Throw","Put"};
};
class Horde_dummy_unit : Horde_Antagonist_Base {
	author = "Das Attorney";
	displayname = "Dummy";
	faction = "ncb_antagonists";
	fsmdanger = "";
	items[] = {};
	linkeditems[] = {};
	magazines[] = {};
	modelsides[] = {0,1,2,3};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {};
	side = 0;
	uniformClass = "";
	weapons[] = {};
	class EventHandlers {
		init = "if (local (_this select 0)) then {\
			(_this select 0) disableAI 'all';\
			(_this select 0) hideObjectGlobal true;\
			(_this select 0) enableSimulationGlobal false\
		}";
	};
};

// PLAYERS

class B_Soldier_base_F;
class B_Soldier_F;
class ncb_player_base : B_Soldier_F {
	armor = 4;
	author = "Das Attorney";
	backpack = "";
	cost = 300000; // same as renegades
	displayname = "Gunman";
	faction = "ncb_players";
	fsmdanger = "";
	fsmFormation = "";
	items[] = {};
	linkeditems[] = {};
	magazines[] = {};
	modelsides[] = {3,2,1,0};
	nakedUniform = "U_BasicBody";
	respawnItems[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 1;
	side = 3;
	uavHacker = 1;
	weapons[] = {"Throw","Put"};
	class EventHandlers {
		class Nocebo {
			HandleScore = "if (isServer) then {_this call horde_fnc_serverHandleScore}";
		};
	};
};
class ncb_player_1 : ncb_player_base {
	displayname = "Gunman";
	scope = 2;
};

class ncb_player_2 : ncb_player_base {
	displayname = "1337 sp3c0ps $n1p3r";
	scope = 2;
};

class ncb_player_3 : ncb_player_base {
	displayname = "xx_n0$c0p3_$w4gl0rd_xx";
	scope = 2;
};

// civilian

class ncb_unit_civilian_base : B_Soldier_F {
	armor = 2;
	author = "Das Attorney";
	backpack = "";
	cost = 300000;
	displayname = "Civilian";
	faction = "ncb_civilians";
	fsmdanger = "";
	fsmFormation = "";
	items[] = {};
	linkeditems[] = {};
	magazines[] = {};
	modelsides[] = {3,2,1,0};
	nakedUniform = "U_BasicBody";
	respawnItems[] = {};
	respawnlinkeditems[] = {};
	respawnmagazines[] = {};
	respawnweapons[] = {"Throw","Put"};
	scope = 1;
	side = 3;
	uavHacker = 0;
	uniformClass = "U_C_Poloshirt_stripped";
	weapons[] = {"Throw","Put"};
};
class ncb_unit_hostage : ncb_unit_civilian_base {
	displayname = "Hostage";
	scope = 2;
	class EventHandlers {
		init = "if (local (_this select 0)) then {\
			removeUniform (_this select 0);\
			(_this select 0) forceAddUniform (selectRandom [\
				'U_C_IDAP_Man_shorts_F',\
				'U_C_IDAP_Man_casual_F',\
				'U_C_IDAP_Man_cargo_F',\
				'U_C_IDAP_Man_Tee_F',\
				'U_C_IDAP_Man_Jeans_F',\
				'U_C_IDAP_Man_TeeShorts_F'\
			]);\
			if (random 1 > 0.5) then {\
				[\
					[_this select 0],{\
						call horde_fnc_getEachFrameArgs params ['_unit'];\
						_unit addHeadgear (selectRandom [\
							'H_HeadBandage_clean_F',\
							'H_HeadBandage_stained_F',\
							'H_HeadBandage_bloody_F'\
						]);\
						call horde_fnc_removeEachFrame\
					},\
					0.1\
				] call horde_fnc_addEachFrame\
			}\
		};";
	};
};
