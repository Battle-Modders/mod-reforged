::mods_hookExactClass("entity/world/attached_location/ore_smelters_location", function(o) {
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		switch (_id)
		{
			case "building.weaponsmith":
				if (!this.getSettlement().isSouthern())
				{
					_list.extend([
						{
							R = 40,
							P = 1.0,
							S = "weapons/rf_battle_axe"
						},
						{
							R = 40,
							P = 1.0,
							S = "weapons/rf_greatsword"
						},
						{
							R = 40,
							P = 1.0,
							S = "weapons/rf_kriegsmesser"
						},
						{
							R = 50,
							P = 1.0,
							S = "weapons/rf_swordstaff"
						}
					]);
				}
				break;
		}

		return onUpdateShopList(_id, _list);
	}
});
