this.perk_rf_dismantle <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_dismantle";
		this.m.Name = ::Const.Strings.PerkName.RF_Dismantle;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Dismantle;
		this.m.Icon = "ui/perks/rf_dismantle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			return false;
		}

		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getArmor(_bodyPart) == 0 || _targetEntity.isAlliedWith(this.getContainer().getActor()) || !_skill.isAttack() || !this.isEnabled())
		{
			return;
		}

		local effect = _targetEntity.getSkills().getSkillByID("effects.rf_dismantled");
		if (effect == null)
		{
			effect = ::new("scripts/skills/effects/rf_dismantled_effect");
		}

		local countsToAdd = 1;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			countsToAdd += 1;
		}

		if (_bodyPart == ::Const.BodyPart.Body)
		{
			effect.m.BodyHitCount += countsToAdd;
		}
		else
		{
			effect.m.HeadHitCount += countsToAdd;
		}

		_targetEntity.getSkills().add(effect);
	}
});
