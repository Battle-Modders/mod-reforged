::mods_hookExactClass("entity/world/settlement", function(o) {
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		switch (_id)
		{
			case "building.weaponsmith":
				_list.extend([
					{
						R = 50,
						P = 1.0,
						S = "weapons/rf_greatsword"
					},
					{
						R = 50,
						P = 1.0,
						S = "weapons/rf_estoc"
					},
				])
				break;

			case "building.armorsmith":
				// so on
				break;
		}

		return onUpdateShopList(_id, _list);
	}
});
