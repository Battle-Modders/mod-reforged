::Reforged.HooksMod.hook("scripts/skills/racial/lindwurm_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Lindwurm";
		this.m.Description = "";	// Vanilla has "TODO" written here. We don't want that to display
		this.m.Icon = "ui/orientation/lindwurm_orientation.png";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Upon receiving a hit from an adjacent enemy that deals at least " + ::MSU.Text.colorPositive("10") + " damage to [Hitpoints,|Concept.Hitpoints] apply [Lindwurm Acid|Skill+lindwurm_acid_effect] to them")
			},
			{
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by nighttime penalties"
			},
			{
				id = 24,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			},
			{
				id = 26,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being disarmed"
			},
			{
				id = 27,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being rooted"
			}
			{
				id = 28,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [stunned|Skill+stunned_effect]")
			}
		]);
		return ret;
	}

	q.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToKnockBackAndGrab = true;
		baseProperties.IsImmuneToStun = true;
		baseProperties.IsImmuneToRoot = true;
	}
});
