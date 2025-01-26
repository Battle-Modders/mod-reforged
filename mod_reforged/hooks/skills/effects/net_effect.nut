::Reforged.HooksMod.hook("scripts/skills/effects/net_effect", function(q) {
	q.m.MeleeDefenseMult <- 0.75; // Compared to vanilla of 0.55 because in Reforged being netted also lowers Reach
	q.m.RangedDefenseMult <- 0.55;
	q.m.InitiativeMult <- 0.55;

	q.getTooltip = @() function()
	{
		local ret = this.skill.getTooltip();

		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::MSU.Text.colorNegative("Unable to move")
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.MeleeDefenseMult) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.RangedDefenseMult) + " [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.InitiativeMult) + " [Initiative|Concept.Initiative]")
			}
		]);

		return ret;
	}

	q.onUpdate = @() function( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= this.m.MeleeDefenseMult;
		_properties.RangedDefenseMult *= this.m.RangedDefenseMult;
		_properties.InitiativeMult *= this.m.InitiativeMult;
	}
});
