this.perk_rf_concussive_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Mace,
		RequiredDamageType = ::Const.Damage.DamageType.Blunt,
		IsForceTwoHanded = false
	},
	function create()
	{
		this.m.ID = "perk.rf_concussive_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_ConcussiveStrikes;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ConcussiveStrikes;
		this.m.Icon = "ui/perks/rf_concussive_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart != ::Const.BodyPart.Head || !_targetEntity.isAlive() || !this.isSkillValid(_skill))
			return;

		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		local isTwoHanded = this.m.IsForceTwoHanded || (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded));

		if (isTwoHanded)
		{
			if (!_targetEntity.getCurrentProperties().IsImmuneToStun && !_targetEntity.getSkills().hasSkill("effects.stunned"))
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/stunned_effect"));

				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
				}
			}
		}
		else
		{
			if (_targetEntity.getSkills().hasSkill("effects.dazed"))
			{
				if (!_targetEntity.getCurrentProperties().IsImmuneToStun && !_targetEntity.getSkills().hasSkill("effects.stunned"))
				{
					_targetEntity.getSkills().add(::new("scripts/skills/effects/stunned_effect"));

					if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
					}
				}
			}
			else if (!_targetEntity.getCurrentProperties().IsImmuneToDaze)
			{
				local effect = ::new("scripts/skills/effects/dazed_effect");
				_targetEntity.getSkills().add(effect);
				effect.setTurns(1);
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " dazed for " + effect.m.TurnsLeft + " turns");
				}
			}
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt)))
			return false;

		if (!this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
