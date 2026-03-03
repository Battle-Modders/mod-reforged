::Reforged.HooksMod.hook("scripts/events/events/lawmen_after_criminal_event", function(q) {
	q.onUpdateScore = @(__original) { function onUpdateScore()
	{
		__original();
		// Prevent avatar from being chosen in this event.
		if (this.m.Score != 0 && this.m.Criminal.getFlags().has("IsPlayerCharacter"))
		{
			this.clear();
			return;
		}
	}}.onUpdateScore;
});
