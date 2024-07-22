::Reforged.HooksMod.hook("scripts/skills/actives/throw_axe", function(q) {
	q.m.AdditionalAccuracy = 20;
	q.m.AdditionalHitChance = -15;

	q.create = @(__original) function()
	{
		__original();
		this.m.FatigueCost = 10;
	}

	q.getTooltip = @() function()
	{
		local ret = this.getRangedTooltip(this.skill.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " axes left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("No axes left")
			});
		}

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
