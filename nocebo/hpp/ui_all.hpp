class CfgActions {
	class None {
		priority = 0;
		show = 1;
		showWindow = 0;
		hideOnUse = 1;
		shortcut = "";
		text = "";
		textDefault = "";
		textSimple = "";
	};
	class HookCargo : None {
		priority = 3;
		text = "Hook";
	};
	class UnhookCargo : None {
		priority = 3;
		text = "Unhook";
	};
	class GetInCommander : None {
		text = "Get in %1 as commander";
		showWindow = 1;
		priority = 5.9;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInDriver : None {
		text = "Get in %1 as Driver";
		showWindow = 1;
		priority = 5.8;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInPilot : None {
		text = "Get in %1 as Pilot";
		showWindow = 1;
		priority = 5.6;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInGunner : None {
		text = "Get in %1 as gunner";
		showWindow = 1;
		priority = 5.7;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInCargo : None {
		text = "Get in %1 Ride in back";
		showWindow = 1;
		priority = 5.5;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		radius = 1.5;
		radiusView = 0.5;
		showIn3D = 1;
	};
	class GetInTurret : None {
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	// class GetInTurret : None {
	// 	text = "Get in %1 as %2";
	// 	showWindow = 1;
	// 	priority = 5.4;
	// 	textDefault = "<img image='nocebo\images\blank.paa' />";
	// 	radius = 1.5;
	// 	radiusView = 0.5;
	// 	showIn3D = 1;
	// };
	class PutInPilot : None {
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 9.6;
		text = "Load In Pilot";
	};
	class PutInDriver : None {
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 9.5;
		text = "Load In Driver";
	};
	class PutInCargo : None {
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 9.7;
		text = "Load In Cargo";
	};
	class Heal : None {
		text = "Treat at %1";
		showWindow = 1;
		priority = 10;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class HealSoldier : None {
		text = "Treat %1";
		priority = 10;
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class RepairVehicle : None {
		text = "Repair %1";
		priority = 9;
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class FirstAid : None {
		text = "First Aid";
		priority = 10;
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class DragSoldier : None {
		priority = 0.6;
		text = "Drag %1";
	};
	class DragSoldierInterrupt : None {
		priority = 0.6;
		text = "Drop Draged";
	};
	class CarrySoldier : None {
		priority = 0.6;
		text = "Carry %1";
	};
	class CarrySoldierInterrupt : None {
		priority = 0.6;
		text = "Drop Body";
	};
	class DropCarried : None {
		priority = 0.6;
		text = "Drop Carried";
	};
	class Repair : None {
		text = "Repair at %1";
		showWindow = 1;
		priority = 6;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Refuel : None {
		text = "Refuel at %1";
		showWindow = 1;
		priority = 2;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Rearm : None {
		text = "Rearm at %1";
		showWindow = 1;
		priority = 5.1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class GetOut : None {
		shortcut = "GetOut";
		text = "Get out";
		showWindow = 0;
		priority = 6.2;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LightOn : None {
		priority = 0.3;
		text = "Lights on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Lights on</t>";
		modelPositions = "switch_lightsldg";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		showWindow = 0;
	};
	class LightOff : LightOn {
		text = "Lights off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Lights off</t>";
	};
	class SearchLightOn : None {
		priority = 0.3;
		show = 1;
		text = "Searchlight on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class SearchLightOff : SearchLightOn {
		text = "Searchlight off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class CollisionLightOn : None {
		priority = 0.3;
		show = 1;
		text = "Collision lights on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Collision lights on</t>";
		modelPositions = "switch_lightsac";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		showWindow = 0;
	};
	class CollisionLightOff : CollisionLightOn {
		text = "Collision lights off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Collision lights off</t>";
	};
	class GunLightOn : None {
		priority = 0.1;
		show = 0;
		text = "Light on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class GunLightOff : None {
		priority = 0.1;
		show = 0;
		text = "Light off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ArtilleryComputer : None {
		priority = 0.1;
		show = 1;
		text = "Artillery computer";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class EngineOn : None {
		shortcut = "EngineToggle";
		text = "Engine on";
		showWindow = 0;
		priority = 6;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class EngineOff : None {
		shortcut = "EngineToggle";
		text = "Engine off";
		show = 1;
		showWindow = 0;
		priority = 6;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeVehicleControl : None {
		priority = 8;
		text = "Take controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class SuspendVehicleControl : None {
		priority = 7;
		text = "Release controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LockVehicleControl : None {
		priority = 7;
		text = "Lock controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UnlockVehicleControl : None {
		priority = 7;
		text = "Unlock controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class SwitchWeapon : None {
		priority = 3.1;
		shortcut = "SwitchWeapon";
		text = "Weapon %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
		showWindow = 0; // entry was not here
	};
	class SwitchMagazine : SwitchWeapon {
		shortcut = "ReloadMagazine";
	};
	class HideWeapon : SwitchWeapon {
		text = "Hide %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UseWeapon : None {
		priority = 1.2;
		text = "%1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LoadMagazine : None {
		shortcut = "ReloadMagazine";
		text = "Reload %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 2;
		show = 0;
	};
	class LoadOtherMagazine : LoadMagazine {
		show = 0;// 1;
		priority = 2;
		showWindow = 0;
	};
	class LoadEmptyMagazine : LoadMagazine {
		show = 0;// 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 2.1;
		showWindow = 0;//1;
	};
	class TakeWeapon : None {
		text = "Take %1%2";
		showWindow = 0;// 1;
		priority = 5.3;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class TakeDropWeapon : TakeWeapon {
		text = "Take %1 (drop %2)%3";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeMagazine : None {
		text = "Take %1%2";
		showWindow = 0;// 1;
		priority = 5.3;
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class TakeDropMagazine : TakeMagazine {
		text = "Take %1 (drop %2)%3";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeFlag : None {
		text = "Take Flag";
		showWindow = 1;
		priority = 7;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ReturnFlag : None {
		text = "Return Flag";
		showWindow = 1;
		priority = 8;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TurnIn : None {
		priority = 0.95;
		shortcut = "TurnIn";
		text = "Turn in";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TurnOut : None {
		priority = 0.6;
		shortcut = "TurnOut";
		text = "Turn out";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class WeaponInHand : None {
		priority = 2;
		text = "%1 in hand";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0;
	};
	class WeaponOnBack : None {
		priority = 0.3;
		text = "%1 on back";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0;
	};
	class SitDown : None {
		priority = 1;
		shortcut = "SitDown";
		show = 0;
		text = "Sit down";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Land : None {
		priority = 0.9;
		text = "Landing autopilot";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class CancelLand : None {
		priority = 0.9;
		text = "Landing autopilot off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Eject : None {
		shortcut = "Eject";
		text = "Eject";
		showWindow = 0;
		priority = 6.1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MoveToDriver : None {
		shortcut = "SwapGunner";
		text = "To Driver's seat";
		showWindow = 0;
		priority = 1.1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MoveToPilot : MoveToDriver {
		text = "To Pilot's seat";
		priority = 1.2;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MoveToGunner : None {
		shortcut = "SwapGunner";
		text = "To Gunner's seat";
		showWindow = 0;
		priority = 1.5;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MoveToCommander : None {
		shortcut = "SwapGunner";
		text = "To Commander's seat";
		showWindow = 0;
		priority = 1.4;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MoveToCargo : None {
		text = "To Passenger seat";
		showWindow = 0;
		priority = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MoveToTurret : None {
		shortcut = "SwapGunner";
		text = "To %2's seat";
		showWindow = 0;
		priority = 1.3;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class HideBody : None {
		priority = 0.51;
		text = "Hide body";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TouchOff : None {
		text = "Touch off %1 bomb(s)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		showWindow = 1;
		priority = 0.1;
	};
	class TouchOffMines : None {
		text = "Touch off %1 bomb(s)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		showWindow = 1;
		priority = 0.1;
	};
	class SetTimer : None {
		text = "Set timer +%1 sec. (%2 remaining)";
		showWindow = 1;
		priority = 2.1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class StartTimer : SetTimer {
		text = "Set timer on (%1 seconds)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Deactivate : None {
		text = "Deactivate bomb";
		showWindow = 1;
		priority = 2.1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class NVGoggles : None {
		priority = 0.511;
		text = "Put on NV goggles";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0;
	};
	class NVGogglesOff : NVGoggles {
		text = "Take off NV goggles";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0;
	};
	class ManualFire : None {
		priority = 0.59;
		shortcut = "HeliManualFire";
		text = "Manual fire";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ManualFireCancel : ManualFire {
		text = "Cancel manual fire";
		ttextDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class AutoHover : None {
		shortcut = "AutoHover";
		showWindow = 0;
		priority = 3;
		text = "Auto-hover on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class AutoHoverCancel : AutoHover {
		shortcut = "AutoHoverCancel";
		text = "Auto-hover off";
		showWindow = 0;
		priority = 3;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class StrokeFist : None {
		priority = 0.1;
		text = "Strike with fist";
		textDefault = "Strike with fist";
	};
	class StrokeGun : None {
		priority = 0.1;
		text = "Strike with weapon";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LadderUp : None {
		text = "Climb Ladder Up";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LadderDown : None {
		text = "Climb Ladder Down";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LadderOnDown : None {
		text = "Climb Ladder Down";
		showWindow = 1;
		priority = 8;
		radius = 2;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LadderOnUp : None {
		text = "Climb Ladder Up";
		showWindow = 1;
		priority = 8;
		radius = 2;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LadderOff : None {
		showWindow = 1;
		priority = 5;
		radius = 2;
		text = "Drop Down Ladder";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class FireInflame : None {
		priority = 0.99;
		showWindow = 0;// 1;
		text = "Light fire";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class FirePutDown : None {
		priority = 0.99;
		showWindow = 0;// 1;
		text = "Put out fire";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class LandGear : None {
		priority = 0.8;
		hideOnUse = 0;
		shortcut = "LandGear";
		text = "Gear down";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class LandGearUp : LandGear {
		shortcut = "LandGearUp";
		text = "Gear up";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class FlapsDown : None {
		priority = 0.7;
		hideOnUse = 0;
		shortcut = "FlapsDown";
		text = "Flaps down";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class FlapsUp : None {
		priority = 0.7;
		hideOnUse = 0;
		shortcut = "FlapsUp";
		text = "Flaps up";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Salute : None {
		priority = 1;
		shortcut = "Salute";
		show = 0;
		text = "Salute";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ScudLaunch : None {
		priority = 0.04;
		text = "Prepare Scud launch";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ScudStart : None {
		priority = 0.04;
		text = "Launch Scud";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ScudCancel : None {
		priority = 0.039;
		text = "Cancel Scud launch";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class User : None {
		priority = 1.5;
		showWindow = 1;
		text = "%1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "%3";
	};
	class DropWeapon : None {
		textDefault = "<img image='nocebo\images\blank.paa' />";
		showWindow = 1;
		priority = 2;
		text = "Drop %1";
	};
	class PutWeapon : DropWeapon {
		textDefault = "<img image='nocebo\images\blank.paa' />";
		showWindow = 1;
		priority = 5;
		text = "Put %1 to %2";
	};
	class DropMagazine : None {
		text = "Drop %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class PutMagazine : DropMagazine {
		text = "Put %1 to %2";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UserType : None {
		priority = 1.4;
		showWindow = 1;
		text = "%1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "%3";
	};
	class HandGunOn : None {
		priority = 3;
		text = "Weapon %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class HandGunOnStand : HandGunOn {
		text = "%1 in hand";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class HandGunOff : None {
		priority = 3;
		text = "Weapon %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class HandGunOffStand : HandGunOff {
		text = "%1 in hand";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class TakeMine : None {
		showWindow = 1;
		priority = 3;
		text = "Take mine";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class DeactivateMine : None {
		text = "Deactivate mine";
		showWindow = 1;
		priority = 9;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UseMagazine : None {
		priority = 3;
		text = "%1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class IngameMenu : None {
		priority = -1;
		shortcut = "MenuSelect";
		text = "Command menu";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class CancelTakeFlag : None {
		text = "Cancel action";
		showWindow = 1;
		priority = 8;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class CancelAction : None {
		shortcut = "CancelAction";
		text = "Cancel action";
		showWindow = 0;
		priority = 8;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MarkEntity : None {
		priority = 0.5199;
		showWindow = 1;
		text = "Collect from %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MarkWeapon : MarkEntity {
		text = "Collect weapon";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TeamSwitch : None {
		priority = 0.11;
		shortcut = "TeamSwitch";
		text = "Team switch";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0;
	};
	class Gear : None {
		priority = 5.1;
		showWindow = 1;
		shortcut = "Gear";
		text = "Inventory";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class GearOpen : None {
		priority = 5.1;
		showWindow = 1;
		text = "Open subordinate's inventory";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class OpenBag : None {
		priority = 5.2;
		showWindow = 1;
		text = "Open %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeBag : None {
		priority = 5.3;
		text = "Take %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		showWindow = 1;
	};
	class PutBag : None {
		priority = 5.2;
		showWindow = 0;
		text = "Drop %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class DropBag : None {
		priority = 5.2;
		showWindow = 0;
		text = "Drop %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class AddBag : None {
		priority = 5.3;
		showWindow = 0;
		text = "Take %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class IRLaserOn : None {
		priority = 0.1;
		show = 0;
		text = "Laser Enable";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class IRLaserOff : None {
		priority = 0.1;
		show = 0;
		text = "Laser Disable";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Assemble : None {
		priority = 6;
		showWindow = 0;
		text = "Assemble %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class DisAssemble : None {
		priority = 5;
		showWindow = 0;
		text = "Disassemble %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class Talk : None {
		showWindow = 1;
		priority = 9;
		text = "Talk to %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Tell : None {
		priority = 2;
		showWindow = 1;
		text = "%1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Surrender : None {
		priority = 0.11;
		shortcut = "Surrender";
		show = 0;
		text = "Surrender";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class GetOver : None {
		priority = 0.11;
		shortcut = "GetOver";
		show = 0;
		text = "Step over";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class OpenParachute : None {
		priority = 9.1;
		text = "Open parachute";
	};
	class HelicopterAutoTrimOn : None {
		text = "Auto-trim on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 3;
		show = 1;
	};
	class HelicopterAutoTrimOff : None {
		text = "Auto-trim off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 3;
		show = 1;
	};
	class HelicopterTrimOn : None {
		text = "Manual trim set";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 3;
		show = 1;
	};
	class HelicopterTrimOff : None {
		text = "Manual trim release";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		priority = 3;
		show = 1;
	};
	class WheelsBrakeOn : None {
		show = 1;
		text = "Wheel brake on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Wheel brake on</t>";
		priority = 0.6;
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 0;
		modelPositions = "switch_rotor_brake";
		showWindow = 0;
	};
	class WheelsBrakeOff : WheelsBrakeOn {
		text = "Wheel brake off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Wheel brake off</t>";
		priority = 0.3;
	};
	class PeriscopeDepthOn : None {
		text = "Maintain periscope depth";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class PeriscopeDepthOff : None {
		text = "Leave periscope depth";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UAVTerminalOpen : None {
		text = "Open UAV Terminal";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UAVTerminalMakeConnection : None {
		text = "Connect terminal to UAV";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UAVTerminalReleaseConnection : None {
		text = "Disconnect terminal from UAV";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UAVTerminalHackConnection : None {
		text = "Hack UAV";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class BackFromUAV : None {
		text = "Release UAV controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class SwitchToUAVDriver : None {
		text = "Take UAV controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class SwitchToUAVGunner : None {
		text = "Take UAV turret controls";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class Sleep : None {
		text = "Sleep";
	};
	class WakeUp : None {
		text = "WakeUp";
	};
	class UnmountItem : None {
		showWindow = 1;
		priority = 2;
		text = "Take it off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MountItem : None {
		showWindow = 1;
		priority = 2;
		text = "Put it on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class DropItem : None {
		showWindow = 1;
		priority = 2;
		text = "Drop it";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeItem : None {
		showWindow = 1;
		priority = 5.3;
		text = "Take %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UnloadMagazine : None {
		showWindow = 1;
		priority = 2;
		text = "Unload magazine";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ChangeUniformWithBody : None {
		showWindow = 0;
		priority = 2;
		text = "Change uniform from body";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class DropItemFromBody : None {
		showWindow = 0;
		priority = 4;
		text = "Drop item from body";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeItemFromBody : None {
		showWindow = 0;
		priority = 5.3;
		text = "Take item from body";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class ChangeBackpackFromBackpack : None {
		showWindow = 0;
		priority = 4;
		text = "Change backpack from backpack";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class TakeWeaponFromBody : None {
		showWindow = 0;
		priority = 5;
		text = "Take weapon from body";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		show = 0; // entry was not here
	};
	class TakeBackpackFromBody : None {
		showWindow = 0;
		priority = 5;
		text = "Take backpack from body";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UnmountUniformItem : None {
		showWindow = 0;
		priority = 2;
		text = "Take off uniform";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MountUniformItem : None {
		showWindow = 0;
		priority = 2;
		text = "Put on uniform";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class MountWeaponFromInv : None {
		showWindow = 1;
		priority = 2;
		text = "Take weapon from inventory";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class UnmountWeaponToInv : None {
		showWindow = 1;
		priority = 2;
		text = "Take weapon to inventory";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class OpenParachuteSteerable : None {
		priority = 9.1;
		text = "Open steerable parachute";
	};
	class OpenParachuteNonSteerable : None {
		priority = 9.2;
		text = "Open non-steerable parachute";
	};
	class ActivateBreathingBomb : None {
		priority = 9.3;
		text = "Activate oxygen tube";
	};
	class DeactivateBreathingBomb : None {
		priority = 9.4;
		text = "Deactivate oxygen tube";
	};
	class PatchSoldier : None {
		text = "Provide help";
		priority = 10;
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class HealSoldierSelf : None {
		text = "Treat yourself";
		priority = 10;
		showWindow = 1;
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class AIAssemble : None {
		priority = 6;
		showWindow = 0;
		text = "Assemble %1";
		textDefault = "<img image='nocebo\images\blank.paa' />";
	};
	class PutInGunner : None {
		priority = 9.5;
		text = "Load In Gunner";
	};
	class PutInCommander : None {
		priority = 9.6;
		text = "Load In Commander";
	};
	class PutInTurret : None {
		priority = 9.7;
		text = "Load In Turret";
	};
	class UnloadFromDriver : None {
		priority = 8.5;
		text = "Unload From Driver";
	};
	class UnloadFromPilot : None {
		priority = 8.6;
		text = "Unload From Pilot";
	};
	class UnloadFromCargo : None {
		priority = 8.7;
		text = "Unload From Cargo";
	};
	class UnloadFromCommander : None {
		priority = 8.5;
		text = "Unload From Commander";
	};
	class UnloadFromGunner : None {
		priority = 8.6;
		text = "Unload From Gunner";
	};
	class UnloadFromTurret : None {
		priority = 8.7;
		text = "Unload From Turret";
	};
	class HealBleedingOnly : None {
		text = "Staunch bleeding";
	};
	class HealBleedingSelfOnly : None {
		text = "Staunch your bleeding";
	};
	class HealSoldierAuto : None {
		text = "Heal soldier";
	};
	class HealBleedingAuto : None {
		text = "Staunch bleeding";
	};
	class ActivateFins : None {
		text = "Activate fins";
	};
	class DeactivateFins : None {
		text = "Deactivate fins";
	};
	class BatteriesOn : None {
		text = "Batteries on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Batteries on</t>";
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		modelPositions = "switch_batteries";
		showWindow = 1;
	};
	class BatteriesOff : BatteriesOn {
		text = "Batteries off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Batteries off</t>";
		priority = 2;
	};
	class APUOn : None {
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		modelPositions = "switch_apu";
		showWindow = 1;
		priority = 4;
		text = "APU on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>APU on</t>";
	};
	class APUOff : APUOn {
		text = "APU off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>APU off</t>";
		priority = 3;
	};
	class StarterOn1 : None {
		text = "Starter on (engine 1)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Starter on (engine 1)</t>";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_starter", "switch_starter_2"};
		showWindow = 1;
	};
	class StarterOff1 : StarterOn1 {
		text = "Starter off (engine 1)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Starter off (engine 1)</t>";
		priority = 3;
	};
	class StarterOn2 : None {
		text = "Starter on (engine 2)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Starter on (engine 2)</t>";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_starter2", "switch_starter2_2"};
		showWindow = 1;
	};
	class StarterOff2 : StarterOn2 {
		text = "Starter off (engine 2)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Starter off (engine 2)</t>";
		priority = 3;
	};
	class StarterOn3 : None {
		text = "Starter on (engine 3)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Starter on (engine 3)</t>";
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_starter3", "switch_starter3_2"};
		showWindow = 1;
	};
	class StarterOff3 : StarterOn3 {
		text = "Starter off (engine 3)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Starter off (engine 3)</t>";
		priority = 3;
	};
	class ThrottleOff1 : None {
		text = "Throttle closed (engine 1)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle closed (engine 1)</t>";
		priority = 3;
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_throttle", "switch_throttle_2"};
		showWindow = 1;
	};
	class ThrottleIdle1 : ThrottleOff1 {
		text = "Throttle idle (engine 1)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle idle (engine 1)</t>";
		priority = 3;
	};
	class ThrottleFull1 : ThrottleOff1 {
		text = "Throttle full (engine 1)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle full (engine 1)</t>";
		priority = 3;
	};
	class ThrottleOff2 : None {
		text = "Throttle closed (engine 2)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle closed (engine 2)</t>";
		priority = 3;
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_throttle2", "switch_throttle2_2"};
		showWindow = 1;
	};
	class ThrottleIdle2 : ThrottleOff2 {
		text = "Throttle idle (engine 2)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle idle (engine 2)</t>";
		priority = 3;
	};
	class ThrottleFull2 : ThrottleOff2 {
		text = "Throttle full (engine 2)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle full (engine 2)</t>";
		priority = 3;
	};
	class ThrottleOff3 : None {
		text = "Throttle closed (engine 3)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle closed (engine 3)</t>";
		priority = 3;
		radius = 3;
		radiusView = 0.08;
		showIn3D = 87;
		available = 3;
		modelPositions[] = {"switch_throttle3", "switch_throttle3_2"};
		showWindow = 1;
	};
	class ThrottleIdle3 : ThrottleOff3 {
		text = "Throttle idle (engine 3)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle idle (engine 3)</t>";
		priority = 4;
	};
	class ThrottleFull3 : ThrottleOff3 {
		text = "Throttle full (engine 3)";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Throttle full (engine 3)</t>";
		priority = 4;
	};
	class RotorBrakeOn : None {
		text = "Rotor brake on";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Rotor brake on</t>";
		priority = 0.6;
		radius = 3;
		radiusView = 0.03;
		showIn3D = 87;
		available = 3;
		modelPositions = "switch_rotor_brake";
		showWindow = 0;
	};
	class RotorBrakeOff : RotorBrakeOn {
		text = "Rotor brake off";
		textDefault = "<img image='nocebo\images\blank.paa' />";
		textToolTip = "<br /><t size='0.64'>Rotor brake off</t>";
		priority = 0.3;
	};
};