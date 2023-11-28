// Add functionality to allow using %factionname% in champion names which is to be replaced by that character's faction's name
::Const.World.Common.RF_generateName <- function( _string, _faction )
{
	return ::String.replace(_string, "%factionname%", ::World.FactionManager.getFaction(_faction).getName());
}

// Add functionality to allow using %factionname% in entity names which is to be replaced by that character's faction's name
local addTroop = ::Const.World.Common.addTroop;
::Const.World.Common.addTroop = function( _party, _troop, _updateStrength = true, _minibossify = 0 )
{
    local ret = addTroop(_party, _troop, _updateStrength, _minibossify);
    ret.Name = this.RF_generateName(ret.Name, ret.Faction);
    return ret;
}

// Add functionality to allow using %factionname% in entity names which is to be replaced by that character's faction's name
local addUnitsToCombat = ::Const.World.Common.addUnitsToCombat;
::Const.World.Common.addUnitsToCombat = function( _into, _partyList, _resources, _faction, _minibossify = 0 )
{
	local ret = addUnitsToCombat(_into, _partyList, _resources, _faction, _minibossify);
	foreach (unit in _into)
	{
		unit.Name = this.RF_generateName(unit.Name, unit.Faction);
	}
	return ret;
}
