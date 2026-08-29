::Reforged.HooksMod.hook("scripts/skills/backgrounds/executioner_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_axe",
					"pg.rf_sword"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
				return _collection.getMin() + 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID, _perkTree) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.rf_vicious":
			case "pg.rf_unstoppable":
			case "pg.rf_cleaver":
				return 2;
		}
	}}.getPerkGroupMultiplier;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Has the [$ $|Perk+perk_coup_de_grace] perk permanently for free")
		});
		return ret;
	}}.getTooltip;

	q.onAdded = @(__original) { function onAdded()
	{
		if (this.m.IsNew)
		{
			this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_coup_de_grace", function(o) {
				o.m.IsRefundable = false;
			}));

			local perkTree = this.getContainer().getActor().getPerkTree();
			if (!perkTree.hasPerk("perk.coup_de_grace"))
			{
				perkTree.addPerk("perk.coup_de_grace", 2)
			}
		}
		return __original();
	}}.onAdded;
});
