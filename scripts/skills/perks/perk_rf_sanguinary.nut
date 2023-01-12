this.perk_rf_sanguinary <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueCostRefundPercentage = 25,
		IsHitHandlingComplete = true,
		WasBleeding = false
	},
	function create()
	{
		this.m.ID = "perk.rf_sanguinary";
		this.m.Name = ::Const.Strings.PerkName.RF_Sanguinary;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Sanguinary;
		this.m.Icon = "ui/perks/rf_sanguinary.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatalityChanceMult *= 1.5;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsHitHandlingComplete = false;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.m.IsAttackValid) this.m.WasBleeding = _targetEntity.getSkills().hasSkill("effects.bleeding");
	}

	// Handles cases where target is already bleeding before the hit
	// Note: Cannot use this function to check for bleeding applied by the attack's onUse function if
	// the bleeding is applied after attackEntity e.g. vanilla cleave skill
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.IsHitHandlingComplete || !this.isAttackValid(_skill, this.getContainer().getActor(), _targetEntity))
			return;

		if (_targetEntity.isAlive() && this.m.WasBleeding)
		{
			local actor = this.getContainer().getActor();
			if (actor.getMoraleState() < ::Const.MoraleState.Steady && actor.getMoraleState() != ::Const.MoraleState.Fleeing)
			{
				actor.setMoraleState(actor.getMoraleState() + 1);
				this.spawnIcon("perk_rf_sanguinary", actor.getTile());
			}

			this.m.IsHitHandlingComplete = true;
		}
	}

	// Handles cases where Bleeding is applied by the attack e.g. during cleave skill's onUse function
	// Note: Is unable to handle bleeding applied by "scheduledEvent" attacks
	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsHitHandlingComplete || !this.isAttackValid(_skill, this.getContainer().getActor(), _targetEntity))
			return;

		if (_targetEntity.isAlive() && _targetEntity.getSkills().hasSkill("effects.bleeding"))
		{
			local actor = this.getContainer().getActor();
			if (actor.getMoraleState() < ::Const.MoraleState.Steady && actor.getMoraleState() != ::Const.MoraleState.Fleeing)
			{
				actor.setMoraleState(actor.getMoraleState() + 1);
				this.spawnIcon("perk_rf_sanguinary", actor.getTile());
			}

			this.m.IsHitHandlingComplete = true;
		}
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_fatalityType != ::Const.FatalityType.None && _skill != null && _killer != null && _killer.getID() == this.getContainer().getActor().getID() && this.isAttackValid(_skill, _killer, _victim))
		{
			local fatigueCostRefund = ::Math.floor(_skill.m.FatigueCost * this.m.FatigueCostRefundPercentage * 0.01);
			_killer.setFatigue(::Math.max(0, _killer.getFatigue() - fatigueCostRefund));
			if (_killer.getMoraleState() < ::Const.MoraleState.Confident && _killer.getMoraleState() != ::Const.MoraleState.Fleeing)
			{
				_killer.setMoraleState(::Const.MoraleState.Confident);
				_skill.spawnIcon("perk_rf_sanguinary", _killer.getTile());
			}
		}
	}

	function isAttackValid( _skill, _attacker, _targetEntity )
	{
		return !_skill.isRanged() && _skill.isAttack() && ::Tactical.TurnSequenceBar.isActiveEntity(_attacker) && _targetEntity != null && !_targetEntity.isAlliedWith(_attacker);
	}
});
