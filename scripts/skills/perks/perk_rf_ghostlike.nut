this.perk_rf_ghostlike <- ::inherit("scripts/skills/skill", {
	m = {
		WeaponReach = 4,
		ArmorStaminaModifier = -20,
		DamageTotalMult = 1.25,
		DirectDamageModifier = 0.2,
		Enemies = []
	},
	function create()
	{
		this.m.ID = "perk.rf_ghostlike";
		this.m.Name = ::Const.Strings.PerkName.RF_Ghostlike;
		this.m.Description = "Blink and you\'ll miss me.";
		this.m.Icon = "ui/perks/perk_rf_ghostlike.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.Enemies.len() == 0 && !this.getContainer().getActor().getCurrentProperties().IsImmuneToZoneOfControl;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.getContainer().getActor().getCurrentProperties().IsImmuneToZoneOfControl)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next movement will ignore [Zone of Control|Concept.ZoneOfControl]")
			});
		}

		if (this.m.Enemies.len() != 0)
		{
			local enemies = [];
			foreach (enemy in this.m.Enemies)
			{
				local enemy = ::Tactical.getEntityByID(enemy);
				if (enemy == null || !enemy.isPlacedOnMap() || !enemy.isAlive())
					continue;

				enemies.push({
					id = 12,
					type = "text",
					icon = "ui/orientation/" + enemy.getOverlayImage() + ".png",
					text = enemy.getName()
				});
			}

			if (enemies.len() != 0)
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::MSU.Text.colorizeMult(this.m.DamageTotalMult) + " more damage and " + ::MSU.Text.colorizePct(this.m.DirectDamageModifier, {AddSign = true}) + " damage ignoring armor against:",
					children = enemies
				});

				ret.push({
					id = 13,
					type = "text",
					icon = "ui/icons/warning.png",
					text = ::Reforged.Mod.Tooltips.parseString("The damage bonus will be lost upon swapping an item or [waiting|Concept.Wait] or ending your [turn|Concept.Turn]")
				});
			}
		}

		return ret;
	}

	function hasValidStaminaModifier()
	{
		return this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) >= this.m.ArmorStaminaModifier;
	}

	function isZOCIgnoreEnabled()
	{
		return this.hasValidStaminaModifier();
	}

	function isDamageEnabled()
	{
		if (!this.hasValidStaminaModifier())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null || (weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) && weapon.getReach() <= this.m.WeaponReach);
	}

	function onUpdate( _properties )
	{
		if (!this.isZOCIgnoreEnabled())
			return;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local numAllies = 0;
			local numEnemies = 0;
			local myTile = actor.getTile();
			foreach (faction in ::Tactical.Entities.getAllInstances())
			{
				foreach (otherActor in faction)
				{
					if (!otherActor.isPlacedOnMap() || otherActor.getTile().getDistanceTo(myTile) != 1)
						continue;

					if (otherActor.isAlliedWith(actor)) numAllies++;
					else numEnemies++;
				}
			}
			if (numAllies >= numEnemies)
			{
				_properties.IsImmuneToZoneOfControl = true;
			}
		}
	}

	function onMovementStarted( _tile, _numTiles )
	{
		this.m.Enemies.clear();
	}

	function onMovementFinished( _tile )
	{
		if (!this.isDamageEnabled())
			return;

		foreach (tile in ::MSU.Tile.getNeighbors(_tile))
		{
			if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWith(this.getContainer().getActor()))
			{
				this.m.Enemies.push(tile.getEntity().getID());
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !this.isDamageEnabled())
			return;

		if (this.m.Enemies.find(_targetEntity.getID()) != null)
		{
			_properties.DamageDirectAdd += this.m.DirectDamageModifier;
			_properties.DamageTotalMult *= this.m.DamageTotalMult;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.removeEnemy(_targetEntity);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeEnemy(_targetEntity);
	}

	function removeEnemy( _entity )
	{
		local idx = this.m.Enemies.find(_entity.getID());
		if (idx != null)
			this.m.Enemies.remove(idx);
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!this.isDamageEnabled())
			return;

		local targetEntity = _targetTile.getEntity();
		if (targetEntity == null)
			return;

		if (this.m.Enemies.find(targetEntity.getID()) != null)
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
	}
});
