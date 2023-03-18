::mods_hookExactClass("skills/perks/perk_inspiring_presence", function(o) {
	o.m.IsForceEnabled <- false;
	o.m.IsEnabledForThisCombat <- false;
	o.m.BonusActionPoints <- 3;

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
			text = "Any ally with less Resolve that starts their turn adjacent to you gains " + ::MSU.Text.colorizeValue(this.m.BonusActionPoints) + " Action Points if they are adjacent to an enemy, or have an adjacent ally who is adjacent to an enemy."
		});
		return tooltip;
	}

	// Overwrite the vanilla function to nullify its effects. Reverting the effect of making allies confident is annoying
	o.onCombatStarted = function()
	{
		this.skill.onCombatStarted();
		local actor = this.getContainer().getActor();
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			if (ally.getID() == actor.getID()) continue;	// We don't check ourself

			local inspiringPresencePerk = ally.getSkills().getSkillByID(this.getID());
			if (inspiringPresencePerk == null) continue;					// Only other brothers with this exact perk may prevent our perk from going active
			if (inspiringPresencePerk.m.IsForceEnabled) return;				// If that other perk is force enabled then we don't activate, because we still respect the limit of 1
			if (inspiringPresencePerk.m.IsEnabledForThisCombat) return;		// If that other perk is already active then we can't also go active
			if (ally.getCurrentProperties().getBravery() > actor.getCurrentProperties().getBravery()) return;	// Another Inspire brother has more resolve than us
		}

		this.m.IsEnabledForThisCombat = true;
		::logWarning("Inspiring Presence is Active for " + actor.getName());
	}

	o.onCombatFinished <- function()
	{
		this.m.IsEnabledForThisCombat = false;
		this.skill.onCombatFinished();
	}

	o.isEnabled <- function()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		return this.m.IsEnabledForThisCombat;
	}
});
