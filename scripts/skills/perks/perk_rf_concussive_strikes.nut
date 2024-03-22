this.perk_rf_concussive_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		RequiresWeapon = true,
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

	function isEnabled()
	{
		if (this.m.IsForceEnabled || !this.m.RequiresWeapon)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Mace);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart != ::Const.BodyPart.Head || !_targetEntity.isAlive() || !_skill.isAttack() || (!this.m.RequiresWeapon && !this.isEnabled()) || (!this.m.IsForceEnabled && _skill.getDamageType().contains(::Const.Damage.DamageType.Blunt)))
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (this.m.IsForceTwoHanded || actor.getMainhandItem().isItemType(::Const.Items.ItemType.TwoHanded))
		{
			if (!_targetEntity.getCurrentProperties().IsImmuneToStun)
			{
				if (!_targetEntity.getSkills().hasSkill("effects.stunned"))
				{
					_targetEntity.getSkills().add(::new("scripts/skills/effects/stunned_effect"));

					if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
					}
				}
			}
		}
		else
		{
			if (_targetEntity.getSkills().hasSkill("effects.dazed"))
			{
				if (!_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					if (!_targetEntity.getSkills().hasSkill("effects.stunned"))
					{
						_targetEntity.getSkills().add(::new("scripts/skills/effects/stunned_effect"));

						if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
						{
							::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " has stunned " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
						}
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
});
