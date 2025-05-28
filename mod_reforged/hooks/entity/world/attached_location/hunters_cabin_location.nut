::Reforged.HooksMod.hook("scripts/entity/world/attached_location/hunters_cabin_location", function(q) {
	q.onUpdateShopList = @(__original) { function onUpdateShopList( _id, _list )
	{
		switch (_id)
		{
			case "building.marketplace":
				{
					_list.extend([
						{
							R = 10,
							P = 2.0,
							S = "tools/throwing_net"
						}
					]);
				}
				break;
		}

		return __original(_id, _list);
	}}.onUpdateShopList;
});
