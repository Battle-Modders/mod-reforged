::mods_hookExactClass("skills/racial/lindwurm_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsAffectedByNight = false;
		base.IsImmuneToDisarm = true;
		base.IsImmuneToKnockBackAndGrab = true;
		base.IsImmuneToStun = true;
		base.IsImmuneToRoot = true;
	}
});
