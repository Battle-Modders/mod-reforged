::Reforged.HooksMod.hook("scripts/skills/backgrounds/hedge_knight_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_shield"
				]
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
				return _collection.getMin() + 2;

			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID, _perkTree) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
			case "pg.special.rf_leadership":
			case "pg.rf_tactician":
			case "pg.rf_dagger":
				return 0;

			case "pg.rf_polearm":
				return 0.25;

			case "pg.rf_spear":
				return 0.2;

			case "pg.rf_sword":
				return 0.9;

			case "pg.special.rf_man_of_steel":
				return -1;
		}
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Has access to the [Lone Wolf|Perk+perk_lone_wolf] [perk|Concept.Perk] at tier 1 of the perk tree")
		});
		return ret;
	}

	q.onBuildPerkTree <- function()
	{
		local perkTree = this.getContainer().getActor().getPerkTree();
		if (perkTree.hasPerk("perk.lone_wolf"))
		{
			perkTree.removePerk("perk.lone_wolf");
		}
		perkTree.addPerk("perk.lone_wolf", 1);
	}
});
