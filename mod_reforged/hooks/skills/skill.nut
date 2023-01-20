::mods_hookBaseClass("skills/skill", function(o) {
	o = o[o.SuperName];

	o.m.EffectHiddenInTacticalTooltip <- false;	// Determines whether this perk displays a line in the effect-section of the tactical tooltip

	o.isDuelistValid <- function()
	{
		return this.isAttack() && !this.isRanged() && this.getBaseValue("ActionPointCost") <= 4 && this.getBaseValue("MaxRange") == 1;
	}
});
