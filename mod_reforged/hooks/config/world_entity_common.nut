// Add functionality to allow using more vars in troop names e.g. for champions
::Const.World.Common.RF_getTroopNameTemplateVars <- function( _troop )
{
	local ret = [];
	local faction = ::World.FactionManager.getFaction(_troop.Faction);
	if (faction != null)
	{
		ret.push([
			"factionname",
			faction.getName()
		]);
	}

	return ret;
}

// Add functionality to allow using more vars in troop names e.g. for champions
local addTroop = ::Const.World.Common.addTroop;
::Const.World.Common.addTroop = function( _party, _troop, _updateStrength = true, _minibossify = 0 )
{
	local ret = addTroop(_party, _troop, _updateStrength, _minibossify);
	if (ret.Name != "")
		ret.Name = ::buildTextFromTemplate(ret.Name, this.RF_getTroopNameTemplateVars(ret));
	return ret;
}

// Add functionality to allow using more vars in troop names e.g. for champions
local addUnitsToCombat = ::Const.World.Common.addUnitsToCombat;
::Const.World.Common.addUnitsToCombat = function( _into, _partyList, _resources, _faction, _minibossify = 0 )
{
	local ret = addUnitsToCombat(_into, _partyList, _resources, _faction, _minibossify);
	foreach (unit in _into)
	{
		// There are certain cases in vanilla where unit.Name doesn't exist
		// for example the knights added directly to the battle in decisive_battle_contract
		if (("Name" in unit) && unit.Name != "")
			unit.Name = ::buildTextFromTemplate(unit.Name, this.RF_getTroopNameTemplateVars(unit));
	}
	return ret;
}
