::Reforged.HooksMod.hook("scripts/skills/actives/slash", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.HitChanceBonus = 5;
	}}.create;

	q.getTooltip = @() { function getTooltip()
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
	}}.getTooltip;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}}.onAnySkillUsed;
});
