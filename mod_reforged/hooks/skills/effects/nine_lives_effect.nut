::Reforged.HooksMod.hook("scripts/skills/effects/nine_lives_effect", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// We change the name of this effect so you don't confuse it with the perk 'Nine Lives' which now also displays under StatusEffects
		this.m.Name = "Heightened Reflexes (Nine Lives)";
		this.m.IconMini = "rf_nine_lives_effect_mini";
	}
});
