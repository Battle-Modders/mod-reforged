::Reforged.HooksMod.hook("scripts/skills/backgrounds/swordmaster_background", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Excluded.extend([
			"trait.asthmatic",
			"trait.cocky"
		]);

		this.m.ExcludedTalents.push(::Const.Attributes.RangedDefense);

		this.m.HiringCost = 2400; // vanilla 400
		this.m.DailyCost = 45; // vanilla 35
	}}.create;

	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
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
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
				return 1; // We only want this background to have the Sword perk group

			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_gifted":
			case "pg.special.rf_fencer":
				return -1;

			case "pg.rf_agile":
			case "pg.rf_fast":
				return 0.5;

			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 0.25;

			case "pg.rf_tactician":
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
			text = ::Reforged.Mod.Tooltips.parseString("Has the [Sword Mastery|Perk+perk_mastery_sword] perk permanently for free")
		});
		return ret;
	}}.getTooltip;

	q.onAdded = @(__original) { function onAdded()
	{
		if (this.m.IsNew)
		{
			this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_mastery_sword", function(o) {
				o.m.IsRefundable = false;
			}));
		}
		return __original();
	}}.onAdded;

	q.onBuildPerkTree = @() { function onBuildPerkTree()
	{
		local perkTree = this.getContainer().getActor().getPerkTree();
		if (perkTree.hasPerk("perk.rf_professional"))
		{
			perkTree.removePerk("perk.rf_professional");
		}
	}}.onBuildPerkTree;
});
