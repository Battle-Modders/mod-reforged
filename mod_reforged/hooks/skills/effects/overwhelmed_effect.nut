::Reforged.HooksMod.hook("scripts/skills/effects/overwhelmed_effect", function(q) {
	q.onUpdate = @() { function onUpdate( _properties )
	{
		local hitchanceMult = 1.0 - this.m.Count * 0.1;
		_properties.MeleeSkillMult *= hitchanceMult;
		_properties.RangedSkillMult *= hitchanceMult;
	}}.onUpdate;

	q.onRefresh = @(__original) { function onRefresh()
	{
		__original();
		this.m.Count = ::Math.min(this.m.Count, 7);
	}}.onRefresh;
});
