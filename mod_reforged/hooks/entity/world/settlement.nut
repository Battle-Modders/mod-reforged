::mods_hookExactClass("entity/world/settlement", function(o) {
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		switch (_id)
		{
			case "building.marketplace":
				_list.extend([
					{
						R = 90,
						P = 1.0,
						S = "weapons/rf_reinforced_wooden_poleflail"
					}
				]);
				break;

			case "building.weaponsmith":
				_list.extend([
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_battle_axe"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_estoc"
					},
					{
						R = 60,
						P = 1.0,
						S = "weapons/rf_kriegsmesser"
					},
					{
						R = 60,
						P = 1.0,
						S = "weapons/rf_greatsword"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_poleflail"
					},
					{
						R = 70,
						P = 1.0,
						S = "weapons/rf_reinforced_wooden_poleflail"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_swordstaff"
					}
				]);
				break;

			case "building.weaponsmith_oriental":
				_list.extend([
					{
						R = 85,
						P = 1.0,
						S = "weapons/rf_battle_axe"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_estoc"
					},
					{
						R = 85,
						P = 1.0,
						S = "weapons/rf_greatsword"
					},
					{
						R = 90,
						P = 1.0,
						S = "weapons/rf_reinforced_wooden_poleflail"
					},
					{
						R = 80,
						P = 1.0,
						S = "weapons/rf_swordstaff"
					}
				]);
				break;

			case "building.fletcher":
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
				break;
		}

		return onUpdateShopList(_id, _list);
	}
});
