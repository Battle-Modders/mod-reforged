::mods_hookExactClass("skills/perks/perk_inspiring_presence", function(o) {
	o.m.IsForceEnabled <- false;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "This character has an inspiring presence on the battlefield.";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Icon = "ui/perks/rf_inspiring_presence.png";
		this.m.IconMini = "rf_inspiring_presence_mini";
	}

	o.isHidden <- function()
	{
		return !this.isEnabled();
	}

	o.getTooltip <- function()
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

	o.isEnabled <- function()
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
	o.onCombatStarted = function()
	{
		local allies = ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		foreach (ally in allies)
		{
			ally.getSkills().add(::new("scripts/skills/special/rf_inspiring_presence_buff_effect"));
		}
	}
});
