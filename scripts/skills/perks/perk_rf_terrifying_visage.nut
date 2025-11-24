this.perk_rf_terrifying_visage <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_terrifying_visage";
		this.m.Name = ::Const.Strings.PerkName.RF_TerrifyingVisage;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TerrifyingVisage;
		this.m.Icon = "ui/perks/perk_rf_terrifying_visage.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.getMoraleState() == ::Const.MoraleState.Ignore || _damageInflictedHitpoints < 1 || !_targetEntity.getCurrentProperties().IsAffectedByLosingHitpoints)
		{
			return;
		}

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
			return;

		this.spawnIcon("perk_rf_terrifying_visage", _targetEntity.getTile());
		if (_targetEntity.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack))
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/horrified_effect"));

			if (!this.getContainer().getActor().isHiddenToPlayer() && !_targetEntity.isHiddenToPlayer())
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is horrified");
			}
		}
	}
});
