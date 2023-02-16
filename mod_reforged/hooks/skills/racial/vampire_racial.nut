::mods_hookExactClass("skills/racial/vampire_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Vampire";
		this.m.Description = "";	// Vanilla has "TODO" written here. We don't want that to display
		this.m.Icon = "/ui/orientation/vampire_01_orientation.png";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
                icon = "ui/icons/regular_damage.png",
				text = "Heal " + ::MSU.Text.colorGreen("100%") + " of Hitpoint damage inflicted on enemies"
			}
		]);
		return ret;
	}

	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToPoison = true;
	}
});
