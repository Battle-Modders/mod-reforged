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
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Allies who start their turn adjacent to this character will gain additional Action Points when engaged in melee or being adjacent to an ally engaged in melee"
		});
		return tooltip;
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
