::Reforged.HooksMod.hook("scripts/ambitions/ambition", function(q) {
	q.m.ButtonIcon <- "ui/icons/rf_default_ambition_icon.png";

// New Functions
	q.getButtonIcon <- function()
	{
		return this.m.ButtonIcon;
	}
});

::Reforged.QueueBucket.Late.push(function() {
	::Reforged.HooksMod.hook("scripts/ambitions/ambition", function(q) {
		q.getButtonTooltip = @(__original) function()
		{
			local ret = __original();
			foreach (i, entry in ret)
			{
				if (("text" in entry) && entry.text == "Your Renown will increase, which means higher pay for contracts and potentially unlocking new types of contracts.")
				{
					ret.remove(i);
					break;
				}
			}

			if (this.getRenownOnSuccess() != 0)
			{
				ret.push({
					id = 6,
					type = "text",
					icon = "ui/icons/ambition_tooltip.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getRenownOnSuccess()) + " [Renown|Concept.BusinessReputation]")
				});
			}
			return ret;
		}
	});
});
