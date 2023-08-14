::Reforged.HooksMod.hook("scripts/skills/actives/fling_back_skill", function(q) {
	// We delay the onFollow of this skill by another 100ms because otherwise the entity doesn't follow through with this function properly when at very high speeds using some faster combat speed mods
	q.onFollow = @(__original) function( _tag )
	{
		if (::Time.getVirtualSpeed() > 2)
		{
			::Time.scheduleEvent(::TimeUnit.Virtual, 100, __original, _tag);
		}
		else
		{
			__original(_tag);
		}
	}
});
