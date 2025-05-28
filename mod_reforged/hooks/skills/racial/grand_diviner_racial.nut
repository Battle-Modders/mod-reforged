::Reforged.HooksMod.hook("scripts/skills/racial/grand_diviner_racial", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("[Castigate|Skill+censer_castigate_skill] and [Censer Strike|Skill+censer_strike] cost " + ::MSU.Text.colorizeValue(this.m.APAdjust, {AddSign = true, InvertColor = true}) + " [Action Points|Concept.ActionPoints]")
			}
		]);
		return ret;
	}}.getTooltip;
});
