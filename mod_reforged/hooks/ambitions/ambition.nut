::Reforged.HooksMod.hook("scripts/ambitions/ambition", function(q) {
	q.getButtonTooltip = @(__original) function()
	{
		local ret = __original();
		if (this.getRenownOnSuccess() != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ambition_tooltip.png",
				text = ::MSU.Text.colorizeValue(this.getRenownOnSuccess()) + " Renown"
			});
		}
		return ret;
	}
});
