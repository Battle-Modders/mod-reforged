this.perk_rf_deep_cuts <- ::inherit("scripts/skills/skill", {
	m = {
		ThresholdToInflictInjuryMult = 0.66,

		__NumInjuriesBefore = 0,
		__TargetID = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_deep_cuts";
		this.m.Name = ::Const.Strings.PerkName.RF_DeepCuts;
		this.m.Description = "This character is prepared to deal a particularly deep cut on the next attack against the same target.";
		this.m.Icon = "ui/perks/perk_rf_deep_cuts.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.__TargetID == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local e = ::Tactical.getEntityByID(this.m.__TargetID);
		if (e != null && e.isAlive())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next " + ::MSU.Text.colorDamage("cutting") + " attack(s) this turn against " + ::MSU.Text.colorNegative(e.getName()) + " have a " + ::MSU.Text.colorizeMultWithText(this.m.ThresholdToInflictInjuryMult, {Text = ["higher", "lower"]}) + " [threshold|Concept.InjuryThreshold] to inflict [injuries|Concept.InjuryTemporary]")
			});

			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("These attacks also inflict [Bleeding|Skill+bleeding_effect] when dealing at least " + ::MSU.Text.colorDamage(::Const.Combat.MinDamageToApplyBleeding) + " damage to [Hitpoints|Concept.Hitpoints]")
			});

			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Will expire upon attacking another target, moving, swapping an item, [waiting|Concept.Wait] or ending a [turn|Concept.Turn], or using any skill except a cutting attack"))
			});
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && this.m.__TargetID == _targetEntity.getID() && this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			_properties.ThresholdToInflictInjuryMult *= this.m.ThresholdToInflictInjuryMult;
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.m.__TargetID == _targetEntity.getID())
			this.m.__NumInjuriesBefore = _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		// Switching targets, set the target to the new target, and wait for next attack.
		if (this.m.__TargetID != _targetEntity.getID())
		{
			this.m.__TargetID = _targetEntity.getID();
			return;
		}

		if (!_targetEntity.isAlive() || _damageInflictedHitpoints < ::Const.Combat.MinDamageToApplyBleeding)
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
			return;

		local actor = this.getContainer().getActor();
		_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));

		if (_targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len() > this.m.__NumInjuriesBefore)
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// Set __TargetID to 0 if switching targets, using an invalid skill, or not being the active entity
		if (_targetEntity == null || this.m.__TargetID != _targetEntity.getID() || _targetEntity.getCurrentProperties().IsImmuneToBleeding || !this.isSkillValid(_skill)
			|| !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.m.__TargetID = 0;
			return;
		}

		this.m.__TargetID = _targetEntity.getID();
	}

	function onTurnEnd()
	{
		this.m.__TargetID = 0;
	}

	function onWaitTurn()
	{
		this.m.__TargetID = 0;
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.__TargetID = 0;
	}

	function onMovementFinished()
	{
		this.m.__TargetID = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.__TargetID = 0;
	}

	function isSkillValid( _skill )
	{
		return _skill.isAttack() && _skill.getDamageType().contains(::Const.Damage.DamageType.Cutting);
	}
});
