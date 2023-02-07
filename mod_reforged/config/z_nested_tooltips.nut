::Reforged.NestedTooltips <- {
	Tooltips = {
		Concept = {}
	},
	AutoConcepts = [
		"character-stats.ActionPoints",
		"character-stats.Hitpoints",
		"character-stats.Morale",
		"character-stats.Fatigue",
		"character-stats.MaximumFatigue",
		"character-stats.ArmorHead",
		"character-stats.ArmorBody",
		"character-stats.MeleeSkill",
		"character-stats.RangeSkill",
		"character-stats.MeleeDefense",
		"character-stats.RangeDefense",
		"character-stats.SightDistance",
		"character-stats.RegularDamage",
		"character-stats.CrushingDamage",
		"character-stats.ChanceToHitHead",
		"character-stats.Initiative",
		"character-stats.Bravery",
		"character-stats.Talent",

		"character-screen.left-panel-header-module.Experience",
		"character-screen.left-panel-header-module.Level",
	]
}

::MSU.AfterQueue.add(::Reforged.ID, function() {
	foreach (concept in ::Reforged.NestedTooltips.AutoConcepts)
	{
		local desc = ::TooltipScreen.m.TooltipEvents.general_queryUIElementTooltipData(::Reforged.getDummyPlayer().getID(), concept, null);
		::Reforged.NestedTooltips.Tooltips.Concept[split(concept, ".").top()] <- ::MSU.Class.CustomTooltip(@(data) desc);
	}

	::Reforged.Mod.Tooltips.setTooltips(::Reforged.NestedTooltips.Tooltips);
});
