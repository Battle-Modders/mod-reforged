::mods_hookExactClass("items/tools/player_banner", function(o) {
	o.onCombatStarted <- function()		// overwrite of base item function
    {
		local allies = ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		foreach (ally in allies)
		{
			ally.getSkills().add(::new("scripts/skills/effects/battle_standard_effect"));
		}
    }
});
