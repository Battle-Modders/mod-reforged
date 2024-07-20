this.perk_rf_calculated_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		DamageTotalMult = 1.2,
		InitiativeMult = 0.8
	},
	function create()
	{
		this.m.ID = "perk.rf_calculated_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_CalculatedStrikes;
		this.m.Description = ::Const.Strings.PerkDescription.RF_CalculatedStrikes;
		this.m.Icon = "ui/perks/rf_calculated_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= this.m.InitiativeMult;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && this.isEnabledFor(_targetEntity))
		{
			_properties.DamageTotalMult *= this.m.DamageTotalMult;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_targetTile.IsOccupiedByActor && this.isEnabledFor(_targetTile.getEntity()))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

// New Functions
	function isEnabledFor( _targetEntity )
	{
		return !_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone();	// This is the same condition as vanilla overwhelm has
	}
});

