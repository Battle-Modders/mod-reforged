this.rf_hew_skill <- ::inherit("scripts/skills/actives/chop", {
	m = {
		ReachAdd = -1
	},
	function create()
	{
		this.chop.create();
		// We keep the ID the same as chop as this
		// skill is basically the same thing.

		this.m.Name = "Hew";
		this.m.Icon = "skills/rf_poleaxe_hew_skill.png";
		this.m.IconDisabled = "skills/rf_poleaxe_hew_skill_sw.png";
		this.m.Overlay = "rf_poleaxe_hew_skill";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
	}

	function getTooltip()
	{
		local ret = this.chop.getTooltip();

		if (this.m.ReachAdd != 0)
		{
			ret.push({
				id = 10, type = "text", icon = "ui/icons/rf_reach.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Has %s [Reach|Concept.Reach]", ::MSU.Text.colorizeValue(this.m.ReachAdd, {AddSign = true})))
			});
		}

		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.chop.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.Reach += this.m.ReachAdd;
		}
	}
});
