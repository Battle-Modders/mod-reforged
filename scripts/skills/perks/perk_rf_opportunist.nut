this.perk_rf_opportunist <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Throwing,
		FatigueCostMult = 0.5,
		IsPrimed = false,
	},
	function create()
	{
		this.m.ID = "perk.rf_opportunist";
		this.m.Name = ::Const.Strings.PerkName.RF_Opportunist;
		this.m.Description = "This character wastes no opportunity to pull a weapon out of an enemy\'s corpse, only to launch it towards another!";
		this.m.Icon = "ui/perks/perk_rf_opportunist.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function isHidden()
	{
		return !this.m.IsPrimed && ::Time.getRound() != 1;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (::Time.getRound() == 1)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Throwing attack(s) during this [turn|Concept.Turn] have their [Action Point|Concept.ActionPoints] costs " + ::MSU.Text.colorPositive("halved"))
			});
		}

		if (this.m.IsPrimed)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next throwing attack before [waiting|Concept.Wait] or ending the [turn|Concept.Turn] costs " + ::MSU.Text.colorPositive("no") + " [Action Points|Concept.ActionPoints] and builds " + ::MSU.Text.colorizeMultWithText(this.m.FatigueCostMult, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
			});
		}

		return ret;
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

		local corpse = _tile.Properties.get("Corpse");
		return corpse.IsValidForOpportunist && this.getContainer().getActor().getAlliedFactions().find(corpse.Faction) == null;
	}

	function onQueryTileTooltip( _tile, _tooltip )
	{
		if (this.canProcOntile(_tile))
		{
			_tooltip.push({
				id = 90,
				type = "text",
				icon = this.m.Icon,
				text = "Can be used for " + ::MSU.Text.colorPositive(this.getName())
			});
		}
	}

	function onMovementFinished( _tile )
	{
		if (!this.canProcOntile(_tile))
			return;

		local actor = this.getContainer().getActor();
		if (!::Tactical.Entities.TurnSequenceBar.isActiveEntity(actor))
			return;

		local weapon = actor.getMainhandItem();
		if (weapon.getAmmoMax() == 0)
			return;

		weapon.setAmmo(::Math.min(weapon.getAmmoMax(), weapon.getAmmo() + 1));
		this.spawnIcon("perk_rf_opportunist", tile);
		_tile.Properties.get("Corpse").IsValidForOpportunist = false;

		this.m.IsPrimed = true;
	}

	function onAfterUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		foreach (skill in weapon.getSkills())
		{
			if (this.isSkillValid(skill))
			{
				if (::Time.getRound() == 1)
				{
					skill.m.ActionPointCost /= 0;
				}
				if (this.m.IsPrimed)
				{
					skill.m.ActionPointCost = 0;
					skill.m.FatigueCostMult *= this.m.FatigueCostMult;
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
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || !_skill.isRanged())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
