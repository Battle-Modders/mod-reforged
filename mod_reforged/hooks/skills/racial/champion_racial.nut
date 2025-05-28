::Reforged.HooksMod.hook("scripts/skills/racial/champion_racial", function(q) {
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::MSU.Text.colorPositive("15%") + " more damage dealt"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("15%") + " more [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("15%") + " more [Ranged Skill|Concept.RangeSkill]")
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive(::Math.floor((this.getDefenseMultiplier() - 1.0) * 100) + "%") + " more [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive(::Math.floor((this.getDefenseMultiplier() - 1.0) * 100) + "%") + " more [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive(::Math.floor((this.getHitpointMult() - 1.0) * 100) + "%") + " more Maximum [Hitpoints|Concept.Hitpoints]")
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("50%") + " more Maximum [Fatigue|Concept.Fatigue]")
			},
			{
				id = 17,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("50%") + " more [Resolve|Concept.Bravery]")
			},
			{
				id = 18,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("15%") + " more [Initiative|Concept.Initiative]")
			}
		]);
		return ret;
	}}.getTooltip;

	// New Helper Functions. They mirrir the vanilla condition for whether to give additional defense or hitpoints to a champion
	q.getDefenseMultiplier <- { function getDefenseMultiplier()
	{
		local defenseMult = 1.25;
		local b = this.getContainer().getActor().getBaseProperties();
		if (b.MeleeDefense >= 20 || b.RangedDefense >= 20 || b.MeleeDefense >= 15 && b.RangedDefense >= 15) defenseMult *= 1.25;
		return defenseMult;
	}}.getDefenseMultiplier;

	q.getHitpointMult <- { function getHitpointMult()
	{
		local hitpointMult = 1.35;
		local b = this.getContainer().getActor().getBaseProperties();
		if (b.MeleeDefense >= 20 || b.RangedDefense >= 20 || b.MeleeDefense >= 15 && b.RangedDefense >= 15) return hitpointMult;
		return (hitpointMult * 1.35);
	}}.getHitpointMult;
});
