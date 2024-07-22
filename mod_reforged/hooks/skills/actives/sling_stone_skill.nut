::Reforged.HooksMod.hook("scripts/skills/actives/sling_stone_skill", function(q) {
	q.m.AdditionalAccuracy = 0;
	q.m.AdditionalHitChance = -5;

	q.getTooltip = @() function()
	{
		local ret = this.getRangedTooltip(this.skill.getDefaultTooltip());

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + ::MSU.Text.colorNegative("100%") + " chance to daze a target on a hit to the head"
		});

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used because this character is engaged in melee")
			});
		}

		return ret;
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local additionalAccuracy = this.m.AdditionalAccuracy;
		__original(_properties);
		this.m.AdditionalAccuracy = additionalAccuracy;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}
});
