::Reforged.HooksMod.hook("scripts/factions/faction_manager", function (q) {
	q.RF_createDraugr <- { function RF_createDraugr()
	{
		local f = ::new("scripts/factions/rf_draugr_faction");
		f.setID(this.m.Factions.len());
		f.setName("Barrowkin");
		f.setDiscovered(true);
		f.addTrait(::Const.FactionTrait.RF_Draugr);
		this.m.Factions.push(f);
	}}.RF_createDraugr;
	
	q.RF_createBeckoned <- { function RF_createBeckoned()
	{
		local f = ::new("scripts/factions/rf_beckoned_faction");
		f.setID(this.m.Factions.len());
		f.setName("Beckoned");
		f.setDiscovered(true);
		this.m.Factions.push(f);
	}}.RF_createBeckoned;

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
		this.RF_createBeckoned();
		__original();
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == ::Const.FactionType.RF_Beckoned)
			{
				for( local j = 0; j < this.m.Factions.len(); j = ++j )
				{
					if (this.m.Factions[j] != null)
					{
						this.m.Factions[i].addAlly(j);
					}
				}
				this.m.Factions[i].updatePlayerRelation();
			}
			else
			{
				for( local j = 0; j < this.m.Factions.len(); j = ++j )
				{
					if (this.m.Factions[j] == null)
						continue;
					if (this.m.Factions[j].getType() == ::Const.FactionType.RF_Beckoned)
					{
						this.m.Factions[i].addAlly(j);
					}
				}
			}
		}
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
