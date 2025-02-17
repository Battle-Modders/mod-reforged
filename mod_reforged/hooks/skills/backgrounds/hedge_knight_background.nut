::Reforged.HooksMod.hook("scripts/skills/backgrounds/hedge_knight_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0,
			"pg.rf_fast": 0,
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_dagger": 0,
			"pg.rf_polearm": 0.25,
			"pg.rf_spear": 0.2,

			"pg.special.rf_man_of_steel": -1
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeOnly);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
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
