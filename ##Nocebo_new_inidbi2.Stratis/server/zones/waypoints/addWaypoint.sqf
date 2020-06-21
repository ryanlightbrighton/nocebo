#include "\nocebo\defines\scriptDefines.hpp"

private _wp = sel(_this,0) addWaypoint [sel(_this,1), 0];
_wp setWaypointBehaviour sel(_this,2);
_wp setWaypointCombatMode sel(_this,3);
_wp setWaypointCompletionRadius sel(_this,4);
_wp setWaypointFormation sel(_this,5);
_wp setWaypointSpeed sel(_this,6);
_wp setWaypointStatements sel(_this,7);
_wp setWaypointTimeout sel(_this,8);
_wp setWaypointType sel(_this,9);

_wp