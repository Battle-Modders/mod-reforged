::mods_hookExactClass("skills/effects/nine_lives_effect", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		// We change the name of this effect so you don't confuse it with the perk 'Nine Lives' which now also displays under StatusEffects
		this.m.Name = "Heightened Reflexes (Nine Lives)";
		this.m.IconMini = "rf_nine_lives_effect_mini";
	}
});
