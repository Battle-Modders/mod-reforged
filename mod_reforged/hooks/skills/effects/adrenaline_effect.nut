::Reforged.HooksMod.hook("scripts/skills/effects/adrenaline_effect", function(q) {
	q.m.GrantsInjuryImmunity <- true;

	q.create = @(__original) { function create()
	{
		__original();

		this.m.Order = ::Const.SkillOrder.TemporaryInjury - 100;	// This effect needs to flip the IsAffectedByInjuries flag before any of the injuries had the time to inflict their effects
	}}.create;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		if (this.m.GrantsInjuryImmunity)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by, and cannot receive, [temporary injuries|Concept.InjuryTemporary]")
			});
		}

		return ret;
	}}.getTooltip;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);

		if (this.m.TurnsLeft != 0 && this.m.GrantsInjuryImmunity)
		{
			_properties.IsAffectedByInjuries = false;
		}
	}}.onUpdate;
});
