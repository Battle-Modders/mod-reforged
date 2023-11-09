this.perk_rf_vigorous_assault <- ::inherit("scripts/skills/skill", {
	m = {
		BonusEveryXTiles = 2,
		APReduction = 1,
		FatCostReduction = 10,
		StartingTile = null,
		IsIconSet = false,
		CurrAPBonus = 0,
		CurrFatBonus = 0,
	},
	function create()
	{
		this.m.ID = "perk.rf_vigorous_assault";
		this.m.Name = ::Const.Strings.PerkName.RF_VigorousAssault;
		this.m.Description = "The momentum of this character\'s movement lends to an easier and faster attack.";
		this.m.Icon = "ui/perks/rf_vigorous_assault.png";
		this.m.IconMini = "rf_vigorous_assault_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		// Always show on AI entities so the player is not surprised
		return this.getContainer().getActor().isPlayerControlled() && this.m.CurrAPBonus == 0 && this.m.CurrFatBonus == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.CurrAPBonus > 0)
		{
			tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/icons/action_points.png",
					text = "The next attack costs [color=" + ::Const.UI.Color.PositiveValue + "]-" + this.m.CurrAPBonus + "[/color] Action Point(s)"
				}
			);
		}

		if (this.m.CurrFatBonus > 0)
		{
			tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "The next attack builds up " + ::MSU.Text.colorizePercentage(this.m.CurrFatBonus) + " less Fatigue"
				}
			);
		}

		tooltip.push(
			{
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Will expire upon waiting or ending the turn, using any skill, or swapping any item except to/from a throwing weapon")
			}
		);

		return tooltip;
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || this.m.StartingTile == null)
		{
			return false;
		}

		local weapon = actor.getMainhandItem();
		if (weapon != null && (!weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) && !weapon.isWeaponType(::Const.Items.WeaponType.Throwing)))
		{
			return false;
		}

		return true;
	}

	function onNewRound()
	{
		if (!this.m.IsIconSet)
		{
			if (this.getContainer().getActor().getFaction() == ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians).getID())
			{
				this.m.Icon = "ui/perks/rf_vigorous_assault_barbarian.png";
				this.m.IconMini = "rf_vigorous_assault_barbarian_mini";
			}

			this.m.IsIconSet = true;
		}
	}

	function onAfterUpdate( _properties )
	{
		this.resetBonus();

		if (!this.isEnabled() || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local distanceMoved = this.m.StartingTile.getDistanceTo(actor.getTile());
		local aoo = this.getContainer().getAttackOfOpportunity();

		local mult = distanceMoved / this.m.BonusEveryXTiles;

		// Reduce the AP cost preemptively by assuming a movement of this.m.BonusEveryXTiles for AI to allow for
		// AI behaviors which check for AP cost of attacks for setting tile scores when calculating where to go
		if (!actor.isPlayerControlled() && aoo != null && distanceMoved < this.m.BonusEveryXTiles)
		{
			local myTile = actor.getTile();
			local actors = ::Tactical.Entities.getAllInstancesAsArray();

			local numEnemiesInRange = 0;
			local numEnemiesApproachable = 0;

			foreach (a in actors)
			{
				if (!a.isAlliedWith(actor))
				{
					local distance = a.getTile().getDistanceTo(myTile);

					if (distance == aoo.getMaxRange())
					{
						numEnemiesInRange++;
						break;
					}

					if (distance == this.m.BonusEveryXTiles + aoo.getMaxRange())
					{
						numEnemiesApproachable++;
					}
				}
			}

			if (numEnemiesInRange == 0 && numEnemiesApproachable > 0)
			{
				mult = 1;
			}
		}

		this.m.CurrAPBonus = this.m.APReduction * mult;
		this.m.CurrFatBonus = this.m.FatCostReduction * mult;

		if (this.m.CurrAPBonus != 0 && this.m.CurrFatBonus != 0)
		{
			foreach (skill in this.getContainer().getSkillsByFunction(@(_skill) _skill.isAttack()))
			{
				skill.m.ActionPointCost -= ::Math.max(0, ::Math.min(skill.m.ActionPointCost - 1, this.m.CurrAPBonus));
				skill.m.FatigueCostMult *= 1.0 - this.m.CurrFatBonus * 0.01;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.StartingTile = this.getContainer().getActor().getTile();
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (!this.isEnabled()) return;

		if (_skill != null)
		{
			foreach (skill in this.getContainer().getSkillsByFunction(@(skill) skill.isAttack()))
	        {
	            this.modifyPreviewField(skill, "ActionPointCost", 0, false);
	            this.modifyPreviewField(skill, "FatigueCostMult", 1, true);
	        }
		}

		if (_movementTile != null)
		{
			local bonus = this.m.StartingTile.getDistanceTo(_movementTile) / this.m.BonusEveryXTiles;

	        foreach (skill in this.getContainer().getSkillsByFunction(@(skill) skill.isAttack()))
	        {
	            this.modifyPreviewField(skill, "ActionPointCost", -1 * ::Math.max(0, ::Math.min(skill.m.ActionPointCost - 1, bonus)), false);
	            this.modifyPreviewField(skill, "FatigueCostMult", 1 - this.m.FatCostReduction * bonus * 0.01, true);
	        }
		}
	}

	function onWaitTurn()
	{
		this.m.StartingTile = null;
		this.resetBonus();
	}

	function onResumeTurn()
	{
		this.m.StartingTile = this.getContainer().getActor().getTile();
		this.resetBonus();
	}

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Weapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				return;
			}
		}

		this.m.StartingTile = this.getContainer().getActor().getTile();
		this.resetBonus();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.StartingTile = null;
		this.resetBonus();
	}

	function onTurnStart()
	{
		this.m.StartingTile = this.getContainer().getActor().getTile();
		this.resetBonus();
	}

	function onTurnEnd()
	{
		this.m.StartingTile = null;
		this.resetBonus();
	}

	function resetBonus()
	{
		this.m.CurrAPBonus = 0;
		this.m.CurrFatBonus = 0;
	}
});
