::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
	q.m.ReachIgnore <- 2; // By default it is 2 so we don't have to hook all shields to add this

	q.getReachIgnore <- function()
	{
		return this.m.ReachIgnore;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignores " + ::MSU.Text.colorGreen(this.getReachIgnore()) + " [Reach Advantage|Concept.ReachAdvantage]")
		});

		return ret;
	}

// New Functions
	q.getMeleeDefenseBonus <- function()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.m.MeleeDefense * mult);
	}

	q.getRangedDefenseBonus <- function()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.m.RangedDefense * mult);
	}
});
