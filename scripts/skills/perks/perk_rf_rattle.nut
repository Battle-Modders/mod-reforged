this.perk_rf_rattle <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_rattle";
		this.m.Name = ::Const.Strings.PerkName.RF_Rattle;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Rattle;
		this.m.Icon = "ui/perks/rf_rattle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getCurrentProperties().IsImmuneToStun || _targetEntity.getCurrentProperties().IsImmuneToDaze ||
			!_skill.isAttack() || !_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt) || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (_damageInflictedHitpoints >= 10 || (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Mace)))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_rattled_effect"));
		}
	}
});

