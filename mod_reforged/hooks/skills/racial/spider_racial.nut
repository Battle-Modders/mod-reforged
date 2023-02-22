::mods_hookExactClass("skills/racial/serpent_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsAffectedByNight = false;
		base.IsImmuneToDisarm = true;
		base.IsImmuneToPoison = true;
	}
});
