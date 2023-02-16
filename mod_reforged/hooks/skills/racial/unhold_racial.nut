::mods_hookExactClass("skills/racial/unhold_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Unhold";
		this.m.Icon = "ui/orientation/unhold_01_orientation.png";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
                icon = "ui/icons/health.png",
				text = "At the start of each turn, this character heals by " + ::MSU.Text.colorGreen("15%") + " of Maximum Hitpoints"
			}
		]);
		return ret;
	}

	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToRotation = true;
	}
});
