::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_schrat_shield", function(q) {
	q.m.SpawnSaplingConditionThreshold <- 125;
	q.m.SpawnSaplingConditionLoss <- 50;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.ReachIgnore = 3;
	}}.create;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("When hit while it is not your [turn|Concept.Turn] and having at least " + ::MSU.Text.colorPositive(this.m.SpawnSaplingConditionThreshold) + " durability, spawns a small " + ::Const.Strings.EntityName[::Const.EntityType.Schrat] + " on an adjacent tile, losing " + ::MSU.Text.colorNegative(this.m.SpawnSaplingConditionLoss) + " points of durability")
		});
		return ret;
	}}.getTooltip;

	q.onShieldHit = @() { function onShieldHit( _attacker, _skill )
	{
		if (!_skill.isRanged() && !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) && this.getCondition() >= this.m.SpawnSaplingConditionThreshold && this.getCondition() > this.m.SpawnSaplingConditionLoss)
		{
			this.spawnSapling();
		}
	}}.onShieldHit;

// New functions
	q.spawnSapling <- { function spawnSapling()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local myTile = actor.getTile();
		local neighboringTiles = ::MSU.Tile.getNeighbors(myTile).filter(@(_, _t) _t.IsEmpty && ::Math.abs(myTile.Level - _t.Level) <= 1);

		if (neighboringTiles.len() != 0)
		{
			local sapling = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/rf_schrat_small_from_shield", ::MSU.Array.rand(neighboringTiles).Coords);
			sapling.setFaction(actor.isPlayerControlled() ? ::Const.Faction.PlayerAnimals : actor.getFaction());
			sapling.m.ConfidentMoraleBrush = "icon_confident";
			sapling.riseFromGround();
			this.setCondition(::Math.max(0, this.m.Condition - this.m.SpawnSaplingConditionLoss));	// We don't use getCondition because that returns a rounded value, causing us to lose decimal places
		}
	}}.spawnSapling;
});
