::mods_hookExactClass("skills/racial/ghost_racial", function(o) {
	o.onAdded <- function()
	{
		local base = this.getContainer().getActor().getBaseProperties();

		base.IsAffectedByInjuries = false;
		base.IsAffectedByNight = false;
		base.IsImmuneToBleeding = true;
		base.IsImmuneToDisarm = true;
		base.IsImmuneToFire = true;
		base.IsImmuneToKnockBackAndGrab = true;
		base.IsImmuneToPoison = true;
		base.IsImmuneToRoot = true;
		base.IsImmuneToStun = true;

		// This is purely a setting for AI decisions:
		base.IsIgnoringArmorOnAttack = true;
	}
});
