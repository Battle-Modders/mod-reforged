::mods_hookExactClass("skills/racial/unhold_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsImmuneToDisarm = true;
		base.IsImmuneToRotation = true;
	}
});
