this.perk_rf_ghostlike <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false, // true ignores weapon reach and armor weight requirements
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
		this.m.Icon = "ui/perks/rf_ghostlike.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorizeMult(this.m.DamageTotalMult) + " more damage and " + ::MSU.Text.colorizeFraction(this.m.DirectDamageModifier, {AddSign = true}) + " damage ignoring armor against:"
			});

			foreach (enemy in this.m.Enemies)
			{
				local enemy = ::Tactical.getEntityByID(enemy);
				if (enemy == null || !enemy.isPlacedOnMap() || !enemy.isAlive())
					continue;

				ret.push({
					id = 12,
					type = "text",
					icon = "ui/orientation/" + enemy.getOverlayImage() + ".png",
					text = enemy.getName()
				});
			}

			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("The damage bonus will be lost upon swapping an item or waiting or ending your turn")
			});
		}

		return ret;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
			return true;

		if (this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) >= this.m.ArmorStaminaModifier)
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null || weapon.getReach() <= this.m.WeaponReach;
	}

	function onUpdate( _properties )
	{
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
		if (_targetEntity == null || !this.isEnabled())
			return;

		if (this.m.Enemies.find(_targetEntity.getID()) != null)
		{
			_properties.DamageDirectAdd += this.m.DirectDamageModifier;
			_properties.DamageTotalMult *= this.m.DamageTotalMult;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity == null)
			return;

		local idx = this.m.Enemies.find(_targetEntity.getID());
		if (idx != null)
			this.m.Enemies.remove(idx);
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!this.isEnabled())
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
