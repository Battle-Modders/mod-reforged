::Reforged.HooksMod.hook("scripts/ai/tactical/agents/vampire_agent", function(q) {
	// Same logic as vanilla except that instead of counting EntityType.Vampire
	// we count allies with the darkflight skill.
	q.onUpdate = @() { function onUpdate()
	{
		local strategy = ::Tactical.Entities.getStrategy(this.getActor().getFaction());
		local vampires = 0;

		foreach (a in this.m.KnownAllies)
		{
			// Vanilla checks for `a.getType() == Const.EntityType.Vampire` which is not
			// enough if we add more entities that can use DarkFlight e.g. rf_vampire_lord
			// in Reforged. This causes vampires to wait instead of using darkflight to engage.
			// We fix this by considering all allies with the darkflight ability to be vampires.
			if (a.getSkills().hasSkill("actives.darkflight"))
			{
				vampires++;
			}
		}

		if (!::Tactical.State.isAutoRetreat() && !strategy.getStats().IsEngaged && this.m.Actor.getAttackedCount() == 0 && this.m.KnownAllies.len() >= 6 && vampires < this.m.KnownAllies.len() - 1 && this.Time.getRound() <= 1)
		{
			this.m.Properties.EngageTileLimit = 0;
			this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Darkflight] = 0.0;
			this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageMelee] = 0.0;
			this.m.Properties.PreferWait = true;
		}
		else if (!::Tactical.State.isAutoRetreat() && !strategy.getStats().IsEngaged && this.m.Actor.getAttackedCount() == 0 && this.m.KnownAllies.len() >= 6 && vampires < this.m.KnownAllies.len() - 1 && strategy.getStats().ShortestDistanceToEnemyNotMoved >= 3)
		{
			this.m.Properties.EngageTileLimit = 3;
			this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Darkflight] = 0.0;
			this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.PreferWait = true;
		}
		else
		{
			this.m.Properties.EngageTileLimit = 0;
			this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Darkflight] = 1.0;
			this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.PreferWait = false;
		}
	}}.onUpdate;
});
