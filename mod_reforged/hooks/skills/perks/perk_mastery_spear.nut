::mods_hookExactClass("skills/perks/perk_mastery_spear", function(o) {
	o.onAfterUpdate <- function( _properties )
	{
		local spearwall = this.getContainer().getSkillByID("actives.spearwall");
		if (spearwall != null && spearwall.m.ActionPointCost > 1)
			spearwall.m.ActionPointCost -= 1;
	}
});
