::Reforged.HooksMod.hook("scripts/skills/effects/taunted_effect", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character is taunted by another character and is much more likely to engage and attack them.";
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

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

// New Functions
	q.getTauntedTarget <- function()
	{
		return this.getContainer().getActor().getAIAgent().getForcedOpponent();
	}
});
