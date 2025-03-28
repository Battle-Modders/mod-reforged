::Reforged.HooksMod.hook("scripts/skills/racial/grand_diviner_racial", function(q) {
	q.getTooltip <- function()
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
	}
});
