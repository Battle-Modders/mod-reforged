::Reforged.HooksMod.hook("scripts/skills/racial/unhold_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Unhold";
		this.m.Icon = "ui/orientation/unhold_01_orientation.png";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "At the start of each turn, this character heals by " + ::MSU.Text.colorGreen("15%") + " of Maximum Hitpoints"
			},
			{
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being disarmed"
			},
			{
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being [rotated|Skill+rotation]"
			}
		]);
		return ret;
	}

	q.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToRotation = true;
	}

	q.onTurnStart = @(__original) function()
	{
		__original();
		local bleed = this.getContainer().getSkillByID("effects.bleeding");
		if (bleed != null)
		{
			bleed.m.Stacks /= 2;
			if (bleed.m.Stacks == 0)
				bleed.removeSelf();
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " had some of his bleeding wounds close");
		}
	}
});
