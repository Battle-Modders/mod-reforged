::Reforged.PerkGroups.Swordmaster <- class extends ::DynamicPerks.Class.PerkGroup
{
	constructor()
	{
		this.ID = "pg.rf_swordmaster";
		this.Name = "Swordmaster";
		this.Icon = "ui/perk_groups/rf_swordmaster.png";
		this.FlavorText = [
			"is a masterful swordsman",
			"is a renowned swordmaster",
			"is a master of the sword"
		];
		this.Tree = [
			[],
			[],
			[],
				[
					"perk.rf_swordmaster_blade_dancer",
					"perk.rf_swordmaster_metzger",
					"perk.rf_swordmaster_juggernaut",
					"perk.rf_swordmaster_versatile_swordsman",
					"perk.rf_swordmaster_precise",
					"perk.rf_swordmaster_grappler",
					"perk.rf_swordmaster_reaper",
				],
			[],
			[],
			[]
		];
		this.PerkTreeMultipliers = {
			"pg.rf_sword": -1,
			"pg.rf_ranged": 0
		};
	}
};
