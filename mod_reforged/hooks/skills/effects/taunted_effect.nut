::mods_hookExactClass("skills/effects/taunted_effect", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
        this.m.Description = "This character is taunted by another character and is much more likely to engage and attack them.";
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();

		if (this.getTauntedTarget() != null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character has been taunted by " + ::MSU.Text.colorRed(this.getTauntedTarget().getName())
			});
		}

		return ret;
	}

	o.getTauntedTarget <- function()	// New helper-function to get the taunter
	{
		return this.getContainer().getActor().getAIAgent().getForcedOpponent();
	}
});
