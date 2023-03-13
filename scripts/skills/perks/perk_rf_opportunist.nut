this.perk_rf_opportunist <- ::inherit("scripts/skills/skill", {
	m = {
		APRecovered = 4,
		FatCostRed = 50,
		IsPrimed = false,
		AttacksRemaining = 2,
	},
	function create()
	{
		this.m.ID = "perk.rf_opportunist";
		this.m.Name = ::Const.Strings.PerkName.RF_Opportunist;
		this.m.Description = "This character wastes no opportunity to pull a weapon out of an enemy\'s corpse, only to launch it towards another!";
		this.m.Icon = "ui/perks/rf_opportunist.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.m.IsPrimed && this.m.AttacksRemaining == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.AttacksRemaining > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next " + ::MSU.Text.colorGreen(this.m.AttacksRemaining) + " throwing attack(s) in this battle have their Action Point costs halved"
			});
		}

		if (this.m.IsPrimed)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "The next throwing attack builds " + ::MSU.Text.colorGreen(this.m.FatCostRed + "%") + " less Fatigue"
			});

			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("The fatigue reduction will expire upon waiting or ending the turn, swapping your weapon, or using any skill")
			});
		}

		return tooltip;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_corpseTile != null && _corpseTile.IsCorpseSpawned)
		{
			_corpseTile.Properties.get("Corpse").IsValidForOpportunist <- true;
		}
	}

	function canProcOntile( _tile )
	{
		if (!_tile.IsCorpseSpawned) return false;

		// TEMPORARY: The ("IsValidForOpportunist" in corpse) check is done because of an issue in MSU where onOtherActorDeath is only called via
		// base actor.nut onDeath function and when a goblin_wolfrider dies and spawns a wolf corpse, it doesn't call the base onDeath function,
		// which means that the event doesn't get called and therefore the IsValidForOpportunist key does not get added to the corpse.
		// Once MSU implements a "hookLeaves" way to do onOtherActorDeath it should no longer be necessary. -- LordMidas
		local corpse = _tile.Properties.get("Corpse");
		return ("IsValidForOpportunist" in corpse) && corpse.IsValidForOpportunist && this.getContainer().getActor().getAlliedFactions().find(corpse.Faction) == null;
	}

	function onQueryTileTooltip( _tile, _tooltip )
	{
		if (this.canProcOntile(_tile))
		{
			_tooltip.push({
				id = 90,
				type = "text",
				icon = this.m.Icon,
				text = "Can be used for " + ::MSU.Text.colorGreen(this.getName())
			});
		}
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing) || weapon.getAmmoMax() == 0)
		{
			return false;
		}

		return true;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || !this.isEnabled() || !::Tactical.TurnSequenceBar.isActiveEntity(actor))
		{
			return;
		}

		if (actor.m.IsMoving)
		{
			local tile = actor.getTile();

			if (tile == null || !this.canProcOntile(tile))
			{
				return;
			}

			local weapon = actor.getMainhandItem();

			weapon.setAmmo(::Math.min(weapon.getAmmoMax(), weapon.getAmmo() + 1));
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			actor.setDirty(true);
			this.spawnIcon("perk_rf_opportunist", tile);
			tile.Properties.get("Corpse").IsValidForOpportunist = false;

			this.m.IsPrimed = true;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.isEnabled())
		{
			foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
			{
				if (skill.isAttack() && skill.isRanged())
				{
					if (this.m.IsPrimed)
					{
						skill.m.FatigueCostMult *= this.m.FatCostRed * 0.01;
					}

					if (this.getContainer().getActor().isPlacedOnMap() && this.m.AttacksRemaining > 0 && skill.m.ActionPointCost > 1)
					{
						skill.m.ActionPointCost /= 2;
					}
				}
			}
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsPrimed = false;
	}

	function onAnySkillExecuted ( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsPrimed = false;
		if (_skill.isAttack() && _skill.isRanged() && _skill.m.IsWeaponSkill && this.isEnabled())
		{
			this.m.AttacksRemaining = ::Math.max(0, this.m.AttacksRemaining - 1);
		}
	}

	function onTurnEnd()
	{
		this.m.IsPrimed = false;
	}

	function onWaitTurn()
	{
		this.m.IsPrimed = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsPrimed = false;
		this.m.AttacksRemaining = 2;
	}
});
