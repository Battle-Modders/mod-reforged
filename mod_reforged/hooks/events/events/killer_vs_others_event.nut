::Reforged.HooksMod.hook("scripts/events/events/killer_vs_others_event", function(q) {
	q.onUpdateScore = @(__original) { function onUpdateScore()
	{
		__original();
		// Prevent avatar from being chosen in this event.
		if (this.m.Score != 0 && this.m.Killer.getFlags().has("IsPlayerCharacter"))
		{
			this.clear();
			return;
		}
	}}.onUpdateScore;
});
