::Reforged.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function(q) {
	q.getTooltip = @() function()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + (this.m.Count * 10) + "%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + (this.m.Count * 10) + "%[/color] Ranged Skill"
			}
		]);

		return tooltip;
	}

	q.onUpdate = @() function( _properties )
	{
		_properties.MeleeSkillMult = ::Math.maxf(0.0, _properties.MeleeSkillMult - 0.1 * this.m.Count);
		_properties.RangedSkillMult = ::Math.maxf(0.0, _properties.RangedSkillMult - 0.1 * this.m.Count);
	}

	q.onRefresh = @(__original) function()
	{
		__original();
		this.m.Count = ::Math.min(this.m.Count, 7);
	}
});
