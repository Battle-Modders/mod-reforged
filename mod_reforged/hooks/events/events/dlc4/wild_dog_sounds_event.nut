::Reforged.HooksMod.hook("scripts/events/events/dlc4/wild_dog_sounds_event", function(q) {
	q.onUpdateScore = @(__original) { function onUpdateScore()
	{
		__original();
		// Prevent avatar from being chosen in this event.
		if (this.m.Score != 0 && this.m.Expendable.getFlags().has("IsPlayerCharacter"))
		{
			this.clear();
			return;
		}
	}}.onUpdateScore;
});
