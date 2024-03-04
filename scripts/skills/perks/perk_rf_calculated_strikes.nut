this.perk_rf_calculated_strikes <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_calculated_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_CalculatedStrikes;
		this.m.Description = ::Const.Strings.PerkDescription.RF_CalculatedStrikes;
		this.m.Icon = "ui/perks/rf_calculated_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 0.8;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && !_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone())
		{
			_properties.DamageTotalMult *= 1.2;
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.isAttack() && _targetEntity != null && !_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone())
		{
			this.spawnIcon("perk_rf_calculated_strikes", this.getContainer().getActor().getTile());
		}
	}
});
