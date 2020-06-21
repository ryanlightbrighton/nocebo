class CfgMagazines {
	class Default;
	class CA_Magazine : Default {
		horde_inventorySound = "horde_sound_magazineInventory";
	};

	class Laserbatteries : CA_Magazine {
		ncb_refill = 1;
		ncb_refillclass = "battery";
	};

	class CA_LauncherMagazine;
	class Titan_AA : CA_LauncherMagazine {
		ncb_refill = 1;
		ncb_refillclass = "titanaa";
	};
	class Titan_AP : Titan_AA {
		ncb_refillclass = "obsolete";
	};
	class Titan_AT : Titan_AA {
		ncb_refillclass = "titanat";
	};

	class 200Rnd_556x45_Box_F;
	class 200Rnd_556x45_Box_Tracer_F : 200Rnd_556x45_Box_F {
		ncb_refill = 1;
		ncb_refillclass = "556x45";
	};

	// VEHICLE AMMUNITION

	class 60Rnd_CMFlareMagazine : CA_Magazine {
		descriptionShort = "Flare magazine<br />Rounds : 60<br />Used in: Vehicles";
		displayname = "Flare magazine";
		picture = "\nocebo\images\vehicle_ammo\countermeasures.paa";
		ncb_refillclass = "flare";
	};
	class 120Rnd_CMFlareMagazine : 60Rnd_CMFlareMagazine {
		descriptionShort = "Flare magazine<br />Rounds : 120<br />Used in: Vehicles";
	};
	class 240Rnd_CMFlareMagazine : 60Rnd_CMFlareMagazine {
		descriptionShort = "Flare magazine<br />Rounds : 240<br />Used in: Vehicles";
	};
	class 60Rnd_CMFlare_Chaff_Magazine : 60Rnd_CMFlareMagazine {
		descriptionshort = "Chaff magazine<br />Rounds : 60<br />Used in: Vehicles";
		displayname = "Chaff magazine";
		ncb_refillclass = "chaff";
	};
	class 120Rnd_CMFlare_Chaff_Magazine : 60Rnd_CMFlare_Chaff_Magazine {
		descriptionshort = "Chaff magazine<br />Rounds : 120<br />Used in: Vehicles";
	};
	class 240Rnd_CMFlare_Chaff_Magazine : 60Rnd_CMFlare_Chaff_Magazine {
		descriptionshort = "Chaff magazine<br />Rounds : 240<br />Used in: Vehicles";
	};
	class 192Rnd_CMFlare_Chaff_Magazine : 60Rnd_CMFlare_Chaff_Magazine {
		descriptionshort = "Chaff magazine<br />Rounds : 192<br />Used in: Vehicles";
	};
	class 168Rnd_CMFlare_Chaff_Magazine : 60Rnd_CMFlare_Chaff_Magazine {
		descriptionshort = "Chaff magazine<br />Rounds : 168<br />Used in: Vehicles";
	};
	class 300Rnd_CMFlare_Chaff_Magazine : 60Rnd_CMFlare_Chaff_Magazine {
		descriptionshort = "Chaff magazine<br />Rounds : 300<br />Used in: Vehicles";
	};
	class VehicleMagazine : CA_Magazine {
		picture = "\nocebo\images\vehicle_ammo\bullet_belt.paa";
	};
	class SmokeLauncherMag : VehicleMagazine {
		descriptionshort = "Smoke launcher magazine<br />Rounds : 2<br />Used in: Vehicles";
		displayname = "Smoke launcher mag";
		picture = "\nocebo\images\vehicle_ammo\smoke_launcher.paa";
		ncb_refillclass = "smoke";
	};
	class SmokeLauncherMag_boat : VehicleMagazine {
		descriptionshort = "Smoke launcher magazine (boat)<br />Rounds : 2<br />Used in: Vehicles";
		displayname = "Smoke launcher mag";
		picture = "\nocebo\images\vehicle_ammo\smoke_launcher.paa";
		ncb_refillclass = "smoke";
	};

	// individual (portable refills)

	class ncb_mag_flare_60_refill : 60Rnd_CMFlareMagazine {
		descriptionshort = "Flare reload<br />Rounds : 60<br />Used in: Vehicles";
		displayname = "60 x Flares";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "flare";
		mass = 30;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_chaff_60_refill : 60Rnd_CMFlare_Chaff_Magazine {
		descriptionshort = "Chaff reload<br />Rounds : 60<br />Used in: Vehicles";
		displayname = "60 x Chaff";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "chaff";
		mass = 30;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_smoke_2_refill : SmokeLauncherMag {
		descriptionshort = "Smoke reload<br />Rounds : 2<br />Used in: Vehicles";
		displayname = "2 x Smoke";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "smoke";
		mass = 30;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};

	// normal class

	class 200Rnd_762x51_Belt : VehicleMagazine {
		author = "Bohemia Interactive";
		scope = 2;
		count = 200;
		ammo = "B_762x51_Ball";
		initSpeed = 860;
		maxLeadSpeed = 55;
		ncb_refillclass = "762x51";
		tracersEvery = 5;
		lastRoundsTracer = 4;
		nameSound = "mgun";
		displayName = "7.62 mm Minigun Belt";
		descriptionShort = "Caliber: 7.62x51 mm<br />Rounds: 200<br />Used in : Vehicles";
	};
	// 200
	class ncb_mag_762x51_200_w : 200Rnd_762x51_Belt {
		ammo = "B_762x51_Ball";
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 200";
		displayName = "7.62 mm Belt";
	};
	class ncb_mag_762x51_200_r : ncb_mag_762x51_200_w {
		ammo = "B_762x51_Tracer_Red";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 200";
		displayName = "7.62 mm Belt (TR)";
	};
	class ncb_mag_762x51_200_g : ncb_mag_762x51_200_w {
		ammo = "B_762x51_Tracer_Green";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 200";
		displayName = "7.62 mm Belt (TG)";
	};
	class ncb_mag_762x51_200_y : ncb_mag_762x51_200_w {
		ammo = "B_762x51_Tracer_Yellow";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 200";
		displayName = "7.62 mm Belt (TY)";
	};
	// 1000
	class ncb_mag_762x51_1000_w : 200Rnd_762x51_Belt {
		ammo = "B_762x51_Ball";
		count = 1000;
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 1000";
		displayName = "7.62 mm Belt";
	};
	class ncb_mag_762x51_1000_r : ncb_mag_762x51_1000_w {
		ammo = "B_762x51_Tracer_Red";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 1000";
		displayName = "7.62 mm Belt (TR)";
	};
	class ncb_mag_762x51_1000_g : ncb_mag_762x51_1000_w {
		ammo = "B_762x51_Tracer_Green";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 1000";
		displayName = "7.62 mm Belt (TG)";
	};
	class ncb_mag_762x51_1000_y : ncb_mag_762x51_1000_w {
		ammo = "B_762x51_Tracer_Yellow";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 1000";
		displayName = "7.62 mm Belt (TY)";
	};
	// 2000
	class ncb_mag_762x51_2000_w : 200Rnd_762x51_Belt {
		ammo = "B_762x51_Ball";
		count = 2000;
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 2000";
		displayName = "7.62 mm Belt";
	};
	class ncb_mag_762x51_2000_r : ncb_mag_762x51_2000_w {
		ammo = "B_762x51_Tracer_Red";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 2000";
		displayName = "7.62 mm Belt (TR)";
	};
	class ncb_mag_762x51_2000_g : ncb_mag_762x51_2000_w {
		ammo = "B_762x51_Tracer_Green";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 2000";
		displayName = "7.62 mm Belt (TG)";
	};
	class ncb_mag_762x51_2000_y : ncb_mag_762x51_2000_w {
		ammo = "B_762x51_Tracer_Yellow";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 2000";
		displayName = "7.62 mm Belt (TY)";
	};
	// 5000
	class ncb_mag_762x51_5000_w : 200Rnd_762x51_Belt {
		ammo = "B_762x51_Ball";
		count = 5000;
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 5000";
		displayName = "7.62 mm Belt";
	};
	class ncb_mag_762x51_5000_r : ncb_mag_762x51_5000_w {
		ammo = "B_762x51_Tracer_Red";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 5000";
		displayName = "7.62 mm Belt (TR)";
	};
	class ncb_mag_762x51_5000_g : ncb_mag_762x51_5000_w {
		ammo = "B_762x51_Tracer_Green";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 5000";
		displayName = "7.62 mm Belt (TG)";
	};
	class ncb_mag_762x51_5000_y : ncb_mag_762x51_5000_w {
		ammo = "B_762x51_Tracer_Yellow";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 5000";
		displayName = "7.62 mm Belt (TY)";
	};


	// air class (area effect)

	// 200
	class ncb_mag_762x51_200_w_air : 200Rnd_762x51_Belt {
		ammo = "ncb_762x51_air";
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 200";
		displayName = "7.62 mm Minigun Belt";
	};
	class ncb_mag_762x51_200_r_air : ncb_mag_762x51_200_w_air {
		ammo = "ncb_762x51_air_tr";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 200";
		displayName = "7.62 mm Minigun Belt (TR)";
	};
	class ncb_mag_762x51_200_g_air : ncb_mag_762x51_200_w_air {
		ammo = "ncb_762x51_air_tg";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 200";
		displayName = "7.62 mm Minigun Belt (TG)";
	};
	class ncb_mag_762x51_200_y_air : ncb_mag_762x51_200_w_air {
		ammo = "ncb_762x51_air_ty";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 200";
		displayName = "7.62 mm Minigun Belt (TY)";
	};
	// 1000
	class ncb_mag_762x51_1000_w_air : 200Rnd_762x51_Belt {
		ammo = "ncb_762x51_air";
		count = 1000;
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 1000";
		displayName = "7.62 mm Minigun Belt";
	};
	class ncb_mag_762x51_1000_r_air : ncb_mag_762x51_1000_w_air {
		ammo = "ncb_762x51_air_tr";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 1000";
		displayName = "7.62 mm Minigun Belt (TR)";
	};
	class ncb_mag_762x51_1000_g_air : ncb_mag_762x51_1000_w_air {
		ammo = "ncb_762x51_air_tg";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 1000";
		displayName = "7.62 mm Minigun Belt (TG)";
	};
	class ncb_mag_762x51_1000_y_air : ncb_mag_762x51_1000_w_air {
		ammo = "ncb_762x51_air_ty";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 1000";
		displayName = "7.62 mm Minigun Belt (TY)";
	};
	// 2000
	class ncb_mag_762x51_2000_w_air : 200Rnd_762x51_Belt {
		ammo = "ncb_762x51_air";
		count = 2000;
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 2000";
		displayName = "7.62 mm Minigun Belt";
	};
	class ncb_mag_762x51_2000_r_air : ncb_mag_762x51_2000_w_air {
		ammo = "ncb_762x51_air_tr";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 2000";
		displayName = "7.62 mm Minigun Belt (TR)";
	};
	class ncb_mag_762x51_2000_g_air : ncb_mag_762x51_2000_w_air {
		ammo = "ncb_762x51_air_tg";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 2000";
		displayName = "7.62 mm Minigun Belt (TG)";
	};
	class ncb_mag_762x51_2000_y_air : ncb_mag_762x51_2000_w_air {
		ammo = "ncb_762x51_air_ty";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 2000";
		displayName = "7.62 mm Minigun Belt (TY)";
	};
	// 5000
	class ncb_mag_762x51_5000_w_air : 200Rnd_762x51_Belt {
		ammo = "ncb_762x51_air";
		count = 5000;
		descriptionShort = "Caliber : 7.62x51 mm<br />Rounds : 5000";
		displayName = "7.62 mm Minigun Belt";
	};
	class ncb_mag_762x51_5000_r_air : ncb_mag_762x51_5000_w_air {
		ammo = "ncb_762x51_air_tr";
		descriptionShort = "Caliber : 7.62x51 mm (TR)<br />Rounds : 5000";
		displayName = "7.62 mm Minigun Belt (TR)";
	};
	class ncb_mag_762x51_5000_g_air : ncb_mag_762x51_5000_w_air {
		ammo = "ncb_762x51_air_tg";
		descriptionShort = "Caliber : 7.62x51 mm (TG)<br />Rounds : 5000";
		displayName = "7.62 mm Minigun Belt (TG)";
	};
	class ncb_mag_762x51_5000_y_air : ncb_mag_762x51_5000_w_air {
		ammo = "ncb_762x51_air_ty";
		descriptionShort = "Caliber : 7.62x51 mm (TY)<br />Rounds : 5000";
		displayName = "7.62 mm Minigun Belt (TY)";
	};

	// 6.5

	class 200Rnd_65x39_Belt : VehicleMagazine {
		ncb_refillclass = "65x39";
	};
	class ncb_mag_65x39_100_refill : 200Rnd_65x39_Belt {
		count = 100;
		descriptionShort = "Caliber: 6.5x39 mm<br />Rounds: 100<br />Used in: Vehicles";
		displayName = "100 x 6.5x39mm Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};

	// 7.62x51

	class ncb_mag_762x51_100_refill : 200Rnd_762x51_Belt {
		count = 100;
		descriptionShort = "Caliber: 7.62x51 mm<br />Rounds: 100<br />Used in: Vehicles";
		displayName = "100 x 7.62x51mm Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};

	// 7.62x54

	// 100
	class ncb_mag_762x54_100_w : VehicleMagazine {
		ammo = "B_762x54_Ball";
        author = "Das Attorney";
        count = 100;
        descriptionShort = "Caliber: 7.62x54 mm<br />Rounds: 100<br />Vehicles";
        displayName = "7.62 x 54 belt";
        initSpeed = 860;
        lastRoundsTracer = 5;
        maxLeadSpeed = 55;
        nameSound = "mgun";
        ncb_refillclass = "762x54";
        tracersEvery = 5;
        scope = 2;
    };
    class ncb_mag_762x54_100_g : ncb_mag_762x54_100_w {
    	ammo = "B_762x54_Tracer_Green";
    };
    class ncb_mag_762x54_100_r : ncb_mag_762x54_100_w {
    	ammo = "B_762x54_Tracer_Red";
    };
    class ncb_mag_762x54_100_y : ncb_mag_762x54_100_w {
    	ammo = "B_762x54_Tracer_Yellow";
    };
    // 200
    class ncb_mag_762x54_200_w : ncb_mag_762x54_100_w {
    	count = 200;
        descriptionShort = "Caliber: 7.62x54 mm<br />Rounds: 200<br />Vehicles";
    };
    class ncb_mag_762x54_200_g : ncb_mag_762x54_200_w {
    	ammo = "B_762x54_Tracer_Green";
    };
    class ncb_mag_762x54_200_r : ncb_mag_762x54_200_w {
    	ammo = "B_762x54_Tracer_Red";
    };
    class ncb_mag_762x54_200_y : ncb_mag_762x54_200_w {
    	ammo = "B_762x54_Tracer_Yellow";
    };
    // 500
    class ncb_mag_762x54_500_w : ncb_mag_762x54_100_w {
    	count = 500;
        descriptionShort = "Caliber: 7.62x54 mm<br />Rounds: 500<br />Vehicles";
    };
    class ncb_mag_762x54_500_g : ncb_mag_762x54_500_w {
    	ammo = "B_762x54_Tracer_Green";
    };
    class ncb_mag_762x54_500_r : ncb_mag_762x54_500_w {
    	ammo = "B_762x54_Tracer_Red";
    };
    class ncb_mag_762x54_500_y : ncb_mag_762x54_500_w {
    	ammo = "B_762x54_Tracer_Yellow";
    };
    // 1000
    class ncb_mag_762x54_1000_w : ncb_mag_762x54_100_w {
    	count = 1000;
        descriptionShort = "Caliber: 7.62x54 mm<br />Rounds: 1000<br />Vehicles";
    };
    class ncb_mag_762x54_1000_g : ncb_mag_762x54_1000_w {
    	ammo = "B_762x54_Tracer_Green";
    };
    class ncb_mag_762x54_1000_r : ncb_mag_762x54_1000_w {
    	ammo = "B_762x54_Tracer_Red";
    };
    class ncb_mag_762x54_1000_y : ncb_mag_762x54_1000_w {
    	ammo = "B_762x54_Tracer_Yellow";
    };
    // 2000
    class ncb_mag_762x54_2000_w : ncb_mag_762x54_100_w {
    	count = 2000;
        descriptionShort = "Caliber: 7.62x54 mm<br />Rounds: 2000<br />Vehicles";
    };
    class ncb_mag_762x54_2000_g : ncb_mag_762x54_2000_w {
    	ammo = "B_762x54_Tracer_Green";
    };
    class ncb_mag_762x54_2000_r : ncb_mag_762x54_2000_w {
    	ammo = "B_762x54_Tracer_Red";
    };
    class ncb_mag_762x54_2000_y : ncb_mag_762x54_2000_w {
    	ammo = "B_762x54_Tracer_Yellow";
    };
    // refill
    class ncb_mag_762x54_100_refill : ncb_mag_762x54_100_w {
		ncb_refill = 1;
		ncb_refillclass = "762x54";
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
	};

	// .338

	class 130Rnd_338_Mag : CA_Magazine {
        ncb_refill = 1;
        ncb_refillclass = ".338";
    };

	// 12.7 x 99mm

	// portable belts

	// BALL

	class 500Rnd_127x99_mag : VehicleMagazine {
		displayName = "12.7 x 99mm Mag";
		descriptionShort = "Caliber: 12.7x99 mm<br/>Rounds: 500<br />Used in: Vehicles";
		ncb_refillclass = "127x99";
	};
	class 500Rnd_127x99_mag_Tracer_Red : 500Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (R)";
		descriptionShort = "Caliber: 12.7x99 mm (R)<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class 500Rnd_127x99_mag_Tracer_Green : 500Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (G)";
		descriptionShort = "Caliber: 12.7x99 mm (G)<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class 500Rnd_127x99_mag_Tracer_Yellow : 500Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (Y)";
		descriptionShort = "Caliber: 12.7x99 mm (Y)<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class 200Rnd_127x99_mag : 500Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag";
		descriptionShort = "Caliber: 12.7x99 mm<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class 200Rnd_127x99_mag_Tracer_Red : 200Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (R)";
		descriptionShort = "Caliber: 12.7x99 mm (R)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class 200Rnd_127x99_mag_Tracer_Green : 200Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (G)";
		descriptionShort = "Caliber: 12.7x99 mm (G)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class 200Rnd_127x99_mag_Tracer_Yellow : 200Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (G)";
		descriptionShort = "Caliber: 12.7x99 mm (Y)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class 100Rnd_127x99_mag : 500Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag";
		descriptionShort = "Caliber: 12.7x99 mm<br/>Rounds: 100<br />Used in: Vehicles";
	};
	class 100Rnd_127x99_mag_Tracer_Red : 100Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (R)";
		descriptionShort = "Caliber: 12.7x99 mm (R)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class 100Rnd_127x99_mag_Tracer_Green : 100Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (G)";
		descriptionShort = "Caliber: 12.7x99 mm (G)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class 100Rnd_127x99_mag_Tracer_Yellow : 100Rnd_127x99_mag {
		displayName = "12.7 x 99mm Mag (Y)";
		descriptionShort = "Caliber: 12.7x99 mm (Y)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class ncb_mag_127x99_100_refill : 500Rnd_127x99_mag {
		count = 100;
		descriptionshort = "Caliber : 12.7x99 mm<br />Rounds : 100<br />Used in: Vehicles";
		displayname = "100 x 127x99mm Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "127x99";
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	// class 100Rnd_127x99_mag_TG : 100Rnd_127x99_mag {
	// 	ammo = "B_127x99_Ball_Tracer_Green";
	// 	descriptionshort = "Caliber : 12.7x99 mm (G)<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm Ammo Can (G)";
	// };
	// class 100Rnd_127x99_mag_TR : 100Rnd_127x99_mag {
	// 	ammo = "B_127x99_Ball_Tracer_Red";
	// 	descriptionshort = "Caliber : 12.7x99 mm (R)<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm Ammo Can (R)";
	// };
	// class 100Rnd_127x99_mag_TY : 100Rnd_127x99_mag {
	// 	ammo = "B_127x99_Ball_Tracer_Yellow";
	// 	descriptionshort = "Caliber : 12.7x99 mm (Y)<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm Ammo Can (Y)";
	// };

	// SLAP

	// class 100Rnd_127x99_SLAP_mag : 100Rnd_127x99_mag {
	// 	ammo = "B_127x99_SLAP";
	// 	descriptionshort = "Caliber : 12.7x99 mm SLAP<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm SLAP Ammo Can";
	// };
	// class 100Rnd_127x99_SLAP_mag_TR : 100Rnd_127x99_SLAP_mag {
	// 	ammo = "B_127x99_SLAP_Tracer_Red";
	// 	descriptionshort = "Caliber : 12.7x99 mm SLAP (R)<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm SLAP Ammo Can (R)";
	// };
	// class 100Rnd_127x99_SLAP_mag_TG : 100Rnd_127x99_SLAP_mag {
	// 	ammo = "B_127x99_SLAP_Tracer_Green";
	// 	descriptionshort = "Caliber : 12.7x99 mm SLAP (G)<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm SLAP Ammo Can (G)";
	// };
	// class 100Rnd_127x99_SLAP_mag_TY : 100Rnd_127x99_SLAP_mag {
	// 	ammo = "B_127x99_SLAP_Tracer_Yellow";
	// 	descriptionshort = descriptionshort = "Caliber : 12.7x99 mm SLAP (Y)<br />Rounds : 100<br />Used in : M2 HMG";
	// 	displayname = "100 x 127x99mm SLAP Ammo Can (Y)";
	// };

	// 12.7 x 108mm

	// portable belts

	class 450Rnd_127x108_Ball : VehicleMagazine {
		displayName = "12.7 x 108mm Mag";
		descriptionShort = "Caliber: 12.7x108 mm<br/>Rounds: 450<br />Used in: Vehicles";
		ncb_refillclass = "127x108";
	};
	class 150Rnd_127x108_Ball : 450Rnd_127x108_Ball {
		descriptionShort = "Caliber: 12.7x108 mm<br/>Rounds: 150<br />Used in: Vehicles";
	};
	class 50Rnd_127x108_Ball : 450Rnd_127x108_Ball {
		descriptionShort = "Caliber: 12.7x108 mm<br/>Rounds: 50<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_500 : 450Rnd_127x108_Ball {
		count = 500;
		displayName = "12.7 x 108mm Mag";
		descriptionShort = "Caliber: 12.7x108 mm<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_500_r : ncb_mag_127x108_500 {
		displayName = "12.7 x 108mm Mag (R)";
		descriptionShort = "Caliber: 12.7x108 mm (R)<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_500_g : ncb_mag_127x108_500 {
		displayName = "12.7 x 108mm Mag (G)";
		descriptionShort = "Caliber: 12.7x108 mm (G)<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_500_y : ncb_mag_127x108_500 {
		displayName = "12.7 x 108mm Mag (Y)";
		descriptionShort = "Caliber: 12.7x108 mm (Y)<br/>Rounds: 500<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_200 : ncb_mag_127x108_500 {
		count = 200;
		displayName = "12.7 x 108mm Mag";
		descriptionShort = "Caliber: 12.7x108 mm<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_200_r : ncb_mag_127x108_200 {
		displayName = "12.7 x 108mm Mag (R)";
		descriptionShort = "Caliber: 12.7x108 mm (R)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_200_g : ncb_mag_127x108_200 {
		displayName = "12.7 x 108mm Mag (G)";
		descriptionShort = "Caliber: 12.7x108 mm (G)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_200_y : ncb_mag_127x108_200 {
		displayName = "12.7 x 108mm Mag (G)";
		descriptionShort = "Caliber: 12.7x108 mm (Y)<br/>Rounds: 200<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_100 : ncb_mag_127x108_500 {
		count = 100;
		displayName = "12.7 x 108mm Mag";
		descriptionShort = "Caliber: 12.7x108 mm<br/>Rounds: 100<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_100_r : ncb_mag_127x108_100 {
		displayName = "12.7 x 108mm Mag (R)";
		descriptionShort = "Caliber: 12.7x108 mm (R)<br/>Rounds: 100<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_100_g : ncb_mag_127x108_100 {
		displayName = "12.7 x 108mm Mag (G)";
		descriptionShort = "Caliber: 12.7x108 mm (G)<br/>Rounds: 100<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_100_y : ncb_mag_127x108_100 {
		displayName = "12.7 x 108mm Mag (Y)";
		descriptionShort = "Caliber: 12.7x108 mm (Y)<br/>Rounds: 100<br />Used in: Vehicles";
	};
	class ncb_mag_127x108_100_refill : 450Rnd_127x108_Ball {
		count = 100;
		descriptionshort = "Caliber : 12.7x108 mm<br />Rounds : 100<br />Used in: Vehicles";
		displayname = "100 x 127x108mm Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "127x108";
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	// class 100Rnd_127x108_mag_TG : 100Rnd_127x108_mag {
	// 	ammo = "B_127x108_Ball_TG";
	// 	descriptionshort = "Caliber : 12.7x108 mm (G)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm Ammo Can (G)";
	// };
	// class 100Rnd_127x108_mag_TR : 100Rnd_127x108_mag {
	// 	ammo = "B_127x108_Ball_TR";
	// 	descriptionshort = "Caliber : 12.7x108 mm (R)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm Ammo Can (R)";
	// };
	// class 100Rnd_127x108_mag_TY : 100Rnd_127x108_mag {
	// 	ammo = "B_127x108_Ball_TY";
	// 	descriptionshort = "Caliber : 12.7x108 mm (Y)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm Ammo Can (Y)";
	// };

	// APDS 100 rnd

	// class 100Rnd_127x108_APDS_mag : 100Rnd_127x108_mag {
	// 	ammo = "B_127x108_APDS";
	// 	descriptionshort = "Caliber : 12.7x108 mm APDS(G)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm APDS Ammo Can (G)";
	// };
	// class 100Rnd_127x108_APDS_mag_TG : 100Rnd_127x108_APDS_mag {
	// 	ammo = "B_127x108_APDS_TG";
	// 	descriptionshort = "Caliber : 12.7x108 mm APDS (G)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm APDS Ammo Can (G)";
	// };
	// class 100Rnd_127x108_APDS_mag_TR : 100Rnd_127x108_APDS_mag {
	// 	ammo = "B_127x108_APDS_TR";
	// 	descriptionshort = "Caliber : 12.7x108 mm APDS (R)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm APDS Ammo Can (R)";
	// };
	// class 100Rnd_127x108_APDS_mag_TY : 100Rnd_127x108_APDS_mag {
	// 	ammo = "B_127x108_APDS_TY";
	// 	descriptionshort = "Caliber : 12.7x108 mm APDS (Y)<br />Rounds : 100<br />Used in : .50 HMG";
	// 	displayname = "100 x 127x108mm APDS Ammo Can (Y)";
	// };

	// 40mm grenades

	 class 200Rnd_40mm_G_belt : VehicleMagazine {
		displayName = "40 mm HE Grenade Mag";
		descriptionShort = "Caliber: 40 mm <br />Rounds: 200<br />Used in: Vehicles";
		picture = "\nocebo\images\vehicle_ammo\grenade_belt.paa";
		ncb_refillclass = "40mmgrenade";
	};
   class 96Rnd_40mm_G_belt : 200Rnd_40mm_G_belt {
		descriptionShort = "Caliber: 40 mm <br />Rounds:96<br />Used in: Vehicles";
	};
	class 64Rnd_40mm_G_belt : 200Rnd_40mm_G_belt {
		descriptionShort = "Caliber: 40 mm <br />Rounds: 64<br />Used in: Vehicles";
	};
	class 32Rnd_40mm_G_belt : 200Rnd_40mm_G_belt {
		descriptionShort = "Caliber: 40 mm <br />Rounds: 32<br />Used in: Vehicles";
	};
	// refill
	class ncb_mag_grenade_40mm_he_32_refill : 200Rnd_40mm_G_belt {
		count = 32;
		displayName = "32 X 40 mm HE Grenade Ammo Can";
		descriptionShort = "Caliber: 40 mm<br />Rounds: 32<br />Used in: Vehicles";
		ncb_refill = 1;
		ncb_refillclass = "40mmgrenade";
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	// 20 mm grenades

	class 200Rnd_20mm_G_belt : VehicleMagazine {
		picture = "\nocebo\images\vehicle_ammo\grenade_belt.paa";
		ncb_refillclass = "20mmgrenade";
	};
	class 40Rnd_20mm_G_belt : 200Rnd_20mm_G_belt {
		descriptionShort = "Caliber: 20 mm<br/>Rounds: 40<br />Used in: Vehicles";
	};
	// refill
	class ncb_magv_grenade_20mm_he_40_refill : 200Rnd_20mm_G_belt {
		count = 40;
		displayName = "40 X 20 mm HE Grenade Ammo Can";
		descriptionShort = "Caliber: 20 mm <br />Rounds: 40<br />Used in: Vehicles";
		ncb_refill = 1;
		ncb_refillclass = "20mmgrenade";
		mass = 100;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};

	// SPG

	class SPG9_HEAT : VehicleMagazine {
		descriptionShort = "SPG HEAT<br />Rounds: 1<br />Used in: Vehicles";
		displayname = "1 x SPG HEAT";
		ncb_refill = 1;
		ncb_refillclass = "spgheat";
		scope = 2;
	};
	class 12rnd_SPG9_HEAT : SPG9_HEAT {
		ncb_refillclass = "spgheat";
		displayname = "12 x SPG HEAT";
	};
	class SPG9_HE : SPG9_HEAT {
		descriptionShort = "SPG HE<br />Rounds: 1<br />Used in: Vehicles";
		displayname = "1 x SPG HE";
		ncb_refill = 1;
		ncb_refillclass = "spghe";
		scope = 2;
	};
	class 8rnd_SPG9_HE : SPG9_HE {
		ncb_refillclass = "spghe";
		displayname = "8 x SPG HE";
	};



	// DAGR missile

	class 24Rnd_PG_missiles : VehicleMagazine {
		descriptionShort = "DAGR missile<br />Rounds: 24<br />Used in: Vehicles";
		displayname = "24 x DAGR missile";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "dagr";
	};
	class 12Rnd_PG_missiles : 24Rnd_PG_missiles {
		descriptionShort = "DAGR missile<br />Rounds: 24<br />Used in: Vehicles";
		displayname = "12 x DAGR missile";
	};

	// DAR missile

	class 24Rnd_missiles : VehicleMagazine {
		descriptionShort = "DAR missile<br />Rounds: 24<br />Used in: Vehicles";
		displayname = "24 x DAR missile";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "dar";
	};

	// scalpel

	class 8Rnd_LG_scalpel : VehicleMagazine {
		descriptionShort = "Scalpel missile<br />Rounds: 8<br />Used in: Vehicles";
		displayname = "8 x Scalpel E2 missile";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "scalpel";
	};

	// skyfire

	class 14Rnd_80mm_rockets : VehicleMagazine {
		descriptionShort = "Skyfire missile<br />Rounds: 14<br />Used in: Vehicles";
		displayname = "14 x Skyfire missile";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "skyfire";
	};

	// sahr-3

	class 2Rnd_Missile_AA_04_F; // falchion
	class 2Rnd_Missile_AA_03_F : 2Rnd_Missile_AA_04_F {
		descriptionShort = "Sahr-3 missile<br />Rounds: 2<br />Used in: Vehicles";
		displayname = "2 x Sahr-3 missile";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "sahr3";
	};

	// sharur

	class 6Rnd_Missile_AGM_02_F; // nato missile
	class 4Rnd_Missile_AGM_01_F : 6Rnd_Missile_AGM_02_F {
		descriptionShort = "Sharur missile<br />Rounds: 4<br />Used in: Vehicles";
		displayname = "4 x Sharur missile";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "sharur";
	};

	// Tratnyr rockets

	class 7Rnd_Rocket_04_HE_F;
	class 20Rnd_Rocket_03_HE_F : 7Rnd_Rocket_04_HE_F {
		descriptionShort = "Tratnyr HE rocket pod<br />Rounds: 20<br />Used in: Vehicles";
		displayname = "20 x Tratnyr HE rocket";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "tratnyrhe";
	};
	class 7Rnd_Rocket_04_AP_F;
	class 20Rnd_Rocket_03_AP_F : 7Rnd_Rocket_04_AP_F {
		descriptionShort = "Tratnyr AP rocket pod<br />Rounds: 20<br />Used in: Vehicles";
		displayname = "20 x Tratnyr AP rocket";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "tratnyrap";
	};
	class 4Rnd_GAA_missiles : VehicleMagazine {
		displayName = "4 x Zephyr AA Missile";
		descriptionShort = "Zephyr AA missile<br />Rounds: 4<br />Used in: Vehicles";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "titanaa";
	};
	class 1Rnd_GAA_missiles : 4Rnd_GAA_missiles {
		displayName = "Titan AA Missile";
		descriptionShort = "Titan AA missile<br />Rounds: 1<br />Used in: Vehicles";
	};
	class 4Rnd_Titan_long_missiles : 4Rnd_GAA_missiles {
		displayName = "4 x Titan AA Missile";
		descriptionShort = "Titan AA missile<br />Rounds: 4<br />Used in: Vehicles";
	};
	class 5Rnd_GAT_missiles : VehicleMagazine {
		displayName = "5 x Titan AT Missile";
		descriptionShort = "Titan AT missile<br />Rounds: 5<br />Used in: Vehicles";
		picture = "\nocebo\images\vehicle_ammo\missile.paa";
		ncb_refillclass = "titanat";
	};
	class 2Rnd_GAT_missiles : 5Rnd_GAT_missiles {
		displayName = "2 x Titan AT Missile";
		descriptionShort = "Titan AT missile<br />Rounds: 2<br />Used in: Vehicles";
	};
	class 1Rnd_GAT_missiles : 5Rnd_GAT_missiles {
		displayName = "Titan AT Missile";
		descriptionShort = "Titan AT missile<br />Rounds: 1<br />Used in: Vehicles";
	};

	// individual missiles

	class ncb_mag_missile_dagr_1_refill : 24Rnd_PG_missiles {
		count = 1;
		descriptionshort = "Type : ATGM<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "DAGR missile";
		ncb_refill = 1;
		ncb_refillclass = "dagr";
		mass = 150;
		model = "\A3\Weapons_F\Ammo\Rocket_01_F.p3d";
		scope = 2;
	};
	class ncb_mag_missile_dar_1_refill : 24Rnd_missiles {
		count = 1;
		descriptionshort = "Type : ATGM<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "DAR missile";
		ncb_refill = 1;
		ncb_refillclass = "dar";
		mass = 150;
		model = "\A3\Weapons_F\Ammo\Rocket_01_F.p3d";
		scope = 2;
	};
	class ncb_mag_missile_scalpel_1_refill : 8Rnd_LG_scalpel {
		count = 1;
		descriptionshort = "Type : ATGM<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "Scalpel E2 missile";
		ncb_refill = 1;
		ncb_refillclass = "scalpel";
		mass = 150;
		model = "\A3\Weapons_F\Ammo\Missile_AT_03_F";
		scope = 2;
	};
	class ncb_mag_missile_skyfire_1_refill : 14Rnd_80mm_rockets {
		count = 1;
		descriptionshort = "Type : ATGM<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "Skyfire missile";
		ncb_refill = 1;
		ncb_refillclass = "skyfire";
		mass = 150;
		model = "\A3\Weapons_F\Ammo\Rocket_02_F";
		scope = 2;
	};
	class ncb_mag_missile_sahr_1_refill : 2Rnd_Missile_AA_03_F {
		count = 1;
		descriptionshort = "Type : AA<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "Sahr-3 missile";
		ncb_refill = 1;
		ncb_refillclass = "sahr3";
		mass = 150;
		model = "\A3\Weapons_F_EPC\Ammo\Missile_AA_03_F.p3d";
		scope = 2;
	};
	class ncb_mag_missile_sharur_1_refill : 4Rnd_Missile_AGM_01_F {
		count = 1;
		descriptionshort = "Type : ATGM<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "Sharur missile";
		ncb_refill = 1;
		ncb_refillclass = "sharur";
		mass = 150;
		model = "\A3\Weapons_F_EPC\Ammo\Missile_AA_04_F.p3d";
		scope = 2;
	};
	class ncb_mag_rocket_tratnyr_he_1_refill : 20Rnd_Rocket_03_HE_F {
		count = 1;
		descriptionshort = "Type : HE rocket<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "Tratnyr HE rocket";
		ncb_refill = 1;
		ncb_refillclass = "tratnyrhe";
		mass = 150;
		model = "\A3\Weapons_F_EPC\Ammo\Rocket_03_HE_F.p3d";
		scope = 2;
	};
	class ncb_mag_rocket_tratnyr_ap_1_refill : 20Rnd_Rocket_03_AP_F {
		count = 1;
		descriptionshort = "Type : AP rocket<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "Tratnyr AP rocket";
		ncb_refill = 1;
		ncb_refillclass = "tratnyrap";
		mass = 150;
		model = "\A3\Weapons_F_EPC\Ammo\Rocket_03_AP_F.p3d";
		scope = 2;
	};

	// belt cannon

	// 20 mm

	class 300Rnd_20mm_shells : VehicleMagazine {
		descriptionshort = "Type : 20 mm Cannon belt<br />Rounds : 300";
		picture = "\nocebo\images\vehicle_ammo\cannon_belt.paa";
		ncb_refillclass = "20mmcannon";
	};
	class 1000Rnd_20mm_shells : 300Rnd_20mm_shells {
		descriptionshort = "Type : 20 mm Cannon belt<br />Rounds : 1000";
	};
	class 2000Rnd_20mm_shells : 300Rnd_20mm_shells {
		descriptionshort = "Type : 20 mm Cannon belt<br />Rounds : 2000";
	};

	// 25 mm

	class 300Rnd_25mm_shells : VehicleMagazine {
		descriptionshort = "Type : 25 mm Cannon belt<br />Rounds : 300";
		picture = "\nocebo\images\vehicle_ammo\cannon_belt.paa";
		ncb_refillclass = "25mmcannon";
	};
	class 1000Rnd_25mm_shells : 300Rnd_25mm_shells {
		descriptionshort = "Type : 25 mm Cannon belt<br />Rounds : 1000";
	};

	// 30 mm

	class 1000Rnd_Gatling_30mm_Plane_CAS_01_F : VehicleMagazine {
		displayName = "GAU-8 Mag";
		displayNameShort = "GAU-8 Mag";
		descriptionshort = "Type : 30 mm GAU-8 Cannon belt<br />Rounds : 1000";
		picture = "\nocebo\images\vehicle_ammo\cannon_belt.paa";
		ncb_refillclass = "30mmcannonhe";
	};

	class 250Rnd_30mm_HE_shells : VehicleMagazine {
		descriptionshort = "Type : 30 mm Cannon belt<br />Rounds : 250";
		picture = "\nocebo\images\vehicle_ammo\cannon_belt.paa";
		ncb_refillclass = "30mmcannonhe";
	};
	class 250Rnd_30mm_HE_shells_Tracer_Red : 250Rnd_30mm_HE_shells {
		descriptionshort = "Type : 30 mm Cannon belt (R)<br />Rounds : 250";
	};
	class 250Rnd_30mm_HE_shells_Tracer_Green : 250Rnd_30mm_HE_shells {
		descriptionshort = "Type : 30 mm Cannon belt (G)<br />Rounds : 250";
	};
	class 250Rnd_30mm_APDS_shells : 250Rnd_30mm_HE_shells {
		descriptionshort = "Type : 30 mm Cannon belt APDS<br />Rounds : 250";
		ncb_refillclass = "30mmcannonapds";
	};
	class 250Rnd_30mm_APDS_shells_Tracer_Red : 250Rnd_30mm_APDS_shells {
		descriptionshort = "Type : 30 mm Cannon belt APDS (R)<br />Rounds : 250";
	};
	class 250Rnd_30mm_APDS_shells_Tracer_Green : 250Rnd_30mm_APDS_shells {
		descriptionshort = "Type : 30 mm Cannon belt APDS (G)<br />Rounds : 250";
	};
	class 250Rnd_30mm_APDS_shells_Tracer_Yellow : 250Rnd_30mm_APDS_shells {
		descriptionshort = "Type : 30 mm Cannon belt APDS (Y)<br />Rounds : 250";
	};
	class 140Rnd_30mm_MP_shells : 250Rnd_30mm_HE_shells {
		descriptionshort = "Type : 30 mm Cannon belt MP<br />Rounds : 140";
	};
	class 140Rnd_30mm_MP_shells_Tracer_Red : 140Rnd_30mm_MP_shells {
		descriptionshort = "Type : 30 mm Cannon belt MP (R)<br />Rounds : 140";
	};
	class 140Rnd_30mm_MP_shells_Tracer_Green : 140Rnd_30mm_MP_shells_Tracer_Red {
		descriptionshort = "Type : 30 mm Cannon belt MP (G)<br />Rounds : 140";
	};
	class 140Rnd_30mm_MP_shells_Tracer_Yellow : 140Rnd_30mm_MP_shells_Tracer_Red {
		descriptionshort = "Type : 30 mm Cannon belt MP (Y)<br />Rounds : 140";
	};
	class 60Rnd_30mm_APFSDS_shells : 250Rnd_30mm_HE_shells {
		descriptionshort = "Type : 30 mm Cannon belt APFSDS<br />Rounds : 60";
		ncb_refillclass = "30mmcannonapds";
	};
	class 60Rnd_30mm_APFSDS_shells_Tracer_Red : 60Rnd_30mm_APFSDS_shells {
		descriptionshort = "Type : 30 mm Cannon belt APFSDS (R)<br />Rounds : 60";
	};
	class 60Rnd_30mm_APFSDS_shells_Tracer_Green : 60Rnd_30mm_APFSDS_shells {
		descriptionshort = "Type : 30 mm Cannon belt APFSDS (G)<br />Rounds : 60";
	};
	class 60Rnd_30mm_APFSDS_shells_Tracer_Yellow : 60Rnd_30mm_APFSDS_shells {
		descriptionshort = "Type : 30 mm Cannon belt APFSDS (Y)<br />Rounds : 60";
	};

	// 35mm

	class 680Rnd_35mm_AA_shells : VehicleMagazine {
		descriptionshort = "Type : 35 mm Cannon belt<br />Rounds : 680";
		picture = "\nocebo\images\vehicle_ammo\cannon_belt.paa";
		ncb_refillclass = "35mmcannon";
	};
	class 680Rnd_35mm_AA_shells_Tracer_Red : 680Rnd_35mm_AA_shells {
		descriptionshort = "Type : 35 mm Cannon belt (R)<br />Rounds : 680";
	};
	class 680Rnd_35mm_AA_shells_Tracer_Green : 680Rnd_35mm_AA_shells {
		descriptionshort = "Type : 35 mm Cannon belt (G)<br />Rounds : 680";
	};
	class 680Rnd_35mm_AA_shells_Tracer_Yellow : 680Rnd_35mm_AA_shells {
		descriptionshort = "Type : 35 mm Cannon belt (Y)<br />Rounds : 680";
	};

	// 40 mm

	class 60Rnd_40mm_GPR_shells : VehicleMagazine {
		descriptionshort = "Type : 40 mm GPR belt<br />Rounds : 60";
		picture = "\nocebo\images\vehicle_ammo\cannon_belt.paa";
		ncb_refillclass = "40mmcannon";
	};
	class 60Rnd_40mm_GPR_Tracer_Red_shells : 60Rnd_40mm_GPR_shells {
		descriptionshort = "Type : 40 mm GPR belt (R)<br />Rounds : 60";
	};
	class 60Rnd_40mm_GPR_Tracer_Green_shells : 60Rnd_40mm_GPR_shells {
		descriptionshort = "Type : 40 mm GPR belt (G)<br />Rounds : 60";
	};
	class 60Rnd_40mm_GPR_Tracer_Yellow_shells : 60Rnd_40mm_GPR_shells {
		descriptionshort = "Type : 40 mm GPR belt (Y)<br />Rounds : 60";
	};
	class 40Rnd_40mm_APFSDS_shells : 60Rnd_40mm_GPR_shells {
		descriptionshort = "Type : 40 mm GPR belt APFSDS<br />Rounds : 40";
	};
	class 40Rnd_40mm_APFSDS_Tracer_Red_shells : 40Rnd_40mm_APFSDS_shells {
		descriptionshort = "Type : 40 mm GPR belt APFSDS (R)<br />Rounds : 40";
	};
	class 40Rnd_40mm_APFSDS_Tracer_Green_shells : 40Rnd_40mm_APFSDS_Tracer_Red_shells {
		descriptionshort = "Type : 40 mm GPR belt APFSDS (G)<br />Rounds : 40";
	};
	class 40Rnd_40mm_APFSDS_Tracer_Yellow_shells : 40Rnd_40mm_APFSDS_Tracer_Red_shells {
		descriptionshort = "Type : 40 mm GPR belt APFSDS (Y)<br />Rounds : 40";
	};

	class ncb_mag_cannon_20mm_he_100_refill : 300Rnd_20mm_shells {
		count = 100;
		descriptionshort = "Caliber : 20 mm cannon belt<br />Rounds : 100<br />Used in: Vehicles";
		displayname = "100 x 20mm Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "20mmcannon";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_cannon_25mm_he_100_refill : 300Rnd_25mm_shells {
		count = 100;
		descriptionshort = "Caliber : 25 mm cannon belt<br />Rounds : 100<br />Used in: Vehicles";
		displayname = "100 x 25mm Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "25mmcannon";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_cannon_30mm_he_50_refill : 250Rnd_30mm_HE_shells {
		count = 50;
		descriptionshort = "Caliber : 30 mm HE cannon belt<br />Rounds : 50<br />Used in: Vehicles";
		displayname = "50 x 30mm HE Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "30mmcannonhe";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_cannon_30mm_apds_50_refill : 250Rnd_30mm_APDS_shells {
		count = 50;
		descriptionshort = "Caliber : 30 mm APDS cannon belt<br />Rounds : 50<br />Used in: Vehicles";
		displayname = "50 x 30mm APDS Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "30mmcannonapds";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_cannon_30mm_gau8_50_refill : 1000Rnd_Gatling_30mm_Plane_CAS_01_F {
		count = 50;
		descriptionshort = "Caliber : 30 mm GAU-8 cannon belt<br />Rounds : 50<br />Used in: Vehicles";
		displayname = "50 x 30mm GAU-8 Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "obsolete";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_cannon_35mm_aa_40_refill : 680Rnd_35mm_AA_shells {
		count = 40;
		descriptionshort = "Caliber : 35 mm AA cannon belt<br />Rounds : 40<br />Used in: Vehicles";
		displayname = "40 x 35mm AA Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "35mmcannon";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};
	class ncb_mag_cannon_40mm_gpr_30_refill : 60Rnd_40mm_GPR_shells {
		count = 30;
		descriptionshort = "Caliber : 40 mm cannon belt<br />Rounds : 30<br />Used in: Vehicles";
		displayname = "30 x 40mm Cannon Ammo Can";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "40mmcannon";
		mass = 200;
		model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
		scope = 2;
	};

	// CANNON

	// 120mm

	class 30Rnd_120mm_HE_shells : VehicleMagazine {
		descriptionshort = "Type : 120 mm HE shells<br />Rounds : 30<br />Used in : Vehicles";
		picture = "\nocebo\images\vehicle_ammo\sabot_shell.paa";
		ncb_refillclass = "120mmcannonhe";
	};
	class 30Rnd_120mm_APFSDS_shells : 30Rnd_120mm_HE_shells {
		descriptionshort = "Type : 120 mm APFSDS shells<br />Rounds : 30<br />Used in : Vehicles";
		ncb_refillclass = "120mmcannonapfsds";
	};
	class ncb_mag_cannon_120mm_he_1_refill : 30Rnd_120mm_HE_shells {
		count = 1;
		descriptionshort = "Caliber : 120 mm shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "120mm HE Cannon Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "120mmcannonhe";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_120mm_apfsds_1_refill : 30Rnd_120mm_APFSDS_shells {
		count = 1;
		descriptionshort = "Caliber : 120 mm APFSDS shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "120mm APFSDS Cannon Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "120mmcannonapfsds";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};

	// 125mm

	class 20Rnd_125mm_APFSDS : VehicleMagazine {
		descriptionshort = "Type : 125 mm APFSDS shells<br />Rounds : 20<br />Used in : Vehicles";
		picture = "\nocebo\images\vehicle_ammo\sabot_shell.paa";
		ncb_refillclass = "125mmcannonapfsds";
	};
	class 16Rnd_120mm_HE_shells;
	class 12Rnd_125mm_HE : 16Rnd_120mm_HE_shells {
		descriptionshort = "Type : 125 mm HE shells<br />Rounds : 12<br />Used in : Vehicles";
		picture = "\nocebo\images\vehicle_ammo\sabot_shell.paa";
		ncb_refillclass = "125mmcannonhe";
	};
	class 12Rnd_125mm_HEAT : 12Rnd_125mm_HE {
		descriptionshort = "Type : 125 mm HEAT shells<br />Rounds : 12<br />Used in : Vehicles";
		picture = "\nocebo\images\vehicle_ammo\sabot_shell.paa";
		ncb_refillclass = "125mmcannonheat";
	};
	class 16Rnd_120mm_HE_shells_Tracer_Green;
	class 12Rnd_125mm_HE_T_Green : 16Rnd_120mm_HE_shells_Tracer_Green {
		descriptionshort = "Type : 125 mm HEAT (TG) shells<br />Rounds : 12<br />Used in : Vehicles";
		picture = "\nocebo\images\vehicle_ammo\sabot_shell.paa";
		ncb_refillclass = "125mmcannonheat";
	};
	class ncb_mag_cannon_125mm_he_1_refill : 12Rnd_125mm_HE {
		count = 1;
		descriptionshort = "Caliber : 120 mm HE shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "125mm HE Cannon Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "125mmcannonhe";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_125mm_heat_1_refill : 12Rnd_125mm_HEAT {
		count = 1;
		descriptionshort = "Caliber : 125 mm HEAT shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "125mm HEAT Cannon Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "125mmcannonheat";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_125mm_apfsds_1_refill : 20Rnd_125mm_APFSDS {
		count = 1;
		descriptionshort = "Caliber : 125 mm APFSDS shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "125mm APFSDS Cannon Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "125mmcannonapfsds";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};

	// 155mm

	class 32Rnd_155mm_Mo_shells : VehicleMagazine {
		descriptionshort = "Type : 155 mm AMOS shells<br />Rounds : 32<br />Used in : Vehicles";
		displayName = "32 x 155 mm HE Shells";
		picture = "\nocebo\images\vehicle_ammo\sabot_shell.paa";
		ncb_refillclass = "155mmcannonhe";
	};
	class 6Rnd_155mm_Mo_smoke : 32Rnd_155mm_Mo_shells {
		descriptionshort = "Type : 155 mm smoke shells<br />Rounds : 6<br />Used in : Vehicles";
		displayName = "6 x 155 mm Smoke Shells";
		ncb_refillclass = "155mmcannonsmoke";
	};
	class 2Rnd_155mm_Mo_guided : 6Rnd_155mm_Mo_smoke {
		descriptionshort = "Type : 155 mm guided shells<br />Rounds : 2<br />Used in : Vehicles";
		displayName = "2 x 155 mm Guided Shells";
		ncb_refillclass = "155mmcannonguided";
	};
	class 2Rnd_155mm_Mo_LG : 6Rnd_155mm_Mo_smoke {
		descriptionshort = "Type : 155 mm laser guided shells<br />Rounds : 2<br />Used in : Vehicles";
		displayName = "2 x 155 mm Laser Guided Shells";
		ncb_refillclass = "155mmcannonlg";
	};
	class 6Rnd_155mm_Mo_mine : 6Rnd_155mm_Mo_smoke {
		descriptionshort = "Type : 155 mm mine cluster shells<br />Rounds : 6<br />Used in : Vehicles";
		displayName = "6 x 155 mm Mine Cluster Shells";
		ncb_refillclass = "155mmcannonmine";
	};
	class 6Rnd_155mm_Mo_AT_mine : 6Rnd_155mm_Mo_smoke {
		descriptionshort = "Type : 155 mm AT mine cluster shells<br />Rounds : 6<br />Used in : Vehicles";
		displayName = "6 x 155 mm AT Mine Cluster Shells";
		ncb_refillclass = "155mmcannonatmine";
	};
	class 2Rnd_155mm_Mo_Cluster : 6Rnd_155mm_Mo_smoke {
		descriptionshort = "Type : 155 mm cluster shells<br />Rounds : 2<br />Used in : Vehicles";
		displayName = "2 x 155 mm Cluster Shells";
		ncb_refillclass = "155mmcannoncluster";
	};
	class ncb_mag_cannon_155mm_he_1_refill : 32Rnd_155mm_Mo_shells {
		count = 1;
		descriptionshort = "Caliber : 155 mm shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon HE Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannonhe";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_155mm_smoke_1_refill : 6Rnd_155mm_Mo_smoke {
		count = 1;
		descriptionshort = "Caliber : 155 mm smoke shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon Smoke Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannonsmoke";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_155mm_guided_1_refill : 2Rnd_155mm_Mo_guided {
		count = 1;
		descriptionshort = "Caliber : 155 mm guided shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon Guided Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannonguided";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_155mm_lg_1_refill : 2Rnd_155mm_Mo_LG {
		count = 1;
		descriptionshort = "Caliber : 155 mm LG shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon LG Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannonlg";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_155mm_mine_1_refill : 6Rnd_155mm_Mo_mine {
		count = 1;
		descriptionshort = "Caliber : 155 mm mine shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon Mine Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannonmine";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_155mm_atmine_1_refill : 6Rnd_155mm_Mo_AT_mine {
		count = 1;
		descriptionshort = "Caliber : 155 mm AT mine shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon AT Mine Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannonatmine";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};
	class ncb_mag_cannon_155mm_cluster_1_refill : 2Rnd_155mm_Mo_Cluster {
		count = 1;
		descriptionshort = "Caliber : 155 mm cluster shell<br />Rounds : 1<br />Used in: Vehicles";
		displayname = "155mm Cannon Cluster Shell";
		horde_inventorySound = "horde_sound_magazineBeltInventory";
		ncb_refill = 1;
		ncb_refillclass = "155mmcannoncluster";
		mass = 200;
		model = "\A3\weapons_f\ammo\shell";
		scope = 2;
	};

	// MORTAR ROUNDS
	class 8Rnd_82mm_Mo_shells : 32Rnd_155mm_Mo_shells{
		ncb_refillclass = "82mmmortarhe";
	};
	class ncb_mag_mortar_82mm_he_1_refill : 8Rnd_82mm_Mo_shells {
		count = 1;
		descriptionshort = "Type : 82mm Mortar round<br />Rounds : 1<br />Used in : Mk6 Mortar";
		displayname = "82mm HE Mortar Shell";
		ncb_refill = 1;
		//ncb_refillclass = "82mmmortarhe";
		mass = 30;
		model = "\A3\weapons_f\ammo\shell";
		picture = "\nocebo\images\mortar_shell.paa";
		scope = 2;
	};
	class 8Rnd_82mm_Mo_Flare_white : 8Rnd_82mm_Mo_shells {
		ncb_refillclass = "82mmmortarflare";
	};
	class ncb_mag_mortar_82mm_flare_white_1_refill : 8Rnd_82mm_Mo_Flare_white {
		count = 1;
		descriptionshort = "Type : 82mm Mortar flare (white)<br />Rounds : 1<br />Used in : Mk6 Mortar";
		displayname = "82mm White Flare Mortar Shell";
		ncb_refill = 1;
		mass = 30;
		model = "\A3\weapons_f\ammo\shell";
		picture = "\nocebo\images\mortar_shell.paa";
		scope = 2;
	};
	class 8Rnd_82mm_Mo_Smoke_white : 8Rnd_82mm_Mo_shells {
		ncb_refillclass = "82mmmortarsmoke";
	};
	class ncb_mag_mortar_82mm_smoke_white_1_refill : 8Rnd_82mm_Mo_Smoke_white {
		count = 1;
		descriptionshort = "Type : 82mm Mortar smoke (white)<br />Rounds : 1<br />Used in : Mk6 Mortar";
		displayname = "82mm White Smoke Mortar Shell";
		ncb_refill = 1;
		mass = 30;
		model = "\A3\weapons_f\ammo\shell";
		picture = "\nocebo\images\mortar_shell.paa";
		scope = 2;
	};

	// BOMBS

	class 2Rnd_GBU12_LGB : VehicleMagazine {
		descriptionshort = "Type : Laser-guided bomb<br />Rounds : 2<br />Used in : Vehicles";
		displayname = "2 x GBU-12 bomb";
		picture = "\nocebo\images\vehicle_ammo\bomb.paa";
		ncb_refillclass = "bombgbu12";
	};
	class ncb_mag_bomb_gbu12_1_refill : 2Rnd_GBU12_LGB {
		count = 1;
		descriptionshort = "Type : Laser guided bomb<br />Rounds : 1<br />Used in : Vehicles";
		displayname = "GBU-12 bomb";
		ncb_refill = 1;
		ncb_refillclass = "bombgbu12";
		mass = 30;
		model = "\A3\Weapons_F\Ammo\Bomb_01_F";
		scope = 2;
	};
	class 2Rnd_Mk82 : VehicleMagazine {
		descriptionshort = "Type : Bomb<br />Rounds : 2<br />Used in : Vehicles";
		picture = "\nocebo\images\vehicle_ammo\bomb.paa";
		ncb_refillclass = "bombmk82";
	};
	class 4Rnd_Bomb_04_F;
	class 2Rnd_Bomb_03_F : 4Rnd_Bomb_04_F {
		descriptionshort = "Type : LOM-250G bomb<br />Rounds : 2<br />Used in : Vehicles";
		displayname = "2 x LOM-250G bomb";
		picture = "\nocebo\images\vehicle_ammo\bomb.paa";
		ncb_refillclass = "bomblom250g";
	};
	class ncb_mag_bomb_lom_250g_1_refill : 2Rnd_Bomb_03_F {
		count = 1;
		descriptionshort = "Type : LOM-250G bomb<br />Rounds : 1<br />Used in : Vehicles";
		displayname = "LOM-250G bomb";
		ncb_refill = 1;
		ncb_refillclass = "bomblom250g";
		mass = 30;
		model = "\A3\Weapons_F_EPC\Ammo\Bomb_03_F.p3d";
		scope = 2;
	};

	// MISC

	class HandGrenade;
	class SmokeShell : HandGrenade {
		class ItemActions {
			class Select {
				text = "Select charge";
				script = "call horde_fnc_selectCharge";
			};
		};
	};

	class StickyCharge_Remote_Mag : CA_Magazine {
		ammo = "DemoCharge_Remote_Ammo_Scripted";
		author = "Das Attorney";
		count = 1;
		descriptionShort = "Type : Charge<br />Rounds : 1<br />Used on : Ground, Vehicles";
		displayname = "Sticky Charge";
		mass = 20;
		model = "\A3\Weapons_F\Explosives\c4_charge_small";
		picture = "\A3\Weapons_F\Data\UI\gear_c4_charge_small_CA.paa";
		scope = 2;
		class ItemActions {
			class Select {
				text = "Select charge";
				script = "call horde_fnc_selectCharge";
			};
		};
	};
	class BreachingCharge_Remote_Mag : StickyCharge_Remote_Mag {
		ammo = "BreachingCharge_Remote_Ammo_Scripted";
		descriptionshort = "Type : Charge<br />Rounds : 1<br />Used on doors";
		displayname = "Breaching Charge";
		mass = 7;
		model = "\A3\Weapons_F\explosives\mine_AP_bouncing_i";
		picture = "\A3\Weapons_F\Data\UI\gear_mine_AP_bouncing_CA.paa";
		scope = 2;
		class ItemActions {
			class Select {
				text = "Select charge";
				script = "call horde_fnc_selectCharge";
			};
		};
		class Library {
			libtextdesc = "A shaped charge to breach doors. It can be set to detonate // by remote detonator.";
		};
	};

	class RPG7_F;
	class RPG7_F_topAttack : RPG7_F {
		author = "Das Attorney";
		displayName = "PG-7TA HEAT Grenade";
		displaynameshort = "AT Top Attack";
		descriptionShort = "Type: Anti-Tank Grenade<br />Rounds: 1<br />Used in: RPG-7<br />Top attack";
		ncb_attackType = 1;
	};
	class RPG32_F;
	class RPG32_F_topAttack : RPG32_F {
		author = "Das Attorney";
		displayName = "RPG-42TA Rocket";
		displaynameshort = "AT Top Attack";
		descriptionShort = "Type: RPG-42 rocket<br />Rounds: 1<br />Used in: RPG-42<br />Top attack";
		ncb_attackType = 1;
	};

	class ItemSupply_Base : CA_Magazine {
		author = "Das Attorney";
		mass = 1;
		picture = "\A3\Weapons_F\Data\UI\gear_item_watch_ca.paa";
		scope = 1;
	};
	class ItemJerryCan_TEST : ItemSupply_Base {
		ammo = "FakeAmmo";
		count = 20;
		descriptionshort = "Used to refuel vehicles.";
		displayname = "Jerry Can (TEST VERSION)";
		horde_actionSound = "";
		horde_inventorySound = "horde_sound_jerryCanInventory";
		mass = 100;
		model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
		ncb_objectClass = "Land_CanisterFuel_F";
		picture = "\nocebo\images\jerry_can.paa";
		scope = 2;
	};
};