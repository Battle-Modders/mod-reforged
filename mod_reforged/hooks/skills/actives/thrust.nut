::Reforged.HooksMod.hook("scripts/skills/actives/thrust", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.HitChanceBonus = 10;
	}

	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.HitChanceBonus != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.HitChanceBonus, {AddSign = true, AddPercent = true}) + " chance to hit"
			});
		}
		return ret;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}
});
