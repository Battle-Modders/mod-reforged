::Reforged.HooksMod.hook("scripts/entity/world/attached_location/ore_smelters_location", function(q) {
	q.onUpdateShopList = @(__original) { function onUpdateShopList( _id, _list )
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
						},
						{
							R = 50,
							P = 1.0,
							S = "weapons/rf_voulge"
						},
						{
							R = 50,
							P = 1.0,
							S = "weapons/rf_halberd"
						},
						{
							R = 50,
							P = 1.0,
							S = "weapons/rf_poleaxe"
						}
					]);
				}
				break;
		}

		return __original(_id, _list);
	}}.onUpdateShopList;
});
