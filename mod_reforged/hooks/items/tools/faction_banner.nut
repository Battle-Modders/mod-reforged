::Reforged.HooksMod.hook("scripts/items/tools/faction_banner", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 6;
	}}.create;

	q.onCombatStarted = @() { function onCombatStarted()
	{
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			ally.getSkills().add(::new("scripts/skills/effects/rf_faction_banner_effect"));
		}
	}}.onCombatStarted;
});
