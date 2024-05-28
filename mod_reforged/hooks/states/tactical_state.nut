::Reforged.HooksMod.hook("scripts/states/tactical_state", function(q) {
    q.showRetreatScreen = @(__original) function ( _tag = null )
    {
        this.m.TacticalScreen.getTopbarOptionsModule().changeFleeButtonToWin();
        return __original(_tag);
    }

	q.turnsequencebar_onNextRound = @(__original) function( _round )
	{
		// Our goal here is to call onRoundStart/End for otherwise left-out entities. Those all have in common that they have IsActingEachTurn set to false
		// For that we wrap the __original() call with an additional onRoundEnd() before, and onRoundStart() after.
		// That works because turnsequencebar_onNextRound() is the first thing happening after vanilla calls onRoundEnd() and the first thing happening before onRoundStart()

		// We clone this in order to not trigger onRoundEnd() for newly spawned entities which were just added by other onRoundEnd() calls
		local instances = clone this.Tactical.Entities.getAllInstances();
		foreach (faction in instances)
		{
			foreach (entity in faction)
			{
				if (!entity.isAlive() || entity.m.IsActingEachTurn)
				{
					continue;
				}

				entity.onRoundEnd();
			}
		}

		__original(_round);

		// We clone this in order to not trigger onRoundStart() for newly spawned entities which were just added by other onRoundStart() calls
		instances = clone this.Tactical.Entities.getAllInstances();
		foreach (faction in instances)
		{
			foreach (entity in faction)
			{
				if (!entity.isAlive() || entity.m.IsActingEachTurn)
				{
					continue;
				}

				entity.onRoundStart();
			}
		}
	}
});
