this.perk_rf_whirling_death <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Flail,
		Stacks = 0,
		IsPerformingExtraAttack = false, // Is flipped during the extra attack to reduce its damage using onAnySkillUsed
		DamageTotalMult = 0.5, // Multiplier for the damage dealt during the extra attack
		ChanceToHitHeadPerReachDiff = 10 // Is used for two-handed flails
	},
	function create()
	{
		this.m.ID = "perk.rf_whirling_death";
		this.m.Name = ::Const.Strings.PerkName.RF_WhirlingDeath;
		this.m.Description = "This character\'s attacks are like a whirlwind, making it very dangerous to be near them.";
		this.m.Icon = "ui/perks/rf_whirling_death.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.Stacks) + " [Reach|Concept.Reach]")
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Will expire upon swapping your weapon!"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Reach += this.m.Stacks;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsPerformingExtraAttack)
			_properties.DamageTotalMult *= this.m.DamageTotalMult;

		local weapon = _skill.getItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded) && this.isSkillValid(_skill))
		{
			local reachDiff = this.getContainer().getActor().getCurrentProperties().getReach() - _targetEntity.getCurrentProperties().getReach();
			if (reachDiff > 0)
				_properties.HitChance[::Const.BodyPart.Head] += reachDiff * this.m.ChanceToHitHeadPerReachDiff;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.isSkillValid(_skill) && !this.m.IsPerformingExtraAttack)
		{
			this.m.Stacks++;

			if (::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
				this.doExtraAttack(_skill, _targetTile);
		}
	}

	function onTurnStart()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (_item != null && _item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.Stacks = 0;
				return;
			}
		}
	}

	function doExtraAttack( _skill, _primaryTargetTile )
	{
		local user = this.getContainer().getActor();
		local myTile = user.getTile();

		local targets = [];
		for (local i = 0; i < 6; i++)
		{
			if (!myTile.hasNextTile(i))
				continue;

			local nextTile = myTile.getNextTile(i);
			if (!nextTile.IsOccupiedByActor || nextTile.isSameTileAs(_primaryTargetTile))
				continue;

			local entity = nextTile.getEntity();
			if (!entity.isAlliedWith(user) && entity.getCurrentProperties().getReach() < user.getCurrentProperties().getReach() && _skill.onVerifyTarget(myTile, nextTile))
			{
				targets.push(entity)
			}
		}

		if (targets.len() == 0)
			return;

		local target = ::MSU.Array.rand(targets);
		local targetTile = target.getTile();

		if (!user.isHiddenToPlayer() || targetTile.IsVisibleForPlayer)
		{
			this.getContainer().setBusy(true);
			::Time.scheduleEvent(::TimeUnit.Virtual, 100, function ( _perk )
			{
				if (target.isAlive())
				{
					::logDebug("[" + user.getName() + "] is attacking [" + target.getName() + "] with skill [" + _skill.getName() + "] due to " + _perk.m.Name);
					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " has " + _perk.m.Name);
					}

					this.m.IsPerformingExtraAttack = true;
					_skill.useForFree(targetTile);
					this.m.IsPerformingExtraAttack = false;
				}
				this.getContainer().setBusy(false);

			}.bindenv(this), this);
		}
		else
		{
			if (target.isAlive())
			{
				::logDebug("[" + user.getName() + "] is attacking [" + target.getName() + "] with skill [" + _skill.getName() + "] due to " + this.m.Name);

				this.m.IsPerformingExtraAttack = true;
				_skill.useForFree(targetTile);
				this.m.IsPerformingExtraAttack = false;
			}
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || _skill.isRanged())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
