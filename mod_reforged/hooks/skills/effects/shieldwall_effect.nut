::Reforged.HooksMod.hook("scripts/skills/effects/shieldwall_effect", function(q) {
	// Part of perk_rf_shield_sergeant functionality
	q.onTurnStart = @(__original) function()
	{
		__original();

		local actor = this.getContainer().getActor();
		local hasPerk = this.getContainer().hasSkill("perk.rf_shield_sergeant");

		foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1, true))
		{
			if (::Math.abs(ally.getTile().Level - actor.getTile().Level) <= 1 && ally.getSkills().hasSkill("actives.shieldwall") && (hasPerk || ally.getSkills().hasSkill("perk.rf_shield_sergeant")))
			{
				this.m.IsGarbage = false;
				if (!actor.isHiddenToPlayer())
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " retains Shieldwall due to " + ::Const.UI.getColorizedEntityName(hasPerk ? actor : ally) + "\'s Shield Sergeant perk");
				}
				return;
			}
		}
	}
});
