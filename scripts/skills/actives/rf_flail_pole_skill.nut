this.rf_flail_pole_skill <- ::inherit("scripts/skills/actives/flail_skill", {
	m = {},
	function create()
	{
		this.flail_skill.create();
		this.m.ID = "actives.rf_flail_pole";
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 15;
		this.m.MaxRange = 2;
		this.m.IsTooCloseShown = true;
	}

	function getTooltip()
	{
		local ret = this.flail_skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorPositive(this.getMaxRange()) + " tiles"
		});

		return ret;
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
