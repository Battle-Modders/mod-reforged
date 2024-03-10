::Reforged.HooksMod.hook("scripts/skills/perks/perk_fearsome", function(q) {
	q.m.ThreatBonusFraction <- 0.2;		// This percentage of Resolve is added as ThreatOnHit

	q.onAfterUpdate = @() function( _properties )	// we replace the vanilla calculation completely
	{
		_properties.ThreatOnHit += this.getThreatBonus(_properties);
	}

// New Functions
	q.getThreatBonus <- function(_properties)
	{
		return ::Math.max(0, _properties.getBravery() * this.m.ThreatBonusFraction);	// This bonus can never be negative
	}
});
