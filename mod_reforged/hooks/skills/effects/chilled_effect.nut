::Reforged.HooksMod.hook("scripts/skills/effects/chilled_effect", function(q) {
	q.onAdded = @(__original) { function onAdded()
	{
		local actor = this.getContainer().getActor();
		// TODO: Better to do this via a skill_container.onAnySkillAdded event
		local warmth = actor.getSkills().getSkillByID("effects.rf_warmth_potion");
		if (warmth != null)
		{
			this.removeSelf();
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " resists being chilled thanks to " + warmth.getName());
			return;
		}

		__original();
	}}.onAdded;
});
