this.perk_rf_sneak_attack <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Enemies = [],
		EnemiesHitWithRanged = []
	},
	function create()
	{
		this.m.ID = "perk.rf_sneak_attack";
		this.m.Name = ::Const.Strings.PerkName.RF_SneakAttack;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SneakAttack;
		this.m.Icon = "ui/perks/rf_sneak_attack.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			return weapon.getReach() <= 4 && this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) >= -20;
		}

		return true;
	}

	function onMovementStarted( _tile, _numTiles )
	{
		this.m.Enemies.clear();
	}

	function onMovementFinished( _tile )
	{
		foreach (tile in ::MSU.Tile.getNeighbors(_tile))
		{
			if (tile.IsOccupiedByActor)
				this.m.Enemies.push(tile.getEntity().getID());
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !this.isEnabled())
			return;

		if (!_skill.isRanged())
		{
			if (this.m.Enemies.find(_targetEntity.getID()) != null)
			{
				_properties.DamageDirectAdd += 0.2;
				_properties.DamageTotalMult *= 1.2;
				_properties.Reach += 2;
			}
		}
		else
		{
			if (this.m.EnemiesHitWithRanged.find(_targetEntity.getID()) == null)
			{
				_properties.DamageDirectAdd += 0.1;
				_properties.DamageTotalMult *= 1.15;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity == null || !this.isEnabled())
			return;

		local success = false;
		if (!_skill.isRanged())
		{
			local idx = this.m.Enemies.find(_targetEntity.getID());
			if (idx != null)
			{
				success = true;
				this.m.Enemies.remove(idx);
			}
		}
		else if (this.m.EnemiesHitWithRanged.find(_targetEntity.getID()) == null)
		{
			success = true;
			this.m.EnemiesHitWithRanged.push(_targetEntity.getID());
		}

		if (success) ::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " performed a Sneak Attack");
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker != null) this.m.EnemiesHitWithRanged.push(_attacker.getID());
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!this.isEnabled()) return;

		local targetEntity = _targetTile.getEntity();
		if (targetEntity == null) return;

		if ((!_skill.isRanged() && this.m.Enemies.find(targetEntity.getID()) != null) ||
			(_skill.isRanged() && this.m.EnemiesHitWithRanged.find(targetEntity.getID()) == null))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.Enemies.clear();
	}

	function onWaitTurn()
	{
		this.m.Enemies.clear();
	}

	function onTurnEnd()
	{
		this.m.Enemies.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Enemies.clear();
		this.m.EnemiesHitWithRanged.clear();
	}
});
