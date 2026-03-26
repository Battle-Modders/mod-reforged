::Reforged.HooksMod.hook("scripts/events/events/bastard_assassin_event", function(q) {
	q.onUpdateScore = @(__original) { function onUpdateScore()
	{
		__original();
		// Prevent avatar from being chosen in this event.
		if (this.m.Score != 0 && this.m.Bastard.getFlags().has("IsPlayerCharacter"))
		{
			this.clear();
			return;
		}
	}}.onUpdateScore;
});
