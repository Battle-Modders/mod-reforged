::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_throwing", function(q) {
	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !this.isSkillValid(_skill))
			return;

		local distance = _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		if (distance <= 2)
		{
			_properties.DamageTotalMult	*= 1.3;
		}
		else if (distance <= 3)
		{
			_properties.DamageTotalMult	*= 1.2;
		}
	}}.onAnySkillUsed;

	q.onTargetHit = @(__original) { function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		if (!_targetEntity.isAlive() || !this.isSkillValid(_skill))
			return;

		if (!this.getContainer().RF_validateSkillCounter(_targetEntity))
			return;

		local actor = this.getContainer().getActor();

		if (_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt))
		{
			local staggeredEffect = _targetEntity.getSkills().getSkillByID("effects.staggered");
			if (staggeredEffect != null)
			{
				if (_targetEntity.getCurrentProperties().IsImmuneToStun) return;

				local effect = ::new("scripts/skills/effects/stunned_effect");
				_targetEntity.getSkills().add(effect);
				effect.m.TurnsLeft = 1;
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turn");
				}
			}
			else if (::Math.rand(1, 100) <= 50)
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
		else if (_skill.getDamageType().contains(::Const.Damage.DamageType.Piercing))
		{
			if (::Math.rand(1, 100) <= 50)
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
			_targetEntity.getSkills().add(::new("scripts/skills/effects/overwhelmed_effect"));
		}
	}}.onTargetHit;

	q.isSkillValid <- { function isSkillValid( _skill )
	{
		if (!_skill.isRanged() || !_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Throwing);
	}}.isSkillValid;
});
