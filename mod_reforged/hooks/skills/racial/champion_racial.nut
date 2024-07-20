::Reforged.HooksMod.hook("scripts/skills/racial/champion_racial", function(q) {
	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::MSU.Text.colorPositive("15%") + " increased Damage dealt"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::MSU.Text.colorPositive("15%") + " increased Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::MSU.Text.colorPositive("15%") + " increased Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorPositive(::Math.floor((this.getDefenseMultiplier() - 1.0) * 100) + "%") + " increased Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorPositive(::Math.floor((this.getDefenseMultiplier() - 1.0) * 100) + "%") + " increased Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::MSU.Text.colorPositive(::Math.floor((this.getHitpointMult() - 1.0) * 100) + "%") + " increased Maximum Hitpoints"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorPositive("50%") + " increased Maximum Fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorPositive("50%") + " increased Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorPositive("15%") + " increased Initiative"
			}
		]);
		return ret;
	}

	// New Helper Functions. They mirrir the vanilla condition for whether to give additional defense or hitpoints to a champion
	q.getDefenseMultiplier <- function()
	{
		local defenseMult = 1.25;
		local b = this.getContainer().getActor().getBaseProperties();
		if (b.MeleeDefense >= 20 || b.RangedDefense >= 20 || b.MeleeDefense >= 15 && b.RangedDefense >= 15) defenseMult *= 1.25;
		return defenseMult;
	}

	q.getHitpointMult <- function()
	{
		local hitpointMult = 1.35;
		local b = this.getContainer().getActor().getBaseProperties();
		if (b.MeleeDefense >= 20 || b.RangedDefense >= 20 || b.MeleeDefense >= 15 && b.RangedDefense >= 15) return hitpointMult;
		return (hitpointMult * 1.35);
	}
});
