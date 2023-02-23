::mods_hookExactClass("skills/racial/unhold_racial", function(o) {
	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToRotation = true;
	}
});
