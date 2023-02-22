::mods_hookExactClass("skills/racial/vampire_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsAffectedByInjuries = false;
		base.IsAffectedByNight = false;
		base.IsImmuneToPoison = true;
	}
});
