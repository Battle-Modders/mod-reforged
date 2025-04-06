::Reforged.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function(q) {
	q.onUpdate = @() function( _properties )
	{
		local hitchanceMult = 1.0 - this.m.Count * 0.1;
		_properties.MeleeSkillMult *= hitchanceMult;
		_properties.RangedSkillMult *= hitchanceMult;
	}

	q.onRefresh = @(__original) function()
	{
		__original();
		this.m.Count = ::Math.min(this.m.Count, 7);
	}
});
