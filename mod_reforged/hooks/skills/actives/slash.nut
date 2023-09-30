::mods_hookExactClass("skills/actives/slash", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = 5;
	}

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.HitChanceBonus != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceBonus) + " chance to hit"
			});
		}
		return ret;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}
});
