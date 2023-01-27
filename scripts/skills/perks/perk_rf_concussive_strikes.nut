this.perk_rf_concussive_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsForceMace = false,
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
		if (this.m.IsForceEnabled) return true;

		if (this.getContainer().getActor().isDisarmed() || this.getContainer().getActor().getMainhandItem() == null) return false;

		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart != ::Const.BodyPart.Head || !_skill.isAttack() || (!this.m.IsForceEnabled && !_skill.m.IsWeaponSkill) || !_targetEntity.isAlive() || _targetEntity.isDying() || !this.isEnabled())
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		local isMace = this.m.IsForceMace || (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Mace));

		if (isMace && (this.m.IsForceEnabled || _skill.getDamageType().contains(::Const.Damage.DamageType.Blunt)))
		{
			if (this.m.IsForceTwoHanded || (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded)))
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
				effect.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
				if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " dazed for " + effect.m.TurnsLeft + " turns");
				}
			}
		}
		else if (!_targetEntity.getCurrentProperties().IsImmuneToDaze)
		{
			local effect = ::new("scripts/skills/effects/dazed_effect");
			_targetEntity.getSkills().add(effect);
			effect.m.TurnsLeft = ::Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(_targetEntity) + " dazed for " + effect.m.TurnsLeft + " turns");
			}
		}
	}
});
