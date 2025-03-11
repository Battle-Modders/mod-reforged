this.rf_kata_step_skill <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Sword,
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		RequireOffhandFree = true, // Require equipping two-handed weapon, or double-grip in effect on one-handed. Is only checked when a RequiredWeaponType is not null.
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "actives.rf_kata_step";
		this.m.Name = "Passing Step";
		this.m.Description = "Move around your opponents combining skillful footwork with the flow of your weapon\'s swings.";
		this.m.Icon = "skills/rf_kata_step_skill.png";
		this.m.IconDisabled = "skills/rf_kata_step_skill_sw.png";
		this.m.Overlay = "rf_kata_step_skill";
		this.m.SoundOnUse = [
			"sounds/combat/footwork_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = -2;
		this.m.FatigueCost = 2;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_KataStep;
	}

	function softReset()
	{
		this.skill.softReset();
		this.resetField("RequiredWeaponType");
		this.resetField("RequiredDamageType");
		this.resetField("RequireOffhandFree");
	}

	// Vanilla does not ensure a non-negative value return (should probably be fixed over at MSU)
	function getActionPointCost()
	{
		return ::Math.max(0, this.skill.getActionPointCost());
	}

	function getCostString()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
			return this.skill.getCostString();

		local ret = "Costs " + (this.m.ActionPointCost == 0 ? "+0" : ::MSU.Text.colorizeValue(this.m.ActionPointCost, {AddSign = true, InvertColor = true})) + " [Action Points|Concept.ActionPoints] and builds ";
		ret += (this.m.FatigueCost == 0 ? "+0" : ::MSU.Text.colorizeValue(this.m.FatigueCost, {AddSign = true, InvertColor = true})) + " [Fatigue|Concept.Fatigue] compared to the movement costs of the starting tile";
		return ::Reforged.Mod.Tooltips.parseString(ret);
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Move to an adjacent tile ignoring [Zone of Control|Concept.ZoneOfControl]")
		});

		if (!this.isEnabled())
		{
			local damageTypeString = this.m.RequiredDamageType == null ? " an attack" : " a " + ::Const.Damage.getDamageTypeName(this.m.RequiredDamageType).tolower() + " attack";
			local weaponTypeString = this.m.RequiredWeaponType == null ? "" : format(" from a %s%s", this.m.RequireOffhandFree ? "double-gripped or two-handed" : "", " " + ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType).tolower());
			if (this.m.RequiredDamageType != null || this.m.RequiredWeaponType != null)
			{
				ret.push({
					id = 20,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = ::MSU.Text.colorNegative(format("Requires%s%s", damageTypeString, weaponTypeString))
				});
			}
		}

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used while rooted")
			});
		}

		if (!actor.isPlacedOnMap() || !this.anAdjacentEmptyTileHasAdjacentEnemy(actor.getTile()))
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Can only be used on an empty tile adjacent to an enemy")
			});
		}

		if (this.m.IsSpent)
		{
			ret.push({
				id = 23,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Can only be used immediately after a successful attack")
			});
		}

		return ret;
	}

	function tileHasAdjacentEnemy( _tile )
	{
		if (_tile == null) return false;

		for (local i = 0; i < 6; i++)
		{
			if (_tile.hasNextTile(i))
			{
				local nextTile = _tile.getNextTile(i);

				if (nextTile.IsOccupiedByActor && ::Math.abs(nextTile.Level - _tile.Level) <= 1)
				{
					if (!nextTile.getEntity().isAlliedWith(this.getContainer().getActor()))
					{
						return true;
					}
				}
			}
		}

		return false;
	}

	function anAdjacentEmptyTileHasAdjacentEnemy( _tile )
	{
		if (_tile == null) return false;

		for (local i = 0; i < 6; i++)
		{
			if (_tile.hasNextTile(i))
			{
				local nextTile = _tile.getNextTile(i);

				if (nextTile.IsEmpty && this.tileHasAdjacentEnemy(nextTile) && ::Math.abs(nextTile.Level - _tile.Level) <= 1)
				{
					return true;
				}
			}
		}

		return false;
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();

		if (this.m.RequiredWeaponType != null)
		{
			if (weapon == null || actor.isDisarmed() || (this.m.RequireOffhandFree && !weapon.isItemType(::Const.Items.ItemType.TwoHanded) && !actor.isDoubleGrippingWeapon()))
				return false;
		}

		if (this.m.RequiredDamageType != null)
		{
			foreach (skill in this.m.RequiredWeaponType != null ? weapon.getSkills() : this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (this.isSkillValid(skill))
					return true;
			}
			return false;
		}

		return true;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted && this.isEnabled() && this.anAdjacentEmptyTileHasAdjacentEnemy(this.getContainer().getActor().getTile());
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty && this.tileHasAdjacentEnemy(_targetTile);
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		this.m.IsSpent = true;
		return true;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local myTile = actor.getTile();
		this.m.ActionPointCost += actor.getActionPointCosts()[myTile.Type];
		this.m.FatigueCost += actor.getFatigueCosts()[myTile.Type];
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.isEnabled() && this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.m.IsSpent = false;
		}
	}

	function onMovementFinished( _tile )
	{
		this.m.IsSpent = true;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill != this && !_forFree) this.m.IsSpent = true;
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsSpent = true;
	}

	function onWaitTurn()
	{
		this.m.IsSpent = true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = true;
	}

	function onCombatStarted()
	{
		this.m.IsSpent = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || _skill.isRanged() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
