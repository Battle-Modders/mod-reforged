::Reforged.HooksMod.hook("scripts/skills/actives/fling_back_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Fling a character backwards and move into their position!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target builds " + ::MSU.Text.colorNegative("10") + " [fatigue|Concept.Fatigue]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target is flung backwards and receives damage upon landing")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target loses effects such as [Shieldwall|Skill+shieldwall_effect], [Spearwall|Skill+spearwall_effect] and [Riposte|Skill+riposte_effect]")
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("You move into the target tile ignoring [Zone of Control|Concept.ZoneOfControl]")
		});
		return ret;
	}}.getTooltip;

	// We delay the onFollow of this skill by another 100ms because otherwise the entity doesn't follow through with this function properly when at very high speeds using some faster combat speed mods
	q.onFollow = @(__original) { function onFollow( _tag )
	{
		if (::Time.getVirtualSpeed() > 2)
		{
			::Time.scheduleEvent(::TimeUnit.Virtual, 100, __original, _tag);
		}
		else
		{
			__original(_tag);
		}
	}}.onFollow;
});
