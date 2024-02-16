::Reforged.HooksMod.hook("scripts/factions/faction_manager", function (q) {
	q.createNobleHouses = @(__original) function()
	{
		// Switcheroo to allow the castle helmet faction to also appear
		local oldMathRand = ::Math.rand;
		::Math.rand = function( _min, _max )
		{
			if (_min == 2 && _max == 10) _min = 1;	// In vanilla only noble faction layouts 2 - 10 are considered. 1 is skipped. We fix that here.

			return oldMathRand(_min, _max);
		}

		local ret = __original();

		// Revert Switcheroo
		::Math.rand = oldMathRand;

		return ret;
	}
});
