this.perk_rf_iron_sights <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 25
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

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isItemType(::Const.Items.ItemType.RangedWeapon) && (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm));
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
			_properties.HitChance[::Const.BodyPart.Head] += this.m.Bonus;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _bodyPart != ::Const.BodyPart.Head || _targetEntity.getMoraleState() == ::Const.MoraleState.Ignore || !_skill.isRanged() || !_skill.isAttack() || !this.isEnabled())
			return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/shellshocked_effect"));
		}
	}
});
