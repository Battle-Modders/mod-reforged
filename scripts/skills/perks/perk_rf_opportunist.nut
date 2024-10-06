this.perk_rf_opportunist <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueCostMult = 0.5,
		IsPrimed = false,
		AttacksRemaining = 2,
		TurnsRemaining = 2
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
		return !this.getContainer().getActor().isPlacedOnMap() || (!this.m.IsPrimed && (this.m.AttacksRemaining == 0 || this.m.TurnsRemaining == 0));
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local weaponTypeName = ::Const.Items.getWeaponTypeName(::Const.Items.WeaponType.Throwing);

		if (this.m.AttacksRemaining != 0 && this.m.TurnsRemaining != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("The next %i %s attack(s) during this battle have their [Action Point|Concept.ActionPoints] costs %s. This effect expires in %s [turn(s)|Concept.Turn]", this.m.AttacksRemaining, weaponTypeName, ::MSU.Text.colorPositive("halved"), ::MSU.Text.colorNegative(this.m.TurnsRemaining)))
			});
		}

		if (this.m.IsPrimed)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("The next %s attack before [waiting|Concept.Wait] or ending the [turn|Concept.Turn] costs %s [Action Points|Concept.ActionPoints] and builds %s [Fatigue|Concept.Fatigue]", weaponTypeName, ::MSU.Text.colorPositive("no"), ::MSU.Text.colorizeMultWithText(this.m.FatigueCostMult, {InvertColor = true})))
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
		if (!::Tactical.TurnSequenceBar.isActiveEntity(actor))
			return;

		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.Weapon) || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing) || weapon.getAmmoMax() == 0)
			return;

		weapon.setAmmo(::Math.min(weapon.getAmmoMax(), weapon.getAmmo() + 1));
		this.spawnIcon("perk_rf_opportunist", _tile);
		_tile.Properties.get("Corpse").IsValidForOpportunist = false;

		this.m.IsPrimed = true;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.Weapon) || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			return;

		foreach (skill in weapon.getSkills())
		{
			if (!this.isSkillValid(skill))
				continue;

			if (this.m.IsPrimed)
			{
				skill.m.ActionPointCost = 0;
				skill.m.FatigueCostMult *= this.m.FatigueCostMult;
			}
			else if (this.m.AttacksRemaining != 0 && this.m.TurnsRemaining != 0 && skill.m.ActionPointCost > 1)
			{
				skill.m.ActionPointCost /= 2;
			}
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsPrimed = false;
	}

	function onAnySkillExecuted ( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.AttacksRemaining != 0 && this.isSkillValid(_skill))
		{
			this.m.AttacksRemaining--;
		}
		this.m.IsPrimed = false;
	}

	function onTurnEnd()
	{
		this.m.IsPrimed = false;
		if (this.m.TurnsRemaining != 0)
			this.m.TurnsRemaining--;
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
		this.m.TurnsRemaining = 2;
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || !_skill.isRanged())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Throwing);
	}
});
