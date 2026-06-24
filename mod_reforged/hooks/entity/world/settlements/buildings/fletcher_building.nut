::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/fletcher_building", function(q) {
	q.getDefaultShopList = @(__original) { function getDefaultShopList()
	{
		local ret = __original();

		ret.extend([
			{
				R = 10,
				P = 3.0,
				S = "tools/throwing_net"
			},
			{
				R = 20,
				P = 3.0,
				S = "tools/throwing_net"
			}
		]);

		return ret;
	}}.getDefaultShopList;
});
