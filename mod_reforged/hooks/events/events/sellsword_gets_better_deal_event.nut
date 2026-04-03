::Reforged.HooksMod.hook("scripts/events/events/sellsword_gets_better_deal_event", function(q) {
	q.onUpdateScore = @(__original) { function onUpdateScore()
	{
		__original();
		// Prevent avatar from being chosen in this event.
		/* Prevent avatar from being chosen in this event.
		We need null check instead of `m.Score != 0`. The member variable is set
		during onUpdateScore() of this event and is only set in a situation where
		the Score is also set to a non-zero value. However, we can arrive at this
		point in this hook with a non-zero Score but null member. This is because
		during event_manager.selectEvent vanilla calls event.update() but that only
		does onClear() and onUpdateScore(). The onClear() does not set the Score to 0
		but does clear the member variables. This works fine in vanilla because vanilla
		calls .clear() on an event after it has been selected as the ActiveEvent, and
		that resets the score to 0 and then calls onUpdateScore() and only fires the
		event if it at that point reports a non-zero score. */
		if (!::MSU.isNull(this.m.Sellsword) && this.m.Sellsword.getFlags().has("IsPlayerCharacter"))
		{
			this.clear();
			return;
		}
	}}.onUpdateScore;
});
