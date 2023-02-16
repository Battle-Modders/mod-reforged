::mods_hookExactClass("skills/racial/spider_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Spider";
		this.m.Description = "";	// Vanilla has "TODO" written here. We don't want that to display
		this.m.Icon = "ui/orientation/spider_01_orientation.png";
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
                icon = "ui/icons/bravery.png",
				text = "Resolve is increased by " + ::MSU.Text.colorGreen("+3") + " for every other ally on the battlefield of the same faction"
			},
			{
				id = 11,
				type = "text",
                icon = "ui/icons/direct_damage.png",
				text = "When attacking a webbed target, the damage that ignores armor is increased by " + ::MSU.Text.colorGreen("100%")
			}
		]);
		return ret;
	}

	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToPoison = true;
	}
});
