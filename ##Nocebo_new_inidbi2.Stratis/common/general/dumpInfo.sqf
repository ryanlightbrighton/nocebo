#include "\nocebo\defines\scriptDefines.hpp"

diag_log "------------------";
diag_log format ["MIN FPS: %1",diag_fpsMin];
diag_log format ["AV FPS: %1",diag_fps];
diag_log format ["TIME: %1",time];
hintSilent "logging run data to rpt";
diag_log "ACTIVE SCRIPTS";
diag_log format ["spawned: %1",diag_activeScripts select 0];
diag_log format ["execVM: %1",diag_activeScripts select 1];
diag_log format ["exec: %1",diag_activeScripts select 2];
diag_log format ["execFSM: %1",diag_activeScripts select 3];
numb1 = 1;
diag_log "ACTIVE SQF";
{
	 diag_log format ["Number: %1 - Script: %2",numb1,_x];
	 numb1 = numb1 + 1
} forEach diag_activeSQFScripts;
numb1 = 1;
diag_log "ACTIVE FSM";
{
	 diag_log format ["Number: %1 - Script: %2",numb1,_x];
	 numb1 = numb1 + 1
} forEach diag_activeMissionFSMs;
numb1 = 1;
diag_log "ACTIVE EACHFRAME";
{
	 diag_log format ["Number: %1 - idx and args: %2",numb1,_x];
	 numb1 = numb1 + 1
} forEach (ncb_gv_eachFrameData apply {[_x select 0,_x select 1]});
diag_log "------------------";
diag_log "COUNT GROUPS";
diag_log format ["west %1",{side _x isEqualTo west} count allGroups];
diag_log format ["east %1",{side _x isEqualTo east} count allGroups];
diag_log format ["indy %1",{side _x isEqualTo resistance} count allGroups];
diag_log format ["civ %1",{side _x isEqualTo civilian} count allGroups];
diag_log format ["logic %1",{side _x isEqualTo sideLogic} count allGroups];
diag_log format ["enemy %1",{side _x isEqualTo sideEnemy} count allGroups];
diag_log "------------------";
diag_log "GROUP INFO";
{
	 diag_log "";
	 diag_log "";
	 diag_log format ["name %1",groupID _x];
	 diag_log format ["side %1",side _x];
	 diag_log format ["leader %1",leader _x];
	 diag_log format ["count units %1",count units _x];
	 diag_log format ["grpData %1",_x getVariable ["groupData","none"]];
	 diag_log format ["waypoints %1",waypoints _x];
	 diag_log "";
	 diag_log "";
} forEach allGroups;
diag_log "------------------";
diag_log "DEAD UNITS";
diag_log format ["allDead %1",count allDead];
diag_log format ["allDeadMen %1",count allDeadMen];
diag_log "------------------";
if (isServer) then {
	diag_log "UNIT POOLS";
	diag_log format ["gunmen %1",count ncb_gv_enemyUnitPool];
	diag_log format ["sniper %1",count ncb_gv_enemySniperPool];
	diag_log format ["para %1",count ncb_gv_enemyParaPool];
	diag_log format ["diver %1",count ncb_gv_enemyDiverPool];
	diag_log format ["renegades %1",count ncb_gv_renegadePool];
	diag_log "------------------";
};