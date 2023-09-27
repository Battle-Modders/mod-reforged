::Reforged.HooksMod.hook("scripts/entity/world/attached_location/surface_iron_vein_location", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		switch (_id)
		{
			case "building.weaponsmith":
				if (!this.getSettlement().isSouthern())
				{
					_list.extend([
						{
							R = 70,
							P = 1.0,
							S = "weapons/rf_battle_axe"
						},
					]);
				}
				break;
		}

		return __original(_id, _list);
	}
});
