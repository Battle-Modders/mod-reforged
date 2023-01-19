::mods_hookExactClass("skills/backgrounds/character_background", function(o) {
	local getBackgroundDescription = o.getBackgroundDescription;
	o.getBackgroundDescription = function()
	{
		local ret = getBackgroundDescription() + "\n\n";

		if (!this.getContainer().getActor().isTryoutDone())
		{
			ret += ::MSU.Text.colorRed("Try out") + " this character to reveal " + ::MSU.Text.colorGreen("more") + " information!";
		}
		else
		{
			ret += this.getContainer().getActor().getBackground().getPerkTree().getTooltip();
			ret = ::MSU.String.replace(ret, "%name%", this.getContainer().getActor().getNameOnly());
		}

		return ret;
	}
});
