::mods_hookExactClass("entity/world/settlements/buildings/fletcher_building", function(o) {
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _list )
	{
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
				},
				{
					R = 20,
					P = 1.0,
					S = "tools/throwing_net"
				}
			]);
		}

		return onUpdateShopList(_id, _list);
	}
});
