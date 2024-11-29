::Reforged.HooksMod.hook("scripts/items/tools/faction_banner", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.Reach = 6;
	}

	q.onCombatStarted <- function()
	{
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			ally.getSkills().add(::new("scripts/skills/effects/rf_faction_banner_effect"));
		}
	}
});
