::mods_hookExactClass("skills/perks/perk_mastery_polearm", function(o) {
	// Not the cleanest way but it'll have to do for now.
	// Other methods would be more performance intensive or may cause drinking an oblivion potion to let a brother keep the adjacency ignore until the savegame is reloaded
	o.onCombatStarted <- function()
	{
		local adjacencySkill = this.getContainer().getSkillByID("special.rf_polearm_adjacency");
		adjacencySkill.m.IgnoreAllyPenalty = true;
	}

	o.onCombatFinished <- function()
	{
		local adjacencySkill = this.getContainer().getSkillByID("special.rf_polearm_adjacency");
		adjacencySkill.m.IgnoreAllyPenalty = false;
	}

});

