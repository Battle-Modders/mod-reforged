this.perk_rf_deep_cuts <- ::inherit("scripts/skills/skill", {
	m = {
		TargetID = null,
		NumInjuriesBefore = 0,
		InjuryThresholdReduction = 33
	},
	function create()
	{
		this.m.ID = "perk.rf_deep_cuts";
		this.m.Name = ::Const.Strings.PerkName.RF_DeepCuts;
		this.m.Description = "This character is prepared to deal a particularly deep cut on the next attack against the same target.";
		this.m.Icon = "ui/perks/rf_deep_cuts.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.TargetID == null;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local e = ::Tactical.getEntityByID(this.m.TargetID);
		if (e != null && e.isAlive())
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The next " + ::MSU.Text.colorNegative("cutting") + " attack(s) this turn against " + ::MSU.Text.colorNegative(e.getName()) + " have a " + ::MSU.Text.colorPositive(this.m.InjuryThresholdReduction + "%") + " lower threshold to inflict injury"
			});

			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Will expire upon attacking another target, moving, swapping an item, waiting or ending a turn, or using any skill except a cutting attack")
			});
		}

		return tooltip;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && this.m.TargetID == _targetEntity.getID() && _skill.isAttack() && _skill.getDamageType().contains(::Const.Damage.DamageType.Cutting) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			_properties.ThresholdToInflictInjuryMult *= 1.0 - this.m.InjuryThresholdReduction * 0.01;
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.m.TargetID != null) this.m.NumInjuriesBefore = _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive())
			return;

		// Attacking the same target as previous attack
		if (this.m.TargetID == _targetEntity.getID())
		{
			if (_damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
			{
				local actor = this.getContainer().getActor();
				local effect = ::new("scripts/skills/effects/bleeding_effect");

				if (_targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len() > this.m.NumInjuriesBefore)
				{
					effect.setDamage(10);
				}

				_targetEntity.getSkills().add(effect);

				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " made a particularly Deep Cut inflicting additional Bleeding on " + ::Const.UI.getColorizedEntityName(_targetEntity));
				}
			}
		}
		else // Set our target
		{
			this.m.TargetID = _targetEntity.getID();
			}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// Set TargetID to null if switching targets, using an invalid skill, or not being the active entity
		if (_targetEntity == null || this.m.TargetID != _targetEntity.getID() || !_skill.isAttack() || _targetEntity.getCurrentProperties().IsImmuneToBleeding ||
			!_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting) || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.m.TargetID = null;
			return;
		}

		this.m.TargetID = _targetEntity.getID();
	}

	function onTurnEnd()
	{
		this.m.TargetID = null;
	}

	function onWaitTurn()
	{
		this.m.TargetID = null;
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.TargetID = null;
	}

	function onMovementFinished( _tile )
	{
		this.m.TargetID = null;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.TargetID = null;
	}
});
