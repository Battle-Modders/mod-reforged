::Reforged.HooksMod.hook("scripts/skills/perks/perk_footwork", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::new("scripts/skills/actives/rf_sprint_skill"));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("actives.rf_sprint");
	}
});
