::mods_hookExactClass("skills/actives/hook", function(o) {

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function( _properties )
	{
		local oldActionPointCost = this.m.ActionPointCost;
		onAfterUpdate(_properties);
		this.m.ActionPointCost = oldActionPointCost;	// Revert any AP changes made by vanilla, Polearm Mastery no longer reduces that cost

		this.m.IsShieldRelevant = !_properties.IsSpecializedInPolearms;		// New effect from Polearm Mastery
	}

});
