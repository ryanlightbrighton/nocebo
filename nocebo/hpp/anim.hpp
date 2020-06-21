

// #define precisionVal 0.35
class CfgMovesBasic {
	class Default {
		// aimPrecision = precisionVal;
	};
	class StandBase;
};
class CfgMovesMaleSdr : CfgMovesBasic {
	class States {
		// fixing things

		class InBaseMoves_assemblingVehicleErc;
		class Horde_anim_fixVehicleStand : InBaseMoves_assemblingVehicleErc {
			headBobMode = 4;
			headBobStrength = -1;
			ignoreMinPlayTime[] = {"Unconscious","Horde_anim_fixVehicleStand"};
			InterpolateFrom[] = {
				"Horde_anim_fixVehicleStand",0.01,

				"AovrPercMstpSrasWpstDf",0.1,

				"AadjPercMstpSrasWrflDdown",0.1,
				"AadjPercMstpSrasWrflDleft",0.1,
				"AadjPercMstpSrasWrflDright",0.1,
				"AadjPercMstpSrasWrflDup",0.1,
				"AadjPercMstpSrasWpstDdown",0.1,
				"AadjPercMstpSrasWpstDleft",0.1,
				"AadjPercMstpSrasWpstDright",0.1,
				"AadjPercMstpSrasWpstDup",0.1,
				"AadjPknlMstpSrasWrflDdown",0.1,
				"AadjPknlMstpSrasWrflDleft",0.1,
				"AadjPknlMstpSrasWrflDright",0.1,
				"AadjPknlMstpSrasWrflDup",0.1,
				"AadjPknlMstpSrasWpstDdown",0.1,
				"AadjPknlMstpSrasWpstDleft",0.1,
				"AadjPknlMstpSrasWpstDright",0.1,
				"AadjPknlMstpSrasWpstDup",0.1,
				"AadjPpneMstpSrasWrflDdown",0.1,
				"AadjPpneMstpSrasWrflDleft",0.1,
				"AadjPpneMstpSrasWrflDright",0.1,
				"AadjPpneMstpSrasWrflDup",0.1,
				"AadjPpneMstpSrasWpstDdown",0.1,
				"AadjPpneMstpSrasWpstDleft",0.1,
				"AadjPpneMstpSrasWpstDright",0.1,
				"AadjPpneMstpSrasWpstDup",0.1,

				"AmovPercMstpSrasWlnrDnon",0.1,
				"AmovPercMstpSrasWrflDnon",0.1,
				"AmovPercMstpSrasWpstDnon",0.1,
				"AmovPercMstpSnonWnonDnon",0.1,
				"AmovPknlMstpSrasWlnrDnon",0.1,
				"AmovPknlMstpSrasWrflDnon",0.1,
				"AmovPknlMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSnonWnonDnon",0.1,
				"AmovPpneMstpSrasWrflDnon",0.1,
				"AmovPpneMstpSrasWpstDnon",0.1,
				"AmovPpneMstpSnonWnonDnon",0.1,

				"AmovPercMstpSlowWlnrDnon",0.1,
				"AmovPercMstpSlowWrflDnon",0.1,
				"AmovPercMstpSlowWpstDnon",0.1,
				"AmovPknlMstpSlowWrflDnon",0.1,
				"AmovPknlMstpSlowWpstDnon",0.1,

				"AinvPercMstpSrasWlnrDnon",0.1,
				"AinvPercMstpSrasWrflDnon",0.1,
				"AinvPercMstpSrasWpstDnon",0.1,
				"AinvPknlMstpSrasWlnrDnon",0.1,
				"AinvPknlMstpSrasWrflDnon",0.1,
				"AinvPknlMstpSrasWpstDnon",0.1,
				"AinvPpneMstpSrasWrflDnon",0.1,
				"AinvPpneMstpSrasWpstDnon",0.1,

				"AmovPercMstpSoptWbinDnon",0.1,
				"AmovPknlMstpSoptWbinDnon",0.1,
				"AmovPpneMstpSoptWbinDnon",0.1
			};
			InterpolateTo[] = {
				"Unconscious", 0.01,
				"Horde_anim_fixVehicleStand", 0.01,
				"AinvPercMstpSrasWlnrDnon",0.1,
				"AinvPercMstpSrasWrflDnon",0.1,
				"AinvPercMstpSrasWpstDnon",0.1,
				"AinvPknlMstpSrasWlnrDnon",0.1,
				"AinvPknlMstpSrasWrflDnon",0.1,
				"AinvPknlMstpSrasWpstDnon",0.1,
				"AinvPpneMstpSrasWrflDnon",0.1,
				"AinvPpneMstpSrasWpstDnon",0.1,
				"AmovPercMstpSrasWlnrDnon", 0.1,
				"AmovPercMstpSrasWrflDnon", 0.1,
				"AmovPercMstpSrasWpstDnon", 0.1,
				"AmovPercMstpSnonWnonDnon", 0.1
			};
		};
		class InBaseMoves_repairVehicleKnl;
		class Horde_anim_fixVehicleKneel : InBaseMoves_repairVehicleKnl {
			headBobMode = 4;
			headBobStrength = -1;
			ignoreMinPlayTime[] = {"Unconscious","Horde_anim_fixVehicleKneel"};
			InterpolateFrom[] = {
				"Horde_anim_fixVehicleKneel",0.01,

				"AovrPercMstpSrasWpstDf",0.1,

				"AadjPercMstpSrasWrflDdown",0.1,
				"AadjPercMstpSrasWrflDleft",0.1,
				"AadjPercMstpSrasWrflDright",0.1,
				"AadjPercMstpSrasWrflDup",0.1,
				"AadjPercMstpSrasWpstDdown",0.1,
				"AadjPercMstpSrasWpstDleft",0.1,
				"AadjPercMstpSrasWpstDright",0.1,
				"AadjPercMstpSrasWpstDup",0.1,
				"AadjPknlMstpSrasWrflDdown",0.1,
				"AadjPknlMstpSrasWrflDleft",0.1,
				"AadjPknlMstpSrasWrflDright",0.1,
				"AadjPknlMstpSrasWrflDup",0.1,
				"AadjPknlMstpSrasWpstDdown",0.1,
				"AadjPknlMstpSrasWpstDleft",0.1,
				"AadjPknlMstpSrasWpstDright",0.1,
				"AadjPknlMstpSrasWpstDup",0.1,
				"AadjPpneMstpSrasWrflDdown",0.1,
				"AadjPpneMstpSrasWrflDleft",0.1,
				"AadjPpneMstpSrasWrflDright",0.1,
				"AadjPpneMstpSrasWrflDup",0.1,
				"AadjPpneMstpSrasWpstDdown",0.1,
				"AadjPpneMstpSrasWpstDleft",0.1,
				"AadjPpneMstpSrasWpstDright",0.1,
				"AadjPpneMstpSrasWpstDup",0.1,

				"AmovPercMstpSrasWlnrDnon",0.1,
				"AmovPercMstpSrasWrflDnon",0.1,
				"AmovPercMstpSrasWpstDnon",0.1,
				"AmovPercMstpSnonWnonDnon",0.1,
				"AmovPknlMstpSrasWlnrDnon",0.1,
				"AmovPknlMstpSrasWrflDnon",0.1,
				"AmovPknlMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSnonWnonDnon",0.1,
				"AmovPpneMstpSrasWrflDnon",0.1,
				"AmovPpneMstpSrasWpstDnon",0.1,
				"AmovPpneMstpSnonWnonDnon",0.1,

				"AmovPercMstpSlowWlnrDnon",0.1,
				"AmovPercMstpSlowWrflDnon",0.1,
				"AmovPercMstpSlowWpstDnon",0.1,
				"AmovPknlMstpSlowWrflDnon",0.1,
				"AmovPknlMstpSlowWpstDnon",0.1,

				"AinvPercMstpSrasWlnrDnon",0.1,
				"AinvPercMstpSrasWrflDnon",0.1,
				"AinvPercMstpSrasWpstDnon",0.1,
				"AinvPknlMstpSrasWlnrDnon",0.1,
				"AinvPknlMstpSrasWrflDnon",0.1,
				"AinvPknlMstpSrasWpstDnon",0.1,
				"AinvPpneMstpSrasWrflDnon",0.1,
				"AinvPpneMstpSrasWpstDnon",0.1,

				"AmovPercMstpSoptWbinDnon",0.1,
				"AmovPknlMstpSoptWbinDnon",0.1,
				"AmovPpneMstpSoptWbinDnon",0.1
			};
			InterpolateTo[] = {
				"Unconscious", 0.01,
				"Horde_anim_fixVehicleKneel",0.01,
				"AinvPercMstpSrasWlnrDnon",0.1,
				"AinvPercMstpSrasWrflDnon",0.1,
				"AinvPercMstpSrasWpstDnon",0.1,
				"AinvPknlMstpSrasWlnrDnon",0.1,
				"AinvPknlMstpSrasWrflDnon",0.1,
				"AinvPknlMstpSrasWpstDnon",0.1,
				"AinvPpneMstpSrasWrflDnon",0.1,
				"AinvPpneMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSrasWlnrDnon",0.1,
				"AmovPknlMstpSrasWrflDnon",0.1,
				"AmovPknlMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSnonWnonDnon",0.1
			};
		};
		class InBaseMoves_repairVehiclePne;
		class Horde_anim_fixVehicleProne : InBaseMoves_repairVehiclePne {
			headBobMode = 4;
			headBobStrength = -1;
			ignoreMinPlayTime[] = {"Unconscious","Horde_anim_fixVehicleProne"};
			InterpolateFrom[] = {
				"Horde_anim_fixVehicleProne",0.01,

				"AovrPercMstpSrasWpstDf",0.1,

				"AadjPercMstpSrasWrflDdown",0.1,
				"AadjPercMstpSrasWrflDleft",0.1,
				"AadjPercMstpSrasWrflDright",0.1,
				"AadjPercMstpSrasWrflDup",0.1,
				"AadjPercMstpSrasWpstDdown",0.1,
				"AadjPercMstpSrasWpstDleft",0.1,
				"AadjPercMstpSrasWpstDright",0.1,
				"AadjPercMstpSrasWpstDup",0.1,
				"AadjPknlMstpSrasWrflDdown",0.1,
				"AadjPknlMstpSrasWrflDleft",0.1,
				"AadjPknlMstpSrasWrflDright",0.1,
				"AadjPknlMstpSrasWrflDup",0.1,
				"AadjPknlMstpSrasWpstDdown",0.1,
				"AadjPknlMstpSrasWpstDleft",0.1,
				"AadjPknlMstpSrasWpstDright",0.1,
				"AadjPknlMstpSrasWpstDup",0.1,
				"AadjPpneMstpSrasWrflDdown",0.1,
				"AadjPpneMstpSrasWrflDleft",0.1,
				"AadjPpneMstpSrasWrflDright",0.1,
				"AadjPpneMstpSrasWrflDup",0.1,
				"AadjPpneMstpSrasWpstDdown",0.1,
				"AadjPpneMstpSrasWpstDleft",0.1,
				"AadjPpneMstpSrasWpstDright",0.1,
				"AadjPpneMstpSrasWpstDup",0.1,

				"AmovPercMstpSrasWlnrDnon",0.1,
				"AmovPercMstpSrasWrflDnon",0.1,
				"AmovPercMstpSrasWpstDnon",0.1,
				"AmovPercMstpSnonWnonDnon",0.1,
				"AmovPknlMstpSrasWlnrDnon",0.1,
				"AmovPknlMstpSrasWrflDnon",0.1,
				"AmovPknlMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSnonWnonDnon",0.1,
				"AmovPpneMstpSrasWrflDnon",0.1,
				"AmovPpneMstpSrasWpstDnon",0.1,
				"AmovPpneMstpSnonWnonDnon",0.1,

				"AmovPercMstpSlowWlnrDnon",0.1,
				"AmovPercMstpSlowWrflDnon",0.1,
				"AmovPercMstpSlowWpstDnon",0.1,
				"AmovPknlMstpSlowWrflDnon",0.1,
				"AmovPknlMstpSlowWpstDnon",0.1,

				"AinvPercMstpSrasWlnrDnon",0.1,
				"AinvPercMstpSrasWrflDnon",0.1,
				"AinvPercMstpSrasWpstDnon",0.1,
				"AinvPknlMstpSrasWlnrDnon",0.1,
				"AinvPknlMstpSrasWrflDnon",0.1,
				"AinvPknlMstpSrasWpstDnon",0.1,
				"AinvPpneMstpSrasWrflDnon",0.1,
				"AinvPpneMstpSrasWpstDnon",0.1,

				"AmovPercMstpSoptWbinDnon",0.1,
				"AmovPknlMstpSoptWbinDnon",0.1,
				"AmovPpneMstpSoptWbinDnon",0.1
			};
			InterpolateTo[] = {
				"Unconscious",0.01,
				"Horde_anim_fixVehicleProne",0.01,
				"AinvPercMstpSrasWlnrDnon",0.1,
				"AinvPercMstpSrasWrflDnon",0.1,
				"AinvPercMstpSrasWpstDnon",0.1,
				"AinvPknlMstpSrasWlnrDnon",0.1,
				"AinvPknlMstpSrasWrflDnon",0.1,
				"AinvPknlMstpSrasWpstDnon",0.1,
				"AinvPpneMstpSrasWrflDnon",0.1,
				"AinvPpneMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSrasWlnrDnon",0.1,
				"AmovPknlMstpSrasWrflDnon",0.1,
				"AmovPknlMstpSrasWpstDnon",0.1,
				"AmovPknlMstpSnonWnonDnon",0.1,
				"AmovPpneMstpSrasWrflDnon",0.1,
				"AmovPpneMstpSrasWpstDnon",0.1,
				"AmovPpneMstpSnonWnonDnon",0.1
			};
		};
		class Acts_listeningToRadio_In;
		class Horde_anim_radioCheckIn : Acts_listeningToRadio_In {
			InterpolateFrom[] = {
				"AmovPercMrunSlowWrflDb",0.1,
				"AmovPercMrunSlowWrflDbl",0.1,
				"AmovPercMrunSlowWrflDbr",0.1,
				"AmovPercMrunSlowWrflDf",0.1,
				"AmovPercMrunSlowWrflDfl",0.1,
				"AmovPercMrunSlowWrflDfr",0.1,
				"AmovPercMrunSlowWrflDr",0.1,
				"AmovPercMrunSlowWrflDr",0.1,

				"AmovPercMrunSrasWrflDb",0.1,
				"AmovPercMrunSrasWrflDbl",0.1,
				"AmovPercMrunSrasWrflDbr",0.1,
				"AmovPercMrunSrasWrflDf",0.1,
				"AmovPercMrunSrasWrflDfl",0.1,
				"AmovPercMrunSrasWrflDfr",0.1,
				"AmovPercMrunSrasWrflDr",0.1,
				"AmovPercMrunSrasWrflDr",0.1,

				"AmovPercMtacSlowWrflDb",0.1,
				"AmovPercMtacSlowWrflDbl",0.1,
				"AmovPercMtacSlowWrflDbr",0.1,
				"AmovPercMtacSlowWrflDf",0.1,
				"AmovPercMtacSlowWrflDfl",0.1,
				"AmovPercMtacSlowWrflDfr",0.1,
				"AmovPercMtacSlowWrflDr",0.1,
				"AmovPercMtacSlowWrflDr",0.1,

				"AmovPercMtacSrasWrflDb",0.1,
				"AmovPercMtacSrasWrflDbl",0.1,
				"AmovPercMtacSrasWrflDbr",0.1,
				"AmovPercMtacSrasWrflDf",0.1,
				"AmovPercMtacSrasWrflDfl",0.1,
				"AmovPercMtacSrasWrflDfr",0.1,
				"AmovPercMtacSrasWrflDr",0.1,
				"AmovPercMtacSrasWrflDr",0.1
			};
			InterpolateTo[] = {
				"AmovPercMstpSnonWnonDnon_turnL",0.02,
				"AmovPercMstpSnonWnonDnon_turnR",0.02,
				"AovrPercMstpSnonWnonDf",0.05,
				"AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic",0.05,
				"AmovPercMrunSnonWnonDf",0.02,
				"AmovPercMwlkSnonWnonDf",0.02,
				"AmovPercMwlkSnonWnonDfl",0.02,
				"AmovPercMwlkSnonWnonDl",0.02,
				"AmovPercMwlkSnonWnonDbl",0.02,
				"AmovPercMwlkSnonWnonDb",0.02,
				"AmovPercMwlkSnonWnonDbr",0.02,
				"AmovPercMwlkSnonWnonDr",0.02,
				"AmovPercMwlkSnonWnonDfr",0.02,
				"AmovPercMrunSnonWnonDfl",0.02,
				"AmovPercMrunSnonWnonDl",0.02,
				"AmovPercMrunSnonWnonDbl",0.02,
				"AmovPercMrunSnonWnonDb",0.02,
				"AmovPercMrunSnonWnonDbr",0.02,
				"AmovPercMrunSnonWnonDr",0.02,
				"AmovPercMrunSnonWnonDfr",0.02,
				"AmovPercMevaSnonWnonDf",0.02,
				"AmovPercMevaSnonWnonDfl",0.02,
				"AmovPercMevaSnonWnonDfr",0.02,
				"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon",0.02,
				"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown",0.02,
				"Unconscious",0.01,
				"AmovPercMstpSnonWnonDnon_AcinPknlMwlkSnonWnonDb_1",0.1,
				"Helper_SwitchToCarrynon",0.2,
				"AswmPercMstpSnonWnonDnon",0.3,
				"AsswPercMstpSnonWnonDnon",0.3,
				"AbswPercMstpSnonWnonDnon",0.3,
				"HaloFreeFall_non",10.2,
				"AmovPercMstpSnonWnonDnon_falling",0.02,
				"AsdvPercMstpSnonWnonDnon",2.02,
				"AdvePercMstpSnonWnonDnon",2,
				"AbdvPercMstpSnonWnonDnon",2,
				"AfalPercMstpSnonWnonDnon",0.025,
				"HubSpectator_standU",1,
				"HubSpectator_walkU",1,
				"AswmPercMrunSnonWnonDf",0.05,
				"AsswPercMrunSnonWnonDf",0.05,
				"AbswPercMrunSnonWnonDf",0.05,

				"Horde_anim_radioCheckOut",0.1,

				"AmovPercMrunSlowWrflDb",0.1,
				"AmovPercMrunSlowWrflDbl",0.1,
				"AmovPercMrunSlowWrflDbr",0.1,
				"AmovPercMrunSlowWrflDf",0.1,
				"AmovPercMrunSlowWrflDfl",0.1,
				"AmovPercMrunSlowWrflDfr",0.1,
				"AmovPercMrunSlowWrflDr",0.1,
				"AmovPercMrunSlowWrflDr",0.1,

				"AmovPercMrunSrasWrflDb",0.1,
				"AmovPercMrunSrasWrflDbl",0.1,
				"AmovPercMrunSrasWrflDbr",0.1,
				"AmovPercMrunSrasWrflDf",0.1,
				"AmovPercMrunSrasWrflDfl",0.1,
				"AmovPercMrunSrasWrflDfr",0.1,
				"AmovPercMrunSrasWrflDr",0.1,
				"AmovPercMrunSrasWrflDr",0.1,

				"AmovPercMtacSlowWrflDb",0.1,
				"AmovPercMtacSlowWrflDbl",0.1,
				"AmovPercMtacSlowWrflDbr",0.1,
				"AmovPercMtacSlowWrflDf",0.1,
				"AmovPercMtacSlowWrflDfl",0.1,
				"AmovPercMtacSlowWrflDfr",0.1,
				"AmovPercMtacSlowWrflDr",0.1,
				"AmovPercMtacSlowWrflDr",0.1,

				"AmovPercMtacSrasWrflDb",0.1,
				"AmovPercMtacSrasWrflDbl",0.1,
				"AmovPercMtacSrasWrflDbr",0.1,
				"AmovPercMtacSrasWrflDf",0.1,
				"AmovPercMtacSrasWrflDfl",0.1,
				"AmovPercMtacSrasWrflDfr",0.1,
				"AmovPercMtacSrasWrflDr",0.1,
				"AmovPercMtacSrasWrflDr",0.1
			};
		};
		class Acts_listeningToRadio_Out;
		class Horde_anim_radioCheckOut : Acts_listeningToRadio_Out {
			InterpolateFrom[] = {
				"Horde_anim_radioCheckIn",0.1
			};
			InterpolateTo[] = {
				"AmovPercMstpSnonWnonDnon_turnL",0.02,
				"AmovPercMstpSnonWnonDnon_turnR",0.02,
				"AovrPercMstpSnonWnonDf",0.05,
				"AinvPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_medic",0.05,
				"AmovPercMrunSnonWnonDf",0.02,
				"AmovPercMwlkSnonWnonDf",0.02,
				"AmovPercMwlkSnonWnonDfl",0.02,
				"AmovPercMwlkSnonWnonDl",0.02,
				"AmovPercMwlkSnonWnonDbl",0.02,
				"AmovPercMwlkSnonWnonDb",0.02,
				"AmovPercMwlkSnonWnonDbr",0.02,
				"AmovPercMwlkSnonWnonDr",0.02,
				"AmovPercMwlkSnonWnonDfr",0.02,
				"AmovPercMrunSnonWnonDfl",0.02,
				"AmovPercMrunSnonWnonDl",0.02,
				"AmovPercMrunSnonWnonDbl",0.02,
				"AmovPercMrunSnonWnonDb",0.02,
				"AmovPercMrunSnonWnonDbr",0.02,
				"AmovPercMrunSnonWnonDr",0.02,
				"AmovPercMrunSnonWnonDfr",0.02,
				"AmovPercMevaSnonWnonDf",0.02,
				"AmovPercMevaSnonWnonDfl",0.02,
				"AmovPercMevaSnonWnonDfr",0.02,
				"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon",0.02,
				"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown",0.02,
				"Unconscious",0.01,
				"AmovPercMstpSnonWnonDnon_AcinPknlMwlkSnonWnonDb_1",0.1,
				"Helper_SwitchToCarrynon",0.2,
				"AswmPercMstpSnonWnonDnon",0.3,
				"AsswPercMstpSnonWnonDnon",0.3,
				"AbswPercMstpSnonWnonDnon",0.3,
				"HaloFreeFall_non",10.2,
				"AmovPercMstpSnonWnonDnon_falling",0.02,
				"AsdvPercMstpSnonWnonDnon",2.02,
				"AdvePercMstpSnonWnonDnon",2,
				"AbdvPercMstpSnonWnonDnon",2,
				"AfalPercMstpSnonWnonDnon",0.025,
				"HubSpectator_standU",1,
				"HubSpectator_walkU",1,
				"AswmPercMrunSnonWnonDf",0.05,
				"AsswPercMrunSnonWnonDf",0.05,
				"AbswPercMrunSnonWnonDf",0.05,

				"AmovPercMrunSlowWrflDb",0.1,
				"AmovPercMrunSlowWrflDbl",0.1,
				"AmovPercMrunSlowWrflDbr",0.1,
				"AmovPercMrunSlowWrflDf",0.1,
				"AmovPercMrunSlowWrflDfl",0.1,
				"AmovPercMrunSlowWrflDfr",0.1,
				"AmovPercMrunSlowWrflDr",0.1,
				"AmovPercMrunSlowWrflDr",0.1,

				"AmovPercMrunSrasWrflDb",0.1,
				"AmovPercMrunSrasWrflDbl",0.1,
				"AmovPercMrunSrasWrflDbr",0.1,
				"AmovPercMrunSrasWrflDf",0.1,
				"AmovPercMrunSrasWrflDfl",0.1,
				"AmovPercMrunSrasWrflDfr",0.1,
				"AmovPercMrunSrasWrflDr",0.1,
				"AmovPercMrunSrasWrflDr",0.1,

				"AmovPercMtacSlowWrflDb",0.1,
				"AmovPercMtacSlowWrflDbl",0.1,
				"AmovPercMtacSlowWrflDbr",0.1,
				"AmovPercMtacSlowWrflDf",0.1,
				"AmovPercMtacSlowWrflDfl",0.1,
				"AmovPercMtacSlowWrflDfr",0.1,
				"AmovPercMtacSlowWrflDr",0.1,
				"AmovPercMtacSlowWrflDr",0.1,

				"AmovPercMtacSrasWrflDb",0.1,
				"AmovPercMtacSrasWrflDbl",0.1,
				"AmovPercMtacSrasWrflDbr",0.1,
				"AmovPercMtacSrasWrflDf",0.1,
				"AmovPercMtacSrasWrflDfl",0.1,
				"AmovPercMtacSrasWrflDfr",0.1,
				"AmovPercMtacSrasWrflDr",0.1,
				"AmovPercMtacSrasWrflDr",0.1
			};
		};
	};
};

/*class CfgMovesFatigue;
class CfgMovesFatigueLevel2 : CfgMovesFatigue {
	coolDown = 7.5;
	maxRun = 0.95;
	maxSprint = 0.7;
};
class CfgMovesFatigueLevel3 : CfgMovesFatigue {
	coolDown = 5;
	maxRun = 1;
	maxSprint = 0.8;
};*/