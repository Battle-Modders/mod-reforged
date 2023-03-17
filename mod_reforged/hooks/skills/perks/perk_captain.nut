::mods_hookExactClass("skills/perks/perk_captain", function(o) {
	o.onCombatStarted <- function()		// overwrite of base skill function
    {
		local allies = ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		foreach (ally in allies)
		{
			ally.getSkills().add(::new("scripts/skills/effects/captain_effect"));
		}
    }
});
