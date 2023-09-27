::Reforged.HooksMod.hook("scripts/skills/actives/coat_with_poison_skill", function(q) {
	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		if (::Time.getRound() == 1) this.m.ActionPointCost = 0;
	}
});
