::mods_hookExactClass("skills/effects/shieldwall_effect", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to the next stun, but will be lost upon receiving the stun"
			}
		);

		return tooltip;
	}		

	o.onSkillsUpdated <- function()
	{
		local stun = this.getContainer().getSkillByID("effects.stunned");
		if (stun != null)
		{
			stun.removeSelf();
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shakes off the stun but loses " + this.getName());
		}
	}
});
