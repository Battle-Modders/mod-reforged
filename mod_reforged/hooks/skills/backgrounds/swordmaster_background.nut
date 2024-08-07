::Reforged.HooksMod.hook("scripts/skills/backgrounds/swordmaster_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.rf_tough": 0.25,
			"pg.rf_vigorous": 0.25,
			"pg.rf_tactician": 2,

			"pg.special.rf_professional": 0,
			"pg.special.rf_fencer": -1
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier",
					"pg.rf_swordmaster"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_sword"
				],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_shield",
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

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
				return 1; // We only want this background to have the Sword perk group

			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Has the [Sword Mastery|Perk+perk_mastery_sword] perk permanently for free")
		});
		return ret;
	}

	q.onAdded = @(__original) function()
	{
		if (this.m.IsNew)
		{
			this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_mastery_sword", function(o) {
				o.m.IsRefundable = false;
			}));
		}
		return __original();
	}
});
