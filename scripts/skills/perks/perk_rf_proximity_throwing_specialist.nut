this.perk_rf_proximity_throwing_specialist <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_proximity_throwing_specialist";
		this.m.Name = ::Const.Strings.PerkName.RF_ProximityThrowingSpecialist;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ProximityThrowingSpecialist;
		this.m.Icon = "ui/perks/rf_proximity_throwing_specialist.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			return false;
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isRanged() || !_skill.m.IsWeaponSkill || !this.isEnabled())
		{
			return;
		}

		local d = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());

		if (d <= 2)
		{
			_properties.DamageTotalMult *= 1.2;
		}
		else if (d <= 3)
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !_skill.isRanged() || !_skill.m.IsWeaponSkill || !this.isEnabled())
		{
			return;
		}

		local distance = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());
		if (distance > 3)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt))
		{
			local chance = distance == 2 ? 100 : 50;
			local roll = ::Math.rand(1, 100);

			if (roll <= chance)
			{
				local staggeredEffect = _targetEntity.getSkills().getSkillByID("effects.staggered");
				if (staggeredEffect != null && !_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					local effect = ::new("scripts/skills/effects/stunned_effect");
					_targetEntity.getSkills().add(effect);
					effect.m.TurnsLeft = 1;
					if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn");
					}
				}
				else
				{
					local effect = ::new("scripts/skills/effects/staggered_effect");
					_targetEntity.getSkills().add(effect);
					effect.m.TurnsLeft = 1;
					if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has staggered " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn");
					}
				}
			}
		}
		else if (_skill.getDamageType().contains(::Const.Damage.DamageType.Piercing))
		{
			local chance = distance == 2 ? 100 : 50;
			local roll = ::Math.rand(1, 100);

			if (roll <= chance)
			{
				local effect = ::new("scripts/skills/effects/rf_arrow_to_the_knee_debuff_effect");
				_targetEntity.getSkills().add(effect);
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has impaled " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turns");
				}
			}
		}
		else if (_skill.getDamageType().contains(::Const.Damage.DamageType.Cutting))
		{
			local chance = distance == 2 ? 100 : 50;
			local roll = ::Math.rand(1, 100);

			if (roll <= chance)
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/overwhelmed_effect"));
			}
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		if (targetEntity != null)
		{
			if (_skill.isAttack() && _skill.isRanged() && this.isEnabled() && targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) <= 3)
			{
				_tooltip.push({
					icon = "ui/tooltips/positive.png",
					text = this.getName()
				});
			}
		}
	}
});
