::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_sword", function(q) {
	q.onAdded = @(__original) function()
	{
		__original()
		this.getContainer().add(::new("scripts/skills/actives/rf_passing_step_skill"));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("actives.rf_passing_step");
	}
});
