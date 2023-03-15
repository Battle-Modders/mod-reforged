this.rf_flail_pole_skill <- ::inherit("scripts/skills/actives/flail_skill", {
	m = {},
	function create()
	{
		this.flail_skill.create();
		this.m.ID = "actives.rf_flail_pole";
		this.m.FatigueCost = 15;
		this.m.MaxRange = 2;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.flail_skill.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
		}
	}
});

