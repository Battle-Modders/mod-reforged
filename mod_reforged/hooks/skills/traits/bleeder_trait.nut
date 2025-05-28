::Reforged.HooksMod.hook("scripts/skills/traits/bleeder_trait", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Description = "This character is prone to bleeding and will do so more than most others."; // "more than" as opposed to vanilla "longer than"
	}}.create;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		_properties.RF_BleedingEffectMult *= 2.0;
	}}.onUpdate;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vigorous":
				return 0;
		}
	}}.getPerkGroupMultiplier;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 10)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("The effects of [Bleeding|Skill+bleeding_effect] are " + ::MSU.Text.colorNegative("doubled"));
				break;
			}
		}
		return ret;
	}}.getTooltip;
});
