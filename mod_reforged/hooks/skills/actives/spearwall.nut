::Reforged.HooksMod.hook("scripts/skills/actives/spearwall", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local crowded = this.getContainer().getSkillByID("special.rf_polearm_adjacency");
		if (crowded != null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Attacks do not suffer from %s when it is not your [turn|Concept.Turn]", ::Reforged.NestedTooltips.getNestedSkillName(crowded)))
			});
		}

		return ret;
	}
});
