::mods_hookExactClass("skills/actives/shoot_bolt", function(o) {
	o.m.AdditionalAccuracy <- 15;
	o.m.AdditionalHitChance <- -3;
	
	// Overwrite vanilla function to set the IsHidden of reload_bolt to false instead of adding it
	// Because we have changed reload_bolt to no longer remove itself in its onUse and instead become Hidden
	o.onUse = function( _user, _targetTile	)
	{
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);

		local reload = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reload != null)
		{
			reload.m.IsHidden = false;
		}

		return ret;
	}

	// Overwrite the vanilla function to prevent removal of reload_bolt
	o.onRemoved = function()
	{
	}

	o.getTooltip = function()
	{
		local ret = this.getRangedTooltip(this.skill.getDefaultTooltip());

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + ::Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Must be reloaded before shooting again[/color]"
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

			if (_properties.IsSharpshooter)
			{
				_properties.DamageDirectMult += 0.05;
			}
		}
	}
});
