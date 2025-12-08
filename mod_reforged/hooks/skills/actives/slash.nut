::Reforged.HooksMod.hook("scripts/skills/actives/slash", function(q) {
	q.m.MeleeSkillAdd <- 5;

	// MSU Function
	// Add IsIgnooredAsAOO to softReset so that our adjustment to it
	// in perk_rf_en_garde works correctly.
	q.softReset = @(__original) { function softReset()
	{
		__original();
		this.resetField("IsIgnoredAsAOO");
	}}.softReset;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.MeleeSkillAdd != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.MeleeSkillAdd, {AddSign = true, AddPercent = true}) + " chance to hit"
			});
		}
		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.MeleeSkillAdd;
			// this.m.HitChanceBonus is set by Modular Vanilla based on changes to _properties.MeleeSkill
		}
	}}.onAnySkillUsed;
});
