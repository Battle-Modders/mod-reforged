this.perk_rf_pattern_recognition <- ::inherit("scripts/skills/skill", {
	m = {
		Opponents = {}
	},
	function create()
	{
		this.m.ID = "perk.rf_pattern_recognition";
		this.m.Name = ::Const.Strings.PerkName.RF_PatternRecognition;
		this.m.Description = "This character is quick to understand the fighting style of opponents, getting better at fighting them as the combat draws on.";
		this.m.Icon = "ui/perks/rf_pattern_recognition.png";
		this.m.IconMini = "rf_pattern_recognition_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Opponents.len() == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push(
			{
				id = 10,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "Increased Melee Skill and Melee Defense"
			}
		);		

		foreach (opponentID, stacks in this.m.Opponents)
		{
			local opponent = ::Tactical.getEntityByID(opponentID);
			if (opponent == null || !opponent.isPlacedOnMap() || !opponent.isAlive() || opponent.isDying())
			{
				continue;
			}

			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.getBonus(opponentID) + "[/color] against " + opponent.getName()
			});
		}

		return tooltip;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		if (skill.isRanged() || targetEntity == null) return;

		if (targetEntity.getID() in this.m.Opponents)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + this.getBonus(targetEntity.getID()) + "%[/color] " + this.getName()
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (_skill.isRanged()) return;

		local user = _skill.getContainer().getActor();
		if (user.getID() in this.m.Opponents)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorRed(this.getBonus(user.getID()) + "% ") + this.getName()
			});
		}
	}

	function getBonus( _opponentID )
	{
		local bonus = 0;
		for (local i = 1; i <= this.m.Opponents[_opponentID]; i++)
		{
			bonus += bonus >= 10 ? 1 : i;
		}
		return bonus;
	}

	function procIfApplicable(_entity, _skill)
	{
		if (this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing || _skill == null || !_skill.isAttack() || _skill.isRanged() || _entity == null || _entity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		if (_entity.getID() in this.m.Opponents)
		{
			this.m.Opponents[_entity.getID()] += 1;
		}
		else
		{
			this.m.Opponents[_entity.getID()] <- 1;
		}
	}

	function onMissed( _attacker, _skill )
	{
		this.procIfApplicable(_attacker, _skill);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.procIfApplicable(_attacker, _skill);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && !_targetEntity.isDying())
		{
			this.procIfApplicable(_targetEntity, _skill);
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.procIfApplicable(_targetEntity, _skill);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && (_targetEntity.getID() in this.m.Opponents) && !_skill.isRanged() && _skill.isAttack())
		{
			_properties.MeleeSkill += this.getBonus(_targetEntity.getID());
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_attacker != null && (_attacker.getID() in this.m.Opponents) && _skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			_properties.MeleeDefense += this.getBonus(_attacker.getID());
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Opponents.clear();
	}
});
