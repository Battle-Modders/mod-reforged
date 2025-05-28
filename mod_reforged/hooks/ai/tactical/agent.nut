::Reforged.HooksMod.hook("scripts/ai/tactical/agent", function(q) {
	q.addBehavior = @(__original) { function addBehavior( _behavior )
	{
		local obj = this;
		while ("SuperName" in obj)
		{
			if ((obj.ClassName in ::Reforged.AI.ExcludedBehaviors) && ::Reforged.AI.ExcludedBehaviors[obj.ClassName].find(_behavior.getID()) != null)
			{
				return;
			}
			obj = obj[obj.SuperName];
		}

		return __original(_behavior);
	}}.addBehavior;
});
