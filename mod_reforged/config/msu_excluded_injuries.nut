::Const.Injury.ExcludedInjuries.add(
	"RF_Undead",
	[
		// Blunt
		"injury.rf_black_eye",
		"injury.broken_nose",
		"injury.broken_ribs",
		"injury.bruised_leg",
		"injury.crushed_windpipe",
		"injury.fractured_ribs",
		"injury.severe_concussion",
		// Burning
		"injury.rf_heat_stroke",
		"injury.inhaled_flames",
		// Cutting
		"injury.cut_artery",
		"injury.cut_throat",
		"injury.exposed_ribs",
		"injury.grazed_neck",
		"injury.ripped_ear",
		"injury.split_nose",
		// Piercing
		"injury.grazed_kidney",
		"injury.pierced_cheek",
		"injury.pierced_lung",
		"injury.pierced_side"
	]
);

::Const.Injury.ExcludedInjuries.add(
	"RF_Skeleton",
	[
		// Blunt
		"injury.rf_dislocated_jaw",
		"injury.sprained_ankle",
		// Burning
		"injury.burnt_face",
		"injury.burnt_legs",
		"injury.burnt_hands",
		// Cutting
		"injury.cut_achilles_tendon",
		"injury.cut_arm_sinew",
		"injury.cut_leg_muscles",
		"injury.deep_abdominal_cut",
		"injury.deep_chest_cut",
		// Piercing
		"injury.pierced_arm_muscles",
		"injury.pierced_chest",
		"injury.pierced_leg_muscles",
		"injury.stabbed_guts"
	],
	[
		::Const.Injury.ExcludedInjuries.RF_Undead
	]
);
