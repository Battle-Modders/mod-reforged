::Reforged.HooksMod.hook("scripts/skills/actives/reload_bolt", function(q) {
	q.onItemSet = @(__original) { function onItemSet()
	{
		__original();

		local skills = this.getItem().getSkills();
		if (skills.len() != 0)
		{
			// Players expect this skill to come earlier than most other active skills because of muscle memory,
			// so we move it forward to be immediately after the shoot skill (assuming shoot is the first skill of the weapon).
			// We have to do this in this function instead of create because this skill is added/removed during use of
			// shoot/reload skills directly from the actor.
			this.setOrder(skills[0].m.Order + 1);
		}
	}}.onItemSet;
});
