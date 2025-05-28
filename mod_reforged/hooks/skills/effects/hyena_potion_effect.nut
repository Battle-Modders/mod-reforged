::Reforged.HooksMod.hook("scripts/skills/effects/hyena_potion_effect", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 11)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("The effects of [Bleeding|Skill+bleeding_effect] are " + ::MSU.Text.colorPositive("halved"));
				break;
			}
		}
		return ret;
	}}.getTooltip;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		_properties.RF_BleedingEffectMult *= 0.5;
	}}.onUpdate;
});
