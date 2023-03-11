::mods_hookExactClass("items/shields/shield", function(o) {
	o.m.ReachIgnore <- 2; // By default it is 2 so we don't have to hook all shields to add this

	o.getReachIgnore <- function()
	{
		return this.m.ReachIgnore;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignores " + ::MSU.Text.colorGreen(this.getReachIgnore()) + " [Reach Advantage|Concept.ReachAdvantage]")
		});

		return ret;
	}

// New Functions
	o.getMeleeDefenseBonus <- function()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.m.MeleeDefense * mult);
	}

	o.getRangedDefenseBonus <- function()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.m.RangedDefense * mult);
	}
});
