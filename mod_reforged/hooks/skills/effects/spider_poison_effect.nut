::Reforged.HooksMod.hook("scripts/skills/effects/spider_poison_effect", function (q) {
	q.m.HitpointRecoveryMult <- 0.6;

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.HitpointRecoveryMult *= this.m.HitpointRecoveryMult;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/damage_received.png",
			text = "Hitpoint Recovery is reduced by " + ::MSU.Text.colorizeMult(this.m.HitpointRecoveryMult)
		});

		return ret;
	}
});
