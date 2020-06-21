// template for interaction info

// note: defined outside CFgVehicles.

// note:  could do it like this:

/* class NCB_Interaction_openInventory {
	assigneditem = "";
	conditions[] = {
		{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
		{"true",""},
		{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
		{"alive player","You are dead"},
		{"isNull objectParent player","You can't be in a vehicle"},
		{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
	};
	distance = 3;
	input[] = {};
	items[] = {};
	magazines[] = {};
	output[] = {};
	script = "call horde_fnc_opOpenInventory";
	text = "Open inventory";
	tooltip = "Loot the items";
};

then in the object config, something like this:

class InteractionInfo {
	class openInventory : NCB_Interaction_openInventory {};
};

*/

// also, the object being tested was _o.bject but now is:((uiNamespace getVariable 'uiInteractionInfo') select 0)
// also, the _i.ntersectPos now is:((uiNamespace getVariable 'uiInteractionInfo') select 4)

class InteractionInfo {
	/*
		key for element 0:
		%1 = _assignedItem
		%2 = _distance
		%3 = _input
		%4 = _items
		%5 = _magazines

		key for element 1:
		%1 = display name
		%2 = name if player
	*/
	class attachAmmo {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"isNull (player getVariable ['playerHasAttachedAmmoObject',objNull])","You already have something attached to your uniform"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_attachLight";
		text = "NOT_SET";
		tooltip	= "'NOT_SET'";
	};
	class dropAmmo : attachAmmo {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"((uiNamespace getVariable 'uiInteractionInfo') select 0) isEqualTo (player getVariable ['playerHasAttachedAmmoObject',objNull])","You don't have anything attached to your uniform"}
		};
		script = "call horde_fnc_dropLight";
	};
	class swapAmmo : attachAmmo {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"not(isNull (player getVariable ['playerHasAttachedAmmoObject',objNull]))","You already have something attached to your uniform"},
			{"not(((uiNamespace getVariable 'uiInteractionInfo') select 0) isEqualTo (player getVariable ['playerHasAttachedAmmoObject',objNull]))","You need something attached in order to swap it"},
			{"isNull (attachedTo ((uiNamespace getVariable 'uiInteractionInfo') select 0))","The light can't be attached to something already"}
		};
		script = "call horde_fnc_swapLight";
	};
	class extinguishAmmo : attachAmmo {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		script = "call horde_fnc_extinguishLight";
	};
	class openInventory {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"side ((uiNamespace getVariable 'uiInteractionInfo') select 0) in [civilian,west]","You can't open this inventory"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_opOpenInventory";
		text = "Open inventory";
		tooltip = "'Loot the items'";
	};
	class dragObject {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"({alive _x} count crew ((uiNamespace getVariable 'uiInteractionInfo') select 0)) isEqualTo 0","You can't drag an occupied weapon"},
			{"not ((attachedTo ((uiNamespace getVariable 'uiInteractionInfo') select 0)) isKindOf 'AllVehicles')","You can't drag a loaded object"},
			{"not (player call horde_fnc_isUnitSwimming)","You can't drag while swimming"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_staticWeaponDrag";
		text = "NOT_SET";
		tooltip	= "'NOT_SET'";
	};
	class pushObject {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"getPosASL player select 2 > -1","You are wading too deep to push effectively"},
			{"vectorMagnitude velocity ((uiNamespace getVariable 'uiInteractionInfo') select 0) < 1","The %1 is moving too fast"},
			//{"((uiNamespace getVariable 'uiInteractionInfo') select 0) in (lineIntersectsWith [eyePos player,ATLtoASL positionCameraToWorld[0,0,4]])","The %1 is too far away"}
			{"not (player call horde_fnc_isUnitSwimming)","You can't push while swimming"},
			{"((uiNamespace getVariable 'uiInteractionInfo') select 0) in (lineIntersectsWith [eyePos player,ATLtoASL screenToWorld [0.5,0.5]])","The %1 is too far away"}
		};
		distance = 10;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_boatPush";
		text = "NOT_SET";
		tooltip	= "'NOT_SET'";
	};
	class fillJerryCan {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"'ItemJerryCanEmpty' in (items player)","You need to have an empty jerry can assigned"}
		};
		distance = 3;
		input[] = {};
		items[] = {"ItemJerryCanEmpty"};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_fillJerryCan";
		text = "Fill jerry can";
		tooltip = "'Refill empty' + endl + 'jerry can'";
	};
	class FillEmptyCanteens {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"'ItemCanteenEmpty' in (items player)","You need to have an empty canteen"}
		};
		distance = 3;
		input[] = {};
		items[] = {"ItemCanteenEmpty"};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_fillCanteens";
		text = "Refill empty canteens";
		tooltip = "'Refill empty canteens'";
	};
	class DrinkFromSource {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_drinkFromSource";
		text = "Drink water";
		tooltip = "'Drink water' + endl + 'from source'";
	};
	class openGate {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"((uiNamespace getVariable 'uiInteractionInfo') select 0) animationPhase 'Door_1_rot' < 1","The gate is closed"}
		};
		distance = 5;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_bargateOpen";
		text = "Open bargate";
		tooltip = "'Raise the bar'";
	};
	class closeGate : openGate {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"((uiNamespace getVariable 'uiInteractionInfo') select 0) animationPhase 'Door_1_rot' > 0","The gate is open"}
		};
		script = "spawn horde_fnc_bargateClose";
		text = "Close bargate";
		tooltip = "'Lower the bar'";
	};
	class Salvage {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Wreck has despawned"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 6;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {"ERROR_NO_OUTPUT"};
		script = "spawn horde_fnc_salvageWreck";
		text = "Salvage parts";
		tools[] = {"ERROR_NO_TOOLS"};
		tooltip = "'Salvage functional' + endl + 'vehicle parts'";
	};
	class cutFence {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"'ItemPliers' in (items player)","You need to have pliers assigned"}
		};
		distance = 5;
		input[] = {};
		items[] = {"ItemPliers"};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_cutFence";
		text = "Cut fence";
		tooltip = "'Cut a section' + endl + 'of fence out'";
	};
	class StartGenerator {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This generator is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"not ((((uiNamespace getVariable 'uiInteractionInfo') select 0) getVariable 'generatorRunning') select 0)","This generator is on already"},
			{"time > ((((uiNamespace getVariable 'uiInteractionInfo') select 0) getVariable 'generatorRunning') select 1) + 6","Try again in a few seconds"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_switchGeneratorOn";
		text = "Start Generator";
		tooltip = "'Start Generator'";
	};
	class StopGenerator : StartGenerator {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This generator is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"(((uiNamespace getVariable 'uiInteractionInfo') select 0) getVariable 'generatorRunning') select 0","This generator is on already"},
			{"time > ((((uiNamespace getVariable 'uiInteractionInfo') select 0) getVariable 'generatorRunning') select 1) + 2","Try again in a few seconds"}
		};
		script = "spawn horde_fnc_switchGeneratorOff";
		text = "Stop Generator";
		tooltip = "'Stop Generator'";
	};
	// assemble option will be on backpack in inventory
	class DisassembleGenerator : StartGenerator {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This generator is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"not ((((uiNamespace getVariable 'uiInteractionInfo') select 0) getVariable 'generatorRunning') select 0)","You need to switch off the generator"},
			{"time > ((((uiNamespace getVariable 'uiInteractionInfo') select 0) getVariable 'generatorRunning') select 1) + 6","Try again in a few seconds"}
		};
		output[] = {"PortableGenerator_backpack_F"};
		script = "spawn horde_fnc_disassembleGenerator"; // need to make this script
		text = "Disassemble Generator";
		tooltip = "'Disassemble Generator'";
	};
	class DisassembleParaBeacon : DisassembleGenerator {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This beacon is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		output[] = {"ParaBeacon_backpack_F"};
		script = "spawn horde_fnc_disassembleParaBeacon";
		text = "Disassemble Para Beacon";
		tooltip = "'Disassemble' + endl + 'Para Beacon'";
	};
	class logOut {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_playerLogOut";
		text = "Log out";
		tooltip	= "'Log out of server' + endl + 'Saves gear and skills'";
	};
	class shutDownServer : logOut {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"serverCommandExecutable '#lock'","You are not an admin"}
		};
		script = "call horde_fnc_adminShutDown";
		text = "Shutdown server (admin)";
		tooltip	= "'Shutdown server' + endl + 'Saves game status' + endl + 'Saves gear and skills for' + endl + 'all players still logged in'";
	};
	class confirmKills {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_playerConfirmKills";
		text = "Confirm kills";
		tooltip	= "'Confirm player' + endl + 'and AI kills'";
	};
	class PackTent {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This tent is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		modelposition[] = {0,1,1}; // what does this do???
		output[] = {"ItemTent"};
		script = "spawn horde_fnc_packTent";
		text = "Pack tent";
		tooltip	= "'Pack tent'";
	};
	class PackCamoNet {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This camo net is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {"NOT_SET"};
		script = "spawn horde_fnc_packCamoNet";
		text = "Pack camo net";
		tooltip	= "'Pack camo net'";
	};
	class chopFireWood {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This tree has been harvested"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer"}
			// {"'%1' in (items player)","You need to use a Grinder"}
			// {_x in getArray (configFile >> "CfgVehicles" >> "AllTrees" >> "CfgInteraction" >> "assignedItems")} count (items player) > 0}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {"ItemFirewood"};
		script = "spawn horde_fnc_harvest";
		text = "Chop Wood";
		tooltip	= "'Chop wood' + endl + 'from the tree'";
	};
	class collectKindling : chopFireWood {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This bush has been harvested"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		output[] = {"ItemKindling"};
		text = "Collect kindling";
		tooltip	= "'Collect kindling' + endl + 'from the bush'";
	};
	class lightFire {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This fire is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"{_x in (items player)} count %4 == count %4","You need to use some matches"}
			//{"rain >= 0.05 and {not ([] isEqualTo lineIntersectsSurfaces [getPosASL ((uiNamespace getVariable 'uiInteractionInfo') select 0),getPosASL ((uiNamespace getVariable 'uiInteractionInfo') select 0) vectorAdd [0,0,50],((uiNamespace getVariable 'uiInteractionInfo') select 0)])}","This fire is wet"}
			// {_x in getArray (configFile >> "CfgVehicles" >> "AllTrees" >> "CfgInteraction" >> "assignedItems")} count (items player) > 0}
		};
		distance = 3;
		input[] = {};
		items[] = {"ItemMatchBox"};
		magazines[] = {};
		output[] = {"ncb_obj_smallFire"};
		script = "spawn horde_fnc_lightFire";
		text = "Ignite fire";
		tooltip	= "'Light the fire' + endl + 'with some matches'";
	};
	class extinguishFire : lightFire {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This fire is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"inflamed ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This fire is not lit"}
			// {_x in getArray (configFile >> "CfgVehicles" >> "AllTrees" >> "CfgInteraction" >> "assignedItems")} count (items player) > 0}
		};
		items[] = {};
		output[] = {"ncb_obj_smallFireEmbers"};
		script = "call horde_fnc_extinguishFire";
		text = "Put out fire";
		tooltip	= "'Put out' + endl + 'the fire'";
	};
	class hideFire : extinguishFire {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This fire is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		output[] = {};
		script = "call horde_fnc_hideFire";
		text = "Hide fire";
		tooltip	= "'Hide the fire'";
	};
	class bandage {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"damage ((uiNamespace getVariable 'uiInteractionInfo') select 0) > 0","%1 is not injured"},
			{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) != 'incapacitated'","%1 needs to be revived"},
			{"'ItemBandage' in (items player)","You do not have any bandages"},
			{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"}
		};
		distance = 3;
		input[] = {};
		items[] = {"ItemBandage"};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_opBandageSetup";
		text = "Bandage";
		tooltip	= "'Bandage other' + endl + 'players wounds'";
	};
	class medigel : bandage {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"damage ((uiNamespace getVariable 'uiInteractionInfo') select 0) > 0","%1 is not injured"},
			{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) != 'incapacitated'","%1 needs to be revived"},
			{"'ItemMedigel' in (items player)","You do not have any Medigel"},
			{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"}
		};
		items[] = {"ItemMedigel"};
		script = "call horde_fnc_opMedigel";
		text = "Apply Medigel";
		tooltip	= "'Apply Medigel' + endl + 'to other player'";
	};
	class bloodBag {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"damage ((uiNamespace getVariable 'uiInteractionInfo') select 0) > 0","%1 is not injured"},
			{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) != 'incapacitated'","%1 needs to be revived"},
			{"'ItemBloodBag' in (items player)","You do not have a blood bag assigned"},
			{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"}
		};
		distance = 3;
		input[] = {};
		items[] = {"ItemBloodBag"};
		magazines[] = {};
		output[] = {};
		script = "spawn horde_fnc_opBloodBag";
		text = "Blood bag";
		tooltip	= "'Apply blood bag' + endl + 'to other player'";
	};
	class firstAid : bandage {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"damage ((uiNamespace getVariable 'uiInteractionInfo') select 0) > 0","%1 is not injured"},
			{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) != 'incapacitated'","%1 needs to be revived"},
			{"'ItemMedPack' in (items player)","You do not have a Med Pack"},
			{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"}
		};
		items[] = {"ItemMedPack"};
		script = "spawn horde_fnc_opFirstAid";
		text = "Give first aid";
		tooltip	= "'Apply Med Pack' + endl + 'to other player'";
	};
	class revive : bloodBag {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) == 'incapacitated'","%1 is not incapacitated"},
			{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"}
			//{"'ItemDefibrillator' in (items player)","You do not have a Defibrillator"}
		};
		items[] = {};
		script = "spawn horde_fnc_opRevive";
		text = "Revive";
		tooltip	= "'Revive player'";
	};
	class removeBullets : bloodBag {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"damage ((uiNamespace getVariable 'uiInteractionInfo') select 0) > 0","%1 is not injured"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"lifeState ((uiNamespace getVariable 'uiInteractionInfo') select 0) != 'incapacitated'","%1 needs to be revived"},
			{"'ItemPliers' in (items player)","You do not have any pliers assigned"},
			{"isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is not a player"}

		};
		items[] = {"ItemPliers"};
		script = "call horde_fnc_opRemoveBulletsSetup";
		text = "Remove bullets";
		tooltip	= "'Remove lodged' + endl + 'bullets from player'";
	};
	class hideBody : bloodBag {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"not alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is alive"},
			{"not isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","players cannot be hidden"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		items[] = {};
		script = "call horde_fnc_hideBody";
		text = "Hide body";
		tooltip	= "'Hide this body'";
	};
	class interrogateNearestWreck {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"not isPlayer ((uiNamespace getVariable 'uiInteractionInfo') select 0)","You can't interrogate other players"},
			{"side ((uiNamespace getVariable 'uiInteractionInfo') select 0) == civilian","%1 has not surrendered"},
			{"(animationState ((uiNamespace getVariable 'uiInteractionInfo') select 0)) == 'AmovPercMstpSsurWnonDnon'","%1 has not surrendered"},
			{"'ItemPliers' in (items player)","You need pliers to interrogate"}
		};
		distance = 3;
		input[] = {};
		items[] = {"ItemPliers"};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_interrogateNearWreck";
		text = "Interrogate (wreck)";
		tooltip	= "'Pull some teeth' + endl + 'to find out' + endl + 'where the nearest' + endl + 'chopper crash is'";
	};
	class freeHostage : interrogateNearestWreck {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is dead"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"side ((uiNamespace getVariable 'uiInteractionInfo') select 0) == civilian","%1 is not captive"},
			{"(animationState ((uiNamespace getVariable 'uiInteractionInfo') select 0)) == 'Acts_ExecutionVictim_Loop'","%1 is not captive"}
			// {"(animationState ((uiNamespace getVariable 'uiInteractionInfo') select 0)) == 'Acts_AidlPsitMstpSsurWnonDnon_loop'","%1 is not captive"}
		};
		items[] = {};
		script = "call horde_fnc_freeHostage";
		text = "Free hostage";
		tooltip	= "'Free hostage'";
	};
	class disassemble {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"({alive _x} count crew ((uiNamespace getVariable 'uiInteractionInfo') select 0)) isEqualTo 0","You can't disassemble an occupied weapon"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {"ncb_weaponbag_mortar"};
		script = "spawn horde_fnc_staticWeaponDisassemble";
		text = "NOT_SET";
		tooltip	= "'NOT_SET'";
	};
	class reloadMenu : disassemble {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 has despawned"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		magazines[] = {};
		output[] = {};
		script = "call {closeDialog 0;createDialog 'reloadMenu'}";
		text = "Open reload menu";
		tooltip	= "'Open reload menu' + endl + 'here you can add' + endl + 'and remove magazines'";
	};
	class rotateL : disassemble {
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 has despawned"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"({alive _x} count crew ((uiNamespace getVariable 'uiInteractionInfo') select 0)) isEqualTo 0","You can't rotate an occupied weapon"}
		};
		output[] = {};
		rot = -30;
		script = "spawn horde_fnc_staticWeaponRotate";
		text = "Rotate weapon left";
		tooltip	= "'Rotate weapon' + endl + 'counter-clockwise'";
	};
	class rotateR : rotateL {
		rot = 30;
		text = "Rotate weapon right";
		tooltip	= "'Rotate weapon' + endl + 'clockwise'";
	};
	class getInGunner {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
			{"isNull attachedTo ((uiNamespace getVariable 'uiInteractionInfo') select 0)","You can't get in a weapon that's being dragged"},
			{"({alive _x} count crew ((uiNamespace getVariable 'uiInteractionInfo') select 0)) isEqualTo 0","You can't get in an occupied weapon"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {};
		script = "call horde_fnc_getInGunner";
		text = "Get in";
		tooltip	= "'Get in' + endl + 'as gunner'";
	};
	class gutAnimal {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"not alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is still alive"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {"ItemMeatRaw"};
		script = "spawn horde_fnc_gutAnimal";
		text = "Gut carcass";
		tooltip	= "'Gut the carcass' + endl + 'to harvest meat'";
	};
	class raiseJollyRoger {
		assigneditem = "";
		conditions[] = {
			{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
			{"true",""},
			{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
			{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","This flag pole is destroyed"},
			{"alive player","You are dead"},
			{"isNull objectParent player","You can't be in a vehicle"},
			{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer"}
		};
		distance = 3;
		input[] = {};
		items[] = {};
		magazines[] = {};
		output[] = {""};
		script = "spawn horde_fnc_raiseJollyRoger";
		text = "Raise Jolly Roger";
		tooltip	= "'Avast ye!' + endl + 'Me hearties!'";
	};

	// rope

	// class ropePickUp {
	// 	assigneditem = "";
	// 	conditions[] = {
	// 		{"isNil {missionNamespace getVariable 'playerPerformingAction'}","You are already doing something"},
	// 		{"true",""},
	// 		{"not isNull ((uiNamespace getVariable 'uiInteractionInfo') select 0)","Null object"},
	// 		{"alive ((uiNamespace getVariable 'uiInteractionInfo') select 0)","%1 is destroyed"},
	// 		{"alive player","You are dead"},
	// 		{"isNull objectParent player","You can't be in a vehicle"},
	// 		{"ASLtoAGL eyePos player distance ((uiNamespace getVariable 'uiInteractionInfo') select 4) <= %2","You need to be closer to %1"},
	// 		{"ropes player isEqualTo []","You are already carrying a rope"}
	// 	};
	// 	distance = 3;
	// 	input[] = {};
	// 	items[] = {};
	// 	magazines[] = {};
	// 	output[] = {};
	// 	script = "call horde_fnc_ropePickUp";
	// 	text = "Pick up";
	// 	tooltip	= "Pick up rope";
	// };
};

// (this is the quads data)
class VehicleInteractionInfo {
	class Chassis {
		anim[] = {};
		location[] = {"HitBody","HitHull"};
		maxdamage = 0.89;
		modelposition[] = {0,0,0};
		parts = "ItemChassis_";
		text = "Chassis";
		textparts = "chassis parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemDrill","ItemHammer"};
		class actions {
			class addParts {
				baseTime = 30;
				failTextLocStatus = "The %1 does not need repair.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_addVehiclePart";
				text = "Add chassis parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class swapParts {
				baseTime = 50;
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap chassis parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class takeParts {
				baseTime = 30;
				failTextLocStatus = "The %1 is destroyed. You cannot take parts from it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove chassis parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class reload {
				baseTime = 0;
				failTextLocStatus = "";
				failTextHasPart = "";
				// script = "call horde_fnc_setVehicleRepairDlg";
				script = "call {}";
				text = "Open reload menu";
				type = "call {}"; // this is the onMouseEnter EH
			};
		};
	};
	class Engine {
		anim[] = {"animate",{{"dummy",0.3},{"dummy",0.6}}};
		location[] = {"HitEngine"};
		maxdamage = 0.9;
		modelposition[] = {0,0,0};
		parts = "ItemEngine_";
		text = "Engine";
		textparts = "engine parts";
		tools[] = {"ItemWrench","ItemMultiMeter","ItemPliers","ItemDrill","ItemScrewdriverPhillips","ItemScrewdriverSlotted"};
		class actions {
			class addParts {
				baseTime = 30;
				failTextLocStatus = "The %1 does not need repair.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_addVehiclePart";
				text = "Add engine parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class swapParts {
				baseTime = 50;
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap engine parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class takeParts {
				baseTime = 30;
				failTextLocStatus = "The %1 is destroyed. You cannot take parts from it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove engine parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
		};
	};
	class FuelTank {
		anim[] = {};
		location[] = {"HitFuel"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemFuelTank_";
		text = "Fuel tank";
		textparts = "fuel tank parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemPliers","ItemDrill","ItemScrewdriverPhillips","ItemScrewdriverSlotted","ItemHammer"};
		class actions {
			class addParts {
				baseTime = 60;
				failTextLocStatus = "The %1 does not need repair.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_addVehiclePart";
				text = "Add fuel tank parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class swapParts {
				baseTime = 110;
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap fuel tank parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class takeParts {
				baseTime = 60;
				failTextLocStatus = "The %1 is destroyed. You cannot take parts from it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove fuel tank parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class fillFuelTank {
				baseTime = 25;
				failTextLocStatus = "The fuel tank is full.";
				failTextHasPart = "You do not have a jerry can assigned.";
				item = "ItemJerryCan";
				script = "spawn horde_fnc_addFuelToTank";
				text = "Add fuel to tank";
				type = "call horde_fnc_setVehicleFuelDlg";
			};
			class syphonFuelTank {
				baseTime = 50;
				failTextLocStatus = "Fuel level too low.";
				failTextHasPart = "You do not have an empty jerry can assigned.";
				item = "ItemJerryCanEmpty";
				script = "spawn horde_fnc_syphonFuelFromTank";
				text = "Syphon fuel from tank";
				type = "call horde_fnc_setVehicleFuelDlg";
			};
		};
	};
	class Wheel_L1 {
		anim[] = {};
		// location = "HitLFWheel";
		location[] = {"HitLFWheel"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemTyre_";
		text = "Left front wheel";
		textparts = "a tyre";
		tools[] = {"ItemWrench"};
		class actions {
			class addTyre {
				baseTime = 15;
				failTextLocStatus = "The %1 does not need replacing.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_fitVehiclePart";
				text = "Fit wheel";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class swapParts {
				baseTime = 25;
				failTextLocStatus = "The %1 is destroyed. You cannot swap tyres with it.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap wheel";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class takeParts {
				baseTime = 15;
				failTextLocStatus = "The %1 is destroyed. You cannot take it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove wheel";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
		};
	};
	class Wheel_L2 : Wheel_L1 {
		// location = "HitLF2Wheel";
		location[] = {"HitLF2Wheel"};
		modelposition[] = {0,0,0};
		text = "Left rear wheel";
	};
	class Wheel_L3 : Wheel_L1 {
		location[] = {"HitLMWheel"};
		modelposition[] = {0,0,0};
		text = "Left rear wheel";
	};
	class Wheel_R1 : Wheel_L1 {
		location[] = {"HitRFWheel"};
		modelposition[] = {0,0,0};
		text = "Right front wheel";
	};
	class Wheel_R2 : Wheel_L1 {
		location[] = {"HitRF2Wheel"};
		modelposition[] = {0,0,0};
		text = "Right rear wheel";
	};
	class Wheel_R3 : Wheel_L1 {
		location[] = {"HitRMWheel"};
		modelposition[] = {0,0,0};
		text = "Right rear wheel";
	};
	class Track_L {
		anim[] = {};
		location[] = {"HitLTrack"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemTracks_";
		text = "Left Track";
		textparts = "track parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemHammer"};
		class actions {
			class addParts {
				baseTime = 120;
				failTextLocStatus = "The %1 does not need repair.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_addVehiclePart";
				text = "Add track parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class swapParts {
				baseTime = 230;
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap track parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class takeParts {
				baseTime = 120;
				failTextLocStatus = "The %1 is destroyed. You cannot take parts from it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove track parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
		};
	};
	class Track_R : Track_L {
		location[] = {"HitRTrack"};
		text = "Right track";
	};
	// from offroad civ
	class AddWeapon {
		anim[] = {"animate",{{"HideDoor3",0.6}}};
		bagstand[] = {
			"ncb_weaponbag_tripod" // <========================= HMM, NOT USING THIS NOW
		};
		location[] = {"AddWeapon"};
		modelposition[] = {0,-2.96777,-0.208237};
		text = "Add weapon";
		textparts = "weapon parts";
		tools[] = {"ItemGrinder","ItemDrill","ItemHammer"};
		weaponconfig[] = {
			{
				{"ncb_weaponbag_hmg_low","ncb_weaponbag_hmg_high"},
				"Add HMG",
				"ncb_veh_offroad_hmg",
				"spawn horde_fnc_addWeaponToVehicle",
				15
			};
		};
	};
	class Avionics {
		anim[] = {};
		location[] = {"HitAvionics"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemAvionics_";
		text = "Avionics";
		textparts = "avionics parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemPliers","ItemDrill","ItemScrewdriverPhillips","ItemScrewdriverSlotted","ItemHammer","ItemMultimeter"};
		class actions {
			class addParts {
				baseTime = 120;
				failTextLocStatus = "The %1 does not need repair.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_addVehiclePart";
				text = "Add avionics parts";
				type = "call horde_fnc_setVehicleRepairDlg";
			};
			class swapParts : addParts {
				baseTime = 230;
				failTextLocStatus = "The %1 are destroyed. You cannot swap parts with destroyed %1.";
				failTextHasPart = "You need some %1 to do this action.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap avionics parts";
			};
			class takeParts : addParts {
				failTextLocStatus = "The %1 are destroyed. You cannot take them.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove avionics parts";
			};
		};
	};
	class MainRotor : Avionics {
		location[] = {"HitHRotor"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemMainRotor_";
		text = "Main Rotor";
		textparts = "main rotor parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemPliers","ItemDrill","ItemScrewdriverPhillips","ItemScrewdriverSlotted","ItemHammer"};
		class actions : actions {
			class addParts : addParts {
				text = "Add main rotor parts";
			};
			class swapParts : addParts {
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap main rotor parts";
			};
			class takeParts : addParts {
				failTextLocStatus = "The %1 is destroyed. You cannot take it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove main rotor parts";
			};
		};
	};
	class TailRotor : Avionics {
		location[] = {"HitVRotor"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemTailRotor_";
		text = "Tail Rotor";
		textparts = "tail rotor parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemPliers","ItemDrill","ItemScrewdriverPhillips","ItemScrewdriverSlotted","ItemHammer"};
		class actions : actions {
			class addParts : addParts {
				text = "Add tail rotor parts";
			};
			class swapParts : addParts {
				baseTime = 25;
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap tail rotor parts";
			};
			class takeParts : addParts {
				failTextLocStatus = "The %1 is destroyed. You cannot take it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove tail rotor parts";
			};
		};
	};
	class Winch : Avionics {
		location[] = {"HitWinch"};
		maxdamage = 1;
		modelposition[] = {0,0,0};
		parts = "ItemWinch_";
		text = "Winch";
		textparts = "winch parts";
		tools[] = {"ItemGrinder","ItemWrench","ItemPliers","ItemDrill","ItemScrewdriverPhillips","ItemScrewdriverSlotted","ItemHammer"};
		class actions : actions {
			class addParts : addParts {
				text = "Add winch parts";
			};
			class swapParts : addParts {
				baseTime = 25;
				failTextLocStatus = "The %1 is destroyed. You cannot swap parts with it.";
				script = "spawn horde_fnc_swapVehiclePart";
				text = "Swap winch parts";
			};
			class takeParts : addParts {
				failTextLocStatus = "The %1 is destroyed. You cannot take it.";
				failTextHasPart = "";
				script = "spawn horde_fnc_takeVehiclePart";
				text = "Remove winch parts";
			};
		};
	};
};
