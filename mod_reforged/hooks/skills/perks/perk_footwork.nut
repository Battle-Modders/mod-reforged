::Reforged.HooksMod.hook("scripts/skills/perks/perk_footwork", function(q) {
	q.onAdded = @(__original) { function onAdded()
	{
		__original();
		this.getContainer().add(::new("scripts/skills/actives/rf_sprint_skill"));
	}}.onAdded;

	q.onRemoved = @(__original) { function onRemoved()
	{
		__original();
		this.getContainer().removeByID("actives.rf_sprint");
	}}.onRemoved;
});
