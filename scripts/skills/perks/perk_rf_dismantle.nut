this.perk_rf_dismantle <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		RequiresWeapon = true
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
		if (this.m.IsForceEnabled || !this.m.RequiresWeapon)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Hammer);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _damageInflictedArmor == 0 || _targetEntity.getArmor(_bodyPart) == 0 || !_skill.isAttack() || !this.isEnabled() || !this.validateDamageType(_skill) || !this.validateWeaponRequirement(_skill))
			return;

		local armorPiece = _bodyPart == ::Const.BodyPart.Head ? _targetEntity.getHeadItem() : _targetEntity.getBodyItem();
		if (armorPiece == null)
			return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.rf_dismantled");
		if (effect == null)
		{
			effect = ::new("scripts/skills/effects/rf_dismantled_effect");
		}

		local count = this.getContainer().getActor().getMainhandItem().isItemType(::Const.Items.ItemType.TwoHanded) ? 2 : 1;

		if (_bodyPart == ::Const.BodyPart.Body)
		{
			effect.m.BodyHitCount += count;
		}
		else
		{
			effect.m.HeadHitCount += count;
		}

		_targetEntity.getSkills().add(effect);
	}

	function validateDamageType( _skill )
	{
		return this.m.IsForceEnabled || _skill.getDamageType().contains(::Const.Damage.DamageType.Blunt);
	}

	function validateWeaponRequirement( _skill )
	{
		return _skill.m.IsWeaponSkill || !this.m.RequiresWeapon || this.m.IsForceEnabled;
	}
});
