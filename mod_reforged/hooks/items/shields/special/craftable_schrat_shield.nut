::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_schrat_shield", function(q) {
	q.m.SpawnSaplingConditionThreshold <- 125;
	q.m.SpawnSaplingConditionLoss <- 50;

	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.ReachIgnore = 3;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When hit while having at least " + ::MSU.Text.colorPositive(this.m.SpawnSaplingConditionThreshold) + " durability, spawns a small " + ::Const.Strings.EntityName[::Const.EntityType.Schrat] + " on an adjacent tile, losing " + ::MSU.Text.colorNegative(this.m.SpawnSaplingConditionLoss) + " points of durability. Does not work during your turn."
		});
		return ret;
	}

	q.onShieldHit = @() function( _attacker, _skill )
	{
		if (!::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) && this.getCondition() >= this.m.SpawnSaplingConditionThreshold && this.getCondition() > this.m.SpawnSaplingConditionLoss)
		{
			this.spawnSapling();
		}
	}

// New functions
	q.spawnSapling <- function()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local myTile = actor.getTile();
		local neighboringTiles = ::MSU.Tile.getNeighbors(myTile).filter(@(_, _t) _t.IsEmpty && ::Math.abs(myTile.Level - _t.Level) <= 1);

		if (neighboringTiles.len() != 0)
		{
			local sapling = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/schrat_small", ::MSU.Array.rand(neighboringTiles).Coords);
			sapling.setFaction(actor.isPlayerControlled() ? ::Const.Faction.PlayerAnimals : actor.getFaction());
			sapling.m.ConfidentMoraleBrush = "icon_confident";
			sapling.riseFromGround();
			this.setCondition(::Math.max(0, this.getCondition() - this.m.SpawnSaplingConditionLoss));
		}
	}
});
