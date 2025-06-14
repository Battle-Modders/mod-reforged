::Reforged.HooksMod.hook("scripts/states/world/asset_manager", function(q) {
	q.getDailyFoodCost = @(__original) function()
	{
		local cost = __original();
		foreach (follower in ::World.Retinue.m.Followers)
		{
			if (follower.isHired())
			{
				cost += follower.getDailyFood();
			}
		}
		return cost;
	}
	q.getDailyMoneyCost = @(__original) function()
	{
		local cost = __original();
		foreach (follower in ::World.Retinue.m.Followers)
		{
			if (follower.isHired())
			{
				cost += follower.getDailyCost();
			}
		}
		return cost;
	}
})
