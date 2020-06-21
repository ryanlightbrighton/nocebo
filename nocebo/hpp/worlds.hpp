class CfgWorlds {
	class CAWorld;
	class Altis : CAWorld {
		class AmbientA3 {
			maxCost = 500;
			class Radius440_500 {
				areaSpawnRadius = 70;
				areaMaxRadius = 200;
				spawnCircleRadius = 30;
				spawnInterval = 4.7;
				class Species {
					class Kestrel_random_F {
						maxCircleCount = "((1 - night) * 2 * (1 - (WaterDepth interpolate [1,30,0,1])) + (2 * (hills))) * (1 - night) * (1-rain)";
						maxWorldCount = 5;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					class Seagull {
						maxCircleCount = "((sea * (1 - night)) + (2 * houses * sea)) * (1 - night)";
						maxWorldCount = 40;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					// class Rabbit_F {
					// 	maxCircleCount = "(20 * (0.1 - houses)) * (1 - sea) * (1-rain)";
					// 	maxWorldCount = 5;
					// 	cost = 5;
					// 	spawnCount = 1;
					// 	groupSpawnRadius = 10;
					// 	maxAlt = 80;
					// 	minAlt = -5;
					// };
				};
			};
			class Radius40_60 {
				areaSpawnRadius = 50;
				areaMaxRadius = 83;
				spawnCircleRadius = 10;
				spawnInterval = 1.5;
				class Species {
					class CatShark_F {
						maxCircleCount = "(4 * (WaterDepth interpolate [1,30,0,1]))";
						maxWorldCount = 10;
						cost = 6;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					class Turtle_F {
						maxCircleCount = "(2 * (waterDepth interpolate [1,16,0,1]) * ((1-houses) * (1-houses)))";
						maxWorldCount = 6;
						cost = 5;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					// class Snake_random_F {
					// 	maxCircleCount = "(1 - houses) * ((2 * (1 - sea)) + (2 * (meadow)))";
					// 	maxWorldCount = 3;
					// 	cost = 5;
					// 	spawnCount = 1;
					// 	groupSpawnRadius = 5;
					// 	maxAlt = 40;
					// 	minAlt = -5;
					// };
					class Salema_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 40;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Ornate_random_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.05))";
						maxWorldCount = 30;
						cost = 5;
						spawnCount = 3;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mackerel_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mullet_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Tuna_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) - 0.2))";
						maxWorldCount = 10;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
				};
			};
			class Radius30_40 {
				areaSpawnRadius = 30;
				areaMaxRadius = 40;
				spawnCircleRadius = 3;
				spawnInterval = 3.75;
				class Species {
					class DragonFly {
						maxCircleCount = "4 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * sea * (1 - windy) * (1-rain)";
						maxWorldCount = 4;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class ButterFly_random {
						maxCircleCount = "3 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FireFly {
						maxCircleCount = "(6 * night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 20;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
					class Cicada {
						maxCircleCount = "(4 * night) * (1 - sea) * (1 - windy) * (1-rain)";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius15_20 {
				areaSpawnRadius = 15;
				areaMaxRadius = 20;
				spawnCircleRadius = 2;
				spawnInterval = 2.85;
				class Species {
					class FxWindGrass1 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindGrass2 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf1 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf2 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf3 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPollen1 {
						maxCircleCount = "(3 * (1 - (WaterDepth interpolate [1,30,0,1]))) * (windy interpolate [0.05,0.15,0,1])";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPaper1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPlastic1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius6_10 {
				areaSpawnRadius = 6;
				areaMaxRadius = 10;
				spawnCircleRadius = 1;
				spawnInterval = 0.1;
				class Species {
					class HoneyBee {
						maxCircleCount = "4 * (1 - night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 8;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class HouseFly {
						maxCircleCount = "(3 + 3 * (houses)) * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 10;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class Mosquito {
						maxCircleCount = "3 * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
		};
	};
	class Malden : CAWorld {
		class AmbientA3 {
			maxCost = 500;
			class Radius440_500 {
				areaSpawnRadius = 70;
				areaMaxRadius = 200;
				spawnCircleRadius = 30;
				spawnInterval = 4.7;
				class Species {
					class Kestrel_random_F {
						maxCircleCount = "((1 - night) * 2 * (1 - (WaterDepth interpolate [1,30,0,1])) + (2 * (hills))) * (1 - night) * (1-rain)";
						maxWorldCount = 5;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					class Seagull {
						maxCircleCount = "((sea * (1 - night)) + (2 * houses * sea)) * (1 - night)";
						maxWorldCount = 40;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					// class Rabbit_F {
					// 	maxCircleCount = "(20 * (0.1 - houses)) * (1 - sea) * (1-rain)";
					// 	maxWorldCount = 5;
					// 	cost = 5;
					// 	spawnCount = 1;
					// 	groupSpawnRadius = 10;
					// 	maxAlt = 80;
					// 	minAlt = -5;
					// };
				};
			};
			class Radius40_60 {
				areaSpawnRadius = 50;
				areaMaxRadius = 83;
				spawnCircleRadius = 10;
				spawnInterval = 1.5;
				class Species {
					class CatShark_F {
						maxCircleCount = "(4 * (WaterDepth interpolate [1,30,0,1]))";
						maxWorldCount = 10;
						cost = 6;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					class Turtle_F {
						maxCircleCount = "(2 * (waterDepth interpolate [1,16,0,1]) * ((1-houses) * (1-houses)))";
						maxWorldCount = 6;
						cost = 5;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					// class Snake_random_F {
					// 	maxCircleCount = "(1 - houses) * ((2 * (1 - sea)) + (2 * (meadow)))";
					// 	maxWorldCount = 3;
					// 	cost = 5;
					// 	spawnCount = 1;
					// 	groupSpawnRadius = 5;
					// 	maxAlt = 40;
					// 	minAlt = -5;
					// };
					class Salema_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 40;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Ornate_random_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.05))";
						maxWorldCount = 30;
						cost = 5;
						spawnCount = 3;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mackerel_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mullet_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Tuna_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) - 0.2))";
						maxWorldCount = 10;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
				};
			};
			class Radius30_40 {
				areaSpawnRadius = 30;
				areaMaxRadius = 40;
				spawnCircleRadius = 3;
				spawnInterval = 3.75;
				class Species {
					class DragonFly {
						maxCircleCount = "4 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * sea * (1 - windy) * (1-rain)";
						maxWorldCount = 4;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class ButterFly_random {
						maxCircleCount = "3 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FireFly {
						maxCircleCount = "(6 * night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 20;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
					class Cicada {
						maxCircleCount = "(4 * night) * (1 - sea) * (1 - windy) * (1-rain)";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius15_20 {
				areaSpawnRadius = 15;
				areaMaxRadius = 20;
				spawnCircleRadius = 2;
				spawnInterval = 2.85;
				class Species {
					class FxWindGrass1 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindGrass2 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf1 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf2 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf3 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPollen1 {
						maxCircleCount = "(3 * (1 - (WaterDepth interpolate [1,30,0,1]))) * (windy interpolate [0.05,0.15,0,1])";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPaper1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPlastic1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius6_10 {
				areaSpawnRadius = 6;
				areaMaxRadius = 10;
				spawnCircleRadius = 1;
				spawnInterval = 0.1;
				class Species {
					class HoneyBee {
						maxCircleCount = "4 * (1 - night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 8;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class HouseFly {
						maxCircleCount = "(3 + 3 * (houses)) * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 10;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class Mosquito {
						maxCircleCount = "3 * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
		};
	};
	class Stratis : CAWorld {
		class AmbientA3 {
			maxCost = 500;
			class Radius440_500 {
				areaSpawnRadius = 70;
				areaMaxRadius = 200;
				spawnCircleRadius = 30;
				spawnInterval = 4.7;
				class Species {
					class Kestrel_random_F {
						maxCircleCount = "((1 - night) * 2 * (1 - (WaterDepth interpolate [1,30,0,1])) + (2 * (hills))) * (1 - night) * (1-rain)";
						maxWorldCount = 5;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					class Seagull {
						maxCircleCount = "((sea * (1 - night)) + (2 * houses * sea)) * (1 - night)";
						maxWorldCount = 40;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					// class Rabbit_F {
					// 	maxCircleCount = "(20 * (0.1 - houses)) * (1 - sea) * (1-rain)";
					// 	maxWorldCount = 5;
					// 	cost = 5;
					// 	spawnCount = 1;
					// 	groupSpawnRadius = 10;
					// 	maxAlt = 80;
					// 	minAlt = -5;
					// };
				};
			};
			class Radius40_60 {
				areaSpawnRadius = 50;
				areaMaxRadius = 83;
				spawnCircleRadius = 10;
				spawnInterval = 1.5;
				class Species {
					class CatShark_F {
						maxCircleCount = "(4 * (WaterDepth interpolate [1,30,0,1]))";
						maxWorldCount = 10;
						cost = 6;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					class Turtle_F {
						maxCircleCount = "(2 * (waterDepth interpolate [1,16,0,1]) * ((1-houses) * (1-houses)))";
						maxWorldCount = 6;
						cost = 5;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					// class Snake_random_F {
					// 	maxCircleCount = "(1 - houses) * ((2 * (1 - sea)) + (2 * (meadow)))";
					// 	maxWorldCount = 3;
					// 	cost = 5;
					// 	spawnCount = 1;
					// 	groupSpawnRadius = 5;
					// 	maxAlt = 40;
					// 	minAlt = -5;
					// };
					class Salema_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 40;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Ornate_random_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.05))";
						maxWorldCount = 30;
						cost = 5;
						spawnCount = 3;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mackerel_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mullet_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Tuna_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) - 0.2))";
						maxWorldCount = 10;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
				};
			};
			class Radius30_40 {
				areaSpawnRadius = 30;
				areaMaxRadius = 40;
				spawnCircleRadius = 3;
				spawnInterval = 3.75;
				class Species {
					class DragonFly {
						maxCircleCount = "4 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * sea * (1 - windy) * (1-rain)";
						maxWorldCount = 4;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class ButterFly_random {
						maxCircleCount = "3 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FireFly {
						maxCircleCount = "(6 * night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 20;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
					class Cicada {
						maxCircleCount = "(4 * night) * (1 - sea) * (1 - windy) * (1-rain)";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius15_20 {
				areaSpawnRadius = 15;
				areaMaxRadius = 20;
				spawnCircleRadius = 2;
				spawnInterval = 2.85;
				class Species {
					class FxWindGrass1 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindGrass2 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf1 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf2 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf3 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPollen1 {
						maxCircleCount = "(3 * (1 - (WaterDepth interpolate [1,30,0,1]))) * (windy interpolate [0.05,0.15,0,1])";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPaper1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPlastic1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius6_10 {
				areaSpawnRadius = 6;
				areaMaxRadius = 10;
				spawnCircleRadius = 1;
				spawnInterval = 0.1;
				class Species {
					class HoneyBee {
						maxCircleCount = "4 * (1 - night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 8;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class HouseFly {
						maxCircleCount = "(3 + 3 * (houses)) * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 10;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class Mosquito {
						maxCircleCount = "3 * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
		};
	};
	class Tanoa : CAWorld {
		class AmbientA3 {
			maxCost = 500;
			class Radius440_500 {
				areaSpawnRadius = 440;
				areaMaxRadius = 500;
				spawnCircleRadius = 30;
				spawnInterval = 4.7;
				class Species {
					class Kestrel_random_F {
						maxCircleCount = "((1 - night) * 2 * (1 - (WaterDepth interpolate [1,30,0,1])) + (2 * (hills))) * (1 - night) * (1-rain)";
						maxWorldCount = 4;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					class Seagull {
						maxCircleCount = "((sea * (1 - night)) + (2 * houses * sea)) * (1 - night)";
						maxWorldCount = 8;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
					class Crowe {
						maxCircleCount = "((1 - night) * 2 * (1 - (WaterDepth interpolate [1,30,0,1])) + (2 * (hills))) * (1 - night)";
						maxWorldCount = 8;
						cost = 3;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 200;
						minAlt = -10;
					};
				};
			};
			class Radius40_60 {
				areaSpawnRadius = 50;
				areaMaxRadius = 83;
				spawnCircleRadius = 10;
				spawnInterval = 1.5;
				class Species {
					class CatShark_F {
						maxCircleCount = "(4 * (WaterDepth interpolate [1,30,0,1]))";
						maxWorldCount = 30;
						cost = 6;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					class Turtle_F {
						maxCircleCount = "(2 * (waterDepth interpolate [1,16,0,1]) * ((1-houses) * (1-houses)))";
						maxWorldCount = 12;
						cost = 5;
						spawnCount = 1;
						groupSpawnRadius = 10;
						maxAlt = 10;
						minAlt = -80;
					};
					class Salema_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 20;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Ornate_random_F {
						maxCircleCount = "(12 * ((WaterDepth interpolate [1,30,0,1]) + 0.05))";
						maxWorldCount = 15;
						cost = 5;
						spawnCount = 3;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mackerel_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 14;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Mullet_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) + 0.07))";
						maxWorldCount = 7;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
					class Tuna_F {
						maxCircleCount = "(8 * ((WaterDepth interpolate [1,30,0,1]) - 0.2))";
						maxWorldCount = 20;
						cost = 5;
						spawnCount = 2;
						groupSpawnRadius = 5;
						maxAlt = 10;
						minAlt = -80;
					};
				};
			};
			class Radius30_40 {
				areaSpawnRadius = 30;
				areaMaxRadius = 40;
				spawnCircleRadius = 3;
				spawnInterval = 3.75;
				class Species {
					class DragonFly {
						maxCircleCount = "4 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * sea * (1 - windy) * (1-rain)";
						maxWorldCount = 2;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class ButterFly_random {
						maxCircleCount = "3 * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FireFly {
						maxCircleCount = "(8 * night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 20;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 3;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius15_20 {
				areaSpawnRadius = 15;
				areaMaxRadius = 20;
				spawnCircleRadius = 2;
				spawnInterval = 2.85;
				class Species {
					class FxWindGrass1 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 10;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindGrass2 {
						maxCircleCount = "2 * (1 - (WaterDepth interpolate [1,30,0,1])) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 10;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf1 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf2 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindLeaf3 {
						maxCircleCount = "2 * (trees + 0.5) * (windy interpolate [0.1,0.25,0,1])";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 2.5;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPollen1 {
						maxCircleCount = "(3 * (1 - (WaterDepth interpolate [1,30,0,1]))) * (windy interpolate [0.05,0.15,0,1])";
						maxWorldCount = 6;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPaper1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 1;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class FxWindPlastic1 {
						maxCircleCount = "(4 * (1 - (WaterDepth interpolate [1,30,0,1])) * houses) * windy";
						maxWorldCount = 1;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
			class Radius6_10 {
				areaSpawnRadius = 6;
				areaMaxRadius = 10;
				spawnCircleRadius = 1;
				spawnInterval = 0.1;
				class Species {
					class HoneyBee {
						maxCircleCount = "4 * (1 - night) * (1 - sea) * (1 - houses) * (1 - windy) * (1-rain)";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class HouseFly {
						maxCircleCount = "(3 + 3 * (houses)) * (1 - night) * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 3;
						cost = 1;
						spawnCount = 3;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
					class Mosquito {
						maxCircleCount = "3 * (1 - (WaterDepth interpolate [1,30,0,1])) * (1 - windy) * (1-rain)";
						maxWorldCount = 5;
						cost = 1;
						spawnCount = 1;
						groupSpawnRadius = 1;
						maxAlt = 30;
						minAlt = -5;
					};
				};
			};
		};
	};
};