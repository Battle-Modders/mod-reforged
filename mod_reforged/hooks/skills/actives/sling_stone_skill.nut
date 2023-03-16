::mods_hookExactClass("skills/actives/sling_stone_skill", function(o) {
	o.m.AdditionalAccuracy <- 0;
	o.m.AdditionalHitChance <- -5;

	o.getTooltip = function()
	{
		local ret = this.getRangedTooltip(this.skill.getDefaultTooltip());

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + ::Const.UI.Color.NegativeValue + "]100%[/color] chance to daze a target on a hit to the head"
		});

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function( _properties )
	{
		local additionalAccuracy = this.m.AdditionalAccuracy;
		onAfterUpdate(_properties);
		this.m.AdditionalAccuracy = additionalAccuracy;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
