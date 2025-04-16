::Reforged.HooksMod.hook("scripts/skills/backgrounds/regent_in_absentia_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
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

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID, _perkTree) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 20;

			case "pg.rf_tactician":
			case "pg.rf_heavy_armor":
				return 3;

			case "pg.rf_trained":
				return 5;
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
			this.getContainer().getActor().getPerkTree().addPerkGroup("pg.rf_noble");
			this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_rf_family_pride", function(o) {
				o.m.IsRefundable = false;
			}));
		}
		__original();
	}
});
