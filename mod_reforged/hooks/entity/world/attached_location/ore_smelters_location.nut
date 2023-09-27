::Reforged.HooksMod.hook("scripts/entity/world/attached_location/ore_smelters_location", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
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

		return __original(_id, _list);
	}
});
