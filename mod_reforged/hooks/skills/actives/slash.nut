::Reforged.HooksMod.hook("scripts/skills/actives/slash", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.HitChanceBonus = 5;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceBonus) + " chance to hit"
		});

		return ret;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}
});
