::Reforged.HooksMod.hook("scripts/factions/faction_manager", function (q) {
	q.RF_createDraugr <- { function RF_createDraugr()
	{
		local f = ::new("scripts/factions/rf_draugr_faction");
		f.setID(this.m.Factions.len());
		f.setName("Draugr");
		f.setDiscovered(true);
		f.addTrait(::Const.FactionTrait.RF_Draugr);
		this.m.Factions.push(f);
	}}.RF_createDraugr;

	q.createNobleHouses = @(__original) { function createNobleHouses()
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
	}}.createNobleHouses;

	q.createAlliances = @(__original) { function createAlliances()
	{
		this.RF_createDraugr();

		__original();

		local zombies = this.getFactionOfType(::Const.FactionType.Zombies);
		local undead = this.getFactionOfType(::Const.FactionType.Undead);
		local draugr = this.getFactionOfType(::Const.FactionType.RF_Draugr);

		zombies.addAlly(draugr.getID());
		undead.addAlly(draugr.getID());
		draugr.addAlly(zombies.getID());
		draugr.addAlly(undead.getID());
	}}.createAlliances;

	q.runSimulation = @(__original) { function runSimulation()
	{
		local draugr = this.getFactionOfType(::Const.FactionType.RF_Draugr);
		local ping = this.__ping;
		this.__ping = function()
		{
			draugr.update(true, true);
			ping();
		}
		__original();
		this.__ping = ping;
	}}.runSimulation;
});
