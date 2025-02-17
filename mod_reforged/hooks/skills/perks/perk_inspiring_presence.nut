::Reforged.HooksMod.hook("scripts/skills/perks/perk_inspiring_presence", function(q) {
	q.m.IsForceEnabled <- false;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character has an inspiring presence on the battlefield.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Icon = "ui/perks/perk_rf_inspiring_presence.png";
		this.m.IconMini = "perk_rf_inspiring_presence_mini";
	}

	q.isHidden <- function()
	{
		return !this.isEnabled();
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Allies who start their [turn|Concept.Turn] adjacent to this character when they are [engaged|Concept.ZoneOfControl] in melee or are adjacent to an ally [engaged|Concept.ZoneOfControl] in melee will gain the [Feeling Inspired|Skill+rf_inspiring_presence_buff_effect] effect")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Only same faction members are considered allies for this [perk|Concept.Perk]")
		});
		return ret;
	}

	q.isEnabled <- function()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.getID().find("banner") != null)
		{
			return true;
		}

		return false;
	}

	// Overwrite the vanilla function to be empty.
	q.onCombatStarted = @() function()
	{
	}
});
