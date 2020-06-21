class CfgCloudlets {
	class Default;
	class Horde_Flies : Default {
		angle = 0;
		angleVar = 10;
		animationSpeed[] = {1.5,0.5};
		animationSpeedCoef = 1;
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		color[] = {{1,1,1,1},{1,1,1,1}};
		colorCoef[] = {1,1,1,1};
		colorVar[] = {0,0,0,0.1};
		interval = 0.3;
		lifeTime = 4;
		lifeTimeVar = 2;
		moveVelocity[] = {0,0,0.5};
		MoveVelocityVarConst[] = {0,0,0};
		particleFSLoop = 0;
		particleShape = "\A3\animals_f\fly.p3d";
		particleType = "spaceObject";
		positionVar[] = {1,1,0.5};
		positionVarConst[] = {0,0,0};
		randomDirectionIntensity = 0.08;
		randomDirectionIntensityVar = 0.03;
		randomDirectionPeriod = 0.01;
		randomDirectionPeriodVar = 0.01;
		rotationVelocityVar = 1;
		rubbing = 0;
		size[] = {1.2, 1.2, 1.2, 0};
		sizeCoef = 1;
		sizeVar = 0.2;
		weight = 1.25; //1.3;

// _pos = _this select 0;
// _interval = if (count _this > 1) then {_this select 1} else {-1};
// _size = if (count _this > 2) then {_this select 2} else {-1};

// if (_interval <= 0) then {_interval = 0.1;};
// if (_size <= 0) then {_size = 1;};

		// // FIXED PARAMS
		// _source = "#particlesource" createVehicleLocal _pos;
		// _source setParticleParams [
		// Sprite		["\A3\animals_f\fly.p3d", 1, 0, 1, 0], "", // File, Ntieth, Index, Count, Loop(Bool)
		// Type 		"spaceObject",
		// TimerPer 		1,
		// Lifetime 		4,
		// Position		[0, 0, 0],
		// MoveVelocity	[0, 0, 0.5],
		// Simulation		0, 1.30, 1, 0, //rotationVel, weight, volume, rubbing
		// Scale		[1.2, 1.2, 1.2, 0],
		// Color		[[1, 1, 1, 1],[1, 1, 1, 1]],
		// AnimSpeed		[1.5,0.5],
		// randDirPeriod	0.01,
		// randDirIntesity	0.08,
		// onTimerScript 	"",
		// DestroyScript 	"",
		// Follow 		""
		// ];

		// // RANDOM / TOLERANCE PARAMS
		// _source setParticleRandom [
		// LifeTime 		2,
		// Position		[_size, _size, 0.5],
		// MoveVelocity	[0, 0, 0],
		// rotationVel 	1,
		// Scale		0.2,
		// Color		[0, 0, 0, 0.1],
		// randDirPeriod	0.01,
		// randDirIntesity	0.03,
		// Angle 		10
	};
	class ImpactSparks1;
	class Horde_ImpactSparks1 : ImpactSparks1 {
		moveVelocity[] = {0,0,-1};
	};
	class ImpactSparksSabot1;
	class Horde_ImpactSparksSabot1 : ImpactSparksSabot1 {
		// color[] = {{0.53,0.08,0.94,-50}};
		// colorCoef[] = {1,1,1,1};
		// colorVar[] = {0.05,0.05,0.05,5};
		moveVelocity[] = {0,0,-3};
	};
	class ImpactSparksSabot1Small;
	class Horde_ImpactSparksSabot1Small : ImpactSparksSabot1Small {
		// color[] = {{0.53,0.08,0.94,-50}};
		// colorCoef[] = {1,1,1,1};
		// colorVar[] = {0.05,0.05,0.05,5};
		moveVelocity[] = {0,0,-3};
	};
	class ExhaustSmokeBigRefract;
	class Horde_AirConditioningHaze : ExhaustSmokeBigRefract {
		// interval = "(0.05 - 0.049 * 1)"; // intensity
		interval = 0.1; // intensity
		moveVelocity[] = {0,1,0};
		position[] = {0,0,0};
	};
	class collisionVeh2;
	class Horde_vehiclePartDestroyed_1 : collisionVeh2 {
		// interval = "(0.05 - 0.049 * 1)"; // intensity
		interval = 0.03; // intensity interval = "0.2/(0.001 + forceSize/1000)";
		moveVelocity[] = {0,0,4};
		MoveVelocityVar[] = {5,5,4};
		position[] = {0,0,0};
	};
	class collisionVeh3;
	class Horde_vehiclePartDestroyed_2 : collisionVeh3 {
		interval = 0.06; // intensity interval = "0.2/(0.001 + forceSize/1000)";
		moveVelocity[] = {0,0,3};
		MoveVelocityVar[] = {3,3,3};
		position[] = {0,0,0};
	};
	class ObjectDestructionShards;
	class Horde_vehiclePartDestroyed_3 : ObjectDestructionShards {
		// interval = "(0.05 - 0.049 * 1)"; // intensity
		interval = 0.08; // intensity interval = "0.2/(0.001 + forceSize/1000)";
		lifeTime = 5;
		lifeTimeVar = 2;
		moveVelocity[] = {0,0,1};
		MoveVelocityVar[] = {1,1,1};
		position[] = {0,0,0};
		rubbing = 0;
	};
	class ExhaustSmokeTank1;
	class Horde_EngineSmokeCloudlet : ExhaustSmokeTank1 {
			color[] = {{0.01,0.01,0.01,0.14},{0.2,0.2,0.2,0.15},{0.2,0.2,0.2,0.015},{0.2,0.2,0.2,0.011}};
		colorCoef[] = {0,0,0,1}; // {1,1,1,1};
		interval = 0.06;
		lifeTime = 4;
		moveVelocity[] = {0,0,2};
		position[] = {0,0,0};
			size[] = {0.5,0.9,1.2,1.4,1.5,1.65};
			sizeCoef = 1.2;
			sizeVar = 0.1;
			volume = 1.2;
	};
	class Horde_EngineSmokeCloudlet2 : Horde_EngineSmokeCloudlet {
		interval = 0.04;
	};
	class Horde_EngineSmokeCloudlet3 : Horde_EngineSmokeCloudlet {
		interval = 0.02;
	};
	class GrenadeExp;
	class ncb_grenadeExp : GrenadeExp {
        size[] = {"0.0125 * 3 + 4", "0.0125 * 3 + 1"};
    };
    class GrenadeSmoke1;
	class ncb_grenadeSmoke1 : GrenadeSmoke1 {
		interval = "0.008 * 5 + 0.008";
        size[] = {"0.0125 * 5 + 4", "0.0125 * 5 + 1"};
    };
	class Refract;
	class Test_SuppressionFX : Refract {
		lifeTime = 10;
		moveVelocity[] = {"outDirX * 100","outDirY * 100","0"};
		moveVelocityVar[] = {0.05,0.05,0.05};
		weight = 1;
	};
	class SmallFireF;
	class ncb_small_fire : SmallFireF {
		damageType="";                       //damage type, only available option is "Fire" so far
		coreIntensity = 0;                    //damage coeficient in the center of fire
		coreDistance = 0;                      //how far can unit get damage
		damageTime = 100;
	};

	class Horde_AmmoEHCloudlet : Default {
		/*angle = 10;
		angleVar = 0;
		animationName = "";
		animationSpeed[] = {1};
		animationSpeedCoef = 1;
		beforeDestroyScript = "";
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		color[] = {{1,1,1,1}};
		colorCoef[] = {1,1,1,1};
		colorVar[] = {0,0,0,0};
		interval = 0.5;
		lifeTime = 1;
		lifeTimeVar = 0;
		moveVelocity[] = {0,0,0};
		MoveVelocityVar[] = {0,0,0};
		MoveVelocityVarConst[] = {0,0,0};*/
		timerPeriod = 1;
		size[] = {5, 10, 18, 24, 27, 30, 32, 33};
		color[] = {{1, 1, 1, 1}, {1, 1, 1, 0}};
		onTimerScript = "\nocebo\scripts\explosion.sqf";
		/*particleFSFrameCount = 1;
		particleFSIndex = 0;
		particleFSLoop = 1;
		particleFSNtieth = 1;
		particleShape = "\A3\Data_f\cl_basic.p3d";
		particleType = "Billboard";
		position[] = {0,0,0};
		positionVar[] = {0,0,0};
		positionVarConst[] = {0,0,0};
		randomDirectionIntensity = 0;
		randomDirectionIntensityVar = 0;
		randomDirectionPeriod = 0;
		randomDirectionPeriodVar = 0;
		rotationVelocity = 0;
		rotationVelocityVar = 0;
		rubbing = 0.05;
		size[] = {1,1};
		sizeCoef = 1;
		sizeVar = 0;
		timerPeriod = 1;
		volume = 1;
		weight = 1;*/
	};

	// class CraterSmoke : Default {
	// 	onTimerScript = "\nocebo\scripts\explosion.sqf";
	// };
};

/* class dummy : Inherit {
	angle = 10;
	angleVar = 0;
	animationName = "";
	animationSpeed[] = {1};
	animationSpeedCoef = 1;
	beforeDestroyScript = "";
	circleRadius = 0;
	circleVelocity[] = {0,0,0};
	color[] = {[1,1,1,1]};
	colorCoef[] = {1,1,1,1};
	colorVar[] = {0,0,0,0};
	interval = 0.5;
	lifeTime = 1;
	lifeTimeVar = 0;
	moveVelocity[] = {0,0,0};
	MoveVelocityVar[] = {0,0,0};
	MoveVelocityVarConst[] = {0,0,0};
	onTimerScript = "";
	particleFSFrameCount = 1;
	particleFSIndex = 0;
	particleFSLoop = 1;
	particleFSNtieth = 1;
	particleShape = "\A3\Data_f\cl_basic.p3d";
	particleType = "Billboard";
	position[] = {0,0,0};
	positionVar[] = {0,0,0};
	positionVarConst[] = {0,0,0};
	randomDirectionIntensity = 0;
	randomDirectionIntensityVar = 0;
	randomDirectionPeriod = 0;
	randomDirectionPeriodVar = 0;
	rotationVelocity = 0;
	rotationVelocityVar = 0;
	rubbing = 0.05;
	size[] = {1,1};
	sizeCoef = 1;
	sizeVar = 0;
	timerPeriod = 1;
	volume = 1;
	weight = 1;
}; */

