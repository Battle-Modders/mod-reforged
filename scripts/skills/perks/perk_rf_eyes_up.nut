this.perk_rf_eyes_up <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		TargetEntity = null,
		TargetTile = null
	},
	function create()
	{
		this.m.ID = "perk.rf_eyes_up";
		this.m.Name = ::Const.Strings.PerkName.RF_EyesUp;
		this.m.Description = ::Const.Strings.PerkDescription.RF_EyesUp;
		this.m.Icon = "ui/perks/rf_eyes_up.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			return false;
		}

		return true;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && this.isEnabled() && (_skill.isRanged() || this.m.IsForceEnabled))
		{
			this.m.TargetEntity = _targetEntity;
			this.m.TargetTile = _targetTile;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.applyEffect();
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.applyEffect();
	}

	function applyEffect()
	{
		if (this.m.TargetEntity == null) return;

		if (this.m.TargetEntity.isAlive() && !this.m.TargetEntity.isDying())
		{
			local effect = ::new("scripts/skills/effects/rf_eyes_up_effect");
			if (this.m.TargetEntity.isArmedWithShield() && this.m.TargetEntity.getOffhandItem().getID().find("buckler") == null)
			{
				effect.m.Stacks -= 0.5;
			}
			this.m.TargetEntity.getSkills().add(effect);
		}

		for (local i = 0; i < 6; i++)
		{
			if (this.m.TargetTile.hasNextTile(i))
			{
				local nextTile = this.m.TargetTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local nextActor = nextTile.getEntity();
					if (nextActor.isAlliedWith(this.getContainer().getActor()) || (nextActor.isArmedWithShield() && nextActor.getOffhandItem().getID().find("buckler") == null))
					{
						continue;
					}

					local effect = ::new("scripts/skills/effects/rf_eyes_up_effect");
					local previouslyAppliedEffect = nextTile.getEntity().getSkills().getSkillByID("effects.rf_eyes_up");
					if (previouslyAppliedEffect != null)
					{
						previouslyAppliedEffect.m.Stacks -= 0.5;
					}
					else
					{
						effect.m.Stacks -= 0.5;
					}
					nextTile.getEntity().getSkills().add(effect);
				}
			}
		}

		this.m.TargetEntity = null;
		this.m.TargetTile = null;
	}
});
