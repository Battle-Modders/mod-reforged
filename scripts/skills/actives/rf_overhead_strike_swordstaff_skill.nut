this.rf_overhead_strike_swordstaff_skill <- ::inherit("scripts/skills/actives/overhead_strike", {
	m = {
		ReachAdd = -1
	},
	function create()
	{
		this.overhead_strike.create();
		this.m.IsIgnoredAsAOO = true;
	}

	function getTooltip()
	{
		local ret = this.overhead_strike.getTooltip();

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
		this.overhead_strike.onAnySkillUsed(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.Reach += this.m.ReachAdd;
		}
	}
});
