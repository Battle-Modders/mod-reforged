this.rf_assault_hew_skill <- ::inherit("scripts/skills/actives/chop", {
	function create()
	{
		this.chop.create();
		this.m.ID = "actives.rf_assault_hew";
		// hidden and only used as part of assault
		this.m.IsHidden = true;
		this.m.Name = "Hew";
		this.m.Icon = "skills/rf_poleaxe_hew_skill.png";
		this.m.IconDisabled = "skills/rf_poleaxe_hew_skill_sw.png";
		this.m.Overlay = "rf_poleaxe_hew_skill";
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.DirectDamageMult = 0.4;
	}
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.chop.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.Reach += this.m.ReachAdd;
			// mult for 2nd attack
			_properties.DamageTotalMult *= 0.75;
			_properties.DamageArmorMult *= 1.2;
			_properties.DamageDirectAdd += 0.2;
		}
	}
});
