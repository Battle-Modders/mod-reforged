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
		this.m.Description = "This character is ready to deliver a deadly surprise."
		this.m.Icon = "ui/perks/rf_sneak_attack.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.getContainer().getActor().isArmedWithRangedWeapon())
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Against targets you have not previously attacked or who have not previously attacked you, gain:"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("15%") + " increased damage"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorGreen("+10%") + " armor penetration"
				}
			]);
		}
		else
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "When you end your movement adjacent to an enemy, the next attack against that enemy gains:"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/reach.png",
					text = ::MSU.Text.colorGreen("+2") + " Reach"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorGreen("25%") + " increased damage"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::MSU.Text.colorGreen("+20%") + " armor penetration"
				}
			]);
		}

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("Will be lost upon swapping an item or waiting or ending your turn")
		});

		return tooltip;
	}

	function isHidden()
	{
		return !this.isEnabled();
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
