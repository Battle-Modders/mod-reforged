::Reforged.HooksMod.hook("scripts/skills/perks/perk_hold_out", function(q) {
	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		_properties.RF_BleedingEffectMult *= 0.5;
	}}.onUpdate;
});
