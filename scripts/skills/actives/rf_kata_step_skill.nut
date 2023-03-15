this.rf_kata_step_skill <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true,
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "actives.rf_kata_step";
		this.m.Name = "Kata Step";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Use the flow of your sword\'s swings to take a step through [Zone of Control|Concept.ZoneOfControl] without triggering attacks of opportunity. Can only be used immediately after a successful attack.");
		this.m.Icon = "skills/rf_kata_step_skill.png";
		this.m.IconDisabled = "skills/rf_kata_step_skill_bw.png";
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
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_KataStep;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
		{
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Costs [color=" + ::Const.UI.Color.PositiveValue + "]2[/color] fewer Action Points than the movement cost of the starting tile"
			});
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Builds Fatigue equal to the movement cost of the starting tile"
			});
		}
		else
		{
			tooltip.push({
				id = 3,
				type = "text",
				text = this.getCostString()
			});
		}

		if (!this.isEnabled())
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Requires a Two-Handed Sword or a double gripped One-Handed sword[/color]"
			});
		}

		if (actor.isPlacedOnMap())
		{
			if (actor.getCurrentProperties().IsRooted)
			{
				tooltip.push({
					id = 9,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used while rooted[/color]"
				});
			}

			if (!this.anAdjacentEmptyTileHasAdjacentEnemy(actor.getTile()))
			{
				tooltip.push({
					id = 9,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + ::Const.UI.Color.NegativeValue + "]Requires an empty tile adjacent to an enemy[/color]"
				});
			}

			if (this.m.IsSpent)
			{
				tooltip.push({
					id = 9,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can only be used immediately after a successful attack[/color]"
				});
			}
		}

		return tooltip;
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
		if (this.m.IsForceEnabled) return true;

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Sword))
			return false;

		if (!this.getContainer().getActor().isDoubleGrippingWeapon() && !weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			local bladeDancerPerk = this.getContainer().getSkillByID("perk.rf_swordmaster_blade_dancer");
			if (bladeDancerPerk == null || !bladeDancerPerk.isEnabled())
			{
				return false;
			}
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

	function onAfterUpdate ( _properties )
	{
		this.m.FatigueCost = 0;
		this.m.ActionPointCost = 0;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local myTile = actor.getTile();
			if (myTile != null)
			{
				this.m.FatigueCost = ::Math.max(0, (actor.getFatigueCosts()[myTile.Type] + _properties.MovementAPCostAdditional) * _properties.MovementAPCostMult);
				this.m.ActionPointCost = ::Math.max(0, (actor.getActionPointCosts()[myTile.Type] + _properties.MovementFatigueCostAdditional - 2) * _properties.MovementFatigueCostMult);
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.isEnabled() && _skill.isAttack() && _skill.getItem() != null &&
			_skill.getItem().getID() == this.getContainer().getActor().getMainhandItem().getID() &&
			::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor())
			)
		{
			this.m.IsSpent = false;
		}
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().m.IsMoving)
		{
			this.m.IsSpent = true;
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill != this) this.m.IsSpent = true;
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
});
