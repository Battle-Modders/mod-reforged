// This class combines common properties of the new sling-an-item skills
::Reforged.Skills.adjustSlingItemSkill <- function( o )
{
	o.m.ID = ::MSU.String.replace(o.m.ID, "throw", "sling");
	o.m.Name = ::MSU.String.replace(o.m.Name, "Throw", "Sling");
	o.m.Description = ::MSU.String.replace(::MSU.String.replace(o.m.Description, "throw", "sling"), "Throw", "Sling");
	o.m.Order = ::Const.SkillOrder.UtilityTargeted + 1000;
	o.m.ActionPointCost = 5;	// Flasks have 5
	o.m.FatigueCost = 25;		// Flasks have 20
	o.m.MinRange = 2;			// Flasks have 0
	o.m.MaxRange = 6;			// Flasks have 3
	o.m.MaxLevelDifference = 4;	// Flasks have 3
	o.m.IsRanged = true;	// Causes you to be able to sling further when shooting downhill
	o.m.IsHidden = true;
	o.m.ProjectileTimeScale = 1.0	// Flasks have 1.5 which makes the projectile slower

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
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
				text = ::MSU.Text.colorNegative("Can not be used because this character is engaged in melee")
			});
		}
		return ret;
	}

	// We only show these skills while the respective items are in one of the bag slots
	local isHidden = ::mods_getMember(o, "isHidden");
	::mods_override(o, "isHidden", function() {
		local mainhandItem = this.getContainer().getActor().getMainhandItem();
		if (mainhandItem == null) return isHidden();
		if (mainhandItem.isItemType(::Const.Items.ItemType.Weapon) == false) return isHidden();
		if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sling) == false) return isHidden();
		return false;
	});

	// Overwrite so that the offhand item is not getting deleted
	o.onUse = function( _user, _targetTile )
	{
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(_targetTile) >= ::Const.Combat.SpawnProjectileMinDist)
			{
				::Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.getItem().removeSelf(); // Vanilla unequips the offhand item. But we instead need to consume the respective Item from whereever it is

		local delayPerDistance = 80.0;
		local tileDistance = _user.getTile().getDistanceTo(_targetTile);	// Vanilla uses a fixed
		::Time.scheduleEvent(::TimeUnit.Real, delayPerDistance * tileDistance, this.onApply.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
	}

	local isUsable = o.isUsable;
	o.isUsable = function()
	{
		if (!isUsable()) return false;
		if (this.getContainer().getActor().isEngagedInMelee()) return false;
		return true;
	}

	o.onUpdate = function( _properties )
	{
		local mainhandItem = this.getContainer().getActor().getMainhandItem();
		if (mainhandItem == null) return;
		if (mainhandItem.isItemType(::Const.Items.ItemType.Weapon) == false) return;
		if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sling) == false) return;
		this.m.MinRange = mainhandItem.getRangeMin();
		this.m.MaxRange = mainhandItem.getRangeMax();
	}

	foreach (key, value in o[o.SuperName])
	{
		if (key.find("onApply") != null)	// all of those function names have 'onApply' in common. We just hope that there doesn't exist a second similar named function there
		{
			o.onApply <- value;		// We save function under a common name in our sling-child-class
			break;
		}
	}
}
