::mods_hookExactClass("skills/racial/lindwurm_racial", function(o) {
	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToKnockBackAndGrab = true;
		baseProperties.IsImmuneToStun = true;
		baseProperties.IsImmuneToRoot = true;
	}
});
