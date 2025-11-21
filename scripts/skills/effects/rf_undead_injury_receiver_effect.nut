this.rf_undead_injury_receiver_effect <- ::inherit("scripts/skills/skill", {
	m = {
		ThresholdToReceiveInjuryMult = 1.33
	},
	function create()
	{
		this.m.ID = "effects.rf_undead_injury_receiver";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= this.m.ThresholdToReceiveInjuryMult;
		_properties.IsAffectedByInjuries = true;
		_properties.IsAffectedByFreshInjuries = true;
	}
});
