::Reforged.HooksMod.hook("scripts/skills/actives/fire_handgonne_skill", function(q) {
	q.m.AdditionalAccuracy = 10;
	q.m.AdditionalHitChance = -10;

	// Overwrite vanilla function to prevent repeated adding of reload skill
	q.onUse = @() function( _user, _targetTile	)
	{
		::Sound.play(this.m.SoundOnFire[::Math.rand(0, this.m.SoundOnFire.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, _user.getPos());
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};
		::Time.scheduleEvent(::TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		this.getItem().setLoaded(false);

		return true;
	}

	// Overwrite the vanilla function to prevent removal of reload skill
	q.onRemoved = @() function()
	{
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 6 targets"
		});

		local rangedTooltip = this.getRangedTooltip();
		rangedTooltip[rangedTooltip.len() - 1].text += ". This chance is unaffected by objects or characters in the line of fire."

		ret.extend(rangedTooltip);

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + ::Const.UI.Color.PositiveValue + "]" + ammo + "[/color] shots left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Needs a non-empty powder bag equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
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

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

	// Implementation of Extended AOE due to rf_take_aim_effect
	q.getAffectedTiles = @(__original) function( _targetTile )
	{
		// For targeting beyond 2 tiles keep normal behavior
		if (_targetTile.getDistanceTo(this.getContainer().getActor().getTile()) != 2 || !this.getContainer().hasSkill("effects.rf_take_aim"))
		{
			return __original(_targetTile);
		}

		local ret = [
			_targetTile
		];
		local ownTile = this.getContainer().getActor().getTile();

		// The logic below is the same as vanilla's for adding the tiles except we condense it by using a local function
		// and increase the number of tiles that are added in each direction.

		local function addForwardTiles( _tile, _dir, _num )
		{
			while (_num > 0 && _tile.hasNextTile(_dir))
			{
				_tile = _tile.getNextTile(_dir);
				if (::Math.abs(_tile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(_tile);
				}
				_num--;
			}
		}

		local dir = ownTile.getDirectionTo(_targetTile);
		addForwardTiles(_targetTile, dir, 2);

		local left = dir - 1 < 0 ? 5 : dir - 1;
		addForwardTiles(_targetTile, left, 3);

		local right = dir + 1 > 5 ? 0 : dir + 1;
		addForwardTiles(_targetTile, right, 3);

		return ret;
	}
});
