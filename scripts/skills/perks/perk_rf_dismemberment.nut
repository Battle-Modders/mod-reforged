this.perk_rf_dismemberment <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		RequiredWeaponType = ::Const.Items.WeaponType.Axe,
		HPDamageFractionPerMoraleCheck = 0.33,
		MaxMoraleChecks = 3,
		NumInjuriesBefore = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_dismemberment";
		this.m.Name = ::Const.Strings.PerkName.RF_Dismemberment;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Dismemberment;
		this.m.Icon = "ui/perks/perk_rf_dismemberment.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	// Get all the possible injuries, filter out any that are already present on the target or are excluded from the target
	// Then adjust the InjuryThresholdMult so that the highest injury's threshold ends up being that of the lowest possible injury in the original injury pool
	// This ensures that the injury inflicted is always one of the highest possible ones
	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (!this.isSkillValid(_skill))
			return;

		local presentInjuries = _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).map(@(injury) injury.getID());
		this.m.NumInjuriesBefore = presentInjuries.len();

		if (_hitInfo.Injuries == null)
			return;

		local injuries = _hitInfo.Injuries.filter(@(_, injury) _targetEntity.m.ExcludedInjuries.find(injury.ID) == null && presentInjuries.find(injury.ID) == null);
		if (injuries.len() == 0)
			return;

		injuries.sort(@(a, b) a.Threshold <=> b.Threshold);

		local lowestThreshold = _hitInfo.Injuries[0].Threshold;
		local highestThreshold = injuries.top().Threshold;

		if (lowestThreshold < highestThreshold)
		{
			_hitInfo.InjuryThresholdMult *= lowestThreshold / highestThreshold; // Reduce the InjuryThresholdMult so that the threshold of the highest injury behaves the same as that of the lowest injury
			_hitInfo.Injuries = injuries.filter(@(_, injury) injury.Threshold >= highestThreshold);
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.getMoraleState() == ::Const.MoraleState.Ignore || _targetEntity.getMoraleState() == ::Const.MoraleState.Fleeing || !this.isSkillValid(_skill))
			return;

		if (this.m.NumInjuriesBefore >= _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len())
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
			return;

		local count = 0;
		local difficulty = ::Const.Morale.OnHitBaseDifficulty * (1.0 - _targetEntity.getHitpoints() / _targetEntity.getHitpointsMax());
		for (local i = _damageInflictedHitpoints / _targetEntity.getHitpoints(); i >= 0; i -= this.m.HPDamageFractionPerMoraleCheck)
		{
			_targetEntity.checkMorale(-1, difficulty);
			if (++count == this.m.MaxMoraleChecks)
			{
				break;
			}
		}
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
