::Reforged.HooksMod.hook("scripts/skills/actives/web_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Spin a web around a target, trapping them in place and hindering their ability to fight and defend themselves.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The target becomes [webbed|Skill+webbed_effect]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Can only be used once every " + ::MSU.Text.colorNegative(3) + " turns")
			}
		]);
		return ret;
	}}.getTooltip;
});
