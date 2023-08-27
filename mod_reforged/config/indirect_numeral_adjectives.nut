::Reforged.Numerals <- {
	// Config
	ExactPartySize = false,
	ExactDialogSize = false,
	PartyRange = false,
	DialogRange = true

	// Data
	IndefiniteNumerals = [],

	function register( _name, _startsAt, _suffix = "" )
	{
		::Reforged.Numerals.IndefiniteNumerals.push({
			Name = _name,
			StartsAt = _startsAt,
			Suffix = _suffix,
			Range = ""
		});
	}

	function setExactPartySize( _bool )
	{
		this.ExactPartySize = _bool;
		this.updateAllParties();
	}

	function setPartyRange( _bool )
	{
		this.PartyRange = _bool;
		this.updateAllParties();
	}


	// This always needs to be called after all new numerals of your mod are registered.
	// This will sort all Numerals and generate their ranges automatically
	function calculateRanges()
	{
		this.IndefiniteNumerals.sort(@(a, b) a.StartsAt <=> b.StartsAt);

		local minAmount = 1;
		local maxAmount = 1;

		for (local i = 1; i < this.IndefiniteNumerals.len(); i++)
		{
			maxAmount = (this.IndefiniteNumerals[i].StartsAt - 1);
			if (minAmount != maxAmount || minAmount != 1)	// We hard-code that the (1) for One would never displayed
			{
				this.IndefiniteNumerals[i - 1].Range = "" + minAmount;
				if (minAmount != maxAmount) this.IndefiniteNumerals[i - 1].Range += "-" + maxAmount;
			}
			minAmount = maxAmount + 1;
		}
		this.IndefiniteNumerals.top().Range = minAmount + "+";
	}

	function getNumeralString( _amount, _isWorldParty )
	{
		if (this.IndefiniteNumerals.len() == 0) return _amount;
		if (this.ExactPartySize && _isWorldParty) return _amount;
		if (this.ExactDialogSize && !_isWorldParty) return _amount;

		local numeralEntry = this.getNumeralEntryByAmount(_amount);

		local numeralString = numeralEntry.Name;
		if (!_isWorldParty) numeralString += numeralEntry.Suffix;
		if (this.PartyRange && _isWorldParty || this.DialogRange && !_isWorldParty)
		{
			if (numeralEntry.Range != "") numeralString += " (" + numeralEntry.Range + ")";
		}
		return numeralString;
	}

	// Can be used by other mods to adjust individuell entries
	function getNumeralEntryByName( _name )
	{
		foreach (numeral in this.IndefiniteNumerals)
		{
			if (numeral.Name == _namet) return numeral;
		}
		return null;
	}

	// Private
	function updateAllParties()
	{
		// I don't know how else to get "every entity on the world map"
		foreach (worldParty in ::World.getAllEntitiesAtPos(::World.State.m.Player.getPos(), 150000.0))
		{
			worldParty.updateStrength();
		}
	}

	// Returns an indirect numeral, given an _amount. This requires 'this.IndefiniteNumerals' to be sorted
	function getNumeralEntryByAmount( _amount )
	{
		local arrayPosition = -1;   // Somewhere the integer needs to be translated into an array position (decrementing by 1) so why not here
		foreach (numeral in this.IndefiniteNumerals)
		{
			if (_amount < numeral.StartsAt) break;		// This should never happen for the first entry
			++arrayPosition;
		}
		arrayPosition = ::Math.min(arrayPosition, this.IndefiniteNumerals.len() - 1);
		return this.IndefiniteNumerals[arrayPosition];
	}
}

::Reforged.Numerals.register("Dozens", 		22, " of");
::Reforged.Numerals.register("A plethora", 	38, " of");
::Reforged.Numerals.register("An army", 	70, " of");
::Reforged.Numerals.register("One", 		0, 	"");
::Reforged.Numerals.register("A few", 		2);
::Reforged.Numerals.register("Some", 		4);
::Reforged.Numerals.register("Several", 	7);
::Reforged.Numerals.register("Many", 		11);
::Reforged.Numerals.register("Lots", 		16, " of");
::Reforged.Numerals.calculateRanges();

::mods_hookBaseClass("entity/world/world_entity", function(o)
{
	o = o[o.SuperName];

	// For world parties
	local oldUpdateStrength = o.updateStrength;
	o.updateStrength = function()
	{
		oldUpdateStrength();

		if (!this.isAlive()) return;	// Included just for safety reasons because it is also part of the original function

		if (!this.hasLabel("name")) return;
		if (this.isPlayerControlled()) return;
		if (this.m.Troops.len() == 0) return;
		if (!this.m.IsShowingStrength) return;

		this.getLabel("name").Text = this.getName() + " (" + ::Reforged.Numerals.getNumeralString(this.m.Troops.len(), true) + ")";
	}

	// For the tooltip of world entities
	local oldGetTroopComposition = o.getTroopComposition;
	o.getTroopComposition = function()
	{
		local newText = "PLACEHOLDER";

		local oldMinf = ::Math.minf;
		::Math.minf = function(_first, _second)
		{
			local ret = oldMinf(_first, _second);
			local originalEnemyNumber = ::Math.round(_second * 14.0);	// the 14.0 is hard-coded and needs to be adjusted if vanilla changes it
			newText = ::Reforged.Numerals.getNumeralString(originalEnemyNumber, false);
			return ret;
		}

		local oldMax = ::Math.max;
		::Math.max = function(_first, _second)
		{
			local ret = oldMax(_first, _second);
			::Const.Strings.EngageEnemyNumbers[ret] = newText;
			return ret;
		}

		local ret = oldGetTroopComposition();

		::Math.max = oldMax;
		::Math.minf = oldMinf;

		return ret;
	}
});

// For Combat Dialogs
::mods_hookExactClass("states/world_state", function(o)
{
    local oldShowCombatDialog = o.showCombatDialog;
    o.showCombatDialog = function( _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true, _properties = null, _pos = null )
    {
		local newText = "PLACEHOLDER";

		local oldMinf = ::Math.minf;
		::Math.minf = function(_first, _second)
		{
			local ret = oldMinf(_first, _second);
			local originalEnemyNumber = ::Math.round(_second * 14.0);	// the 14.0 is hard-coded and needs to be adjusted if vanilla changes it
			newText = ::Reforged.Numerals.getNumeralString(originalEnemyNumber, false);
			return ret;
		}

		local oldMax = ::Math.max;
		::Math.max = function(_first, _second)
		{
			local ret = oldMax(_first, _second);
			::Const.Strings.EngageEnemyNumbers[ret] = newText;
			return ret;
		}

		local ret = oldShowCombatDialog(_isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking, _properties, _pos);

		::Math.max = oldMax;
		::Math.minf = oldMinf;

		return ret;
    }
});
