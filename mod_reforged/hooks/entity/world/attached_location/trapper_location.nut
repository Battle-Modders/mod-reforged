::mods_hookExactClass("entity/world/attached_location/trapper_location", function(o) {
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		switch (_id)
		{
			case "building.marketplace":
				{
					_list.extend([
						{
							R = 10,
							P = 1.0,
							S = "tools/throwing_net"
						},
						{
							R = 20,
							P = 1.0,
							S = "tools/throwing_net"
						}
					]);
				}
				break;
		}

		return onUpdateShopList(_id, _list);
	}
});
