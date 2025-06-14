this.perk_rf_vigorous_assault <- ::inherit("scripts/skills/skill", {
	m = {
		BonusEveryXTiles = 2,
		NumTilesMoved = 0,

		// Is incremented during previewing skills to add additional stacks
		// so affordability of skills is calculated properly
		NumTilesMovedPreview = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_vigorous_assault";
		this.m.Name = ::Const.Strings.PerkName.RF_VigorousAssault;
		this.m.Description = "The momentum of this character\'s movement lends to an easier and faster attack.";
		this.m.Icon = "ui/perks/perk_rf_vigorous_assault.png";
		this.m.IconMini = "perk_rf_vigorous_assault_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.getNumTilesMoved() / this.m.BonusEveryXTiles == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local actionPointCostModifier = this.getActionPointCostModifier();
		if (actionPointCostModifier != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next attack costs " + ::MSU.Text.colorizeValue(actionPointCostModifier, {AddSign = true, InvertColor = true}) + " [Action Point(s)|Concept.ActionPoints]")
			});
		}

		local fatigueCostMultMult = this.getFatigueCostMultMult();
		if (fatigueCostMultMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next attack builds up " + ::MSU.Text.colorizeMultWithText(this.getFatigueCostMultMult(), {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon [waiting|Concept.Wait] or ending the [turn|Concept.Turn], using any skill, or swapping any item except to/from a throwing weapon")
		});

		return ret;
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
		{
			return false;
		}

		local weapon = actor.getMainhandItem();
		return weapon != null && weapon.isItemType(::Const.Items.ItemType.Weapon) && (weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) || weapon.isWeaponType(::Const.Items.WeaponType.Throwing));
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.isPreviewing() && actor.getPreviewSkill() != null) // The effect of this skill expires upon using any skill, so we reflect that in the preview
			return;

		if (!this.isEnabled())
			return;

		this.m.NumTilesMovedPreview = actor.isPreviewing() ? actor.getPreviewMovement().Tiles : 0;

		// Reduce the AP cost preemptively by assuming a movement of this.m.BonusEveryXTiles for AI to allow for
		// AI behaviors which check for AP cost of attacks for setting tile scores when calculating where to go
		if (!actor.isPlayerControlled() && this.getNumTilesMoved() < this.m.BonusEveryXTiles && ::Tactical.TurnSequenceBar.isActiveEntity(actor))
		{
			local aoo = this.getContainer().getAttackOfOpportunity();
			if (aoo != null)
			{
				local numEnemiesInRange = 0;
				local numEnemiesApproachable = 0;
				local myTile = actor.getTile();

				foreach (faction, actors in ::Tactical.Entities.getAllInstances())
				{
					if (actor.isAlliedWith(faction))
						continue;

					foreach (enemy in actors)
					{
						if (!enemy.isPlacedOnMap())
							continue;

						local distance = enemy.getTile().getDistanceTo(myTile);
						if (distance <= aoo.getMaxRange())
						{
							numEnemiesInRange++;
							break;
						}

						if (distance >= this.m.BonusEveryXTiles + aoo.getMaxRange())
						{
							numEnemiesApproachable++;
						}
					}

				}

				if (numEnemiesInRange == 0 && numEnemiesApproachable > 0)
				{
					this.m.NumTilesMoved = this.m.BonusEveryXTiles;
				}
			}
		}

		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			if (this.isSkillValid(skill))
			{
				if (skill.m.ActionPointCost > 1)
				{
					skill.m.ActionPointCost = ::Math.max(1, skill.m.ActionPointCost + this.getActionPointCostModifier());
				}
				skill.m.FatigueCostMult *= this.getFatigueCostMultMult();
			}
		}
	}

	function getNumTilesMoved()
	{
		return this.m.NumTilesMoved + this.m.NumTilesMovedPreview;
	}

	function getActionPointCostModifier()
	{
		return -this.getNumTilesMoved() / this.m.BonusEveryXTiles;
	}

	function getFatigueCostMultMult()
	{
		return ::Math.maxf(0.0, 1.0 - 0.1 * (this.getNumTilesMoved() / this.m.BonusEveryXTiles));
	}

	function onMovementStarted( _tile, _numTiles )
	{
		this.m.NumTilesMoved += _numTiles;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.NumTilesMoved = 0;
	}

	function onWaitTurn()
	{
		this.m.NumTilesMoved = 0;
	}

	function onResumeTurn()
	{
		this.m.NumTilesMoved = 0;
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

		this.m.NumTilesMoved = 0;
	}

	function onTurnStart()
	{
		this.m.NumTilesMoved = 0;
	}

	function onTurnEnd()
	{
		this.m.NumTilesMoved = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.NumTilesMoved = 0;
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack())
			return false;

		if (!_skill.isRanged())
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Throwing);
	}
});
