this.rf_line_breaker_onslaught_skill <- ::inherit("scripts/skills/actives/rf_line_breaker_skill", {
	m = {},
	function create()
	{
		this.rf_line_breaker_skill.create();
		this.m.ID = "actives.rf_line_breaker_onslaught";
		this.m.Name = "Line Breaker (Onslaught)";
		this.m.ActionPointCost -= 1;
		this.m.FatigueCost -= 10;
		this.m.IsRemovedAfterBattle = true;

		this.m.RequiresShield = false; // This is a field from the m table of the base rf_line_breaker_skill
	}

	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill == this)
		{
			this.removeSelf();
		}
	}
});
