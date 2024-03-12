this.rf_take_aim_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DiversionMaxLevelDifference = null,
		FireHandgonneSkill = null // WeakTableRef to allow us to hook the getAffectedTiles function
	},
	function create()
	{
		this.m.ID = "effects.rf_take_aim";
		this.m.Name = "Taking Aim";
		this.m.Description = "This character is expending significant effort into taking a better aim.";
		this.m.Icon = "skills/rf_take_aim_effect.png";
		this.m.IconMini = "rf_take_aim_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "For the next ranged attack:"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Crossbows ignore any hitchance penalty from obstacles, and the shot cannot go astray"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Handgonnes have their Maximum Range increased by 1 and if used at shorter range, have their area of effect increased by 1 instead"
		});

		return tooltip;
	}

	function isEnabled()
	{
		local skill = this.getContainer().getSkillByID("actives.rf_take_aim");
		return skill != null && skill.isEnabled();
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
		{
			_properties.RangedAttackBlockedChanceMult = 0;
		}
	}

	function onAfterUpdate(_properties)
	{
		local fireHandgonne = this.getContainer().getSkillByID("actives.fire_handgonne");
		if (fireHandgonne == null)
			return;

		fireHandgonne.m.MaxRange += 1;

		if (::MSU.isEqual(this.m.FireHandgonneSkill, fireHandgonne))
			return;

		this.m.FireHandgonneSkill = ::MSU.asWeakTableRef(fireHandgonne);

		local getAffectedTiles = fireHandgonne.getAffectedTiles;
		fireHandgonne.getAffectedTiles = function( _targetTile )
		{
			// For targeting beyond 2 tiles keep normal behavior
			if (_targetTile.getDistanceTo(this.getContainer().getActor().getTile()) != 2)
				return getAffectedTiles(_targetTile);

			local ret = [
				_targetTile
			];
			local ownTile = this.getContainer().getActor().getTile();
			local dir = ownTile.getDirectionTo(_targetTile);
			local dist = ownTile.getDistanceTo(_targetTile);

			if (_targetTile.hasNextTile(dir))
			{
				local forwardTile = _targetTile.getNextTile(dir);

				if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}

				if (forwardTile.hasNextTile(dir))
				{
					forwardTile = forwardTile.getNextTile(dir);

					if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
					{
						ret.push(forwardTile);
					}
				}
			}

			local left = dir - 1 < 0 ? 5 : dir - 1;

			if (_targetTile.hasNextTile(left))
			{
				local forwardTile = _targetTile.getNextTile(left);

				if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}

				if (forwardTile.hasNextTile(dir))
				{
					forwardTile = forwardTile.getNextTile(dir);

					if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
					{
						ret.push(forwardTile);
					}
				}

				if (forwardTile.hasNextTile(dir))
				{
					forwardTile = forwardTile.getNextTile(dir);

					if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
					{
						ret.push(forwardTile);
					}
				}
			}

			local right = dir + 1 > 5 ? 0 : dir + 1;

			if (_targetTile.hasNextTile(right))
			{
				local forwardTile = _targetTile.getNextTile(right);

				if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}

				if (forwardTile.hasNextTile(dir))
				{
					forwardTile = forwardTile.getNextTile(dir);

					if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
					{
						ret.push(forwardTile);
					}
				}

				if (forwardTile.hasNextTile(dir))
				{
					forwardTile = forwardTile.getNextTile(dir);

					if (::Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
					{
						ret.push(forwardTile);
					}
				}
			}

			return ret;
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.DiversionMaxLevelDifference = null;
		
		if (_skill.isAttack() && _skill.isRanged())
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
			{
				this.m.DiversionMaxLevelDifference = ::Const.Combat.DiversionMaxLevelDifference;
				::Const.Combat.DiversionMaxLevelDifference = -100;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.DiversionMaxLevelDifference != null)
		{
			::Const.Combat.DiversionMaxLevelDifference = this.m.DiversionMaxLevelDifference;
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
