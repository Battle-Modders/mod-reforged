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
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::Reforged.Mod.Tooltips.parseString("At the start of each [turn|Concept.Turn], this character heals by " + ::MSU.Text.colorPositive("15%") + " of Maximum [Hitpoints|Concept.Hitpoints]")
		});

		// This is about the vanila behavior coded in this skill's `onUpdate` function.
		// We show it here in the absence of a better UI that shows turn order initiative in addition to regular initiative.
		local actor = this.getContainer().getActor();
		if (::MSU.isKindOf(actor, "unhold_armored") || ::MSU.isKindOf(actor, "unhold_frost_armored") || ::MSU.isEqual(actor, ::MSU.getDummyPlayer()))
		{
			local roundsForInitiativeBonus = ::Tactical.isActive() ? (::Tactical.State.isScenarioMode() ? 3 : 2) : "few";
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString("[Turn|Concept.Turn] order is determined with " + ::MSU.Text.colorPositive("+40") + " [Initiative|Concept.Initiative] during the first " + roundsForInitiativeBonus + " [rounds|Concept.Round]")
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to being disarmed"
		})
		ret.push({
			id = 21,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune to being [rotated|Skill+rotation]")
		});

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
