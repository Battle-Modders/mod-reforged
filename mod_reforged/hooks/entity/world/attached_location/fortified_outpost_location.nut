::Reforged.HooksMod.hook("scripts/entity/world/attached_location/fortified_outpost_location", function(q) {
	q.onUpdateShopList = @(__original) function( _id, _list )
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
							R = 85,
							P = 1.0,
							S = "weapons/rf_battle_axe"
						},
						{
							R = 85,
							P = 1.0,
							S = "weapons/rf_reinforced_wooden_poleflail"
						}
					]);
				}
				break;
		}

		return __original(_id, _list);
	}
});
