this.rf_voulge_cleave_skill <- ::inherit("scripts/skills/actives/cleave", {
	m = {},
	function create()
	{
		this.cleave.create();
		this.m.ID = "actives.rf_voulge_cleave";
		this.m.Icon = "skills/rf_voulge_cleave_skill.png";
		this.m.IconDisabled = "skills/rf_voulge_cleave_skill_sw.png";
		this.m.Overlay = "rf_voulge_cleave_skill";
		this.m.MaxRange = 2;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.DirectDamageMult = 0.3;
		this.m.IsTooCloseShown = true;
	}

	function getTooltip()
	{
		local ret = this.cleave.getTooltip();

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorNegative("-15%") + " chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.cleave.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill != this || _targetEntity == null)
			return;

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
		{
			_properties.MeleeSkill += -15;
			this.m.HitChanceBonus = -15;
		}
		else
		{
			this.resetField("HitChanceBonus");
		}
	}
});
