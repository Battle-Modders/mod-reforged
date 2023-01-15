::Reforged.Reach <- {
	BonusPerReach = 5,
	Default = {
		Goblin = 1,
		Human = 2,
		Orc = 3,
		Dagger = 1,
		Short_1H = 2,
		Medium_1H = 3,
		Long_1H = 4,
		Short_2H = 5,
		Medium_2H = 6,
		Long_2H = 7
	},

	function hasLineOfSight( _actor1, _actor2 )
	{
		if (!_actor1.isPlacedOnMap() || !_actor2.isPlacedOnMap()) return false;

		local tile1 = _actor1.getTile();
		local tile2 = _actor2.getTile();

		if (tile1.getDistanceTo(tile2) > 1)
		{
			local dir = tile1.getDirectionTo(tile2);
			if (!tile1.hasNextTile(dir) || !tile1.getNextTile(dir).IsEmpty)
				return false;

			dir = tile2.getDirectionTo(tile1);
			if (!tile2.hasNextTile(dir) || !tile2.getNextTile(dir).IsEmpty)
				return false;
		}

		return true;
	}
}
