::Reforged.HooksMod.hook("scripts/items/shields/named/named_shield", function(q) {
	q.getBaseItemFields = @(__original) function()
	{
		local ret = __original();
		ret.push("ReachIgnore");
		return ret;
	}
});
