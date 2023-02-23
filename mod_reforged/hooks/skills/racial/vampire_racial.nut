::mods_hookExactClass("skills/racial/vampire_racial", function(o) {
	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToPoison = true;
	}
});
