::Reforged.HooksMod.hook("scripts/skills/backgrounds/regent_in_absentia_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 20,
			"pg.rf_tactician": 3,
			"pg.rf_trained": 5,
			"pg.rf_heavy_armor": 3
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeOnly);
		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_noble"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
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
			text = ::Reforged.Mod.Tooltips.parseString("Has the [Family Pride|Perk+perk_rf_family_pride] perk permanently for free")
		});
		return ret;
	}

	q.onAdded = @(__original) function()
	{
		if (this.m.IsNew)
		{
			this.getPerkTree().addPerkGroup("pg.rf_noble");
			this.getSkills().add(::Reforged.new("scripts/skills/perks/perk_rf_family_pride", function(o) {
				o.m.IsRefundable = false;
			}));
		}
		__original();
	}
});
