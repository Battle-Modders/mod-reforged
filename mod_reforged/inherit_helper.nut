::Reforged.InheritHelper <- {
	function slingItemSkill( _superName )
	{
		return {
			m = {},
			function create()
			{
				this[_superName].create();
				this.m.ID = ::MSU.String.replace(this.m.ID, "throw", "sling");
				this.m.Name = ::MSU.String.replace(this.m.Name, "Throw", "Sling");
				this.m.Description = ::MSU.String.replace(::MSU.String.replace(this.m.Description, "throw", "sling"), "Throw", "Sling");
				this.m.Order = ::Const.SkillOrder.UtilityTargeted + 1000;
				this.m.ActionPointCost = 5;	// Flasks have 5
				this.m.FatigueCost = 25;		// Flasks have 20
				this.m.MinRange = 2;			// Flasks have 0
				this.m.MaxRange = 6;			// Flasks have 3
				this.m.MaxLevelDifference = 4;	// Flasks have 3
				this.m.IsRanged = true;	// Causes you to be able to sling further when shooting downhill
				this.m.IsHidden = true;
				this.m.ProjectileTimeScale = 1.0	// Flasks have 1.5 which makes the projectile slower
			}

			function isHidden()
			{
				local weapon = this.getContainer().getActor().getMainhandItem();
				if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Sling))
				{
					return false;
				}
				return this[_superName].isHidden();
			}

			function getTooltip()
			{
				local ret = this[_superName].getTooltip();
				ret.push({
					id = 8,
					type = "text",
					icon = "ui/icons/vision.png",
					text = "Has a range of " + ::MSU.Text.colorPositive(this.getMaxRange()) + " tiles on even ground, more if slinging downhill"
				});
				if (this.getContainer().getActor().isEngagedInMelee())
				{
					ret.push({
						id = 9,
						type = "text",
						icon = "ui/tooltips/warning.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Can not be used because this character is [engaged in melee|Concept.ZoneOfControl]"))
					});
				}
				return ret;
			}

			function onUse( _user, _targetTile )
			{
				local effectDelay = 1;
				if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
				{
					if (_user.getTile().getDistanceTo(_targetTile) >= ::Const.Combat.SpawnProjectileMinDist)
					{
						local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
						effectDelay = ::Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
					}
				}

				this.getItem().removeSelf(); // Vanilla unequips the offhand item. But we instead need to consume the respective Item from whereever it is

				::Time.scheduleEvent(::TimeUnit.Virtual, effectDelay, this.onApply.bindenv(this), {
					Skill = this,
					User = _user,
					TargetTile = _targetTile
				});
			}

			function isUsable()
			{
				return !this.getContainer().getActor().isEngagedInMelee() && this[_superName].isUsable();
			}

			function onUpdate( _properties )
			{
				this[_superName].onUpdate(_properties);

				local weapon = this.getContainer().getActor().getMainhandItem();
				if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Sling))
				{
					this.m.MinRange = weapon.getRangeMin();
					this.m.MaxRange = weapon.getRangeMax();
				}
			}
		};
	}
};
