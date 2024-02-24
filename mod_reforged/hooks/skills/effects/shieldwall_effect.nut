::Reforged.HooksMod.hook("scripts/skills/effects/shieldwall_effect", function(q) {
	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to the next stun, but will be lost upon receiving the stun"
			}
		);

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune against [Hook Shield|Skill+rf_hook_shield_skill]")
		});

		return tooltip;
	}

	q.onUpdate = @(__original) function( _properties )	// Overwritten because the defense is no longer added here but instead handled within the shield.nut
	{
		_properties.ShieldDefenseMult * 2.0;

		if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills)	// This is a Oathtaker-Only calculation
		{
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
	}

	q.onSkillsUpdated <- function()
	{
		local stun = this.getContainer().getSkillByID("effects.stunned");
		if (stun != null)
		{
			stun.removeSelf();
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shakes off the stun but loses " + this.getName());
		}
	}
});
