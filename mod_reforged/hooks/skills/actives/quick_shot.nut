::Reforged.HooksMod.hook("scripts/skills/actives/quick_shot", function(q) {
	q.m.AdditionalAccuracy = 0;
	q.m.AdditionalHitChance = -4;

	q.getTooltip = @(__original) function()
	{
		local ret = this.getRangedTooltip(this.skill.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + ::Const.UI.Color.PositiveValue + "]" + ammo + "[/color] arrows left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of arrows equipped[/color]"
			});
		}

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

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local additionalAccuracy = this.m.AdditionalAccuracy;
		__original(_properties);
		this.m.AdditionalAccuracy = additionalAccuracy;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.05;
			}
		}
	}
});
