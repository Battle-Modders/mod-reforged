::mods_hookExactClass("entity/world/attached_location/militia_trainingcamp_location", function(o) {
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
							R = 80,
							P = 1.0,
							S = "weapons/rf_reinforced_wooden_poleflail"
						},
						{
							R = 80,
							P = 1.0,
							S = "weapons/two_handed_wooden_flail"
						}
					]);
				}
				break;
		}

		return onUpdateShopList(_id, _list);
	}
});
