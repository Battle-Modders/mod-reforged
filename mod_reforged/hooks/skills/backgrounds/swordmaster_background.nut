::mods_hookExactClass("skills/backgrounds/swordmaster_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_devious": 0,
			"pg.rf_fast": 0.5,
			"pg.rf_large": 0.25,
			"pg.rf_leadership": 15,
			"pg.rf_resilient": 1.5,
			"pg.rf_sturdy": 0.25,
			"pg.rf_tactician": 2,
			"pg.rf_talented": 0,

            "pg.special.rf_professional": -1
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_soldier",
				"pg.rf_swordmaster"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [
				"pg.rf_sword"
			],
			"pgc.rf_armor": [
				"pg.rf_medium_armor"
			],
			"pgc.rf_fighting_style": [
				"pg.rf_power",
				"pg.rf_swift"
			]
		});
	}

	o.onBuildPerkTree <- function()
	{
		local perkTree = this.getPerkTree();
		local masteryPerks = [
			"perk.mastery.axe",
			"perk.mastery.bow",
			"perk.mastery.cleaver",
			"perk.mastery.crossbow",
			"perk.mastery.dagger",
			"perk.mastery.flail",
			"perk.mastery.hammer",
			"perk.mastery.mace",
			"perk.mastery.polearm",
			"perk.mastery.spear",
			"perk.mastery.throwing",
		];
		foreach (perk in masteryPerks)
		{
			if (perkTree.hasPerk(perk)) perkTree.removePerk(perk);
		}
	}
});
