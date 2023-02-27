::mods_hookBaseClass("skills/skill", function(o) {
	o = o[o.SuperName];

	o.isDuelistValid <- function()
	{
		return this.isAttack() && !this.isRanged() && this.getBaseValue("ActionPointCost") <= 4 && this.getBaseValue("MaxRange") == 1;
	}

	local getDefaultTooltip = o.getDefaultTooltip;
	o.getDefaultTooltip = function()
	{
		local ret = getDefaultTooltip();

		// Midas -- Would be nice if there was a way to avoid having to buildPropertiesForUse here
		// as they are already built during getDefaultTooltip. One way is to overwrite the entire
		// vanilla function but I'd like to avoid that.
		local properties = this.m.Container.buildPropertiesForUse(this, null);

		if (this.m.DirectDamageMult > 0.0)
		{
			// Direct damage entry
			local damageDirectPct = properties.DamageDirectMult * (this.m.DirectDamageMult + properties.DamageDirectAdd + (this.m.IsRanged ? properties.DamageDirectRangedAdd : properties.DamageDirectMeleeAdd));
			ret[3].text = ::MSU.String.replace(ret[3].text, "which ", "which " + ::MSU.Text.colorRed(::Math.floor(100 * damageDirectPct) + "%") + " [");
			ret[3].text = ::MSU.String.replace(ret[3].text, " can", "] can");
		}

		// Armor damage entry
		if (ret[4].id == 5)
		{
			ret[4].text = ::MSU.String.replace(ret[4].text, "Inflicts ", "Inflicts " + ::MSU.Text.colorRed(::Math.floor(100 * properties.DamageArmorMult) + "%") + " [");
			ret[4].text = ::MSU.String.replace(ret[4].text, " damage", "] damage");
		}

		return ret;
	}
});
