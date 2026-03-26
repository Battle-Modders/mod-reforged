::Reforged.HooksMod.hook("scripts/events/events/dlc8/disowned_noble_welcomed_back_event", function(q) {
	q.onUpdateScore = @(__original) { function onUpdateScore()
	{
		__original();
		// Prevent avatar from being chosen in this event.
		if (this.m.Score != 0 && this.m.Disowned.getFlags().has("IsPlayerCharacter"))
		{
			this.clear();
			return;
		}
	}}.onUpdateScore;
});
