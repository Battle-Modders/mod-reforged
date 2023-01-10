this.perk_rf_dent_armor <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsForceTwoHanded = false,
		ChanceOneHanded = 33,
		ChanceTwoHanded = 66
	},
	function create()
	{
		this.m.ID = "perk.rf_dent_armor";
		this.m.Name = ::Const.Strings.PerkName.RF_DentArmor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DentArmor;
		this.m.Icon = "ui/perks/rf_dent_armor.png";
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

		local weapon = this.getContainer().getActor().getMainhandItem();
		if(weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			return false;
		}

		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (!_skill.isAttack() || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor) ||
			(!_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt) && !this.m.IsForceEnabled) ||
			!this.isEnabled())
		{
			return;
		}

		local targetArmorItem = _bodyPart == ::Const.BodyPart.Head ? _targetEntity.getHeadItem() : _targetEntity.getBodyItem();
		if (targetArmorItem == null || targetArmorItem.getArmorMax() <= 200)
		{
			return;
		}

		local weapon = actor.getMainhandItem();
		local isTwoHanded = this.m.IsForceTwoHanded || (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded));

		local roll = ::Math.rand(1, 100);
		if (roll <= this.m.ChanceOneHanded || (isTwoHanded && roll <= this.m.ChanceTwoHanded))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_dented_armor_effect"));
		}
	}
});
