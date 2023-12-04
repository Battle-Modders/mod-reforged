::Reforged.HooksMod.hook("scripts/skills/backgrounds/swordmaster_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
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
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_throwing": 0,
			"pg.rf_ranged": 0

            "pg.special.rf_fencer": -1
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier",
					"pg.rf_swordmaster",
					::MSU.Class.WeightedContainer([
	                    [10, "pg.special.rf_professional"],
	                    [90, "DynamicPerks_NoPerkGroup"]
	                ])
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
			}
		});

		this.m.Excluded.extend([
		    "trait.asthmatic",
		    "trait.cocky"
		]);

		this.m.ExcludedTalents.push(::Const.Attributes.RangedDefense);
	}

	q.onAdded = @(__original) function()
	{
		if (this.m.IsNew)
		{
			this.getContainer().add(::new("scripts/skills/effects/rf_swordmasters_finesse_effect"));
			this.getContainer().add(::MSU.new("scripts/skills/perks/perk_mastery_sword", function(o) {
				o.m.IsRefundable = false;
			}));
		}
		return __original();
	}

	q.onBuildPerkTree <- function()
	{
		local perkTree = this.getContainer().getActor().getPerkTree();
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
