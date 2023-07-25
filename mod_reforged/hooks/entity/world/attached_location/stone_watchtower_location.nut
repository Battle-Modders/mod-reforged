::mods_hookExactClass("entity/world/attached_location/stone_watchtower_location", function(o) {
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		switch (_id)
		{
			case "building.marketplace":
				if (!this.getSettlement().isSouthern())
				{
					_list.extend([
						{
							R = 50,
							P = 1.0,
							S = "helmets/rf_scale_helmet"
						},
						{
							R = 60,
							P = 1.0,
							S = "helmets/rf_padded_scale_helmet"
						},
						{
							R = 80,
							P = 1.0,
							S = "weapons/rf_reinforced_wooden_poleflail"
						}
					]);
				}
				break;
		}

		return onUpdateShopList(_id, _list);
	}
});
