::Reforged.HooksMod.hook("scripts/skills/actives/warcry", function(q) {
	q.create = @(__original) { function create()
	{
		__original();

		// VanillaFix: vanilla uses the wrong icon active_41
		this.m.Icon = "skills/active_49.png";
		this.m.IconDisabled = "skills/active_49_sw.png";

		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Let out a bellowing roar to bolster the [morale|Concept.Morale] of your allies while giving your enemies [second thoughts|Concept.Morale]!");
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("All allies and enemies receive positive and negative [morale checks|Concept.Morale] respectively, with those closer to you receiving stronger checks")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("All allies on the battlefield recover " + ::MSU.Text.colorPositive(20) + " [Fatigue|Concept.Fatigue]")
		});

		return ret;
	}}.getTooltip;
});
