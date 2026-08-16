this.rf_assault_hew_skill <- ::inherit("scripts/skills/actives/rf_hew_skill", {
	m = {
		ReachAdd = 0
	},
	function create()
	{
		this.rf_hew_skill.create();
		this.m.ID = "actives.rf_assault_hew";
		// hidden and only used as part of assault
		this.m.IsHidden = true;
		this.m.Name = "Assault Hew";
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.rf_hew_skill.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			// mult for 2nd attack
			_properties.DamageTotalMult *= 0.75;
			_properties.DamageArmorMult *= 1.2;
			_properties.DamageDirectAdd += 0.2;
		}
	}

	function onUse( _user, _targetTile )
	{
		// Consider it as a new skill use because we want this attack to trigger effects/perks
		::Const.SkillCounter++;
		this.rf_hew_skill.onUse(_user, _targetTile)
	}
});
