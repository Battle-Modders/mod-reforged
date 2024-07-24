this.perk_rf_vigorous_assault <- ::inherit("scripts/skills/skill", {
	m = {
		BonusEveryXTiles = 2,
		APReduction = 1,
		FatCostReduction = 10,
		StartingTile = null,
		IsIconSet = false,
		CurrAPBonus = 0,
		CurrFatBonus = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_vigorous_assault";
		this.m.Name = ::Const.Strings.PerkName.RF_VigorousAssault;
		this.m.Description = "The momentum of this character\'s movement lends to an easier and faster attack.";
		this.m.Icon = "ui/perks/perk_rf_vigorous_assault.png";
		this.m.IconMini = "perk_rf_vigorous_assault_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function isHidden()
	{
		return this.m.CurrAPBonus == 0 && this.m.CurrFatBonus == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.CurrAPBonus > 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next attack costs " + ::MSU.Text.colorPositive("-" + this.m.CurrAPBonus) + " [Action Point(s)|Concept.ActionPoints]")
			});
		}

		if (this.m.CurrFatBonus > 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next attack builds up " + ::MSU.Text.colorizePercentage(this.m.CurrFatBonus) + " less [Fatigue|Concept.Fatigue]")
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
				this.m.Icon = "ui/perks/perk_rf_vigorous_assault_barbarian.png";
				this.m.IconMini = "perk_rf_vigorous_assault_barbarian_mini";
			}

			this.m.IsIconSet = true;
		}
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.isPreviewing() && actor.getPreviewSkill() != null) // The effect of this skill expires upon using any skill, so we reflect that in the preview
			return;

		this.resetBonus();

		if (!this.isEnabled() || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			return;
		}

		local distanceMoved = this.m.StartingTile.getDistanceTo(actor.isPreviewing() ? actor.getPreviewMovement().End : actor.getTile());
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
