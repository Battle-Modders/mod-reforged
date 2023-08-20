::mods_hookExactClass("skills/racial/vampire_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Vampire";
		this.m.Description = "";	// Vanilla has "TODO" written here. We don't want that to display
		this.m.Icon = "/ui/orientation/vampire_01_orientation.png";
		this.m.IsHidden = true;		// We currently don't have any description to display
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToPoison = true;

		this.getContainer().add(::new("scripts/skills/effects/rf_life_leech_effect"));
	}

	// Vanilla used to handle life-leech in this function but we outsourced that effect. That's why we need to disable the vanilla function now by overwriting it
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {}
});
