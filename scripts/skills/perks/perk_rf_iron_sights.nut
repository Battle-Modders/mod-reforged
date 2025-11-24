this.perk_rf_iron_sights <- ::inherit("scripts/skills/skill", {
	m = {
		ChanceToHitHeadAdd = 25
	},
	function create()
	{
		this.m.ID = "perk.rf_iron_sights";
		this.m.Name = ::Const.Strings.PerkName.RF_IronSights;
		this.m.Description = ::Const.Strings.PerkDescription.RF_IronSights;
		this.m.Icon = "ui/perks/perk_rf_iron_sights.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.isSkillValid(_skill))
			_properties.HitChance[::Const.BodyPart.Head] += this.m.ChanceToHitHeadAdd;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _bodyPart != ::Const.BodyPart.Head || _targetEntity.getMoraleState() == ::Const.MoraleState.Ignore || !this.isSkillValid(_skill))
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
			return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/shellshocked_effect"));
		}
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isRanged() || !_skill.isAttack())
			return;

		local weapon = _skill.getItem();
		return ::MSU.isKindOf(weapon, "weapon") && (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm));
	}
});
