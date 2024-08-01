::Reforged.HooksMod.hook("scripts/skills/actives/shoot_bolt", function(q) {
	q.m.AdditionalAccuracy = 15;
	q.m.AdditionalHitChance = -3;

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
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " bolts left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Needs a non-empty quiver of bolts equipped")
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Must be reloaded before shooting again")
			});
		}

		return ret;
	}

	// Overwrite vanilla function to remove changing of this.m.AdditionalAccuracy and this.m.DirectDamageMult
	q.onAfterUpdate = @() function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
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
