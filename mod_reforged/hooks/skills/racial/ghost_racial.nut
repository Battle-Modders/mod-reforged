::mods_hookExactClass("skills/racial/ghost_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToFire = true;
		baseProperties.IsImmuneToKnockBackAndGrab = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.IsImmuneToRoot = true;
		baseProperties.IsImmuneToStun = true;

		// This is purely a setting for AI decisions:
		baseProperties.IsIgnoringArmorOnAttack = true;
	}
});
