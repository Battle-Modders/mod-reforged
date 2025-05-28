::Reforged.HooksMod.hook("scripts/skills/effects/net_effect", function(q) {
	q.m.MeleeDefenseMult <- 0.75; // Compared to vanilla of 0.55 because in Reforged being netted also lowers Reach
	q.m.RangedDefenseMult <- 0.55;
	q.m.InitiativeMult <- 0.55;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::MSU.Text.colorNegative("Unable to move")
		});

		if (this.m.MeleeDefenseMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.MeleeDefenseMult) + " [Melee Defense|Concept.MeleeDefense]")
			});
		}

		if (this.m.RangedDefenseMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.RangedDefenseMult) + " [Ranged Defense|Concept.RangeDefense]")
			});
		}

		if (this.m.InitiativeMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.InitiativeMult) + " [Initiative|Concept.Initiative]")
			});
		}

		return ret;
	}}.getTooltip;

	q.onUpdate = @() { function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= this.m.MeleeDefenseMult;
		_properties.RangedDefenseMult *= this.m.RangedDefenseMult;
		_properties.InitiativeMult *= this.m.InitiativeMult;
	}}.onUpdate;
});
