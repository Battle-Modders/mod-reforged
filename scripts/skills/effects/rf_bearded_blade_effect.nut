this.rf_bearded_blade_effect <- ::inherit("scripts/skills/skill", {
	m = {
		IsUpdating = false,
		HitChance = 0
	},
	function create()
	{
		this.m.ID = "effects.rf_bearded_blade";
		this.m.Name = "Bearded Blade";
		this.m.Description = "This character is prepared to use the axe\'s bearded blade to disarm an opponent.";
		this.m.Icon = "skills/rf_bearded_blade_effect.png";
		this.m.IconMini = "rf_bearded_blade_effect_mini";
		this.m.Overlay = "rf_bearded_blade_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The next attack has a chance equal to the hit chance to disarm the opponent"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Until your next turn, every attack missed against you has a chance to disarm the attacker equal to the miss chance"
		});
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("Will expire upon attacking or successfully disarming an opponent, or swapping your weapon")
		});

		return tooltip;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.HitChance = 0;
		if (_targetEntity != null && _skill.isAttack() && !_skill.isRanged() && _skill.m.IsWeaponSkill)
		{
			this.m.HitChance = _skill.getHitchance(_targetEntity);
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (!this.m.IsUpdating && !_skill.isRanged())
		{
			this.m.HitChance = 0;

			this.m.IsUpdating = true;
			this.m.HitChance = _skill.getHitchance(this.getContainer().getActor());
			this.m.IsUpdating = false;
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();

		if (!_targetEntity.isAlive() || ::Math.rand(1, 100) > this.m.HitChance || _targetEntity.getMainhandItem() == null)
			return;

		local effect = ::new("scripts/skills/effects/disarmed_effect");
		_targetEntity.getSkills().add(effect);

		if (!this.getContainer().getActor().isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has disarmed " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn(s)");
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.onTargetMissed(_skill, _targetEntity);
	}

	function onMissed( _attacker, _skill )
	{
		if (_skill.isRanged() || !_attacker.isAlive() || ::Math.rand(1, 100) <= this.m.HitChance)
			return;

		local weapon = _attacker.getMainhandItem();
		if (weapon == null)
			return;

		local effect = ::new("scripts/skills/effects/disarmed_effect");
		_attacker.getSkills().add(effect);
		if (!effect.isGarbage()) effect.setTurns(2); // if effect wasn't removed during addition

		if (!this.getContainer().getActor().isHiddenToPlayer() && _attacker.getTile().IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " has disarmed " + ::Const.UI.getColorizedEntityName(_attacker) + " for " + effect.m.TurnsLeft + " turn(s)");
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});
