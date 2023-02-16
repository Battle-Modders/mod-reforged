::mods_hookExactClass("skills/effects/berserker_rage_effect", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
        this.m.Description = "This character is in a berserking rage."
	}

	o.getDescription = function()	// Vanilla overwrote this returning "TODO" so we need to fix that
	{
		return this.skill.getDescription();
	}


	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
                icon = "ui/icons/special.png",
				text = "All damage received is reduced by " + ::MSU.Text.colorRed((100.0 - (this.calcDamageTakenMult() * 100.0)) + "%")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::MSU.Text.colorGreen("+" + this.m.RageStacks) + " Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorGreen("+" + this.m.RageStacks) + " Resolve"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorGreen("+" + this.m.RageStacks) + " Initiative"
			}
		]);
		return ret;
	}

	// New function replicating the current hard-coded vanilla calculation. Changing this will currently only affect the tooltip
	o.calcDamageTakenMult <- function()
	{
		return ::Math.maxf(0.3, 1.0 - 0.02 * this.m.RageStacks);
	}
});
