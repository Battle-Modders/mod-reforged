::Reforged.HooksMod.hook("scripts/skills/perks/perk_battle_flow", function(q) {
	q.m.StaminaRecoveredMult <- 0.10; // In vanilla it is 15% of base maximum fatigue

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Icon = "ui/perks/perk_rf_battle_flow.png"
	}}.create;

	q.onTargetKilled = @() { function onTargetKilled( _targetEntity, _skill )
	{
		if (!this.m.IsSpent)
		{
			this.m.IsSpent = true;
			local actor = this.getContainer().getActor();
			actor.setFatigue(::Math.max(0, actor.getFatigue() - actor.getBaseProperties().Stamina * actor.getBaseProperties().StaminaMult * this.m.StaminaRecoveredMult));
			actor.setDirty(true);
		}
	}}.onTargetKilled;
});
