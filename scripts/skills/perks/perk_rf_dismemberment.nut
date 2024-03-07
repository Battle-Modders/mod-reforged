this.perk_rf_dismemberment <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		NumInjuriesBefore = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_dismemberment";
		this.m.Name = ::Const.Strings.PerkName.RF_Dismemberment;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Dismemberment;
		this.m.Icon = "ui/perks/rf_dismemberment.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Axe);
	}

	// Get all the possible injuries, filter out any that are below the highest threshold
	// Then adjust the InjuryThresholdMult so that the highest injury's threshold ends up being that of the lowest one
	// This ensures that the injury inflicted is always one of the highest possible ones
	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (!this.isEnabled())
			return;

		this.m.NumInjuriesBefore = _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len();

		local injuries = _hitInfo.Injuries.filter(@(_, injury) _targetEntity.m.ExcludedInjuries.find(injury.ID) == null && !_targetEntity.getSkills().hasSkill(injury.ID));
		if (injuries.len() == 0)
			return;

		injuries.sort(@(a, b) a.Threshold <=> b.Threshold);

		local highest = injuries.top().Threshold;

		_hitInfo.InjuryThresholdMult *= injuries[0].Threshold / highest; // Reduce the InjuryThresholdMult so that the threshold of the highest injury behaves the same as that of the lowest injury

		_hitInfo.Injuries = injuries.filter(@(_, injury) injury.Threshold < highest);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.getMoraleState() == ::Const.MoraleState.Ignore || _targetEntity.getMoraleState() == ::Const.MoraleState.Fleeing || !this.isEnabled())
			return;

		if (this.m.NumInjuriesBefore == _targetEntity.getSkills().getAllSkillsOfType(::Const.SkillType.TemporaryInjury).len())
			return;

		for (local i = this.getContainer().getActor().getCurrentProperties().getBravery(); i >= 0; i-=25)
		{
			_targetEntity.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - _targetEntity.getHitpoints() / _targetEntity.getHitpointsMax()));
		}
	}
});
