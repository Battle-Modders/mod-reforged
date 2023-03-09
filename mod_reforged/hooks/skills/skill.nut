::mods_hookBaseClass("skills/skill", function(o) {
	o = o[o.SuperName];

	o.isDuelistValid <- function()
	{
		return this.isAttack() && !this.isRanged() && this.getBaseValue("ActionPointCost") <= 4 && this.getBaseValue("MaxRange") == 1;
	}

	o.isTrappedEffect <- function()		// Needs to be overwritten for any effect that is a 'trapped_effect'
	{
		return false;
	}
});
