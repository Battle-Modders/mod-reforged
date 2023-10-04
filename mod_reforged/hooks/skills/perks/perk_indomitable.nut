::Reforged.HooksMod.hook("scripts/skills/perks/perk_indomitable", function(q) {
	q.onCombatStarted = @(__original) function()
	{
		__original();
		this.getContainer().add(::new("scripts/skills/effects/rf_retribution_effect"));
	}
});
