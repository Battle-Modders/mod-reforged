::mods_hookExactClass("skills/racial/ghost_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Ghost";
		this.m.Icon = "ui/orientation/ghost_01_orientation.png";
		this.m.IsHidden = false;
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "When being attacked, gain " + ::MSU.Text.colorGreen("+10") + " Melee Defense and Ranged Defense for each tile between you and the attacker"
		});
		return ret;
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
