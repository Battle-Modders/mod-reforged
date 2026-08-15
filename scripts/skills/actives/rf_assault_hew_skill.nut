this.rf_assault_hew_skill <- ::inherit("scripts/skills/actives/rf_hew_skill", {
	function create()
	{
		this.m.ID = "actives.rf_assault_hew";
		// hidden and only used as part of assault
		this.m.IsHidden = true;
		this.m.ActionPointCost = 999;
	}
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.chop.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.Reach += this.m.ReachAdd;
		}

		// mult for 2nd attack
		_properties.DamageTotalMult *= 0.75;
		_properties.DamageArmorMult *= 1.2;
		_properties.DamageDirectAdd += 0.2;
	}
});
