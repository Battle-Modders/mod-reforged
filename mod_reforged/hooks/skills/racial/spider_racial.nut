::mods_hookExactClass("skills/racial/serpent_racial", function(o) {
	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToPoison = true;
	}
});
