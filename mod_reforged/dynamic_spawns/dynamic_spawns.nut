::Reforged.QueueBucket.AfterHooks.push(function() {
	foreach (def in ::Reforged.Spawns.Parties)
	{
		::DynamicSpawns.Public.registerParty(def);
	}

	foreach (def in ::Reforged.Spawns.UnitBlocks)
	{
		::DynamicSpawns.Public.registerUnitBlock(def);
	}

	foreach (def in ::Reforged.Spawns.Units)
	{
		if (!("Cost" in def))
			def.Cost <- ::Const.World.Spawn.Troops[def.Troop].Cost;
		::DynamicSpawns.Public.registerUnit(def);
	}

	delete ::Reforged.Spawns;
});
