::Reforged.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function(q) {
	q.onUpdate = @() function( _properties )
	{
		_properties.MeleeSkillMult = ::Math.maxf(0.0, _properties.MeleeSkillMult - 0.1 * this.m.Count);
		_properties.RangedSkillMult = ::Math.maxf(0.0, _properties.RangedSkillMult - 0.1 * this.m.Count);
	}

	q.onRefresh = @(__original) function()
	{
		__original();
		this.m.Count = ::Math.min(this.m.Count, 7);
	}
});
