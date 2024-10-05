::Reforged.HooksMod.hook("scripts/skills/actives/barbarian_fury_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "skills/active_175.png";
		this.m.IconDisabled = "skills/active_175_sw.png";
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Switch places with an adjacent ally, provided neither you nor the ally is [stunned|Skill+stunned_effect] or rooted. Rotate the battle line to keep fresh troops in front!");
	}

	q.getTooltip = @() function()
	{
		return this.skill.getDefaultUtilityTooltip();
	}
});
