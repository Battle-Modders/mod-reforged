::Reforged.Reach <- {
	BonusPerReach = 5,
	Default = {
		Goblin = 1,
		Human = 2,
		Orc = 3,

		BeastSmall = 3,
		BeastMedium = 5,
		BeastLarge = 7,
		BeastHuge = 9,
		BeastEnormous = 11,
		BeastGargantuan 13,

		Dagger = 1,
		Short_1H = 2,
		Medium_1H = 3,
		Long_1H = 4,
		Short_2H = 5,
		Medium_2H = 6,
		Long_2H = 7
	},
	WeaponTypeDefault = {
		Axe = 3,
		Bow = 0,
		Cleaver = 4,
		Crossbow = 0,
		Dagger = 1,
		Firearm = 0,
		Flail = 4,
		Hammer = 3,
		Mace = 3,
		Polearm = 7,
		Spear = 5,
		Sword = 4
		Throwing = 0
	},

	function hasLineOfSight( _actor1, _actor2 )
	{
		if (!_actor1.isPlacedOnMap() || !_actor2.isPlacedOnMap()) return false;

		local tile1 = _actor1.getTile();
		local tile2 = _actor2.getTile();
		local distance = tile1.getDistanceTo(tile2);

		if (distance > 2) return false;

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
