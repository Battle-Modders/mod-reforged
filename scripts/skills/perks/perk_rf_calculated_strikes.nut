this.perk_rf_calculated_strikes <- this.inherit("scripts/skills/skill", {
	m = {
		DamageMult = 1.2,
		InitiativeMult = 0.8
	},
	function create()
	{
		this.m.ID = "perk.rf_calculated_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_CalculatedStrikes;
		this.m.Description = ::Const.Strings.PerkDescription.RF_CalculatedStrikes;
		// this.m.Icon = "ui/perks/rf_calculated_strikes.png";	// TODO: add this icon
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= this.m.InitiativeMult;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this) return;

		if (this.isEnabledFor(_targetEntity))
		{
			_properties.DamageTotalMult *= this.m.DamageMult;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_targetTile.getEntity() != null && this.isEnabledFor(_targetTile.getEntity()))
		{
			_tooltip.push({
				icon = "ui/icons/damage_dealt.png",
				text = ::MSU.Text.colorizeMult(this.m.DamageMult) + " increased damage (" + this.getName() + ")"
			});
		}
	}

// New Functions
	function isEnabledFor( _targetEntity )
	{
		return (!_targetEntity.isTurnStarted() && !_targetEntity.isTurnDone());	// This is the same condition as vanilla overwhelm has
	}
});

